class QuestionsController < ApplicationController
  include QuestionsHelper

  before_filter :find_question, only: [:show, :edit, :update, :answer]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new question_params
    if @question.save
      redirect_to root_path, flash: {info: 'Question created successfully.'}
    else
      render :new
    end
  end

  def update
    if @question.update_attributes question_params
      redirect_to root_path, flash: {info: 'Question saved successfully.'}
    else
      render :edit
    end
  end

  def answer
    flash.now[:success] = "That's correct!" if is_valid_answer?
    render :show
  end

  private

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:question, :answer)
  end
end
