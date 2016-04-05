class Topic < ActiveRecord::Base
    has_many :posts, dependent: :destroy
    has_many :sponsoredposts
    has_many :labelings, as: :labelable
    has_many :labels, through: :labelings
    has_many :comments
    
    validates :name, length: { minimum: 5 }, presence: true
    validates :description, length: {minimum: 15}, presence: true
end
