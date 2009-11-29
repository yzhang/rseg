$KCODE = 'UTF8'

require File.join(File.dirname(__FILE__), 'engines/engine')
require File.join(File.dirname(__FILE__), 'engines/dict')
require File.join(File.dirname(__FILE__), 'engines/english')
require File.join(File.dirname(__FILE__), 'engines/number')
require File.join(File.dirname(__FILE__), 'engines/name')

require File.join(File.dirname(__FILE__), 'filters/fullwidth')
require File.join(File.dirname(__FILE__), 'filters/symbol')
require File.join(File.dirname(__FILE__), 'filters/conjunction')

class Rseg
  @@engines = nil
  @@segment = nil
  @@filters = nil
  
  class << self
    def segment(input)
      @@segment ||= Rseg.new(input)
      @@segment.segment
    end
  end
  
  def initialize(input)
    @input = input
    @words = []
    init_engines
    init_filters
  end
  
  def segment
    @words.clear
    
    @input.chars.each do |origin|
      char = filter(origin)
      process(char, origin)
    end
    
    process(:symbol, '')
    @words
  end

  private
  def filter(char)
    result = char
    @@filters.each do |klass|
      result = klass.filter(result)
    end
    result
  end
  
  def process(char, origin)
    nomatch = true
    word = ''
    
    engines.each do |engine|
      next unless engine.running?
      match, word = engine.process(char)
      match ? nomatch = false : engine.stop
    end
    
    if nomatch
      if word == ''
        @words << origin unless char == :symbol
        reset_engines
      else
        reset_engines
        @words << word if word.is_a?(String)
        reprocess(word) if word.is_a?(Array)

        # re-process current char
        process(char, origin)
      end
    end
  end
  
  def reprocess(word)
    last = word.pop

    word.each do |char|
      process(char, char)
    end
    
    process(:symbol, :symbol)
    process(last, last)
  end

  def reset_engines
    engines.each do |engine|
      engine.run
    end
  end
  
  def engines=(engines)
    @@engines ||= engines
  end

  def engines
    @@engines
  end

  def init_filters
    @@filters = [Fullwidth, Symbol]
  end
  
  def init_engines
    @@engines ||= [Dict, English, Number, Name].map do |engine_klass|
      engine_klass.new
    end
  end
end