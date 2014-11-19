require 'spec_helper'
describe 'challenge' do

  context 'with defaults for all parameters' do
    it { should contain_class('challenge') }
  end
end
