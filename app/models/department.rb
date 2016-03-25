class Department < ActiveRecord::Base
    has_many :representatives
    attr_accessible :name, :state

  def self.all_states
    %w(1 2 3 4)
  end
end
