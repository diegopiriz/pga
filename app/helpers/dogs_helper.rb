# encoding: utf-8
module DogsHelper
    def top_dogs(n = 6)
      Dog.take(n)
    end

    def diff_in_years(date)
      (date_diff(date) / 365).to_i
    end

    def diff_in_months(date)
      ((date_diff(date) - diff_in_years(date) * 365) / 30).round
    end

    def age(dog)
      years = diff_in_years(dog.birthdate)
      months = diff_in_months(dog.birthdate)
      result = ""
      case years
      when 0
        #pass
      when 1
        result += "1 año"
      else
        result += "#{years} años"
      end
      case months
      when 0
        #pass
      when 1
        result += " y " if years != 0
        result += "1 mes"
      else
        result += " y " if years != 0
        result += "#{months} meses"
      end
      result
    end

    def size(dog)
      Size.where("low <= ?", dog.weight).where("high > ?", dog.weight).take.description
    end

    def sex_symbol(sex)
      if sex == "Macho"
        "&#9794;"
      else
        "&#9792"
      end
    end

    def size_image(dog)
      size_desc = size(dog)
      if "pequeño".casecmp(size_desc) == 0
        "size_small.png"
      elsif "medio".casecmp(size_desc) == 0
        "size_medium.png"
      elsif "grande".casecmp(size_desc) == 0
        "size_large.png"
      else
        "generic_dog.jpg"
      end
    end
          
        

    private 
      def date_diff(date)
        if date
          Time.now.to_date - date
        else
          0
        end
      end
end
