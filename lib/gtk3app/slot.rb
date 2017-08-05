module Gtk3App
module Slot
  using Rafini::Array

  def self.dbm
    SDBM.open(CONFIG[:SlotsDBM]){|db|yield(db)}
  end

  def self.numbers
    1.upto(CONFIG[:Slots]){|n|yield(n.to_s)}
  end

  def self.get
    Slot.dbm do |db|
      Slot.numbers do |slot|
        unless db[slot]
          db[slot]=$$.to_s
          return slot.to_i
        end
      end
    end
    return nil
  end

  def self.release(slot)
    Slot.dbm{|db|db.delete(slot.to_s)}
  end

  def self.gc
    Thread.new do
      Slot.dbm do |db|
        Slot.numbers do |slot|
          if pid = db[slot]
            db.delete(slot) unless File.directory?("/proc/#{pid}")
          end
        end
      end
    end
  end
  Slot.gc
end
end
