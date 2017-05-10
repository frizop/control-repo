# Simple SQL Profile to install MSSQL based on share
class profile::sql (

  String $collation = pick($::puppet_vra_property.dig('foo.COLLATION'), 'SQL_Latin1_General_CP1_CI_AS'),
  String $sqlport   = pick($::puppet_vra_property.dig('foo.SqlServer.PortNumber'), '52065'),
  String $sqluser   = pick($::puppet_vra_property.dig('foo.SqlServer.UserName'), 'loggingUser'),
  String $sqlpw     = pick($::puppet_vra_property.dig('foo.SqlServer.Password'), 'Pupp3t1@'),

) {

  notify { 'message':
    message => $::os['family'],
  }

  notify { 'roleclass':
    message => $::puppet_vra_properties['Puppet.RoleClass'],
  }

  notify { 'sqlport':
    message => $::puppet_vra_properties['foo.SqlServer.PortNumber'],
  }

  sqlserver_instance { 'MSSQLSERVER':
    features              => ['SQLEngine', 'Replication', 'FullText'],
    source                => 'c:\\tmp\\foo',
    # agt_svc_account       => '',
    # agt_svc_password      => '',
    # sql_svc_account       => '',
    # sql_svc_password      => '',
    sql_sysadmin_accounts => ['myuser'],
    security_mode         => 'SQL',
    sa_pwd                => 'p@ssw0rd!!',
    install_switches      => {
      'TCPENABLED'   => 1,
      'SQLCOLLATION' => $collation,
      # 'INSTANCEDIR'         => 'C:\\MSSQL11.MSSQLSERVER',
      # 'INSTALLSHAREDDIR'    => 'C:\\Program Files\\Microsoft SQL Server',
      # 'INSTALLSHAREDWOWDIR' => 'C:\\Program Files\\Microsoft SQL Server WOW',
      # 'INSTALLSQLDATADIR'   => 'C:\\MSSQL11.MSSQLSERVER',
      # 'SQLUSERDBLOGDIR'     => 'C:\\MSSQL11.MSSQLSERVER',
      # 'SQLTEMPDBDIR'        => 'C:\\MSSQL11.MSSQLSERVER',
    }
  }

  sqlserver_features { 'Generic Features':
    source   => 'c:\\tmp\\foo',
    features => ['Tools'],
    # is_svc_account  => '',
    # is_svc_password => '',
  }

  # Example of creating the user based on params
  sqlserver::login{ $sqluser:
    instance => 'MSSQLSERVER',
    password => $sqlpw,
  }

  # Default Instance Registery setting for TCP/IP Port
  # HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQLServer\SuperSocketNetLib\TCP\IPAll
  registry_value { 'HKLM\SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL10.MSSQLSERVER\MSSQLServer\SuperSocketNetLib\TCP\IPAll':
    ensure => present,
    type   => string,
    data   => 'The Puppet Agent service periodically manages your configuration',
  }

}
