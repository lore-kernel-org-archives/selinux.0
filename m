Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m18LSq1g010495
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2008 16:28:52 -0500
Received: from g1t0029.austin.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m18LSn5u019222
	for <selinux@tycho.nsa.gov>; Fri, 8 Feb 2008 21:28:50 GMT
Received: from g1t0029.austin.hp.com (localhost.localdomain [127.0.0.1])
	by receive-from-antispam-filter (Postfix) with SMTP id 412E6384EB
	for <selinux@tycho.nsa.gov>; Fri,  8 Feb 2008 21:28:26 +0000 (UTC)
Received: from smtp1.fc.hp.com (smtp.fc.hp.com [15.15.136.127])
	by g1t0029.austin.hp.com (Postfix) with ESMTP id 348FD380CA
	for <selinux@tycho.nsa.gov>; Fri,  8 Feb 2008 21:28:26 +0000 (UTC)
Message-Id: <20080208212823.557882665@hp.com>
References: <20080208212534.491651808@hp.com>
Date: Fri, 08 Feb 2008 16:25:36 -0500
From: paul.moore@hp.com
To: selinux@tycho.nsa.gov
Cc: Paul Moore <paul.moore@hp.com>
Subject: [PATCH 2/4] REFPOL: Add forwarding permissions to the packet object class
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add the 'forward_in' and 'forward_out' permissions to the packet object class
to support the new forwarding controls added to the 2.6.25 kernel.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 policy/flask/access_vectors |    2 ++
 1 file changed, 2 insertions(+)

Index: refpolicy_svn_repo/policy/flask/access_vectors
===================================================================
--- refpolicy_svn_repo.orig/policy/flask/access_vectors
+++ refpolicy_svn_repo/policy/flask/access_vectors
@@ -652,6 +652,8 @@ class packet
 	relabelto
 	flow_in		# not currently in use
 	flow_out	# not currently in use
+	forward_in
+	forward_out
 }
 
 class key

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
