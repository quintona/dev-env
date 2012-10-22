class gitblit::service {
	service { 'gitblit':
		ensure => running,
		enable => true,
		hasstatus => false,
		hasrestart => true
	}
}