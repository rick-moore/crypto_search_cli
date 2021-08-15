# CryptoSearchCli
## A command line tool for looking up current and historical market data for the most popular cryptocurrencies.

## Installation

Clone this repo on to your machine

And then execute:

    $ bundle install

# Key Features

## Web Scraping and API Connection
* Top coins scraped using `Nokogiri` from https://coinmarketcap.com/all/views/all/
* data loaded from https://api.coingecko.com/api/v3/coins for coin data.

## Usage

To start the CLI, run:
    
    $ ruby bin/crypto-search

Search for a cryptocurrency name or symbol to look it up, or type 'list' to see an extendable list of the top current cryptocurrencies.

Navigate the menus to view more information on a selected crypto-currency:

![cryptosearch-top](https://user-images.githubusercontent.com/72274257/122453322-85bbcf00-cfaa-11eb-8190-885589924e2b.gif)

![cryptosearch-market](https://user-images.githubusercontent.com/72274257/122453921-0aa6e880-cfab-11eb-8af5-b450d1d61326.gif)

## Money and Strings Formatting
* `rainbow` gem used for colorizing the command line.
* `money` `date` and `monetize` gems used to format strings.  View my blog post for more detail on my approach here: https://dirklo.medium.com/formatting-number-strings-in-ruby-4da35d5282e3
* Switch national markets and currencies on the market details:

![cryptosearch-currency](https://user-images.githubusercontent.com/72274257/122454840-0e873a80-cfac-11eb-9a47-1f4813fe094d.gif)
