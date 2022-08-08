# frozen_string_literal: true

require 'spec_helper'

describe 'hdm' do
  on_supported_os.each do |os, os_facts|
    context "on #{os} using docker" do
      let(:facts) { os_facts }
      let(:params) do
        {
          'method' => 'docker',
        }
      end

      it { is_expected.to compile.with_all_deps }
    end
  end
end
