class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :set_username

  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  def is_author?(record)
    record.user == self
  end

  private
    def set_username
      self.username = email.match(/^(.+)@/).captures.first
    end
end
