require 'httparty'
require 'json'

def fetch_crypto_prices
  url = "https://api.coingecko.com/api/v3/coins/markets"
  params = {
    vs_currency: "usd",
    order: "market_cap_desc",
    per_page: 10,
    page: 1,
    sparkline: false
  }

  response = HTTParty.get(url, query: params)
  data = JSON.parse(response.body)

  crypto_array = []

  data.each do |crypto|
    symbol = crypto["symbol"].upcase
    price = crypto["current_price"].to_f
    puts "Récupéré : #{symbol} => #{price}"  # <= Ce puts affiche chaque crypto récupérée
    crypto_array << { symbol => price }
  end

  crypto_array
end

# Appelle la méthode si ce fichier est lancé directement
if __FILE__ == $PROGRAM_NAME
  puts "\nRésultat final :"
  puts fetch_crypto_prices
end


