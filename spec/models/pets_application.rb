require 'rails_helper'

describe PetsApplication, type: :model do
  describe "validations" do
    it { should belong_to :pet}
    it { should belong_to :application}
  end
end
