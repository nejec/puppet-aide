require 'spec_helper'
describe 'aide', type: 'class' do
  context 'default parameters on RedHat 7' do
    let (:facts) {{
      :osfamily               => 'RedHat',
      :operatingsystem        => 'RedHat',
      :operatingsystemrelease => '7',
      :concat_basedir => '/tmp',
    }}
    it {
      should contain_class('break')
      should contain_package('aide').with({
        'ensure' => 'latest',
        'name'   => 'aide',
      })
    }
  end
  context 'default parameters on Debian 8' do
    let (:facts) {{
      :osfamily          => 'Debian',
      :operatingsystem   => 'Debian',
      :lsbmajdistrelease => '8',
      :concat_basedir => '/tmp',
    }}
    it {
      should contain_class('aide')
      should contain_package('aide').with({
        'ensure' => 'latest',
        'name'   => 'aide',
      })
    }
  end
end


describe 'aide::cron', type: 'class' do
  context 'default parameters cron' do
    let (:facts) {{
      :osfamily               => 'RedHat',
      :operatingsystem        => 'RedHat',
      :operatingsystemrelease => '7',
      :concat_basedir => '/tmp',
    }}
    it {
      should contain_class('aide::cron')
    }
  end
end
