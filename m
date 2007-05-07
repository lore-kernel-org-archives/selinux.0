Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l47G1kk7027151
	for <selinux@tycho.nsa.gov>; Mon, 7 May 2007 12:01:46 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l47G1iMp022202
	for <selinux@tycho.nsa.gov>; Mon, 7 May 2007 16:01:45 GMT
Message-ID: <463F4D58.7000702@redhat.com>
Date: Mon, 07 May 2007 12:01:28 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: Re: apcupsd policy
References: <200704201926.l3KJQuOH027268@redsox.boston.devel.redhat.com> <1178549446.25271.6.camel@sgc>
In-Reply-To: <1178549446.25271.6.camel@sgc>
Content-Type: multipart/mixed;
 boundary="------------000804000101010105010301"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000804000101010105010301
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Christopher J. PeBenito wrote:
> On Fri, 2007-04-20 at 15:26 -0400, dwalsh@redhat.com wrote:
>   
>> --- nsaserefpolicy/policy/modules/services/apcupsd.fc	1969-12-31 19:00:00.000000000 -0500
>> +++ serefpolicy-2.5.12/policy/modules/services/apcupsd.fc	2007-04-11 17:07:34.000000000 -0400
>> @@ -0,0 +1,9 @@
>> +
>> +/usr/sbin/apcupsd		--	gen_context(system_u:object_r:apcupsd_exec_t,s0)
>> +/var/log/apcupsd\.events.*		--	gen_context(system_u:object_r:apcupsd_log_t,s0)
>> +/var/run/apcupsd\.pid		--	gen_context(system_u:object_r:apcupsd_var_run_t,s0)
>> +
>> +/var/www/apcupsd/multimon.cgi		--	gen_context(system_u:object_r:httpd_apcupsd_cgi_script_exec_t,s0)
>> +/var/www/apcupsd/upsfstats.cgi		--	gen_context(system_u:object_r:httpd_apcupsd_cgi_script_exec_t,s0)
>> +/var/www/apcupsd/upsimage.cgi		--	gen_context(system_u:object_r:httpd_apcupsd_cgi_script_exec_t,s0)
>> +/var/www/apcupsd/upsstats.cgi		--	gen_context(system_u:object_r:httpd_apcupsd_cgi_script_exec_t,s0)
>> --- nsaserefpolicy/policy/modules/services/apcupsd.if	1969-12-31 19:00:00.000000000 -0500
>> +++ serefpolicy-2.5.12/policy/modules/services/apcupsd.if	2007-04-11 17:07:34.000000000 -0400
>> @@ -0,0 +1,108 @@
>> +
>> +## <summary>policy for apcupsd</summary>
>> +
>> +########################################
>> +## <summary>
>> +##	Execute a domain transition to run apcupsd.
>> +## </summary>
>> +## <param name="domain">
>> +## <summary>
>> +##	Domain allowed to transition.
>> +## </summary>
>> +## </param>
>> +#
>> +interface(`apcupsd_domtrans',`
>> +	gen_require(`
>> +		type apcupsd_t, apcupsd_exec_t;
>> +	')
>> +
>> +	domain_auto_trans($1,apcupsd_exec_t,apcupsd_t)
>> +
>> +	allow apcupsd_t $1:fd use;
>> +	allow apcupsd_t $1:fifo_file rw_file_perms;
>> +	allow apcupsd_t $1:process sigchld;
>> +')
>> +
>> +########################################
>> +## <summary>
>> +##	Read apcupsd PID files.
>> +## </summary>
>> +## <param name="domain">
>> +##	<summary>
>> +##	Domain allowed access.
>> +##	</summary>
>> +## </param>
>> +#
>> +interface(`apcupsd_read_pid_files',`
>> +	gen_require(`
>> +		type apcupsd_var_run_t;
>> +	')
>> +
>> +	files_search_pids($1)
>> +	allow $1 apcupsd_var_run_t:file r_file_perms;
>> +')
>> +
>> +
>> +########################################
>> +## <summary>
>> +##	Allow the specified domain to read apcupsd's log files.
>> +## </summary>
>> +## <param name="domain">
>> +##	<summary>
>> +##	Domain allowed access.
>> +##	</summary>
>> +## </param>
>> +## <rolecap/>
>> +#
>> +interface(`apcupsd_read_log',`
>> +	gen_require(`
>> +		type apcupsd_log_t;
>> +	')
>> +
>> +	logging_search_logs($1)
>> +	allow $1 apcupsd_log_t:dir r_dir_perms;
>> +	allow $1 apcupsd_log_t:file { read getattr lock };
>> +')
>> +
>> +########################################
>> +## <summary>
>> +##	Allow the specified domain to append
>> +##	apcupsd log files.
>> +## </summary>
>> +## <param name="domain">
>> +## 	<summary>
>> +##	Domain allowed to transition.
>> +## 	</summary>
>> +## </param>
>> +#
>> +interface(`apcupsd_append_log',`
>> +	gen_require(`
>> +		type var_log_t, apcupsd_log_t;
>> +	')
>> +
>> +	logging_search_logs($1)
>> +	allow $1 apcupsd_log_t:dir r_dir_perms;
>> +	allow $1 apcupsd_log_t:file { getattr append };
>> +')
>> +
>> +########################################
>> +## <summary>
>> +##	Execute a domain transition to run httpd_apcupsd_cgi_script.
>> +## </summary>
>> +## <param name="domain">
>> +## <summary>
>> +##	Domain allowed to transition.
>> +## </summary>
>> +## </param>
>> +#
>> +interface(`httpd_apcupsd_cgi_script_domtrans',`
>> +	gen_require(`
>> +		type httpd_apcupsd_cgi_script_t, httpd_apcupsd_cgi_script_exec_t;
>> +	')
>> +
>> +	domain_auto_trans($1,httpd_apcupsd_cgi_script_exec_t,httpd_apcupsd_cgi_script_t)
>> +
>> +	allow httpd_apcupsd_cgi_script_t $1:fd use;
>> +	allow httpd_apcupsd_cgi_script_t $1:fifo_file rw_file_perms;
>> +	allow httpd_apcupsd_cgi_script_t $1:process sigchld;
>> +')
>> --- nsaserefpolicy/policy/modules/services/apcupsd.te	1969-12-31 19:00:00.000000000 -0500
>> +++ serefpolicy-2.5.12/policy/modules/services/apcupsd.te	2007-04-12 15:16:19.000000000 -0400
>> @@ -0,0 +1,91 @@
>> +policy_module(apcupsd,1.0.0)
>> +
>> +########################################
>> +#
>> +# Declarations
>> +#
>> +
>> +type apcupsd_t;
>> +type apcupsd_exec_t;
>> +domain_type(apcupsd_t)
>> +init_daemon_domain(apcupsd_t, apcupsd_exec_t)
>> +
>> +type apcupsd_lock_t;
>> +files_lock_file(apcupsd_lock_t)
>> +
>> +type apcupsd_log_t;
>> +logging_log_file(apcupsd_log_t)
>> +
>> +type apcupsd_var_run_t;
>> +files_pid_file(apcupsd_var_run_t)
>> +
>> +########################################
>> +#
>> +# apcupsd local policy
>> +#
>> +
>> +# Init script handling
>> +init_use_fds(apcupsd_t)
>> +init_use_script_ptys(apcupsd_t)
>> +domain_use_interactive_fds(apcupsd_t)
>> +
>> +allow apcupsd_t self:fifo_file rw_file_perms;
>> +allow apcupsd_t self:unix_stream_socket create_stream_socket_perms;
>> +allow apcupsd_t self:tcp_socket create_stream_socket_perms;
>> +
>> +corenet_tcp_bind_apcupsd_port(apcupsd_t)
>> +corenet_tcp_bind_all_nodes(apcupsd_t)
>> +corenet_tcp_sendrecv_generic_if(apcupsd_t)
>> +corenet_tcp_sendrecv_all_nodes(apcupsd_t)
>> +corenet_tcp_sendrecv_all_ports(apcupsd_t)
>> +
>> +dev_rw_generic_usb_dev(apcupsd_t)
>> +
>> +files_read_etc_files(apcupsd_t)
>> +files_search_locks(apcupsd_t)
>> +
>> +libs_use_ld_so(apcupsd_t)
>> +libs_use_shared_libs(apcupsd_t)
>> +
>> +miscfiles_read_localization(apcupsd_t)
>> +
>> +ifdef(`targeted_policy',`
>> +	term_dontaudit_use_unallocated_ttys(apcupsd_t)
>> +	term_dontaudit_use_generic_ptys(apcupsd_t)
>> +')
>> +
>> +allow apcupsd_t apcupsd_lock_t:file manage_file_perms;
>> +files_lock_filetrans(apcupsd_t,apcupsd_lock_t,file)
>> +
>> +allow apcupsd_t apcupsd_log_t:file manage_file_perms;
>> +allow apcupsd_t apcupsd_log_t:dir { rw_dir_perms setattr };
>> +logging_log_filetrans(apcupsd_t,apcupsd_log_t,{ file dir })
>> +
>> +allow apcupsd_t apcupsd_var_run_t:file manage_file_perms;
>> +allow apcupsd_t apcupsd_var_run_t:dir rw_dir_perms;
>> +files_pid_filetrans(apcupsd_t,apcupsd_var_run_t, file)
>> +
>> +logging_send_syslog_msg(apcupsd_t)
>> +
>> +########################################
>> +#
>> +# apcupsd_cgi Declarations
>> +#
>> +
>> +apache_content_template(apcupsd_cgi)
>> +
>> +# Default Networking
>> +sysnet_dns_name_resolve(httpd_apcupsd_cgi_script_t)
>> +corenet_non_ipsec_sendrecv(httpd_apcupsd_cgi_script_t)
>> +
>> +allow httpd_apcupsd_cgi_script_t self:tcp_socket create_stream_socket_perms;
>> +corenet_tcp_sendrecv_all_if(httpd_apcupsd_cgi_script_t)
>> +corenet_tcp_sendrecv_all_nodes(httpd_apcupsd_cgi_script_t)
>> +corenet_tcp_sendrecv_all_ports(httpd_apcupsd_cgi_script_t)
>> +corenet_tcp_connect_apcupsd_port(httpd_apcupsd_cgi_script_t)
>> +
>> +allow httpd_apcupsd_cgi_script_t self:udp_socket create_socket_perms;
>> +corenet_udp_sendrecv_all_if(httpd_apcupsd_cgi_script_t)
>> +corenet_udp_sendrecv_all_nodes(httpd_apcupsd_cgi_script_t)
>> +corenet_udp_sendrecv_all_ports(httpd_apcupsd_cgi_script_t)
>> +
>>     
>
> Merged, except for the cgi part.  Also some reordering.  The apcupsd
> port definition was missing so I commented out the relevant lines for
> now.
>
>   

Added the network defs.
apcupsd signals itself also.

--------------000804000101010105010301
Content-Type: text/x-patch;
 name="apcupsd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="apcupsd.patch"

--- nsaserefpolicy/policy/modules/services/apcupsd.fc	2007-05-07 11:11:55.000000000 -0400
+++ serefpolicy-2.6.4/policy/modules/services/apcupsd.fc	2007-05-07 11:45:20.000000000 -0400
@@ -3,3 +3,8 @@
 /var/log/apcupsd\.events.*	--	gen_context(system_u:object_r:apcupsd_log_t,s0)
 
 /var/run/apcupsd\.pid		--	gen_context(system_u:object_r:apcupsd_var_run_t,s0)
+
+/var/www/apcupsd/multimon.cgi		--	gen_context(system_u:object_r:httpd_apcupsd_cgi_script_exec_t,s0)
+/var/www/apcupsd/upsfstats.cgi		--	gen_context(system_u:object_r:httpd_apcupsd_cgi_script_exec_t,s0)
+/var/www/apcupsd/upsimage.cgi		--	gen_context(system_u:object_r:httpd_apcupsd_cgi_script_exec_t,s0)
+/var/www/apcupsd/upsstats.cgi		--	gen_context(system_u:object_r:httpd_apcupsd_cgi_script_exec_t,s0)
--- nsaserefpolicy/policy/modules/services/apcupsd.if	2007-05-07 11:11:55.000000000 -0400
+++ serefpolicy-2.6.4/policy/modules/services/apcupsd.if	2007-05-07 11:45:44.000000000 -0400
@@ -79,3 +79,25 @@
 	allow $1 apcupsd_log_t:dir list_dir_perms;
 	allow $1 apcupsd_log_t:file { getattr append };
 ')
+
+########################################
+## <summary>
+##	Execute a domain transition to run httpd_apcupsd_cgi_script.
+## </summary>
+## <param name="domain">
+## <summary>
+##	Domain allowed to transition.
+## </summary>
+## </param>
+#
+interface(`httpd_apcupsd_cgi_script_domtrans',`
+	gen_require(`
+		type httpd_apcupsd_cgi_script_t, httpd_apcupsd_cgi_script_exec_t;
+	')
+
+	domain_auto_trans($1,httpd_apcupsd_cgi_script_exec_t,httpd_apcupsd_cgi_script_t)
+
+	allow httpd_apcupsd_cgi_script_t $1:fd use;
+	allow httpd_apcupsd_cgi_script_t $1:fifo_file rw_file_perms;
+	allow httpd_apcupsd_cgi_script_t $1:process sigchld;
+')
--- nsaserefpolicy/policy/modules/services/apcupsd.te	2007-05-07 11:11:55.000000000 -0400
+++ serefpolicy-2.6.4/policy/modules/services/apcupsd.te	2007-05-07 11:56:18.000000000 -0400
@@ -24,6 +24,7 @@
 # apcupsd local policy
 #
 
+allow apcupsd_t self:process signal;
 allow apcupsd_t self:fifo_file rw_file_perms;
 allow apcupsd_t self:unix_stream_socket create_stream_socket_perms;
 allow apcupsd_t self:tcp_socket create_stream_socket_perms;
@@ -43,8 +44,8 @@
 corenet_tcp_sendrecv_all_nodes(apcupsd_t)
 corenet_tcp_sendrecv_all_ports(apcupsd_t)
 corenet_tcp_bind_all_nodes(apcupsd_t)
-#corenet_tcp_bind_apcupsd_port(apcupsd_t)
-#corenet_sendrecv_apcupsd_server_packets(apcupsd_t)
+corenet_tcp_bind_apcupsd_port(apcupsd_t)
+corenet_sendrecv_apcupsd_server_packets(apcupsd_t)
 
 dev_rw_generic_usb_dev(apcupsd_t)
 
@@ -65,3 +66,26 @@
 	term_dontaudit_use_unallocated_ttys(apcupsd_t)
 	term_dontaudit_use_generic_ptys(apcupsd_t)
 ')
+
+########################################
+#
+# apcupsd_cgi Declarations
+#
+
+apache_content_template(apcupsd_cgi)
+
+# Default Networking
+sysnet_dns_name_resolve(httpd_apcupsd_cgi_script_t)
+corenet_non_ipsec_sendrecv(httpd_apcupsd_cgi_script_t)
+
+allow httpd_apcupsd_cgi_script_t self:tcp_socket create_stream_socket_perms;
+corenet_tcp_sendrecv_all_if(httpd_apcupsd_cgi_script_t)
+corenet_tcp_sendrecv_all_nodes(httpd_apcupsd_cgi_script_t)
+corenet_tcp_sendrecv_all_ports(httpd_apcupsd_cgi_script_t)
+corenet_tcp_connect_apcupsd_port(httpd_apcupsd_cgi_script_t)
+
+allow httpd_apcupsd_cgi_script_t self:udp_socket create_socket_perms;
+corenet_udp_sendrecv_all_if(httpd_apcupsd_cgi_script_t)
+corenet_udp_sendrecv_all_nodes(httpd_apcupsd_cgi_script_t)
+corenet_udp_sendrecv_all_ports(httpd_apcupsd_cgi_script_t)
+
--- nsaserefpolicy/policy/modules/kernel/corenetwork.te.in	2007-05-07 10:32:44.000000000 -0400
+++ serefpolicy-2.6.4/policy/modules/kernel/corenetwork.te.in	2007-05-07 11:27:37.000000000 -0400
@@ -60,6 +65,7 @@
 network_port(amanda, udp,10080,s0, tcp,10080,s0, udp,10081,s0, tcp,10081,s0, tcp,10082,s0, tcp,10083,s0)
 network_port(amavisd_recv, tcp,10024,s0)
 network_port(amavisd_send, tcp,10025,s0)
+network_port(apcupsd, tcp,3551,s0, udp,3551,s0)
 network_port(asterisk, tcp,1720,s0, udp,2427,s0, udp,2727,s0, udp,4569,s0, udp,5060,s0)
 network_port(auth, tcp,113,s0)
 network_port(bgp, tcp,179,s0, udp,179,s0, tcp,2605,s0, udp,2605,s0)

--------------000804000101010105010301--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
