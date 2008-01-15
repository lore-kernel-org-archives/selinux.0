Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0FKvvgs012715
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2008 15:57:57 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m0FKvtJK004345
	for <selinux@tycho.nsa.gov>; Tue, 15 Jan 2008 20:57:55 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [PATCH] refpolicy: su needs ability to run unix_update
Date: Tue, 15 Jan 2008 15:57:54 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588016EEB0F@exchange.columbia.tresys.com>
From: "Brandon Whalen" <bwhalen@tresys.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On RHEL 5.1 systems su uses unix_update to help authenticate users.

--- /home/bwhalen/workspace/refpolicy-trunk/policy/modules/admin/su.if
(revision 2579)
+++ /home/bwhalen/workspace/refpolicy-trunk/policy/modules/admin/su.if
(working copy)
@@ -78,6 +78,10 @@
 	auth_dontaudit_read_shadow($1_su_t)
 	auth_use_nsswitch($1_su_t)
 	auth_rw_faillog($1_su_t)
+	#RHEL 5 uses unix_update for su
+	ifdef(`distro_redhat',`
+		auth_domtrans_upd_passwd($1_su_t)
+	')
 
 	domain_use_interactive_fds($1_su_t)
 
@@ -207,6 +211,10 @@
 	auth_dontaudit_read_shadow($1_su_t)
 	auth_use_nsswitch($1_su_t)
 	auth_rw_faillog($1_su_t)
+	#RHEL 5 uses unix_update for su
+	ifdef(`distro_redhat',`
+		auth_domtrans_upd_passwd($1_su_t)
+	')
 
 	corecmd_search_bin($1_su_t)





Brandon


Brandon Whalen        Tresys Technology
v: 443-539-0747       Suite 2100
f: 410-953-0494       8840 Stanford Blvd
bwhalen@tresys.com    Columbia, MD 21045



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
