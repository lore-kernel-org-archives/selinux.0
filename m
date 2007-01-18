Message-ID: <45AFA116.2040807@tresys.com>
Date: Thu, 18 Jan 2007 11:32:22 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [RFC] 3/4 - Hierarchal apache policy for reference policy (file contexts)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Below is the file contexts for the hierarchal apache policy. No 
functional changes should be present, only type name changes.

------------------------------------------

# temporary hack till genhomedircon is fixed
ifdef(`targeted_policy',`
HOME_DIR/((www)|(web)|(public_html))(/.+)? 
gen_context(system_u:object_r:apache_t.user_content,s0)
',`
HOME_DIR/((www)|(web)|(public_html))(/.+)? 
gen_context(system_u:object_r:apache_t.ROLE_content,s0)
')

/etc/apache(2)?(/.*)?            
gen_context(system_u:object_r:apache_t.config,s0)
/etc/apache-ssl(2)?(/.*)?        
gen_context(system_u:object_r:apache_t.config,s0)
/etc/htdig(/.*)?            
gen_context(system_u:object_r:apache_t.sys_content,s0)
/etc/httpd            -d    
gen_context(system_u:object_r:apache_t.config,s0)
/etc/httpd/conf.*            
gen_context(system_u:object_r:apache_t.config,s0)
/etc/httpd/logs                
gen_context(system_u:object_r:apache_t.log,s0)
/etc/httpd/modules            
gen_context(system_u:object_r:apache_t.daemon_modules,s0)
/etc/vhosts            --    
gen_context(system_u:object_r:apache_t.config,s0)

/srv/([^/]*/)?www(/.*)?            
gen_context(system_u:object_r:apache_t.sys_content,s0)
/srv/gallery2(/.*)?            
gen_context(system_u:object_r:apache_t.sys_content,s0)

/usr/bin/htsslpass         --    
gen_context(system_u:object_r:apache_t.helper_exec,s0)

/usr/lib/apache-ssl/.+        --    
gen_context(system_u:object_r:apache_t.daemon_exec,s0)
/usr/lib/cgi-bin(/.*)?            
gen_context(system_u:object_r:apache_t.sys_script_exec,s0)
/usr/lib/squid/cachemgr\.cgi    --    
gen_context(system_u:object_r:apache_t.daemon_exec,s0)
/usr/lib(64)?/apache(/.*)?        
gen_context(system_u:object_r:apache_t.daemon_modules,s0)
/usr/lib(64)?/apache2/modules(/.*)?    
gen_context(system_u:object_r:apache_t.daemon_modules,s0)
/usr/lib(64)?/apache(2)?/suexec(2)? --    
gen_context(system_u:object_r:apache_t.suexec_exec,s0)
/usr/lib(64)?/cgi-bin/(nph-)?cgiwrap(d)? -- 
gen_context(system_u:object_r:apache_t.suexec_exec,s0)
/usr/lib(64)?/httpd(/.*)?        
gen_context(system_u:object_r:apache_t.daemon_modules,s0)

/usr/sbin/apache(2)?        --    
gen_context(system_u:object_r:apache_t.daemon_exec,s0)
/usr/sbin/apache-ssl(2)?    --    
gen_context(system_u:object_r:apache_t.daemon_exec,s0)
/usr/sbin/httpd(\.worker)?    --    
gen_context(system_u:object_r:apache_t.daemon_exec,s0)
/usr/sbin/rotatelogs        --    
gen_context(system_u:object_r:apache_t.rotatelogs_exec,s0)
/usr/sbin/suexec        --    
gen_context(system_u:object_r:apache_t.suexec_exec,s0)

ifdef(`distro_suse', `
/usr/sbin/httpd2-.*        --    
gen_context(system_u:object_r:apache_t.daemon_exec,s0)
')

/usr/share/htdig(/.*)?            
gen_context(system_u:object_r:apache_t.sys_content,s0)
/usr/share/openca/htdocs(/.*)?        
gen_context(system_u:object_r:apache_t.sys_content,s0)
/usr/share/selinux-policy([^/]*)?/html(/.*)? 
gen_context(system_u:object_r:apache_t.sys_content,s0)

/var/cache/httpd(/.*)?            
gen_context(system_u:object_r:apache_t.daemon_cache,s0)
/var/cache/mason(/.*)?            
gen_context(system_u:object_r:apache_t.daemon_cache,s0)
/var/cache/mod_ssl(/.*)?        
gen_context(system_u:object_r:apache_t.daemon_cache,s0)
/var/cache/php-eaccelerator(/.*)?    
gen_context(system_u:object_r:apache_t.daemon_cache,s0)
/var/cache/php-mmcache(/.*)?        
gen_context(system_u:object_r:apache_t.daemon_cache,s0)
/var/cache/rt3(/.*)?            
gen_context(system_u:object_r:apache_t.daemon_cache,s0)
/var/cache/ssl.*\.sem        --    
gen_context(system_u:object_r:apache_t.daemon_cache,s0)

/var/lib/cacti/rra(/.*)?        
gen_context(system_u:object_r:apache_t.sys_content,s0)
/var/lib/dav(/.*)?            
gen_context(system_u:object_r:apache_t.var_lib,s0)
/var/lib/htdig(/.*)?            
gen_context(system_u:object_r:apache_t.sys_content,s0)
/var/lib/httpd(/.*)?            
gen_context(system_u:object_r:apache_t.var_lib,s0)
/var/lib/php/session(/.*)?        
gen_context(system_u:object_r:apache_t.var_run,s0)
/var/lib/squirrelmail/prefs(/.*)?    
gen_context(system_u:object_r:apache_t.squirrelmail,s0)

/var/log/apache(2)?(/.*)?        
gen_context(system_u:object_r:apache_t.log,s0)
/var/log/apache-ssl(2)?(/.*)?        
gen_context(system_u:object_r:apache_t.log,s0)
/var/log/cacti(/.*)?            
gen_context(system_u:object_r:apache_t.log,s0)
/var/log/cgiwrap\.log.*        --    
gen_context(system_u:object_r:apache_t.log,s0)
/var/log/httpd(/.*)?            
gen_context(system_u:object_r:apache_t.log,s0)
ifdef(`distro_debian', `
/var/log/horde2(/.*)?            
gen_context(system_u:object_r:apache_t.log,s0)
')

/var/run/apache.*            
gen_context(system_u:object_r:apache_t.var_run,s0)
/var/run/gcache_port        -s    
gen_context(system_u:object_r:apache_t.var_run,s0)
/var/run/httpd.*            
gen_context(system_u:object_r:apache_t.var_run,s0)

/var/spool/gosa(/.*)?            
gen_context(system_u:object_r:apache_t.sys_script,s0)
/var/spool/squirrelmail(/.*)?        
gen_context(system_u:object_r:apache_t.squirrelmail_spool,s0)

/var/www(/.*)?                
gen_context(system_u:object_r:apache_t.sys_content,s0)
/var/www/cgi-bin(/.*)?            
gen_context(system_u:object_r:apache_t.sys_script_exec,s0)
/var/www/icons(/.*)?            
gen_context(system_u:object_r:apache_t.sys_content,s0)
/var/www/perl(/.*)?            
gen_context(system_u:object_r:apache_t.sys_script_exec,s0)



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
