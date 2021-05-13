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
# @param enable_turnserver
#   do we enable coturn in the default_file ?
#   set to false to disable.
# @param default_file
#   use a file in /etc/default to enable server.
#   this is the filename with path.
# @param daemon_args
#   if default_file is set, this parameter can be
#   used to set the startup options (DAEMON_ARGS) there.
#   if set to 'absent', the option will be deleted.
#
class coturn::service(
  String           $service_name      = 'coturn',
  String           $service_ensure    = 'running',
  Boolean          $service_enable    = true,
  Boolean          $enable_turnserver = true,
  Optional[String] $default_file      = undef,
  Optional[String] $daemon_args       = undef,
) {

  Package <| tag == 'coturn-packages' |> -> File_line <| tag == 'coturn::service' |> ~> Service['coturn']


  if $default_file {
    if $enable_turnserver {
      file_line{ 'turnserver default file':
        ensure => 'present',
        path   => $default_file,
        line   => 'TURNSERVER_ENABLED=1',
        match  => '^TURNSERVER_ENABLED',
        tag    => 'coturn::service',
      }
    } else {
      file_line{ 'turnserver default file':
        ensure            => 'absent',
        path              => $default_file,
        match             => '^TURNSERVER_ENABLED',
        match_for_absence => true,
        tag               => 'coturn::service',
      }
    }

    if $daemon_args == 'absent' {
      file_line{ 'turnserver default file, damonargs':
        ensure            => 'absent',
        path              => $default_file,
        match             => '^DAEMON_ARGS',
        match_for_absence => true,
        tag               => 'coturn::service',
      }
    }
    elsif $daemon_args {
      file_line{ 'turnserver default file, damonargs':
        ensure => 'present',
        path   => $default_file,
        match  => '^DAEMON_ARGS',
        line   => "DAEMON_ARGS=\"${daemon_args}\"",
        tag    => 'coturn::service',
      }
    }
  }

  service {'coturn':
    ensure => $service_ensure,
    name   => $service_name,
    enable => $service_enable,
  }
}
