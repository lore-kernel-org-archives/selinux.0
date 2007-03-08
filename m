Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l28Ekqx2004815
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 09:46:52 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l28EkoHa007332
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 14:46:51 GMT
Message-ID: <45F021D7.4060401@redhat.com>
Date: Thu, 08 Mar 2007 09:46:47 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: system-config-service of iptables needs this patch to work in targeted
 policy
Content-Type: multipart/mixed;
 boundary="------------020800030305040608010700"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020800030305040608010700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Basically iptables needs to be able to output to the terminal and talk 
to unconfined_pipes from the tool.

--------------020800030305040608010700
Content-Type: text/x-patch;
 name="nsaserefpolicy_policy_modules_system_iptables.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsaserefpolicy_policy_modules_system_iptables.patch"

--- nsaserefpolicy/policy/modules/system/iptables.te	2007-02-19 11:32:53.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/system/iptables.te	2007-03-08 08:42:37.000000000 -0500
@@ -77,9 +77,10 @@
 userdom_use_all_users_fds(iptables_t)
 
 ifdef(`targeted_policy', `
-	term_dontaudit_use_unallocated_ttys(iptables_t)
-	term_dontaudit_use_generic_ptys(iptables_t)
+	term_use_unallocated_ttys(iptables_t)
+	term_use_generic_ptys(iptables_t)
 	files_dontaudit_read_root_files(iptables_t)
+ 	unconfined_rw_pipes(iptables_t)
 ')
 
 optional_policy(`
@@ -111,3 +112,7 @@
 optional_policy(`
 	udev_read_db(iptables_t)
 ')
+
+optional_policy(`
+	fail2ban_append_log(iptables_t)
+')

--------------020800030305040608010700--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
