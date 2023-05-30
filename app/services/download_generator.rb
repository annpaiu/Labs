require 'csv'

class DownloadGenerator
  def self.generate_csv(headers, libraries)
    CSV.generate(headers: true, col_sep: ';') do |csv|
      csv << ['Library Name', 'Library Location', 'Library Year of Creation', 'Library Street Address', 'Library ZIP Code',
              'Reader Name', 'Reader Address', 'Reader Email', 'Reader Card Number', 'Reader Age']

      libraries.each do |library|
        library.reader_cards.each do |reader_card|
          user = reader_card.user
          csv << [
              library.name,
              library.location,
              library.year_of_creation,
              library.street_address,
              library.zip_code,
              user.name,
              user.address,
              user.email,
              reader_card.id,
              user.age
          ]
        end
      end
    end
  end

  def self.generate_pdf(libraries)
    pdf = Prawn::Document.new
# Створюєм таблицю для відображення даних про книги
    data = []
    libraries.each do |library|
      library_data = {}
      library_data[:library_name] = library.name
      library_data[:library_location] = library.location
      library_data[:library_year_of_creation] = library.year_of_creation
      library_data[:library_street_address] = library.street_address
      library_data[:library_zip_code] = library.zip_code
      data << library_data

      library.reader_cards.each do |reader_card|
        user = reader_card.user
        reader_data = {}
        reader_data[:reader_name] = user.name
        reader_data[:reader_address] = user.address
        reader_data[:reader_email] = user.email
        reader_data[:reader_card_number] = reader_card.id
        reader_data[:reader_age] = user.age
        data << reader_data
      end
    end

    pdf.text "Libraries\n\n"
    data.each do |data_entry|
      if data_entry[:library_name]
        pdf.text "-----------------------------------------------------------------------------------------------", color: "5cff00"
        pdf.text "Library Name: #{data_entry[:library_name]}"
        pdf.text "Library Location: #{data_entry[:library_location]}"
        pdf.text "Library Year of Creation: #{data_entry[:library_year_of_creation]}"
        pdf.text "Library Street Address: #{data_entry[:library_street_address]}"
        pdf.text "Library ZIP Code: #{data_entry[:library_zip_code]}"
        pdf.text "\n"
        pdf.text "Readers:"
        pdf.text "\n"
      else
        pdf.text "Reader Name: #{data_entry[:reader_name]}"
        pdf.text "Reader Address: #{data_entry[:reader_address]}"
        pdf.text "Reader Email: #{data_entry[:reader_email]}"
        pdf.text "Reader Card Number: #{data_entry[:reader_card_number]}"
        pdf.text "Reader Age: #{data_entry[:reader_age]}"
        pdf.text "\n"
      end
    end
    pdf.render
  end

  def self.generate_library_report(library)
    Prawn::Document.new do |pdf|
      pdf.repeat(:all) do
        pdf.draw_text "Library", at: [pdf.bounds.right - 30, pdf.bounds.top - 30], size: 24, color: "ff2400", rotate: 45
      end
      pdf.text "Library Information", size: 16, style: :bold, align: :center, color: "0072C6"
      pdf.move_down 20
      pdf.image "#{Rails.root}/images/image.jpg", width: 400, align: :center
      pdf.move_down 20

      # Library information
      pdf.text "Library Name: #{library.name}", size: 14, color: "333333"
      pdf.text "Location: #{library.location}", size: 14, color: "333333"
      pdf.text "Year of Creation: #{library.year_of_creation}", size: 14, color: "333333"
      pdf.text "Street Address: #{library.street_address}", size: 14, color: "333333"
      pdf.text "ZIP Code: #{library.zip_code}", size: 14, color: "333333"
      pdf.text "-----------------------------------------------------------------------------------------------", color: "5cff00"
      pdf.move_down 20

      # Books information
      pdf.text "Books in the Library", size: 16, style: :bold, color: "ff2400"
      pdf.move_down 10

      library.books.each do |book|
        pdf.text "Title: #{book.title}"
        pdf.text "Authors: #{book.authors.map(&:name).join(", ")}"
        pdf.text "Genres: #{book.genres.map(&:name).join(", ")}"
        pdf.text "Published_date: #{book.published_date}"
        pdf.text "\n"
      end
      pdf.text "-----------------------------------------------------------------------------------------------", color: "5cff00"
      pdf.move_down 20

      # Reader Cards information
      pdf.text "Readers in the Library", size: 16, style: :bold, color: "700357"
      pdf.move_down 10

      library.reader_cards.each do |reader_card|
        user = reader_card.user
        pdf.text "Name: #{user.name}"
        pdf.text "Address: #{user.address}"
        pdf.text "Email: #{user.email}"
        pdf.text "Card Number: #{reader_card.id}"
        pdf.text "Age: #{user.age}"
        pdf.text "\n"
      end
    end.render
  end

  def self.generate_user_report(user)
    pdf = Prawn::Document.new
    pdf.repeat(:all) do
      pdf.draw_text "User", at: [pdf.bounds.right - 30, pdf.bounds.top - 30], size: 24, color: "ff2400", rotate: 45
    end
    pdf.text "User Information", size: 16, style: :bold, align: :center, color: "0072C6"
    pdf.move_down 20

    pdf.text "Name: #{user.name}"
    pdf.text "Address: #{user.address}"
    pdf.text "Email: #{user.email}"
    pdf.text "Number: #{user.number}"
    pdf.text "Age: #{user.age}"
    pdf.move_down 20

    pdf.text "Reader Cards", size: 14, style: :bold, color: "ff2400"
    pdf.move_down 10

    user.reader_cards.each do |reader_card|
      pdf.text "Card Number: #{reader_card.id}"
      pdf.text "Library: #{reader_card.library.name}"
      pdf.text "Books:"
      reader_card.books.each do |book|
        pdf.text "- #{book.title} (#{book.published_date})"
      end
      pdf.text "-----------------------------------------------------------------------------------------------", color: "5cff00"
      pdf.move_down 10
    end
    pdf.render
  end

end
