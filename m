From: william.c.roberts@intel.com
To: sds@tycho.nsa.gov, nnk@google.com, selinux@tycho.nsa.gov
Subject: [PATCH 1/2] Revert "libsepol: fix checkpolicy dontaudit compiler bug"
Date: Tue, 15 Nov 2016 11:40:00 -0800
Message-Id: <1479238801-13053-2-git-send-email-william.c.roberts@intel.com>
In-Reply-To: <1479238801-13053-1-git-send-email-william.c.roberts@intel.com>
References: <[PATCH] libsepol: fix checkpolicy dontaudit compiler bug>
 <1479238801-13053-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

This reverts commit 6201bb5e258e2b5bcc04d502d6fbc05c69d21d71.
---
 libsepol/src/expand.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index d7adbf8..004a029 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1604,8 +1604,7 @@ static int expand_range_trans(expand_state_t * state,
 static avtab_ptr_t find_avtab_node(sepol_handle_t * handle,
 				   avtab_t * avtab, avtab_key_t * key,
 				   cond_av_list_t ** cond,
-				   av_extended_perms_t *xperms,
-				   char *alloced)
+				   av_extended_perms_t *xperms)
 {
 	avtab_ptr_t node;
 	avtab_datum_t avdatum;
@@ -1659,11 +1658,6 @@ static avtab_ptr_t find_avtab_node(sepol_handle_t * handle,
 			nl->next = *cond;
 			*cond = nl;
 		}
-		if (alloced)
-			*alloced = 1;
-	} else {
-		if (alloced)
-			*alloced = 0;
 	}
 
 	return node;
@@ -1756,7 +1750,7 @@ static int expand_terule_helper(sepol_handle_t * handle,
 			return EXPAND_RULE_CONFLICT;
 		}
 
-		node = find_avtab_node(handle, avtab, &avkey, cond, NULL, NULL);
+		node = find_avtab_node(handle, avtab, &avkey, cond, NULL);
 		if (!node)
 			return -1;
 		if (enabled) {
@@ -1796,7 +1790,6 @@ static int expand_avrule_helper(sepol_handle_t * handle,
 	class_perm_node_t *cur;
 	uint32_t spec = 0;
 	unsigned int i;
-	char alloced;
 
 	if (specified & AVRULE_ALLOWED) {
 		spec = AVTAB_ALLOWED;
@@ -1831,8 +1824,7 @@ static int expand_avrule_helper(sepol_handle_t * handle,
 		avkey.target_class = cur->tclass;
 		avkey.specified = spec;
 
-		node = find_avtab_node(handle, avtab, &avkey, cond,
-				       extended_perms, &alloced);
+		node = find_avtab_node(handle, avtab, &avkey, cond, extended_perms);
 		if (!node)
 			return EXPAND_RULE_ERROR;
 		if (enabled) {
@@ -1858,7 +1850,7 @@ static int expand_avrule_helper(sepol_handle_t * handle,
 			 */
 			avdatump->data &= cur->data;
 		} else if (specified & AVRULE_DONTAUDIT) {
-			if (!alloced)
+			if (avdatump->data)
 				avdatump->data &= ~cur->data;
 			else
 				avdatump->data = ~cur->data;
-- 
2.7.4
