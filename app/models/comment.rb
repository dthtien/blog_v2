class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article, counter_cache: true

  acts_as_votable
end
