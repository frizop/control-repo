# spec/classes/profile_apache_spec.rb
require 'spec_helper'
require 'pry'

binding.pry

describe 'profile::base' do
  context 'catalog compile' do
    it { is_expected.to compile.with_all_deps }
  end
end