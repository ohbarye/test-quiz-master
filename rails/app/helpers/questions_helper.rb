module QuestionsHelper
  def is_valid_answer?
    @user_answer = params[:answer][:user_answer]
    return false if is_answer_blank?
    return false if !is_answer_correct?
    return true
  end

  private
  
  def is_answer_blank?
    if @user_answer.blank?
      flash.now[:danger] = 'Please input your answer.'
      return true
    else
      return false
    end
  end

  def is_answer_correct?
    if @question.is_correct?(@user_answer)
      return true
    else
      flash.now[:warning] = 'Wrong answer... Try again!'
      return false
    end
  end

end
