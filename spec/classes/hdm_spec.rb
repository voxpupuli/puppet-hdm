# frozen_string_literal: true

require 'spec_helper'

describe 'hdm' do
  on_supported_os.each do |os, os_facts|
    context "on #{os} using docker" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
    end
    context "on #{os} using puppet ruby" do
      let(:facts) { os_facts }
      let(:params) do
        { 'method' => 'puppet-ruby', }
      end

      it { is_expected.to compile }
    end
  end
end
