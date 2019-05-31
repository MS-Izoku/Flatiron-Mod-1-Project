require_relative '../config/environment'
# not the dryest code I could do, but it is functional
# many of the if-statements could be made into switch statements
# input could be redone and checked for the downcased-versions of their search topics

# Style
def menu_header(title)
    puts "
    ==-----==[ #{title} ]==-----==
    "
end

# Functionaliy
def login
    # functionality for existing users not-implemented
    # every login will create a new user
    menu_header("Creation Menu")
    create_user # made as a function since an existing user-login could exist later
end

# a user should be able to create an account
def create_user
    puts ">> Input New Username:"
    name = gets.chomp
    puts ">> Welcome #{name}, please enter your favorite genre of music"
    gen = gets.chomp
    temp = User.create(name: name, favorite_genre: gen)

    puts ">> Welcome #{name}!"
    run_program
end

# "admin privilege" to delete all users from the table
def clear_user_table
    menu_header("Delete All Users")
    puts ">> Danger-zone, please input admin password"
    inp = gets.chomp
    if inp == "admin"
        puts ">> UNLIMITED POWER"
        User.destroy_all
        login
    else
        puts ">> Admin access denied"
    end
end

# search functionality
def search
    puts ">> How would you like to search?"
    puts ">> Genre      Host"
    inp = gets.chomp
    if inp == "Genre" || inp == "genre"
        genre_search
    elsif inp == "Host" || inp == "host"
        host_search
    elsif inp == "back" || inp == "Back"
        run_program
    else
        puts ">> Invalid Input"
    end
end

def host_search
    menu_header("Search For Hosts")
    puts ">> If you know 'um, we can find 'um!"
    inp = "DJ #{gets.chomp}"

    stations = Station.all.select do |station|
        station.host.downcase == inp.downcase
    end
    
    if stations[0] != nil
        stations.each do |station|
            puts ">> #{station.host} hosts the #{station.genre} station '#{station.name}'"
        end
    else
        puts ">> That host was not found"
    end
end

def genre_search
    menu_header("Search For Stations")
    puts ">> What genre are you looking for?"
    inp = gets.chomp
    stations = Station.all.select do |station|
        station.genre == inp || station.genre.downcase == inp
    end
    if stations[0] != nil
        stations.each do |station|
            puts ">> #{station.name}, hosted by #{station.host}."
        end
    else
        puts ">> No stations of that genre were found."
    end
end

def user_search
    menu_header("User Search")
    puts "What user are you looking for?"
    inp = gets.chomp

    users = User.all.select do |user|
        user.name.downcase == inp
    end
end

# a user should be able to delete a station from their account
def remove_user
    menu_header("Remove User")
    puts ">> Input username to delete"
    inp = gets.chomp
    
    usernames = User.all.collect do |user|
        user.name
    end
    
    #check if the user wants to go back, or if the input is on the db
    if inp.downcase == "back"
        run_program
    elsif !usernames.include?(inp)
        puts ">> Invalid Input '#{inp}'"
        remove_user
    end

    puts ">> Are you sure you want to delete #{inp}? Enter Yes or No"
    ready_check = gets.chomp
    if ready_check == "Yes" || ready_check == "yes"
         User.where(name: inp).destroy_all   # NOTE: deletes all users with a matching name
         login
    elsif ready_check == "No" || ready_check == "no" || ready_check == "back" || ready_check == "Back"
        puts ">> Returning to main menu"
        #run_program
    else
        puts ">> Invalid Input"
        remove_user   #run the function again in case of a typo
    end

end

def exit_program
    puts ">> Goodbye"
    exit
end

# updates a users favorite genre
def change_favorite_genre
    puts ">> Input User"
    user_name = gets.chomp

    user = User.find_by(name: user_name)
    if user == nil
        puts ">> User not found"
    else
        puts ">> Enter new favorite genre"
        new_genre = gets.chomp
        user.update(favorite_genre: new_genre)
    end
end

def list_all_stations
    menu_header("Station List")
    Station.all.each do |station|
        puts ">> #{station.name}, hosted by #{station.host}"
    end
end

def help_menu
    menu_header("Help Menu")
    puts ">> Enter 'remove-account' to remove a user account by name"
    puts ">> Enter 'update-favorite-genre' to change a users favorite genre"
    puts ">> Enter 'search' to search for stations"
    puts ">> Enter 'directory' to list out Database information"
    puts ">> Enter 'station-list' to remove a user account by name"
    puts ">> Enter 'exit' or 'quit' to exit the program"
end

def db_directory
    menu_header("List Directory")
    puts ">> What would you like to list?"
    puts ">> Hosts  Users   Stations    Genres      User-Genres"
    inp = gets.chomp
    if inp == "Hosts" || inp == "hosts"
        Station.all.each do |station|
            puts ">> #{station.host}"
        end
    elsif inp.downcase == "user-genres"
        User.all.each do |user|
            puts ">> #{user.name}, favorite genere: #{user.favorite_genre}"
        end
    elsif inp == "Users" || inp == "users"
        User.all.each do |user|
            puts ">> #{user.name}"
        end
    elsif inp == "Stations" || inp == "stations"
        Stations.all.each do |station|
            puts ">> #{station.name}"
        end
    elsif inp == "Genres" || inp == "genres"
        all_genres = [] # dump all genres in this array
        Station.all.each do |station|
            all_genres << station.genre
        end

        User.all.each do |user|
            all_genres << user.favorite_genre
        end

        all_genres.uniq.each do |genre| # lists all unique genres
            puts ">> #{genre}"
        end
    elsif inp.downcase == "back"
        run_program
    else
        puts "Invalid Input"
        db_directory
    end
end

def run_program
    menu_header("[[-----{{!}}   Main Menu   {{!}}-----]]")
    puts ">> Please Enter a command"
    puts ">> For help, type 'h' or 'help'"
    inp = gets.chomp

    while inp != ""
        if inp == "remove-account"
            remove_user
        elsif inp == "remove-all-users"
            clear_user_table
        elsif inp == "update-favorite-genre"
            change_favorite_genre
        elsif inp == "search"
            search
        elsif inp == "station-list"
            list_all_stations
        elsif inp == "directory"
            db_directory
        elsif inp == "h" || inp == "help"
            help_menu
        elsif inp == "exit" || inp == "quit"
            exit_program
        else
            puts ">> Invalid Input, type 'h' or 'help' for a list of commands"
        end
        run_program
    end
end

login