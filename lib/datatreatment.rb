require 'csv'
require_relative '../app/models/state'
require_relative '../app/models/title'
require_relative '../app/models/party'

module TreatData
  def self.import(filename)
    columns_we_need = ["state","title","party"]
    states = []
    titles = []
    parties = []
    p "kkkk"
    csv = CSV.new(File.open(filename), :headers => true)
    csv.each do |row|
      row_hashed = row.to_hash
      attribute_hash = Hash.new
      columns_we_need.each do |field|
        attribute_hash[field] = row_hashed[field]
      end
      states << attribute_hash["state"]
      titles << attribute_hash["title"]
      parties << attribute_hash["party"]
    end

    states = states.uniq.sort
    states.each do |state|
      state_entry = State.create!(name:state)
    end

    titles = titles.uniq.sort
    titles.each do |title|
      title_entry = Title.create!(name:title)
    end

    parties = parties.uniq.sort
    parties.each do |party|
      party_entry = Party.create!(name:party)
    end

    # p states
    # p titles
    # p parties

  end

end


# test = TreatState.import("legislators.csv")