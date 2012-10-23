
package {git:ensure=> [latest,installed]}

exec {"get_repo":
	command => "git clone https://github.com/quintona/dev-env.git /home/vagrant/dev-env",
	path => "/usr/bin",
	creates => "/home/vagrant/dev-env",
	require => Package['git'],
}

exec {"get_stdlib":
	command => "git clone git://github.com/puppetlabs/puppetlabs-stdlib.git /home/vagrant/stdlib",
	path => "/usr/bin",
	creates => "/home/vagrant/stdlib",
	require => Package['git'],
}

exec {"get_stdlib":
	command => "ln -s /home/vagrant/stdlib stdlib",
	cwd => "/home/vagrant/dev-env/modules",
	path => "/usr/bin",
	require => Exec['get_stdlib'],
}

