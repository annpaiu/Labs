class LibrariesQuery

  def self.call()
    libraries = Library.left_joins(books: :genres)
        .select("libraries.id, libraries.name, COUNT(DISTINCT books.id) AS books_count, COUNT(DISTINCT genres.id) AS genres_count")
        .group("libraries.id, libraries.name")
        .order("libraries.name ASC")
  end

  def self.search(name, libraries)
    if name.present?
      # libraries = libraries.where(name: name)
      libraries = libraries.where('libraries.name LIKE ?', "%#{name}%")
    end
    libraries
  end

  def self.sort_libraries(libraries, sort_by)
    case sort_by
    when "books_asc"
      libraries.sort_by { |library| library.books_count }
    when "books_desc"
      libraries.sort_by { |library| -library.books_count }
    when "genres_asc"
      libraries.sort_by { |library| library.genres_count }
    when "genres_desc"
      libraries.sort_by { |library| -library.genres_count }
    when "name_asc"
      libraries.sort_by { |library| library.name }
    when "name_desc"
      libraries.sort_by { |library| library.name }.reverse
    else
      libraries
    end
  end

  def self.main_sort(params)
    @libraries = LibrariesQuery.call
    if(params[:name])
      @libraries = LibrariesQuery.search(params[:name], @libraries)
    end
    @libraries = LibrariesQuery.sort_libraries(@libraries, params[:sort_by])

    @libraries = Kaminari.paginate_array(@libraries).page(params[:page]).per(20)
    @libraries
  end
end
