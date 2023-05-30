class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reader_cards
  validates :address, presence: true, uniqueness: true
  validates :name, presence: true
  validates :number, presence: true
  validates :age, presence: true
  has_one_attached :image

  # def self.add_user(name, address)
  #   user = User.new(name: name, address: address)
  #   if user.valid?
  #     user.save
  #     User.last
  #   else
  #     # Обработка ошибок валидации
  #     puts user.errors.full_messages
  #     nil
  #   end
  # end
  #
  # def self.update_user (name, address, id)
  #   user_id = User.find(id)
  #   user = User.new(name: name, address: address)
  #   if user.valid?
  #     user_id.update(name: name, address: address)
  #     return user_id
  #   else
  #     # Обработка ошибок валидации
  #     puts user.errors.full_messages
  #     nil
  #   end
  # end

  def self.delete_user_id (id)
    user_id = User.find(id)
    user_id.delete
  end
end
