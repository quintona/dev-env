class gitblit::configuration () {
	
	file { "/usr/local/gitblit/current/gitblit.properties":
      source => "puppet:///gitblit/gitblit.properties",
      require => Exec['gitblit_set_current'],
	  notify => Service['gitblit'],
	  replace => true
    }
	
}