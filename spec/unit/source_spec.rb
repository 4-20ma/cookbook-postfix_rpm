# encoding: utf-8
require 'spec_helper'

describe 'postfix.rpm::source' do
  [
    { :platform => 'centos', :version => '6.5' }
  ].each do |i|
    context "#{i[:platform]}/#{i[:version]}" do
      # need to use let instead of cached so mocks will work properly (slower)
      let(:chef_run) do
        ChefSpec::Runner.new(i) do |node|
        end.converge(described_recipe)
      end # let

      #------------------------------------------------------ include_recipe[]
      describe 'yum-epel::default' do
        it 'includes described recipe' do
          expect(chef_run).to include_recipe(subject)
        end # it
      end # describe

      #----------------------------------------- yum_repository[RedHat-Source]
      describe 'RedHat-Source' do
        it 'creates described yum repository' do
          expect(chef_run).to create_yum_repository(subject)
        end # it
      end # describe

      #------------------------------------------- bash[download_postfix_srpm]
      describe 'download_postfix_srpm' do
        it 'runs described bash script unless file exists' do
          allow_any_instance_of(Pathname).to receive(:file?)
            .and_return(false)
          expect(chef_run).to run_bash(subject)
        end # it

        it 'does not run described bash script if file exists' do
          allow_any_instance_of(Pathname).to receive(:file?)
            .and_return(true)
          expect(chef_run).to_not run_bash(subject)
        end # it
      end # describe

      #------------------------------------------------------------- package[]
      describe 'git' do
        it 'installs described package' do
          expect(chef_run).to install_package(subject)
        end # it
      end # describe

      describe 'man' do
        it 'installs described package' do
          expect(chef_run).to install_package(subject)
        end # it
      end # describe

      describe 'nano' do
        it 'installs described package' do
          expect(chef_run).to install_package(subject)
        end # it
      end # describe

      describe 'rpmrebuild' do
        it 'installs described package' do
          expect(chef_run).to install_package(subject)
        end # it
      end # describe

      describe 'yum-utils' do
        it 'installs described package' do
          expect(chef_run).to install_package(subject)
        end # it
      end # describe

    end # context
  end # [...].each

end # describe
