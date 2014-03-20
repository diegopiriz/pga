class Dog < ActiveRecord::Base

  validates :sex, inclusion: { in: ["Macho", "Hembra"]}

  attr_accessor :years
  attr_accessor :months

  before_validation :set_birthdate
  before_validation :set_colors
  before_validation :set_personality

  private
    def set_birthdate
      self.birthdate = Time.now - years.to_i.years - months.to_i.months
    end

    def set_colors
      self.colors = colors.gsub(/[\"\[\]\s]/, "")
    end

    def set_personality
      self.personality = personality.gsub(/[\"\[\]\s]/, "")
    end
end
