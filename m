Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHbwI2014588
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:37:58 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHbt2p008444
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:37:56 GMT
Date: Wed, 30 May 2007 11:29:13 -0400
Message-Id: <200705301529.l4UFTDb2010600@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: admin_kudzu changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

kudzu needs to sys_ptrace to setup init correctly
Remove unconfined_domain

--- nsaserefpolicy/policy/modules/admin/kudzu.te	2007-05-29 14:10:59.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/admin/kudzu.te	2007-05-30 09:25:53.000000000 -0400
@@ -21,8 +21,8 @@
 # Local policy
 #
 
-allow kudzu_t self:capability { dac_override sys_admin sys_rawio net_admin sys_tty_config mknod };
-dontaudit kudzu_t self:capability { sys_ptrace sys_tty_config };
+allow kudzu_t self:capability { dac_override sys_admin sys_ptrace sys_rawio net_admin sys_tty_config mknod };
+dontaudit kudzu_t self:capability sys_tty_config;
 allow kudzu_t self:process { signal_perms execmem };
 allow kudzu_t self:fifo_file rw_fifo_file_perms;
 allow kudzu_t self:unix_stream_socket { connectto create_stream_socket_perms };
@@ -103,6 +103,8 @@
 init_use_fds(kudzu_t)
 init_use_script_ptys(kudzu_t)
 init_stream_connect_script(kudzu_t)
+init_read_init_state(kudzu_t)
+init_ptrace_init_domain(kudzu_t)
 # kudzu will telinit to make init re-read
 # the inittab after configuring serial consoles
 init_telinit(kudzu_t)
@@ -141,15 +143,6 @@
         udev_read_db(kudzu_t)
 ')
 
-optional_policy(`
-	# cjp: this was originally in the else block
-	# of ifdef userhelper.te, but it seems to
-	# make more sense here.  also, require
-	# blocks curently do not work in the
-	# else block of optionals
-	unconfined_domain(kudzu_t)
-')
-
 ifdef(`TODO',`
 allow kudzu_t modules_conf_t:file unlink;
 optional_policy(`

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
