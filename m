Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1LE36dW017678
	for <selinux@tycho.nsa.gov>; Mon, 21 Feb 2005 09:03:06 -0500 (EST)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1LDwdpm006436
	for <selinux@tycho.nsa.gov>; Mon, 21 Feb 2005 13:58:39 GMT
Message-ID: <4219E93C.9040005@redhat.com>
Date: Mon, 21 Feb 2005 08:59:24 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: ivg2@cornell.edu
CC: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, selinux@tycho.nsa.gov
Subject: Re: Java Legacy problem
References: <1108910713.3610.18.camel@cobra.ivg2.net>	 <20050220154458.GH14038@lkcl.net> <1108914838.5275.10.camel@cobra.ivg2.net>	 <20050220171743.GJ14038@lkcl.net>  <4219DB94.1090906@redhat.com> <1108992257.26875.0.camel@cobra.ivg2.net>
In-Reply-To: <1108992257.26875.0.camel@cobra.ivg2.net>
Content-Type: multipart/mixed;
 boundary="------------050308040806010302030206"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050308040806010302030206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ivan Gyurdiev wrote:

>>This is a case where we may want to give an application more rights then 
>>user_t.
>>The java_user_t should be user_t + (execmem/execmod privs)
>>    
>>
>
>Maybe we should just ask Sun to fix it?
>
>  
>
I don't think java can be fixed,   I think it is doing this stuff by 
design. 
A couple of things to try.

How about we rename java_domain to javap_domain (java_plugin).
Then we create a java_domain like the following

define(`java_domain',`
type $1_java_t, domain, privlog , nscd_client_domain, transitionbool;
legacy_domain($1_java)
base_user_domain($1_java)
domain_auto_trans($1_t, java_exec_t, $1_java_t)
')

Attached latest diffs to make these changes.




--------------050308040806010302030206
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsapolicy/ChangeLog policy-1.21.14/ChangeLog
--- nsapolicy/ChangeLog	2005-02-17 10:16:42.000000000 -0500
+++ policy-1.21.14/ChangeLog	2005-02-21 08:58:01.000000000 -0500
@@ -1,6 +1,6 @@
 1.21 2005-02-07
 	* Added secure_file_type attribute from Dan Walsh
-	* Added access_terminal() macro from Dan Walsh
+	* Added access_terminal() macro from Ivan Gyurdiev
 	* Updated capability access vector for audit capabilities.
 	* Added mlsconvert Makefile target to help generate MLS policies
 	  (see selinux-doc/README.MLS for instructions).
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/ldconfig.te policy-1.21.14/domains/program/ldconfig.te
--- nsapolicy/domains/program/ldconfig.te	2005-02-10 14:48:38.000000000 -0500
+++ policy-1.21.14/domains/program/ldconfig.te	2005-02-21 08:58:01.000000000 -0500
@@ -38,14 +38,14 @@
 dontaudit ldconfig_t httpd_modules_t:dir search;
 ')
 
-ifdef(`distro_suse', `
-# because of libraries in /var/lib/samba/bin
 allow ldconfig_t { var_t var_lib_t }:dir search;
-')
-
 allow ldconfig_t proc_t:file read;
 ifdef(`hide_broken_symptoms', `
 ifdef(`unconfined.te',`
 dontaudit ldconfig_t unconfined_t:tcp_socket { read write };
-')
+');
 ')dnl end hide_broken_symptoms
+ifdef(`targeted_policy', `
+allow ldconfig_t lib_t:file r_file_perms;
+unconfined_domain(ldconfig_t) 
+')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/amanda.te policy-1.21.14/domains/program/unused/amanda.te
--- nsapolicy/domains/program/unused/amanda.te	2005-02-10 14:48:39.000000000 -0500
+++ policy-1.21.14/domains/program/unused/amanda.te	2005-02-21 08:58:01.000000000 -0500
@@ -31,7 +31,7 @@
 # General declarations
 ######################
 
-type amanda_t, domain, privlog;
+type amanda_t, domain, privlog, nscd_client_domain ;
 role system_r types amanda_t;
 
 # type for the amanda executables
@@ -304,3 +304,7 @@
 type amanda_port_t, port_type;
 allow inetd_t amanda_port_t:{ tcp_socket udp_socket } name_bind;
 
+allow amanda_t file_type:dir {getattr read search };
+allow amanda_t file_type:file {getattr read };
+var_log_domain(amanda)
+
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/apache.te policy-1.21.14/domains/program/unused/apache.te
--- nsapolicy/domains/program/unused/apache.te	2005-02-17 10:16:43.000000000 -0500
+++ policy-1.21.14/domains/program/unused/apache.te	2005-02-21 08:58:01.000000000 -0500
@@ -307,6 +307,7 @@
 #
 typealias httpd_log_t  alias httpd_runtime_t;
 allow { httpd_t httpd_sys_script_t } httpd_runtime_t:file { getattr append };
+dontaudit httpd_t httpd_runtime_t:file ioctl;
 ') dnl distro_redhat
 #
 # Customer reported the following
@@ -323,8 +324,9 @@
 allow httpd_sys_script_t httpd_squirrelmail_t:file { append read };
 # File Type of squirrelmail attachments
 type squirrelmail_spool_t, file_type, sysadmfile, tmpfile;
-allow httpd_t var_spool_t:dir { getattr search };
+allow { httpd_t httpd_sys_script_t } var_spool_t:dir { getattr search };
 create_dir_file(httpd_t, squirrelmail_spool_t)
+r_dir_file(httpd_sys_script_t, squirrelmail_spool_t)
 
 ifdef(`mta.te', `
 dontaudit system_mail_t httpd_log_t:file { append getattr };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/cups.te policy-1.21.14/domains/program/unused/cups.te
--- nsapolicy/domains/program/unused/cups.te	2005-02-17 10:16:43.000000000 -0500
+++ policy-1.21.14/domains/program/unused/cups.te	2005-02-21 08:58:01.000000000 -0500
@@ -77,6 +77,7 @@
 
 # Use capabilities.
 allow cupsd_t self:capability { dac_read_search kill setgid setuid fsetid net_bind_service fowner chown dac_override sys_tty_config };
+dontaudit cupsd_t self:capability net_admin;
 
 allow cupsd_t self:process setsched;
 
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/dovecot.te policy-1.21.14/domains/program/unused/dovecot.te
--- nsapolicy/domains/program/unused/dovecot.te	2005-02-09 15:01:29.000000000 -0500
+++ policy-1.21.14/domains/program/unused/dovecot.te	2005-02-21 08:58:01.000000000 -0500
@@ -26,6 +26,7 @@
 
 allow dovecot_t pop_port_t:tcp_socket name_bind;
 allow dovecot_t urandom_device_t:chr_file read;
+allow dovecot_t cert_t:dir search;
 allow dovecot_t dovecot_cert_t:file { getattr read };
 
 allow dovecot_t { self proc_t }:file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/java.te policy-1.21.14/domains/program/unused/java.te
--- nsapolicy/domains/program/unused/java.te	2005-02-16 14:34:10.000000000 -0500
+++ policy-1.21.14/domains/program/unused/java.te	2005-02-21 08:58:01.000000000 -0500
@@ -10,5 +10,8 @@
 # Allow java to read files in the user home directory
 bool disable_java false;
 
+# Allow java to read files in the user home directory
+bool disable_javap false;
+
 # Everything else is in the java_domain macro in
 # macros/program/java_macros.te.
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nscd.te policy-1.21.14/domains/program/unused/nscd.te
--- nsapolicy/domains/program/unused/nscd.te	2005-02-10 14:48:39.000000000 -0500
+++ policy-1.21.14/domains/program/unused/nscd.te	2005-02-21 08:58:01.000000000 -0500
@@ -72,4 +72,4 @@
 allow nscd_t self:netlink_route_socket r_netlink_socket_perms;
 allow nscd_t tmp_t:dir { search getattr };
 allow nscd_t tmp_t:lnk_file read;
-allow nscd_t urandom_device_t:chr_file { getattr read };
+allow nscd_t { urandom_device_t random_device_t }:chr_file { getattr read };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/ping.te policy-1.21.14/domains/program/unused/ping.te
--- nsapolicy/domains/program/unused/ping.te	2005-02-09 15:01:29.000000000 -0500
+++ policy-1.21.14/domains/program/unused/ping.te	2005-02-21 08:58:01.000000000 -0500
@@ -11,7 +11,7 @@
 # ping_t is the domain for the ping program.
 # ping_exec_t is the type of the corresponding program.
 #
-type ping_t, domain, privlog;
+type ping_t, domain, privlog, nscd_client_domain;
 role sysadm_r types ping_t;
 role system_r types ping_t;
 in_user_role(ping_t)
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/privoxy.te policy-1.21.14/domains/program/unused/privoxy.te
--- nsapolicy/domains/program/unused/privoxy.te	2005-02-09 15:01:29.000000000 -0500
+++ policy-1.21.14/domains/program/unused/privoxy.te	2005-02-21 08:58:01.000000000 -0500
@@ -16,7 +16,7 @@
 allow privoxy_t self:capability net_bind_service;
 
 # Use the network.
-can_network_server(privoxy_t)
+can_network(privoxy_t)
 allow privoxy_t port_t:{ tcp_socket udp_socket } name_bind;
 allow privoxy_t etc_t:file { getattr read };
 allow privoxy_t self:capability { setgid setuid };
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/samba.te policy-1.21.14/domains/program/unused/samba.te
--- nsapolicy/domains/program/unused/samba.te	2005-02-17 10:16:44.000000000 -0500
+++ policy-1.21.14/domains/program/unused/samba.te	2005-02-21 08:58:01.000000000 -0500
@@ -176,12 +176,7 @@
 
 # Terminal
 read_locale(smbmount_t) 
-allow smbmount_t devtty_t:chr_file rw_file_perms;
-allow smbmount_t devpts_t:dir r_dir_perms;
-allow smbmount_t devpts_t:chr_file rw_file_perms;
-allow smbmount_t sysadm_tty_device_t:chr_file rw_file_perms;
-allow smbmount_t sysadm_devpts_t:chr_file rw_file_perms;
-#FIXME: what about user_tty_device_t, user_devpts_t?
+access_terminal(smbmount_t, sysadm)
 allow smbmount_t userdomain:fd use;
 allow smbmount_t local_login_t:fd use;
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/utempter.te policy-1.21.14/domains/program/unused/utempter.te
--- nsapolicy/domains/program/unused/utempter.te	2005-02-09 15:01:28.000000000 -0500
+++ policy-1.21.14/domains/program/unused/utempter.te	2005-02-21 08:58:01.000000000 -0500
@@ -12,7 +12,7 @@
 # executed by xterm to update utmp and wtmp.
 # utempter_exec_t is the type of the utempter binary.
 #
-type utempter_t, domain;
+type utempter_t, domain, nscd_client_domain;
 in_user_role(utempter_t)
 role sysadm_r types utempter_t;
 uses_shlib(utempter_t)
diff --exclude-from=exclude -N -u -r nsapolicy/file_contexts/program/amanda.fc policy-1.21.14/file_contexts/program/amanda.fc
--- nsapolicy/file_contexts/program/amanda.fc	2005-02-09 15:01:30.000000000 -0500
+++ policy-1.21.14/file_contexts/program/amanda.fc	2005-02-21 08:58:01.000000000 -0500
@@ -67,3 +67,4 @@
 /var/lib/amanda/disklist	--	system_u:object_r:amanda_data_t
 /var/lib/amanda/gnutar-lists(/.*)?	system_u:object_r:amanda_gnutarlists_t
 /var/lib/amanda/index			system_u:object_r:amanda_data_t
+/var/log/amanda(/.*)?			system_u:object_r:amanda_log_t
diff --exclude-from=exclude -N -u -r nsapolicy/macros/global_macros.te policy-1.21.14/macros/global_macros.te
--- nsapolicy/macros/global_macros.te	2005-02-17 10:16:46.000000000 -0500
+++ policy-1.21.14/macros/global_macros.te	2005-02-21 08:58:01.000000000 -0500
@@ -538,6 +538,7 @@
 #Required when starting with /lib/tls/libc-
 allow $1_t { texrel_shlib_t shlib_t }:file execmod;
 allow $1_t ld_so_t:file execmod;
+allow $1_t ld_so_cache_t:file execmod;
 }
 ')
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/games_domain.te policy-1.21.14/macros/program/games_domain.te
--- nsapolicy/macros/program/games_domain.te	2005-02-10 14:48:42.000000000 -0500
+++ policy-1.21.14/macros/program/games_domain.te	2005-02-21 08:58:01.000000000 -0500
@@ -30,7 +30,6 @@
 allow $1_games_t xdm_tmp_t:dir rw_dir_perms;
 allow $1_games_t xdm_tmp_t:sock_file create_file_perms;
 allow $1_games_t xdm_var_lib_t:file { getattr read };
-allow $1_games_t xdm_t:fifo_file rw_file_perms;
 ')dnl end if xdm.te
 
 can_unix_connect($1_t, $1_games_t)
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/gpg_macros.te policy-1.21.14/macros/program/gpg_macros.te
--- nsapolicy/macros/program/gpg_macros.te	2005-02-17 10:16:46.000000000 -0500
+++ policy-1.21.14/macros/program/gpg_macros.te	2005-02-21 08:58:01.000000000 -0500
@@ -44,6 +44,7 @@
 allow $1_gpg_t self:tcp_socket create_stream_socket_perms;
 
 access_terminal($1_gpg_t, $1)
+allow $1_gpg_t { $1_devpts_t $1_tty_device_t }:chr_file ioctl;
 ifdef(`gnome-pty-helper.te', `allow $1_gpg_t $1_gph_t:fd use;')
 
 # Inherit and use descriptors
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/java_macros.te policy-1.21.14/macros/program/java_macros.te
--- nsapolicy/macros/program/java_macros.te	2005-02-16 14:34:31.000000000 -0500
+++ policy-1.21.14/macros/program/java_macros.te	2005-02-21 08:58:01.000000000 -0500
@@ -1,117 +1,134 @@
 #
-# Macros for java/java (or other browser) domains.
+# Authors:  Dan Walsh <dwalsh@redhat.com> 
 #
-
 #
-# Authors:  Dan Walsh <dwalsh@redhat.com> and Timothy Fraser 
+# Macros for java domains.
 #
-
 #
-# java_domain(domain_prefix, user)
+# java_domain(domain_prefix)
 #
-# Define a derived domain for the java/java program when executed by
-# a web browser.  
+# Define a derived domain for the java program when executed by
+# a user.
 #
 # The type declaration for the executable type for this program is
 # provided separately in domains/program/java.te. 
 #
+
 define(`java_domain',`
 type $1_java_t, domain, privlog , nscd_client_domain, transitionbool;
+legacy_domain($1_java)
+base_user_domain($1_java)
+domain_auto_trans($1_t, java_exec_t, $1_java_t)
+')
+
+#
+# Macros for javap (java plugin) domains.
+#
+#
+# javap_domain(domain_prefix, user)
+#
+# Define a derived domain for the javap program when executed by
+# a web browser.  
+#
+# The type declaration for the executable type for this program is
+# provided separately in domains/program/java.te. 
+#
+define(`javap_domain',`
+type $1_javap_t, domain, privlog , nscd_client_domain, transitionbool;
 
 # The user role is authorized for this domain.
-role $2_r types $1_java_t;
-domain_auto_trans($1_t, java_exec_t, $1_java_t)
+role $2_r types $1_javap_t;
+domain_auto_trans($1_t, java_exec_t, $1_javap_t)
 
-allow $1_java_t sound_device_t:chr_file rw_file_perms;
+allow $1_javap_t sound_device_t:chr_file rw_file_perms;
 # Unrestricted inheritance from the caller.
-allow $1_t $1_java_t:process { noatsecure siginh rlimitinh };
-allow $1_java_t $1_t:process signull;
+allow $1_t $1_javap_t:process { noatsecure siginh rlimitinh };
+allow $1_javap_t $1_t:process signull;
 
-can_unix_connect($1_java_t, $1_t)
-allow $1_java_t $1_t:unix_stream_socket { read write };
+can_unix_connect($1_javap_t, $1_t)
+allow $1_javap_t $1_t:unix_stream_socket { read write };
 
 # This domain is granted permissions common to most domains (including can_net)
-can_network_client($1_java_t)
-can_ypbind($1_java_t)
-allow $1_java_t self:process { fork signal_perms getsched setsched };
-allow $1_java_t self:unix_stream_socket { connectto create_stream_socket_perms };
-allow $1_java_t self:fifo_file rw_file_perms;
-allow $1_java_t etc_runtime_t:file { getattr read };
-allow $1_java_t fs_t:filesystem getattr;
-read_locale($1_java_t)
-r_dir_file($1_java_t, { proc_t proc_net_t })
-allow $1_java_t self:dir search;
-allow $1_java_t self:lnk_file read;
-allow $1_java_t self:file { getattr read };
-
-read_sysctl($1_java_t)
-
-tmp_domain($1_java)
-r_dir_file($1_java_t,{ fonts_t usr_t etc_t })
-
-# Search bin directory under java for java executable
-allow $1_java_t bin_t:dir search;
-can_exec($1_java_t, java_exec_t)
+can_network_client($1_javap_t)
+can_ypbind($1_javap_t)
+allow $1_javap_t self:process { fork signal_perms getsched setsched };
+allow $1_javap_t self:unix_stream_socket { connectto create_stream_socket_perms };
+allow $1_javap_t self:fifo_file rw_file_perms;
+allow $1_javap_t etc_runtime_t:file { getattr read };
+allow $1_javap_t fs_t:filesystem getattr;
+r_dir_file($1_javap_t, { proc_t proc_net_t })
+allow $1_javap_t self:dir search;
+allow $1_javap_t self:lnk_file read;
+allow $1_javap_t self:file { getattr read };
+
+read_sysctl($1_javap_t)
+
+tmp_domain($1_javap)
+r_dir_file($1_javap_t,{ fonts_t usr_t etc_t })
+
+# Search bin directory under javap for javap executable
+allow $1_javap_t bin_t:dir search;
+can_exec($1_javap_t, javap_exec_t)
 
 # Allow connections to X server.
 ifdef(`xserver.te', `
 
 ifdef(`xdm.te', `
 # for when /tmp/.X11-unix is created by the system
-allow $1_java_t xdm_xserver_tmp_t:dir search;
-allow $1_java_t xdm_t:fifo_file rw_file_perms;
-allow $1_java_t xdm_tmp_t:dir search;
-allow $1_java_t xdm_tmp_t:sock_file write;
+allow $1_javap_t xdm_xserver_tmp_t:dir search;
+allow $1_javap_t xdm_t:fifo_file rw_file_perms;
+allow $1_javap_t xdm_tmp_t:dir search;
+allow $1_javap_t xdm_tmp_t:sock_file write;
 ')
 
 ifdef(`startx.te', `
 # for when /tmp/.X11-unix is created by the X server
-allow $1_java_t $2_xserver_tmp_t:dir search;
+allow $1_javap_t $2_xserver_tmp_t:dir search;
 
 # for /tmp/.X0-lock
-allow $1_java_t $2_xserver_tmp_t:file getattr;
+allow $1_javap_t $2_xserver_tmp_t:file getattr;
 
-allow $1_java_t $2_xserver_tmp_t:sock_file rw_file_perms;
-can_unix_connect($1_java_t, $2_xserver_t)
+allow $1_javap_t $2_xserver_tmp_t:sock_file rw_file_perms;
+can_unix_connect($1_javap_t, $2_xserver_t)
 ')dnl end startx
 
-can_unix_connect($1_java_t, xdm_xserver_t)
-allow xdm_xserver_t $1_java_t:fd use;
-allow xdm_xserver_t $1_java_t:shm { associate getattr read unix_read };
-dontaudit xdm_xserver_t $1_java_t:shm { unix_write write };
+can_unix_connect($1_javap_t, xdm_xserver_t)
+allow xdm_xserver_t $1_javap_t:fd use;
+allow xdm_xserver_t $1_javap_t:shm { associate getattr read unix_read };
+dontaudit xdm_xserver_t $1_javap_t:shm { unix_write write };
 
 ')dnl end xserver
 
-allow $1_java_t self:shm create_shm_perms;
+allow $1_javap_t self:shm create_shm_perms;
 
-legacy_domain($1_java)
+legacy_domain($1_javap)
 
-uses_shlib($1_java_t)
-read_locale($1_java_t)
-rw_dir_file($1_java_t, $1_rw_t)
-
-allow $1_java_t ld_so_cache_t:file execute;
-allow $1_java_t lib_t:file execute;
-allow $1_java_t locale_t:file execute;
-allow $1_java_t $1_java_tmp_t:file execute;
-
-allow $1_java_t { random_device_t urandom_device_t }:chr_file ra_file_perms;
-
-allow $1_java_t home_root_t:dir { getattr search };
-file_type_auto_trans($1_java_t, $2_home_dir_t, $1_rw_t)
-allow $1_java_t $2_home_xauth_t:file { getattr read };
-allow $1_java_t $2_tmp_t:sock_file write;
-allow $1_java_t $2_t:fd use;
-
-allow $1_java_t var_t:dir getattr;
-allow $1_java_t var_lib_t:dir { getattr search };
-
-dontaudit $1_java_t fonts_t:file execute;
-dontaudit $1_java_t sound_device_t:chr_file execute;
-dontaudit $1_java_t $2_devpts_t:chr_file { read write };
-dontaudit $1_java_t sysadm_devpts_t:chr_file { read write };
-dontaudit $1_java_t devtty_t:chr_file { read write };
-dontaudit $1_java_t tmpfs_t:file { execute read write };
-dontaudit $1_java_t $1_rw_t:file { execute setattr };
+uses_shlib($1_javap_t)
+read_locale($1_javap_t)
+rw_dir_file($1_javap_t, $1_rw_t)
+
+allow $1_javap_t ld_so_cache_t:file execute;
+allow $1_javap_t lib_t:file execute;
+allow $1_javap_t locale_t:file execute;
+allow $1_javap_t $1_javap_tmp_t:file execute;
+
+allow $1_javap_t { random_device_t urandom_device_t }:chr_file ra_file_perms;
+
+allow $1_javap_t home_root_t:dir { getattr search };
+file_type_auto_trans($1_javap_t, $2_home_dir_t, $1_rw_t)
+allow $1_javap_t $2_home_xauth_t:file { getattr read };
+allow $1_javap_t $2_tmp_t:sock_file write;
+allow $1_javap_t $2_t:fd use;
+
+allow $1_javap_t var_t:dir getattr;
+allow $1_javap_t var_lib_t:dir { getattr search };
+
+dontaudit $1_javap_t fonts_t:file execute;
+dontaudit $1_javap_t sound_device_t:chr_file execute;
+dontaudit $1_javap_t $2_devpts_t:chr_file { read write };
+dontaudit $1_javap_t sysadm_devpts_t:chr_file { read write };
+dontaudit $1_javap_t devtty_t:chr_file { read write };
+dontaudit $1_javap_t tmpfs_t:file { execute read write };
+dontaudit $1_javap_t $1_rw_t:file { execute setattr };
 
 ')
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mozilla_macros.te policy-1.21.14/macros/program/mozilla_macros.te
--- nsapolicy/macros/program/mozilla_macros.te	2005-02-17 10:16:46.000000000 -0500
+++ policy-1.21.14/macros/program/mozilla_macros.te	2005-02-21 08:58:01.000000000 -0500
@@ -84,6 +84,7 @@
 dontaudit $1_mozilla_t $1_home_t:dir setattr;
 dontaudit $1_mozilla_t $1_home_t:file setattr;
 }
+allow $1_mozilla_t $1_tmp_t:sock_file rw_file_perms;
 file_type_auto_trans($1_mozilla_t, tmp_t, $1_mozilla_rw_t)
 file_type_auto_trans($1_mozilla_t, $1_tmp_t, $1_mozilla_rw_t)
 
@@ -111,8 +112,9 @@
 
 #
 # Rules needed to run java apps
-
-java_domain($1_mozilla, $1)
+ifdef(`java.te', `
+javap_domain($1_mozilla, $1)
+')
 
 # Mplayer plugin
 ifdef(`mplayer.te', `
@@ -123,12 +125,6 @@
 allow $1_mplayer_t $1_mozilla_t:unix_stream_socket { read write };
 ')dnl end if mplayer.te  
 
-ifdef(`xdm.te', `
-allow $1_mozilla_t xdm_t:fifo_file { write read };
-allow $1_mozilla_t xdm_tmp_t:dir search;
-allow $1_mozilla_t xdm_tmp_t:file { getattr read };
-allow $1_mozilla_t xdm_tmp_t:sock_file write;
-')dnl end if xdm.te
 if (allow_execmem) {
 allow $1_mozilla_t self:process { execmem };
 }
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/mplayer_macros.te policy-1.21.14/macros/program/mplayer_macros.te
--- nsapolicy/macros/program/mplayer_macros.te	2005-02-14 14:49:20.000000000 -0500
+++ policy-1.21.14/macros/program/mplayer_macros.te	2005-02-21 08:58:01.000000000 -0500
@@ -45,6 +45,7 @@
 uses_shlib($1_$2_t)
 read_locale($1_$2_t)
 access_terminal($1_$2_t, $1)
+allow $1_$2_t { $1_devpts_t $1_tty_device_t }:chr_file ioctl;
 
 # Required for win32 binary loader 
 allow $1_$2_t zero_device_t:chr_file { read write execute };
@@ -79,11 +80,6 @@
 # Mplayer common stuff
 mplayer_common($1, mplayer)
 
-# Additional rules for search /tmp/.X11-unix
-ifdef(`xdm.te', `
-allow $1_mplayer_t xdm_tmp_t:dir search;
-')dnl end if xdm.te
-
 # Audio
 allow $1_mplayer_t sound_device_t:chr_file rw_file_perms;
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/ssh_macros.te policy-1.21.14/macros/program/ssh_macros.te
--- nsapolicy/macros/program/ssh_macros.te	2005-02-17 10:16:46.000000000 -0500
+++ policy-1.21.14/macros/program/ssh_macros.te	2005-02-21 08:58:01.000000000 -0500
@@ -124,6 +124,7 @@
 
 # Write to the user domain tty.
 access_terminal($1_ssh_t, $1)
+allow $1_ssh_t { $1_devpts_t $1_tty_device_t devtty_t }:chr_file ioctl;
 
 # Allow the user shell to signal the ssh program.
 allow $1_t $1_ssh_t:process signal;
@@ -138,7 +139,8 @@
 allow $1_ssh_t $1_xserver_tmp_t:dir search;
 ')dnl end if startx
 ifdef(`xdm.te', `
-allow $1_ssh_t xdm_xserver_tmp_t:dir search;
+allow $1_ssh_t { xdm_xserver_tmp_t xdm_tmp_t }:dir search;
+allow $1_ssh_t { xdm_tmp_t }:sock_file write;
 ')
 ')dnl end if xserver
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/tvtime_macros.te policy-1.21.14/macros/program/tvtime_macros.te
--- nsapolicy/macros/program/tvtime_macros.te	2005-02-09 15:01:31.000000000 -0500
+++ policy-1.21.14/macros/program/tvtime_macros.te	2005-02-21 08:58:01.000000000 -0500
@@ -33,9 +33,6 @@
 allow $1_tvtime_t self:capability { setuid sys_nice sys_resource };
 allow $1_tvtime_t self:process setsched;
 allow $1_tvtime_t usr_t:file { getattr read };
-ifdef(`xdm.te', `
-allow $1_tvtime_t xdm_tmp_t:dir search;
-')
 
 ')dnl end tvtime_domain
 
diff --exclude-from=exclude -N -u -r nsapolicy/macros/program/x_client_macros.te policy-1.21.14/macros/program/x_client_macros.te
--- nsapolicy/macros/program/x_client_macros.te	2005-02-17 10:16:46.000000000 -0500
+++ policy-1.21.14/macros/program/x_client_macros.te	2005-02-21 08:58:01.000000000 -0500
@@ -179,7 +179,7 @@
 allow $1_$2_t xdm_xserver_tmpfs_t:file r_file_perms;
 
 can_unix_connect($1_$2_t, xdm_xserver_t)
-allow $1_$2_t xdm_xserver_tmp_t:dir search;
+allow $1_$2_t { xdm_xserver_tmp_t xdm_tmp_t }:dir search;
 allow $1_$2_t { xdm_xserver_tmp_t xdm_tmp_t }:sock_file { read write };
 allow $1_$2_t xdm_t:fd use;
 dontaudit $1_$2_t xdm_t:tcp_socket { read write };
diff --exclude-from=exclude -N -u -r nsapolicy/macros/user_macros.te policy-1.21.14/macros/user_macros.te
--- nsapolicy/macros/user_macros.te	2005-02-17 10:16:46.000000000 -0500
+++ policy-1.21.14/macros/user_macros.te	2005-02-21 08:58:01.000000000 -0500
@@ -47,6 +47,7 @@
 ifdef(`apache.te', `apache_domain($1)')
 ifdef(`slocate.te', `locate_domain($1)')
 ifdef(`lockdev.te', `lockdev_domain($1)')
+ifdef(`java.te', `java_domain($1)')
 
 can_kerberos($1_t)
 # allow port_t name binding for UDP because it is not very usable otherwise
diff --exclude-from=exclude -N -u -r nsapolicy/Makefile policy-1.21.14/Makefile
--- nsapolicy/Makefile	2005-02-17 15:52:02.000000000 -0500
+++ policy-1.21.14/Makefile	2005-02-21 08:58:01.000000000 -0500
@@ -21,21 +21,25 @@
 SBINDIR = $(PREFIX)/sbin
 LOADPOLICY  = $(SBINDIR)/load_policy
 CHECKPOLICY = $(BINDIR)/checkpolicy
+GENHOMEDIRCON = $(SBINDIR)/genhomedircon
 SETFILES = $(SBINDIR)/setfiles
 VERS := $(shell $(CHECKPOLICY) $(POLICYCOMPAT) -V |cut -f 1 -d ' ')
 KERNVERS := $(shell cat /selinux/policyvers)
 POLICYVER := policy.$(VERS)
+TOPDIR = $(DESTDIR)/etc/selinux
 ifeq ($(MLS),y)
-INSTALLDIR = $(DESTDIR)/etc/selinux/mls
+TYPE=mls
 else
-INSTALLDIR = $(DESTDIR)/etc/selinux/strict
+TYPE=strict
 endif
+INSTALLDIR = $(TOPDIR)/$(TYPE)
 POLICYPATH = $(INSTALLDIR)/policy
 SRCPATH = $(INSTALLDIR)/src
 USERPATH = $(INSTALLDIR)/users
 CONTEXTPATH = $(INSTALLDIR)/contexts
 LOADPATH = $(POLICYPATH)/$(POLICYVER)
 FCPATH = $(CONTEXTPATH)/files/file_contexts
+HOMEDIRPATH = $(CONTEXTPATH)/files/homedir_template
 
 ALL_PROGRAM_MACROS := $(wildcard macros/program/*.te)
 ALL_MACROS := $(ALL_PROGRAM_MACROS) $(wildcard macros/*.te)
@@ -50,15 +54,18 @@
 POLICYFILES += mls
 CHECKPOLMLS += -M
 endif
+DEFCONTEXTFILES = initial_sid_contexts fs_use genfs_contexts net_contexts
 POLICYFILES += $(ALL_TUNABLES) $(TE_RBAC_FILES)
 POLICYFILES += $(USER_FILES)
 POLICYFILES += constraints
-POLICYFILES += initial_sid_contexts fs_use genfs_contexts net_contexts
-CONTEXTFILES = initial_sid_contexts fs_use genfs_contexts net_contexts
+POLICYFILES += $(DEFCONTEXTFILES)
+CONTEXTFILES = $(DEFCONTEXTFILES)
+POLICY_DIRS = domains/program domains/misc
 
 UNUSED_TE_FILES := $(wildcard domains/program/unused/*.te)
 
 FC = file_contexts/file_contexts
+HOMEDIR_TEMPLATE = file_contexts/homedir_template
 FCFILES=file_contexts/types.fc $(patsubst domains/program/%.te,file_contexts/program/%.fc, $(wildcard domains/program/*.te)) file_contexts/distros.fc $(wildcard file_contexts/misc/*.fc)
 CONTEXTFILES += $(FCFILES)
 
@@ -169,9 +176,9 @@
 	grep -v dontaudit policy.conf > policy.audit
 	mv policy.audit policy.conf
 
-policy.conf: $(POLICYFILES) 
+policy.conf: $(POLICYFILES) $(POLICY_DIRS)
 	mkdir -p tmp
-	m4 $(M4PARAM) -Imacros -s $^ > $@.tmp
+	m4 $(M4PARAM) -Imacros -s $(POLICYFILES) > $@.tmp
 	mv $@.tmp $@
 
 install-src: 
@@ -203,14 +210,15 @@
 $(FCPATH): $(FC) 
 	@mkdir -p $(CONTEXTPATH)/files
 	install -m 644 $(FC) $(FCPATH)
+	install -m 644 $(HOMEDIR_TEMPLATE) $(HOMEDIRPATH)
+	@$(GENHOMEDIRCON) -d $(TOPDIR) -t $(TYPE) $(USEPWD)
 
 $(FC): $(ALL_TUNABLES) tmp/program_used_flags.te $(FCFILES) domains/program domains/misc file_contexts/program file_contexts/misc users /etc/passwd
 	@echo "Building file_contexts ..."
 	@m4 $(M4PARAM) $(ALL_TUNABLES) tmp/program_used_flags.te $(FCFILES) > $@.tmp
-	@grep -v "^/root" $@.tmp > $@.root
-	@/usr/sbin/genhomedircon . $@.root  > $@
-	@grep "^/root" $@.tmp >> $@
-	@-rm $@.tmp $@.root
+	@grep -v -e HOME -e ROLE $@.tmp > $@
+	@grep -e HOME -e ROLE $@.tmp  > $(HOMEDIR_TEMPLATE)
+	@-rm $@.tmp
 
 # Create a tags-file for the policy:
 # we need exuberant ctags; unfortunately it is named differently on different distros, sigh...
diff --exclude-from=exclude -N -u -r nsapolicy/targeted/domains/unconfined.te policy-1.21.14/targeted/domains/unconfined.te
--- nsapolicy/targeted/domains/unconfined.te	2005-02-09 15:01:45.000000000 -0500
+++ policy-1.21.14/targeted/domains/unconfined.te	2005-02-21 08:58:01.000000000 -0500
@@ -9,6 +9,8 @@
 role user_r types unconfined_t;
 role sysadm_r types unconfined_t;
 unconfined_domain(unconfined_t)
+allow domain unconfined_t:fd use;
+allow domain unconfined_t:process sigchld;
 
 # Define some type aliases to help with compatibility with
 # macros and domains from the "strict" policy.
@@ -37,6 +39,9 @@
 user_typealias(sysadm)
 user_typealias(staff)
 user_typealias(user)
+attribute user_file_type;
+attribute staff_file_type;
+attribute sysadm_file_type;
 
 allow unconfined_t unlabeled_t:filesystem *;
 allow unlabeled_t self:filesystem associate;
@@ -45,14 +50,19 @@
 bool use_nfs_home_dirs false;
 
 # Allow execution of anonymous mappings, e.g. executable stack.
-bool allow_execmem false;
+bool allow_execmem true;
 
 # Support Share libraries with Text Relocation
-bool allow_execmod false;
+bool allow_execmod true;
 
 # Support SAMBA home directories
 bool use_samba_home_dirs false;
 
+if (allow_execmod) {
+allow unconfined_t { ld_so_t shlib_t }:file execmod;
+allow unconfined_t { bin_t sbin_t exec_type }:file execmod;
+}
+
 ifdef(`samba.te', `samba_domain(user)')
 
 # Allow system to run with NIS
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/distro.tun policy-1.21.14/tunables/distro.tun
--- nsapolicy/tunables/distro.tun	2005-02-09 15:01:31.000000000 -0500
+++ policy-1.21.14/tunables/distro.tun	2005-02-21 08:58:01.000000000 -0500
@@ -5,7 +5,7 @@
 # appropriate ifdefs.
 
 
-dnl define(`distro_redhat')
+define(`distro_redhat')
 
 dnl define(`distro_suse')
 
diff --exclude-from=exclude -N -u -r nsapolicy/tunables/tunable.tun policy-1.21.14/tunables/tunable.tun
--- nsapolicy/tunables/tunable.tun	2005-02-09 15:01:31.000000000 -0500
+++ policy-1.21.14/tunables/tunable.tun	2005-02-21 08:58:01.000000000 -0500
@@ -1,27 +1,27 @@
 # Allow users to execute the mount command
-dnl define(`user_can_mount')
+define(`user_can_mount')
 
 # Allow rpm to run unconfined.
-dnl define(`unlimitedRPM')
+define(`unlimitedRPM')
 
 # Allow privileged utilities like hotplug and insmod to run unconfined.
-dnl define(`unlimitedUtils')
+define(`unlimitedUtils')
 
 # Allow rc scripts to run unconfined, including any daemon
 # started by an rc script that does not have a domain transition
 # explicitly defined.
-dnl define(`unlimitedRC')
+define(`unlimitedRC')
 
 # Allow sysadm_t to directly start daemons
 define(`direct_sysadm_daemon')
 
 # Do not audit things that we know to be broken but which
 # are not security risks
-dnl define(`hide_broken_symptoms')
+define(`hide_broken_symptoms')
 
 # Allow user_r to reach sysadm_r via su, sudo, or userhelper.
 # Otherwise, only staff_r can do so.
-dnl define(`user_canbe_sysadm')
+define(`user_canbe_sysadm')
 
 # Allow xinetd to run unconfined, including any services it starts
 # that do not have a domain transition explicitly defined.

--------------050308040806010302030206--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
