require_relative 'letter_node.rb'

class DictionaryTree
#LetterNode = Struct.new(:letter, :definition, :children, :parent, :depth)
attr_reader :root, :num_letters, :num_words, :depth

  def initialize(entries=[])
    @root = LetterNode.new(nil, nil, [], nil, 0)
    @num_letters = 0
    @num_words = 0
    @depth = 0
    entries.each do |entry|
      insert_word(entry[0], entry[1])
    end
  end

  def insert_word(word, definition)
    current_node = @root
    depth = 0
    word.chars.each do |letter|
      child = current_node.children.select { |n| n.letter == letter }
      if child == []
        current_node.children << LetterNode.new(letter, nil, [], current_node, current_node.depth + 1)
        @num_letters += 1
        current_node = current_node.children.last
      else
        current_node = child[0]
      end
    end
    @depth = current_node.depth if current_node.depth > @depth
    current_node.definition = definition
    @num_words += 1
  end

  def definition_of(word)
    current_node = @root
    word.chars.each do |letter|
      child = current_node.children.select { |n| n.letter == letter }
      if child != []
        current_node = child[0]
      else
        return nil
      end
    end
    return current_node.definition
  end

  def remove_word(word)
    current_node = @root
    word.chars.each do |letter|
      child = current_node.children.select { |n| n.letter == letter }
      current_node = child[0] if child != []
    end
    if current_node.definition
      current_node.definition = nil
      @num_words -= 1
      if current_node.children.empty?
        until current_node.parent == @root || current_node.parent.children.length > 1 || current_node.parent.definition != nil
          current_node = current_node.parent
          @num_letters -= 1
        end
        @num_letters -= 1
        current_node.parent.children.delete(current_node)
      end
    end
    return nil
  end

  def depth
    depth = 0
    current_node = @root
    queue = []
    queue << current_node
    until queue.empty?
      first = queue.shift
      depth = first.depth if first.depth > depth
      if !first.children.empty?
        first.children.each do |child|
          queue << child
        end
      end
    end
    return depth
  end
end
