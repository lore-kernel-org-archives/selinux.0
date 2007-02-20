Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1KGiRbO000919
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 11:44:27 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1KGjiQc016999
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 16:45:44 GMT
Message-ID: <45DB25B4.70201@redhat.com>
Date: Tue, 20 Feb 2007 11:45:40 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: IPTables needs to be able to talk to the terminal
Content-Type: multipart/mixed;
 boundary="------------010608020209070201090400"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010608020209070201090400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

service iptables status  needs to be able to work.

Policy changes

--------------010608020209070201090400
Content-Type: text/x-patch;
 name="nsaserefpolicy_policy_modules_system_iptables.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsaserefpolicy_policy_modules_system_iptables.patch"

--- nsaserefpolicy/policy/modules/system/iptables.te	2007-02-19 11:32:53.000000000 -0500
+++ serefpolicy-2.5.4/policy/modules/system/iptables.te	2007-02-19 16:08:20.000000000 -0500
@@ -51,7 +51,7 @@
 
 mls_file_read_up(iptables_t)
 
-term_dontaudit_use_console(iptables_t)
+term_use_console(iptables_t)
 
 domain_use_interactive_fds(iptables_t)
 
@@ -77,9 +77,11 @@
 userdom_use_all_users_fds(iptables_t)
 
 ifdef(`targeted_policy', `
-	term_dontaudit_use_unallocated_ttys(iptables_t)
-	term_dontaudit_use_generic_ptys(iptables_t)
+	term_use_unallocated_ttys(iptables_t)
+	term_use_generic_ptys(iptables_t)
+	term_use_all_user_ptys(iptables_t)
 	files_dontaudit_read_root_files(iptables_t)
+ 	unconfined_rw_pipes(iptables_t)
 ')
 
 optional_policy(`

--------------010608020209070201090400--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
