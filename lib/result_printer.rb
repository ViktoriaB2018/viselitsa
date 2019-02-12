class ResultPrinter
  def initialize(game)
    @status_image = []
    counter = 0

    while counter <= game.max_errors
      file_name = "#{File.join(__dir__, '..', 'image', "#{counter}.txt")}"

      begin
        file = File.new(file_name, 'r:UTF-8')
        @status_image << file.read
        file.close
      rescue SystemCallError
        @status_image << "\n [ изображение не найдено ] \n"
      end

      counter += 1
    end
  end

  def print_viselitsa(errors)
    puts @status_image[errors]
  end

  def cls
    system('clear') && system('cls')
  end

  def print_status(game)
    puts "\nСлово: #{get_word_for_print(game.letters, game.right_letters)}"
    puts "\nОшибки: #{game.wrong_letters.join(', ')}"

    print_viselitsa(game.errors)

    if game.lost?
      puts 'К сожалению, вы проиграли'
      puts "Загаданное слово было: #{game.letters.join('')}"
      puts
    elsif game.won?
      puts 'Поздравляем, вы выиграли!'
    else
      puts "У вас осталось ошибок: #{game.errors_left}"
    end
  end

  def get_word_for_print(letters, right_letters)
    result = ''

    letters.each do |letter|
      result += if right_letters.include?(letter)
                  letter + ' '
                else
                  '__ '
                end
    end
    result
  end
end
