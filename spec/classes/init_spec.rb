require File.expand_path(File.join(File.dirname(__FILE__),'../spec_helper'))

describe 'sslh', :type => 'class' do
  describe 'with standard' do
    let(:facts) {
      {
        :ipaddress                 => '192.168.1.5',
        :operatingsystemmajrelease => '7',
      }
    }
    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_package('sslh').with(
      :ensure => 'installed',
      :before => ['File[/etc/sslh.cfg]'],
    )}
    it { is_expected.to contain_file('/etc/sslh.cfg').with(
      :owner  => 'root',
      :group  => 0,
      :mode   => '0644',
      :notify => ['Service[sslh]'],
    )}
    it { is_expected.to contain_file('/etc/sslh.cfg').with_content(/{ host: "192.168.1.5"; port: "443"; }$/) }
    it { is_expected.to contain_file('/etc/sslh.cfg').with_content(/{ name: "ssh"; service: "ssh"; host: "localhost"; port: "22"; probe: "builtin"; log_level: 0; },$/) }
    it { is_expected.to contain_file('/etc/sslh.cfg').with_content(/{ name: "ssl"; service: "ssl"; host: "localhost"; port: "443"; probe: "builtin"; log_level: 0; },$/) }
    it { is_expected.to contain_file('/etc/sslh.cfg').with_content(/{ name: "anyprot"; service: "anyprot"; host: "localhost"; port: "443"; probe: "builtin"; log_level: 0; }$/) }
    it { is_expected.to contain_service('sslh').with(
      :ensure => 'running',
      :enable => true,
    )}
  end
end
