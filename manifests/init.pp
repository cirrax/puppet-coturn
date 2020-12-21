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
# @param no_stdout_log
#   Flag to prevent stdout log messages
# @param syslog
#   redirect all log output into system log (syslog)
# @param simple_log
#   if true, no log file rollover will be used
# @param verbose
#   if true, enables verbose mode
# @param extra_verbose
#   if true, enables Verbose mode (extra verbose) 
# @param log_file
#   Option to set the log file path
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
  Boolean          $no_stdout_log      = false,
  Boolean          $syslog             = false,
  Boolean          $simple_log         = false,
  Boolean          $verbose            = false,
  Boolean          $extra_verbose      = false,
  Optional[String] $log_file           = undef,
  Optional[String] $static_auth_secret = undef,
  Optional[String] $realm              = undef,
) {

  include coturn::service

  package{'coturn':
    ensure => 'installed',
    name   => $package_name,
    before => File[$config_file],
    tag    => 'coturn-packages',
  }

  file{ $config_file:
    mode    => $mode,
    owner   => $owner,
    group   => $group,
    content => template('coturn/turnserver.conf.erb'),
    notify  => Service['coturn'],
  }
}
