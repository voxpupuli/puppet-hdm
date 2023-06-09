# frozen_string_literal: true

require 'spec_helper'

describe 'hdm' do
  on_supported_os.each do |os, os_facts|
    context "on #{os} using docker" do
      let(:facts) { os_facts }
      let(:params) do
        {
          'method' => 'docker',
          'version' => '1.0.1',
        }
      end

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('docker') }
      it { is_expected.to contain_file('/etc/hdm/hdm.yml').with(content => %r{hiera_config_file: "hiera.yaml"}) }
    end
  end
end
