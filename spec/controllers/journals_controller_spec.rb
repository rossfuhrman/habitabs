require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe JournalsController do
  login_user

  # This should return the minimal set of attributes required to create a valid
  # Journal. As you add validations to Journal, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { :entry => "The journal entry", :date => Time.current.to_date, :user_id => 1 } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # JournalsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all journals as @journals" do
      journal = Journal.create! valid_attributes
      get :index, {}, valid_session
      assigns(:journals).should eq([journal])
    end
  end

  describe "GET show" do
    it "assigns the requested journal as @journal" do
      journal = Journal.create! valid_attributes
      get :show, {:id => journal.to_param}, valid_session
      assigns(:journal).should eq(journal)
    end
  end

  describe "GET new" do
    it "assigns a new journal as @journal" do
      get :new, {}, valid_session
      assigns(:journal).should be_a_new(Journal)
    end
  end

  describe "GET edit" do
    it "assigns the requested journal as @journal" do
      journal = Journal.create! valid_attributes
      get :edit, {:id => journal.to_param}, valid_session
      assigns(:journal).should eq(journal)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Journal" do
        expect {
          post :create, {:journal => valid_attributes}, valid_session
        }.to change(Journal, :count).by(1)
      end

      it "assigns a newly created journal as @journal" do
        post :create, {:journal => valid_attributes}, valid_session
        assigns(:journal).should be_a(Journal)
        assigns(:journal).should be_persisted
      end

      it "redirects to the created journal" do
        post :create, {:journal => valid_attributes}, valid_session
        response.should redirect_to(Journal.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved journal as @journal" do
        # Trigger the behavior that occurs when invalid params are submitted
        Journal.any_instance.stub(:save).and_return(false)
        post :create, {:journal => { :user_id => 1 }}, valid_session
        assigns(:journal).should be_a_new(Journal)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Journal.any_instance.stub(:save).and_return(false)
        post :create, {:journal => { :user_id => 1 }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested journal" do
        journal = Journal.create! valid_attributes
        # Assuming there are no other journals in the database, this
        # specifies that the Journal created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Journal.any_instance.should_receive(:update).with({ "entry" => "The journal entry", "user_id" => 1  })
        put :update, {:id => journal.to_param, :journal => { "entry" => "The journal entry", "user_id" => 1  }}, valid_session
      end

      it "assigns the requested journal as @journal" do
        journal = Journal.create! valid_attributes
        put :update, {:id => journal.to_param, :journal => valid_attributes}, valid_session
        assigns(:journal).should eq(journal)
      end

      it "redirects to the journal" do
        journal = Journal.create! valid_attributes
        put :update, {:id => journal.to_param, :journal => valid_attributes}, valid_session
        response.should redirect_to(journal)
      end
    end

    describe "with invalid params" do
      it "assigns the journal as @journal" do
        journal = Journal.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Journal.any_instance.stub(:save).and_return(false)
        put :update, {:id => journal.to_param, :journal => { :user_id => 1 }}, valid_session
        assigns(:journal).should eq(journal)
      end

      it "re-renders the 'edit' template" do
        journal = Journal.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Journal.any_instance.stub(:save).and_return(false)
        put :update, {:id => journal.to_param, :journal => { :user_id => 1 }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested journal" do
      journal = Journal.create! valid_attributes
      expect {
        delete :destroy, {:id => journal.to_param}, valid_session
      }.to change(Journal, :count).by(-1)
    end

    it "redirects to the journals list" do
      journal = Journal.create! valid_attributes
      delete :destroy, {:id => journal.to_param}, valid_session
      response.should redirect_to(journals_url)
    end
  end

end
