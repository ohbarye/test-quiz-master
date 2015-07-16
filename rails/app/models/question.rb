class Question < ActiveRecord::Base

  validates_presence_of :question
  validates_presence_of :answer

  def is_correct?(submission)
    normalize(self.answer) == normalize(submission)
  end

  private

  def normalize(str)
    number_to_word(
      remove_extra_white_spaces(str.downcase())
    )
  end

  def number_to_word(str)
    str.gsub(/\d/) { |num| num.to_i.to_words }
  end

  def remove_extra_white_spaces(str)
    str.strip.squeeze(' ')
  end

end
