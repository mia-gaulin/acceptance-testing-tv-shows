require "spec_helper"

describe TelevisionShow do
  let(:show) { TelevisionShow.new("Firefly", "Fox", "2002", "Fantasy", "Space pirates") }
  let(:show2) { TelevisionShow.new("Firefly", "Fox", "2002", "Fantasy") }

 describe ".new" do
   it "should take a title, network, starting year, genre, and synopsis as arguments" do
     expect(show).to be_a(TelevisionShow)
   end

   it "should have a reader for all arguments" do
     expect(show.title).to eq("Firefly")
   end
 end

 describe ".all" do
  it "displays an array of hashes containing TV show information" do
    CSV.open('television-shows.csv', 'a') do |file|
      title = "Friends"
      network = "NBC"
      starting_year = "1994"
      synopsis = "Six friends living in New York city"
      genre = "Comedy"
      data = [title, network, starting_year, synopsis, genre]
      file.puts(data)
    end

    all = TelevisionShow.all
    expect(all).to be_an(Array)
    expect(all.count).to eq 1
    expect(all.first[:title]).to eq("Friends")
  end
 end

 describe "#errors" do
   it "should return an empty array on a newly initialized object" do
     expect(show.errors).to be_a(Array)
     expect(show.errors).to be_empty
   end
 end

 describe "#valid?" do
   it "should return true if the object is valid" do
     expect(show.valid?).to eq true
   end

   it "should return false if the object is not valid" do
     expect(show2.valid?).to eq false
   end

   it "should return an empty array when calling #errors if object is valid" do
     expect(show.errors).to be_empty
   end

   it "should return an array containing 'Please fill in all required fields' when calling #errors if object is invalid" do
     expect(show2.errors).to be_a(Array)
     expect(show2.errors).to include("Please fill in all required fields")
   end

   it "should return an array containing 'The show as already been added' when calling #errors if the show has already been added" do
     expect(show2.errors).to include("The show has already been added")
   end

   it "should return an array containing both error message strings when calling #errors if the show fails both validations" do
     expect(show2.errors).to include("Please fill in all required fields")
     expect(show2.errors).to include("The show has already been added")
   end
 end

 describe "#save" do
   it "should return true and add the attributes of the object to the csv if #valid? returns true" do
     expect(show.save).to eq true
   end

   it "should return false if #valid? is false" do
     expect(show2.save).to eq false
   end
 end
end
