require 'rails_helper'

describe LocationsController do
  let(:location) { create(:location) }
  let(:params) { {location: {
      name: 'Test 3',
      polygon_coordinates: '-121, 47,-120, 45,-122, 43'
  } } }

  describe "GET #index" do
    it "populates an array of locations" do
      locations = create_list(:location, 5)

      get :index

      expect(assigns(:locations).to_a).to eq locations.to_a
      expect(assigns(:locations).count).to eq locations.count
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "assigns the requested booking to @booking" do
      new_location = location
      get :show, params: {id: new_location.id}
      expect(assigns(:location)).to eq new_location
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "renders the :new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "saves the new location in the database" do
        post :create, params: params
        expect(assigns(:location).errors.keys).to eq []
        expect(response).to redirect_to(location_path(id: assigns(:location).id))
      end
    end

    context "with invalid attributes" do
      it "does not save the new booking in the database" do
        params[:location][:polygon_coordinates] = nil

        post :create, params: params

        expect(assigns(:location).errors.keys).to eq [:area]
        expect(assigns(:location).errors.full_messages[0]).to match /Area can't be blank/m
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "updates the location in the database" do
        new_location = create(:location)
        name = 'New name'
        coordinates = '-121.0,45.0,-120.0,48.0,-122.0,41.0'
        patch :update, params: {
            id: new_location.id,
            location: {
                name: name,
                polygon_coordinates: coordinates
            }
        }

        expect(assigns(:location).errors.keys).to eq []

        expect(assigns(:location).name).to eq name
        expect(assigns(:location).area.coordinates[0].join(',')).to eq coordinates + ',-121.0,45.0'

        expect(response).to redirect_to(location_path(id: new_location.id))
      end
    end

    context "with invalid attributes" do
      it "does not update the booking in the database" do
        new_location = create(:location)
        patch :update, params: {
            id: new_location.id,
            location: {
                name: nil
            }
        }

        expect(assigns(:location).errors.keys).to eq [:name]

        expect(response).to render_template(:edit)
      end
    end
  end

  describe "GET #edit" do
    it "renders the :edit template" do
      get :edit, params: {id: location.id}
      expect(assigns(:location)).to eq location
      expect(response).to render_template(:edit)
    end
  end

  describe "DESTROY #destroy" do
    it "delete booking" do
      delete :destroy, params: {id: location.id}
      expect(assigns(:location)).to eq location
      expect(response).to redirect_to(root_path)
    end
  end
end