require 'open-uri'
require 'nokogiri'

# Test pour récupérer les URLs des mairies
def test_get_townhall_urls
  puts "Test: Récupération des URLs des mairies..."

  begin
    urls = get_townhall_urls
    if urls.empty?
      puts "Aucune URL trouvée."
    else
      puts "URLs récupérées :"
      urls.each do |town, url|
        puts "#{town} => #{url}"
      end
    end
  rescue => e
    puts "Erreur lors du test de récupération des URLs : #{e.message}"
  end
end

# Test pour récupérer les emails des mairies
def test_get_townhall_emails
  puts "Test: Récupération des emails des mairies..."

  begin
    # On commence par récupérer les URLs des mairies
    urls = get_townhall_urls
    if urls.empty?
      puts "Aucune URL à tester pour les emails."
      return
    end
    
    # Ensuite on récupère les emails pour chaque URL
    emails = get_townhall_emails(urls)
    
    if emails.empty?
      puts "Aucun email trouvé."
    else
      puts "Emails récupérés :"
      emails.each do |email|
        email.each do |town, mail|
          puts "#{town} => #{mail}"
        end
      end
    end
  rescue => e
    puts "Erreur lors du test de récupération des emails : #{e.message}"
  end
end

# Programme principal qui exécute les tests
def main
  test_get_townhall_urls
  test_get_townhall_emails
end

# Lancement des tests
main


  
  



  

