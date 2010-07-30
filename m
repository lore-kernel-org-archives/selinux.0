From: Eric Paris <eparis@redhat.com>
Subject: [PATCH -v3] selinux: convert the policy type_attr_map to flex_array
To: selinux@tycho.nsa.gov
Cc: jmorris@namei.org, sds@tycho.nsa.gov
Date: Thu, 29 Jul 2010 23:02:34 -0400
Message-ID: <20100730030233.18877.81076.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Current selinux policy can have over 3000 types.  The type_attr_map in
policy is an array sized by the number of types times sizeof(struct ebitmap)
(12 on x86_64).  Basic math tells us the array is going to be of length
3000 x 12 = 36,000 bytes.  The largest 'safe' allocation on a long running
system is 16k.  Most of the time a 32k allocation will work.  But on long
running systems a 64k allocation (what we need) can fail quite regularly.
In order to deal with this I am converting the type_attr_map to use
flex_arrays.  Let the library code deal with breaking this into PAGE_SIZE
pieces.

-v2
rework some of the if(!obj) BUG() to be BUG_ON(!obj)
drop flex_array_put() calls and just use a _get() object directly

-v3
make apply to James' tree (drop the policydb_write changes)

Signed-off-by: Eric Paris <eparis@redhat.com>
Acked-by:  Stephen D. Smalley <sds@tycho.nsa.gov>
---

 security/selinux/ss/policydb.c |   41 ++++++++++++++++++++++++++++++----------
 security/selinux/ss/policydb.h |    4 +++-
 security/selinux/ss/services.c |    7 +++++--
 3 files changed, 39 insertions(+), 13 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 674ddfe..3a29704 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -31,6 +31,7 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/audit.h>
+#include <linux/flex_array.h>
 #include "security.h"
 
 #include "policydb.h"
@@ -739,11 +740,17 @@ void policydb_destroy(struct policydb *p)
 	hashtab_map(p->range_tr, range_tr_destroy, NULL);
 	hashtab_destroy(p->range_tr);
 
-	if (p->type_attr_map) {
-		for (i = 0; i < p->p_types.nprim; i++)
-			ebitmap_destroy(&p->type_attr_map[i]);
+	if (p->type_attr_map_array) {
+		for (i = 0; i < p->p_types.nprim; i++) {
+			struct ebitmap *e;
+
+			e = flex_array_get(p->type_attr_map_array, i);
+			if (!e)
+				continue;
+			ebitmap_destroy(e);
+		}
+		flex_array_free(p->type_attr_map_array);
 	}
-	kfree(p->type_attr_map);
 	ebitmap_destroy(&p->policycaps);
 	ebitmap_destroy(&p->permissive_map);
 
@@ -2257,19 +2264,33 @@ int policydb_read(struct policydb *p, void *fp)
 	if (rc)
 		goto bad;
 
-	p->type_attr_map = kmalloc(p->p_types.nprim * sizeof(struct ebitmap), GFP_KERNEL);
-	if (!p->type_attr_map)
+	rc = -ENOMEM;
+	p->type_attr_map_array = flex_array_alloc(sizeof(struct ebitmap),
+						  p->p_types.nprim,
+						  GFP_KERNEL | __GFP_ZERO);
+	if (!p->type_attr_map_array)
+		goto bad;
+
+	/* preallocate so we don't have to worry about the put ever failing */
+	rc = flex_array_prealloc(p->type_attr_map_array, 0, p->p_types.nprim - 1,
+				 GFP_KERNEL | __GFP_ZERO);
+	if (rc)
 		goto bad;
 
 	for (i = 0; i < p->p_types.nprim; i++) {
-		ebitmap_init(&p->type_attr_map[i]);
+		struct ebitmap *e = flex_array_get(p->type_attr_map_array, i);
+
+		BUG_ON(!e);
+		ebitmap_init(e);
 		if (p->policyvers >= POLICYDB_VERSION_AVTAB) {
-			if (ebitmap_read(&p->type_attr_map[i], fp))
+			rc = ebitmap_read(e, fp);
+			if (rc)
 				goto bad;
 		}
 		/* add the type itself as the degenerate case */
-		if (ebitmap_set_bit(&p->type_attr_map[i], i, 1))
-				goto bad;
+		rc = ebitmap_set_bit(e, i, 1);
+		if (rc)
+			goto bad;
 	}
 
 	rc = policydb_bounds_sanity_check(p);
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 26d9adf..310e944 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -24,6 +24,8 @@
 #ifndef _SS_POLICYDB_H_
 #define _SS_POLICYDB_H_
 
+#include <linux/flex_array.h>
+
 #include "symtab.h"
 #include "avtab.h"
 #include "sidtab.h"
@@ -246,7 +248,7 @@ struct policydb {
 	struct hashtab *range_tr;
 
 	/* type -> attribute reverse mapping */
-	struct ebitmap *type_attr_map;
+	struct flex_array *type_attr_map_array;
 
 	struct ebitmap policycaps;
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 1de60ce..9ea2fec 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -50,6 +50,7 @@
 #include <linux/audit.h>
 #include <linux/mutex.h>
 #include <linux/selinux.h>
+#include <linux/flex_array.h>
 #include <net/netlabel.h>
 
 #include "flask.h"
@@ -626,8 +627,10 @@ static void context_struct_compute_av(struct context *scontext,
 	 */
 	avkey.target_class = tclass;
 	avkey.specified = AVTAB_AV;
-	sattr = &policydb.type_attr_map[scontext->type - 1];
-	tattr = &policydb.type_attr_map[tcontext->type - 1];
+	sattr = flex_array_get(policydb.type_attr_map_array, scontext->type - 1);
+	BUG_ON(!sattr);
+	tattr = flex_array_get(policydb.type_attr_map_array, tcontext->type - 1);
+	BUG_ON(!tattr);
 	ebitmap_for_each_positive_bit(sattr, snode, i) {
 		ebitmap_for_each_positive_bit(tattr, tnode, j) {
 			avkey.source_type = i + 1;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
