class DogPicture < ActiveRecord::Base
  belongs_to :dog

  attr_accessor :x1, :x2, :y1, :y2

  before_save :decode_data

  private
    def decode_data
      puts ">>>>>>>>>>>>>>>>>>>>>>>#{self.data.class}"
      self.data = base64UrlDecode(self.data.split(',')[1])
    end

    def base64UrlDecode(data)
      data.tr('-_','+/').unpack('m')[0]
    end
end
