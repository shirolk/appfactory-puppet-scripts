class wso2::am ( $version, 
		   $offset=0, 
		   $tribes_port=4000, 
		   $config_db=governance, 
		   $maintenance_mode=true, 
		   $depsync=false, 
		   $sub_cluster_domain=mgt,
		   $owner=root,
		   $group=root,
		   $target="/mnt" ) {
	
	$deployment_code	= "am"

	$stratos_version 	= $version
	$service_code 		= "am"
	$carbon_home		= "${target}/wso2${service_code}-${stratos_version}"

	$service_templates 	=  [
					"conf/api-manager.xml",
					"conf/axis2/axis2.xml", 
					"conf/carbon.xml",
					"conf/registry.xml",
					"conf/user-mgt.xml",
					"conf/tomcat/catalina-server.xml",
          "deployment/server/jaggeryapps/store/site/conf/site.json",
          "deployment/server/jaggeryapps/publisher/site/conf/site.json",
          "conf/datasources/master-datasources.xml",
				]
	$common_templates 	=  []

	tag ($service_code) 

        define pushtemplates ( $directory, $target ) {
        
                file { "${target}/repository/${name}":
                        owner   => $owner,
                        group   => $group,
                        mode    => 755,
                        content => template("${directory}/${name}.erb"),
                        ensure  => present,
                }
        }

	cleandeployment { $deployment_code:
		mode		=> $maintenance_mode,
                target          => $carbon_home,
	}

	initializedeployment { $deployment_code:
		repo		=> $package_repo,
		version         => $stratos_version,
		mode		=> $maintenance_mode,
		service		=> $service_code,
		local_dir       => $local_package_dir,
		owner		=> $owner,
		target   	=> $target,
		require		=> WSO2::CleanDeployment[$deployment_code],
	}

	deployservice { $deployment_code:
		service		=> $service_code,	
		security	=> "true",
		owner		=> $owner,
		group		=> $group,
		target		=> $carbon_home,
		require		=> WSO2::InitializeDeployment[$deployment_code],
	}

#	if $sub_cluster_domain == "worker" {
#		createworker { $deployment_code:
#			target	=> $carbon_home,
#			require	=> WSO2::DeployService[$deployment_code],
#		}
#	}	
	
	pushtemplates { 
		$service_templates: 
		target		=> $carbon_home,
		directory 	=> $service_code,
		require 	=> WSO2::DeployService[$deployment_code];

		$common_templates:
		target          => $carbon_home,
    directory       => "commons",
		require 	=> WSO2::DeployService[$deployment_code],
	}

	startservice { $deployment_code:
		owner		=> $owner,
                target          => $carbon_home,
		require		=> [ WSO2::InitializeDeployment[$deployment_code],
				     WSO2::DeployService[$deployment_code],
				     PushTemplates[$service_templates],
				     PushTemplates[$common_templates], 
				   ],
	}
}

