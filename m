Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m18LSqDm010497
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2008 16:28:52 -0500
Received: from g1t0026.austin.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m18LSn5u019223
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2008 21:28:50 GMT
Received: from g1t0026.austin.hp.com (localhost.localdomain [127.0.0.1])
	by receive-from-antispam-filter (Postfix) with SMTP id 3C988C3C3
	for <selinux@tycho.nsa.gov>; Fri,  8 Feb 2008 21:28:26 +0000 (UTC)
Received: from smtp2.fc.hp.com (smtp2.fc.hp.com [15.11.136.114])
	by g1t0026.austin.hp.com (Postfix) with ESMTP id 2D521C1AB
	for <selinux@tycho.nsa.gov>; Fri,  8 Feb 2008 21:28:26 +0000 (UTC)
Message-Id: <20080208212822.224178508@hp.com>
References: <20080208212534.491651808@hp.com>
Date: Fri, 08 Feb 2008 16:25:35 -0500
From: paul.moore@hp.com
To: selinux@tycho.nsa.gov
Cc: Paul Moore <paul.moore@hp.com>
Subject: [PATCH 1/4] REFPOL: Add "rogue" Fedora packet class permissions
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

At some point in the Fedora 6 timeframe the "flow_in" and "flow_out"
permissions were added to the "packet" class, most likely as part of the
ill-fated secid-reconciliation effort.  Despite the fact that these permissions
are not currently used they should be included in the Reference Policy as they
are now a permanent fixture in Fedora and it is crucial that the FLASK
defines be kept in sync.

This patch needs to be applied before any other patches that affect the
"packet" class, otherwise the resulting policy may not load.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 policy/flask/access_vectors |    2 ++
 1 file changed, 2 insertions(+)

Index: refpolicy_svn_repo/policy/flask/access_vectors
===================================================================
--- refpolicy_svn_repo.orig/policy/flask/access_vectors
+++ refpolicy_svn_repo/policy/flask/access_vectors
@@ -650,6 +650,8 @@ class packet
 	send
 	recv
 	relabelto
+	flow_in		# not currently in use
+	flow_out	# not currently in use
 }
 
 class key

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
