require './game'
require './author'

module GameModule
  def game_info
    puts 'When was this game published'
    date_of_publish = input_date('of Publish')
    puts 'When did you last play this game?'
    date_last_played = input_date('when last played')
    puts 'Is multiplayer'
    bool = game_feature('multiplayer')
    game = Game.new(date_of_publish, date_last_played)
    game.multiplayer = bool if bool
    @games << game
    puts 'Do you know author of the game?'
    know_author = game_feature('author')
    if know_author
      puts 'Lets create an Author for this game'
      create_author(game)
    else
      puts 'No worries!! You can always create it later by using "15" option.'
    end
  end

  def input_date(val)
    year_input = validate_year("Input year #{val}")
    month_input = validate_month("Input month #{val}")
    day_input = validate_day("Input day #{val}")
    {
      year: year_input,
      month: month_input,
      day: day_input
    }
  end

  def game_feature(val)
    puts "Insert 'Y' if #{val}, 'N' if not"
    user_input = gets.chomp.downcase
    if user_input.include?('y')
      true
    elsif user_input.include?('n')
      false
    else
      puts 'Invalid Input. Insert "Y" if multiplayer, "N" if single player'
      game_feature(val)
    end
  end

  def create_author(game)
    first, last = author_input
    if @authors.length.positive? 
      bool, author_value = validate_author(first, last)
      # @authors.each do |author|
      #   game.add_author(author) if author.f_name == first && author.l_name == last
      # end
      if bool 
        game.add_author(author_value)
      else
        @authors.push(Author.new(first, last))
        puts author_value
      end
    else
      author = Author.new(first, last)
      @authors.push(author)
      game.add_author(author)
    end
  end

  def create_new_author
    first, last = author_input
    author = Author.new(first, last)
    @authors.push(author)
  end

  def validate_author(first, last)
    @authors.each do |author|
      author.f_name == first && author.l_name == last ? [true, author] : [false, 'new author created']
    end
  end


  def author_input
    puts 'Please add first name of the author'
    first = gets.chomp
    puts 'Please add last name of the author'
    last = gets.chomp
    [first, last]
  end
end
