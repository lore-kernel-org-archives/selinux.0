Subject: [patch] libsepol: clarify and reduce neverallow error reporting
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        Joshua Brindle <method@manicmethod.com>
Content-Type: text/plain
Date: Thu, 29 Nov 2007 09:52:17 -0500
Message-Id: <1196347937.24040.10.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Alter the error reporting for neverallow failures to be clearer, i.e.
use the word neverallow instead of assertion and don't report a line number
if we don't have that information, and bail on the first such error rather
than flooding the user with multiple ones, since any such error is fatal.

Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>

---

 libsepol/src/assertion.c |   47 ++++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

Index: trunk/libsepol/src/assertion.c
===================================================================
--- trunk/libsepol/src/assertion.c	(revision 2690)
+++ trunk/libsepol/src/assertion.c	(working copy)
@@ -59,11 +59,21 @@
 	return 0;
 
       err:
-	ERR(handle, "assertion on line %lu violated by allow %s %s:%s {%s };",
-	    line, p->p_type_val_to_name[stype], p->p_type_val_to_name[ttype],
-	    p->p_class_val_to_name[curperm->class - 1],
-	    sepol_av_to_string(p, curperm->class,
-			       node->datum.data & curperm->data));
+	if (line) {
+		ERR(handle, "neverallow on line %lu violated by allow %s %s:%s {%s };",
+		    line, p->p_type_val_to_name[stype], 
+		    p->p_type_val_to_name[ttype],
+		    p->p_class_val_to_name[curperm->class - 1],
+		    sepol_av_to_string(p, curperm->class,
+				       node->datum.data & curperm->data));
+	} else {
+		ERR(handle, "neverallow violated by allow %s %s:%s {%s };",
+		    p->p_type_val_to_name[stype], 
+		    p->p_type_val_to_name[ttype],
+		    p->p_class_val_to_name[curperm->class - 1],
+		    sepol_av_to_string(p, curperm->class,
+				       node->datum.data & curperm->data));
+	}
 	return -1;
 }
 
@@ -74,7 +84,7 @@
 	avtab_t te_avtab, te_cond_avtab;
 	ebitmap_node_t *snode, *tnode;
 	unsigned int i, j;
-	int errors = 0;
+	int rc;
 
 	if (!avrules) {
 		/* Since assertions are stored in avrules, if it is NULL
@@ -111,32 +121,31 @@
 			if (a->flags & RULE_SELF) {
 				if (check_assertion_helper
 				    (handle, p, &te_avtab, &te_cond_avtab, i, i,
-				     a->perms, a->line))
-					errors++;
+				     a->perms, a->line)) {
+					rc = -1;
+					goto out;
+				}
 			}
 			ebitmap_for_each_bit(ttypes, tnode, j) {
 				if (!ebitmap_node_get_bit(tnode, j))
 					continue;
 				if (check_assertion_helper
 				    (handle, p, &te_avtab, &te_cond_avtab, i, j,
-				     a->perms, a->line))
-					errors++;
+				     a->perms, a->line)) {
+					rc = -1;
+					goto out;
+				}
 			}
 		}
 	}
 
-	if (errors) {
-		ERR(handle, "%d assertion violations occured", errors);
-		avtab_destroy(&te_avtab);
-		avtab_destroy(&te_cond_avtab);
-		return -1;
-	}
-
+	rc = 0;
+out:
 	avtab_destroy(&te_avtab);
 	avtab_destroy(&te_cond_avtab);
-	return 0;
+	return rc;
 
       oom:
-	ERR(handle, "Out of memory - unable to check assertions");
+	ERR(handle, "Out of memory - unable to check neverallows");
 	return -1;
 }

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
