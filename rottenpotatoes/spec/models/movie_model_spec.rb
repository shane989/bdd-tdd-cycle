require 'spec_helper'

describe Movie do
    it "should return all ratings" do
        Movie.all_ratings.should eq(%w(G PG PG-13 NC-17 R))
    end
    
    it "should return list of movies with the same director" do
        Movie.create({:title => "Pulp Fiction", :rating => 'R', :director => "Quentin Tarantino", :release_date => "1994-10-14"})
        Movie.create({:title => "The Hateful Eight", :rating => 'R', :director => "Quentin Tarantino", :release_date => "2015-12-25"})
        
        movies = Movie.movies_with_director("Quentin Tarantino")
        movies[0].title.should eq('Pulp Fiction')
        movies[1].title.should eq('The Hateful Eight')
    end
end