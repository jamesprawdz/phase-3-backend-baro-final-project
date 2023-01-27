class Bar < ActiveRecord::Base
    # has_many :reviews
    # has_many :users, through: :reviews
    # has_many :favorite_bars
    # has_many :users, through: :favorite_bars
    # belongs_to :owner, class_name: "User"
    has_many :reviews
    has_many :users, through: :reviews
    # def owner

    # end

    def average_rating
        self.reviews.average(:star_rating).to_f.round(1)
    end

   
end