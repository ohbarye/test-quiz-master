require 'rails_helper'

describe QuestionsHelper do
  describe 'is_answer_blank?' do
    context 'answer is blank' do
      it 'return true and set message.' do
        @user_answer = ''
        expect(is_answer_blank?).to be true
        expect(flash[:danger]).to eq 'Please input your answer.'
      end
    end

    context 'answer is not blank' do
      it 'return false and set no message.' do
        @user_answer = 'Tokyo'
        expect(is_answer_blank?).to be false
        expect(flash[:danger]).to eq nil
      end
    end
  end

  describe 'is_answer_correct?' do
    before(:each) { @question = Question.new(answer: "Tokyo") }

    context 'answer is correct.' do
      it 'return true and set no message.' do
        @user_answer = 'Tokyo'
        expect(is_answer_correct?).to be true
        expect(flash[:warning]).to eq nil
      end
    end

    context 'answer is not correct.' do
      it 'return false and set message.' do
        @user_answer = 'Osaka'
        expect(is_answer_correct?).to be false
        expect(flash[:warning]).to eq 'Wrong answer... Try again!'
      end
    end
  end
end
