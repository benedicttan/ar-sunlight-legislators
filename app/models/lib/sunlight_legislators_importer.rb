require 'csv'
require_relative '../app/models/congress_member'
require_relative '../app/models/state'
require_relative '../app/models/title'
require_relative '../app/models/party'
require_relative 'datatreatment'



class SunlightLegislatorsImporter


  def self.import
    filename = File.dirname(__FILE__) + "/../db/data/legislators.csv"
    include TreatData
    TreatData.import(filename)
    columns_we_need = ["title","firstname","middlename","lastname","party","state","in_office","gender","phone","fax","website","webform","twitter_id","birthdate"]
    csv = CSV.new(File.open(filename), :headers => true)
    csv.each do |row|
      row_hashed = row.to_hash
      attribute_hash = Hash.new
      columns_we_need.each do |field|
        attribute_hash[field] = row_hashed[field]
        # TODO: begin
        # raise NotImplementedError, "TODO: figure out what to do with this row and do it!"
        # TODO: end
      end
      # insert code for treating state
      attribute_hash["state_id"] = State.find_by(name: attribute_hash["state"]).id
      attribute_hash["party_id"] = Party.find_by(name: attribute_hash["party"]).id
      attribute_hash["title_id"] = Title.find_by(name: attribute_hash["title"]).id

      attribute_hash.delete("state")
      attribute_hash.delete("party")
      attribute_hash.delete("title")
      # p attribute_hash
      # p attribute_hash["state"]
      # p State.find_by(name: attribute_hash[:state]).id
      congress_member = CongressMember.create!(attribute_hash)
      # return
    end
  end
end

# test = SunlightLegislatorsImporter.import("legislators.csv")
# IF YOU WANT TO HAVE THIS FILE RUN ON ITS OWN AND NOT BE IN THE RAKEFILE, UNCOMMENT THE BELOW
# AND RUN THIS FILE FROM THE COMMAND LINE WITH THE PROPER ARGUMENT.
# begin
#   raise ArgumentError, "you must supply a filename argument" unless ARGV.length == 1
#   SunlightLegislatorsImporter.import(ARGV[0])
# rescue ArgumentError => e
#   $stderr.puts "Usage: ruby sunlight_legislators_importer.rb <filename>"
# rescue NotImplementedError => e
#   $stderr.puts "You shouldn't be running this until you've modified it with your implementation!"
# end
