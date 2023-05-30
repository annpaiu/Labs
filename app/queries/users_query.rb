class UsersQuery
  def self.call
    User.left_joins(reader_cards: :books)
        .select(
            'users.id',
            'users.name',
            'users.age',
            'COUNT(DISTINCT books.id) AS books_count'
        )
        .group('users.id')
  end

  def self.search(name, users)
    if name.present?
      # libraries = libraries.where(name: name)
      users = users.where('users.name LIKE ?', "%#{name}%")
    end
    users
  end

  def self.search_age(age, users)
    if age.present?
      # libraries = libraries.where(name: name)
      users = users.where('users.age LIKE ?', "%#{age}%")
    end
    users
  end

  def self.search_count(count, users)
    if count.present?
      users = users.having('COUNT(DISTINCT books.id) = ?', count.to_i)
    end
    users
  end

  def self.sort_users(users, sort_by)
    case sort_by
    when "books_asc"
      users.sort_by { |user| user.books_count }
    when "books_desc"
      users.sort_by { |user| -user.books_count }
    when "age_asc"
      users.sort_by { |user| user.age}
    when "age_desc"
      users.sort_by { |user| -user.age }
    when "name_asc"
      users.sort_by { |user| user.name }
    when "name_desc"
      users.sort_by { |user| user.name }.reverse
    else
      users
    end
  end

  def self.main_sort(params)
    @users = UsersQuery.call
    if(params[:name])
      @users = UsersQuery.search(params[:name], @users)
    end
    if(params[:age])
      @users = UsersQuery.search_age(params[:age], @users)
    end
    if(params[:count])
      @users = UsersQuery.search_count(params[:count], @users)
    end
    @users = UsersQuery.sort_users(@users, params[:sort_by])
    @users = Kaminari.paginate_array(@users).page(params[:page]).per(10)
    @users
  end

end