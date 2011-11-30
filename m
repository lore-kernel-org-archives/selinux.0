Message-ID: <4ED65B76.3050107@redhat.com>
Date: Wed, 30 Nov 2011 11:36:06 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Tom <tom@t0mb.net>
CC: SELinux@tycho.nsa.gov
Subject: Re: First forays in to writing a module to lock down PowerDNS.
References: <4ED500C9.1080509@t0mb.net> <4ED50502.1030509@redhat.com> <4ED507D4.101@t0mb.net> <4ED60963.7080006@t0mb.net>
In-Reply-To: <4ED60963.7080006@t0mb.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/30/2011 05:45 AM, Tom wrote:
> Hi Again,
> 
> I've followed your advice, and I've removed all but one requirement
> for var_run_t:sock_file.  I couldn't find any interfaces which
> would simply give me access to that, but it's certainly looking a
> lot better, and a lot more readable!  It could probably do with
> some more re-factoring, but it's working well at the moment!
> 
> I haven't really thought too much about the file labelling.  I've
> only done the daemon binary, config file and /var/run/pdns.pid
> file.  I'm not sure I've followed best practices there at all.
> 
> 
Ok the next rule you need to follow, is if you need to write to a
"Generic" type, then you need to create your own type and potentially
transition to it.

> # PowerDNS targeted enforcement module
> 
> policy_module(pdns,1.0.0)
> 
> require { type var_run_t; }
> 
> type pdns_t; type pdns_exec_t; allow pdns_t pdns_exec_t:file
> execute_no_trans;
> 
> init_daemon_domain(pdns_t, pdns_exec_t)
> 
> # /etc/pdns/pdns.conf type pdns_conf_t; 
> files_config_file(pdns_conf_t)
> 
> # /var/run/pdns.pid type pdns_var_run_t; 
> files_pid_file(pdns_var_run_t)
> 
> # General self privs allow pdns_t self:capability { setuid chown
> fsetid kill setgid }; allow pdns_t self:fifo_file { read getattr
> ioctl };
allow pdns_t self:fifo_file rw_fifo_file_perms;
> allow pdns_t self:process sigkill;
Might want to just add signal_perms;
> allow pdns_t self:tcp_socket { setopt read bind create accept
> write ioctl connect getopt listen };
allow pdns_t self:tcp_socket create_stream_socket_perms;

> allow pdns_t self:udp_socket { read bind create write getattr };
allow pdns_t self:udp_socket create_socket_perms;
> 
> # Cannot figure out an interface to use with this one: allow pdns_t
> var_run_t:sock_file { create setattr };
> 
See below
> # General files access Macros files_read_etc_files(pdns_t) 
> files_manage_usr_files(pdns_t)
You should have you own type?  Whar file in /usr are you rewriting?

> files_read_default_files(pdns_t) files_rw_generic_pids(pdns_t) 
> files_delete_all_pids(pdns_t)
Are you actually deleting other peoples content in /var/run?  Or do
you have your own content in /var/run?

For example something like

manage_dirs_pattern(pdns_t, pdns_var_run_t, pdns_var_run_t)
manage_files_pattern(pdns_t, pdns_var_run_t, pdns_var_run_t)
manage_sock_files_pattern(pdns_t, pdns_var_run_t, pdns_var_run_t)
files_pid_filetrans(pdns_t, pdns_var_run_t, { dir file sock_file })

Then add a matching content in the fc file.

> files_read_config_files(pdns_t) libs_use_lib_files(pdns_t) 
> libs_use_ld_so(pdns_t) miscfiles_read_localization(pdns_t)
> 
> # Core Network corenet_udp_bind_all_nodes(pdns_t) 
> corenet_tcp_bind_all_nodes(pdns_t)
> 
> # Syslog logging_send_syslog_msg(pdns_t)
> 
> # Inbound DNS corenet_udp_bind_dns_port(pdns_t) 
> corenet_udp_sendrecv_dns_port(pdns_t) 
> corenet_tcp_bind_dns_port(pdns_t) 
> corenet_tcp_sendrecv_dns_port(pdns_t)
> 
> # Inbound TCP 8081 for PDNS Web Server 
> corenet_tcp_bind_transproxy_port(pdns_t) 
> corenet_tcp_sendrecv_transproxy_port(pdns_t)
> 
> # Outbound DB Connectivity corenet_tcp_connect_mysqld_port(pdns_t) 
> corenet_tcp_connect_mssql_port(pdns_t)
> 
> 
> Thanks again for your advice.
> 
> Tom.
> 
> 
> On 29/11/11 16:27, Tom wrote:
>> Hi Daniel,
>> 
>> Thanks for this.  I'm just about to leave work, but I'll be
>> looking again in the morning, and I'll get back to you and see
>> what you think of version 1.0.1! :)
>> 
>> Thanks again.  Tom.
>> 
>> 
>> On 29/11/11 16:14, Daniel J Walsh wrote:
> On 11/29/2011 10:56 AM, Tom wrote:
>>>>> Greetings,
>>>>> 
>>>>> This is my first attempt at writing an selinux module.
>>>>> I've basically done it by trying to confine the powerdns
>>>>> service, and then worked through all of the problems I've
>>>>> had in the audit log. At this point, my powerdns service
>>>>> seems to work well with full functionality, however, I'm
>>>>> sure there's about a million things I could be doing to
>>>>> make it better.  I'm still a bit shaky on the way I've done
>>>>> the domain transition, and also, I'm sure there are a loads
>>>>> of macros which I could be using, although I'm not sure 
>>>>> whether those types of things are distribution dependent.
>>>>> I'm using CentOS 5.7, and have written this to fit in to
>>>>> the targeted polifcy.
>>>>> 
>>>>> I'd be glad of any advice on how to do this type of thing
>>>>> in a more efficient way.
>>>>> 
>>>>> Many thanks.  Tom.
>>>>> 
>>>>> # cat pdns.te # PowerDNS targeted enforcement module
>>>>> 
>>>>> policy_module(pdns,1.0.0)
>>>>> 
>>>>> require { type etc_t; type lib_t; type usr_t; type
>>>>> ld_so_cache_t; type ld_so_t; type lib_t; type locale_t;
>>>>> type var_run_t; type devlog_t; type syslogd_t; type
>>>>> initrc_var_run_t; type dns_port_t; type inaddr_any_node_t;
>>>>> type transproxy_port_t; type mysqld_port_t; type
>>>>> mssql_port_t; }
>>>>> 
>>>>> type pdns_t; type pdns_exec_t;
>>>>> 
>>>>> domain_type(pdns_t) domain_entry_file(pdns_t, pdns_exec_t) 
>>>>> init_daemon_domain(pdns_t, pdns_exec_t)
>>>>> 
>>>>> # /etc/pdns/pdns.conf type pdns_conf_t; 
>>>>> files_config_file(pdns_conf_t)
>>>>> 
>>>>> # /var/run/pdns.pid type pdns_var_run_t; 
>>>>> files_pid_file(pdns_var_run_t)
>>>>> 
>>>>> allow pdns_t etc_t:dir search; allow pdns_t etc_t:file {
>>>>> getattr read }; allow pdns_t usr_t:dir search; allow pdns_t
>>>>> usr_t:file { write create read getattr }; allow pdns_t
>>>>> lib_t:dir { search getattr }; allow pdns_t lib_t:lnk_file
>>>>> read; allow pdns_t lib_t:file { read getattr execute };
>>>>> allow pdns_t ld_so_cache_t:file read; allow pdns_t
>>>>> ld_so_cache_t:file getattr; allow pdns_t ld_so_t:file {
>>>>> read execute }; allow pdns_t locale_t:file { read getattr
>>>>> }; allow pdns_t pdns_conf_t:file read; allow pdns_t
>>>>> var_run_t:dir { write remove_name add_name }; allow pdns_t
>>>>> var_run_t:sock_file { unlink create setattr }; allow pdns_t
>>>>> var_run_t:file { write create }; allow pdns_t 
>>>>> devlog_t:sock_file write; allow pdns_t
>>>>> syslogd_t:unix_dgram_socket sendto; allow pdns_t
>>>>> initrc_var_run_t:file write; allow pdns_t pdns_exec_t:file
>>>>> execute_no_trans;
>>>>> 
>>>>> allow pdns_t self:process sigkill; allow pdns_t
>>>>> self:fifo_file { getattr read ioctl write }; allow pdns_t
>>>>> self:capability { chown fsetid net_bind_service setuid
>>>>> setgid kill }; allow pdns_t self:unix_dgram_socket { create
>>>>> connect write }; allow pdns_t self:udp_socket { create bind
>>>>> read getattr write }; allow pdns_t self:tcp_socket { create
>>>>> bind read getattr write setopt listen connect shutdown
>>>>> accept getopt ioctl };
>>>>> 
>>>>> allow pdns_t inaddr_any_node_t:udp_socket node_bind; allow
>>>>> pdns_t inaddr_any_node_t:tcp_socket node_bind;
>>>>> 
>>>>> # TCP + UDP Port 53 allow pdns_t dns_port_t:udp_socket
>>>>> name_bind; allow pdns_t dns_port_t:tcp_socket name_bind;
>>>>> 
>>>>> # TCP 8081 for PDNS Web Server allow pdns_t 
>>>>> transproxy_port_t:tcp_socket name_bind;
>>>>> 
>>>>> # DB Connectivity allow pdns_t mysqld_port_t:tcp_socket 
>>>>> name_connect; allow pdns_t mssql_port_t:tcp_socket
>>>>> name_connect;
>>>>> 
>>>>> 
>>>>> # cat pdns.fc /usr/sbin/pdns_server    -- 
>>>>> gen_context(system_u:object_r:pdns_exec_t,s0)
>>>>> /var/run/pdns.pid --
>>>>> gen_context(system_u:object_r:pdns_var_run_t,s0) 
>>>>> /etc/pdns/pdns.conf    -- 
>>>>> gen_context(system_u:object_r:pdns_conf_t,s0)
>>>>> 
>>>>> 
>>>>> 
>>>>> 
>>>>> 
>>>>> -- This message was distributed to subscribers of the
>>>>> selinux mailing list. If you no longer wish to subscribe,
>>>>> send mail to majordomo@tycho.nsa.gov with the words
>>>>> "unsubscribe selinux" without quotes as the message.
> 
> Tom try to remove the entire require block.  You should be using 
> interfaces and not using the types directly in your policy.
> 
> All interfaces are available under
> /usr/share/selinux/devel/include/...
> 
> For example.
>>>>> allow pdns_t etc_t:dir search; allow pdns_t etc_t:file {
>>>>> getattr read }; allow pdns_t usr_t:dir search; allow pdns_t
>>>>> usr_t:file { write create read getattr };
> Should be
> 
> files_read_etc_files(pdns_t) files_read_usr_files(pdns_t)
> 
> 
>>>>> allow pdns_t transproxy_port_t:tcp_socket name_bind;
> Should be
> 
> corenet_tcp_bind_transproxy_port(pdns_t)
>> 
>> 
>> -- This message was distributed to subscribers of the selinux
>> mailing list. If you no longer wish to subscribe, send mail to 
>> majordomo@tycho.nsa.gov with the words "unsubscribe selinux"
>> without quotes as the message.
> 
> 
> -- This message was distributed to subscribers of the selinux
> mailing list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux"
> without quotes as the message.
> 
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7WW3YACgkQrlYvE4MpobO1DgCgsHHTO6M+oMRKm6XEIDroPdy1
q4gAoLUwdZEqg4RZ4XztIGH8jlpq53P6
=O79Q
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
