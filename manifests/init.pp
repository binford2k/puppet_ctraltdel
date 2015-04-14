class ctraltdel {
 if ($osfamily  == 'redhat') and ( versioncmp($operatingsystemrelease, '5') > 0 ) {
  case $::operatingsystemrelease {
   /^5/: {
     file_line { 'ctraltdell':
       ensure => present,
       path => '/etc/inittab',
       line => '#ca::ctrlaltdel:/sbin/shutdown -t3 -r now',
       match => '^ca::ctrlaltdel',
     }
   }
   /^6/: {
     $ctraltdelf = template('ctraltdel/ctraltdel.erb')
     file { '/etc/init/control-alt-delete.override':
       ensure => file,
       owner => root,
       group => root,
       mode => '0644',
       content => $ctraltdelf,
     }
   }
   default: {
     fail ("version not supported")
   }
  }
 }
}
