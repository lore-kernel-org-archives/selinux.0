Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7I6QP07012150
	for <selinux@tycho.nsa.gov>; Sat, 18 Aug 2007 02:26:25 -0400
Received: from moutng.kundenserver.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7I6QN3E016181
	for <selinux@tycho.nsa.gov>; Sat, 18 Aug 2007 06:26:23 GMT
Mime-Version: 1.0 (Apple Message framework v752.2)
To: "Christopher PeBenito J." <cpebenito@tresys.com>
Message-Id: <D7E6BD9F-1C0A-49F4-B95B-D311C691A90E@sf-net.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-2-805246358
Cc: SELinux List <selinux@tycho.nsa.gov>
Subject: [refpolicy] postfix changes
From: Stefan Schulze Frielinghaus <stefan@sf-net.com>
Date: Sat, 18 Aug 2007 08:26:00 +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail-2-805246358
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed

postfix needs chroot permissions and also read the  
postfix_master_file to work out of the box


--Apple-Mail-2-805246358
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=postfix.if.patch
Content-Disposition: attachment;
	filename=postfix.if.patch

--- /usr/src/refpolicy-20070629/policy/modules/services/postfix.if	2007-06-27 17:23:21.000000000 +0200
+++ policy/modules/services/postfix.if	2007-08-16 18:14:02.000000000 +0200
@@ -456,3 +456,11 @@
 
 	typeattribute $1 postfix_user_domtrans;
 ')
+
+interface(`postfix_read_master_file',`
+	gen_require(`
+		type postfix_master_t;
+	')
+
+	allow $1 postfix_master_t:file read;
+')

--Apple-Mail-2-805246358
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name=postfix.te.patch
Content-Disposition: attachment;
	filename=postfix.te.patch

--- /usr/src/refpolicy-20070629/policy/modules/services/postfix.te	2007-06-29 16:48:13.000000000 +0200
+++ policy/modules/services/postfix.te	2007-08-16 18:24:33.000000000 +0200
@@ -90,7 +90,7 @@
 #
 
 # chown is to set the correct ownership of queue dirs
-allow postfix_master_t self:capability { chown dac_override kill setgid setuid net_bind_service sys_tty_config };
+allow postfix_master_t self:capability { chown dac_override kill setgid setuid net_bind_service sys_chroot sys_tty_config };
 allow postfix_master_t self:fifo_file rw_fifo_file_perms;
 allow postfix_master_t self:tcp_socket create_stream_socket_perms;
 allow postfix_master_t self:udp_socket create_socket_perms;
@@ -170,6 +170,8 @@
 mta_rw_aliases(postfix_master_t)
 mta_read_sendmail_bin(postfix_master_t)
 
+postfix_read_master_file(postfix_local_t)
+
 ifdef(`targeted_policy',`
 	term_dontaudit_use_unallocated_ttys(postfix_master_t)
 	term_dontaudit_use_generic_ptys(postfix_master_t)
@@ -209,7 +211,7 @@
 # Postfix bounce local policy
 #
 
-allow postfix_bounce_t self:capability dac_read_search;
+allow postfix_bounce_t self:capability { dac_read_search sys_chroot };
 allow postfix_bounce_t self:tcp_socket create_socket_perms;
 
 allow postfix_bounce_t postfix_public_t:sock_file write;
@@ -223,11 +225,14 @@
 manage_files_pattern(postfix_bounce_t,postfix_spool_bounce_t,postfix_spool_bounce_t)
 manage_lnk_files_pattern(postfix_bounce_t,postfix_spool_bounce_t,postfix_spool_bounce_t)
 
+postfix_read_master_file(postfix_bounce_t)
+
 ########################################
 #
 # Postfix cleanup local policy
 #
 
+allow postfix_cleanup_t self:capability sys_chroot;
 allow postfix_cleanup_t self:process setrlimit;
 
 # connect to master process
@@ -244,6 +249,8 @@
 
 corecmd_exec_bin(postfix_cleanup_t)
 
+postfix_read_master_file(postfix_cleanup_t)
+
 ########################################
 #
 # Postfix local local policy
@@ -370,6 +377,7 @@
 # Postfix pickup local policy
 #
 
+allow postfix_pickup_t self:capability sys_chroot;
 allow postfix_pickup_t self:tcp_socket create_socket_perms;
 
 stream_connect_pattern(postfix_pickup_t,postfix_private_t,postfix_private_t,postfix_master_t)
@@ -383,6 +391,8 @@
 read_files_pattern(postfix_pickup_t,postfix_spool_maildrop_t,postfix_spool_maildrop_t)
 delete_files_pattern(postfix_pickup_t,postfix_spool_maildrop_t,postfix_spool_maildrop_t)
 
+postfix_read_master_file(postfix_pickup_t)
+
 ########################################
 #
 # Postfix pipe local policy
@@ -521,6 +531,7 @@
 # Postfix smtp delivery local policy
 #
 
+allow postfix_smtp_t self:capability sys_chroot;
 allow postfix_smtp_t self:netlink_route_socket r_netlink_socket_perms;
 
 # connect to master process
@@ -530,6 +541,8 @@
 
 allow postfix_smtp_t postfix_spool_t:file rw_file_perms;
 
+postfix_read_master_file(postfix_smtp_t)
+
 optional_policy(`
 	cyrus_stream_connect(postfix_smtp_t)
 ')

--Apple-Mail-2-805246358--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
