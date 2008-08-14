Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7ECoYo6014594
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 08:50:34 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7ECoYqV018166
	for <selinux@tycho.nsa.gov>; Thu, 14 Aug 2008 12:50:34 GMT
Message-ID: <48A42A16.1070209@redhat.com>
Date: Thu, 14 Aug 2008 08:50:30 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: postgresql patch
Content-Type: multipart/mixed;
 boundary="------------030804070000090805070407"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030804070000090805070407
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

New location for log files

Uses hugetblfs.

--------------030804070000090805070407
Content-Type: text/plain;
 name="services_postgresql.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="services_postgresql.patch"

--- nsaserefpolicy/policy/modules/services/postgresql.fc	2008-08-07 11:15:11.000000000 -0400
+++ serefpolicy-3.5.4/policy/modules/services/postgresql.fc	2008-08-11 16:39:48.000000000 -0400
@@ -34,6 +34,7 @@
 /var/lib/sepgsql/pgstartup\.log	--	gen_context(system_u:object_r:postgresql_log_t,s0)
 
 /var/log/postgres\.log.* 	--	gen_context(system_u:object_r:postgresql_log_t,s0)
+/var/lib/pgsql/logfile(/.*)?		gen_context(system_u:object_r:postgresql_log_t,s0)
 /var/log/postgresql(/.*)?		gen_context(system_u:object_r:postgresql_log_t,s0)
 /var/log/sepostgresql\.log.*	--	gen_context(system_u:object_r:postgresql_log_t,s0)
 
--- nsaserefpolicy/policy/modules/services/postgresql.te	2008-08-07 11:15:11.000000000 -0400
+++ serefpolicy-3.5.4/policy/modules/services/postgresql.te	2008-08-11 16:39:48.000000000 -0400
@@ -186,6 +189,7 @@
 
 fs_getattr_all_fs(postgresql_t)
 fs_search_auto_mountpoints(postgresql_t)
+fs_rw_hugetlbfs_files(postgresql_t)
 
 selinux_get_enforce_mode(postgresql_t)
 selinux_validate_context(postgresql_t)

--------------030804070000090805070407--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
