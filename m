Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id VAA03584
	for <selinux@tycho.nsa.gov>; Fri, 25 Oct 2002 21:39:06 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id BAA28110
	for <selinux@tycho.nsa.gov>; Sat, 26 Oct 2002 01:37:11 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id BAA28106 for <selinux@tycho.nsa.gov>; Sat, 26 Oct 2002 01:37:08 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id CC82692724
	for <selinux@tycho.nsa.gov>; Sat, 26 Oct 2002 11:38:48 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 9E7E9784
	for <selinux@tycho.nsa.gov>; Sat, 26 Oct 2002 03:38:40 +0200 (CEST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: run_init
Date: Sat, 26 Oct 2002 03:38:39 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_F8FKA9MTK92L7PCXXNI0"
Message-Id: <200210260338.39715.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_F8FKA9MTK92L7PCXXNI0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I have attached the source to a modified version of run_init that runs another 
process (in initrc_t) to actually run the daemon.

initrc_t is allowed to write to the sysadm terminal, and I've changed my 
policy to allow all daemons rw_file_perms access to initrc_devpts_t.

I've gone through the policy for all the daemons and removed any instances 
(even commented ones) of direct daemon access to the administrator terminal.

I also noticed a minor error related to devfs pty's.  I have now made the pty 
allocation macro include filesystem getattr access.  I would have done that 
before if I knew it was the openpty() library call that was doing it.

I have attached the policy patch to this message.  Steve, I encourage you to 
apply this patch to the CVS now.  It does what you want the policy to do.  We 
can probably have a discussion about the best way of implementing the 
openpty() code (and my code at the moment is a bit messy).  But regardless of 
how we might decide to change it, it'll at most require something like a 2 
line policy patch.

Also the policy patch applies on top of my previous patch.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--------------Boundary-00=_F8FKA9MTK92L7PCXXNI0
Content-Type: application/x-tgz;
  name="run_init.tgz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="run_init.tgz"

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

--------------Boundary-00=_F8FKA9MTK92L7PCXXNI0
Content-Type: text/x-diff;
  charset="us-ascii";
  name="init.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="init.diff"

Only in /tmp/policy/domains: admin
diff -ru /tmp/policy/domains/program/apache.te ./domains/program/apache.te
--- /tmp/policy/domains/program/apache.te	2002-10-23 21:38:16.000000000 +0200
+++ ./domains/program/apache.te	2002-10-26 02:49:28.000000000 +0200
@@ -365,17 +365,6 @@
 allow httpd_t httpd_user_script_rw_t:file r_file_perms;
 allow httpd_t httpd_user_script_rw_t:dir r_dir_perms;
 
-########################################
-# When the admin starts the server, the server wants to acess
-# the TTY or PTY associated with the session. The httpd appears
-# to run correctly without this permission, so the permission
-# are commented out here. If you decide that access is needed,
-# then uncomment, but be aware that this will grant httpd access
-# to all sysadm_r TTYs and PTYs.
-##################################################
-#allow httpd_t admin_tty_type:chr_file write;
-dontaudit httpd_t admin_tty_type:chr_file { read write };
-
 ###########################
 # Allow httpd to receive messages from the network card
 ########################################
@@ -399,12 +388,12 @@
 #################################################
 # Allow the httpd_t to read the web servers config files
 ###################################################
-allow httpd_t httpd_config_t:file r_file_perms;
-allow httpd_t httpd_config_t:dir r_dir_perms;
+r_dir_file(httpd_t, httpd_config_t)
 # allow logrotate to read the config files for restart
 ifdef(`logrotate.te', `
 r_dir_file(logrotate_t, httpd_config_t)
 ')
+r_dir_file(initrc_t, httpd_config_t)
 ##################################################
 
 ##################################################
diff -ru /tmp/policy/domains/program/courier.te ./domains/program/courier.te
--- /tmp/policy/domains/program/courier.te	2002-10-10 17:50:12.000000000 +0200
+++ ./domains/program/courier.te	2002-10-26 02:48:14.000000000 +0200
@@ -112,9 +112,6 @@
 # for calendaring
 courier_domain(pcp)
 
-# courier pcpd will not start (from an admin shell) without this!
-#allow courier_pcp_t admin_tty_type:chr_file { read write };
-
 allow courier_pcp_t self:capability { setuid setgid };
 allow courier_pcp_t random_device_t:chr_file r_file_perms;
 
diff -ru /tmp/policy/domains/program/devfsd.te ./domains/program/devfsd.te
--- /tmp/policy/domains/program/devfsd.te	2002-09-27 22:27:37.000000000 +0200
+++ ./domains/program/devfsd.te	2002-10-26 02:49:34.000000000 +0200
@@ -19,7 +19,6 @@
 allow devfsd_t proc_t:dir r_dir_perms;
 allow devfsd_t { etc_t etc_runtime_t proc_t }:file r_file_perms;
 allow devfsd_t devtty_t:chr_file rw_file_perms;
-#allow devfsd_t admin_tty_type:chr_file { read write };
 
 # Run /sbin/modprobe
 allow devfsd_t sbin_t:dir r_dir_perms;
diff -ru /tmp/policy/domains/program/dpkg.te ./domains/program/dpkg.te
--- /tmp/policy/domains/program/dpkg.te	2002-10-26 03:27:45.000000000 +0200
+++ ./domains/program/dpkg.te	2002-10-26 03:19:46.000000000 +0200
@@ -109,6 +109,10 @@
 # daemons are started in the correct context
 domain_auto_trans(dpkg_t, etc_t, initrc_t)
 
+# allow dpkg to run open_init_pty
+can_create_other_pty(dpkg, initrc)
+can_exec(dpkg_t, initrc_exec_t)
+
 ifdef(`bootloader.te',
 `domain_auto_trans(dpkg_t, bootloader_exec_t, bootloader_t)')
 
diff -ru /tmp/policy/domains/program/initrc.te ./domains/program/initrc.te
--- /tmp/policy/domains/program/initrc.te	2002-10-01 19:28:43.000000000 +0200
+++ ./domains/program/initrc.te	2002-10-26 02:41:58.000000000 +0200
@@ -19,6 +19,9 @@
 every_domain(initrc_t)
 type initrc_exec_t, file_type, sysadmfile, exec_type;
 
+# Can create ptys for open_init_pty
+can_create_pty(initrc)
+
 type initrc_tmp_t, file_type, sysadmfile, tmpfile;
 file_type_auto_trans(initrc_t, tmp_t, initrc_tmp_t)
 
@@ -227,4 +230,4 @@
 #
 # Rules for the run_init_t domain.
 #
-run_program(sysadm_t, sysadm_r, init, etc_t, initrc_t)
+run_program(sysadm_t, sysadm_r, init, initrc_exec_t, initrc_t)
diff -ru /tmp/policy/domains/program/ircd.te ./domains/program/ircd.te
--- /tmp/policy/domains/program/ircd.te	2002-09-27 22:27:37.000000000 +0200
+++ ./domains/program/ircd.te	2002-10-26 02:49:39.000000000 +0200
@@ -21,8 +21,6 @@
 type var_lib_ircd_t, sysadmfile, file_type;
 file_type_auto_trans(ircd_t, var_lib_t, var_lib_ircd_t)
 
-#allow ircd_t admin_tty_type:chr_file rw_file_perms;
-
 # Use the network.
 can_network(ircd_t)
 #allow ircd_t self:fifo_file { read write };
diff -ru /tmp/policy/domains/program/named.te ./domains/program/named.te
--- /tmp/policy/domains/program/named.te	2002-10-17 00:01:11.000000000 +0200
+++ ./domains/program/named.te	2002-10-26 02:48:19.000000000 +0200
@@ -17,9 +17,6 @@
 type ndc_t, domain, privlog;
 role sysadm_r types ndc_t;
 
-# named will not start (from an admin shell) without this!
-#allow named_t admin_tty_type:chr_file { read write };
-
 can_exec(named_t, named_exec_t)
 allow named_t sbin_t:dir search;
 
diff -ru /tmp/policy/domains/program/postfix.te ./domains/program/postfix.te
--- /tmp/policy/domains/program/postfix.te	2002-10-17 00:01:12.000000000 +0200
+++ ./domains/program/postfix.te	2002-10-26 02:50:36.000000000 +0200
@@ -90,8 +90,6 @@
 create_dir_file(postfix_master_t, postfix_spool_flush_t)
 allow postfix_master_t random_device_t:chr_file { read getattr };
 allow postfix_master_t postfix_prng_t:file rw_file_perms;
-# should not need read, getattr does not matter
-allow postfix_master_t admin_tty_type:chr_file { getattr read write };
 
 # allow access to deferred queue
 allow postfix_master_t postfix_spool_t:dir create_dir_perms;
diff -ru /tmp/policy/domains/program/postgresql.te ./domains/program/postgresql.te
--- /tmp/policy/domains/program/postgresql.te	2002-10-23 21:38:18.000000000 +0200
+++ ./domains/program/postgresql.te	2002-10-26 02:48:23.000000000 +0200
@@ -11,9 +11,6 @@
 #
 daemon_domain(postgresql)
 
-# postgresql will not start (from an admin shell) without this!
-#allow postgresql_t admin_tty_type:chr_file { read write };
-
 ifdef(`dpkg.te', `
 # gross hack
 domain_auto_trans(dpkg_t, postgresql_exec_t, postgresql_t)
diff -ru /tmp/policy/domains/program/radvd.te ./domains/program/radvd.te
--- /tmp/policy/domains/program/radvd.te	2002-09-27 22:27:38.000000000 +0200
+++ ./domains/program/radvd.te	2002-10-26 02:50:40.000000000 +0200
@@ -14,8 +14,6 @@
 allow radvd_t self:{ rawip_socket unix_dgram_socket } rw_socket_perms;
 allow radvd_t self:{ rawip_socket } recvfrom;
 
-#allow radvd_t admin_tty_type:chr_file { read write };
-
 allow radvd_t self:capability { net_raw };
 allow radvd_t self:{ unix_dgram_socket rawip_socket } create;
 allow radvd_t self:unix_stream_socket create_socket_perms;
diff -ru /tmp/policy/domains/program/rlogind.te ./domains/program/rlogind.te
--- /tmp/policy/domains/program/rlogind.te	2002-10-17 00:01:13.000000000 +0200
+++ ./domains/program/rlogind.te	2002-10-26 02:41:09.000000000 +0200
@@ -45,7 +45,3 @@
 
 # Modify /var/log/wtmp.
 allow rlogind_t wtmp_t:file rw_file_perms;
-
-ifdef(`devfsd.te', `
-allow rlogind_t device_t:filesystem getattr;
-')
diff -ru /tmp/policy/domains/program/slapd.te ./domains/program/slapd.te
--- /tmp/policy/domains/program/slapd.te	2002-09-27 22:27:38.000000000 +0200
+++ ./domains/program/slapd.te	2002-10-26 02:48:28.000000000 +0200
@@ -18,9 +18,6 @@
 type slapd_db_t, file_type, sysadmfile;
 type slapd_replog_t, file_type, sysadmfile;
 
-# slapd will not start (from an admin shell) without this!
-#allow slapd_t admin_tty_type:chr_file { read write };
-
 tmp_domain(slapd)
 
 # Use the network.
diff -ru /tmp/policy/domains/program/ssh.te ./domains/program/ssh.te
--- /tmp/policy/domains/program/ssh.te	2002-10-23 21:38:19.000000000 +0200
+++ ./domains/program/ssh.te	2002-10-26 02:50:47.000000000 +0200
@@ -36,10 +36,6 @@
 # Determine the set of legal user SIDs that can be reached.
 allow $1 security_t:security get_user_sids;
 
-ifdef(`devfsd.te', `
-allow $1 device_t:filesystem getattr;
-')
-
 ')dnl end sshd_program_domain
 
 #################################
@@ -69,9 +65,6 @@
 # Inherit and use descriptors from init.
 allow sshd_t init_t:fd use;
 
-# for startup error messages
-#allow sshd_t admin_tty_type:chr_file { read write };
-
 # Can create ptys
 can_create_pty(sshd)
 
diff -ru /tmp/policy/domains/program/transproxy.te ./domains/program/transproxy.te
--- /tmp/policy/domains/program/transproxy.te	2002-09-27 22:27:39.000000000 +0200
+++ ./domains/program/transproxy.te	2002-10-26 02:50:56.000000000 +0200
@@ -16,7 +16,6 @@
 # Use the network.
 can_network(transproxy_t)
 allow transproxy_t transproxy_port_t:tcp_socket name_bind;
-#allow transproxy_t admin_tty_type:chr_file { read write };
 
 #allow transproxy_t self:fifo_file { read write };
 allow transproxy_t self:unix_stream_socket create_socket_perms;
diff -ru /tmp/policy/file_contexts/program/initrc.fc ./file_contexts/program/initrc.fc
--- /tmp/policy/file_contexts/program/initrc.fc	2002-09-21 05:01:29.000000000 +0200
+++ ./file_contexts/program/initrc.fc	2002-10-26 02:54:40.000000000 +0200
@@ -9,3 +9,4 @@
 # run_init
 /usr/local/selinux/sbin/run_init	system_u:object_r:run_init_exec_t
 /usr/sbin/run_init		system_u:object_r:run_init_exec_t
+/usr/sbin/open_init_pty		system_u:object_r:initrc_exec_t
diff -ru /tmp/policy/macros/global_macros.te ./macros/global_macros.te
--- /tmp/policy/macros/global_macros.te	2002-10-01 19:28:52.000000000 +0200
+++ ./macros/global_macros.te	2002-10-26 03:20:05.000000000 +0200
@@ -530,6 +530,11 @@
 
 # Read and write my pty files.
 allow $1_t $1_devpts_t:chr_file { setattr rw_file_perms };
+
+ifdef(`devfsd.te', `
+allow $1_t device_t:filesystem getattr;
+')
+
 ')
 
 
@@ -549,6 +554,11 @@
 
 # Read and write pty files.
 allow $1_t $2_devpts_t:chr_file { setattr rw_file_perms };
+
+ifdef(`devfsd.te', `
+allow $1_t device_t:filesystem getattr;
+')
+
 ')
 
 
@@ -930,6 +940,7 @@
 allow $1_t device_t:dir { getattr search };
 allow $1_t null_device_t:chr_file rw_file_perms;
 allow $1_t console_device_t:chr_file rw_file_perms;
+allow $1_t initrc_devpts_t:chr_file rw_file_perms;
 ')dnl
 
 define(`daemon_domain', `
diff -ru /tmp/policy/macros/user_macros.te ./macros/user_macros.te
--- /tmp/policy/macros/user_macros.te	2002-10-10 17:50:29.000000000 +0200
+++ ./macros/user_macros.te	2002-10-26 02:33:42.000000000 +0200
@@ -40,10 +40,6 @@
 # Bind to a Unix domain socket in /tmp.
 allow $1_t $1_tmp_t:unix_stream_socket name_bind;
 
-ifdef(`devfsd.te', `
-allow $1_t device_t:filesystem getattr;
-')
-
 # Type for tty devices.
 type $1_tty_device_t, file_type, sysadmfile, ttyfile;
 # Access ttys.

--------------Boundary-00=_F8FKA9MTK92L7PCXXNI0--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
