class Size < ActiveRecord::Base
  def average
    (low + high) / 2
  end

  def name
    "#{description} (#{low}Kg - #{high}Kg)"
  end
end
