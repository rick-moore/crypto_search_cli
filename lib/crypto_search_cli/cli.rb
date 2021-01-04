require 'pry'
class CryptoSearchCli::CLI

    ##### INITIALIZING FUNCTIONS #####
    def call
        ##### PULL DATA AND CREATE COIN OBJECTS FROM API #####
        MarketScraper.make_coins

        ##### WELCOME USER #####
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

        ##### USER INPUT EITHER OPENS CURRENCY LIST OR FINDS COIN OBJECT #####
        puts Rainbow("  Enter a cryptocurrency name or symbol for your search,").bright
        puts Rainbow("Or enter 'list' to view the current top 10 cryptocurrencies:").bright
        input = gets.chomp.downcase
        if input == "list"
            top_ten
        else
            coin_grab(input)
        end
    end

    def top_ten(num = 0)
        puts Rainbow("              **********************").green
        puts Rainbow("              *Top Cryptocurrencies*").green
        puts Rainbow("              **********************").green
        puts "\n"

        ##### USES PASSED NUMBER TO DISPLAY RANGE OF 10 CURRENCIES #####
        index = num
        MarketScraper.get_top_list(num).each do |k, v|
            puts "[#{index + 1}] #{k.ljust(20)} #{v}" if index < 9
            puts "[#{index + 1}] #{k.ljust(19)} #{v}" if index >= 9
            index += 1
        end
        puts "\n"

        ##### USER INPUT EITHER ADVANCES LIST OR FINDS COIN OBJECT #####
        puts "Enter a cryptocurrency name or symbol for your search"
        puts "Or enter 'next' to view the next 10 cryptocurrencies"
        input = gets.chomp.downcase 
        if input == "next"
            top_ten(num + 10)
        else 
            coin_grab(input)
        end
    end

    def coin_grab(input)
        ##### EITHER FINDS COIN OBJECT BY NAME OR SYMBOL, AND CALLS #main_menu #####
        coin = Coin.find_by_symbol_or_name(input)
        if coin.class == Coin
            coin.display_current_price
            main_menu(coin)
        else
            puts "Sorry, that cryptocurrency was not found, please try again"
            main_lookup
        end
    end

    def exit_program
        ##### EXITS THE PROGRAM #####
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
        puts "   ***********"
        puts "    Main Menu"
        puts "   ***********"
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
        ##### ONLY ADDS EXTENDED DETAILS WHEN WE REACH THIS MENU #####
        coin.add_attributes(MarketScraper.get_extended_data(coin))
        puts "\n\n\n\n"
        puts "   ******************"
        puts "    #{coin.name} Details"
        puts "   ******************"
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
        puts "   *******************************"
        puts "    #{coin.name} Market Details"
        puts "   *******************************"
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
        puts "   *******************************"
        puts "    #{coin.name} Historical Market Details"
        puts "   *******************************"
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
        puts "   *******************************"
        puts "    #{coin.name} Developer Details"
        puts "   *******************************"
        coin.display_developer_stats

        puts " [1] Current Market details"
        puts " [2] Historical Market Details"
        puts " [3] Return and look up another cryptocurrency"
        puts " [4] Exit program"

        selection = gets.chomp
        if selection == "1"
            market_menu(coin)
        elsif selection == "2"
            history_menu(coin)
        elsif selection == "3"
            main_lookup
        elsif selection == "4"
            exit_program
        else
            puts "Invalid selection, please enter 1, 2, 3, or 4:"
            developer_menu(coin)
        end
    end
end
