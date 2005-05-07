Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j47CvIgA022986
	for <selinux@tycho.nsa.gov>; Sat, 7 May 2005 08:57:18 -0400 (EDT)
Received: from sunspire.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j47CtIF1020573
	for <selinux@tycho.nsa.gov>; Sat, 7 May 2005 12:55:19 GMT
Message-ID: <427CBAD8.6060901@gentoo.org>
Date: Sat, 07 May 2005 15:55:52 +0300
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: gentoo diffs
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig560E1DAB70535D76A56E80D9"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig560E1DAB70535D76A56E80D9
Content-Type: multipart/mixed;
 boundary="------------050804080109020502090508"

This is a multi-part message in MIME format.
--------------050804080109020502090508
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


Hi,

here is the short version of the gentoo policy patches:

* named: changed one file label
* daemontools: policy cleanup, added support for 2 more services
* dante: policy tweaks needed for latest versions
* gnupg: support for gnupg-1.9.x
* kerberos: gentoo file locations
* postfix: gentoo file locations for 64bit systems
* ucspi-tcp: patch from Andy Dustman to support rblsmtp

bye,
peter

-- 
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------050804080109020502090508
Content-Type: text/plain;
 name="selinux-bind.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="selinux-bind.diff"

--- /root/public_html/policy/nsa/file_contexts/program/named.fc	2005-04-17 00:36:16.000000000 +0300
+++ /root/cvs/cvs.gentoo.org/gentoo-projects/selinux/bind/named.fc	2005-05-07 10:47:59.000000000 +0300
@@ -43,7 +43,7 @@
 ifdef(`distro_gentoo', `
 /etc/bind(/.*)?         system_u:object_r:named_zone_t
 /etc/bind/named\.conf   --  system_u:object_r:named_conf_t
-/etc/bind/rndc\.key    --  system_u:object_r:named_conf_t
+/etc/bind/rndc\.key    --  system_u:object_r:dnssec_t
 /var/bind(/.*)?             system_u:object_r:named_cache_t
 /var/bind/pri(/.*)?         system_u:object_r:named_zone_t
 ') dnl distro_gentoo
--------------050804080109020502090508
Content-Type: text/plain;
 name="selinux-daemontools.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="selinux-daemontools.diff"

--- /root/public_html/policy/nsa/macros/program/daemontools_macros.te	2005-03-15 19:54:55.000000000 +0200
+++ /root/cvs/cvs.gentoo.org/gentoo-projects/selinux/daemontools/daemontools_macros.te	2005-03-16 20:33:50.000000000 +0200
@@ -1,10 +1,10 @@
 ifdef(`daemontools.te', `
 
 define(`svc_ipc_domain',`
-allow $1 svc_start_t:process { sigchld };
-allow $1 svc_start_t:fd { use };
-allow $1 svc_start_t:fifo_file { read write };
-allow svc_start_t $1:process { signal }; 
+allow $1 svc_start_t:process sigchld;
+allow $1 svc_start_t:fd use;
+allow $1 svc_start_t:fifo_file { read write getattr };
+allow svc_start_t $1:process signal; 
 ')
 
 ') dnl ifdef daemontools
--- /root/public_html/policy/nsa/file_contexts/program/daemontools.fc	2005-03-15 19:54:54.000000000 +0200
+++ /root/cvs/cvs.gentoo.org/gentoo-projects/selinux/daemontools/daemontools.fc	2005-03-16 20:08:01.000000000 +0200
@@ -22,7 +22,6 @@
 /usr/bin/svscan		--	system_u:object_r:svc_start_exec_t
 /usr/bin/svscanboot	--	system_u:object_r:svc_start_exec_t
 /usr/bin/svok		--	system_u:object_r:svc_start_exec_t
-#/usr/bin/svstat		--	system_u:object_r:svc_start_exec_t
 /usr/bin/supervise	--	system_u:object_r:svc_start_exec_t
 
 # starting scripts
--- /root/public_html/policy/nsa/domains/program/unused/daemontools.te	2005-03-15 19:54:54.000000000 +0200
+++ /root/cvs/cvs.gentoo.org/gentoo-projects/selinux/daemontools/daemontools.te	2005-03-16 20:39:52.000000000 +0200
@@ -27,18 +27,16 @@
 file_type_auto_trans($1, svc_svc_t, svc_svc_t);
 ')
 
-define(`svc_base_domain', `
-daemon_base_domain($1)
-svc_filedir_domain(`$1_t')
-')
-
 ##############################################################
 # the domains
+daemon_base_domain(svc_script)
+svc_filedir_domain(svc_script_t)
 
 # part started by initrc_t
-svc_base_domain(svc_start)
+daemon_base_domain(svc_start)
+domain_auto_trans(init_t, svc_start_exec_t, svc_start_t)
+svc_filedir_domain(svc_start_t)
 
-svc_base_domain(svc_script)
 # also get here from svc_script_t
 domain_auto_trans(svc_script_t, svc_start_exec_t, svc_start_t)
 
@@ -65,12 +63,18 @@
 # svc_start_t
 allow svc_start_t self:fifo_file rw_file_perms;
 allow svc_start_t self:capability kill;
+allow svc_start_t self:unix_stream_socket create_socket_perms;
+
 allow svc_start_t { bin_t sbin_t etc_t }:dir r_dir_perms;
 allow svc_start_t { bin_t sbin_t etc_t }:lnk_file r_file_perms;
+allow svc_start_t { etc_t etc_runtime_t }:file r_file_perms;
 allow svc_start_t { var_t var_run_t }:dir search;
+can_exec(svc_start_t, bin_t)
 can_exec(svc_start_t, shell_exec_t)
 allow svc_start_t svc_start_exec_t:file { rx_file_perms execute_no_trans };
 allow svc_start_t svc_run_t:process signal;
+dontaudit svc_start_t proc_t:file r_file_perms;
+dontaudit svc_start_t devtty_t:chr_file { read write };
 
 # svc script
 allow svc_script_t self:capability sys_admin;
@@ -140,6 +144,11 @@
 dontaudit httpd_t svc_svc_t:dir { search };
 ')
 
+ifdef(`clamav.te', `
+domain_auto_trans(svc_run_t, clamd_exec_t, clamd_t)
+svc_ipc_domain(clamd_t)
+')
+
 ifdef(`clockspeed.te', `
 domain_auto_trans( svc_run_t, clockspeed_exec_t, clockspeed_t)
 svc_ipc_domain(clockspeed_t)
@@ -171,6 +180,11 @@
 svc_ipc_domain(rsyncd_t)
 ')
 
+ifdef(`spamd.te', `
+domain_auto_trans(svc_run_t, spamd_exec_t, spamd_t)
+svc_ipc_domain(spamd_t)
+')
+
 ifdef(`ssh.te', `
 domain_auto_trans(svc_run_t, sshd_exec_t, sshd_t)
 svc_ipc_domain(sshd_t)

--------------050804080109020502090508
Content-Type: text/plain;
 name="selinux-dante.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="selinux-dante.diff"

--- /root/public_html/policy/nsa/domains/program/unused/dante.te	2004-12-06 21:01:25.000000000 +0200
+++ /root/cvs/cvs.gentoo.org/gentoo-projects/selinux/dante/dante.te	2005-03-08 12:59:22.000000000 +0200
@@ -10,11 +10,16 @@
 can_network_server(dante_t)
 
 allow dante_t self:fifo_file { read write };
-allow dante_t self:capability { setuid };
+allow dante_t self:capability { setuid setgid };
 allow dante_t self:unix_dgram_socket { connect create write };
 allow dante_t self:unix_stream_socket { connect create read setopt write };
+allow dante_t self:tcp_socket connect;
 
 allow dante_t socks_port_t:tcp_socket name_bind;
 
 allow dante_t { etc_t etc_runtime_t }:file r_file_perms;
 r_dir_file(dante_t, dante_conf_t)
+
+allow dante_t initrc_var_run_t:file { getattr write };
+

--------------050804080109020502090508
Content-Type: text/plain;
 name="selinux-gnupg.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="selinux-gnupg.diff"

--- /root/public_html/policy/nsa/file_contexts/program/gpg.fc	2005-01-26 09:01:01.000000000 +0200
+++ /root/cvs/cvs.gentoo.org/gentoo-projects/selinux/gnupg/gpg.fc	2005-04-08 12:24:21.000000000 +0300
@@ -1,5 +1,7 @@
 # gpg
 HOME_DIR/\.gnupg(/.+)?	system_u:object_r:ROLE_gpg_secret_t
-/usr/bin/gpg		--	system_u:object_r:gpg_exec_t
+/usr/bin/gpg(2)?		--	system_u:object_r:gpg_exec_t
 /usr/bin/kgpg		--	system_u:object_r:gpg_exec_t
-/usr/lib/gnupg/gpgkeys.*	--	system_u:object_r:gpg_helper_exec_t
+/usr/lib/gnupg/.*	--	system_u:object_r:gpg_exec_t
+/usr/lib/gnupg/gpgkeys.*	--  system_u:object_r:gpg_helper_exec_t
+
--------------050804080109020502090508
Content-Type: text/plain;
 name="selinux-kerberos.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="selinux-kerberos.diff"

--- /root/public_html/policy/nsa/file_contexts/program/kerberos.fc	2005-01-12 20:52:11.000000000 +0200
+++ /root/cvs/cvs.gentoo.org/gentoo-projects/selinux/kerberos/kerberos.fc	2005-02-26 22:59:34.000000000 +0200
@@ -9,3 +9,12 @@
 /var/log/krb5kdc\.log			system_u:object_r:krb5kdc_log_t
 /var/log/kadmind\.log			system_u:object_r:kadmind_log_t
 /usr(/local)?/bin/ksu		--	system_u:object_r:su_exec_t
+
+# gentoo file locations
+/usr/sbin/krb5kdc			--	system_u:object_r:krb5kdc_exec_t
+/usr/sbin/kadmind			--	system_u:object_r:kadmind_exec_t
+/etc/krb5kdc(/.*)?				system_u:object_r:krb5kdc_conf_t
+/etc/krb5kdc/principal.*		system_u:object_r:krb5kdc_principal_t
+/etc/krb5kdc/kadm5.keytab 	--	system_u:object_r:krb5_keytab_t
+/var/log/kadmin.log			--	system_u:object_r:kadmind_log_t
+

--------------050804080109020502090508
Content-Type: text/plain;
 name="selinux-postfix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="selinux-postfix.diff"

--- /root/public_html/policy/nsa/file_contexts/program/postfix.fc	2005-02-17 13:58:35.000000000 +0200
+++ /root/cvs/cvs.gentoo.org/gentoo-projects/selinux/postfix/postfix.fc	2005-04-17 00:34:20.000000000 +0300
@@ -5,17 +5,17 @@
 ')
 /etc/postfix/postfix-script.* -- system_u:object_r:postfix_exec_t
 /etc/postfix/prng_exch	--	system_u:object_r:postfix_prng_t
-/usr/lib(exec)?/postfix/.*	--	system_u:object_r:postfix_exec_t
-/usr/lib(exec)?/postfix/cleanup --	system_u:object_r:postfix_cleanup_exec_t
-/usr/lib(exec)?/postfix/local	--	system_u:object_r:postfix_local_exec_t
-/usr/lib(exec)?/postfix/master	--	system_u:object_r:postfix_master_exec_t
-/usr/lib(exec)?/postfix/pickup	--	system_u:object_r:postfix_pickup_exec_t
-/usr/lib(exec)?/postfix/(n)?qmgr --	system_u:object_r:postfix_qmgr_exec_t
-/usr/lib(exec)?/postfix/showq	--	system_u:object_r:postfix_showq_exec_t
-/usr/lib(exec)?/postfix/smtp	--	system_u:object_r:postfix_smtp_exec_t
-/usr/lib(exec)?/postfix/smtpd	--	system_u:object_r:postfix_smtpd_exec_t
-/usr/lib(exec)?/postfix/bounce	--	system_u:object_r:postfix_bounce_exec_t
-/usr/lib(exec)?/postfix/pipe	--	system_u:object_r:postfix_pipe_exec_t
+/usr/lib(exec)?(64)?/postfix/.*	--	system_u:object_r:postfix_exec_t
+/usr/lib(exec)?(64)?/postfix/cleanup --	system_u:object_r:postfix_cleanup_exec_t
+/usr/lib(exec)?(64)?/postfix/local	--	system_u:object_r:postfix_local_exec_t
+/usr/lib(exec)?(64)?/postfix/master	--	system_u:object_r:postfix_master_exec_t
+/usr/lib(exec)?(64)?/postfix/pickup	--	system_u:object_r:postfix_pickup_exec_t
+/usr/lib(exec)?(64)?/postfix/(n)?qmgr --	system_u:object_r:postfix_qmgr_exec_t
+/usr/lib(exec)?(64)?/postfix/showq	--	system_u:object_r:postfix_showq_exec_t
+/usr/lib(exec)?(64)?/postfix/smtp	--	system_u:object_r:postfix_smtp_exec_t
+/usr/lib(exec)?(64)?/postfix/smtpd	--	system_u:object_r:postfix_smtpd_exec_t
+/usr/lib(exec)?(64)?/postfix/bounce	--	system_u:object_r:postfix_bounce_exec_t
+/usr/lib(exec)?(64)?/postfix/pipe	--	system_u:object_r:postfix_pipe_exec_t
 /usr/sbin/postalias	--	system_u:object_r:postfix_master_exec_t
 /usr/sbin/postcat	--	system_u:object_r:postfix_master_exec_t
 /usr/sbin/postdrop	--	system_u:object_r:postfix_postdrop_exec_t
--------------050804080109020502090508
Content-Type: text/plain;
 name="selinux-ucspi-tcp.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="selinux-ucspi-tcp.diff"

--- /root/public_html/policy/nsa/file_contexts/program/ucspi-tcp.fc	2005-03-15 19:54:54.000000000 +0200
+++ /root/cvs/cvs.gentoo.org/gentoo-projects/selinux/ucspi-tcp/ucspi-tcp.fc	2005-03-16 19:57:48.000000000 +0200
@@ -1,2 +1,3 @@
 #ucspi-tcp
 /usr/bin/tcpserver	--	system_u:object_r:utcpserver_exec_t
+/usr/bin/rblsmtpd	--	system_u:object_r:rblsmtpd_exec_t
--- /root/public_html/policy/nsa/domains/program/unused/ucspi-tcp.te	2005-04-17 00:36:16.000000000 +0300
+++ /root/cvs/cvs.gentoo.org/gentoo-projects/selinux/ucspi-tcp/ucspi-tcp.te	2005-05-07 12:41:02.000000000 +0300
@@ -1,6 +1,7 @@
 #DESC ucspi-tcp - TCP Server and Client Tools
 #
 # Author Petre Rodan <kaiowas@gentoo.org>
+#			Andy Dustman (rblsmtp-related policy)
 #
 
 # http://cr.yp.to/ucspi-tcp.html
@@ -9,18 +10,16 @@
 
 daemon_base_domain(utcpserver)
 can_network(utcpserver_t)
-allow utcpserver_t port_type:tcp_socket name_connect;
 
-#reads /etc/nsswitch.conf and resolv.conf
-allow utcpserver_t etc_t:file { getattr read };
-allow utcpserver_t net_conf_t:file { read };
-
-allow utcpserver_t { bin_t var_t }:dir { search };
+allow utcpserver_t etc_t:file r_file_perms;
+allow utcpserver_t { bin_t sbin_t var_t }:dir search;
 
 allow utcpserver_t self:capability { net_bind_service setgid setuid };
 allow utcpserver_t self:fifo_file { read write };
 allow utcpserver_t self:process { fork sigchld };
 
+allow utcpserver_t port_t:udp_socket name_bind;
+
 ifdef(`qmail.te', `
 domain_auto_trans(utcpserver_t, qmail_smtpd_exec_t, qmail_smtpd_t)
 allow utcpserver_t smtp_port_t:tcp_socket name_bind;
@@ -29,3 +28,24 @@
 allow utcpserver_t qmail_etc_t:file r_file_perms;
 ')
 
+daemon_base_domain(rblsmtpd)
+can_network(rblsmtpd_t)
+
+allow rblsmtpd_t self:process { fork sigchld };
+
+allow rblsmtpd_t etc_t:file r_file_perms;
+allow rblsmtpd_t { bin_t var_t }:dir search;
+allow rblsmtpd_t port_t:udp_socket name_bind;
+allow rblsmtpd_t utcpserver_t:tcp_socket { read write getattr };
+
+ifdef(`qmail.te', `
+domain_auto_trans(rblsmtpd_t, qmail_smtpd_exec_t, qmail_smtpd_t)
+allow qmail_queue_t rblsmtpd_t:fd use;
+')
+
+ifdef(`daemontools.te', `
+svc_ipc_domain(rblsmtpd_t)
+')
+
+domain_auto_trans(utcpserver_t, rblsmtpd_exec_t, rblsmtpd_t)
+

--------------050804080109020502090508--

--------------enig560E1DAB70535D76A56E80D9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1-ecc0.1.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCfLreGSBEIeh4AEYRAnBYAKCLPaLkz32x8EwT+1l583HuuX8cHgCfZYvH
LfV81W8/n6dKrawzqvhjQH4=
=6S/Y
-----END PGP SIGNATURE-----

--------------enig560E1DAB70535D76A56E80D9--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
