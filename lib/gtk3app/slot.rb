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
    Slot.gc
  end

  def self.gc
    Thread.new do
      uid = Process.uid
      alive = Sys::ProcTable.ps.select{|p|
        p.uid==uid && p.cmdline=~/\bgtk3app\b/
      }.map{|p|p.pid.to_s}.is(true)
      Slot.dbm do |db|
        Slot.numbers do |slot|
          if pid = db[slot]
            db.delete(slot) unless alive[pid]
          end
        end
      end
    end
  end
  Slot.gc
end
end
