# frozen_string_literal: true

require 'spec_helper'

describe 'coturn' do
  let :default_params do
    { config_file: '/etc/turnserver.conf',
      mode: '0644',
      owner: 'root',
      group: 'root',
      package_name: 'coturn' }
  end

  shared_examples_for 'coturn' do
    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_class('coturn::service') }

    it {
      is_expected.to contain_file(params[:config_file])
        .with_mode(params[:mode])
        .with_group(params[:group])
        .with_owner(params[:owner])
    }

    it {
      is_expected.to contain_package('coturn')
        .with_ensure('installed')
        .with_name(params[:package_name])
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      describe 'without parameters' do
        let(:params) { default_params }

        it_behaves_like 'coturn'
      end
    end
  end
end
