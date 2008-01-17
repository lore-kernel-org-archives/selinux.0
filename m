Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0HHPCM2026291
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2008 12:25:12 -0500
Received: from g1t0026.austin.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0HHPATY011575
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2008 17:25:11 GMT
Received: from g1t0026.austin.hp.com (localhost.localdomain [127.0.0.1])
	by receive-from-antispam-filter (Postfix) with SMTP id 82840C39E
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2008 17:25:10 +0000 (UTC)
Received: from smtp1.fc.hp.com (smtp1.fc.hp.com [15.15.136.127])
	by g1t0026.austin.hp.com (Postfix) with ESMTP id 7565AC309
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2008 17:25:10 +0000 (UTC)
Message-Id: <20080117172246.341834342@hp.com>
Date: Thu, 17 Jan 2008 12:22:42 -0500
From: Paul Moore <paul.moore@hp.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] REFPOL: Add "rogue" Fedora packet class permissions
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
@@ -644,6 +644,8 @@ class packet
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
