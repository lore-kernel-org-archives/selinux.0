Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72KYYH3024841
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:34:34 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KYXM1006672
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:34:33 GMT
Date: Thu, 2 Aug 2007 16:34:29 -0400
Message-Id: <200708022034.l72KYTej032378@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_spamassassin changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

More spool/run directories

--- nsaserefpolicy/policy/modules/services/spamassassin.fc	2007-06-11 16:05:30.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/spamassassin.fc	2007-08-02 11:02:02.000000000 -0400
@@ -10,3 +10,9 @@
 /var/lib/spamassassin(/.*)?	gen_context(system_u:object_r:spamd_var_lib_t,s0)
 
 /var/spool/spamassassin(/.*)?	gen_context(system_u:object_r:spamd_spool_t,s0)
+/var/spool/spamd(/.*)?	gen_context(system_u:object_r:spamd_spool_t,s0)
+
+/var/run/spamassassin(/.*)?	gen_context(system_u:object_r:spamd_var_run_t,s0)
+/var/run/spamass-milter(/.*)?	gen_context(system_u:object_r:spamd_var_run_t,s0)
+
+
--- nsaserefpolicy/policy/modules/services/spamassassin.te	2007-08-02 08:17:27.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/spamassassin.te	2007-08-02 11:02:02.000000000 -0400
@@ -83,8 +83,9 @@
 allow spamd_t spamd_var_lib_t:dir list_dir_perms;
 read_files_pattern(spamd_t,spamd_var_lib_t,spamd_var_lib_t)
 
+manage_dirs_pattern(spamd_t,spamd_var_run_t,spamd_var_run_t)
 manage_files_pattern(spamd_t,spamd_var_run_t,spamd_var_run_t)
-files_pid_filetrans(spamd_t,spamd_var_run_t,file)
+files_pid_filetrans(spamd_t,spamd_var_run_t,{ file dir })
 
 kernel_read_all_sysctls(spamd_t)
 kernel_read_system_state(spamd_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
