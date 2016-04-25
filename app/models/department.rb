class Department < ActiveRecord::Base
    has_many :representatives , dependent: :destroy

    def self.all_states
      %w(1 2 3 4)
    end
  

end
