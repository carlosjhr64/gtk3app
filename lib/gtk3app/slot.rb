module Gtk3App
module Slot
  using Rafini::Array

  def self.dbm
    SDBM.open(CONFIG[:SLOTS_DBM]){|db|yield(db)}
  end

  def self.numbers
    1.upto(CONFIG[:SLOTS]){|n|yield(n.to_s)}
  end

  def self.get
    alive = Sys::ProcTable.ps.select{|p|p.cmdline=~/\bruby\b.*\bgtk3app\b/}.map{|p|p.pid.to_s}.is(true)
    Slot.dbm do |db|
      Slot.numbers do |slot|
        unless alive[db[slot]]
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

end
end
