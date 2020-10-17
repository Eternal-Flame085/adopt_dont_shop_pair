require 'rails_helper'

describe Application, type: :model do
  describe "validations" do
    it { should belong_to :user}
    it {should have_many(:pets).through(:pets_applications)}

  end
end
