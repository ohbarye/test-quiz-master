require 'rails_helper'

RSpec.describe QuestionsController, :type => :controller do

  describe 'GET #index' do
    before :each do
      get :index
    end

    it 'renders template of index.' do
      expect(response).to render_template :index
    end

    it 'loads all questions.' do
      question = create(:question)
      expect(assigns(:questions)).to eq([question])
    end
  end

  describe 'GET #new' do
    before :each do
      get :new
    end

    it 'renders template of new.' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    it 'creates new question.' do
      expect{
        post :create, question: attributes_for(:question)
      }.to change(Question, :count).by(1)
    end

    it 'redirects to root_path and show flash message.' do
      post :create, question: attributes_for(:question)
      expect(response).to redirect_to root_path
      expect(flash[:info]).to eq('Question created successfully.')
    end
  end

  describe 'GET #edit' do
    before :each do
      @question = create(:question)
      get :edit, id: @question
    end

    it 'renders template of edit.' do
      expect(response).to render_template :edit
    end

    it 'loads specified question by :id.' do
      expect(assigns(:question)).to eq(@question)
    end
  end

  describe 'POST #update' do
    before :each do
      @question = create(:question)
    end

    it 'updates question collectly.' do
      old_question = @question.question
      old_answer   = @question.answer
      new_question  = 'Who is the CEO of Google?'
      new_answer    = 'Lawrence Edward "Larry" Page'
      change{
        post :update, id: @question, question: attributes_for(:question, question: new_question, answer: new_answer)
        @question.reload()
      }.to change { @question.question }.to(new_question).from(old_question)
      .and change { @question.answer   }.to(new_answer).from(old_answer)
    end

    it 'redirects to root_path and show flash message.' do
      post :update, id: @question, question: attributes_for(:question)
      expect(response).to redirect_to root_path
      expect(flash[:info]).to eq('Question saved successfully.')
    end
  end

  describe 'GET #show' do
    before :each do
      @question = create(:question)
      get :show, id: @question
    end

    it 'renders template of show.' do
      expect(response).to render_template :show
    end

    it 'loads specified question by :id.' do
      expect(assigns(:question)).to eq(@question)
    end
  end

  describe 'POST #answer' do
    before :each do
      @question = create(:question)
    end

    it 'renders template of show.' do
      post :answer, id: @question, question: attributes_for(:question), answer: {'user_answer'=>''}
      expect(response).to render_template :show
    end

    context 'when submitted answer is correct.' do
      it 'shows flash message.' do
        post :answer, id: @question, question: attributes_for(:question), answer: {'user_answer'=>@question.answer}
        expect(flash[:success]).to eq("That's correct!")
      end
    end

    context 'when submitted answer is wrong.' do
      it 'shows flash message.' do
        post :answer, id: @question, question: attributes_for(:question), answer: {'user_answer'=>'Wrong answer'}
        expect(flash[:warning]).to eq('Wrong answer... Try again!')
      end
    end

    context 'when submitted answer is missing.' do
      it 'shows flash message.' do
        post :answer, id: @question, question: attributes_for(:question), answer: {'user_answer'=>''}
        expect(flash[:danger]).to eq('Please input your answer.')
      end
    end
  end
end
