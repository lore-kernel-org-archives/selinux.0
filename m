Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3KJSL0H027292
	for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2007 15:28:21 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3KJSKxc011560
	for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2007 19:28:20 GMT
From: dwalsh@redhat.com
Date: Fri, 20 Apr 2007 15:28:12 -0400
Message-Id: <200704201928.l3KJSCXC027282@redsox.boston.devel.redhat.com>
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: aide has a new directory
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/aide.fc	2006-11-16 17:15:21.000000000 -0500
+++ serefpolicy-2.5.12/policy/modules/services/aide.fc	2007-04-18 22:31:58.000000000 -0400
@@ -3,3 +3,4 @@
 /var/lib/aide(/.*)		gen_context(system_u:object_r:aide_db_t,mls_systemhigh)
 
 /var/log/aide.log	--	gen_context(system_u:object_r:aide_log_t,mls_systemhigh)
+/var/log/aide(/.*)?		gen_context(system_u:object_r:aide_log_t,mls_systemhigh)
--- nsaserefpolicy/policy/modules/services/aide.te	2007-01-02 12:57:43.000000000 -0500
+++ serefpolicy-2.5.12/policy/modules/services/aide.te	2007-04-18 22:31:08.000000000 -0400
@@ -32,7 +32,7 @@
 manage_files_pattern(aide_t,aide_db_t,aide_db_t)
 
 # logs
-allow aide_t aide_log_t:file manage_file_perms;
+manage_files_pattern(aide_t, aide_log_t, aide_log_t)
 logging_log_filetrans(aide_t,aide_log_t,file)
 
 files_read_all_files(aide_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
