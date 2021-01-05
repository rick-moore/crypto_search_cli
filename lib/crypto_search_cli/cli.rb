require 'pry'
class CryptoSearchCli::CLI

    ##### INITIALIZING FUNCTIONS #####
    def call
        # Pull data and create coin objects from the API
        CryptoSearchCli::MarketScraper.make_coins

        # Welcome user
        puts "\n\n\n\n"
        puts Rainbow("        ------------------------------------").darkblue
        puts Rainbow("                    *+*+*+*+*+*").blue
        puts "              " + Rainbow("WELCOME TO CRYPTO SEARCH").red.underline.bright
        puts Rainbow("                    *+*+*+*+*+*").blue
        puts Rainbow("        ------------------------------------").darkblue
        main_lookup
    end

    def main_lookup
        puts "\n\n\n"

        # User input either opens cryptocurrency list or searches for a name or symbol
        puts Rainbow("  Enter a cryptocurrency name or symbol for your search,").bright
        puts Rainbow("Or enter 'list' to view the current top 10 cryptocurrencies:").bright
        input = gets.chomp.downcase
        if input == "list"
            top_ten
        else
            coin_grab(input)
        end
    end

    def top_ten
        puts Rainbow("              **********************").green
        puts Rainbow("              *Top Cryptocurrencies*").green
        puts Rainbow("              **********************").green
        puts "\n"

        # Scrapes website for top list of cryptocurrencies
        top_list = CryptoSearchCli::MarketScraper.get_top_list
        index = 0

        # Displays the next 10 currencies on the top list
        while true
            10.times do
                puts "[#{index + 1}] #{top_list[index][0].ljust(20)} \t#{top_list[index][1]}"
                index += 1
            end
            puts "\n"

            # User input either advances the list, or calls #coin_grab
            puts "Enter a cryptocurrency name or symbol for your search"
            puts "Or enter 'next' to view the next 10 cryptocurrencies"
            input = gets.chomp.downcase 
            if input != "next"
                coin_grab(input)
                break
            end
        end
    end

    def coin_grab(input)
        # Finds a coin object, displays the current price, and calls #main_menu
        coin = CryptoSearchCli::Coin.find_by_symbol_or_name(input)
        if coin.class == CryptoSearchCli::Coin
            coin.display_current_price
            main_menu(coin)
        else
            puts "Sorry, that cryptocurrency was not found, please try again"
            main_lookup
        end
    end

    def exit_program
        # Exits the program
        puts "\n\n\n\n"
        puts Rainbow("        ------------------------------------").darkblue
        puts Rainbow("                    *+*+*+*+*+*").blue
        puts "              " + Rainbow("HAVE A GREAT DAY! GOODBYE!").green.underline.bright
        puts Rainbow("                    *+*+*+*+*+*").blue
        puts Rainbow("        ------------------------------------").darkblue
        puts "\n\n\n\n"
        exit
    end




    ##### MENU FUNCTIONS #####
    def main_menu(coin)
        puts "\n\n"
        puts Rainbow("   ***********").magenta.bright
        puts Rainbow("    Main Menu").bright
        puts Rainbow("   ***********").magenta.bright
        puts " [1] Show extended details for #{coin.name}"
        puts " [2] Return and look up another cryptocurrency"
        puts " [3] Exit program"

        selection = gets.chomp
        if selection == "1"
            details_menu(coin)
        elsif selection == "2"
            main_lookup
        elsif selection == "3"
            exit_program
        else
            puts "Invalid selection, please enter 1, 2 or 3:"
            main_menu(coin)
        end
    end

    def details_menu(coin)
        # Extended details added only when we reach this menu
        coin.add_attributes(CryptoSearchCli::MarketScraper.get_extended_data(coin))
        puts "\n\n\n\n"
        puts Rainbow("   ******************").cyan.bright
        puts Rainbow("    #{coin.name} Details").bright
        puts Rainbow("   ******************").cyan.bright
        puts " [1] Current Market Details"
        puts " [2] Historical Market Details"
        puts " [3] Developer Details"
        puts " [4] Return and look up another cryptocurrency"
        puts " [5] Exit program"

        selection = gets.chomp
        if selection == "1"
            market_menu(coin)
        elsif selection == "2"
            history_menu(coin)    
        elsif selection == "3"
            developer_menu(coin)
        elsif selection == "4"
            main_lookup
        elsif selection == "5"
            exit_program
        else
            puts "Invalid selection, please enter 1, 2, 3, 4 or 5:"
            details_menu(coin)
        end
    end

    def market_menu(coin, currency = "usd")
        puts "\n\n\n\n"
        puts Rainbow("   *******************************").green.bright
        puts Rainbow("    #{coin.name} Market Details").bright
        puts Rainbow("   *******************************").green.bright
        coin.display_market_stats(currency)

        puts " [1] Switch Selected National Currency"
        puts " [2] Historical Market Details"
        puts " [3] Developer Details"
        puts " [4] Return and look up another cryptocurrency"
        puts " [5] Exit program"

        selection = gets.chomp
        if selection == "1"
            puts "Enter new currency: (usd, cad, huf)"
            currency = gets.chomp.downcase
            while !Money::Currency.include?(currency)
                puts "#{currency} is not a valid currency code, please try again:"
                currency = gets.chomp.downcase
            end
            market_menu(coin, currency)
        elsif selection == "2"
            history_menu(coin, currency)
        elsif selection == "3"
            developer_menu(coin)
        elsif selection == "4"
            main_lookup
        elsif selection == "5"
            exit_program
        else
            puts "Invalid selection, please enter 1, 2, 3, 4 or 5:"
            market_menu(coin, currency)
        end
    end

    def history_menu(coin, currency = "usd")
        puts "\n\n\n\n"
        puts Rainbow("   *******************************").blue.bright
        puts Rainbow("    #{coin.name} Historical Market Details").bright
        puts Rainbow("   *******************************").blue.bright
        coin.display_historical_stats(currency)

        puts " [1] Switch Selected National Currency"
        puts " [2] Current Market Details"
        puts " [3] Developer Details"
        puts " [4] Return and look up another cryptocurrency"
        puts " [5] Exit program"

        selection = gets.chomp
        if selection == "1"
            puts "Enter new currency: (usd, cad, huf)"
            currency = gets.chomp.downcase 
            while !Money::Currency.include?(currency)
                puts "#{currency} is not a valid currency code, please try again:"
                currency = gets.chomp.downcase
            end
            history_menu(coin, currency)
        elsif selection == "2"
            market_menu(coin, currency)
        elsif selection == "3"
            developer_menu(coin)
        elsif selection == "4"
            main_lookup
        elsif selection == "5"
            exit_program
        else
            puts "Invalid selection, please enter 1, 2, 3,4 or 5:"
            history_menu(coin, currency)
        end
    end

    def developer_menu(coin)
        puts "\n\n\n\n"
        puts Rainbow("   *******************************").red.bright
        puts Rainbow("    #{coin.name} Developer Details").bright
        puts Rainbow("   *******************************").red.bright
        coin.display_developer_stats

        puts " [1] Current Market details"
        puts " [2] Historical Market Details"
        puts " [3] Open Homepage in Browser"
        puts " [4] Return and look up another cryptocurrency"
        puts " [5] Exit program"

        selection = gets.chomp
        if selection == "1"
            market_menu(coin)
        elsif selection == "2"
            history_menu(coin)
        elsif selection == "3"
            coin.open_in_browser
            developer_menu(coin)
        elsif selection == "4"
            main_lookup
        elsif selection == "5"
            exit_program
        else
            puts "Invalid selection, please enter 1, 2, 3, 4 or 5:"
            developer_menu(coin)
        end
    end
end
