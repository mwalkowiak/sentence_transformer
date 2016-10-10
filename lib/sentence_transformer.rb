class SentenceTransformer
  END_SENTENCE_CHARS = ['.', '?', '!']
  SINGLE_WORD_CHARS = [',', ';', ':']
  BRACKETS = [
    { left: '(', right: ')'},
    { left: '[', right: ']'},
    { left: '<', right: '>'},
  ]

  def initialize
    @reversed_sentence = ''
  end

  def reverse(content)
    current_position = 0
    previous_position = 0
    sentences = []

    content.each_char do |ch|
      current_position += 1

      # Detect end of the sentence
      if END_SENTENCE_CHARS.include?(ch)
        sentences << { sentence: content[previous_position..current_position].strip, delimiter: ch }
        previous_position = current_position
      end
    end

    sentences.each do |record|
      @reversed_sentence = "#{@reversed_sentence} #{reverse_sentence(record[:sentence]).capitalize}#{record[:delimiter]}".strip
    end
    @reversed_sentence
  end

  private

  # Go through the given sentence and and apply reverse order keeping positions of special chars
  def reverse_sentence(sentence)
    reversed_sentence = ''
    sentence_words = sentence.split(' ')
    sentence_words.to_enum.with_index.reverse_each do |word, index|
      word = clean_word(word)
      word = append_char_to_word(word, sentence_words, index)
      word = handle_brackets(word)

      reversed_sentence = "#{reversed_sentence} #{word}"
    end
    reversed_sentence.strip
  end

  # Cleanup given word after sentence split
  def clean_word(word)
    unwanted_chars = END_SENTENCE_CHARS + SINGLE_WORD_CHARS
    unwanted_chars.each do |unwanted_char|
      word.tr!(unwanted_char, '') if word.include?(unwanted_char)
    end
    word
  end

  # handle single chars like comma
  def append_char_to_word(word, sentence_words, index)
    SINGLE_WORD_CHARS.each do |single_word_char|
      word = "#{word}#{single_word_char}" if sentence_words[index - 1].include?(single_word_char)
    end
    word
  end

  # Handle different brackets as they behave a little different than other chars
  def handle_brackets(word)
    BRACKETS.each do |bracket|
      if word.include?(bracket[:left])
        word.tr!(bracket[:left], '')
        word = "#{word}#{bracket[:right]}"
        break
      end
      if word.include?(bracket[:right])
        word.tr!(bracket[:right], '')
        word = "#{bracket[:left]}#{word}"
        break
      end
    end
    word
  end
end
