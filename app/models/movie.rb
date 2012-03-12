class Movie < ActiveRecord::Base
  def self.get_ratings_list
    ['G', 'PG', 'PG-13', 'R']
  end
end
