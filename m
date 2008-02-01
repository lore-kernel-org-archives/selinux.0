Subject: [patch] libsemanage:  free base immediately after expand
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <method@manicmethod.com>,
        "Todd C. Miller" <tmiller@tresys.com>
Content-Type: text/plain
Date: Fri, 01 Feb 2008 09:11:06 -0500
Message-Id: <1201875066.4568.149.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Drop the base module immediately after expanding, so that the memory can
be reused for the remainder of the transaction.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 libsemanage/src/direct_api.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: trunk/libsemanage/src/direct_api.c
===================================================================
--- trunk/libsemanage/src/direct_api.c	(revision 2774)
+++ trunk/libsemanage/src/direct_api.c	(working copy)
@@ -642,6 +642,9 @@
 		retval = semanage_expand_sandbox(sh, base, &out);
 		if (retval < 0)
 			goto cleanup;
+	
+		sepol_module_package_free(base);
+		base = NULL;
 
 		dbase_policydb_attach((dbase_policydb_t *) pusers_base->dbase,
 				      out);
@@ -718,7 +721,6 @@
 	dbase_policydb_detach((dbase_policydb_t *) pbools->dbase);
 
 	free(mod_filenames);
-	sepol_module_package_free(base);
 	sepol_policydb_free(out);
 	semanage_release_trans_lock(sh);
 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
