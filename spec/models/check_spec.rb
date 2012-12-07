require 'spec_helper'

describe Check do
  it { should belong_to :user }
  it { should belong_to :beer }

  it { should validate_presence_of :user }
  it { should validate_presence_of :beer }

  it { should have_db_index([:user_id, :beer_id])}

end

