require 'active_model'


namespace :parser do
  desc "Parse libraries"
  task :parse_libraries =>:environment do
    require 'open-uri'
    require 'nokogiri'

    url = 'https://en.wikipedia.org/wiki/List_of_libraries'
    html = URI.open(url, :read_timeout => 10).read
    doc = Nokogiri::HTML(html)

    libraries = doc.xpath('//h2[1]/following-sibling::*[following::h2[2]]')

    libraries.css('li').each do |library|
      link = library.css('a').first
      if link
        name = link.text
        location = library.text.split(",").last.strip
        year_of_creation = rand(1000..2023)
        puts "Name: #{name}, Location: #{location}"
        # Library.create(name: name, location: location, year_of_creation: year_of_creation)
      end
    end
  end

  desc 'Extract library data from CSV file'
  task extract_library_data: :environment do
    require 'csv'
    output_file = CSV.open("output_file.csv", "w")
    output_file << ['Library Name', 'Street Address', 'City', 'Zip Code']
    start_time = Time.now
    CSV.foreach('libraries_5.csv', headers: true) do |row|
      library_name = row['Library Name']
      street_address = row['Street Address']
      city = row['City']
      zip_code = row['Zip Code']
      sleep 0.0003
      output_file << [library_name, street_address, city, zip_code]
      puts "Library Name: #{library_name}, Street Address: #{street_address}, City: #{city}, Zip Code: #{zip_code}"
      year_of_creation = rand(1000..2023)
      # Library.create(name: library_name, location: city, year_of_creation: year_of_creation, street_address: street_address, zip_code: zip_code)
    end
    end_time = Time.now
    puts "Функція виконувалась #{(end_time - start_time)} секунд"
  end

  desc 'Extract library data from CSV file used threads'
  task extract_library_data_threads: :environment do
    require 'csv'
    output_file = CSV.open("output_file.csv", "w")
    output_file << ['Library Name', 'Street Address', 'City', 'Zip Code']
    start_time = Time.now
    threads = []
    CSV.foreach('libraries_5.csv', headers: true) do |row|
      threads << Thread.new do
        library_name = row['Library Name']
        street_address = row['Street Address']
        city = row['City']
        zip_code = row['Zip Code']
        sleep 0.0003
        output_file << [library_name, street_address, city, zip_code]
        puts "Library Name: #{library_name}, Street Address: #{street_address}, City: #{city}, Zip Code: #{zip_code}"
        year_of_creation = rand(1000..2023)
        # Library.create(name: library_name, location: city, year_of_creation: year_of_creation, street_address: street_address, zip_code: zip_code)
      end
    end

    threads.each(&:join)
    end_time = Time.now
    puts "Функція виконувалась #{(end_time - start_time)} секунд"
  end
end