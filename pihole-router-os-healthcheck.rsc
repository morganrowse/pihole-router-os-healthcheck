:global piholeURL "http://<your_pihole_ip>/admin/api.php\?status&auth=<your_pihole_api_key>"
:global piholeDNS "<your_pihole_ip>"
:global piholeDNSList "<your_pihole_ip>"
:global backupDNS "<your_backup_dns_list_comma_seperated>"

:do {
  :local result [/tool fetch url=$piholeURL as-value output=user];
        :if ($result->"data" = "{\"status\":\"enabled\"}") do={
            :if ([/ip dns get servers] != $piholeDNS ) do={
              /ip dns set servers=$piholeDNSList
            }
        } else={
            /ip dns set servers=$backupDNS
        }
} on-error={
  /ip dns set servers=$backupDNS 
}
