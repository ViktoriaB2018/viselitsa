class Game
  attr_reader :errors, :letters, :right_letters, :wrong_letters, :status

  MAX_ERRORS = 7

  def initialize(word)
    @letters = get_letters(word)
    @errors = 0
    @right_letters = []
    @wrong_letters = []

    # :in_progress — игра продолжается
    # :won — игра выиграна
    # :lost — игра проиграна
    @status = :in_progress
  end

  def get_letters(word)
    if word.nil? || word == ''
      abort 'Задано пустое слово, не о чем играть. Закрываемся.'
    end
    Unicode.upcase(word).split('')
  end

  def errors_left
    MAX_ERRORS - @errors
  end

  def max_errors
    MAX_ERRORS
  end

  def right?(letter)
    @letters.include?(letter) ||
      (letter == 'Е' && @letters.include?('Ё')) ||
      (letter == 'Ё' && @letters.include?('Е')) ||
      (letter == 'И' && @letters.include?('Й')) ||
      (letter == 'Й' && @letters.include?('И'))
  end

  def add_letter_to(letters, letter)
    letters << letter

    case letter
    when 'И' then letters << 'Й'
    when 'Й' then letters << 'И'
    when 'Е' then letters << 'Ё'
    when 'Ё' then letters << 'Е'
    end
  end

  def solved?
    (@letters - @right_letters).empty?
  end

  def repeated?(letter)
    @right_letters.include?(letter) || @wrong_letters.include?(letter)
  end

  def lost?
    @status == :lost || @errors >= MAX_ERRORS
  end

  def in_progress?
    @status == :in_progress
  end

  def won?
    @status == :won
  end

  def next_step(letter)
    letter = Unicode.upcase(letter)

    return if @status == :lost || @status == :won
    return if repeated?(letter)

    if right?(letter)
      add_letter_to(@right_letters, letter)
      @status = :won if solved?
    else
      add_letter_to(@wrong_letters, letter)
      @errors += 1
      @status = :lost if lost?
    end
  end

  def ask_next_letter
    puts 'Введите следующую букву'
    letter = ''
    letter = gets.encode('UTF-8').chomp while letter == ''
    next_step(letter)
  end
end
