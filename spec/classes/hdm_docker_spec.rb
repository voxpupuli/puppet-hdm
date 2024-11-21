# frozen_string_literal: true

require 'spec_helper'

describe 'hdm' do
  on_supported_os.each do |os, os_facts|
    let(:pre_condition) do
      if facts[:os]['family'] == 'Suse'
        '
          class { "docker":
            acknowledge_unsupported_os => true,
          }
        '
      end
    end

    context "on #{os} using docker" do
      let(:facts) { os_facts }
      let(:params) do
        {
          'method' => 'docker',
          'version' => '1.0.1',
        }
      end

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('hdm::docker') }
      it { is_expected.to contain_class('docker') }
      it { is_expected.to contain_docker__image('ghcr.io/betadots/hdm') }
      it { is_expected.to contain_file('/etc/hdm') }
      it { is_expected.to contain_file('/etc/hdm/certs') }
      it { is_expected.to contain_file('/etc/hdm/db') }
      it { is_expected.to contain_file('/etc/hdm/db/production.sqlite3') }
      it { is_expected.to contain_file('/etc/hdm/database.yml') }
      it { is_expected.to contain_file('/etc/hdm/hdm.yml').with('content' => %r{hiera_config_file: "hiera.yaml"}) }
    end

    context "on #{os} using docker with all parameters" do
      let(:facts) { os_facts }
      let(:params) do
        {
          'method' => 'docker',
          'version' => '3.0.0',
          'puppet_dir' => '/etc/puppetlabs',
          'puppet_code_dir' => '/etc/puppet/code',
        }
      end

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('docker') }
      it { is_expected.to contain_file('/etc/hdm/hdm.yml').with('content' => %r{hiera_config_file: "hiera.yaml"}) }
      it { is_expected.to contain_docker__run('hdm').with('volumes' => %r{/etc/puppetlabs:/etc/puppetlabs:ro}) }
    end
  end
end
