class Department < ActiveRecord::Base
    has_many :representatives
    attr_accessor :academic_unit_name, :college, :state

  def self.all_states
    %w(1 2 3 4)
  end
end
