require 'spec_helper'

describe MoviesController do
    describe "pages" do
        
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
        
        it "should go to new movie page" do
            {:get => new_movie_path}.should route_to(
                :controller => "movies",
                :action => "new"
                )
            end
        it "should go to the show page" do
            {:get => movie_path(1)}.should route_to(
                :controller => "movies",
                :action => "show",
                :id => "1"
            )
        end
        
         it "should go to the similar movies page" do
            {:get => similar_movies_path(1)}.should
            route_to(
                :controller => "movies",
                :action => "similar_movies",
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
            @movie1 = Movie.create :title => "Pulp Fiction", :director => "Quentin Tarantino", :release_date => "1994-10-14"
            @movie2 = Movie.create :title => "The Hateful Eight", :director => "Quentin Tarantino", :release_date => "2015-12-25"
            @movie3 = Movie.create :title => "Star Wars", :director => nil, :release_date => "1979-05-25"
        end
        
        it "should show movie details" do
            get :show, :id => @movie1
            assigns(:movie).should == @movie1
        end
        
        it "should sort by title" do
            get :index, :sort => 'title'
            session[:sort].should == 'title'
        end
        
         it "should sort by release date" do
            get :index, :sort => 'release_date'
            session[:sort].should == 'release_date'
        end
        
        it "should show movie by certain ratings" do
            get :index, :ratings => ['G', 'PG', 'R']
            session[:ratings].should == ['G', 'PG', 'R']
        end
        
        it "should not show similar movies when there are none" do
            get :show, :id => @movie3
            assigns(:similar_movies).should == nil
            
        end
            
         it "should delete movie" do
            delete :destroy, :id => @movie1
            flash[:notice].should =~ /deleted/i
        end
        
        it "should display ''Pulp Fiction' has no director info'" do
            get :similar_movies, :id => @movie3
            flash[:notice].should =~ /no director info/i
        end
        
        
    end
end