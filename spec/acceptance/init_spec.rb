# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'hdm' do
  context 'with default values' do
    it_behaves_like 'an idempotent resource' do
      let(:manifest) do
        <<-PUPPET
      include hdm
        PUPPET
      end
    end
  end
end
