# encoding: utf-8
require 'spec_helper'

describe 'postfix.rpm::default' do
  [
    { :platform => 'centos', :version => '6.5' }
  ].each do |i|
    context "#{i[:platform]}/#{i[:version]}" do
      # need to use let instead of cached so mocks will work properly (slower)
      let(:chef_run) do
        ChefSpec::Runner.new(i) do |node|
          # override cookbook attributes
          node.override['postfix']['pre_tidy'] = true
          node.override['postfix']['post_tidy'] = true

          # set cookbook attributes
          node.set['postfix']['devel_packages'] = %w(package2)
          node.set['postfix']['options']['ipv6'] = true
          node.set['postfix']['options']['ldap'] = true
          node.set['postfix']['options']['mysql'] = true
          node.set['postfix']['options']['pcre'] = true
          node.set['postfix']['options']['pflogsumm'] = true
          node.set['postfix']['options']['pgsql'] = true
          node.set['postfix']['options']['sasl'] = true
          node.set['postfix']['options']['sqlite'] = true
          node.set['postfix']['options']['tls'] = true
        end.converge(described_recipe)
      end # let

      #---------------------------------------------------------------- locals
      home = Pathname.new('/') + 'home' + 'vagrant'
      rpmbuild = home + 'rpmbuild'
      sources = rpmbuild + 'SOURCES'
      specs = rpmbuild + 'SPECS'

      #--------------------------------- template[/home/vagrant/.bash_profile]
      describe '/home/vagrant/.bash_profile' do
        it 'creates template with expected owner, group' do
          expect(chef_run).to create_template(subject)
            .with_owner('vagrant').with_group('vagrant')
        end # it
      end # describe

      #------------------------------------ template[/home/vagrant/.rpmmacros]
      describe '/home/vagrant/.rpmmacros' do
        it 'creates template with expected owner, group' do
          expect(chef_run).to create_template(subject)
            .with_owner('vagrant').with_group('vagrant')
        end # it
      end # describe

      #------------------------------------------------------------- package[]
      describe 'automake' do
        it 'installs described package' do
          expect(chef_run).to install_package(subject)
        end # it
      end # describe

      describe 'pkgconfig' do
        it 'installs described package' do
          expect(chef_run).to install_package(subject)
        end # it
      end # describe

      describe 'rpm-build' do
        it 'installs described package' do
          expect(chef_run).to install_package(subject)
        end # it
      end # describe

      describe 'package2-devel' do
        it 'installs described package' do
          expect(chef_run).to install_package(subject)
        end # it
      end # describe

      #-------------------------------------------------------- bash[pre_tidy]
      describe 'pre_tidy' do
        it 'runs described bash script' do
          expect(chef_run).to run_bash(subject)
        end # it
      end # describe

      #----------------------------- directory[/home/vagrant/rpmbuild/SOURCES]
      describe '/home/vagrant/rpmbuild/SOURCES' do
        it 'creates directory with expected owner, group' do
          expect(chef_run).to create_directory(subject)
            .with_owner('vagrant').with_group('vagrant').with_recursive(true)
        end # it
      end # describe

      #------------------------------- directory[/home/vagrant/rpmbuild/SPECS]
      describe '/home/vagrant/rpmbuild/SPECS' do
        it 'creates directory with expected owner, group' do
          expect(chef_run).to create_directory(subject)
            .with_owner('vagrant').with_group('vagrant').with_recursive(true)
        end # it
      end # describe

      #------------------------------------ bash[chown /home/vagrant/rpmbuild]
      describe 'chown /home/vagrant/rpmbuild' do
        it 'runs described bash script if directory exists' do
          allow_any_instance_of(Pathname).to receive(:directory?)
            .and_return(true)
          expect(chef_run).to run_bash(subject)
        end # it

        it 'does not run described bash script unless directory exists' do
          allow_any_instance_of(Pathname).to receive(:directory?)
            .and_return(false)
          expect(chef_run).to_not run_bash(subject)
        end # it
      end # describe

      #----- remote_file[/home/vagrant/rpmbuild/SOURCES/postfix-2.11.0.tar.gz]
      describe "#{sources}/postfix-2.11.0.tar.gz" do
        it 'creates remote file unless file exists' do
          allow_any_instance_of(Pathname).to receive(:file?)
            .and_return(false)
          expect(chef_run).to create_remote_file(subject)
            .with_backup(false).with_user('vagrant').with_group('vagrant')
        end # it

        it 'does not create remote file if file exists' do
          allow_any_instance_of(Pathname).to receive(:file?)
            .and_return(true)
          expect(chef_run).to_not create_remote_file(subject)
        end # it
      end # describe

      #------------------------------------------------------- cookbook_file[]
      describe "#{sources}/pflogsumm-1.1.1.tar.gz" do
        it 'creates cookbook file with expected owner, group' do
          expect(chef_run).to create_cookbook_file(subject)
            .with_owner('vagrant').with_group('vagrant')
        end # it
      end # describe

      #------------------------------------------------------------ template[]
      describe "#{sources}/pflogsumm-1.1.1-datecalc.patch" do
        it 'creates template with expected owner, group' do
          expect(chef_run).to create_template(subject)
            .with_owner('vagrant').with_group('vagrant')
        end # it
      end # describe

      describe "#{sources}/postfix-2.11.0-config.patch" do
        it 'creates template with expected owner, group' do
          expect(chef_run).to create_template(subject)
            .with_owner('vagrant').with_group('vagrant')
        end # it
      end # describe

      describe "#{sources}/postfix-2.11.0-files.patch" do
        it 'creates template with expected owner, group' do
          expect(chef_run).to create_template(subject)
            .with_owner('vagrant').with_group('vagrant')
        end # it
      end # describe

      describe "#{sources}/postfix-alternatives.patch" do
        it 'creates template with expected owner, group' do
          expect(chef_run).to create_template(subject)
            .with_owner('vagrant').with_group('vagrant')
        end # it
      end # describe

      describe "#{sources}/postfix-etc-init.d-postfix" do
        it 'creates template with expected owner, group' do
          expect(chef_run).to create_template(subject)
            .with_owner('vagrant').with_group('vagrant')
        end # it
      end # describe

      describe "#{sources}/postfix-large-fs.patch" do
        it 'creates template with expected owner, group' do
          expect(chef_run).to create_template(subject)
            .with_owner('vagrant').with_group('vagrant')
        end # it
      end # describe

      describe "#{sources}/postfix-pam.conf" do
        it 'creates template with expected owner, group' do
          expect(chef_run).to create_template(subject)
            .with_owner('vagrant').with_group('vagrant')
        end # it
      end # describe

      describe "#{sources}/postfix-sasl.conf" do
        it 'creates template with expected owner, group' do
          expect(chef_run).to create_template(subject)
            .with_owner('vagrant').with_group('vagrant')
        end # it
      end # describe

      describe "#{sources}/README-Postfix-SASL-RedHat.txt" do
        it 'creates template with expected owner, group' do
          expect(chef_run).to create_template(subject)
            .with_owner('vagrant').with_group('vagrant')
        end # it
      end # describe

      describe "#{specs}/postfix.spec" do
        it 'creates template with expected owner, group' do
          expect(chef_run).to create_template(subject)
            .with_owner('vagrant').with_group('vagrant')
        end # it

        it 'renders file with expected IPV6' do
          expect(chef_run).to render_file(subject)
            .with_content('%define IPV6 1')
        end # it

        it 'renders file with expected LDAP' do
          expect(chef_run).to render_file(subject)
            .with_content('%define LDAP 1')
        end # it

        it 'renders file with expected MYSQL' do
          expect(chef_run).to render_file(subject)
            .with_content('%{?!MYSQL: %define MYSQL 1}')
        end # it

        it 'renders file with expected PCRE' do
          expect(chef_run).to render_file(subject)
            .with_content('%define PCRE 1')
        end # it

        it 'renders file with expected PFLOGSUMM' do
          expect(chef_run).to render_file(subject)
            .with_content('%define PFLOGSUMM 1')
        end # it

        it 'renders file with expected PGSQL' do
          expect(chef_run).to render_file(subject)
            .with_content('%{?!PGSQL: %define PGSQL 1}')
        end # it

        it 'renders file with expected SASL' do
          expect(chef_run).to render_file(subject)
            .with_content('%define SASL 2')
        end # it

        it 'renders file with expected SQLITE' do
          expect(chef_run).to render_file(subject)
            .with_content('%{?!SQLITE: %define SQLITE 1}')
        end # it

        it 'renders file with expected TLS' do
          expect(chef_run).to render_file(subject)
            .with_content('%define TLS 1')
        end # it
      end # describe

      #-------------------------------------------------------- bash[rpmbuild]
      describe 'rpmbuild' do
        it 'runs described bash script unless file exists' do
          allow_any_instance_of(Pathname).to receive(:exist?)
            .and_return(false)
          expect(chef_run).to run_bash(subject)
            .with_user('vagrant').with_group('vagrant')
            .with_environment('HOME' => '/home/vagrant')
        end # it

        it 'does not run described bash script if file exists' do
          allow_any_instance_of(Pathname).to receive(:exist?)
            .and_return(true)
          expect(chef_run).to_not run_bash(subject)
        end # it
      end # describe

      #--------------------------------------------- bash[copy_final_products]
      describe 'copy_final_products' do
        it 'runs described bash script if directory exists' do
          allow_any_instance_of(Pathname).to receive(:directory?)
            .and_return(true)
          expect(chef_run).to run_bash(subject)
            .with_user('vagrant').with_group('vagrant')
        end # it

        it 'does not run described bash script unless directory exists' do
          allow_any_instance_of(Pathname).to receive(:directory?)
            .and_return(false)
          expect(chef_run).to_not run_bash(subject)
        end # it
      end # describe

      #------------------------------------------------------- bash[post_tidy]
      describe 'post_tidy' do
        it 'runs described bash script' do
          expect(chef_run).to run_bash(subject)
        end # it
      end # describe

    end # context
  end # [...].each

end # describe
