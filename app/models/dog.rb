class Dog < ActiveRecord::Base
  has_many :dog_pictures, :dependent => :destroy
  accepts_nested_attributes_for :dog_pictures, :allow_destroy => :true, :reject_if => lambda { |a| !a.has_key?(:id) && a[:data].blank? }

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

  def self.search(params)
    if params
      #Dog.where(condition(params))
      find(:all, :conditions => build_conditions(params))
      #find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      Dog.all
    end
  end

private

  def self.build_conditions(params)
    conditions = []
    if provided? params, :name
      conditions << "name LIKE '%#{params[:name]}%'"
    end
    if provided? params, :status
      conditions << "status = '#{params[:status]}'"
    end
    if provided? params, :sex
      conditions << "sex = '#{params[:sex]}'"
    end
    if provided? params, :age
      puppy = 6.months.ago.to_date
      young_adult = 2.years.ago.to_date
      adult = 6.years.ago.to_date
      case params[:age]
      when "Cachorro"
        conditions << "birthdate >= '#{puppy}'"
      when "Joven adulto"
        conditions << "birthdate <  '#{puppy}'"
        conditions << "birthdate >= '#{young_adult}'"
      when "Adulto"
        conditions << "birthdate <  '#{young_adult}'"
        conditions << "birthdate >= '#{adult}'"
      when "Adulto mayor"
        conditions << "birthdate < '#{adult}'"
      end
    end
    if provided? params, :size
      size = Size.find(params[:size])
      p size
      conditions << "weight >= #{size[:low]}"
      conditions << "weight <  #{size[:high]}"
    end
    if provided? params, :colors
      params[:colors].gsub(/[\"\[\]\s]/, "").split(',').each do |c|
        conditions << "colors LIKE '%#{c}%'"
      end
    end
    if provided? params, :personality
      params[:personality].gsub(/[\"\[\]\s]/, "").split(',').each do |c|
        conditions << "personality LIKE '%#{c}%'"
      end
    end
    puts "BUSCANDO CON #{conditions * " AND "}"
    conditions * " AND "
  end

  def self.provided?(hash, key)
    hash.has_key?(key) && !hash[key].blank?
  end

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
