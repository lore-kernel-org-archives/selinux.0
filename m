Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5BISFs0029824
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 14:28:15 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5BISEX5002334
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 18:28:14 GMT
Message-ID: <485018BC.4080606@redhat.com>
Date: Wed, 11 Jun 2008 14:26:04 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Fedora diffs for vmware policy
Content-Type: multipart/mixed;
 boundary="------------080306090008050407000600"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080306090008050407000600
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Multiple file context changes.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkhQGLwACgkQrlYvE4MpobP/xwCg0i2aq0oXn42XynW+q3eX0eKl
iNYAnjJHi2LM+jGN1re/um7AGpISUKV6
=586L
-----END PGP SIGNATURE-----

--------------080306090008050407000600
Content-Type: text/plain;
 name="apps_vmware.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="apps_vmware.patch"

Subject: [PATCH] refpolicy: apps_vmware changes
--text follows this line--
--- nsaserefpolicy/policy/modules/apps/vmware.fc	2008-06-11 08:15:43.000000000 -0400
+++ serefpolicy-3.4.2/policy/modules/apps/vmware.fc	2008-06-11 13:24:07.000000000 -0400
@@ -1,9 +1,9 @@
 #
 # HOME_DIR/
 #
-HOME_DIR/\.vmware(/.*)?			gen_context(system_u:object_r:ROLE_vmware_file_t,s0)
-HOME_DIR/\.vmware[^/]*/.*\.cfg	--	gen_context(system_u:object_r:ROLE_vmware_conf_t,s0)
-HOME_DIR/vmware(/.*)?			gen_context(system_u:object_r:ROLE_vmware_file_t,s0)
+HOME_DIR/\.vmware(/.*)?			gen_context(system_u:object_r:vmware_home_t,s0)
+HOME_DIR/\.vmware[^/]*/.*\.cfg	--	gen_context(system_u:object_r:vmware_home_t,s0)
+HOME_DIR/vmware(/.*)?			gen_context(system_u:object_r:vmware_home_t,s0)
 
 #
 # /etc
@@ -21,19 +21,25 @@
 /usr/bin/vmware-nmbd		--	gen_context(system_u:object_r:vmware_host_exec_t,s0)
 /usr/bin/vmware-ping		--	gen_context(system_u:object_r:vmware_host_exec_t,s0)
 /usr/bin/vmware-smbd		--	gen_context(system_u:object_r:vmware_host_exec_t,s0)
+/usr/sbin/vmware-guest.*		--	gen_context(system_u:object_r:vmware_host_exec_t,s0)
 /usr/bin/vmware-smbpasswd	--	gen_context(system_u:object_r:vmware_host_exec_t,s0)
 /usr/bin/vmware-smbpasswd\.bin	--	gen_context(system_u:object_r:vmware_host_exec_t,s0)
 /usr/bin/vmware-vmx		--	gen_context(system_u:object_r:vmware_host_exec_t,s0)
 /usr/bin/vmware-wizard		--	gen_context(system_u:object_r:vmware_exec_t,s0)
 /usr/bin/vmware			--	gen_context(system_u:object_r:vmware_exec_t,s0)
+/usr/sbin/vmware-serverd	--	gen_context(system_u:object_r:vmware_exec_t,s0)
 
 /usr/lib/vmware/config		--	gen_context(system_u:object_r:vmware_sys_conf_t,s0)
 /usr/lib/vmware/bin/vmware-mks	--	gen_context(system_u:object_r:vmware_exec_t,s0)
 /usr/lib/vmware/bin/vmware-ui	--	gen_context(system_u:object_r:vmware_exec_t,s0)
+/usr/lib/vmware/bin/vmplayer  --	gen_context(system_u:object_r:vmware_exec_t,s0)
+/usr/lib/vmware/bin/vmware-vmx	--	gen_context(system_u:object_r:vmware_host_exec_t,s0)
 
 /usr/lib64/vmware/config	--	gen_context(system_u:object_r:vmware_sys_conf_t,s0)
 /usr/lib64/vmware/bin/vmware-mks --	gen_context(system_u:object_r:vmware_exec_t,s0)
 /usr/lib64/vmware/bin/vmware-ui --	gen_context(system_u:object_r:vmware_exec_t,s0)
+/usr/lib64/vmware/bin/vmplayer  --	gen_context(system_u:object_r:vmware_exec_t,s0)
+/usr/lib64/vmware/bin/vmware-vmx	--	gen_context(system_u:object_r:vmware_host_exec_t,s0)
 
 ifdef(`distro_gentoo',`
 /opt/vmware/(workstation|player)/bin/vmnet-bridge --	gen_context(system_u:object_r:vmware_host_exec_t,s0)
@@ -49,3 +55,9 @@
 /opt/vmware/(workstation|player)/bin/vmware-wizard --	gen_context(system_u:object_r:vmware_exec_t,s0)
 /opt/vmware/(workstation|player)/bin/vmware --	gen_context(system_u:object_r:vmware_exec_t,s0)
 ')
+
+/var/log/vmware.* 	--	gen_context(system_u:object_r:vmware_log_t,s0)
+/var/run/vmnat.* 	-s	gen_context(system_u:object_r:vmware_var_run_t,s0)
+/var/run/vmware.* 		gen_context(system_u:object_r:vmware_var_run_t,s0)
+/usr/lib/vmware-tools/sbin32/vmware.*	--	gen_context(system_u:object_r:vmware_host_exec_t,s0)
+/usr/lib/vmware-tools/sbin64/vmware.*	--	gen_context(system_u:object_r:vmware_host_exec_t,s0)
--- nsaserefpolicy/policy/modules/apps/vmware.if	2008-05-29 15:57:39.000000000 -0400
+++ serefpolicy-3.4.2/policy/modules/apps/vmware.if	2008-06-11 13:23:37.000000000 -0400
@@ -47,11 +47,8 @@
 	domain_entry_file($1_vmware_t,vmware_exec_t)
 	role $3 types $1_vmware_t;
 
-	type $1_vmware_conf_t;
-	userdom_user_home_content($1,$1_vmware_conf_t)
-
-	type $1_vmware_file_t;
-	userdom_user_home_content($1,$1_vmware_file_t)
+	typealias vmware_home_t alias $1_vmware_file_t;
+	typealias vmware_home_t alias $1_vmware_conf_t;
 
 	type $1_vmware_tmp_t;
 	files_tmp_file($1_vmware_tmp_t)
@@ -84,12 +81,9 @@
 
 	can_exec($1_vmware_t, vmware_exec_t)
 
-	# User configuration files
-	allow $1_vmware_t $1_vmware_conf_t:file manage_file_perms;
-
 	# VMWare disks
-	manage_files_pattern($1_vmware_t,$1_vmware_file_t,$1_vmware_file_t)
-	manage_lnk_files_pattern($1_vmware_t,$1_vmware_file_t,$1_vmware_file_t)
+	manage_files_pattern($1_vmware_t,vmware_home_t,vmware_home_t)
+	manage_lnk_files_pattern($1_vmware_t,vmware_home_t,vmware_home_t)
 
 	allow $1_vmware_t $1_vmware_tmp_t:file execute;
 	manage_dirs_pattern($1_vmware_t,$1_vmware_tmp_t,$1_vmware_tmp_t)
@@ -202,3 +196,22 @@
 
 	allow $1 vmware_sys_conf_t:file append;
 ')
+
+########################################
+## <summary>
+##	Append to VMWare log files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`vmware_append_log',`
+	gen_require(`
+		type vmware_log_t;
+	')
+
+	logging_search_logs($1)
+	append_files_pattern($1,vmware_log_t,vmware_log_t)
+')
--- nsaserefpolicy/policy/modules/apps/vmware.te	2008-06-11 08:15:43.000000000 -0400
+++ serefpolicy-3.4.2/policy/modules/apps/vmware.te	2008-06-11 13:25:18.000000000 -0400
@@ -10,6 +10,9 @@
 type vmware_exec_t;
 corecmd_executable_file(vmware_exec_t)
 
+type vmware_home_t;
+userdom_user_home_content(user,vmware_home_t)
+
 # VMWare host programs
 type vmware_host_t;
 type vmware_host_exec_t;
@@ -22,17 +25,21 @@
 type vmware_var_run_t;
 files_pid_file(vmware_var_run_t)
 
+type vmware_log_t;
+logging_log_file(vmware_log_t)
+
 ########################################
 #
 # VMWare host local policy
 #
 
-allow vmware_host_t self:capability { setuid net_raw };
+allow vmware_host_t self:capability { setgid setuid net_raw };
 dontaudit vmware_host_t self:capability sys_tty_config;
-allow vmware_host_t self:process signal_perms;
+allow vmware_host_t self:process { execstack execmem signal_perms };
 allow vmware_host_t self:fifo_file rw_fifo_file_perms;
 allow vmware_host_t self:unix_stream_socket create_stream_socket_perms;
 allow vmware_host_t self:rawip_socket create_socket_perms;
+allow vmware_host_t self:tcp_socket create_socket_perms;
 
 # cjp: the ro and rw files should be split up
 manage_files_pattern(vmware_host_t,vmware_sys_conf_t,vmware_sys_conf_t)
@@ -41,6 +48,11 @@
 manage_sock_files_pattern(vmware_host_t,vmware_var_run_t,vmware_var_run_t)
 files_pid_filetrans(vmware_host_t,vmware_var_run_t,{ file sock_file })
 
+manage_files_pattern(vmware_host_t,vmware_log_t,vmware_log_t)	
+logging_log_filetrans(vmware_host_t,vmware_log_t,{ file dir })
+
+files_search_home(vmware_host_t)
+
 kernel_read_kernel_sysctls(vmware_host_t)
 kernel_list_proc(vmware_host_t)
 kernel_read_proc_symlinks(vmware_host_t)
@@ -63,6 +75,7 @@
 corenet_sendrecv_all_server_packets(vmware_host_t)
 
 dev_read_sysfs(vmware_host_t)
+dev_read_urand(vmware_host_t)
 dev_rw_vmware(vmware_host_t)
 
 domain_use_interactive_fds(vmware_host_t)
@@ -100,14 +113,12 @@
 ')
 netutils_domtrans_ping(vmware_host_t)
 
-ifdef(`TODO',`
-# VMWare need access to pcmcia devices for network
 optional_policy(`
-allow kernel_t cardmgr_var_lib_t:dir { getattr search };
-allow kernel_t cardmgr_var_lib_t:file { getattr ioctl read };
+	unconfined_domain(vmware_host_t)
 ')
-# Vmware create network devices
-allow kernel_t self:capability net_admin;
-allow kernel_t self:netlink_route_socket { bind create getattr nlmsg_read nlmsg_write read write };
-allow kernel_t self:socket create;
+
+optional_policy(`
+	xserver_xdm_rw_shm(vmware_host_t)
 ')
+
+

--------------080306090008050407000600
Content-Type: application/pgp-signature;
 name="apps_vmware.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="apps_vmware.patch.sig"

iEYEABECAAYFAkhQGLwACgkQrlYvE4MpobMH0gCeM1vprh/OtkQGeKUIuYlg+AOENiwAoNVf
Vr4VJjkx6JSqx8jIUYRHbS0F
--------------080306090008050407000600--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
