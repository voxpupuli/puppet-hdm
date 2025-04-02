# frozen_string_literal: true

require 'spec_helper'

describe 'hdm' do
  on_supported_os.each do |os, os_facts|
    context "on #{os} using rvm" do
      # mock osfamily fact for the rvm module
      # workaround until https://github.com/dgolja/golja-gnupg/pull/38 is merged/released
      let(:facts) { os_facts.merge({ osfamily: os_facts[:os]['family'] }) }
      let(:params) do
        {
          'method' => 'rvm',
          'version' => 'main',
        }
      end

      it { is_expected.to compile.with_all_deps }

      if os_facts[:os]['name'] == 'CentOS'
        it { is_expected.to contain_yumrepo('crb') }
        it { is_expected.to contain_package('libyaml-devel') }
      end
      it { is_expected.to contain_class('hdm::rvm') }
      it { is_expected.to contain_rvm__system_user('hdm') }
      it { is_expected.to contain_rvm_gem('bundler') }
      it { is_expected.to contain_rvm_system_ruby('ruby-3.4.2') }
      it { is_expected.to contain_group('hdm') }
      it { is_expected.to contain_user('hdm') }
      it { is_expected.to contain_vcsrepo('/etc/hdm') }
      it { is_expected.to contain_file('/etc/hdm/config/hdm.yml') }
      it { is_expected.to contain_exec('bundle config development') }
      it { is_expected.to contain_exec('bundle config path') }
      it { is_expected.to contain_exec('bundle db:setup') }
      it { is_expected.to contain_exec('bundle install') }
      it { is_expected.to contain_exec('bundle rails credentials') }
      it { is_expected.to contain_systemd__unit_file('hdm.service') }
    end
  end
end
