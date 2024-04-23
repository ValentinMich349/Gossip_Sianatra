require 'csv'
class Gossip
  attr_accessor :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end

# enregistre un element dans un fichier CSV
  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

# recupe les elemts dans une array
  def self.all
    all_gossips = []
    CSV.read("db/gossip.csv").each do |row| 
      all_gossips.push(Gossip.new(row[0], row[1]))
    end
    return all_gossips
  end

# recup 1 elm avec son id 
  def self.find(id)
    searched_gossip = []
    CSV.open('db/gossip.csv').each do |row|
      searched_gossip.push(Gossip.new(row[0], row[1]))
    end
    return searched_gossip[id.to_i - 1]
  end

# modif elmt (tout les params) grace id
  def self.update(id, updated_author, updated_content)
    id = id.to_i - 1
    new_list_gossips = CSV.read("db/gossip.csv")
    new_list_gossips[id][0] = updated_author
    new_list_gossips[id][1] = updated_content
    CSV.open("db/gossip.csv", "w+") do |csv|
      new_list_gossips.each do |updated_row|
        csv << updated_row
      end
    end
  end
end
