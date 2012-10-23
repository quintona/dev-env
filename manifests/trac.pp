trac::project {"Izazi":
	repository_path	=>	"/home/vagrant/dev-env/.git",
	description	=>  "Default Project",
	config => "defaults",
} 

trac::project {"MRS":
	repository_path	=>	"/media/git/MRS.git",
	description	=>  "Medical Rebate System",
	config => "defaults",
}

