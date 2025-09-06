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
# @param listening_device
#   Listener interface device (optional, Linux only)
#   (not recomended)
# @param listening_port
#   TURN listener port for UDP and TCP (Default: 3478)
# @param tls_listening_port
#   TURN listener port for TLS (Default: 5349).
# @param alt_listening_port
#   Alternative listening port for UDP and TCP listeners
# @param alt_tls_listening_port
#   Alternative listening port for TLS and DTLS protocols
# @param tcp_proxy_port
#   TCP reverse proxy in front of the STUN server
# @param listening_ip
#   listener IP address of relay server.
#   Multiple listeners can be specified
# @param aux_server
#   Auxiliary STUN/TURN server listening endpoint
# @param udp_self_balance
#   Automatically balance UDP traffic over auxiliary servers
# @param relay_device
#   Relay interface device for relay sockets
# @param relay_ip
#   Relay address
# @param external_ip
#   TURN Server public/private address mapping
# @param min_port
#   Lower bound of the UDP relay endpoints
# @param max_port
#   Upper bound of the UDP relay endpoints
# @param verbose
#   if true, enables verbose mode
# @param extra_verbose
#   if true, enables Verbose mode (extra verbose) 
# @param fingerprint
#   use fingerprints in the TURN messages
# @param lt_cred_mech
#   use long-term credential mechanism
# @param no_auth
#   no auth
# @param prometheus
#   Enable prometheus exporter
# @param use_auth_secret
#   enable use-auth-secret
# @param static_auth_secret
#   'Static' authentication secret value
# @param server_name
#   Server name used for the oAuth authentication purposes.
# @param oauth
#   allow oAuth authentication
# @param user
#   static user accounts for the long term credentials mechanism
# @param userdb
#   SQLite database file name
# @param psql_userdb
#   PostgreSQL database connection string
# @param mysql_userdb
#   MySQL database connection string
# @param secret_key_file
#   MySQL password encryption secret key
# @param mongo_userdb
#   MongoDB database connection string
# @param redis_userdb
#   Redis database connection string
# @param redis_statsdb
#   Redis status and statistics database connection string
# @param realm
#   the default realm to be used
# @param check_origin_consistency
#   set the origin consistency  check
# @param user_quota
#   Per-user allocation quota
# @param total_quota
#   Total allocation quota
# @param max_bps
#   Max bytes-per-second bandwidth a TURN session is
#   allowed to handle
# @param bps_capacity
#   Maximum server capacity
# @param no_udp
#   no UDP client listener
# @param no_tcp
#   no TCP client listener
# @param no_tls
#   no TLS client listener
# @param no_dtls
#   no DTLS client listener
# @param no_udp_relay
#   no UDP relay endpoints are allowed
# @param no_tcp_relay
#   no TCP relay endpoints are allowed
# @param stale_nonce
#   limited lifetime for nonce
# @param max_allocate_lifetime
#   maximum allocation lifetime
# @param channel_lifetime
#   maximum channel lifetime
# @param permission_lifetime
#   maximum permission lifetime
# @param cert
#   Certificate file
# @param pkey
#   Private key file
# @param pkey_pwd
#   Private key file password
# @param cipher_list
#   Allowed OpenSSL ciphers
# @param ca_file
#   CA file in OpenSSL format
# @param ec_curve_name
#   Curve name for EC ciphers
# @param dh566
#   Use 566 bits predefined DH TLS key
# @param dh1066
#   Use 1066 bits predefined DH TLS key
# @param dh_file
#   Use custom DH TLS key, stored in PEM format in the file
# @param no_stdout_log
#   Flag to prevent stdout log messages
# @param syslog
#   redirect all log output into system log (syslog)
# @param syslog_facility
#   Set syslog facility
# @param simple_log
#   if true, no log file rollover will be used
# @param log_file
#   Option to set the log file path
# @param new_log_timestamp
#   Enable full ISO-8601 timestamp in all logs
# @param new_log_timestamp_format
#   Set timestamp format
# @param log_binding
#   Disabled by default binding logging in verbose log mode
# @param alternate_server
#   Option to set the "redirection" mode
# @param tls_alternate_server
#   Option to set alternative server for TLS & DTLS services
# @param stun_only
#   suppress TURN functionality
# @param non_software_attribute
#   hide software version
# @param no_stun
#   suppress STUN functionality
# @param rest_api_separator
#   timestamp/username separator symbol
# @param allow_loopback_peers
#   allow peers on the loopback addresses
# @param no_multicast_peers
#   disallow peers on well-known broadcast addresses
# @param max_allocate_timeout
#   set the max time, in seconds
# @param allowed_peer_ip
#   allow specific ip addresses or ranges
# @param denied_peer_ip
#   ban specific ip addresses or ranges
# @param pidfile
#   File name to store the pid of the process
# @param secure_stun
#   Require authentication of the STUN Binding request
# @param mobility
#   Mobility with ICE (MICE) specs support
# @param keep_address_family
#   Allocate Address Family according
# @param allocation_default_address_family
#   TURN server allocates address family to use.
# @param proc_user
#   User name to run the process
# @param proc_group
#   Group name to run the process
# @param no_cli
#   Turn OFF the CLI support
# @param cli_ip
#   Local system IP address to be used for CLI server endpoint
# @param cli_port
#   CLI server port
# @param cli_password
#   CLI access password
# @param web_admin
#   Enable Web-admin support on https
# @param web_admin_ip
#   Local system IP address to be used for Web-admin server endpoint
# @param web_admin_port
#   Web-admin server port
# @param web_admin_listen_on_workers
#   Web-admin server listen on STUN/TURN worker threads
# @param acme_redirect
#   Redirect ACME
# @param server_relay
#   Server relay. NON-STANDARD AND DANGEROUS OPTION.
# @param cli_max_output_sessions
#   Maximum number of output sessions in ps CLI command
# @param no_tlsv1
#   Do not allow tlsv1
# @param no_tlsv1_1
#   Do not allow tlsv1_1
# @param no_tlsv1_2
#   Do not allow tlsv1_2
# @param no_rfc5780
#   Disable RFC5780 (NAT behavior discovery)
# @param no_stun_backwards_compatibility
#   Disable handling old STUN Binding requests
# @param response_origin_only_with_rfc5780
#   Only send RESPONSE-ORIGIN attribute in binding response 
#   if RFC5780 is enabled
#
class coturn (
  Stdlib::Absolutepath                   $config_file                       = '/etc/turnserver.conf',
  String                                 $mode                              = '0644',
  String                                 $owner                             = 'root',
  String                                 $group                             = 'root',
  String                                 $package_name                      = 'coturn',
  Optional[String[1]]                    $listening_device                  = undef,
  Optional[Integer]                      $listening_port                    = undef,
  Optional[Integer]                      $tls_listening_port                = undef,
  Optional[Integer]                      $alt_listening_port                = undef,
  Optional[Integer]                      $alt_tls_listening_port            = undef,
  Optional[Integer]                      $tcp_proxy_port                    = undef,
  Array[Stdlib::IP::Address]             $listening_ip                      = [],
  Array[String[1]]                       $aux_server                        = [],
  Boolean                                $udp_self_balance                  = false,
  Optional[String[1]]                    $relay_device                      = undef,
  Array[Stdlib::IP::Address]             $relay_ip                          = [],
  Array[String[1]]                       $external_ip                       = [],
  Optional[Integer]                      $min_port                          = undef,
  Optional[Integer]                      $max_port                          = undef,
  Boolean                                $verbose                           = false,
  Boolean                                $extra_verbose                     = false,
  Boolean                                $fingerprint                       = false,
  Boolean                                $lt_cred_mech                      = false,
  Boolean                                $no_auth                           = false,
  Boolean                                $prometheus                        = false,
  Boolean                                $use_auth_secret                   = false,
  Optional[String[1]]                    $static_auth_secret                = undef,
  Optional[String[1]]                    $server_name                       = undef,
  Boolean                                $oauth                             = false,
  Array[String[1]]                       $user                              = [],
  Optional[Stdlib::Absolutepath]         $userdb                            = undef,
  Optional[String[1]]                    $psql_userdb                       = undef,
  Optional[String[1]]                    $mysql_userdb                      = undef,
  Optional[Stdlib::Absolutepath]         $secret_key_file                   = undef,
  Optional[String[1]]                    $mongo_userdb                      = undef,
  Optional[String[1]]                    $redis_userdb                      = undef,
  Optional[String[1]]                    $redis_statsdb                     = undef,
  Optional[String[1]]                    $realm                             = undef,
  Boolean                                $check_origin_consistency          = false,
  Optional[Integer]                      $user_quota                        = undef,
  Optional[Integer]                      $total_quota                       = undef,
  Optional[Integer]                      $max_bps                           = undef,
  Optional[Integer]                      $bps_capacity                      = undef,
  Boolean                                $no_udp                            = false,
  Boolean                                $no_tcp                            = false,
  Boolean                                $no_tls                            = false,
  Boolean                                $no_dtls                           = false,
  Boolean                                $no_udp_relay                      = false,
  Boolean                                $no_tcp_relay                      = false,
  Optional[Integer]                      $stale_nonce                       = undef,
  Optional[Integer]                      $max_allocate_lifetime             = undef,
  Optional[Integer]                      $channel_lifetime                  = undef,
  Optional[Integer]                      $permission_lifetime               = undef,
  Optional[Stdlib::Absolutepath]         $cert                              = undef,
  Optional[Stdlib::Absolutepath]         $pkey                              = undef,
  Optional[String[1]]                    $pkey_pwd                          = undef,
  Optional[String[1]]                    $cipher_list                       = undef,
  Optional[Stdlib::Absolutepath]         $ca_file                           = undef,
  Optional[String[1]]                    $ec_curve_name                     = undef,
  Boolean                                $dh566                             = false,
  Boolean                                $dh1066                            = false,
  Optional[String[1]]                    $dh_file                           = undef,
  Boolean                                $no_stdout_log                     = false,
  Boolean                                $syslog                            = false,
  Optional[String[1]]                    $syslog_facility                   = undef,
  Boolean                                $simple_log                        = false,
  Optional[String[1]]                    $log_file                          = undef,
  Boolean                                $new_log_timestamp                 = false,
  Optional[String[1]]                    $new_log_timestamp_format          = undef,
  Boolean                                $log_binding                       = false,
  Array[String[1]]                       $alternate_server                  = [],
  Array[String[1]]                       $tls_alternate_server              = [],
  Boolean                                $stun_only                         = false,
  Boolean                                $non_software_attribute            = false,
  Boolean                                $no_stun                           = false,
  Optional[String[1]]                    $rest_api_separator                = undef,
  Boolean                                $allow_loopback_peers              = false,
  Boolean                                $no_multicast_peers                = false,
  Optional[Integer]                      $max_allocate_timeout              = undef,
  Array[String[1]]                       $allowed_peer_ip                   = [],
  Array[String[1]]                       $denied_peer_ip                    = [],
  Optional[Stdlib::Absolutepath]         $pidfile                           = undef,
  Boolean                                $secure_stun                       = false,
  Boolean                                $mobility                          = false,
  Boolean                                $keep_address_family               = false,
  Optional[Enum['ipv4', 'ipv6', 'keep']] $allocation_default_address_family = undef,
  Optional[String[1]]                    $proc_user                         = undef,
  Optional[String[1]]                    $proc_group                        = undef,
  Boolean                                $no_cli                            = false,
  Optional[Stdlib::IP::Address]          $cli_ip                            = undef,
  Optional[Integer]                      $cli_port                          = undef,
  Optional[String[1]]                    $cli_password                      = undef,
  Boolean                                $web_admin                         = false,
  Optional[Stdlib::IP::Address]          $web_admin_ip                      = undef,
  Optional[Integer]                      $web_admin_port                    = undef,
  Boolean                                $web_admin_listen_on_workers       = false,
  Optional[String[1]]                    $acme_redirect                     = undef,
  Boolean                                $server_relay                      = false,
  Optional[Integer]                      $cli_max_output_sessions           = undef,
  Boolean                                $no_tlsv1                          = false,
  Boolean                                $no_tlsv1_1                        = false,
  Boolean                                $no_tlsv1_2                        = false,
  Boolean                                $no_rfc5780                        = true,
  Boolean                                $no_stun_backwards_compatibility   = true,
  Boolean                                $response_origin_only_with_rfc5780 = true,
) {
  include coturn::service

  package { 'coturn':
    ensure => 'installed',
    name   => $package_name,
    before => File[$config_file],
    tag    => 'coturn-packages',
  }

  file { $config_file:
    mode    => $mode,
    owner   => $owner,
    group   => $group,
    content => template('coturn/turnserver.conf.erb'),
    notify  => Service['coturn'],
  }
}
