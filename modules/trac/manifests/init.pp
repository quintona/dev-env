# Each trac is configured with the following files :
#
# * /var/lib/trac/<project>/conf/trac.ini
# * /etc/trac/trac.ini
# * /etc/trac/trac.defaults
#
# These files are defined into :
#
# * templates/trac/trac.ini
# * files/trac/trac.ini.<project> (customize this file)
# * files/trac/trac.ini (global settings)
# * files/trac/trac.defaults (do not modify, generated by trac)

class trac {
  package { trac: ensure => latest }
  package { trac-git: ensure => latest }
  package { libjs-jquery: }
  package { enscript: }
  package { python-subversion: }
  package { libapache2-mod-auth-pam: }
  package { libapache2-mod-fcgid: }
  
  # Directory to store all trac projects
  file { "/var/lib/trac":
    ensure => directory
  }

  # Contains trac.ini generated by trac
  file { "/etc/trac/trac.defaults":
    source => "puppet:///trac/trac.defaults",
    require => Package[trac]
  }

  # Customize settings for all projects
  file { "/etc/trac/trac.ini":
    source => ["puppet:///files/trac/trac.ini", "puppet:///trac/trac.ini"],
    require => [Package[trac], File["/etc/trac/trac.defaults"]]
  }


  #TODO: add trac and git hooks
  
  #create a trac admin user
  exec { "trac-admin-user-htpasswd":
    command => "htpasswd -b -c htpasswd admin password",
    cwd => "/var/lib/trac",
    path => "/usr/bin",
    creates => "/var/lib/trac/htpasswd",
  }
    

  define project($repository_path = '', $description = '', $config = '') {
    include trac

    $real_repository_path = $repository_path ? {
        '' => "/srv/git/$name",
        default => $repository_path
    }

    # Directory to store the trac project
    file { "/var/lib/trac/$name":
      ensure => directory,
      mode => 2775,
      group => www-data
    }

    # Create the trac project
    exec { "trac-initenv-$name":
      # Add a chmod -R g+w to fix permissions
      command => "trac-admin /var/lib/trac/$name initenv $name sqlite:db/trac.db git file://$real_repository_path && chmod -R g+w /var/lib/trac/$name/*",
      path => "/usr/bin",
      user => "www-data",
      group => "www-data",
      creates => "/var/lib/trac/$name/db/trac.db",
      require => [File["/var/lib/trac/$name"], Package[trac-git]]
    }
    
    

    $real_config = $config ? {
      '' => "files/trac/trac.ini.$name",
      default => $config
    }

    # Install a trac.ini file for each project
    #
    # This file contains generated values and then the content of files/trac/trac.ini.$name
    file { "/var/lib/trac/$name/conf/trac.ini":
      owner => "www-data",
      group => "www-data",
      content => template("trac/trac.ini"),
      require => [Exec["trac-initenv-$name"], File["/etc/trac/trac.ini"]]
    }
    
    #create a trac admin user for this project
    exec { "trac-admin-user-$name":
      command => "trac-admin /var/lib/trac/$name/ permission add admin TRAC_ADMIN",
      path => "/usr/bin",
      require => Exec["trac-initenv-$name"],
      returns => [0,1,2],
    }

    # Should be executed only by the first project
    exec { "tracadmin-deploy-$name":
      command => "trac-admin /var/lib/trac/$name deploy /var/www/trac && chmod +x /var/www/trac/cgi-bin/trac.cgi /var/www/trac/cgi-bin/trac.fcgi",
      path => "/usr/bin",
      creates => "/var/www/trac/cgi-bin/trac.cgi",
      require => Exec["trac-initenv-$name"]
    }
  }

  file { "/usr/local/bin/trac-robotstxt":
    source => "puppet:///trac/trac-robotstxt",
    mode => 755
  }

  file { "/usr/share/trac/plugins":
    ensure => directory,
    require => Package[trac]
  }

  file { "/var/cache/trac":
    owner => www-data,
    ensure => directory,
    require => Package[trac]
  }
  
  #apache config
  file { "/etc/apache2/sites-available/trac-site":
    source => "puppet:///trac/trac-site",
    require => [Package[libapache2-mod-fcgid], Package[libapache2-mod-auth-pam]],
    replace => true,
  }
  
  file { "/etc/apache2/sites-enabled/trac-site":
    source => "puppet:///trac/trac-site",
    require => [Package[libapache2-mod-fcgid], Package[libapache2-mod-auth-pam]],
    replace => true,
  }
  
  exec {"restart-apache2":
  	command => "/etc/init.d/apache2 restart",
  	require => [File["/etc/apache2/sites-enabled/trac-site"],File["/etc/apache2/sites-available/trac-site"]],
  }
}