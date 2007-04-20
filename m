Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3KJUSEr027433
	for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2007 15:30:28 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3KJURxc011987
	for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2007 19:30:27 GMT
From: dwalsh@redhat.com
Date: Fri, 20 Apr 2007 15:30:19 -0400
Message-Id: <200704201930.l3KJUJMV027319@redsox.boston.devel.redhat.com>
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: kudzu fixes to allow it to edit and restart init for MLS
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


p--- nsaserefpolicy/policy/modules/admin/kudzu.te	2007-04-10 12:52:58.000000000 -0400
+++ serefpolicy-2.5.12/policy/modules/admin/kudzu.te	2007-04-11 17:07:34.000000000 -0400
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

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
