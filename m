From: william.c.roberts@intel.com
To: sds@tycho.nsa.gov, nnk@google.com, selinux@tycho.nsa.gov
Subject: [PATCH take2 v2] libsepol: fix checkpolicy dontaudit compiler bug
Date: Tue, 15 Nov 2016 13:06:24 -0800
Message-Id: <1479243984-17306-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

The combining logic for dontaudit rules was wrong, causing
a dontaudit A B:C *; rule to be clobbered by a dontaudit A B:C p;
rule.

This is a reimplimation of 6201bb5e2 that avoids the cumbersome
pointer assignments on alloced.

Reported-by: Nick Kralevich <nnk@google.com>
Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libsepol/src/expand.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 004a029..815d012 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1604,7 +1604,8 @@ static int expand_range_trans(expand_state_t * state,
 static avtab_ptr_t find_avtab_node(sepol_handle_t * handle,
 				   avtab_t * avtab, avtab_key_t * key,
 				   cond_av_list_t ** cond,
-				   av_extended_perms_t *xperms)
+				   av_extended_perms_t *xperms,
+				   uint32_t init_data)
 {
 	avtab_ptr_t node;
 	avtab_datum_t avdatum;
@@ -1640,6 +1641,7 @@ static avtab_ptr_t find_avtab_node(sepol_handle_t * handle,
 
 	if (!node) {
 		memset(&avdatum, 0, sizeof avdatum);
+		avdatum.data = init_data;
 		/* this is used to get the node - insertion is actually unique */
 		node = avtab_insert_nonunique(avtab, key, &avdatum);
 		if (!node) {
@@ -1663,6 +1665,17 @@ static avtab_ptr_t find_avtab_node(sepol_handle_t * handle,
 	return node;
 }
 
+static inline uint32_t specified_to_init_value(uint32_t specified)
+{
+	/*
+	 * Things that get &= start life with values as ~0 and get unset as
+	 * they continue life.
+	 * Things that are |=, start as 0.
+	 */
+	return (specified & AVRULE_DONTAUDIT)
+		|| (specified & AVRULE_AUDITDENY) ? ~0 : 0;
+}
+
 #define EXPAND_RULE_SUCCESS   1
 #define EXPAND_RULE_CONFLICT  0
 #define EXPAND_RULE_ERROR    -1
@@ -1750,7 +1763,8 @@ static int expand_terule_helper(sepol_handle_t * handle,
 			return EXPAND_RULE_CONFLICT;
 		}
 
-		node = find_avtab_node(handle, avtab, &avkey, cond, NULL);
+		node = find_avtab_node(handle, avtab, &avkey, cond, NULL,
+				       specified_to_init_value(specified));
 		if (!node)
 			return -1;
 		if (enabled) {
@@ -1824,7 +1838,9 @@ static int expand_avrule_helper(sepol_handle_t * handle,
 		avkey.target_class = cur->tclass;
 		avkey.specified = spec;
 
-		node = find_avtab_node(handle, avtab, &avkey, cond, extended_perms);
+		node = find_avtab_node(handle, avtab, &avkey, cond,
+				       extended_perms,
+				       specified_to_init_value(specified));
 		if (!node)
 			return EXPAND_RULE_ERROR;
 		if (enabled) {
@@ -1850,10 +1866,7 @@ static int expand_avrule_helper(sepol_handle_t * handle,
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
