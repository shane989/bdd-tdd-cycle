require 'spec_helper'

describe MoviesController do
    describe "pages" do
        it "should go to similar movies page" do
            {:get => similar_movies_path(1)}.should
            route_to(
                :controller => "movies",
                :action => "similar_movies",
                :id => "1"
            )
        end
        
  
        
        it "should go to the index page" do
            {:get => "/movies"}.should
            route_to(
                :controller => "movies",
                :action => "index"
                )
            end
            
        it "should go to edit page" do
            {:get => edit_movie_path(1)}.should route_to(
                :controller => "movies",
                :action => "edit",
                :id => "1"
            )
        end
    end
     describe "methods" do
        it "should create new movie" do
            Movie.stub(:create).and_return(double(Movie))
            post :create
            flash[:notice].should =~ /successfully created/i
        end
        
        before(:each) do
            @movie = Movie.create :title => "Alien", :director => nil, :release_date => "1979-05-25"
        end
        
        it "should show movie details" do
            get :show, :id => @movie
            assigns(:movie).should == @movie
        end
    end
end