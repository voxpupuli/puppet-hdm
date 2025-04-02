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
    end
  end
end
