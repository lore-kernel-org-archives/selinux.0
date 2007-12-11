Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBBMKQSR022483
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 17:20:26 -0500
Received: from cadmus.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBBMKOEe011783
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 22:20:25 GMT
Received: from cadmus.columbia.tresys.com (localhost.localdomain [127.0.0.1])
	by cadmus.columbia.tresys.com (8.14.1/8.14.1) with ESMTP id lBBMKOwp018373
	for <selinux@tycho.nsa.gov>; Tue, 11 Dec 2007 17:20:24 -0500
Received: (from tmiller@localhost)
	by cadmus.columbia.tresys.com (8.14.1/8.14.1/Submit) id lBBMKOme018372
	for selinux@tycho.nsa.gov; Tue, 11 Dec 2007 17:20:24 -0500
Date: Tue, 11 Dec 2007 17:20:24 -0500
From: "Todd C. Miller" <tmiller@tresys.com>
Message-Id: <200712112220.lBBMKOme018372@cadmus.columbia.tresys.com>
To: selinux@tycho.nsa.gov
Subject: PATCH: libsepol should not write policy.18 with mls enabled
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Currently, libsepol will write a binary policy with the MLS flag set
even if the policy version is unable to support MLS.  For instance, you
can build a policy.18 with mls enabled.  The resulting policy binary is
invalid and can't be read by the kernel or the various tools.

Fixing this is just a matter of adding the appropriate check to
policydb_write().

Signed-off-by: Todd C. Miller <tmiller@tresys.com>

Index: libsepol/src/write.c
===================================================================
--- libsepol/src/write.c	(revision 2704)
+++ libsepol/src/write.c	(working copy)
@@ -1531,8 +1531,19 @@
 	pd.p = p;
 
 	config = 0;
-	if (p->mls)
+	if (p->mls) {
+		if ((p->policyvers < POLICYDB_VERSION_MLS &&
+		    p->policy_type == POLICY_KERN) ||
+		    (p->policyvers < MOD_POLICYDB_VERSION_MLS &&
+		    p->policy_type == POLICY_BASE) ||
+		    (p->policyvers < MOD_POLICYDB_VERSION_MLS &&
+		    p->policy_type == POLICY_MOD)) {
+			ERR(fp->handle, "policy version %d cannot support MLS",
+			    p->policyvers);
+			return POLICYDB_ERROR;
+		}
 		config |= POLICYDB_CONFIG_MLS;
+	}
 
 	config |= (POLICYDB_CONFIG_UNKNOWN_MASK & p->handle_unknown);
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
