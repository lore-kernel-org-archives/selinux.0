Message-ID: <4615339A.1060700@tycho.nsa.gov>
Date: Thu, 05 Apr 2007 13:36:26 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux: grant permissions on deny in permissive mode
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch duplicates the kernel behavior of granting permissions
after a denial to avoid repeated AVC's.

It required moving the avc_update_node static inline function further
up in the file and changing its prototype.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>

---
 avc.c |   65 ++++++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 34 insertions(+), 31 deletions(-)

Index: libselinux/src/avc.c
===================================================================
--- libselinux/src/avc.c	(revision 2318)
+++ libselinux/src/avc.c	(working copy)
@@ -203,6 +203,32 @@
 	    & (AVC_CACHE_SLOTS - 1);
 }
 
+static inline void avc_update_node(uint32_t event, struct avc_entry *ae,
+				   access_vector_t perms)
+{
+	switch (event) {
+	case AVC_CALLBACK_GRANT:
+		ae->avd.allowed |= perms;
+		break;
+	case AVC_CALLBACK_TRY_REVOKE:
+	case AVC_CALLBACK_REVOKE:
+		ae->avd.allowed &= ~perms;
+		break;
+	case AVC_CALLBACK_AUDITALLOW_ENABLE:
+		ae->avd.auditallow |= perms;
+		break;
+	case AVC_CALLBACK_AUDITALLOW_DISABLE:
+		ae->avd.auditallow &= ~perms;
+		break;
+	case AVC_CALLBACK_AUDITDENY_ENABLE:
+		ae->avd.auditdeny |= perms;
+		break;
+	case AVC_CALLBACK_AUDITDENY_DISABLE:
+		ae->avd.auditdeny &= ~perms;
+		break;
+	}
+}
+
 int avc_context_to_sid_raw(security_context_t ctx, security_id_t * sid)
 {
 	int rc;
@@ -982,9 +1008,12 @@
 
 	denied = requested & ~(ae->avd.allowed);
 
-	if ((!requested || denied) && avc_enforcing) {
-		errno = EACCES;
-		rc = -1;
+	if (!requested || denied) {
+		if (avc_enforcing) {
+			errno = EACCES;
+			rc = -1;
+		} else
+			avc_update_node(AVC_CALLBACK_GRANT, ae, requested);
 	}
 
       out:
@@ -1066,32 +1095,6 @@
 	return (x == y || x == SECSID_WILD || y == SECSID_WILD);
 }
 
-static inline void avc_update_node(uint32_t event, struct avc_node *node,
-				   access_vector_t perms)
-{
-	switch (event) {
-	case AVC_CALLBACK_GRANT:
-		node->ae.avd.allowed |= perms;
-		break;
-	case AVC_CALLBACK_TRY_REVOKE:
-	case AVC_CALLBACK_REVOKE:
-		node->ae.avd.allowed &= ~perms;
-		break;
-	case AVC_CALLBACK_AUDITALLOW_ENABLE:
-		node->ae.avd.auditallow |= perms;
-		break;
-	case AVC_CALLBACK_AUDITALLOW_DISABLE:
-		node->ae.avd.auditallow &= ~perms;
-		break;
-	case AVC_CALLBACK_AUDITDENY_ENABLE:
-		node->ae.avd.auditdeny |= perms;
-		break;
-	case AVC_CALLBACK_AUDITDENY_DISABLE:
-		node->ae.avd.auditdeny &= ~perms;
-		break;
-	}
-}
-
 static int avc_update_cache(uint32_t event, security_id_t ssid,
 			    security_id_t tsid, security_class_t tclass,
 			    access_vector_t perms)
@@ -1108,7 +1111,7 @@
 				if (avc_sidcmp(ssid, node->ae.ssid) &&
 				    avc_sidcmp(tsid, node->ae.tsid) &&
 				    tclass == node->ae.tclass) {
-					avc_update_node(event, node, perms);
+					avc_update_node(event, &node->ae, perms);
 				}
 			}
 		}
@@ -1116,7 +1119,7 @@
 		/* apply to one node */
 		node = avc_search_node(ssid, tsid, tclass, 0);
 		if (node) {
-			avc_update_node(event, node, perms);
+			avc_update_node(event, &node->ae, perms);
 		}
 	}
 


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
