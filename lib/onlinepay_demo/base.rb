module UnionpayLib
  Base = Class.new do
    class << self
      def faraday
        Faraday.new(@@endpoint, :ssl => {:verify => true})
      end
    end
  end
end
