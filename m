Message-ID: <4ED500C9.1080509@t0mb.net>
Date: Tue, 29 Nov 2011 15:56:57 +0000
From: Tom <tom@t0mb.net>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: First forays in to writing a module to lock down PowerDNS.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Greetings,

This is my first attempt at writing an selinux module.  I've basically 
done it by trying to confine the powerdns service, and then worked 
through all of the problems I've had in the audit log.  At this point, 
my powerdns service seems to work well with full functionality, however, 
I'm sure there's about a million things I could be doing to make it 
better.  I'm still a bit shaky on the way I've done the domain 
transition, and also, I'm sure there are a loads of macros which I could 
be using, although I'm not sure whether those types of things are 
distribution dependent.  I'm using CentOS 5.7, and have written this to 
fit in to the targeted polifcy.

I'd be glad of any advice on how to do this type of thing in a more 
efficient way.

Many thanks.  Tom.

# cat pdns.te
# PowerDNS targeted enforcement module

policy_module(pdns,1.0.0)

require {
   type etc_t;
   type lib_t;
   type usr_t;
   type ld_so_cache_t;
   type ld_so_t;
   type lib_t;
   type locale_t;
   type var_run_t;
   type devlog_t;
   type syslogd_t;
   type initrc_var_run_t;
   type dns_port_t;
   type inaddr_any_node_t;
   type transproxy_port_t;
   type mysqld_port_t;
   type mssql_port_t;
}

type pdns_t;
type pdns_exec_t;

domain_type(pdns_t)
domain_entry_file(pdns_t, pdns_exec_t)
init_daemon_domain(pdns_t, pdns_exec_t)

# /etc/pdns/pdns.conf
type pdns_conf_t;
files_config_file(pdns_conf_t)

# /var/run/pdns.pid
type pdns_var_run_t;
files_pid_file(pdns_var_run_t)

allow pdns_t etc_t:dir search;
allow pdns_t etc_t:file { getattr read };
allow pdns_t usr_t:dir search;
allow pdns_t usr_t:file { write create read getattr };
allow pdns_t lib_t:dir { search getattr };
allow pdns_t lib_t:lnk_file read;
allow pdns_t lib_t:file { read getattr execute };
allow pdns_t ld_so_cache_t:file read;
allow pdns_t ld_so_cache_t:file getattr;
allow pdns_t ld_so_t:file { read execute };
allow pdns_t locale_t:file { read getattr };
allow pdns_t pdns_conf_t:file read;
allow pdns_t var_run_t:dir { write remove_name add_name };
allow pdns_t var_run_t:sock_file { unlink create setattr };
allow pdns_t var_run_t:file { write create };
allow pdns_t devlog_t:sock_file write;
allow pdns_t syslogd_t:unix_dgram_socket sendto;
allow pdns_t initrc_var_run_t:file write;
allow pdns_t pdns_exec_t:file execute_no_trans;

allow pdns_t self:process sigkill;
allow pdns_t self:fifo_file { getattr read ioctl write };
allow pdns_t self:capability { chown fsetid net_bind_service setuid 
setgid kill };
allow pdns_t self:unix_dgram_socket { create connect write };
allow pdns_t self:udp_socket { create bind read getattr write };
allow pdns_t self:tcp_socket { create bind read getattr write setopt 
listen connect shutdown accept getopt ioctl };

allow pdns_t inaddr_any_node_t:udp_socket node_bind;
allow pdns_t inaddr_any_node_t:tcp_socket node_bind;

# TCP + UDP Port 53
allow pdns_t dns_port_t:udp_socket name_bind;
allow pdns_t dns_port_t:tcp_socket name_bind;

# TCP 8081 for PDNS Web Server
allow pdns_t transproxy_port_t:tcp_socket name_bind;

# DB Connectivity
allow pdns_t mysqld_port_t:tcp_socket name_connect;
allow pdns_t mssql_port_t:tcp_socket name_connect;


# cat pdns.fc
/usr/sbin/pdns_server    --    gen_context(system_u:object_r:pdns_exec_t,s0)
/var/run/pdns.pid    --    gen_context(system_u:object_r:pdns_var_run_t,s0)
/etc/pdns/pdns.conf    --    gen_context(system_u:object_r:pdns_conf_t,s0)





--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
