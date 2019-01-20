require 'rails_helper'

RSpec.describe Log, type: :model do
  it { should validate_presence_of(:project_id) }
  it { should validate_presence_of(:hours) }
  it { should validate_presence_of(:log_date) }
end
