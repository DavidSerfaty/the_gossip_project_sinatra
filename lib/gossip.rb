
require 'csv'

class Gossip
  attr_accessor :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.update(id, new_author, new_content)
    all_gossips = Array.new
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end

    gossip = all_gossips[id.to_i]

    gossip.author = new_author
    gossip.content = new_content
    all_gossips[id.to_i] = gossip

    CSV.open("./db/gossip.csv", "w") do |csv_line|
      all_gossips.each do |gossip|
        csv_line << [gossip.author, gossip.content]
      end
    end
  end

  def self.find(gossip)
    all[gossip.to_i]
  end

  def self.all
    all_gossips = Array.new
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

end
