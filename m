Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHajVM013482
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:45 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHai2p008175
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:44 GMT
Date: Wed, 30 May 2007 11:40:22 -0400
Message-Id: <200705301540.l4UFeMx8011828@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: kernel_corecommands changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Additional bin_t files

--- nsaserefpolicy/policy/modules/kernel/corecommands.fc	2007-05-29 14:10:48.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/kernel/corecommands.fc	2007-05-30 09:25:53.000000000 -0400
@@ -36,6 +36,11 @@
 /etc/cipe/ip-up.*		--	gen_context(system_u:object_r:bin_t,s0)
 /etc/cipe/ip-down.*		--	gen_context(system_u:object_r:bin_t,s0)
 
+/etc/cron.daily/.*		--	gen_context(system_u:object_r:bin_t,s0)
+/etc/cron.hourly/.*		--	gen_context(system_u:object_r:bin_t,s0)
+/etc/cron.weekly/.*		--	gen_context(system_u:object_r:bin_t,s0)
+/etc/cron.monthly/.*		--	gen_context(system_u:object_r:bin_t,s0)
+
 /etc/hotplug/.*agent		--	gen_context(system_u:object_r:bin_t,s0)
 /etc/hotplug/.*rc		-- 	gen_context(system_u:object_r:bin_t,s0)
 /etc/hotplug/hotplug\.functions --	gen_context(system_u:object_r:bin_t,s0)
@@ -244,6 +253,7 @@
 /var/ftp/bin(/.*)?			gen_context(system_u:object_r:bin_t,s0)
 
 /usr/lib/yp/.+			--	gen_context(system_u:object_r:bin_t,s0)
+/usr/lib64/yp/.+		--	gen_context(system_u:object_r:bin_t,s0)
 
 /var/qmail/bin                  -d      gen_context(system_u:object_r:bin_t,s0)
 /var/qmail/bin(/.*)?                    gen_context(system_u:object_r:bin_t,s0)
@@ -252,3 +262,5 @@
 ifdef(`distro_suse',`
 /var/lib/samba/bin/.+			gen_context(system_u:object_r:bin_t,s0)
 ')
+/usr/lib/vmware-tools/sbin32(/.*)?      gen_context(system_u:object_r:bin_t,s0)
+
--- nsaserefpolicy/policy/modules/kernel/corecommands.if	2007-05-29 14:10:48.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/kernel/corecommands.if	2007-05-30 09:25:53.000000000 -0400
@@ -980,3 +980,23 @@
 
 	mmap_files_pattern($1,bin_t,exec_type)
 ')
+
+########################################
+## <summary>
+##	dontaudit checking for execute privs on all executables
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`corecmd_dontaudit_exec_all_executables',`
+	gen_require(`
+		attribute exec_type;
+	')
+
+	dontaudit $1 exec_type:file execute;
+')
+
+

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
