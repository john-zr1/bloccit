require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(name: "Test", email: "test@example.com", password: "bloccit") }

  describe "attributes" do
    it "should respond to name" do
      expect(user).to respond_to(:name)
    end

    it " should respond to email" do
      expect(user).to respond_to(:email)
    end

    it "should format the user's name" do
      user.name = "bloc user"
      user.save
      expect(user.name).to eq "Bloc User"
    end
  end
end
