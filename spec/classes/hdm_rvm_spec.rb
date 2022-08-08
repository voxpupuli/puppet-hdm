# frozen_string_literal: true

require 'spec_helper'

describe 'hdm' do
  on_supported_os.each do |os, os_facts|
    context "on #{os} using rvm" do
      let(:facts) { os_facts }
      let(:params) do
        {
          'method' => 'rvm',
        }
      end

      it { is_expected.to compile }
    end
  end
end
