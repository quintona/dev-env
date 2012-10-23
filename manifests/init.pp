class {'gitblit': }

file { "/usr/local/gitblit/current/groovy/localclone.groovy":
    source => "puppet:///localclone.groovy",
    require => Class['gitblit'],
    replace => true,
  }


