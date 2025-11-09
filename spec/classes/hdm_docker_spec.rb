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
          'version' => '3.0.0',
        }
      end

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('hdm::docker') }
      it { is_expected.to contain_class('docker') }
      it { is_expected.to contain_docker__image('ghcr.io/betadots/hdm').with('image_tag' => '3.0.0') }
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

    context "on #{os} using docker with all parameters and additional mounts" do
      let(:facts) { os_facts }
      let(:params) do
        {
          'method' => 'docker',
          'version' => '3.0.0',
          'puppet_dir' => '/etc/puppetlabs',
          'puppet_code_dir' => '/etc/puppet/code',
          'additional_mounts' => [
            '/opt/puppet/code',
            '/var/puppet',
          ],
        }
      end

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('docker') }
      it { is_expected.to contain_file('/etc/hdm/hdm.yml').with('content' => %r{hiera_config_file: "hiera.yaml"}) }
      it { is_expected.to contain_docker__run('hdm').with('volumes' => %r{/etc/puppetlabs:/etc/puppetlabs:ro}) }
      it { is_expected.to contain_docker__run('hdm').with('volumes' => %r{/opt/puppet/code:/opt/puppet/code:ro}) }
      it { is_expected.to contain_docker__run('hdm').with('volumes' => %r{/var/puppet:/var/puppet:ro}) }
    end

    context "on #{os} using docker with all parameters and ldap settings" do
      let(:facts) { os_facts }
      let(:params) do
        {
          'method' => 'docker',
          'version' => '3.0.0',
          'puppet_dir' => '/etc/puppetlabs',
          'puppet_code_dir' => '/etc/puppet/code',
          'ldap_settings' => {
            'host'  => 'ldapserver.domain.tld',
            'port'  => 389,
            'base_dn' => 'OU=Benutzer,OU=OU,dc=DC,dc=DC2,dc=DE',
            'bind_dn' => 'CN=hdm_ldap,OU=Benutzer,OU=DC,DC=DC2,DC=de',
            'bind_dn_password' => 's3cr3t',
          },
        }
      end

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('docker') }
      it { is_expected.to contain_file('/etc/hdm/hdm.yml').with('content' => %r{hiera_config_file: "hiera.yaml"}) }
      it { is_expected.to contain_file('/etc/hdm/hdm.yml').with('content' => %r{base_dn: OU=Benutzer,OU=OU,dc=DC,dc=DC2,dc=DE}) }
      it { is_expected.to contain_file('/etc/hdm/hdm.yml').with('content' => %r{bind_dn: CN=hdm_ldap,OU=Benutzer,OU=DC,DC=DC2,DC=de}) }
    end
  end
end
