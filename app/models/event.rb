class Event < ApplicationRecord
    validate :different_teams
  
    def different_teams
      errors.add(:base, "Both teams must be different") if name_first_team == name_second_team
    end
  end
  