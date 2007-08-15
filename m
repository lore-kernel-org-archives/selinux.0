Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7FEFhq1009901
	for <selinux@tycho.nsa.gov>; Wed, 15 Aug 2007 10:15:43 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7FEFerX005063
	for <selinux@tycho.nsa.gov>; Wed, 15 Aug 2007 14:15:40 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l7FEFYhp013046
	for <selinux@tycho.nsa.gov>; Wed, 15 Aug 2007 10:15:34 -0400
Received: from pobox-2.corp.redhat.com (pobox-2.corp.redhat.com [10.11.255.15])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l7FEFY7x009413
	for <selinux@tycho.nsa.gov>; Wed, 15 Aug 2007 10:15:34 -0400
Received: from localhost.localdomain (vpn-15-14.rdu.redhat.com [10.11.15.14])
	by pobox-2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l7FEFY6c021736
	for <selinux@tycho.nsa.gov>; Wed, 15 Aug 2007 10:15:34 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH] Suppress rule generation for dontaudit rules
Message-Id: <2ad2d21fc72476558d8f.1187187301@localhost.localdomain>
Date: Wed, 15 Aug 2007 10:15:01 -0400
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The current policy generation code incorrectly generates allow rules for dontaudit messages. This patch fixes that.

Signed-off-by: User "Karl MacMillan <kmacmillan@mentalrootkit.com>"
---

diff -r 56dbe9166d98 -r 2ad2d21fc724 sepolgen/src/sepolgen/policygen.py
--- a/sepolgen/src/sepolgen/policygen.py	Thu Jun 07 08:08:31 2007 -0400
+++ b/sepolgen/src/sepolgen/policygen.py	Wed Aug 15 10:13:28 2007 -0400
@@ -139,6 +139,8 @@ class PolicyGenerator:
 
     def __add_allow_rules(self, avs):
         for av in avs:
+            if not av.denial:
+                continue
             rule = refpolicy.AVRule(av)
             if self.explain:
                 rule.comment = refpolicy.Comment(explain_access(av, verbosity=self.explain))

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
