Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n486TeXW025171
	for <selinux@tycho.nsa.gov>; Fri, 8 May 2009 02:29:40 -0400
Received: from tyo201.gate.nec.co.jp (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n486Rwet013157
	for <selinux@tycho.nsa.gov>; Fri, 8 May 2009 06:27:59 GMT
Message-ID: <4A03D145.2040901@ak.jp.nec.com>
Date: Fri, 08 May 2009 15:29:25 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Refpolicy <refpolicy@oss.tresys.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH] An interface to allow web-apps minimum privileges (Re: [RFC]
 mod_selinux security policy)
References: <49F69A33.2070601@ak.jp.nec.com> <4A025C03.50907@ak.jp.nec.com>
In-Reply-To: <4A025C03.50907@ak.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------060106080709090804030009"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060106080709090804030009
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

The purpose of the attached patch is a proof of the concent, and I don't
intend it to be commited soon.

This patch provides two new interfaces to apache.if which enables to allow
a web application domain shares minimum necessary privileges to perform
as a part of the web server process (httpd_t).

When we assign an individual security context on a web application handler,
it needs to be bounded to httpd_t due to the hardwired constraint for
multi-threading process.

The mod_selinux.so is a loadable module for apache web server, which enables
to assign a bounded security context (based on http authentication) prior to
invocations of web application handler.
However, it also performs as a part of web server process, so needs minimum
necessary privileges to play a role as a web server process, not only web
application instance. For example, if web application instance writes out
a log message, it means the thread should have a set of privileges to append
a record on /var/log/httpd/error_log.

Most of the apache_base_webapp() come from apache.te with a bit modification.
(So, there is no assurance whether it is really minimum necessary privileges,
or not.) It allows a domain to perform as a part of web server process. If we
have such kind of interface in the upstream policy, it will enable policy
authors to focus on access controls for web contents.

What is your opinion? Any comments please,

Thanks,

KaiGai Kohei wrote:
> KaiGai Kohei wrote:
>> Folks,
>>
>> Nowadays, I'm also under development for a loadable module on apache/httpd,
>> named as mod_selinux.so. It enables to launch web-applications with an
>> individual security context based on http-authenticated users.
>> It internally uses a one-time worker thread for each connections to perform
>> as a restrictive domain bounded to httpd_t due to the hard-wired rule for
>> multi-threading process.
>>
>> In the LCA2009 demonstration, all we can show was individual MCS category
>> per http-users because of lack of TE policy.
>> The following ugly policy is an example of TE policy for mod_selinux.so.
>>
>>  http://code.google.com/p/sepgsql/source/browse/misc/mod_selinux/mod_selinux.te
>>  http://code.google.com/p/sepgsql/source/browse/misc/mod_selinux/mod_selinux.if
>>
>> We needed to remain a minimum set of privileges on the bounded domains because
>> they also perform as a part of the daemon process, although they are restricted
>> to access to the web contents or database objects.
>> (Thus, it allows webapp_type to write on log files, for example.)
>>
>> In my hope, if we can have a interface to assign the minimum set of privileges
>> on the bounded domain, it will be helpfull for authors of web applications
>> which provide its own security policy. It will enables them to focus on writing
>> their policy for web contents.
> 
> One possible idea is to define a new attribute (e.g httpd_server_type) which
> contains httpd_t and other domains for built-in web applications.
> A minimum set of privileges to perform as a web server process is allowed
> on the httpd_server_type, and rest of permissions are allowed on individual
> types.
> 
> Or, add a new template/interface to allow minimum privilges to perform as
> a web server process (e.g httpd_server_domain), then httpd_t and other
> domains for built-in web applications uses this template/interface.
> 
> Anyway, the mod_selinux currently copies and pastes a part of policies for
> apache, but it is not basically good due to the code duplication.
> 
> I would like to get any comments prior to the pushing the package to Fedora.
> 
> Thanks,

-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------060106080709090804030009
Content-Type: text/x-patch;
 name="refpolicy-webapp-interface.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="refpolicy-webapp-interface.patch"

Index: apache.te
===================================================================
--- apache.te	(revision 2982)
+++ apache.te	(working copy)
@@ -111,6 +111,9 @@
 attribute httpdcontent;
 attribute httpd_user_content_type;
 
+# domains that can perform as a server process
+attribute httpd_server_domains;
+
 # domains that can exec all users scripts
 attribute httpd_exec_scripts;
 
@@ -123,6 +126,7 @@
 type httpd_t;
 type httpd_exec_t;
 init_daemon_domain(httpd_t, httpd_exec_t)
+typeattribute httpd_t httpd_server_domains;
 role system_r types httpd_t;
 
 # httpd_cache_t is the type given to the /var/cache/httpd
Index: apache.if
===================================================================
--- apache.if	(revision 2982)
+++ apache.if	(working copy)
@@ -308,6 +308,182 @@
 
 ########################################
 ## <summary>
+##	Allow a domain to perform as a web server process
+##	with necessary minimum privileges.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`apache_base_webapp',`
+	gen_require(`
+		attribute httpd_server_domains;
+		type httpd_t;
+		type httpd_config_t;
+		type httpd_log_t;
+		type httpd_sys_content_t;
+		type httpd_suexec_exec_t;
+	')
+	########################################
+	#
+	# Local declarations
+	#
+	typeattribute $1 httpd_server_domains;
+
+	typebounds httpd_t $1;
+
+	allow httpd_t $1:process { dyntransition };
+	role system_r types $1;
+
+	########################################
+	#
+	# Minimum privileges to perform as a part of httpd
+	#
+	allow $1 httpd_server_domains:process ~{ ptrace setcurrent setexec setfscreate setrlimit execmem execstack execheap };
+	allow $1 httpd_server_domains:fd use;
+	allow $1 httpd_server_domains:sock_file read_sock_file_perms;
+	allow $1 httpd_server_domains:fifo_file rw_fifo_file_perms;
+	allow $1 httpd_server_domains:shm rw_shm_perms;
+	allow $1 httpd_server_domains:sem rw_sem_perms;
+	allow $1 httpd_server_domains:msgq rw_msgq_perms;
+	allow $1 httpd_server_domains:msg { send receive };
+	allow $1 httpd_server_domains:unix_dgram_socket { rw_socket_perms sendto };
+	allow $1 httpd_server_domains:unix_stream_socket { rw_socket_perms connectto };
+	allow $1 httpd_server_domains:tcp_socket rw_socket_perms;
+	allow $1 httpd_server_domains:udp_socket rw_socket_perms;
+
+	# allow to read the web servers config files
+	allow $1 httpd_config_t:dir list_dir_perms;
+	read_files_pattern($1, httpd_config_t, httpd_config_t)
+	read_lnk_files_pattern($1, httpd_config_t, httpd_config_t)
+
+	# allow to append the web servers log files
+	allow $1 httpd_log_t:dir setattr;
+	create_files_pattern($1, httpd_log_t, httpd_log_t)
+	append_files_pattern($1, httpd_log_t, httpd_log_t)
+	read_files_pattern($1, httpd_log_t, httpd_log_t)
+	read_lnk_files_pattern($1, httpd_log_t, httpd_log_t)
+	logging_log_filetrans($1, httpd_log_t, file)
+
+	# SuExec
+	allow $1 httpd_suexec_exec_t:file read_file_perms;
+
+	# Read-only accesses to system contents
+	allow $1 httpd_sys_content_t:dir list_dir_perms;
+	read_files_pattern($1, httpd_sys_content_t, httpd_sys_content_t)
+	read_lnk_files_pattern($1, httpd_sys_content_t, httpd_sys_content_t)
+
+	# /proc
+	allow $1 httpd_server_domains:dir list_dir_perms;
+	kernel_read_kernel_sysctls($1)
+	kernel_read_system_state($1)
+
+	# allow to communicate via core-networks
+	corenet_all_recvfrom_unlabeled($1)
+	corenet_all_recvfrom_netlabel($1)
+	corenet_tcp_sendrecv_generic_if($1)
+	corenet_udp_sendrecv_generic_if($1)
+	corenet_tcp_sendrecv_generic_node($1)
+	corenet_udp_sendrecv_generic_node($1)
+	corenet_tcp_sendrecv_all_ports($1)
+	corenet_udp_sendrecv_all_ports($1)
+	corenet_sendrecv_http_server_packets($1)
+	corenet_tcp_connect_http_port($1)
+
+	# device nodes
+	dev_read_sysfs($1)
+	dev_read_rand($1)
+	dev_read_urand($1)
+	dev_rw_crypto($1)
+
+	# filesystems
+	fs_getattr_all_fs($1)
+	fs_search_auto_mountpoints($1)
+
+	# misc permissions
+	domain_use_interactive_fds($1)
+
+	files_read_usr_files($1)
+	files_list_mnt($1)
+	files_search_spool($1)
+	files_read_var_lib_files($1)
+	files_search_home($1)
+	files_getattr_home_dir($1)
+	# for modules that want to access /etc/mtab
+	files_read_etc_runtime_files($1)
+	# Allow httpd_t to have access to files such as nisswitch.conf
+	files_read_etc_files($1)
+
+	libs_read_lib_files($1)
+
+	logging_send_syslog_msg($1)
+
+	miscfiles_read_localization($1)
+	miscfiles_read_fonts($1)
+	miscfiles_read_public_files($1)
+	miscfiles_read_certs($1)
+
+	seutil_dontaudit_search_config($1)
+
+	userdom_use_unpriv_users_fds($1)
+')
+
+########################################
+## <summary>
+##	Allos a domain to access UBAC types for web contents
+## </summary>
+## <param name="prefix">
+##	<summary>
+##	The prefix to be used for deriving type names.
+##	</summary>
+## </param>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`apache_user_webapp',`
+	gen_require(`
+		type httpd_$1_content_t;
+		type httpd_$1_htaccess_t;
+		type httpd_$1_script_t;
+		type httpd_$1_script_exec_t;
+		type httpd_$1_script_ro_t;
+		type httpd_$1_script_rw_t;
+		type httpd_$1_script_ra_t;
+	')
+
+	# .htaccess files
+	allow $2 httpd_$1_htaccess_t:file read_file_perms;
+
+	# httpd_builtin_scripting controls them
+	manage_dirs_pattern($2, httpd_$1_script_rw_t, httpd_$1_script_rw_t)
+	manage_files_pattern($2, httpd_$1_script_rw_t, httpd_$1_script_rw_t)
+	manage_lnk_files_pattern($2, httpd_$1_script_rw_t, httpd_$1_script_rw_t)
+	rw_sock_files_pattern($2, httpd_$1_script_rw_t, httpd_$1_script_rw_t)
+
+	allow $2 httpd_$1_script_ra_t:dir { list_dir_perms add_entry_dir_perms };
+	read_files_pattern($2, httpd_$1_script_ra_t, httpd_$1_script_ra_t)
+	append_files_pattern($2, httpd_$1_script_ra_t, httpd_$1_script_ra_t)
+	read_lnk_files_pattern($2, httpd_$1_script_ra_t, httpd_$1_script_ra_t)
+
+	allow $2 httpd_$1_script_ro_t:dir list_dir_perms;
+	read_files_pattern($2, httpd_$1_script_ro_t, httpd_$1_script_ro_t)
+	read_lnk_files_pattern($2, httpd_$1_script_ro_t, httpd_$1_script_ro_t)
+
+	allow $2 httpd_$1_content_t:dir list_dir_perms;
+	read_files_pattern($2, httpd_$1_content_t, httpd_$1_content_t)
+	read_lnk_files_pattern($2, httpd_$1_content_t, httpd_$1_content_t)
+
+	# httpd_enable_cgi controls them
+	domtrans_pattern($2, httpd_$1_script_exec_t, httpd_$1_script_t)
+')
+
+########################################
+## <summary>
 ##	Read httpd user scripts executables.
 ## </summary>
 ## <param name="domain">

--------------060106080709090804030009--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
