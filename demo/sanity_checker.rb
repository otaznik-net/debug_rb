class SanityChecker
  def self.am_i_sane?
    [true,false].sample
  end
end

class Time
  class << self
    alias_method :real_now, :now
    def now
      real_now - 86400
    end
  end
end

