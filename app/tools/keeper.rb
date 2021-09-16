require 'singleton'

class Keeper
  include Singleton

  def initialize
    @storage = {}
  end

  def get(key)
    @storage[key]
  end

  def store(stuff={})
    @storage.merge!(stuff)
  end

  def keys
    @storage.keys
  end

  def self.get(*args)
    Keeper.instance.get(*args)
  end

  def self.store(*args)
    Keeper.instance.store(*args)
  end

  def self.keys
    Keeper.instance.keys
  end

  def self.method_missing(m, *_, &_)
    Keeper.get(m)
  end
end
