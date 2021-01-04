##### REQUIRING GEMS/LIBRARIES #####
require "bundler/setup"
require "open-uri"
require "nokogiri"
require "net/http"
require "json"
require "date"
require "money"
require "monetize"
require "rainbow"

##### CONFIGURING MONEY GEM TO AVOID DEPRECATION #####
Money.rounding_mode = BigDecimal::ROUND_HALF_EVEN
Money.locale_backend = :currency
Money.default_currency = "USD"

##### REQUIRING LIB FILES #####
require_relative './crypto_search_cli/version'
require_relative './crypto_search_cli/cli'
require_relative './crypto_search_cli/coin'
require_relative './crypto_search_cli/scraper'