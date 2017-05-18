class Article < ApplicationRecord
  belongs_to :user
  has_many :comments

  default_scope -> { order(created_at: :desc) }
  before_save :set_description

  validates :title, presence: true, length: {minimum: 10, maximum: 120}
  validates :body, presence: true, length: {minimum: 100}

  self.per_page = 10

  searchable do
    text :title, :body
  end

  private
    def set_description
      self.description = body[0..120]
    end
end
