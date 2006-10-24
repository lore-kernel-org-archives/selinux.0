Message-ID: <453E26D2.6050903@trustedcs.com>
Date: Tue, 24 Oct 2006 09:44:34 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
Subject: [PATCH] libsepol: fix version comparison when writing policies
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Fix a version comparison that prohibits the "old style" range transition
rules from being written for a version 5 base policy.

---

diff -ruNp --exclude=.svn selinux-base/libsepol/src/write.c selinux/libsepol/src/write.c
--- selinux-base/libsepol/src/write.c	2006-10-24 09:35:46.000000000 -0500
+++ selinux/libsepol/src/write.c	2006-10-24 09:35:13.000000000 -0500
@@ -1641,7 +1641,7 @@ int policydb_write(policydb_t * p, struc
 	if ((p->policyvers >= POLICYDB_VERSION_MLS
 	     && p->policy_type == POLICY_KERN)
 	    || (p->policyvers >= MOD_POLICYDB_VERSION_MLS
-		&& p->policyvers < MOD_POLICYDB_VERSION_MLS
+		&& p->policyvers < MOD_POLICYDB_VERSION_RANGETRANS
 		&& p->policy_type == POLICY_BASE)) {
 		if (range_write(p, fp)) {
 			return POLICYDB_ERROR;
-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
