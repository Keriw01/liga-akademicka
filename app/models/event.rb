class Event < ApplicationRecord
    validate :different_teams
  
    def different_teams
      errors.add(:base, "Drużyny biorące udział w spotkaniu muszą być różne") if name_first_team == name_second_team
    end
  end
  