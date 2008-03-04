Subject: [patch] libsepol:  drop unused buffer field from policy_file
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: "Todd C. Miller" <tmiller@tresys.com>,
        Joshua Brindle <method@manicmethod.com>
Content-Type: text/plain
Date: Tue, 04 Mar 2008 09:56:42 -0500
Message-Id: <1204642602.23738.101.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Remove the buffer array from struct policy_file; it is unused.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 libsepol/include/sepol/policydb/policydb.h |    1 -
 1 file changed, 1 deletion(-)

Index: trunk/libsepol/include/sepol/policydb/policydb.h
===================================================================
--- trunk/libsepol/include/sepol/policydb/policydb.h	(revision 2830)
+++ trunk/libsepol/include/sepol/policydb/policydb.h	(working copy)
@@ -561,7 +561,6 @@
 	size_t size;
 	FILE *fp;
 	struct sepol_handle *handle;
-	unsigned char buffer[BUFSIZ];
 } policy_file_t;
 
 struct sepol_policy_file {

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
