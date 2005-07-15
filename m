Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6FFpKgA012222
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 11:51:20 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6FFl0Bp007779
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 15:47:00 GMT
Received: from twoface.columbia.tresys.com (twoface.columbia.tresys.com [10.1.13.32])
	by gotham.columbia.tresys.com (8.12.8/8.12.8) with ESMTP id j6FFljvv025140
	for <selinux@tycho.nsa.gov>; Fri, 15 Jul 2005 11:47:45 -0400
Subject: [PATCH] fix hierarchy checking location
From: Joshua Brindle <jbrindle@tresys.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 11:47:51 -0400
Message-Id: <1121442472.28368.16.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch puts the hierarchy check in the right place (currently it's before the policy expand)

--- nsa/selinux-usr/checkpolicy/checkpolicy.c   2005-07-13 15:14:25.326064968 -0400
+++ policy-modules/trunk/checkpolicy/checkpolicy.c      2005-07-15 09:49:30.260465152 -0400
@@ -564,11 +564,6 @@ int main(int argc, char **argv)
                        exit(1);
                }

-               if (hierarchy_check_constraints(&parse_policy, error_msg, sizeof(error_msg))) {
-                       fprintf(stderr, "%s\n", error_msg);
-                       exit(1);
-               }
-
                if (policydb_init(&policydb, POLICY_KERN)) {
                        exit(1);
                 }
@@ -583,6 +578,11 @@ int main(int argc, char **argv)
                 }
                policydbp = &policydb;

+               if (hierarchy_check_constraints(policydbp, error_msg, sizeof(error_msg))) {
+                       fprintf(stderr, "%s\n", error_msg);
+                       exit(1);
+               }
+
                if (check_assertions(policydbp,
                                      policydbp->global->branch_list->avrules,
                                      &policydbp->te_avtab) ||



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
