  
  class profile::wsus::wsus {
  
    # Disable Windows automatic updates
    class { 'wsus_client': 
            server_url             => 'http://10.0.0.5:8530',
            auto_update_option     => "Scheduled",
            scheduled_install_day  => "Sunday",
            scheduled_install_hour => 2,
            enable_status_server => true,
    }
  }
