def get_deputies_info
    base_url = "https://www.assemblee-nationale.fr/dyn/vos-deputes"  # URL de la liste des députés
    deputies = []
  
    puts "Début de la récupération des informations des députés..."
    begin
      page = Nokogiri::HTML(URI.open(base_url))
      puts "Page récupérée avec succès !"
      
      # Extraction des informations des députés
      page.css('.list_table .table.table-striped tbody tr').each do |row|
        name = row.css('td a').text.strip
        email = row.css('td a[href^="mailto"]').text.strip  # Cherche l'email directement dans les liens mailto
  
        if name && email
          puts "Récupéré : #{name} => #{email}"
  
          # Séparation du nom et prénom
          first_name, last_name = name.split(" ", 2)
  
          # Correction : vérifier que le last_name ne contient pas d'email
          last_name = last_name.gsub(/<.*?>/, '').strip  # Suppression des emails qui pourraient se glisser dans le nom
  
          deputies << { "first_name" => first_name, "last_name" => last_name, "email" => email }
        end
      end
  
    rescue StandardError => e
      puts "Erreur lors de la récupération des données : #{e.message}"
    end
  
    puts "Données récupérées : #{deputies}"
    return deputies
  end
  



  