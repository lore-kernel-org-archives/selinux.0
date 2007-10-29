Subject: [PATCH] refpolicy: Fix range_transition rules in the
	init_ranged_system_domain interface in system/init.if
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 29 Oct 2007 13:21:52 -0400
Message-Id: <1193678512.2796.14.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The interface init_ranged_system_domain is not currently used, so maybe it can be just deleted.

Index: policy/modules/system/init.if
===================================================================
--- policy/modules/system/init.if	(revision 2474)
+++ policy/modules/system/init.if	(working copy)
@@ -242,11 +242,11 @@
 	init_system_domain($1,$2)
 
 	ifdef(`enable_mcs',`
-		range_transition initrc_t $2 $3;
+		range_transition initrc_t $2:process $3;
 	')
 
 	ifdef(`enable_mls',`
-		range_transition initrc_t $2 $3;
+		range_transition initrc_t $2:process $3;
 	')
 ')
 

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
