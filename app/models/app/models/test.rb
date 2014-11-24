require 'sqlite3'
require_relative "state"
require_relative "party"
require_relative "title"
require_relative "congress_member"

def findMembersInState
  print "Which state (ID)? "
  input = gets.chomp.to_i

  members = CongressMember.where(state_id: input)
  titles = [
    members.where(title_id: 1),
    members.where(title_id: 2),
    members.where(title_id: 3),
    members.where(title_id: 4)
  ]

  titles.each do |title|
    if title.count > 0
      puts Title.find(title.first.title_id).name
      puts "==="
      title.each do |member|
        puts member.firstname << " " << member.lastname << " (" << Party.find(member.party_id).name << ")"
      end
      puts ""
    end
  end
end

def findTitlesByGender
  print "Which gender (M/F)? "
  input = gets.chomp.upcase

  # p com = CongressMember.where(title_id: 1).count
  # p del = CongressMember.where(title_id: 2).count
  # p sep = CongressMember.where(title_id: 3).count
  # p sen = CongressMember.where(title_id: 4).count

  members = CongressMember.where(gender: input)

  titles = [
    members.where(title_id: 1),
    members.where(title_id: 2),
    members.where(title_id: 3),
    members.where(title_id: 4)
  ]

  puts "#{input} all: #{members.count} (" << (members.count*100/CongressMember.all.count).to_s << "%)"

  titles.each do |title|
    if title.count > 0
      puts "#{input} " << Title.find(title.first.title_id).name << ": #{title.count} (" << (title.count*100/members.count).to_s << "%)"
    end
  end
end

def findAllSensReps
  sens = CongressMember.where(title_id: Title.where(name: "Sen"))
  reps = CongressMember.where(title_id: Title.where(name: "Rep"))
end

  # array_of_sorted_state = []

  # allstates = CongressMember.select(:id, :state_id, :title_id)
  # reps = allstates.select("count(:title_id) AS title_count").where(title_id: 3)
  # p reps.title_count



  # sort_hash = {}
  # State.all.each do |s|
  #   sort_hash[s.name] = CongressMember.where(state_id: s.id, title_id: 3).count + CongressMember.where(state_id: s.id, title_id: 4).count
  # end

  # p sort_hash



def findAllStatesSorted
  statehash = CongressMember.where(in_office: 1).group(:state_id).count
  statearray = statehash.sort_by {|k,v| v}.reverse
  repcount = CongressMember.where(in_office: 1, title_id: 3).group(:state_id).count
  sencount = CongressMember.where(in_office: 1, title_id: 4).group(:state_id).count

  statearray.each do |k|
    p State.find(k[0]).name << ", Rep: " << repcount[k[0]].to_s << ", Sen: " << sencount[k[0]].to_s
  end
end


def findAllInOffice
  puts Title.find(4).name << ": " << CongressMember.where(title_id: 4, in_office:1).count.to_s
  puts Title.find(3).name << ": " << CongressMember.where(title_id: 3, in_office:1).count.to_s
end