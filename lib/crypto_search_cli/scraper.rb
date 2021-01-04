class MarketScraper

    #takes in a url, requests and returns the parsed JSON data
    def self.json_helper(url)
        uri = URI.parse(url)
        response = Net::HTTP.get_response(uri)
        JSON.parse(response.body)
    end


    ##### COIN OBJECT CREATORS #####

    #returns a hash of all cryptocurrencies
    def self.get_coins 
        url = 'https://api.coingecko.com/api/v3/coins/list'
    
        self.json_helper(url)
    end

    #creates coin objects, assigning their name, id, and symbol for searching purposes
    def self.make_coins
        self.get_coins.each do |coin_attributes|
            c = Coin.new(coin_attributes)
        end
    end

    
    ##### COIN DATA RETRIEVERS #####

    #returns a hash with the currency and current value of passed coin
    def self.get_price(coin)
        url = "https://api.coingecko.com/api/v3/simple/price?ids=#{coin.id}&vs_currencies=USD"

        self.json_helper(url).values[0]
    end

    #returns a hash with all extended data of passed coin 
    def self.get_extended_data(coin)
        url = "https://api.coingecko.com/api/v3/coins/#{coin.id}?localization=false&tickers=true&market_data=true&community_data=true&developer_data=true&sparkline=false"

        self.json_helper(url)
    end

    
    ##### TOP LIST RETRIEVER #####
    def self.get_top_list(num)
        url = "https://coinmarketcap.com/all/views/all/"
        html = Nokogiri::HTML(open(url))

        
        # retrieve title list
        titles = html.css(".cmc-table__cell--sort-by__name a")
        titles_list = []
        titles.each do |item|
            titles_list << item.attributes["title"].text
        end

        # retrieve symbol list
        symbols = html.css(".cmc-table__cell--sort-by__symbol div")
        symbols_list = []
        symbols.each do |item|
            symbols_list << item.text
        end

        #create a hash of 10 names and symbols, starting from the passed in index
        titles_and_symbols_hash = {}
        index = num
        10.times do 
            titles_and_symbols_hash[titles_list[index]] = symbols_list[index]
            index +=1
        end
        titles_and_symbols_hash
    end
end
