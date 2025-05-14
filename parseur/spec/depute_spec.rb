# spec/depute_spec.rb
require 'rspec'
require 'nokogiri'
require 'open-uri'
require_relative '../lib/depute'

RSpec.describe 'Récupération des informations des députés' do
  let(:base_url) { "https://www.assemblee-nationale.fr/dyn/vos-deputes" }

  # Simulation d'une page HTML pour ne pas effectuer de vraie requête
  let(:html_content) do
    <<-HTML
      <table class="table table-striped">
        <tbody>
          <tr>
            <td><a href="#">Jean Dupont</a></td>
            <td><a href="mailto:jean.dupont@assemblee.fr">jean.dupont@assemblee.fr</a></td>
          </tr>
          <tr>
            <td><a href="#">Marie Durand</a></td>
            <td><a href="mailto:marie.durand@assemblee.fr">marie.durand@assemblee.fr</a></td>
          </tr>
        </tbody>
      </table>
    HTML
  end

  before do
    # On se moque de l'ouverture du fichier en ligne (pas de requêtes HTTP réelles)
    allow(URI).to receive(:open).with(base_url).and_return(html_content)
  end

  describe '#get_deputies_info' do
    it 'devrait récupérer les informations des députés' do
      # Appel de la méthode pour récupérer les informations
      deputies = get_deputies_info

      # Vérification du contenu HTML reçu pour vérifier la simulation
      puts "Données récupérées : #{deputies}"

      # Vérification des données récupérées
      expect(deputies).to be_an(Array)  # Doit être un tableau
      expect(deputies.length).to eq(2)   # Nous avons 2 députés dans l'exemple HTML

      # Vérification du contenu des données
      expect(deputies[0]).to eq({
        "first_name" => "Jean", "last_name" => "Dupont", "email" => "jean.dupont@assemblee.fr"
      })
      expect(deputies[1]).to eq({
        "first_name" => "Marie", "last_name" => "Durand", "email" => "marie.durand@assemblee.fr"
      })
    end
  end
end
