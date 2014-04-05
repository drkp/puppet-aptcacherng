require 'spec_helper'

# aptcacherng
describe 'aptcacherng', :type => :class do

  describe 'On an unknown osfamily' do
    let(:facts) {{ :osfamily => 'Fooboozoo' }}
    it 'should fail' do
      expect do
        subject
      end.to raise_error(Puppet::Error, /aptcacherng: Fooboozoo not supported./)
    end
  end

  describe 'On Debian' do
    describe 'With default params' do
      let(:facts) {{ :osfamily => 'Debian' }}

      it { should contain_class('aptcacherng::params') }
      it { should contain_package('apt-cacher-ng') }
      it { should contain_service('apt-cacher-ng') }

      ['/var/cache/apt-cacher-ng','/var/log/apt-cacher-ng'].each do |d|
        it { should contain_file(d).with(
          :ensure  => 'directory',
          :owner   => 'apt-cacher-ng',
          :group   => 'apt-cacher-ng',
          :mode    => '2755',
          :require => 'Package[apt-cacher-ng]',
          :before  => 'Service[apt-cacher-ng]'
        )}
      end

      it { should contain_file('/etc/apt-cacher-ng/acng.conf').with(
        :owner   => 'root',
        :group   => 'root',
        :mode    => '0644',
        :require => 'Package[apt-cacher-ng]',
      )}

      it { should contain_file('/etc/apt-cacher-ng/acng.conf').with_content(/^CacheDir: \/var\/cache\/apt-cacher-ng$/) }
      it { should contain_file('/etc/apt-cacher-ng/acng.conf').with_content(/^LogDir: \/var\/log\/apt-cacher-ng$/) }
      it { should contain_file('/etc/apt-cacher-ng/acng.conf').with_content(/^Port: 3142$/) }
      it { should contain_file('/etc/apt-cacher-ng/acng.conf').with_content(/^ReportPage: acng-report.html$/) }
      it { should contain_file('/etc/apt-cacher-ng/acng.conf').with_content(/^ExTreshold: 4$/) }

      it { should_not contain_file('/etc/apt-cacher-ng/security.conf') }

    end # with default params

  end # Debian

end # aptcacherng
