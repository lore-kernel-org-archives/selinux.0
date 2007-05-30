Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHamGv013609
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:48 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHakue002786
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:47 GMT
Date: Wed, 30 May 2007 11:31:06 -0400
Message-Id: <200705301531.l4UFV60b010640@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: admin_amanda changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Amanda fixes

--- nsaserefpolicy/policy/modules/admin/amanda.te	2007-05-29 14:10:59.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/admin/amanda.te	2007-05-30 09:25:53.000000000 -0400
@@ -70,7 +70,7 @@
 
 allow amanda_t self:capability { chown dac_override setuid kill };
 allow amanda_t self:process { setpgid signal };
-allow amanda_t self:fifo_file { getattr read write ioctl lock };
+allow amanda_t self:fifo_file rw_fifo_file_perms;
 allow amanda_t self:unix_stream_socket create_stream_socket_perms;
 allow amanda_t self:unix_dgram_socket create_socket_perms;
 allow amanda_t self:tcp_socket create_stream_socket_perms;
@@ -85,18 +85,22 @@
 
 # access to amandas data structure
 allow amanda_t amanda_data_t:dir { read search write };
-allow amanda_t amanda_data_t:file { read write };
+allow amanda_t amanda_data_t:file manage_file_perms;
 
 # access to amanda_dumpdates_t
 allow amanda_t amanda_dumpdates_t:file { getattr lock read write };
 
 can_exec(amanda_t,amanda_exec_t)
+can_exec(amanda_t,amanda_inetd_exec_t)
 
 # access to amanda_gnutarlists_t (/var/lib/amanda/gnutar-lists)
 allow amanda_t amanda_gnutarlists_t:dir rw_dir_perms;
 allow amanda_t amanda_gnutarlists_t:file manage_file_perms;
 allow amanda_t amanda_gnutarlists_t:lnk_file manage_file_perms;
 
+manage_dirs_pattern(amanda_t,amanda_var_lib_t,amanda_var_lib_t)
+manage_files_pattern(amanda_t,amanda_var_lib_t,amanda_var_lib_t)
+
 manage_files_pattern(amanda_t,amanda_log_t,amanda_log_t)
 manage_dirs_pattern(amanda_t,amanda_log_t,amanda_log_t)
 logging_log_filetrans(amanda_t,amanda_log_t,{ file dir })

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
