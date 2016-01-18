require_relative 'letter_node.rb'

class DictionaryTree
#LetterNode = Struct.new(:letter, :definition, :children, :parent, :depth)
attr_reader :root, :num_letters, :num_words, :depth

  def initialize(entries=[])
    raise ArgumentError unless entries.is_a?(Array)
    @root = LetterNode.new(nil, nil, [], nil, 1)
    @num_letters = 0
    @num_words = 0
    entries.each do |entry|
      insert_word(entry[0], entry[1])
    end
    @depth = 1
  end

  def insert_word(word, definition)
    raise ArgumentError if !word.is_a?(String) && !definition.is_a?(String)
    raise ArgumentError if word == nil || definition == nil

    current_node = @root
    word_array = word.split("")
    max_index = word_array.length - 1

    word_array.each_with_index do |letter, index|
      child = current_node.children.select { |node| letter == node.letter }
      current_node = child[0] unless child == []

      if index == max_index
        current_node.children << LetterNode.new(letter, definition, [], current_node, index + 2)
        @num_words += 1
        @num_letters += 1
      else
        current_node.children << LetterNode.new(letter, nil, [], current_node, index + 2)
        @num_letters += 1
      end
      current_node = current_node.children.last
    end

  end

  def definition_of(word)
    raise ArgumentError unless word.is_a?(String)

    current_node = @root
    word_array = word.split("")
    max_index = word_array.length - 1

    word_array.each_with_index do |letter, index|
      child = current_node.children.select { |node| letter == node.letter }
      current_node = child[0] unless child == []

      if index ==  max_index

      end
    end
    return nil
  end

  def remove_word(word)
    raise ArgumentError unless word.is_a?(String)
  end
end
