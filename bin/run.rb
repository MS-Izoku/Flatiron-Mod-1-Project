require_relative '../config/environment'

current_user = nil

def login
    # functionality for existing users not-implemented
    puts "User Creation Menu"
    create_user
end

# a user should be able to create an account
def create_user
    puts "Input New Username:"
    name = gets.chomp
    puts "Welcome #{name}, please enter your favorite genre of music"
    gen = gets.chomp
    temp = User.create(name: name, favorite_genre: gen)
    current_user = temp

    puts "Great, let's get started then"
    run_program
end

def clear_user_table
    puts "Danger-zone, please input admin password"
    inp = gets.chomp
    if inp == "admin"
        puts "UNLIMITED POWER"
        User.destroy_all
        login
    else
        puts "Admin access denied"
    end
end

# a user should be able to delete a station frm their account
def remove_user(user_to_remove = nil)
    puts "Input username to delete"
    if user_to_remove == nil 
        inp = gets.chomp
    else
        inp = user_to_remove
    end
    
    puts "Are you sure you want to delete #{inp}? Enter Yes or No"
    ready_check = gets.chomp
    if ready_check == "Yes" || ready_check == "yes"
         User.where(name: inp).destroy_all   # NOTE: deletes all users with a matching name
    elsif ready_check == "No" || ready_check == "no"
        puts "Returning to main menu"
        run_program
    else
        puts "Invalid Input"
        remove_user(inp)    #run the function again in case of a typo
    end
    login
end

# a usershould be able to see all available stations
def read_all_stations
    Station.all.each do |station|
        puts station.name
    end
end

# a user should be able to add a station from their account
def add_new_station(station)
    Selection.create(station_id: station.id , user_id: current_user.id)
end

def exit_program
    puts "Goodbye #{current_user.name}"
end

def change_favorite_genre
    puts "Input Username to Continue"
    user_name = gets.chomp

    user = User.find_by(name: user_name)
    if user == nil
        puts "User not found"
    else
        puts "Enter new favorite genre"
        new_genre = gets.chomp
        user.update(favorite_genre: new_genre)
    end
end

def list_all_users
   User.all.each do |user|
     puts user.name
   end
end

def run_program
    puts "Main Menu"
    puts "Enter a command"
    inp = gets.chomp

    while inp != ""
        if inp == "remove-account"
            remove_user
        elsif inp == "user-list"
            list_all_users
        elsif inp == "remove-all-users"
            clear_user_table
        elsif inp == "update-favorite-genre"
            change_favorite_genre
        elsif inp == "exit"
            exit_program
        end
        run_program
    end
end

login


