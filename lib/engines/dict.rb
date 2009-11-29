class Dict < Engine
  @@root = nil
  
  def initialize
    @@root ||= load_dict(dict_path)
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
    File.open(path, "rb") {|io| Marshal.load(io)}
  end
  
  def dict_path
    File.join(File.dirname(__FILE__), '../../dict/dict.hash')
  end
end