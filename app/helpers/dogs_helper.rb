module DogsHelper

  def age_in_months(dob)
    now = Time.now.utc.to_date
    diff = now -  dob
    (diff / 30.4375).round
  end

  def years(age)
    age / 12
  end

  def months(age)
    age % 12
  end

  def color_name(color_id)
    c = Color.find_by id:color_id
    (c && c.name) || I18n.t('undefined_color', scope: 'dog')
  end

  def get_top_dogs(count)
    Dog.take(count) * 3
  end
end
