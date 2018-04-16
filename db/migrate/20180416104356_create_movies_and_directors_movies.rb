class CreateMoviesAndDirectorsMovies < ActiveRecord::Migration

	 def up
    create_table :movies do |t|
      t.string :title, :limit => 255, :null => false
      t.integer :producer_id, :null => false
      t.datetime :produced_at
      t.string :serial_number, :limit => 5, :unique => true
      t.text :blurb
      t.integer :length
      t.float :price
      t.timestamps
  end
      create_table :directors_movies do |t|
      t.integer :director_id, :null => false
      t.integer :movie_id, :null => false
      t.timestamps
    end

    say_with_time 'Adding foreing keys' do
      # Add foreign key reference to directors_movies table
      execute 'ALTER TABLE directors_movies ADD CONSTRAINT fk_directors_movies_directors
              FOREIGN KEY (director_id) REFERENCES directors(id) ON DELETE CASCADE'      
      execute 'ALTER TABLE directors_movies ADD CONSTRAINT fk_directors_movies_movies
              FOREIGN KEY (movie_id) REFERENCES movies(id) ON DELETE CASCADE'
      # Add foreign key reference to producers table
      execute 'ALTER TABLE movies ADD CONSTRAINT fk_movies_producers
              FOREIGN KEY (producer_id) REFERENCES producers(id) ON DELETE CASCADE'
    end
  end

  def self.down
    drop_table :movies
    drop_table :directors_movies
  end
end
