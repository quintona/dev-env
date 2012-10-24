class backups  {
	
  file { "/home/vagrant/cron-file.txt":
    source => "puppet:///backups/cron-file.txt",
  }
  
  exec { "create-crontab":
    command => "crontab cron-file.txt",
    cwd => "/home/vagrant/",
    path => "/usr/bin",
    require => File['/home/vagrant/cron-file.txt'],
  }
  
}