# coturn::service
#
# @summary Installs services coturn
#
# @param service_name
#   Service name for coturn.
# @param service_ensure
#   Whether the service should be running.
#   Defaults to 'running'
# @param service_enable
#   Whether the service should be enabled.
#   Defaults to true
#
class coturn::service(
  String           $service_name      = 'coturn',
  String           $service_ensure    = 'running',
  Boolean          $service_enable    = true,
  Boolean          $enable_turnserver = true,
  Optional[String] $default_file      = undef,
) {

  if $default_file {
    if $enable_turnserver {
      file_line{ 'turnserver default file':
        ensure  => 'present',
        path    => $default_file,
        line    => 'TURNSERVER_ENABLED=1',
        match   => '^TURNSERVER_ENABLED',
        notify  => Service['coturn'],
        require => Package['coturn'],
      }
    } else {
      file_line{ 'turnserver default file':
        ensure  => 'absent',
        path    => $default_file,
        match   => '^TURNSERVER_ENABLED',
        notify  => Service['coturn'],
        require => Package['coturn'],
      }
    }
  }

  service {'coturn':
    ensure => $service_ensure,
    name   => $service_name,
    enable => $service_enable,
  }
}
