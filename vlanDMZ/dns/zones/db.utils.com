$TTL    604800
@       IN      SOA     ns1.utils.com. adminmail.utils.com. (
                             2         ; Serial
                        604800         ; Refresh
                         86400         ; Retry
                       2419200         ; Expire
                       604800 )       ; Negative Cache TTL

; Name servers
        IN      NS      ns1.utils.com.

; A records
ns1     IN      A       10.10.0.3          
voting  IN      A       10.10.0.2
calculator IN    A       192.168.20.2
