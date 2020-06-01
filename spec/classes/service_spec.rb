# frozen_string_literal: true

require 'spec_helper'

describe 'coturn::service' do
  let :default_params do
    { service_name: 'coturn',
      service_ensure: 'running',
      service_enable: true,
      enable_turnserver: true }
  end

  shared_examples_for 'coturn service' do
    it { is_expected.to compile.with_all_deps }

    it {
      is_expected.to contain_service('coturn')
        .with_ensure(params[:service_ensure])
        .with_name(params[:service_name])
        .with_enable(params[:service_enable])
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      describe 'without parameters' do
        let(:params) { default_params }

        it_behaves_like 'coturn service'
      end
    end
  end
end
