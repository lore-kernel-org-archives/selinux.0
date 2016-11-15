From: william.c.roberts@intel.com
To: sds@tycho.nsa.gov, nnk@google.com, selinux@tycho.nsa.gov
Subject: [PATCH take2 v5] libsepol: fix checkpolicy dontaudit compiler bug
Date: Tue, 15 Nov 2016 15:30:22 -0800
Message-Id: <1479252622-20935-1-git-send-email-william.c.roberts@intel.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: William Roberts <william.c.roberts@intel.com>

The combining logic for dontaudit rules was wrong, causing
a dontaudit A B:C *; rule to be clobbered by a dontaudit A B:C p;
rule.

This is a reimplementation of:
commit 6201bb5e258e2b5bcc04d502d6fbc05c69d21d71 ("libsepol:
fix checkpolicy dontaudit compiler bug")
that avoids the cumbersome pointer assignments on alloced.

Reported-by: Nick Kralevich <nnk@google.com>
Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libsepol/src/expand.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 004a029..17d2a2a 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1640,6 +1640,12 @@ static avtab_ptr_t find_avtab_node(sepol_handle_t * handle,
 
 	if (!node) {
 		memset(&avdatum, 0, sizeof avdatum);
+		/*
+		 * AUDITDENY and DONTAUDIT are &= assigned, versus |= for
+		 * others. Initialize the data accordingly.
+		 */
+		avdatum.data = (key->specified &
+			       (AVRULE_AUDITDENY | AVRULE_DONTAUDIT)) ? ~0 : 0;
 		/* this is used to get the node - insertion is actually unique */
 		node = avtab_insert_nonunique(avtab, key, &avdatum);
 		if (!node) {
@@ -1850,10 +1856,7 @@ static int expand_avrule_helper(sepol_handle_t * handle,
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
