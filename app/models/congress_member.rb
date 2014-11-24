require_relative '../../db/config'
require_relative 'tweet'
require 'twitter'

class CongressMember < ActiveRecord::Base
  has_many :tweets

  def self.findTweets(id)

    tweetsToStore = 10

    client = Twitter::REST::Client.new do |config|
     config.consumer_key        = "vXiOZQtaSj4zPny60EPZtcfOO"
     config.consumer_secret     = "qrA8HLbcDHyJqoVSPxfTsVApRutKNaDUJu3DCQBJMrqBuaWcx1"
     config.access_token        = "81753202-jxJ0gxEJAjcf5s7tqzflQ0TZvPy7ahqafOiFoHRBW"
     config.access_token_secret = "9LIel1Kn9ACo3XLvG7rJuJX0erCL8zE1G631aS50Rw77F"
    end

    member = CongressMember.find(id)
    tweets = client.user_timeline(member.twitter_id).take(5)

    tweets.each do |tweet|
      if Tweet.find_by(twitter_id: tweet.id)
        puts "Tweet exists in database"
      else
        Tweet.create(congress_member_id: id, text: tweet.text, twitter_id: tweet.id)
        puts "Tweet now in database"
      end
    end

  end

end