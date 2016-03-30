Given(/^the following movies exist:$/) do |table|
  table.hashes.each do |hash|
    Movie.create!(hash)
  end
end

Then(/^the director of "(.*?)" should be "(.*?)"$/) do |title, director|
  movie = Movie.find_by_title(title)
  movie.director.should == director
end