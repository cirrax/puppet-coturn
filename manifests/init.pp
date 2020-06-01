# @summary main configuration class for coturn
#
# Main class to configure coturn
#
# @param config_file
#   the coturn configuration file
# @param mode
#   mode to use for coturn config file
# @param owner
#   owner of coturn config file
# @param group
#   group of the coturn config file
# @param package_name
#   package to install
# @param use_auth_secret
#   enable use-auth-secret
# @param static_auth_secret
#   'Static' authentication secret value
# @param realm
#   the default realm to be used
#
class coturn (
  String           $config_file        = '/etc/turnserver.conf',
  String           $mode               = '0644',
  String           $owner              = 'root',
  String           $group              = 'root',
  String           $package_name       = 'coturn',
  Boolean          $use_auth_secret    = false,
  Optional[String] $static_auth_secret = undef,
  Optional[String] $realm              = undef,
) {

  include coturn::service

  package{'coturn':
    ensure => 'installed',
    name   => $package_name,
    before => File[$config_file],
  }

  file{ $config_file:
    mode    => $mode,
    owner   => $owner,
    group   => $group,
    content => template('coturn/turnserver.conf.erb'),
    notify  => Service['coturn'],
  }
}
