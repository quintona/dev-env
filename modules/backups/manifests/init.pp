class backups  {
	
  file { "/home/vagrant/cron-file.txt":
    content => "@hourly rsync -ar /usr/local/gitblit/current/git /media/git\n@hourly rsync -ar /var/lib/trac/ /media/trac\n",
    replace => true,
  }
  
  exec { "create-crontab":
    command => "crontab cron-file.txt",
    cwd => "/home/vagrant/",
    path => "/usr/bin",
    require => File['/home/vagrant/cron-file.txt'],
  }
  
}