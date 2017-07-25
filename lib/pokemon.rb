require 'pry'
class Pokemon
  attr_accessor :name, :type, :db, :id, :hp
  @@all = []
  def initialize (attributes, hp = nil)
    attributes.each {|key, value| self.send(("#{key}="), value)}
    @hp = 60
    @@all << self
  end

  def self.save (name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)",name, type)
  end

  def self.find (id, db)
    # binding.pry

    @name = db.get_first_value("SELECT name FROM pokemon WHERE id = (?)", id)
    @type = db.get_first_value("SELECT type FROM pokemon WHERE id = (?)", id)
    # @hp = db.get_first_value("SELECT hp FROM pokemon WHERE id = (?)", id)

    # binding.pry
    x = {id: id, name: @name, type: @type, db: db}
    Pokemon.new(x)
    # db.execute("INSERT INTO pokemon (hp) VALUES (60) WHERE id = (?)", id)
    # binding.pry
  end

  def alter_hp (hp, db)
    # binding.pry
    db.execute("UPDATE pokemon SET hp = (?) WHERE name = (?)", hp, self.name)
    
  end

  def hp
    @hp = db.get_first_value("SELECT hp FROM pokemon WHERE id = (?)", self.id)
  end
end
