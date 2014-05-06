# encoding: utf-8
require 'spec_helper'

describe 'postfix.rpm::default' do
  #---------------------------------------------------------------- locals
  home = Pathname.new('/') + 'home' + 'vagrant'
  products = home + 'products'
  rpmbuild = home + 'rpmbuild'
  rpms = rpmbuild + 'RPMS'
  sources = rpmbuild + 'SOURCES'
  specs = rpmbuild + 'SPECS'

  #----------------------------------------- file[/home/vagrant/.bash_profile]
  describe file('/home/vagrant/.bash_profile') do
    it 'is a file' do
      expect(subject).to be_file
    end # it

    it 'is owned by vagrant' do
      expect(subject).to be_owned_by('vagrant')
    end # it

    it 'is in group vagrant' do
      expect(subject).to be_grouped_into('vagrant')
    end # it

    it 'is mode 644' do
      expect(subject).to be_mode(644)
    end # it

    it 'includes expected content' do
      expect(subject.content).to include("alias la='ls -ahl'")
    end # it
  end # describe

  #-------------------------------------------- file[/home/vagrant/.rpmmacros]
  describe file('/home/vagrant/.rpmmacros') do
    it 'is a file' do
      expect(subject).to be_file
    end # it

    it 'is owned by vagrant' do
      expect(subject).to be_owned_by('vagrant')
    end # it

    it 'is in group vagrant' do
      expect(subject).to be_grouped_into('vagrant')
    end # it

    it 'is mode 644' do
      expect(subject).to be_mode(644)
    end # it

    it 'includes expected content' do
      expect(subject.content).to include('%_topdir %(echo $HOME)/rpmbuild')
    end # it
  end # describe

  #----------------------------------------------------------------- package[]
  # packages required to build all rpms
  describe package('automake') do
    it 'installs described package' do
      expect(subject).to be_installed
    end # it
  end # describe

  describe package('pkgconfig') do
    it 'installs described package' do
      expect(subject).to be_installed
    end # it
  end # describe

  describe package('rpm-build') do
    it 'installs described package' do
      expect(subject).to be_installed
    end # it
  end # describe

  # development packages required specifically for postfix
  describe package('db4-devel') do
    it 'installs described package' do
      expect(subject).to be_installed
    end # it
  end # describe

  describe package('zlib-devel') do
    it 'installs described package' do
      expect(subject).to be_installed
    end # it
  end # describe

  describe package('openldap-devel') do
    it 'does not install described package' do
      expect(subject).to_not be_installed
    end # it
  end # describe

  describe package('mysql-devel') do
    it 'does not install described package' do
      expect(subject).to_not be_installed
    end # it
  end # describe

  describe package('pcre-devel') do
    it 'installs described package' do
      expect(subject).to be_installed
    end # it
  end # describe

  describe package('postgresql-devel') do
    it 'does not install described package' do
      expect(subject).to_not be_installed
    end # it
  end # describe

  describe package('cyrus-sasl-devel') do
    it 'installs described package' do
      expect(subject).to be_installed
    end # it
  end # describe

  describe package('sqlite-devel') do
    it 'installs described package' do
      expect(subject).to be_installed
    end # it
  end # describe

  describe package('openssl-devel') do
    it 'installs described package' do
      expect(subject).to be_installed
    end # it
  end # describe

  #--------------------------------------------------------------- directory[]
  describe file('/home/vagrant/rpmbuild') do
    it 'is a directory' do
      expect(subject).to be_directory
    end # it

    it 'is owned by vagrant' do
      expect(subject).to be_owned_by('vagrant')
    end # it

    it 'is in group vagrant' do
      expect(subject).to be_grouped_into('vagrant')
    end # it

    it 'is mode 755' do
      expect(subject).to be_mode(755)
    end # it
  end # describe

  describe file('/home/vagrant/rpmbuild/SOURCES') do
    it 'is a directory' do
      expect(subject).to be_directory
    end # it

    it 'is owned by vagrant' do
      expect(subject).to be_owned_by('vagrant')
    end # it

    it 'is in group vagrant' do
      expect(subject).to be_grouped_into('vagrant')
    end # it

    it 'is mode 755' do
      expect(subject).to be_mode(755)
    end # it
  end # describe

  describe file('/home/vagrant/rpmbuild/SPECS') do
    it 'is a directory' do
      expect(subject).to be_directory
    end # it

    it 'is owned by vagrant' do
      expect(subject).to be_owned_by('vagrant')
    end # it

    it 'is in group vagrant' do
      expect(subject).to be_grouped_into('vagrant')
    end # it

    it 'is mode 755' do
      expect(subject).to be_mode(755)
    end # it
  end # describe

  #--------- remote_file[/home/vagrant/rpmbuild/SOURCES/postfix-2.11.0.tar.gz]
  describe file('/home/vagrant/rpmbuild/SOURCES/postfix-2.11.0.tar.gz') do
    it 'is a file' do
      expect(subject).to be_file
    end # it

    it 'is owned by vagrant' do
      expect(subject).to be_owned_by('vagrant')
    end # it

    it 'is in group vagrant' do
      expect(subject).to be_grouped_into('vagrant')
    end # it

    it 'is mode 644' do
      expect(subject).to be_mode(644)
    end # it
  end # describe

  #----------------------------------------------------------- cookbook_file[]
  describe file("#{sources}/pflogsumm-1.1.1.tar.gz") do
    it 'is a file' do
      expect(subject).to be_file
    end # it

    it 'is owned by vagrant' do
      expect(subject).to be_owned_by('vagrant')
    end # it

    it 'is in group vagrant' do
      expect(subject).to be_grouped_into('vagrant')
    end # it

    it 'is mode 644' do
      expect(subject).to be_mode(644)
    end # it
  end # describe

  #---------------------------------------------------------------- template[]
  describe file("#{sources}/pflogsumm-1.1.1-datecalc.patch") do
    it 'is a file' do
      expect(subject).to be_file
    end # it

    it 'is owned by vagrant' do
      expect(subject).to be_owned_by('vagrant')
    end # it

    it 'is in group vagrant' do
      expect(subject).to be_grouped_into('vagrant')
    end # it

    it 'is mode 644' do
      expect(subject).to be_mode(644)
    end # it
  end # describe

  describe file("#{sources}/postfix-2.11.0-config.patch") do
    it 'is a file' do
      expect(subject).to be_file
    end # it

    it 'is owned by vagrant' do
      expect(subject).to be_owned_by('vagrant')
    end # it

    it 'is in group vagrant' do
      expect(subject).to be_grouped_into('vagrant')
    end # it

    it 'is mode 644' do
      expect(subject).to be_mode(644)
    end # it
  end # describe

  describe file("#{sources}/postfix-2.11.0-files.patch") do
    it 'is a file' do
      expect(subject).to be_file
    end # it

    it 'is owned by vagrant' do
      expect(subject).to be_owned_by('vagrant')
    end # it

    it 'is in group vagrant' do
      expect(subject).to be_grouped_into('vagrant')
    end # it

    it 'is mode 644' do
      expect(subject).to be_mode(644)
    end # it
  end # describe

  describe file("#{sources}/postfix-alternatives.patch") do
    it 'is a file' do
      expect(subject).to be_file
    end # it

    it 'is owned by vagrant' do
      expect(subject).to be_owned_by('vagrant')
    end # it

    it 'is in group vagrant' do
      expect(subject).to be_grouped_into('vagrant')
    end # it

    it 'is mode 644' do
      expect(subject).to be_mode(644)
    end # it
  end # describe

  describe file("#{sources}/postfix-etc-init.d-postfix") do
    it 'is a file' do
      expect(subject).to be_file
    end # it

    it 'is owned by vagrant' do
      expect(subject).to be_owned_by('vagrant')
    end # it

    it 'is in group vagrant' do
      expect(subject).to be_grouped_into('vagrant')
    end # it

    it 'is mode 644' do
      expect(subject).to be_mode(644)
    end # it
  end # describe

  describe file("#{sources}/postfix-large-fs.patch") do
    it 'is a file' do
      expect(subject).to be_file
    end # it

    it 'is owned by vagrant' do
      expect(subject).to be_owned_by('vagrant')
    end # it

    it 'is in group vagrant' do
      expect(subject).to be_grouped_into('vagrant')
    end # it

    it 'is mode 644' do
      expect(subject).to be_mode(644)
    end # it
  end # describe

  describe file("#{sources}/postfix-pam.conf") do
    it 'is a file' do
      expect(subject).to be_file
    end # it

    it 'is owned by vagrant' do
      expect(subject).to be_owned_by('vagrant')
    end # it

    it 'is in group vagrant' do
      expect(subject).to be_grouped_into('vagrant')
    end # it

    it 'is mode 644' do
      expect(subject).to be_mode(644)
    end # it
  end # describe

  describe file("#{sources}/postfix-sasl.conf") do
    it 'is a file' do
      expect(subject).to be_file
    end # it

    it 'is owned by vagrant' do
      expect(subject).to be_owned_by('vagrant')
    end # it

    it 'is in group vagrant' do
      expect(subject).to be_grouped_into('vagrant')
    end # it

    it 'is mode 644' do
      expect(subject).to be_mode(644)
    end # it
  end # describe

  describe file("#{sources}/README-Postfix-SASL-RedHat.txt") do
    it 'is a file' do
      expect(subject).to be_file
    end # it

    it 'is owned by vagrant' do
      expect(subject).to be_owned_by('vagrant')
    end # it

    it 'is in group vagrant' do
      expect(subject).to be_grouped_into('vagrant')
    end # it

    it 'is mode 644' do
      expect(subject).to be_mode(644)
    end # it
  end # describe

  describe file("#{specs}/postfix.spec") do
    it 'is a file' do
      expect(subject).to be_file
    end # it

    it 'is owned by vagrant' do
      expect(subject).to be_owned_by('vagrant')
    end # it

    it 'is in group vagrant' do
      expect(subject).to be_grouped_into('vagrant')
    end # it

    it 'is mode 644' do
      expect(subject).to be_mode(644)
    end # it
  end # describe

  #------------------------------------------------------------ bash[rpmbuild]
  describe file("#{rpms}/x86_64/postfix-2.11.0-1.el6.x86_64.rpm") do
    it 'is a file' do
      expect(subject).to be_file
    end # it

    it 'is owned by vagrant' do
      expect(subject).to be_owned_by('vagrant')
    end # it

    it 'is in group vagrant' do
      expect(subject).to be_grouped_into('vagrant')
    end # it

    it 'is mode 644' do
      expect(subject).to be_mode(644)
    end # it
  end # describe

  #------------------------------------------------- bash[copy_final_products]
  describe file("#{products}/postfix-2.11.0-1.el6.x86_64.rpm") do
    it 'is a file' do
      expect(subject).to be_file
    end # it

    # it 'is owned by vagrant' do
    #   expect(subject).to be_owned_by('vagrant')
    # end # it
    #
    # it 'is in group vagrant' do
    #   expect(subject).to be_grouped_into('vagrant')
    # end # it

    it 'is mode 644' do
      expect(subject).to be_mode(644)
    end # it
  end # describe

end # describe
