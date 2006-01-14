Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0EGf3Xf006186
	for <selinux@tycho.nsa.gov>; Sat, 14 Jan 2006 11:41:03 -0500 (EST)
Received: from sunspire.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k0EGduRT004155
	for <selinux@tycho.nsa.gov>; Sat, 14 Jan 2006 16:39:56 GMT
Date: Sat, 14 Jan 2006 18:40:42 +0200
From: Petre Rodan <kaiowas@gentoo.org>
To: SELinux <selinux@tycho.nsa.gov>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: djb-related policy diff
Message-ID: <20060114164042.GA5597@peter.sunspire.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--hQiwHBbRI9kgIhsi
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi,

attached you'll find

* policies for daemontools, ucspi-tcp, djbdns, publicfile
* modified apache.te, ftp.te, mysql.te, rsync.te, spamassassin.te, ssh.te, =
stunnel.te, init.te, selinuxutil.te to add daemontools support.

cheers,
peter

--=20
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux=20

--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="djb_policy.diff"
Content-Transfer-Encoding: quoted-printable

diff -ur --new-file --exclude=3DCVS --exclude=3D'corenetwork.*' policy.orig=
/policy/modules/services/apache.te policy/policy/modules/services/apache.te
--- policy.orig/policy/modules/services/apache.te	2006-01-13 23:26:18.00000=
0000 +0200
+++ policy/policy/modules/services/apache.te	2006-01-14 16:37:38.000000000 =
+0200
@@ -395,6 +395,10 @@
 	userdom_dontaudit_use_sysadm_terms(httpd_t)
 ')
=20
+optional_policy(`daemontools',`
+	daemontools_service_domain(httpd_t, httpd_exec_t)
+')
+
 optional_policy(`kerberos',`
 	kerberos_use(httpd_t)
 ')
diff -ur --new-file --exclude=3DCVS --exclude=3D'corenetwork.*' policy.orig=
/policy/modules/services/djbdns.fc policy/policy/modules/services/djbdns.fc
--- policy.orig/policy/modules/services/djbdns.fc	1970-01-01 02:00:00.00000=
0000 +0200
+++ policy/policy/modules/services/djbdns.fc	2006-01-14 18:34:50.000000000 =
+0200
@@ -0,0 +1,9 @@
+
+/usr/bin/axfrdns		--	gen_context(system_u:object_r:djbdns_axfrdns_exec_t,s=
0)
+/usr/bin/dnscache	--	gen_context(system_u:object_r:djbdns_dnscache_exec_t,=
s0)
+/usr/bin/tinydns		--	gen_context(system_u:object_r:djbdns_tinydns_exec_t,s=
0)
+
+/var/axfrdns/root(/.*)?		gen_context(system_u:object_r:djbdns_axfrdns_conf=
_t,s0)
+/var/dnscache/root(/.*)?		gen_context(system_u:object_r:djbdns_dnscache_co=
nf_t,s0)
+/var/tinydns/root(/.*)?		gen_context(system_u:object_r:djbdns_tinydns_conf=
_t,s0)
+
diff -ur --new-file --exclude=3DCVS --exclude=3D'corenetwork.*' policy.orig=
/policy/modules/services/djbdns.if policy/policy/modules/services/djbdns.if
--- policy.orig/policy/modules/services/djbdns.if	1970-01-01 02:00:00.00000=
0000 +0200
+++ policy/policy/modules/services/djbdns.if	2006-01-14 18:43:52.000000000 =
+0200
@@ -0,0 +1,53 @@
+## <summary>small and secure DNS daemon</summary>
+
+########################################
+## <summary>
+##      Create a set of derived types for djbdns=20
+##	components that are directly supervised by daemontools.
+## </summary>
+## <param name=3D"prefix">
+##      The prefix to be used for deriving type names.
+## </param>
+#
+template(`djbdns_daemontools_domain_template',`
+
+	type djbdns_$1_t;
+	type djbdns_$1_exec_t;
+	type djbdns_$1_conf_t;
+	files_config_file(djbdns_$1_conf_t)
+
+	domain_type(djbdns_$1_t)
+	domain_entry_file(djbdns_$1_t,djbdns_$1_exec_t)
+	role system_r types djbdns_$1_t;
+
+	daemontools_service_domain(djbdns_$1_t, djbdns_$1_exec_t)
+	daemontools_read_svc(djbdns_$1_t)
+
+	allow djbdns_$1_t self:capability { net_bind_service setgid setuid sys_ch=
root };
+	allow djbdns_$1_t self:tcp_socket create_stream_socket_perms;
+	allow djbdns_$1_t self:udp_socket create_socket_perms;
+	allow djbdns_$1_t port_t:udp_socket name_bind;
+
+	allow djbdns_$1_t djbdns_$1_conf_t:dir r_dir_perms;
+	allow djbdns_$1_t djbdns_$1_conf_t:file r_file_perms;
+
+	corenet_tcp_sendrecv_all_if(djbdns_$1_t)
+	corenet_udp_sendrecv_all_if(djbdns_$1_t)
+	corenet_tcp_sendrecv_all_nodes(djbdns_$1_t)
+	corenet_udp_sendrecv_all_nodes(djbdns_$1_t)
+	corenet_tcp_sendrecv_all_ports(djbdns_$1_t)
+	corenet_udp_sendrecv_all_ports(djbdns_$1_t)
+	corenet_non_ipsec_sendrecv(djbdns_$1_t)
+	corenet_tcp_bind_all_nodes(djbdns_$1_t)
+	corenet_udp_bind_all_nodes(djbdns_$1_t)
+
+	corenet_tcp_bind_dns_port(djbdns_$1_t)
+	corenet_udp_bind_dns_port(djbdns_$1_t)
+
+	files_search_var(djbdns_$1_t)
+
+	libs_use_ld_so(djbdns_$1_t)
+	libs_use_shared_libs(djbdns_$1_t)
+
+')
+
diff -ur --new-file --exclude=3DCVS --exclude=3D'corenetwork.*' policy.orig=
/policy/modules/services/djbdns.te policy/policy/modules/services/djbdns.te
--- policy.orig/policy/modules/services/djbdns.te	1970-01-01 02:00:00.00000=
0000 +0200
+++ policy/policy/modules/services/djbdns.te	2006-01-14 19:22:24.000000000 =
+0200
@@ -0,0 +1,45 @@
+
+policy_module(djbdns,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type djbdns_axfrdns_t;
+type djbdns_axfrdns_exec_t;
+type djbdns_axfrdns_conf_t;
+domain_type(djbdns_axfrdns_t)
+domain_entry_file(djbdns_axfrdns_t,djbdns_axfrdns_exec_t)
+role system_r types djbdns_axfrdns_t;
+files_config_file(djbdns_axfrdns_conf_t)
+
+djbdns_daemontools_domain_template(dnscache)
+
+djbdns_daemontools_domain_template(tinydns)
+
+########################################
+#
+# Local policy for axfrdns component
+#
+
+files_config_file(djbdns_axfrdns_conf_t)
+
+daemontools_ipc_domain(djbdns_axfrdns_t)
+daemontools_read_svc(djbdns_axfrdns_t)
+
+allow djbdns_axfrdns_t self:capability { setuid setgid sys_chroot };
+allow djbdns_axfrdns_t djbdns_axfrdns_conf_t:dir r_dir_perms;
+allow djbdns_axfrdns_t djbdns_axfrdns_conf_t:file r_file_perms;
+allow djbdns_axfrdns_t djbdns_tinydns_t:dir r_dir_perms;
+allow djbdns_axfrdns_t djbdns_tinydns_t:file r_file_perms;
+allow djbdns_axfrdns_t djbdns_tinydns_conf_t:dir r_dir_perms;
+allow djbdns_axfrdns_t djbdns_tinydns_conf_t:file r_file_perms;
+
+files_search_var(djbdns_axfrdns_t)
+
+libs_use_ld_so(djbdns_axfrdns_t)
+libs_use_shared_libs(djbdns_axfrdns_t)
+
+ucspitcp_service_domain(djbdns_axfrdns_t, djbdns_axfrdns_exec_t)
+
diff -ur --new-file --exclude=3DCVS --exclude=3D'corenetwork.*' policy.orig=
/policy/modules/services/ftp.te policy/policy/modules/services/ftp.te
--- policy.orig/policy/modules/services/ftp.te	2006-01-13 23:26:18.00000000=
0 +0200
+++ policy/policy/modules/services/ftp.te	2006-01-14 16:37:38.000000000 +02=
00
@@ -193,6 +193,10 @@
 	')
 ')
=20
+optional_policy(`daemontools',`
+	daemontools_service_domain(ftpd_t, ftpd_exec_t)
+')
+
 optional_policy(`inetd',`
 	#reh: typeattributes not allowed in conditionals yet.
 	#tunable_policy(`! ftpd_is_daemon',`
diff -ur --new-file --exclude=3DCVS --exclude=3D'corenetwork.*' policy.orig=
/policy/modules/services/mysql.te policy/policy/modules/services/mysql.te
--- policy.orig/policy/modules/services/mysql.te	2006-01-13 23:26:18.000000=
000 +0200
+++ policy/policy/modules/services/mysql.te	2006-01-14 16:37:38.000000000 +=
0200
@@ -141,11 +141,6 @@
 	udev_read_db(mysqld_t)
 ')
=20
-ifdef(`TODO',`
 optional_policy(`daemontools',`
-	domain_auto_trans( svc_run_t, mysqld_exec_t, mysqld_t)
-	mysqld_signal(svc_start_t)
-
-	svc_ipc_domain(mysqld_t)
+	daemontools_service_domain(mysqld_t, mysqld_exec_t)
 ')
-') dnl end TODO
diff -ur --new-file --exclude=3DCVS --exclude=3D'corenetwork.*' policy.orig=
/policy/modules/services/publicfile.fc policy/policy/modules/services/publi=
cfile.fc
--- policy.orig/policy/modules/services/publicfile.fc	1970-01-01 02:00:00.0=
00000000 +0200
+++ policy/policy/modules/services/publicfile.fc	2006-01-14 18:11:01.000000=
000 +0200
@@ -0,0 +1,7 @@
+
+/usr/bin/ftpd		--	gen_context(system_u:object_r:publicfile_exec_t,s0)
+/usr/bin/httpd		--	gen_context(system_u:object_r:publicfile_exec_t,s0)
+
+# this is the place where online content located
+# set this to suit your needs
+#/var/www(/.*)?			gen_context(system_u:object_r:publicfile_content_t,s0)
diff -ur --new-file --exclude=3DCVS --exclude=3D'corenetwork.*' policy.orig=
/policy/modules/services/publicfile.if policy/policy/modules/services/publi=
cfile.if
--- policy.orig/policy/modules/services/publicfile.if	1970-01-01 02:00:00.0=
00000000 +0200
+++ policy/policy/modules/services/publicfile.if	2006-01-14 18:11:01.000000=
000 +0200
@@ -0,0 +1 @@
+## <summary>publicfile supplies files to the public through HTTP and FTP</=
summary>
diff -ur --new-file --exclude=3DCVS --exclude=3D'corenetwork.*' policy.orig=
/policy/modules/services/publicfile.te policy/policy/modules/services/publi=
cfile.te
--- policy.orig/policy/modules/services/publicfile.te	1970-01-01 02:00:00.0=
00000000 +0200
+++ policy/policy/modules/services/publicfile.te	2006-01-14 18:11:02.000000=
000 +0200
@@ -0,0 +1,39 @@
+
+policy_module(publicfile,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type publicfile_t;
+type publicfile_exec_t;
+init_system_domain(publicfile_t,publicfile_exec_t)
+role system_r types publicfile_t;
+
+type publicfile_content_t;
+files_type(publicfile_content_t)
+
+########################################
+#
+# Local policy
+#
+
+allow publicfile_t self:capability { dac_override setgid setuid sys_chroot=
 };
+allow publicfile_t publicfile_content_t:dir r_dir_perms;
+allow publicfile_t publicfile_content_t:file r_file_perms;
+
+files_search_var(publicfile_t)
+
+libs_use_ld_so(publicfile_t)
+libs_use_shared_libs(publicfile_t)
+
+optional_policy(`ucspitcp',`
+	ucspitcp_service_domain(publicfile_t, publicfile_exec_t)
+')
+
+optional_policy(`daemontools',`
+	daemontools_ipc_domain(publicfile_t)
+')
+
+#allow publicfile_t initrc_t:tcp_socket { read write };
diff -ur --new-file --exclude=3DCVS --exclude=3D'corenetwork.*' policy.orig=
/policy/modules/services/rsync.te policy/policy/modules/services/rsync.te
--- policy.orig/policy/modules/services/rsync.te	2006-01-13 23:26:18.000000=
000 +0200
+++ policy/policy/modules/services/rsync.te	2006-01-14 16:37:39.000000000 +=
0200
@@ -87,6 +87,10 @@
 	miscfiles_manage_public_files(rsync_t)
 ')
=20
+optional_policy(`daemontools',`
+	daemontools_service_domain(rsync_t, rsync_exec_t)
+')
+
 optional_policy(`kerberos',`
 	kerberos_use(rsync_t)
 ')
diff -ur --new-file --exclude=3DCVS --exclude=3D'corenetwork.*' policy.orig=
/policy/modules/services/spamassassin.te policy/policy/modules/services/spa=
massassin.te
--- policy.orig/policy/modules/services/spamassassin.te	2006-01-13 23:26:18=
=2E000000000 +0200
+++ policy/policy/modules/services/spamassassin.te	2006-01-14 16:37:39.0000=
00000 +0200
@@ -136,6 +136,10 @@
 	cron_system_entry(spamd_t,spamd_exec_t)
 ')
=20
+optional_policy(`daemontools',`
+	daemontools_service_domain(spamd_t,spamd_exec_t)
+')
+
 optional_policy(`nis',`
 	nis_use_ypbind(spamd_t)
 ')
diff -ur --new-file --exclude=3DCVS --exclude=3D'corenetwork.*' policy.orig=
/policy/modules/services/ssh.te policy/policy/modules/services/ssh.te
--- policy.orig/policy/modules/services/ssh.te	2006-01-13 23:26:18.00000000=
0 +0200
+++ policy/policy/modules/services/ssh.te	2006-01-14 16:37:39.000000000 +02=
00
@@ -113,6 +113,10 @@
 		userdom_signal_unpriv_users(sshd_t)
 	')
=20
+	optional_policy(`daemontools',`
+		daemontools_service_domain(sshd_t, sshd_exec_t)
+	')
+
 	optional_policy(`rpm',`
 		rpm_use_script_fd(sshd_t)
 	')
@@ -139,6 +143,7 @@
 		allow sshd_t userpty_type:chr_file { relabelto read write getattr ioctl =
setattr };
 	')
 	') dnl endif TODO
+
 ')
=20
 #################################
diff -ur --new-file --exclude=3DCVS --exclude=3D'corenetwork.*' policy.orig=
/policy/modules/services/stunnel.te policy/policy/modules/services/stunnel.=
te
--- policy.orig/policy/modules/services/stunnel.te	2006-01-13 23:26:18.0000=
00000 +0200
+++ policy/policy/modules/services/stunnel.te	2006-01-14 16:37:39.000000000=
 +0200
@@ -103,6 +103,10 @@
         	files_dontaudit_read_root_file(stunnel_t)
 	')
=20
+	optional_policy(`daemontools',`
+		daemontools_service_domain(stunnel_t, stunnel_exec_t)
+	')
+
 	optional_policy(`mount',`
         	mount_send_nfs_client_request(stunnel_t)
 	')
diff -ur --new-file --exclude=3DCVS --exclude=3D'corenetwork.*' policy.orig=
/policy/modules/services/ucspitcp.fc policy/policy/modules/services/ucspitc=
p.fc
--- policy.orig/policy/modules/services/ucspitcp.fc	1970-01-01 02:00:00.000=
000000 +0200
+++ policy/policy/modules/services/ucspitcp.fc	2006-01-14 18:11:02.00000000=
0 +0200
@@ -0,0 +1,3 @@
+
+/usr/bin/rblsmtpd	--	gen_context(system_u:object_r:rblsmtpd_exec_t,s0)
+/usr/bin/tcpserver	--	gen_context(system_u:object_r:ucspitcp_exec_t,s0)
diff -ur --new-file --exclude=3DCVS --exclude=3D'corenetwork.*' policy.orig=
/policy/modules/services/ucspitcp.if policy/policy/modules/services/ucspitc=
p.if
--- policy.orig/policy/modules/services/ucspitcp.if	1970-01-01 02:00:00.000=
000000 +0200
+++ policy/policy/modules/services/ucspitcp.if	2006-01-14 18:11:03.00000000=
0 +0200
@@ -0,0 +1,36 @@
+## <summary>ucspitcp policy</summary>
+## <desc>
+##      <p>
+##              Policy for DJB's ucspi-tcpd
+##      </p>
+## </desc>
+
+########################################
+## <summary>
+##      Define a specified domain as a ucspitcp service.
+## </summary>
+## <param name=3D"domain">
+##      Domain allowed access.
+## </param>
+## <param name=3D"entrypoint">
+##      The type associated with the process program.
+## </param>
+#
+interface(`ucspitcp_service_domain', `
+	gen_require(`
+		type ucspitcp_t;
+		role system_r;
+	')
+
+	domain_type($1)
+	domain_entry_file($1,$2)
+
+	role system_r types $1;
+
+	domain_auto_trans(ucspitcp_t, $2, $1)
+
+	allow $1 ucspitcp_t:fd use;
+	allow $1 ucspitcp_t:process sigchld;
+	allow $1 ucspitcp_t:tcp_socket rw_stream_socket_perms;
+')
+
diff -ur --new-file --exclude=3DCVS --exclude=3D'corenetwork.*' policy.orig=
/policy/modules/services/ucspitcp.te policy/policy/modules/services/ucspitc=
p.te
--- policy.orig/policy/modules/services/ucspitcp.te	1970-01-01 02:00:00.000=
000000 +0200
+++ policy/policy/modules/services/ucspitcp.te	2006-01-14 19:14:21.00000000=
0 +0200
@@ -0,0 +1,90 @@
+
+policy_module(ucspitcp,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type rblsmtpd_t;
+type rblsmtpd_exec_t;
+init_system_domain(rblsmtpd_t,rblsmtpd_exec_t)
+role system_r types rblsmtpd_t;
+
+type ucspitcp_t;
+type ucspitcp_exec_t;
+init_system_domain(ucspitcp_t,ucspitcp_exec_t)
+role system_r types ucspitcp_t;
+
+########################################
+#
+# Local policy for rblsmtpd
+#
+
+ucspitcp_service_domain(rblsmtpd_t, rblsmtpd_exec_t)
+
+allow rblsmtpd_t self:process { fork sigchld };
+
+corecmd_search_bin(rblsmtpd_t)
+
+corenet_tcp_sendrecv_all_if(rblsmtpd_t)
+corenet_udp_sendrecv_all_if(rblsmtpd_t)
+corenet_tcp_sendrecv_all_nodes(rblsmtpd_t)
+corenet_udp_sendrecv_all_nodes(rblsmtpd_t)
+corenet_tcp_sendrecv_all_ports(rblsmtpd_t)
+corenet_udp_sendrecv_all_ports(rblsmtpd_t)
+corenet_non_ipsec_sendrecv(rblsmtpd_t)
+corenet_tcp_bind_all_nodes(rblsmtpd_t)
+corenet_udp_bind_generic_port(rblsmtpd_t)
+
+files_read_etc_files(rblsmtpd_t)
+files_search_var(rblsmtpd_t)
+
+libs_use_ld_so(rblsmtpd_t)
+libs_use_shared_libs(rblsmtpd_t)
+
+optional_policy(`daemontools',`
+	daemontools_ipc_domain(rblsmtpd_t)
+')
+
+########################################
+#
+# Local policy for tcpserver
+#
+
+allow ucspitcp_t self:capability { net_bind_service setgid setuid };
+allow ucspitcp_t self:fifo_file { read write };
+allow ucspitcp_t self:process { fork sigchld };
+allow ucspitcp_t self:tcp_socket create_stream_socket_perms;
+
+corecmd_search_bin(ucspitcp_t)
+corecmd_search_sbin(ucspitcp_t)
+
+corenet_tcp_sendrecv_all_if(ucspitcp_t)
+corenet_udp_sendrecv_all_if(ucspitcp_t)
+corenet_tcp_sendrecv_all_nodes(ucspitcp_t)
+corenet_udp_sendrecv_all_nodes(ucspitcp_t)
+corenet_tcp_sendrecv_all_ports(ucspitcp_t)
+corenet_udp_sendrecv_all_ports(ucspitcp_t)
+corenet_non_ipsec_sendrecv(ucspitcp_t)
+corenet_tcp_bind_all_nodes(ucspitcp_t)
+corenet_tcp_bind_ftp_port(ucspitcp_t)
+corenet_tcp_bind_ftp_data_port(ucspitcp_t)
+corenet_tcp_bind_http_port(ucspitcp_t)
+corenet_tcp_bind_smtp_port(ucspitcp_t)
+corenet_tcp_bind_dns_port(ucspitcp_t)
+corenet_udp_bind_dns_port(ucspitcp_t)
+corenet_udp_bind_generic_port(ucspitcp_t)
+
+files_search_var(ucspitcp_t)
+files_read_etc_files(ucspitcp_t)
+
+libs_use_ld_so(ucspitcp_t)
+libs_use_shared_libs(ucspitcp_t)
+
+sysnet_read_config(ucspitcp_t)
+
+optional_policy(`daemontools',`
+	daemontools_service_domain(ucspitcp_t,ucspitcp_exec_t)
+	daemontools_read_svc(ucspitcp_t)
+')
diff -ur --new-file --exclude=3DCVS --exclude=3D'corenetwork.*' policy.orig=
/policy/modules/system/daemontools.fc policy/policy/modules/system/daemonto=
ols.fc
--- policy.orig/policy/modules/system/daemontools.fc	1970-01-01 02:00:00.00=
0000000 +0200
+++ policy/policy/modules/system/daemontools.fc	2006-01-14 18:27:54.0000000=
00 +0200
@@ -0,0 +1,49 @@
+#
+# /service
+#
+
+/service(/.*)?			gen_context(system_u:object_r:svc_svc_t,s0)
+
+#
+# /usr
+#
+
+/usr/bin/envdir		--	gen_context(system_u:object_r:svc_run_exec_t,s0)
+/usr/bin/envuidgid	--	gen_context(system_u:object_r:svc_run_exec_t,s0)
+/usr/bin/fghack		--	gen_context(system_u:object_r:svc_run_exec_t,s0)
+/usr/bin/multilog	--	gen_context(system_u:object_r:svc_multilog_exec_t,s0)
+/usr/bin/pgrphack	--	gen_context(system_u:object_r:svc_run_exec_t,s0)
+/usr/bin/setlock	--	gen_context(system_u:object_r:svc_run_exec_t,s0)
+/usr/bin/setuidgid	--	gen_context(system_u:object_r:svc_run_exec_t,s0)
+/usr/bin/softlimit	--	gen_context(system_u:object_r:svc_run_exec_t,s0)
+/usr/bin/svc		--	gen_context(system_u:object_r:svc_start_exec_t,s0)
+/usr/bin/svok		--	gen_context(system_u:object_r:svc_start_exec_t,s0)
+/usr/bin/svscan		--	gen_context(system_u:object_r:svc_start_exec_t,s0)
+/usr/bin/svscanboot	--	gen_context(system_u:object_r:svc_start_exec_t,s0)
+/usr/bin/supervise	--	gen_context(system_u:object_r:svc_start_exec_t,s0)
+
+#
+# /var
+#
+
+/var/axfrdns(/.*)?			gen_context(system_u:object_r:svc_svc_t,s0)
+/var/axfrdns/run		--	gen_context(system_u:object_r:svc_run_exec_t,s0)
+/var/axfrdns/log/run	--	gen_context(system_u:object_r:svc_run_exec_t,s0)
+/var/axfrdns/env(/.*)?		gen_context(system_u:object_r:svc_conf_t,s0)
+
+/var/dnscache(/.*)?			gen_context(system_u:object_r:svc_svc_t,s0)
+/var/dnscache/env(/.*)?		gen_context(system_u:object_r:svc_conf_t,s0)
+/var/dnscache/run		--	gen_context(system_u:object_r:svc_run_exec_t,s0)
+/var/dnscache/log/run	--	gen_context(system_u:object_r:svc_run_exec_t,s0)
+
+/var/service/.*				gen_context(system_u:object_r:svc_svc_t,s0)
+/var/service/.*/env(/.*)?	gen_context(system_u:object_r:svc_conf_t,s0)
+/var/service/.*/log/main(/.*)?	gen_context(system_u:object_r:svc_log_t,s0)
+/var/service/.*/log/run		gen_context(system_u:object_r:svc_run_exec_t,s0)
+/var/service/.*/run.*		gen_context(system_u:object_r:svc_run_exec_t,s0)
+
+/var/tinydns(/.*)?			gen_context(system_u:object_r:svc_svc_t,s0)
+/var/tinydns/run		--	gen_context(system_u:object_r:svc_run_exec_t,s0)
+/var/tinydns/log/run	--	gen_context(system_u:object_r:svc_run_exec_t,s0)
+/var/tinydns/env(/.*)?		gen_context(system_u:object_r:svc_conf_t,s0)
+
diff -ur --new-file --exclude=3DCVS --exclude=3D'corenetwork.*' policy.orig=
/policy/modules/system/daemontools.if policy/policy/modules/system/daemonto=
ols.if
--- policy.orig/policy/modules/system/daemontools.if	1970-01-01 02:00:00.00=
0000000 +0200
+++ policy/policy/modules/system/daemontools.if	2006-01-14 18:10:58.0000000=
00 +0200
@@ -0,0 +1,147 @@
+## <summary>Collection of tools for managing UNIX services</summary>
+## <desc>
+##	<p>
+##		Policy for DJB's daemontools
+##	</p>
+## </desc>
+
+########################################
+## <summary>
+##	An ipc channel between the supervised domain and svc_start_t
+## </summary>
+## <param name=3D"domain">
+##	Domain allowed access to svc_start_t.
+## </param>
+#
+interface(`daemontools_ipc_domain',`
+	gen_require(`
+		type svc_start_t;
+	')
+
+	allow $1 svc_start_t:process sigchld;
+	allow $1 svc_start_t:fd use;
+	allow $1 svc_start_t:fifo_file { read write getattr };
+	allow svc_start_t $1:process signal;
+')
+
+########################################
+## <summary>
+##      Define a specified domain as a supervised service.
+## </summary>
+## <param name=3D"domain">
+##      Domain allowed access.
+## </param>
+## <param name=3D"entrypoint">
+##      The type associated with the process program.
+## </param>
+#
+interface(`daemontools_service_domain',`
+	gen_require(`
+		type svc_run_t;
+	')
+
+	domain_auto_trans(svc_run_t, $2, $1)
+	daemontools_ipc_domain($1)
+
+	allow svc_run_t $1:process signal;
+	allow $1 svc_run_t:fd use;
+')
+
+########################################
+## <summary>
+##      Execute in the svc_start_t domain.
+## </summary>
+## <param name=3D"domain">
+##      Domain allowed access.
+## </param>
+#
+interface(`daemontools_start_domtrans',`
+	gen_require(`
+		type svc_start_t, svc_start_exec_t;
+	')
+
+	domain_auto_trans($1, svc_start_exec_t, svc_start_t)
+
+	allow $1 svc_start_t:fd use;
+	allow svc_start_t $1:fd use;
+	allow svc_start_t $1:fifo_file rw_file_perms;
+	allow svc_start_t $1:process sigchld;
+')
+
+########################################
+## <summary>
+##      Execute in the svc_run_t domain.
+## </summary>
+## <param name=3D"domain">
+##      Domain allowed access.
+## </param>
+#
+interface(`daemontools_run_domtrans',`
+	gen_require(`
+		type svc_run_t, svc_run_exec_t;
+	')
+
+	domain_auto_trans($1, svc_run_exec_t, svc_run_t)
+
+	allow $1 svc_run_t:fd use;
+	allow svc_run_t $1:fd use;
+	allow svc_run_t $1:fifo_file rw_file_perms;
+	allow svc_run_t $1:process sigchld;
+')
+
+########################################
+## <summary>
+##      Execute in the svc_multilog_t domain.
+## </summary>
+## <param name=3D"domain">
+##      Domain allowed access.
+## </param>
+#
+interface(`daemontools_multilog_domtrans',`
+	gen_require(`
+		type svc_multilog_t, svc_multilog_exec_t;
+	')
+
+	domain_auto_trans($1, svc_multilog_exec_t, svc_multilog_t)
+
+	allow $1 svc_multilog_t:fd use;
+	allow svc_multilog_t $1:fd use;
+	allow svc_multilog_t $1:fifo_file rw_file_perms;
+	allow svc_multilog_t $1:process sigchld;
+')
+
+########################################
+## <summary>
+##      Allow a domain to read svc_svc_t files.
+## </summary>
+## <param name=3D"domain">
+##      Domain allowed access.
+## </param>
+#
+interface(`daemontools_read_svc',`
+	gen_require(`
+		type svc_svc_t;
+	')
+
+	allow $1 svc_svc_t:dir r_dir_perms;
+	allow $1 svc_svc_t:file r_file_perms;
+')
+
+########################################
+## <summary>
+##      Allow a domain to create svc_svc_t files.
+## </summary>
+## <param name=3D"domain">
+##      Domain allowed access.
+## </param>
+#
+interface(`daemontools_create_svc',`
+	gen_require(`
+		type svc_svc_t;
+	')
+
+	allow $1 svc_svc_t:dir create_dir_perms;
+	allow $1 svc_svc_t:fifo_file create_file_perms;
+	allow $1 svc_svc_t:file create_file_perms;
+	allow $1 svc_svc_t:lnk_file { read create };
+')
diff -ur --new-file --exclude=3DCVS --exclude=3D'corenetwork.*' policy.orig=
/policy/modules/system/daemontools.te policy/policy/modules/system/daemonto=
ols.te
--- policy.orig/policy/modules/system/daemontools.te	1970-01-01 02:00:00.00=
0000000 +0200
+++ policy/policy/modules/system/daemontools.te	2006-01-14 18:28:28.0000000=
00 +0200
@@ -0,0 +1,122 @@
+
+policy_module(daemontools,1.0.0)
+
+########################################
+#
+# Declarations
+#
+
+type svc_conf_t;
+files_type(svc_conf_t)
+
+type svc_log_t;
+files_type(svc_log_t)
+
+type svc_multilog_t;
+type svc_multilog_exec_t;
+domain_type(svc_multilog_t)
+domain_entry_file(svc_multilog_t,svc_multilog_exec_t)
+role system_r types svc_multilog_t;
+
+type svc_run_t;
+type svc_run_exec_t;
+domain_type(svc_run_t)
+domain_entry_file(svc_run_t,svc_run_exec_t)
+role system_r types svc_run_t;
+
+type svc_start_t;
+type svc_start_exec_t;
+init_system_domain(svc_start_t,svc_start_exec_t)
+role system_r types svc_start_t;
+
+type svc_svc_t;
+files_type(svc_svc_t)
+
+
+########################################
+#
+# multilog local policy
+#
+
+# multilog creates /service/*/log/status
+allow svc_multilog_t svc_svc_t:dir rw_dir_perms;
+allow svc_multilog_t svc_svc_t:file create_file_perms;
+
+daemontools_ipc_domain(svc_multilog_t)
+
+init_use_fd(svc_multilog_t)
+
+libs_use_ld_so(svc_multilog_t)
+libs_use_shared_libs(svc_multilog_t)
+
+# writes to /var/log/*/*
+logging_manage_generic_logs(svc_multilog_t)
+
+
+########################################
+#
+# local policy for binaries that impose=20
+# a given environment to supervised daemons
+# ie. softlimit, setuidgid, envuidgid, envdir, fghack ..
+#
+
+allow svc_run_t self:capability { setgid setuid chown fsetid };
+allow svc_run_t self:process setrlimit;
+allow svc_run_t self:fifo_file rw_file_perms;
+allow svc_run_t self:unix_stream_socket create_stream_socket_perms;
+
+allow svc_run_t svc_conf_t:dir r_dir_perms;
+allow svc_run_t svc_conf_t:file r_file_perms;
+
+can_exec(svc_run_t svc_run_exec_t)
+corecmd_exec_bin(svc_run_t)
+corecmd_exec_sbin(svc_run_t)
+corecmd_exec_shell(svc_run_t)
+corecmd_exec_ls(svc_run_t)
+
+daemontools_multilog_domtrans(svc_run_t)
+daemontools_read_svc(svc_run_t)
+
+files_read_etc_files(svc_run_t)
+files_read_etc_runtime_files(svc_run_t)
+files_search_pids(svc_run_t)
+files_search_var_lib(svc_run_t)
+
+init_use_script_fd(svc_run_t)
+init_use_fd(svc_run_t)
+
+kernel_read_system_state(svc_run_t)
+
+libs_use_ld_so(svc_run_t)
+libs_use_shared_libs(svc_run_t)
+
+########################################
+#
+# local policy for service monitoring programs
+# ie svc, svscan, supervise ...
+#
+
+allow svc_start_t svc_run_t:process signal;
+
+daemontools_run_domtrans(svc_start_t)
+
+allow svc_start_t self:fifo_file rw_file_perms;
+allow svc_start_t self:capability kill;
+allow svc_start_t self:unix_stream_socket create_socket_perms;
+
+can_exec(svc_start_t svc_start_exec_t)
+
+corecmd_read_sbin_symlink(svc_start_t)
+corecmd_exec_bin(svc_start_t)
+corecmd_exec_shell(svc_start_t)
+
+daemontools_create_svc(svc_start_t)
+
+files_read_etc_files(svc_start_t)
+files_read_etc_runtime_files(svc_start_t)
+files_search_var(svc_start_t)
+files_search_pids(svc_start_t)
+
+libs_use_ld_so(svc_start_t)
+libs_use_shared_libs(svc_start_t)
+
diff -ur --new-file --exclude=3DCVS --exclude=3D'corenetwork.*' policy.orig=
/policy/modules/system/init.fc policy/policy/modules/system/init.fc
--- policy.orig/policy/modules/system/init.fc	2005-11-12 00:23:47.000000000=
 +0200
+++ policy/policy/modules/system/init.fc	2006-01-14 18:27:20.000000000 +0200
@@ -28,6 +28,8 @@
 /sbin/rc		--	gen_context(system_u:object_r:initrc_exec_t,s0)
 /sbin/runscript		--      gen_context(system_u:object_r:initrc_exec_t,s0)
 /sbin/runscript\.sh	--	gen_context(system_u:object_r:initrc_exec_t,s0)
+/sbin/runsvcscript\.sh	--	gen_context(system_u:object_r:initrc_exec_t,s0)
+/sbin/svcinit		--	gen_context(system_u:object_r:initrc_exec_t,s0)
 ')
=20
 #
@@ -41,6 +43,7 @@
 #
 ifdef(`distro_gentoo', `
 /var/lib/init\.d(/.*)?		gen_context(system_u:object_r:initrc_state_t,s0)
+/var/run/svscan\.pid	--	gen_context(system_u:object_r:initrc_var_run_t,s0)
 ')
=20
 /var/run/utmp		--	gen_context(system_u:object_r:initrc_var_run_t,s0)
diff -ur --new-file --exclude=3DCVS --exclude=3D'corenetwork.*' policy.orig=
/policy/modules/system/init.te policy/policy/modules/system/init.te
--- policy.orig/policy/modules/system/init.te	2006-01-13 23:26:19.000000000=
 +0200
+++ policy/policy/modules/system/init.te	2006-01-14 18:32:16.000000000 +0200
@@ -182,6 +182,10 @@
 	auth_rw_login_records(init_t)
 ')
=20
+optional_policy(`daemontools',`
+	daemontools_start_domtrans(init_t)
+')
+
 optional_policy(`nscd',`
 	nscd_use_socket(init_t)
 ')
@@ -512,6 +516,10 @@
 	cups_read_log(initrc_t)
 ')
=20
+optional_policy(`daemontools',`
+	daemontools_create_svc(initrc_t)
+')
+
 optional_policy(`dbus',`
 	dbus_connect_system_bus(initrc_t)
 	dbus_send_system_bus_msg(initrc_t)
diff -ur --new-file --exclude=3DCVS --exclude=3D'corenetwork.*' policy.orig=
/policy/modules/system/logging.fc policy/policy/modules/system/logging.fc
--- policy.orig/policy/modules/system/logging.fc	2006-01-07 00:55:18.000000=
000 +0200
+++ policy/policy/modules/system/logging.fc	2006-01-14 18:36:36.000000000 +=
0200
@@ -19,6 +19,9 @@
 /var/lib/stunnel/dev/log -s	gen_context(system_u:object_r:devlog_t,s0)
 ')
=20
+/var/axfrdns/log/main(/.*)?		gen_context(system_u:object_r:var_log_t,s0)
+/var/dnscache/log/main(/.*)?	gen_context(system_u:object_r:var_log_t,s0)
+
 /var/log			-d	gen_context(system_u:object_r:var_log_t,s0-s15:c0.c255)
 /var/log/.*			gen_context(system_u:object_r:var_log_t,s0)
 /var/log/audit.log	--	gen_context(system_u:object_r:auditd_log_t,s15:c0.c2=
55)
@@ -29,3 +32,6 @@
 /var/run/log		-s	gen_context(system_u:object_r:devlog_t,s0)
 /var/run/metalog\.pid	--	gen_context(system_u:object_r:syslogd_var_run_t,s=
0)
 /var/run/syslogd\.pid	--	gen_context(system_u:object_r:syslogd_var_run_t,s=
0)
+
+/var/tinydns/log/main(/.*)?		gen_context(system_u:object_r:var_log_t,s0)
+
diff -ur --new-file --exclude=3DCVS --exclude=3D'corenetwork.*' policy.orig=
/policy/modules/system/selinuxutil.te policy/policy/modules/system/selinuxu=
til.te
--- policy.orig/policy/modules/system/selinuxutil.te	2006-01-07 00:55:18.00=
0000000 +0200
+++ policy/policy/modules/system/selinuxutil.te	2006-01-14 18:33:26.0000000=
00 +0200
@@ -451,13 +451,15 @@
 	logging_send_syslog_msg(run_init_t)
 ') dnl end ifdef targeted policy
=20
ifdef(`TODO',`
 ifdef(`distro_gentoo', `
 	# Gentoo integrated run_init+open_init_pty-runscript:
 	domain_entry_file(run_init_t,initrc_exec_t)
 	domain_auto_trans(sysadm_t,initrc_exec_t,run_init_t)
 ')
') dnl end TODO
+
+optional_policy(`daemontools',`
+	daemontools_start_domtrans(run_init_t)
+')
=20
 ########################################
 #

--rwEMma7ioTxnRzrJ--

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)

iD8DBQFDySmJGSBEIeh4AEYRAiOnAJ9aWUAOeVIzxlDuCvHXL2So2R0KQgCeKLAn
iWgUGfE5idySm7MJd35BvtU=
=i2Ul
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
