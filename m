Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2GDOnDo006539
	for <selinux@tycho.nsa.gov>; Wed, 16 Mar 2005 08:24:49 -0500 (EST)
Received: from static-70-19-113-34.ny325.east.verizon.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2GDIlfp029100
	for <selinux@tycho.nsa.gov>; Wed, 16 Mar 2005 13:18:47 GMT
Subject: Tweaks to the dovecot policy
From: David Hampton <hampton-rh@rainbolthampton.net>
To: selinux@tycho.nsa.gov
Cc: fedora-selinux-list@redhat.com
Content-Type: multipart/mixed; boundary="=-QDX9FxaEOKjBP4Zg9c0S"
Date: Wed, 16 Mar 2005 08:18:47 -0500
Message-Id: <1110979127.20316.20.camel@hampton-pc.rainbolthampton.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-QDX9FxaEOKjBP4Zg9c0S
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I've added support to the dovecot policy to allow authentication against
a dovecot private password file, and added a couple of tweaks that I
hope tighten up the security of dovecot a little bit.  They make the
dovecot configuration file into a unique type, and add a type that can
be used to distinguish mail stored by dovecot from other mail stored on
the system.

David

P.S.  These diffs are based on the files from the selinux-policy-strict-
sources-1.22.1-2 rpm on my FC3 system.

--=-QDX9FxaEOKjBP4Zg9c0S
Content-Disposition: attachment; filename=dovecot.diffs
Content-Type: text/x-patch; name=dovecot.diffs; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: domains/program/dovecot.te
===================================================================
RCS file: /home/cvs/starfury/etc/selinux/strict/src/policy/domains/program/dovecot.te,v
retrieving revision 1.2
diff -u -r1.2 dovecot.te
--- domains/program/dovecot.te	26 Feb 2005 22:43:39 -0000	1.2
+++ domains/program/dovecot.te	14 Mar 2005 23:13:24 -0000
@@ -3,13 +3,19 @@
 # Author:  Russell Coker <russell@coker.com.au>
 # X-Debian-Packages: dovecot-imapd, dovecot-pop3d
 
+#
+# Main dovecot daemon
+#
 daemon_domain(dovecot, `, privhome')
+etc_domain(dovecot);
 
 allow dovecot_t dovecot_var_run_t:sock_file create_file_perms;
 
 can_exec(dovecot_t, dovecot_exec_t)
 
 type dovecot_cert_t, file_type, sysadmfile;
+type dovecot_passwd_t, file_type, sysadmfile;
+type dovecot_spool_t, file_type, sysadmfile;
 
 allow dovecot_t self:capability { dac_override dac_read_search chown net_bind_service setgid setuid sys_chroot };
 allow dovecot_t self:process setrlimit;
@@ -27,6 +33,7 @@
 allow dovecot_t pop_port_t:tcp_socket name_bind;
 allow dovecot_t urandom_device_t:chr_file read;
 allow dovecot_t dovecot_cert_t:file { getattr read };
+allow dovecot_t cert_t:dir search;
 
 allow dovecot_t { self proc_t }:file { getattr read };
 allow dovecot_t self:fifo_file rw_file_perms;
@@ -35,10 +42,16 @@
 
 allow dovecot_t tmp_t:dir search;
 rw_dir_file(dovecot_t, mail_spool_t)
+create_dir_file(dovecot_t, dovecot_spool_t)
+create_dir_file(mta_delivery_agent, dovecot_spool_t)
 allow dovecot_t mail_spool_t:lnk_file read;
 allow dovecot_t var_spool_t:dir { search };
 
+#
+# Dovecot auth daemon
+#
 daemon_sub_domain(dovecot_t, dovecot_auth, `, auth_chkpwd')
+allow dovecot_auth_t self:capability { setgid setuid };
 allow dovecot_auth_t self:process { fork signal_perms };
 allow dovecot_auth_t dovecot_t:unix_stream_socket { getattr accept read write ioctl };
 allow dovecot_auth_t self:unix_dgram_socket create_socket_perms;
@@ -50,5 +63,6 @@
 read_locale(dovecot_auth_t)
 read_sysctl(dovecot_auth_t)
 allow dovecot_auth_t sysctl_t:dir search;
+allow dovecot_auth_t dovecot_passwd_t:file { getattr read };
 dontaudit dovecot_auth_t selinux_config_t:dir search;
 
Index: file_contexts/program/dovecot.fc
===================================================================
RCS file: /home/cvs/starfury/etc/selinux/strict/src/policy/file_contexts/program/dovecot.fc,v
retrieving revision 1.1
diff -u -r1.1 dovecot.fc
--- file_contexts/program/dovecot.fc	10 Feb 2005 16:05:59 -0000	1.1
+++ file_contexts/program/dovecot.fc	14 Mar 2005 23:13:02 -0000
@@ -1,4 +1,6 @@
 # for Dovecot POP and IMAP server
+/etc/dovecot.conf.*			system_u:object_r:dovecot_etc_t
+/etc/dovecot.passwd.*			system_u:object_r:dovecot_passwd_t
 /usr/sbin/dovecot		--	system_u:object_r:dovecot_exec_t
 ifdef(`distro_redhat', `
 /usr/libexec/dovecot/dovecot-auth --	system_u:object_r:dovecot_auth_exec_t
@@ -10,3 +12,4 @@
 /usr/share/ssl/private/dovecot\.pem --	system_u:object_r:dovecot_cert_t
 /var/run/dovecot(-login)?(/.*)?		system_u:object_r:dovecot_var_run_t
 /usr/lib(64)?/dovecot/.+	--		system_u:object_r:bin_t
+/var/spool/dovecot(/.*)?		system_u:object_r:dovecot_spool_t

--=-QDX9FxaEOKjBP4Zg9c0S--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
