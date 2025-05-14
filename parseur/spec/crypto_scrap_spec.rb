# spec/crypto_scrap_spec.rb

require_relative '../lib/crypto_scrap'

RSpec.describe 'fetch_crypto_prices' do
  it 'retourne un array non vide' do
    result = fetch_crypto_prices
    expect(result).to be_an(Array)
    expect(result).not_to be_empty
  end

  it 'contient des hashes avec une clé symbole et une valeur numérique' do
    result = fetch_crypto_prices
    expect(result.all? { |h| h.is_a?(Hash) }).to be true
    expect(result.all? { |h| h.keys.first.is_a?(String) && h.values.first.is_a?(Numeric) }).to be true
  end

  it 'contient certaines cryptos bien connues (BTC, ETH)' do
    result = fetch_crypto_prices
    symbols = result.map(&:keys).flatten
    expect(symbols).to include("BTC")
    expect(symbols).to include("ETH")
  end
end
