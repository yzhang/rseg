$KCODE = 'UTF8'

def process(path, tree)
  File.open(path, 'r') do |file|
    file.each_line do |line|
      node = nil
      line.chars.each do |c|
        next if c == "\n" || c == "\r"
        if node
          node[c] ||= {}
          node = node[c]
        else
          tree[c] ||= Hash.new
          node = tree[c]
        end
      end
      node[:end] = true
    end
  end
end

def build
  tree = {}
  dictionaries = ['cedict.zh_CN.utf8', 'wikipedia.zh.utf8']
  
  dictionaries.each do |dictionary|
    puts "Processing #{dictionary}..."
    path = File.join(File.dirname(__FILE__), '../../dict', dictionary)
    process(path, tree)
  end
  
  File.open(hash_path, "wb") {|io| Marshal.dump(tree, io)}  
  puts 'Done'
end

def hash_path
  File.join(File.dirname(__FILE__), '../../dict/dict.hash')
end

build

