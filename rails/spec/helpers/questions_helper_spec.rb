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
      it 'returns true and set no message.' do
        @user_answer = 'Tokyo'
        expect(is_answer_correct?).to be true
        expect(flash[:warning]).to eq nil
      end
    end

    context 'answer is not correct.' do
      it 'returns false and set message.' do
        @user_answer = 'Osaka'
        expect(is_answer_correct?).to be false
        expect(flash[:warning]).to eq 'Wrong answer... Try again!'
      end
    end
  end

  describe 'show_only_title' do
    it 'returns the 1st line of text.' do
      text = <<-EOS
        line 1
        line 2
        line 3
      EOS
      expect(show_only_title(text)).to eq 'line 1'
    end
  end

  describe 'format_question' do
    let(:text) {
      text = <<-EOS.strip_heredoc
        <h1>Heading 1</h1>
        <h2>Heading 2</h2>
        <h3>Heading 3</h3>
        <h4>Heading 4</h4>
        <h5>Heading 5</h5>
        <h6>Heading 6</h6>
        <div>
          <span>It is <b>bold</b>.</span>
          <span>It is <i>italic</i>.</span>
        </div>
      EOS
    }

    it 'adds line break tags.' do
      expect(format_question(text)).to include '<br />'
    end

    it 'leaves sqecified tags.' do
      expect(format_question(text))
         .to include('<h1>').and include('</h1>')
        .and include('<h2>').and include('</h2>')
        .and include('<h3>').and include('</h3>')
        .and include('<h4>').and include('</h4>')
        .and include('<h5>').and include('</h5>')
        .and include('<h6>').and include('</h6>')
        .and include('<b>').and include('</b>')
        .and include('<i>').and include('</i>')
    end

    it 'removes unsqecified tags.' do
      expect(format_question(text)).not_to include('<div>')
      expect(format_question(text)).not_to include('</div>')
      expect(format_question(text)).not_to include('<span>')
      expect(format_question(text)).not_to include('</span>')
    end
  end
end
