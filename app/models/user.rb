class User < ActiveRecord::Base
    # has_many :reviews
    # has_many :bars, through: :reviews
    has_many :bar_crawls

    # has_many :bars, foreign_key: 'owner_id'
    has_many :reviews
    has_many :bars, through: :reviews
    # , source: :bar

    # has_many :favorite_bars
    # has_many :liked_bars, through: :favorite_bars, source: :bar

    # has_many :favorite_bars
    # has_many :bars, through: :favorite_bars
    # alias_method :favorite_bars, :favorite_bars


    def add_review(id)
        self.find(id).
        Review.create(user_id: user_id, bar_id: self.id)
    end
end