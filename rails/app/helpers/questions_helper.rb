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

  def show_only_title(question)
    lines = question.split("\n")
    lines[0].strip
  end

  def format_question(question)
    simple_format(
      sanitize(question, tags: %w(b i h1 h2 h3 h4 h5 h6))
    )
  end
end
