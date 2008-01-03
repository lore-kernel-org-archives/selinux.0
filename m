Message-Id: <20080103184515.454003194@tresys.com>
References: <20080103184331.485176161@tresys.com>
Date: Thu, 03 Jan 2008 13:43:33 -0500
From: tmiller@tresys.com
To: selinux@tycho.nsa.gov
Cc: method@madmethod.com, sds@tycho.nsa.gov
Subject: [patch 2/7] quiet libsepol qualifier warnings
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Fix discarded const warnings in mls.c by sprinkling const in mls_level_eq,
mls_level_dom and the ebitmap functions.

---
 libsepol/include/sepol/policydb/ebitmap.h   |   12 ++++++------
 libsepol/include/sepol/policydb/mls_types.h |    4 ++--
 libsepol/src/ebitmap.c                      |   12 ++++++------
 3 files changed, 14 insertions(+), 14 deletions(-)

Index: trunk/libsepol/include/sepol/policydb/ebitmap.h
===================================================================
--- trunk.orig/libsepol/include/sepol/policydb/ebitmap.h
+++ trunk/libsepol/include/sepol/policydb/ebitmap.h
@@ -73,12 +73,12 @@ static inline int ebitmap_node_get_bit(e
 #define ebitmap_for_each_bit(e, n, bit) \
 	for (bit = ebitmap_start(e, &n); bit < ebitmap_length(e); bit = ebitmap_next(&n, bit)) \
 
-extern int ebitmap_cmp(ebitmap_t * e1, ebitmap_t * e2);
-extern int ebitmap_or(ebitmap_t * dst, ebitmap_t * e1, ebitmap_t * e2);
-extern int ebitmap_union(ebitmap_t * dst, ebitmap_t * e1);
-extern int ebitmap_cpy(ebitmap_t * dst, ebitmap_t * src);
-extern int ebitmap_contains(ebitmap_t * e1, ebitmap_t * e2);
-extern int ebitmap_get_bit(ebitmap_t * e, unsigned int bit);
+extern int ebitmap_cmp(const ebitmap_t * e1, const ebitmap_t * e2);
+extern int ebitmap_or(ebitmap_t * dst, const ebitmap_t * e1, const ebitmap_t * e2);
+extern int ebitmap_union(ebitmap_t * dst, const ebitmap_t * e1);
+extern int ebitmap_cpy(ebitmap_t * dst, const ebitmap_t * src);
+extern int ebitmap_contains(const ebitmap_t * e1, const ebitmap_t * e2);
+extern int ebitmap_get_bit(const ebitmap_t * e, unsigned int bit);
 extern int ebitmap_set_bit(ebitmap_t * e, unsigned int bit, int value);
 extern void ebitmap_destroy(ebitmap_t * e);
 extern int ebitmap_read(ebitmap_t * e, void *fp);
Index: trunk/libsepol/include/sepol/policydb/mls_types.h
===================================================================
--- trunk.orig/libsepol/include/sepol/policydb/mls_types.h
+++ trunk/libsepol/include/sepol/policydb/mls_types.h
@@ -70,12 +70,12 @@ static inline void mls_level_destroy(str
 	mls_level_init(level);
 }
 
-static inline int mls_level_eq(struct mls_level *l1, struct mls_level *l2)
+static inline int mls_level_eq(const struct mls_level *l1, const struct mls_level *l2)
 {
 	return ((l1->sens == l2->sens) && ebitmap_cmp(&l1->cat, &l2->cat));
 }
 
-static inline int mls_level_dom(struct mls_level *l1, struct mls_level *l2)
+static inline int mls_level_dom(const struct mls_level *l1, const struct mls_level *l2)
 {
 	return ((l1->sens >= l2->sens) && ebitmap_contains(&l1->cat, &l2->cat));
 }
Index: trunk/libsepol/src/ebitmap.c
===================================================================
--- trunk.orig/libsepol/src/ebitmap.c
+++ trunk/libsepol/src/ebitmap.c
@@ -15,7 +15,7 @@
 #include "debug.h"
 #include "private.h"
 
-int ebitmap_or(ebitmap_t * dst, ebitmap_t * e1, ebitmap_t * e2)
+int ebitmap_or(ebitmap_t * dst, const ebitmap_t * e1, const ebitmap_t * e2)
 {
 	ebitmap_node_t *n1, *n2, *new, *prev;
 
@@ -58,7 +58,7 @@ int ebitmap_or(ebitmap_t * dst, ebitmap_
 	return 0;
 }
 
-int ebitmap_union(ebitmap_t * dst, ebitmap_t * e1)
+int ebitmap_union(ebitmap_t * dst, const ebitmap_t * e1)
 {
 	ebitmap_t tmp;
 
@@ -71,7 +71,7 @@ int ebitmap_union(ebitmap_t * dst, ebitm
 	return 0;
 }
 
-int ebitmap_cmp(ebitmap_t * e1, ebitmap_t * e2)
+int ebitmap_cmp(const ebitmap_t * e1, const ebitmap_t * e2)
 {
 	ebitmap_node_t *n1, *n2;
 
@@ -92,7 +92,7 @@ int ebitmap_cmp(ebitmap_t * e1, ebitmap_
 	return 1;
 }
 
-int ebitmap_cpy(ebitmap_t * dst, ebitmap_t * src)
+int ebitmap_cpy(ebitmap_t * dst, const ebitmap_t * src)
 {
 	ebitmap_node_t *n, *new, *prev;
 
@@ -121,7 +121,7 @@ int ebitmap_cpy(ebitmap_t * dst, ebitmap
 	return 0;
 }
 
-int ebitmap_contains(ebitmap_t * e1, ebitmap_t * e2)
+int ebitmap_contains(const ebitmap_t * e1, const ebitmap_t * e2)
 {
 	ebitmap_node_t *n1, *n2;
 
@@ -148,7 +148,7 @@ int ebitmap_contains(ebitmap_t * e1, ebi
 	return 1;
 }
 
-int ebitmap_get_bit(ebitmap_t * e, unsigned int bit)
+int ebitmap_get_bit(const ebitmap_t * e, unsigned int bit)
 {
 	ebitmap_node_t *n;
 

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
