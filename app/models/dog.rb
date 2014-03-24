class Dog < ActiveRecord::Base
has_many :dog_pictures, :dependent => :destroy
accepts_nested_attributes_for :dog_pictures, :allow_destroy => :true

attr_accessor :years
attr_accessor :months

before_validation :set_colors
before_validation :set_personality

validates :name, presence: true,  :length => { minimum: 2, maximum: 20 }, uniqueness: true
validates :status, inclusion: { :in => Status.all.map {|s| s.description } }
validates :sex, inclusion: { in: ["Macho", "Hembra"] }
validate  :validate_age
validate  :validate_admission
validates :weight, numericality: { greater_than_or_equal_to: Size.minimum("low"), less_than_or_equal_to: Size.maximum("high") }
validate  :validate_colors
validate  :validate_personality
validates :story, presence: true,  :length => { minimum: 20 }

after_validation :set_birthdate

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

  def validate_age
    errors.add("la edad", "es invalida.") unless years.to_i > 0 || (years.to_i == 0 && months.to_i > 0)
  end

  def validate_admission
    errors.add("la fecha de admision", "es invalida.") unless self.admission <= Time.now.to_date
  end

  def validate_colors
    cs = self.colors.split(",")
    errors.add("los colores", "no son validos") unless cs.size > 0
    valid_colors = Color.all.map {|c| c.name }
    errors.add("los colores", "no son validos") unless cs.all? {|c| valid_colors.include? c}
  end


  def validate_personality
    self.personality.split(",").each do |p|
      errors.add("#{p}", "no es un atributo de personalidad valido.") unless (Personality.all.map {|p| p.description}).include? p
    end
  end
end
