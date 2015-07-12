describe WelcomeController do
  context "#index" do
    it 'should render all the questions to the visitor' do
      get :index
      expect(assigns(:questions)).to be_a ActiveRecord::Relation
    end

    it 'should render a form for a new user' do
      get :index
      expect(assigns(:user)).to be_a User
    end
  end
end
