class Article < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_many :comments

  default_scope -> { order(created_at: :desc) }
  before_save :set_description, on: :create

  has_attached_file :image, styles: {original: "300x300#"},  default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  validates :title, presence: true, length: {minimum: 10, maximum: 120}
  validates :body, presence: true, length: {minimum: 100}

  acts_as_votable

  self.per_page = 10

  def self.search(text)
    where('lower(title) LIKE ? OR lower(body) LIKE ?',
      "%#{text.downcase}%", "%#{text.downcase}%")
  end

  private
    def set_description
      self.description = body[0..120]
    end

    def set_title
      self.title = title.downcase
    end
end
