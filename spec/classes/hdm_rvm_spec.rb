# frozen_string_literal: true

require 'spec_helper'

describe 'hdm' do
  on_supported_os.each do |os, os_facts|
    context "on #{os} using rvm" do
      let(:facts) { os_facts }
      let(:params) do
        {
          'method' => 'rvm',
          'version' => 'main',
        }
      end

      it { is_expected.to compile.with_all_deps }
      it { is_expected.to contain_class('hdm::rvm') }
      it { is_expected.to contain_rvm__system_user('hdm') }
      it { is_expected.to contain_rvm_gem('bundler') }
      it { is_expected.to contain_rvm_system_ruby('ruby-3.3.1') }
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
      if os_facts[:os]['family'] == 'RedHat' and os_facts[:os]['release']['major'].to_i < 8
        it { is_expected.to contain_package('centos-release-scl') }
        it { is_expected.to contain_package('devtoolset-7') }
        it { is_expected.to contain_exec('update sqlite') }
      end

    end
  end
end
