module RsegEngine
  class Dict < Engine
    @@root      = nil
    @@dict_path = File.join(File.dirname(__FILE__), '../../dict/dict.hash')

    class << self
      def dict_path=(path)
        @@dict_path = path
      end
    
      def dict_path
        @@dict_path
      end
    end
  
    def initialize
      @@root ||= load_dict(@@dict_path)
      @word = ''
      @node = @@root
      super
    end
  
    def process(char)
      match = false
      word = nil
    
      if @node[char]
        @word << char
        @node = @node[char]
        match = true
      else
        if @node[:end] || @word.chars.to_a.length == 1
          word = @word
        else
          word = @word.chars.to_a
        end
      
        @node = @@root
        @word = ''
        match = false
      end
    
      [match, word]
    end
  
    private
    def load_dict(path)
      force_utf8 = Proc.new {|v| v.is_a?(String) ? v.force_encoding('utf-8') : v} # fix encoding for ruby version >= 1.9
      File.open(path, "rb") {|io| Marshal.load(io, force_utf8)}
    end
  end
end