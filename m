From: william.c.roberts@intel.com
To: sds@tycho.nsa.gov, nnk@google.com, selinux@tycho.nsa.gov
Subject: [PATCH take2 v3] libsepol: fix checkpolicy dontaudit compiler bug
Date: Tue, 15 Nov 2016 13:29:05 -0800
Message-Id: <1479245345-18119-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

The combining logic for dontaudit rules was wrong, causing
a dontaudit A B:C *; rule to be clobbered by a dontaudit A B:C p;
rule.

This is a reimplementation of 6201bb5e2 that avoids the cumbersome
pointer assignments on alloced.

Reported-by: Nick Kralevich <nnk@google.com>
Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libsepol/src/expand.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 004a029..5a04c25 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1604,7 +1604,8 @@ static int expand_range_trans(expand_state_t * state,
 static avtab_ptr_t find_avtab_node(sepol_handle_t * handle,
 				   avtab_t * avtab, avtab_key_t * key,
 				   cond_av_list_t ** cond,
-				   av_extended_perms_t *xperms)
+				   av_extended_perms_t *xperms,
+				   uint32_t specified)
 {
 	avtab_ptr_t node;
 	avtab_datum_t avdatum;
@@ -1640,6 +1641,11 @@ static avtab_ptr_t find_avtab_node(sepol_handle_t * handle,
 
 	if (!node) {
 		memset(&avdatum, 0, sizeof avdatum);
+		/*
+		 * AUDITDENY, aka DONTAUDIT, is &= assigned, versus != for others.
+		 * Initialize data accordingly.
+		 */
+		avdatum.data = (specified == AVRULE_AUDITDENY) ? ~0 : 0;
 		/* this is used to get the node - insertion is actually unique */
 		node = avtab_insert_nonunique(avtab, key, &avdatum);
 		if (!node) {
@@ -1750,7 +1756,7 @@ static int expand_terule_helper(sepol_handle_t * handle,
 			return EXPAND_RULE_CONFLICT;
 		}
 
-		node = find_avtab_node(handle, avtab, &avkey, cond, NULL);
+		node = find_avtab_node(handle, avtab, &avkey, cond, NULL, 0);
 		if (!node)
 			return -1;
 		if (enabled) {
@@ -1824,7 +1830,8 @@ static int expand_avrule_helper(sepol_handle_t * handle,
 		avkey.target_class = cur->tclass;
 		avkey.specified = spec;
 
-		node = find_avtab_node(handle, avtab, &avkey, cond, extended_perms);
+		node = find_avtab_node(handle, avtab, &avkey, cond,
+				       extended_perms, specified);
 		if (!node)
 			return EXPAND_RULE_ERROR;
 		if (enabled) {
@@ -1850,10 +1857,7 @@ static int expand_avrule_helper(sepol_handle_t * handle,
 			 */
 			avdatump->data &= cur->data;
 		} else if (specified & AVRULE_DONTAUDIT) {
-			if (avdatump->data)
-				avdatump->data &= ~cur->data;
-			else
-				avdatump->data = ~cur->data;
+			avdatump->data &= ~cur->data;
 		} else if (specified & AVRULE_XPERMS) {
 			xperms = avdatump->xperms;
 			if (!xperms) {
-- 
2.7.4
