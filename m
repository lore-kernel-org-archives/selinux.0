Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o0VMhFYR004432
	for <selinux@tycho.nsa.gov>; Sun, 31 Jan 2010 17:43:15 -0500
Received: from hostingsmtp.register.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o0VMh3HE008681
	for <selinux@tycho.nsa.gov>; Sun, 31 Jan 2010 22:43:04 GMT
Message-Id: <201001312243.o0VMh9qn023003@vivaldi39.register.it>
From: "Guido Trentalancia" <guido@trentalancia.com>
Reply-To: "Guido Trentalancia" <guido@trentalancia.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, eparis@parisplace.org, jmorris@namei.org
Subject: [PATCH] Allowing MLS->non-MLS and vice versa upon policy reload
Date: Sun, 31 Jan 2010 23:43:09 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_9cb81d9739ca038815a898bcce47220a"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------_=_NextPart_000_9cb81d9739ca038815a898bcce47220a
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_e180d38c7880f6c5455907d61156c6e7"


------_=_NextPart_001_e180d38c7880f6c5455907d61156c6e7
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Dear Stephen,

I have created the patch for allowing runtime switch between different policy types, according to your advice and previous discussions on this mailing list. The patch obsoletes the small piece of documentation that I wrote a few days ago to help new users cope with the limitation.

I would be very grateful if you could review the patch so that, as soon as it is reviewed, it can be posted to the kernel mailing list. I have done some basic testing and it works on one of my systems, although sometimes I get the following side-effect:

/dev/pts/0 changed labels.
Unable to restore tty label...

which however doesn't affect the system. I am not sure where that comes from (perhaps bash)...

Regards,

Guido Trentalancia

Author: Guido Trentalancia <guido@trentalancia.com>
Date:   Sun Jan 31 22:10:22 2010 +0100

    Allow runtime switching between different policy types (e.g. from a MLS/MCS
    policy to a non-MLS/non-MCS policy or viceversa).

    Signed-off-by: Guido Trentalancia <guido@trentalancia.com>

diff -pruN security-testing-2.6/security/selinux/Makefile security-testing-2.6-new/security/selinux/Makefile
--- security-testing-2.6/security/selinux/Makefile	2010-01-29 01:06:42.132070393 +0100
+++ security-testing-2.6-new/security/selinux/Makefile	2010-01-29 02:13:42.497044862 +0100
@@ -18,7 +18,7 @@ selinux-$(CONFIG_SECURITY_NETWORK_XFRM) 
 
 selinux-$(CONFIG_NETLABEL) +=3D netlabel.o
 
-EXTRA_CFLAGS +=3D -Isecurity/selinux -Isecurity/selinux/include
+EXTRA_CFLAGS +=3D -Isecurity/selinux -Isecurity/selinux/ss -Isecurity/selinux/include
 
 $(obj)/avc.o: $(obj)/flask.h
 
diff -pruN security-testing-2.6/security/selinux/include/security.h security-testing-2.6-new/security/selinux/include/security.h
--- security-testing-2.6/security/selinux/include/security.h	2010-01-29 02:02:47.737045258 +0100
+++ security-testing-2.6-new/security/selinux/include/security.h	2010-01-29 02:13:59.641064788 +0100
@@ -57,7 +57,6 @@
 struct netlbl_lsm_secattr;
 
 extern int selinux_enabled;
-extern int selinux_mls_enabled;
 
 /* Policy capabilities */
 enum {
diff -pruN security-testing-2.6/security/selinux/selinuxfs.c security-testing-2.6-new/security/selinux/selinuxfs.c
--- security-testing-2.6/security/selinux/selinuxfs.c	2010-01-29 02:02:47.738046835 +0100
+++ security-testing-2.6-new/security/selinux/selinuxfs.c	2010-01-31 23:17:44.494329730 +0100
@@ -38,6 +38,10 @@
 #include "security.h"
 #include "objsec.h"
 #include "conditional.h"
+#include "services.h"
+#include "policydb.h"
+
+extern struct policydb policydb;
 
 /* Policy capability filenames */
 static char *policycap_names[] =3D {
@@ -282,7 +286,8 @@ static ssize_t sel_read_mls(struct file 
 	char tmpbuf[TMPBUFLEN];
 	ssize_t length;
 
-	length =3D scnprintf(tmpbuf, TMPBUFLEN, "%d", selinux_mls_enabled);
+	length =3D scnprintf(tmpbuf, TMPBUFLEN, "%d",
+		policydb.selinux_mls_enabled);
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
 }
 
diff -pruN security-testing-2.6/security/selinux/ss/Makefile security-testing-2.6-new/security/selinux/ss/Makefile
--- security-testing-2.6/security/selinux/ss/Makefile	2010-01-29 01:06:42.157062028 +0100
+++ security-testing-2.6-new/security/selinux/ss/Makefile	2010-01-29 02:15:52.319045091 +0100
@@ -5,5 +5,5 @@
 EXTRA_CFLAGS +=3D -Isecurity/selinux -Isecurity/selinux/include
 obj-y :=3D ss.o
 
-ss-y :=3D ebitmap.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o conditional.o mls.o
+ss-y :=3D context.o ebitmap.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o conditional.o mls.o mls_types.o
 
diff -pruN security-testing-2.6/security/selinux/ss/context.c security-testing-2.6-new/security/selinux/ss/context.c
--- security-testing-2.6/security/selinux/ss/context.c	1970-01-01 01:00:00.000000000 +0100
+++ security-testing-2.6-new/security/selinux/ss/context.c	2010-01-31 21:39:01.293500739 +0100
@@ -0,0 +1,131 @@
+/*
+ * Security context auxiliary functions
+ *
+ * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ */
+
+#include "context.h"
+#include "ebitmap.h"
+#include "mls_types.h"
+#include "security.h"
+#include "policydb.h"
+
+inline void mls_context_init(struct context *c)
+{
+	memset(&c->range, 0, sizeof(c->range));
+}
+
+inline int mls_context_cpy(struct context *dst, struct context *src)
+{
+	int rc;
+
+	if (!policydb.selinux_mls_enabled)
+		return 0;
+
+	dst->range.level[0].sens =3D src->range.level[0].sens;
+	rc =3D ebitmap_cpy(&dst->range.level[0].cat, &src->range.level[0].cat);
+	if (rc)
+		goto out;
+
+	dst->range.level[1].sens =3D src->range.level[1].sens;
+	rc =3D ebitmap_cpy(&dst->range.level[1].cat, &src->range.level[1].cat);
+	if (rc)
+		ebitmap_destroy(&dst->range.level[0].cat);
+out:
+	return rc;
+}
+
+/*
+ * Sets both levels in the MLS range of 'dst' to the low level of 'src'.
+ */
+inline int mls_context_cpy_low(struct context *dst, struct context *src)
+{
+	int rc;
+
+	if (!policydb.selinux_mls_enabled)
+		return 0;
+
+	dst->range.level[0].sens =3D src->range.level[0].sens;
+	rc =3D ebitmap_cpy(&dst->range.level[0].cat, &src->range.level[0].cat);
+	if (rc)
+		goto out;
+
+	dst->range.level[1].sens =3D src->range.level[0].sens;
+	rc =3D ebitmap_cpy(&dst->range.level[1].cat, &src->range.level[0].cat);
+	if (rc)
+		ebitmap_destroy(&dst->range.level[0].cat);
+out:
+	return rc;
+}
+
+inline int mls_context_cmp(struct context *c1, struct context *c2)
+{
+	if (!policydb.selinux_mls_enabled)
+		return 1;
+
+	return c1->range.level[0].sens =3D=3D c2->range.level[0].sens &&
+		ebitmap_cmp(&c1->range.level[0].cat, &c2->range.level[0].cat) &&
+		c1->range.level[1].sens =3D=3D c2->range.level[1].sens &&
+		ebitmap_cmp(&c1->range.level[1].cat, &c2->range.level[1].cat);
+}
+
+inline void mls_context_destroy(struct policydb *p, struct context *c)
+{
+	if (!p->selinux_mls_enabled)
+		return;
+
+	ebitmap_destroy(&c->range.level[0].cat);
+	ebitmap_destroy(&c->range.level[1].cat);
+	mls_context_init(c);
+}
+
+inline void context_init(struct context *c)
+{
+	memset(c, 0, sizeof(*c));
+}
+
+inline int context_cpy(struct context *dst, struct context *src)
+{
+	int rc;
+
+	dst->user =3D src->user;
+	dst->role =3D src->role;
+	dst->type =3D src->type;
+	if (src->str) {
+		dst->str =3D kstrdup(src->str, GFP_ATOMIC);
+		if (!dst->str)
+			return -ENOMEM;
+		dst->len =3D src->len;
+	} else {
+		dst->str =3D NULL;
+		dst->len =3D 0;
+	}
+	rc =3D mls_context_cpy(dst, src);
+	if (rc) {
+		kfree(dst->str);
+		return rc;
+	}
+	return 0;
+}
+
+inline void context_destroy(struct policydb *p, struct context *c)
+{
+	c->user =3D c->role =3D c->type =3D 0;
+	kfree(c->str);
+	c->str =3D NULL;
+	c->len =3D 0;
+	mls_context_destroy(p, c);
+}
+
+inline int context_cmp(struct context *c1, struct context *c2)
+{
+	if (c1->len && c2->len)
+		return (c1->len =3D=3D c2->len && !strcmp(c1->str, c2->str));
+	if (c1->len || c2->len)
+		return 0;
+	return ((c1->user =3D=3D c2->user) &&
+		(c1->role =3D=3D c2->role) &&
+		(c1->type =3D=3D c2->type) &&
+		mls_context_cmp(c1, c2));
+}
+
diff -pruN security-testing-2.6/security/selinux/ss/context.h security-testing-2.6-new/security/selinux/ss/context.h
--- security-testing-2.6/security/selinux/ss/context.h	2010-01-29 01:06:42.160060332 +0100
+++ security-testing-2.6-new/security/selinux/ss/context.h	2010-01-31 21:38:06.517349464 +0100
@@ -12,6 +12,7 @@
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+
 #ifndef _SS_CONTEXT_H_
 #define _SS_CONTEXT_H_
 
@@ -19,6 +20,8 @@
 #include "mls_types.h"
 #include "security.h"
 
+extern struct policydb policydb;
+
 /*
  * A security context consists of an authenticated user
  * identity, a role, a type and a MLS range.
@@ -32,124 +35,15 @@ struct context {
 	char *str;	/* string representation if context cannot be mapped. */
 };
 
-static inline void mls_context_init(struct context *c)
-{
-	memset(&c->range, 0, sizeof(c->range));
-}
-
-static inline int mls_context_cpy(struct context *dst, struct context *src)
-{
-	int rc;
-
-	if (!selinux_mls_enabled)
-		return 0;
-
-	dst->range.level[0].sens =3D src->range.level[0].sens;
-	rc =3D ebitmap_cpy(&dst->range.level[0].cat, &src->range.level[0].cat);
-	if (rc)
-		goto out;
-
-	dst->range.level[1].sens =3D src->range.level[1].sens;
-	rc =3D ebitmap_cpy(&dst->range.level[1].cat, &src->range.level[1].cat);
-	if (rc)
-		ebitmap_destroy(&dst->range.level[0].cat);
-out:
-	return rc;
-}
-
-/*
- * Sets both levels in the MLS range of 'dst' to the low level of 'src'.
- */
-static inline int mls_context_cpy_low(struct context *dst, struct context *src)
-{
-	int rc;
-
-	if (!selinux_mls_enabled)
-		return 0;
-
-	dst->range.level[0].sens =3D src->range.level[0].sens;
-	rc =3D ebitmap_cpy(&dst->range.level[0].cat, &src->range.level[0].cat);
-	if (rc)
-		goto out;
-
-	dst->range.level[1].sens =3D src->range.level[0].sens;
-	rc =3D ebitmap_cpy(&dst->range.level[1].cat, &src->range.level[0].cat);
-	if (rc)
-		ebitmap_destroy(&dst->range.level[0].cat);
-out:
-	return rc;
-}
-
-static inline int mls_context_cmp(struct context *c1, struct context *c2)
-{
-	if (!selinux_mls_enabled)
-		return 1;
-
-	return ((c1->range.level[0].sens =3D=3D c2->range.level[0].sens) &&
-		ebitmap_cmp(&c1->range.level[0].cat, &c2->range.level[0].cat) &&
-		(c1->range.level[1].sens =3D=3D c2->range.level[1].sens) &&
-		ebitmap_cmp(&c1->range.level[1].cat, &c2->range.level[1].cat));
-}
-
-static inline void mls_context_destroy(struct context *c)
-{
-	if (!selinux_mls_enabled)
-		return;
-
-	ebitmap_destroy(&c->range.level[0].cat);
-	ebitmap_destroy(&c->range.level[1].cat);
-	mls_context_init(c);
-}
-
-static inline void context_init(struct context *c)
-{
-	memset(c, 0, sizeof(*c));
-}
-
-static inline int context_cpy(struct context *dst, struct context *src)
-{
-	int rc;
-
-	dst->user =3D src->user;
-	dst->role =3D src->role;
-	dst->type =3D src->type;
-	if (src->str) {
-		dst->str =3D kstrdup(src->str, GFP_ATOMIC);
-		if (!dst->str)
-			return -ENOMEM;
-		dst->len =3D src->len;
-	} else {
-		dst->str =3D NULL;
-		dst->len =3D 0;
-	}
-	rc =3D mls_context_cpy(dst, src);
-	if (rc) {
-		kfree(dst->str);
-		return rc;
-	}
-	return 0;
-}
-
-static inline void context_destroy(struct context *c)
-{
-	c->user =3D c->role =3D c->type =3D 0;
-	kfree(c->str);
-	c->str =3D NULL;
-	c->len =3D 0;
-	mls_context_destroy(c);
-}
-
-static inline int context_cmp(struct context *c1, struct context *c2)
-{
-	if (c1->len && c2->len)
-		return (c1->len =3D=3D c2->len && !strcmp(c1->str, c2->str));
-	if (c1->len || c2->len)
-		return 0;
-	return ((c1->user =3D=3D c2->user) &&
-		(c1->role =3D=3D c2->role) &&
-		(c1->type =3D=3D c2->type) &&
-		mls_context_cmp(c1, c2));
-}
+inline void mls_context_init(struct context *c);
+inline int mls_context_cpy(struct context *dst, struct context *src);
+inline int mls_context_cpy_low(struct context *dst, struct context *src);
+inline int mls_context_cmp(struct context *c1, struct context *c2);
+inline void mls_context_destroy(struct policydb *p, struct context *c);
+inline void context_init(struct context *c);
+inline int context_cpy(struct context *dst, struct context *src);
+inline void context_destroy(struct policydb *p, struct context *c);
+inline int context_cmp(struct context *c1, struct context *c2);
 
 #endif	/* _SS_CONTEXT_H_ */
 
diff -pruN security-testing-2.6/security/selinux/ss/mls.c security-testing-2.6-new/security/selinux/ss/mls.c
--- security-testing-2.6/security/selinux/ss/mls.c	2010-01-29 02:02:47.739046177 +0100
+++ security-testing-2.6-new/security/selinux/ss/mls.c	2010-01-31 21:49:38.704348310 +0100
@@ -39,7 +39,7 @@ int mls_compute_context_len(struct conte
 	struct ebitmap *e;
 	struct ebitmap_node *node;
 
-	if (!selinux_mls_enabled)
+	if (!policydb.selinux_mls_enabled)
 		return 0;
 
 	len =3D 1; /* for the beginning ":" */
@@ -93,7 +93,7 @@ void mls_sid_to_context(struct context *
 	struct ebitmap *e;
 	struct ebitmap_node *node;
 
-	if (!selinux_mls_enabled)
+	if (!policydb.selinux_mls_enabled)
 		return;
 
 	scontextp =3D *scontext;
@@ -200,7 +200,7 @@ int mls_context_isvalid(struct policydb 
 {
 	struct user_datum *usrdatum;
 
-	if (!selinux_mls_enabled)
+	if (!p->selinux_mls_enabled)
 		return 1;
 
 	if (!mls_range_isvalid(p, &c->range))
@@ -253,7 +253,7 @@ int mls_context_to_sid(struct policydb *
 	struct cat_datum *catdatum, *rngdatum;
 	int l, rc =3D -EINVAL;
 
-	if (!selinux_mls_enabled) {
+	if (!pol->selinux_mls_enabled) {
 		if (def_sid !=3D SECSID_NULL && oldc)
 			*scontext +=3D strlen(*scontext)+1;
 		return 0;
@@ -387,7 +387,7 @@ int mls_from_string(char *str, struct co
 	char *tmpstr, *freestr;
 	int rc;
 
-	if (!selinux_mls_enabled)
+	if (!policydb.selinux_mls_enabled)
 		return -EINVAL;
 
 	/* we need freestr because mls_context_to_sid will change
@@ -407,7 +407,7 @@ int mls_from_string(char *str, struct co
 /*
  * Copies the MLS range `range' into `context'.
  */
-static inline int mls_range_set(struct context *context,
+inline int mls_range_set(struct context *context,
 				struct mls_range *range)
 {
 	int l, rc =3D 0;
@@ -427,7 +427,7 @@ static inline int mls_range_set(struct c
 int mls_setup_user_range(struct context *fromcon, struct user_datum *user,
 			 struct context *usercon)
 {
-	if (selinux_mls_enabled) {
+	if (policydb.selinux_mls_enabled) {
 		struct mls_level *fromcon_sen =3D &(fromcon->range.level[0]);
 		struct mls_level *fromcon_clr =3D &(fromcon->range.level[1]);
 		struct mls_level *user_low =3D &(user->range.level[0]);
@@ -477,7 +477,7 @@ int mls_convert_context(struct policydb 
 	struct ebitmap_node *node;
 	int l, i;
 
-	if (!selinux_mls_enabled)
+	if (!policydb.selinux_mls_enabled)
 		return 0;
 
 	for (l =3D 0; l < 2; l++) {
@@ -516,7 +516,7 @@ int mls_compute_sid(struct context *scon
 	struct range_trans rtr;
 	struct mls_range *r;
 
-	if (!selinux_mls_enabled)
+	if (!policydb.selinux_mls_enabled)
 		return 0;
 
 	switch (specified) {
@@ -559,7 +559,7 @@ int mls_compute_sid(struct context *scon
 void mls_export_netlbl_lvl(struct context *context,
 			   struct netlbl_lsm_secattr *secattr)
 {
-	if (!selinux_mls_enabled)
+	if (!policydb.selinux_mls_enabled)
 		return;
 
 	secattr->attr.mls.lvl =3D context->range.level[0].sens - 1;
@@ -579,7 +579,7 @@ void mls_export_netlbl_lvl(struct contex
 void mls_import_netlbl_lvl(struct context *context,
 			   struct netlbl_lsm_secattr *secattr)
 {
-	if (!selinux_mls_enabled)
+	if (!policydb.selinux_mls_enabled)
 		return;
 
 	context->range.level[0].sens =3D secattr->attr.mls.lvl + 1;
@@ -601,7 +601,7 @@ int mls_export_netlbl_cat(struct context
 {
 	int rc;
 
-	if (!selinux_mls_enabled)
+	if (!policydb.selinux_mls_enabled)
 		return 0;
 
 	rc =3D ebitmap_netlbl_export(&context->range.level[0].cat,
@@ -629,7 +629,7 @@ int mls_import_netlbl_cat(struct context
 {
 	int rc;
 
-	if (!selinux_mls_enabled)
+	if (!policydb.selinux_mls_enabled)
 		return 0;
 
 	rc =3D ebitmap_netlbl_import(&context->range.level[0].cat,
diff -pruN security-testing-2.6/security/selinux/ss/mls.h security-testing-2.6-new/security/selinux/ss/mls.h
--- security-testing-2.6/security/selinux/ss/mls.h	2010-01-29 01:06:42.168051431 +0100
+++ security-testing-2.6-new/security/selinux/ss/mls.h	2010-01-31 21:50:17.923330980 +0100
@@ -24,6 +24,8 @@
 #include "context.h"
 #include "policydb.h"
 
+extern struct policydb policydb;
+
 int mls_compute_context_len(struct context *context);
 void mls_sid_to_context(struct context *context, char **scontext);
 int mls_context_isvalid(struct policydb *p, struct context *c);
@@ -39,6 +41,8 @@ int mls_context_to_sid(struct policydb *
 
 int mls_from_string(char *str, struct context *context, gfp_t gfp_mask);
 
+inline int mls_range_set(struct context *context, struct mls_range *range);
+
 int mls_convert_context(struct policydb *oldp,
 			struct policydb *newp,
 			struct context *context);
diff -pruN security-testing-2.6/security/selinux/ss/mls_types.c security-testing-2.6-new/security/selinux/ss/mls_types.c
--- security-testing-2.6/security/selinux/ss/mls_types.c	1970-01-01 01:00:00.000000000 +0100
+++ security-testing-2.6-new/security/selinux/ss/mls_types.c	2010-01-29 02:36:49.528045041 +0100
@@ -0,0 +1,27 @@
+/*
+ * Auxiliary functions for the multi-level security (MLS) policy.
+ *
+ * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
+ */
+
+#include "mls_types.h"
+#include "policydb.h"
+
+inline int mls_level_eq(struct mls_level *l1, struct mls_level *l2)
+{
+	if (!policydb.selinux_mls_enabled)
+		return 1;
+
+	return ((l1->sens =3D=3D l2->sens) &&
+		ebitmap_cmp(&l1->cat, &l2->cat));
+}
+
+inline int mls_level_dom(struct mls_level *l1, struct mls_level *l2)
+{
+	if (!policydb.selinux_mls_enabled)
+		return 1;
+
+	return ((l1->sens >=3D l2->sens) &&
+		ebitmap_contains(&l1->cat, &l2->cat));
+}
+
diff -pruN security-testing-2.6/security/selinux/ss/mls_types.h security-testing-2.6-new/security/selinux/ss/mls_types.h
--- security-testing-2.6/security/selinux/ss/mls_types.h	2010-01-29 01:06:42.168051431 +0100
+++ security-testing-2.6-new/security/selinux/ss/mls_types.h	2010-01-29 02:23:39.017044387 +0100
@@ -14,7 +14,9 @@
 #ifndef _SS_MLS_TYPES_H_
 #define _SS_MLS_TYPES_H_
 
-#include "security.h"
+#include "ebitmap.h"
+
+extern struct policydb policydb;
 
 struct mls_level {
 	u32 sens;		/* sensitivity */
@@ -25,23 +27,8 @@ struct mls_range {
 	struct mls_level level[2]; /* low =3D=3D level[0], high =3D=3D level[1] */
 };
 
-static inline int mls_level_eq(struct mls_level *l1, struct mls_level *l2)
-{
-	if (!selinux_mls_enabled)
-		return 1;
-
-	return ((l1->sens =3D=3D l2->sens) &&
-		ebitmap_cmp(&l1->cat, &l2->cat));
-}
-
-static inline int mls_level_dom(struct mls_level *l1, struct mls_level *l2)
-{
-	if (!selinux_mls_enabled)
-		return 1;
-
-	return ((l1->sens >=3D l2->sens) &&
-		ebitmap_contains(&l1->cat, &l2->cat));
-}
+inline int mls_level_eq(struct mls_level *l1, struct mls_level *l2);
+inline int mls_level_dom(struct mls_level *l1, struct mls_level *l2);
 
 #define mls_level_incomp(l1, l2) 
 (!mls_level_dom((l1), (l2)) && !mls_level_dom((l2), (l1)))
diff -pruN security-testing-2.6/security/selinux/ss/policydb.c security-testing-2.6-new/security/selinux/ss/policydb.c
--- security-testing-2.6/security/selinux/ss/policydb.c	2010-01-29 02:02:47.740046077 +0100
+++ security-testing-2.6-new/security/selinux/ss/policydb.c	2010-01-31 21:41:44.306327882 +0100
@@ -52,8 +52,6 @@ static char *symtab_name[SYM_NUM] =3D {
 };
 #endif
 
-int selinux_mls_enabled;
-
 static unsigned int symtab_sizes[SYM_NUM] =3D {
 	2,
 	32,
@@ -455,7 +453,7 @@ static int policydb_index_others(struct 
 
 	printk(KERN_DEBUG "SELinux:  %d users, %d roles, %d types, %d bools",
 	       p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim, p->p_bools.nprim);
-	if (selinux_mls_enabled)
+	if (p->selinux_mls_enabled)
 		printk(", %d sens, %d cats", p->p_levels.nprim,
 		       p->p_cats.nprim);
 	printk("n");
@@ -656,10 +654,10 @@ static int range_tr_destroy(void *key, v
 	return 0;
 }
 
-static void ocontext_destroy(struct ocontext *c, int i)
+static void ocontext_destroy(struct policydb *p, struct ocontext *c, int i)
 {
-	context_destroy(&c->context[0]);
-	context_destroy(&c->context[1]);
+	context_destroy(p, &c->context[0]);
+	context_destroy(p, &c->context[1]);
 	if (i =3D=3D OCON_ISID || i =3D=3D OCON_FS ||
 	    i =3D=3D OCON_NETIF || i =3D=3D OCON_FSUSE)
 		kfree(c->u.name);
@@ -699,7 +697,7 @@ void policydb_destroy(struct policydb *p
 		while (c) {
 			ctmp =3D c;
 			c =3D c->next;
-			ocontext_destroy(ctmp, i);
+			ocontext_destroy(p, ctmp, i);
 		}
 		p->ocontexts[i] =3D NULL;
 	}
@@ -712,7 +710,7 @@ void policydb_destroy(struct policydb *p
 		while (c) {
 			ctmp =3D c;
 			c =3D c->next;
-			ocontext_destroy(ctmp, OCON_FSUSE);
+			ocontext_destroy(p, ctmp, OCON_FSUSE);
 		}
 		gtmp =3D g;
 		g =3D g->next;
@@ -942,7 +940,7 @@ static int context_read_and_validate(str
 
 	if (!policydb_context_isvalid(p, c)) {
 		printk(KERN_ERR "SELinux:  invalid security contextn");
-		context_destroy(c);
+		context_destroy(p, c);
 		rc =3D -EINVAL;
 	}
 out:
@@ -1787,12 +1785,7 @@ int policydb_read(struct policydb *p, vo
 	}
 
 	if ((le32_to_cpu(buf[1]) & POLICYDB_CONFIG_MLS)) {
-		if (ss_initialized && !selinux_mls_enabled) {
-			printk(KERN_ERR "SELinux: Cannot switch between non-MLS"
-				" and MLS policiesn");
-			goto bad;
-		}
-		selinux_mls_enabled =3D 1;
+		p->selinux_mls_enabled =3D 1;
 		config |=3D POLICYDB_CONFIG_MLS;
 
 		if (p->policyvers < POLICYDB_VERSION_MLS) {
@@ -1801,12 +1794,6 @@ int policydb_read(struct policydb *p, vo
 				p->policyvers);
 			goto bad;
 		}
-	} else {
-		if (ss_initialized && selinux_mls_enabled) {
-			printk(KERN_ERR "SELinux: Cannot switch between MLS and"
-				" non-MLS policiesn");
-			goto bad;
-		}
 	}
 	p->reject_unknown =3D !!(le32_to_cpu(buf[1]) & REJECT_UNKNOWN);
 	p->allow_unknown =3D !!(le32_to_cpu(buf[1]) & ALLOW_UNKNOWN);
@@ -2234,7 +2221,7 @@ int policydb_read(struct policydb *p, vo
 out:
 	return rc;
 bad_newc:
-	ocontext_destroy(newc, OCON_FSUSE);
+	ocontext_destroy(p, newc, OCON_FSUSE);
 bad:
 	if (!rc)
 		rc =3D -EINVAL;
diff -pruN security-testing-2.6/security/selinux/ss/policydb.h security-testing-2.6-new/security/selinux/ss/policydb.h
--- security-testing-2.6/security/selinux/ss/policydb.h	2010-01-29 02:02:47.740046077 +0100
+++ security-testing-2.6-new/security/selinux/ss/policydb.h	2010-01-29 02:33:01.393045934 +0100
@@ -185,6 +185,8 @@ struct genfs {
 
 /* The policy database */
 struct policydb {
+	int selinux_mls_enabled;
+
 	/* symbol tables */
 	struct symtab symtab[SYM_NUM];
 #define p_commons symtab[SYM_COMMONS]
diff -pruN security-testing-2.6/security/selinux/ss/services.c security-testing-2.6-new/security/selinux/ss/services.c
--- security-testing-2.6/security/selinux/ss/services.c	2010-01-29 02:02:47.742042805 +0100
+++ security-testing-2.6-new/security/selinux/ss/services.c	2010-01-31 23:28:26.440336638 +0100
@@ -26,6 +26,10 @@
  *
  *  Added support for bounds domain and audit messaged on masked permissions
  *
+ * Updated: Guido Trentalancia <guido@trentalancia.com>
+ *
+ *  Added support for runtime switching of the policy type
+ *
  * Copyright (C) 2008, 2009 NEC Corporation
  * Copyright (C) 2006, 2007 Hewlett-Packard Development Company, L.P.
  * Copyright (C) 2004-2006 Trusted Computer Solutions, Inc.
@@ -1145,7 +1149,7 @@ static int string_to_context_struct(stru
 	rc =3D 0;
 out:
 	if (rc)
-		context_destroy(ctx);
+		context_destroy(pol, ctx);
 	return rc;
 }
 
@@ -1198,7 +1202,7 @@ static int security_context_to_sid_core(
 	} else if (rc)
 		goto out;
 	rc =3D sidtab_context_to_sid(&sidtab, &context, sid);
-	context_destroy(&context);
+	context_destroy(&policydb, &context);
 out:
 	read_unlock(&policy_rwlock);
 	kfree(scontext2);
@@ -1419,7 +1423,7 @@ static int security_compute_sid(u32 ssid
 	rc =3D sidtab_context_to_sid(&sidtab, &newcontext, out_sid);
 out_unlock:
 	read_unlock(&policy_rwlock);
-	context_destroy(&newcontext);
+	context_destroy(&policydb, &newcontext);
 out:
 	return rc;
 }
@@ -1547,6 +1551,8 @@ static int convert_context(u32 key,
 {
 	struct convert_context_args *args;
 	struct context oldc;
+	struct ocontext *oc;
+	struct mls_range *range;
 	struct role_datum *role;
 	struct type_datum *typdatum;
 	struct user_datum *usrdatum;
@@ -1614,9 +1620,29 @@ static int convert_context(u32 key,
 		goto bad;
 	c->type =3D typdatum->value;
 
-	rc =3D mls_convert_context(args->oldp, args->newp, c);
-	if (rc)
-		goto bad;
+	/* Convert the MLS/MCS fields or deal with policy type switch */
+	if (args->oldp->selinux_mls_enabled
+	    && args->newp->selinux_mls_enabled) {
+		rc =3D mls_convert_context(args->oldp, args->newp, c);
+		if (rc)
+			goto bad;
+	} else if (args->oldp->selinux_mls_enabled
+		   && !args->newp->selinux_mls_enabled)
+	/* Switching between MLS/MCS and non-MLS/non-MCS policy: */
+	/* free any storage used by the MLS fields in the        */
+	/* context for all existing entries in the sidtab.       */
+		mls_context_destroy(args->oldp, c);
+	else if (!args->oldp->selinux_mls_enabled
+		 && args->newp->selinux_mls_enabled) {
+	/* Switching between non-MLS/non-MCS and MLS/MCS policy:  */
+	/* ensure that the MLS fields of the context for all      */
+	/* existing entries in the sidtab are filled in with a    */
+	/* suitable default value, likely taken from one of the   */
+	/* initial SIDs.                                          */
+		oc =3D args->newp->ocontexts[OCON_ISID];
+		range =3D &oc->context[0].range;
+		mls_range_set(c, range);
+	}
 
 	/* Check the validity of the new context. */
 	if (!policydb_context_isvalid(args->newp, c)) {
@@ -1625,7 +1651,7 @@ static int convert_context(u32 key,
 			goto bad;
 	}
 
-	context_destroy(&oldc);
+	context_destroy(args->oldp, &oldc);
 	rc =3D 0;
 out:
 	return rc;
@@ -1633,8 +1659,8 @@ bad:
 	/* Map old representation to string and save it. */
 	if (context_struct_to_string(&oldc, &s, &len))
 		return -ENOMEM;
-	context_destroy(&oldc);
-	context_destroy(c);
+	context_destroy(args->oldp, &oldc);
+	context_destroy(args->newp, c);
 	c->str =3D s;
 	c->len =3D len;
 	printk(KERN_INFO
@@ -1712,6 +1738,15 @@ int security_load_policy(void *data, siz
 	if (policydb_read(&newpolicydb, fp))
 		return -EINVAL;
 
+	/* If switching between different policy types, log it */
+	if (policydb.selinux_mls_enabled && newpolicydb.selinux_mls_enabled)
+		printk(KERN_INFO "SELinux: Switching between MLS/MCS"
+			" and standard policy...n");
+	else if (!policydb.selinux_mls_enabled
+	  && newpolicydb.selinux_mls_enabled)
+		printk(KERN_INFO "SELinux: Switching between standard"
+			" and MLS/MCS policy...n");
+
 	if (sidtab_init(&newsidtab)) {
 		policydb_destroy(&newpolicydb);
 		return -ENOMEM;
@@ -1741,8 +1776,12 @@ int security_load_policy(void *data, siz
 	args.oldp =3D &policydb;
 	args.newp =3D &newpolicydb;
 	rc =3D sidtab_map(&newsidtab, convert_context, &args);
-	if (rc)
+	if (rc) {
+		printk(KERN_ERR "SELinux:  unable to convert the internal"
+			" representation of contexts in the new SID"
+			" tablen");
 		goto err;
+	}
 
 	/* Save the old policydb and SID table to free later. */
 	memcpy(&oldpolicydb, &policydb, sizeof policydb);
@@ -1761,7 +1800,7 @@ int security_load_policy(void *data, siz
 
 	/* Free the old policydb and SID table. */
 	policydb_destroy(&oldpolicydb);
-	sidtab_destroy(&oldsidtab);
+	sidtab_destroy(&oldpolicydb, &oldsidtab);
 	kfree(oldmap);
 
 	avc_ss_reset(seqno);
@@ -1773,7 +1812,7 @@ int security_load_policy(void *data, siz
 
 err:
 	kfree(map);
-	sidtab_destroy(&newsidtab);
+	sidtab_destroy(&newpolicydb, &newsidtab);
 	policydb_destroy(&newpolicydb);
 	return rc;
 
@@ -2338,7 +2377,7 @@ int security_sid_mls_copy(u32 sid, u32 m
 	u32 len;
 	int rc =3D 0;
 
-	if (!ss_initialized || !selinux_mls_enabled) {
+	if (!ss_initialized || !policydb.selinux_mls_enabled) {
 		*new_sid =3D sid;
 		goto out;
 	}
@@ -2388,7 +2427,7 @@ bad:
 
 out_unlock:
 	read_unlock(&policy_rwlock);
-	context_destroy(&newcon);
+	context_destroy(&policydb, &newcon);
 out:
 	return rc;
 }
@@ -2439,7 +2478,7 @@ int security_net_peersid_resolve(u32 nlb
 	/* we don't need to check ss_initialized here since the only way both
 	 * nlbl_sid and xfrm_sid are not equal to SECSID_NULL would be if the
 	 * security server was initialized and ss_initialized was true */
-	if (!selinux_mls_enabled) {
+	if (!policydb.selinux_mls_enabled) {
 		*peer_sid =3D SECSID_NULL;
 		return 0;
 	}
@@ -2612,7 +2651,7 @@ void selinux_audit_rule_free(void *vrule
 	struct selinux_audit_rule *rule =3D vrule;
 
 	if (rule) {
-		context_destroy(&rule->au_ctxt);
+		context_destroy(&policydb, &rule->au_ctxt);
 		kfree(rule);
 	}
 }
diff -pruN security-testing-2.6/security/selinux/ss/services.h security-testing-2.6-new/security/selinux/ss/services.h
--- security-testing-2.6/security/selinux/ss/services.h	2010-01-29 01:06:42.174044406 +0100
+++ security-testing-2.6-new/security/selinux/ss/services.h	2010-01-31 23:24:36.677347711 +0100
@@ -3,6 +3,7 @@
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+
 #ifndef _SS_SERVICES_H_
 #define _SS_SERVICES_H_
 
@@ -11,5 +12,51 @@
 
 extern struct policydb policydb;
 
+int security_bounded_transition(u32 old_sid, u32 new_sid);
+void security_compute_av(u32 ssid, u32 tsid, u16 orig_tclass,
+			 struct av_decision *avd);
+void security_compute_av_user(u32 ssid, u32 tsid, u16 tclass,
+			      struct av_decision *avd);
+const char *security_get_initial_sid_context(u32 sid);
+int security_sid_to_context(u32 sid, char **scontext, u32 *scontext_len);
+int security_sid_to_context_force(u32 sid, char **scontext, u32 *scontext_len);
+int security_context_to_sid(const char *scontext, u32 scontext_len, u32 *sid);
+int security_context_to_sid_default(const char *scontext, u32 scontext_len,
+				    u32 *sid, u32 def_sid, gfp_t gfp_flags);
+int security_context_to_sid_force(const char *scontext, u32 scontext_len,
+				  u32 *sid);
+int security_transition_sid(u32 ssid, u32 tsid, u16 tclass, u32 *out_sid);
+int security_transition_sid_user(u32 ssid, u32 tsid, u16 tclass, u32 *out_sid);
+int security_member_sid(u32 ssid, u32 tsid, u16 tclass, u32 *out_sid);
+int security_change_sid(u32 ssid, u32 tsid, u16 tclass, u32 *out_sid);
+int security_load_policy(void *data, size_t len);
+int security_port_sid(u8 protocol, u16 port, u32 *out_sid);
+int security_netif_sid(char *name, u32 *if_sid);
+int security_node_sid(u16 domain, void *addrp, u32 addrlen, u32 *out_sid);
+int security_get_user_sids(u32 fromsid, char *username, u32 **sids, u32 *nel);
+int security_genfs_sid(const char *fstype, char *path, u16 orig_sclass,
+		       u32 *sid);
+int security_fs_use(const char *fstype, unsigned int *behavior, u32 *sid);
+int security_get_bools(int *len, char ***names, int **values);
+int security_set_bools(int len, int *values);
+int security_get_bool_value(int bool);
+int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid);
+int security_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type, u32 xfrm_sid,
+				 u32 *peer_sid);
+int security_get_classes(char ***classes, int *nclasses);
+int security_get_permissions(char *class, char ***perms, int *nperms);
+int security_get_reject_unknown(void);
+int security_get_allow_unknown(void);
+int security_policycap_supported(unsigned int req_cap);
+void selinux_audit_rule_free(void *vrule);
+int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule);
+int selinux_audit_rule_known(struct audit_krule *rule);
+int selinux_audit_rule_match(u32 sid, u32 field, u32 op, void *vrule,
+			     struct audit_context *actx);
+int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
+				   u32 *sid);
+int security_netlbl_sid_to_secattr(u32 sid, struct netlbl_lsm_secattr *secattr);
+
+
 #endif	/* _SS_SERVICES_H_ */
 
diff -pruN security-testing-2.6/security/selinux/ss/sidtab.c security-testing-2.6-new/security/selinux/ss/sidtab.c
--- security-testing-2.6/security/selinux/ss/sidtab.c	2010-01-29 01:06:42.174044406 +0100
+++ security-testing-2.6-new/security/selinux/ss/sidtab.c	2010-01-31 21:42:55.649896349 +0100
@@ -232,7 +232,7 @@ void sidtab_hash_eval(struct sidtab *h, 
 	       max_chain_len);
 }
 
-void sidtab_destroy(struct sidtab *s)
+void sidtab_destroy(struct policydb *p, struct sidtab *s)
 {
 	int i;
 	struct sidtab_node *cur, *temp;
@@ -245,7 +245,7 @@ void sidtab_destroy(struct sidtab *s)
 		while (cur) {
 			temp =3D cur;
 			cur =3D cur->next;
-			context_destroy(&temp->context);
+			context_destroy(p, &temp->context);
 			kfree(temp);
 		}
 		s->htable[i] =3D NULL;
diff -pruN security-testing-2.6/security/selinux/ss/sidtab.h security-testing-2.6-new/security/selinux/ss/sidtab.h
--- security-testing-2.6/security/selinux/ss/sidtab.h	2010-01-29 01:06:42.175047659 +0100
+++ security-testing-2.6-new/security/selinux/ss/sidtab.h	2010-01-31 21:42:31.052348740 +0100
@@ -45,7 +45,7 @@ int sidtab_context_to_sid(struct sidtab 
 			  u32 *sid);
 
 void sidtab_hash_eval(struct sidtab *h, char *tag);
-void sidtab_destroy(struct sidtab *s);
+void sidtab_destroy(struct policydb *p, struct sidtab *s);
 void sidtab_set(struct sidtab *dst, struct sidtab *src);
 void sidtab_shutdown(struct sidtab *s);
  

------_=_NextPart_001_e180d38c7880f6c5455907d61156c6e7--

------_=_NextPart_000_9cb81d9739ca038815a898bcce47220a
Content-Type: application/octet-stream;
	name="switch-policy.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="switch-policy.patch"

QXV0aG9yOiBHdWlkbyBUcmVudGFsYW5jaWEgPGd1aWRvQHRyZW50YWxhbmNp
YS5jb20+CkRhdGU6ICAgU3VuIEphbiAzMSAyMjoxMDoyMiAyMDEwICswMTAw
CgogICAgQWxsb3cgcnVudGltZSBzd2l0Y2hpbmcgYmV0d2VlbiBkaWZmZXJl
bnQgcG9saWN5IHR5cGVzIChlLmcuIGZyb20gYSBNTFMvTUNTCiAgICBwb2xp
Y3kgdG8gYSBub24tTUxTL25vbi1NQ1MgcG9saWN5IG9yIHZpY2V2ZXJzYSku
CgogICAgU2lnbmVkLW9mZi1ieTogR3VpZG8gVHJlbnRhbGFuY2lhIDxndWlk
b0B0cmVudGFsYW5jaWEuY29tPgoKZGlmZiAtcHJ1TiBzZWN1cml0eS10ZXN0
aW5nLTIuNi9zZWN1cml0eS9zZWxpbnV4L01ha2VmaWxlIHNlY3VyaXR5LXRl
c3RpbmctMi42LW5ldy9zZWN1cml0eS9zZWxpbnV4L01ha2VmaWxlCi0tLSBz
ZWN1cml0eS10ZXN0aW5nLTIuNi9zZWN1cml0eS9zZWxpbnV4L01ha2VmaWxl
CTIwMTAtMDEtMjkgMDE6MDY6NDIuMTMyMDcwMzkzICswMTAwCisrKyBzZWN1
cml0eS10ZXN0aW5nLTIuNi1uZXcvc2VjdXJpdHkvc2VsaW51eC9NYWtlZmls
ZQkyMDEwLTAxLTI5IDAyOjEzOjQyLjQ5NzA0NDg2MiArMDEwMApAQCAtMTgs
NyArMTgsNyBAQCBzZWxpbnV4LSQoQ09ORklHX1NFQ1VSSVRZX05FVFdPUktf
WEZSTSkgCiAKIHNlbGludXgtJChDT05GSUdfTkVUTEFCRUwpICs9IG5ldGxh
YmVsLm8KIAotRVhUUkFfQ0ZMQUdTICs9IC1Jc2VjdXJpdHkvc2VsaW51eCAt
SXNlY3VyaXR5L3NlbGludXgvaW5jbHVkZQorRVhUUkFfQ0ZMQUdTICs9IC1J
c2VjdXJpdHkvc2VsaW51eCAtSXNlY3VyaXR5L3NlbGludXgvc3MgLUlzZWN1
cml0eS9zZWxpbnV4L2luY2x1ZGUKIAogJChvYmopL2F2Yy5vOiAkKG9iaikv
Zmxhc2suaAogCmRpZmYgLXBydU4gc2VjdXJpdHktdGVzdGluZy0yLjYvc2Vj
dXJpdHkvc2VsaW51eC9pbmNsdWRlL3NlY3VyaXR5Lmggc2VjdXJpdHktdGVz
dGluZy0yLjYtbmV3L3NlY3VyaXR5L3NlbGludXgvaW5jbHVkZS9zZWN1cml0
eS5oCi0tLSBzZWN1cml0eS10ZXN0aW5nLTIuNi9zZWN1cml0eS9zZWxpbnV4
L2luY2x1ZGUvc2VjdXJpdHkuaAkyMDEwLTAxLTI5IDAyOjAyOjQ3LjczNzA0
NTI1OCArMDEwMAorKysgc2VjdXJpdHktdGVzdGluZy0yLjYtbmV3L3NlY3Vy
aXR5L3NlbGludXgvaW5jbHVkZS9zZWN1cml0eS5oCTIwMTAtMDEtMjkgMDI6
MTM6NTkuNjQxMDY0Nzg4ICswMTAwCkBAIC01Nyw3ICs1Nyw2IEBACiBzdHJ1
Y3QgbmV0bGJsX2xzbV9zZWNhdHRyOwogCiBleHRlcm4gaW50IHNlbGludXhf
ZW5hYmxlZDsKLWV4dGVybiBpbnQgc2VsaW51eF9tbHNfZW5hYmxlZDsKIAog
LyogUG9saWN5IGNhcGFiaWxpdGllcyAqLwogZW51bSB7CmRpZmYgLXBydU4g
c2VjdXJpdHktdGVzdGluZy0yLjYvc2VjdXJpdHkvc2VsaW51eC9zZWxpbnV4
ZnMuYyBzZWN1cml0eS10ZXN0aW5nLTIuNi1uZXcvc2VjdXJpdHkvc2VsaW51
eC9zZWxpbnV4ZnMuYwotLS0gc2VjdXJpdHktdGVzdGluZy0yLjYvc2VjdXJp
dHkvc2VsaW51eC9zZWxpbnV4ZnMuYwkyMDEwLTAxLTI5IDAyOjAyOjQ3Ljcz
ODA0NjgzNSArMDEwMAorKysgc2VjdXJpdHktdGVzdGluZy0yLjYtbmV3L3Nl
Y3VyaXR5L3NlbGludXgvc2VsaW51eGZzLmMJMjAxMC0wMS0zMSAyMzoxNzo0
NC40OTQzMjk3MzAgKzAxMDAKQEAgLTM4LDYgKzM4LDEwIEBACiAjaW5jbHVk
ZSAic2VjdXJpdHkuaCIKICNpbmNsdWRlICJvYmpzZWMuaCIKICNpbmNsdWRl
ICJjb25kaXRpb25hbC5oIgorI2luY2x1ZGUgInNlcnZpY2VzLmgiCisjaW5j
bHVkZSAicG9saWN5ZGIuaCIKKworZXh0ZXJuIHN0cnVjdCBwb2xpY3lkYiBw
b2xpY3lkYjsKIAogLyogUG9saWN5IGNhcGFiaWxpdHkgZmlsZW5hbWVzICov
CiBzdGF0aWMgY2hhciAqcG9saWN5Y2FwX25hbWVzW10gPSB7CkBAIC0yODIs
NyArMjg2LDggQEAgc3RhdGljIHNzaXplX3Qgc2VsX3JlYWRfbWxzKHN0cnVj
dCBmaWxlIAogCWNoYXIgdG1wYnVmW1RNUEJVRkxFTl07CiAJc3NpemVfdCBs
ZW5ndGg7CiAKLQlsZW5ndGggPSBzY25wcmludGYodG1wYnVmLCBUTVBCVUZM
RU4sICIlZCIsIHNlbGludXhfbWxzX2VuYWJsZWQpOworCWxlbmd0aCA9IHNj
bnByaW50Zih0bXBidWYsIFRNUEJVRkxFTiwgIiVkIiwKKwkJcG9saWN5ZGIu
c2VsaW51eF9tbHNfZW5hYmxlZCk7CiAJcmV0dXJuIHNpbXBsZV9yZWFkX2Zy
b21fYnVmZmVyKGJ1ZiwgY291bnQsIHBwb3MsIHRtcGJ1ZiwgbGVuZ3RoKTsK
IH0KIApkaWZmIC1wcnVOIHNlY3VyaXR5LXRlc3RpbmctMi42L3NlY3VyaXR5
L3NlbGludXgvc3MvTWFrZWZpbGUgc2VjdXJpdHktdGVzdGluZy0yLjYtbmV3
L3NlY3VyaXR5L3NlbGludXgvc3MvTWFrZWZpbGUKLS0tIHNlY3VyaXR5LXRl
c3RpbmctMi42L3NlY3VyaXR5L3NlbGludXgvc3MvTWFrZWZpbGUJMjAxMC0w
MS0yOSAwMTowNjo0Mi4xNTcwNjIwMjggKzAxMDAKKysrIHNlY3VyaXR5LXRl
c3RpbmctMi42LW5ldy9zZWN1cml0eS9zZWxpbnV4L3NzL01ha2VmaWxlCTIw
MTAtMDEtMjkgMDI6MTU6NTIuMzE5MDQ1MDkxICswMTAwCkBAIC01LDUgKzUs
NSBAQAogRVhUUkFfQ0ZMQUdTICs9IC1Jc2VjdXJpdHkvc2VsaW51eCAtSXNl
Y3VyaXR5L3NlbGludXgvaW5jbHVkZQogb2JqLXkgOj0gc3MubwogCi1zcy15
IDo9IGViaXRtYXAubyBoYXNodGFiLm8gc3ltdGFiLm8gc2lkdGFiLm8gYXZ0
YWIubyBwb2xpY3lkYi5vIHNlcnZpY2VzLm8gY29uZGl0aW9uYWwubyBtbHMu
bworc3MteSA6PSBjb250ZXh0Lm8gZWJpdG1hcC5vIGhhc2h0YWIubyBzeW10
YWIubyBzaWR0YWIubyBhdnRhYi5vIHBvbGljeWRiLm8gc2VydmljZXMubyBj
b25kaXRpb25hbC5vIG1scy5vIG1sc190eXBlcy5vCiAKZGlmZiAtcHJ1TiBz
ZWN1cml0eS10ZXN0aW5nLTIuNi9zZWN1cml0eS9zZWxpbnV4L3NzL2NvbnRl
eHQuYyBzZWN1cml0eS10ZXN0aW5nLTIuNi1uZXcvc2VjdXJpdHkvc2VsaW51
eC9zcy9jb250ZXh0LmMKLS0tIHNlY3VyaXR5LXRlc3RpbmctMi42L3NlY3Vy
aXR5L3NlbGludXgvc3MvY29udGV4dC5jCTE5NzAtMDEtMDEgMDE6MDA6MDAu
MDAwMDAwMDAwICswMTAwCisrKyBzZWN1cml0eS10ZXN0aW5nLTIuNi1uZXcv
c2VjdXJpdHkvc2VsaW51eC9zcy9jb250ZXh0LmMJMjAxMC0wMS0zMSAyMToz
OTowMS4yOTM1MDA3MzkgKzAxMDAKQEAgLTAsMCArMSwxMzEgQEAKKy8qCisg
KiBTZWN1cml0eSBjb250ZXh0IGF1eGlsaWFyeSBmdW5jdGlvbnMKKyAqCisg
KiBBdXRob3IgOiBTdGVwaGVuIFNtYWxsZXksIDxzZHNAZXBvY2gubmNzYy5t
aWw+CisgKi8KKworI2luY2x1ZGUgImNvbnRleHQuaCIKKyNpbmNsdWRlICJl
Yml0bWFwLmgiCisjaW5jbHVkZSAibWxzX3R5cGVzLmgiCisjaW5jbHVkZSAi
c2VjdXJpdHkuaCIKKyNpbmNsdWRlICJwb2xpY3lkYi5oIgorCitpbmxpbmUg
dm9pZCBtbHNfY29udGV4dF9pbml0KHN0cnVjdCBjb250ZXh0ICpjKQorewor
CW1lbXNldCgmYy0+cmFuZ2UsIDAsIHNpemVvZihjLT5yYW5nZSkpOworfQor
CitpbmxpbmUgaW50IG1sc19jb250ZXh0X2NweShzdHJ1Y3QgY29udGV4dCAq
ZHN0LCBzdHJ1Y3QgY29udGV4dCAqc3JjKQoreworCWludCByYzsKKworCWlm
ICghcG9saWN5ZGIuc2VsaW51eF9tbHNfZW5hYmxlZCkKKwkJcmV0dXJuIDA7
CisKKwlkc3QtPnJhbmdlLmxldmVsWzBdLnNlbnMgPSBzcmMtPnJhbmdlLmxl
dmVsWzBdLnNlbnM7CisJcmMgPSBlYml0bWFwX2NweSgmZHN0LT5yYW5nZS5s
ZXZlbFswXS5jYXQsICZzcmMtPnJhbmdlLmxldmVsWzBdLmNhdCk7CisJaWYg
KHJjKQorCQlnb3RvIG91dDsKKworCWRzdC0+cmFuZ2UubGV2ZWxbMV0uc2Vu
cyA9IHNyYy0+cmFuZ2UubGV2ZWxbMV0uc2VuczsKKwlyYyA9IGViaXRtYXBf
Y3B5KCZkc3QtPnJhbmdlLmxldmVsWzFdLmNhdCwgJnNyYy0+cmFuZ2UubGV2
ZWxbMV0uY2F0KTsKKwlpZiAocmMpCisJCWViaXRtYXBfZGVzdHJveSgmZHN0
LT5yYW5nZS5sZXZlbFswXS5jYXQpOworb3V0OgorCXJldHVybiByYzsKK30K
KworLyoKKyAqIFNldHMgYm90aCBsZXZlbHMgaW4gdGhlIE1MUyByYW5nZSBv
ZiAnZHN0JyB0byB0aGUgbG93IGxldmVsIG9mICdzcmMnLgorICovCitpbmxp
bmUgaW50IG1sc19jb250ZXh0X2NweV9sb3coc3RydWN0IGNvbnRleHQgKmRz
dCwgc3RydWN0IGNvbnRleHQgKnNyYykKK3sKKwlpbnQgcmM7CisKKwlpZiAo
IXBvbGljeWRiLnNlbGludXhfbWxzX2VuYWJsZWQpCisJCXJldHVybiAwOwor
CisJZHN0LT5yYW5nZS5sZXZlbFswXS5zZW5zID0gc3JjLT5yYW5nZS5sZXZl
bFswXS5zZW5zOworCXJjID0gZWJpdG1hcF9jcHkoJmRzdC0+cmFuZ2UubGV2
ZWxbMF0uY2F0LCAmc3JjLT5yYW5nZS5sZXZlbFswXS5jYXQpOworCWlmIChy
YykKKwkJZ290byBvdXQ7CisKKwlkc3QtPnJhbmdlLmxldmVsWzFdLnNlbnMg
PSBzcmMtPnJhbmdlLmxldmVsWzBdLnNlbnM7CisJcmMgPSBlYml0bWFwX2Nw
eSgmZHN0LT5yYW5nZS5sZXZlbFsxXS5jYXQsICZzcmMtPnJhbmdlLmxldmVs
WzBdLmNhdCk7CisJaWYgKHJjKQorCQllYml0bWFwX2Rlc3Ryb3koJmRzdC0+
cmFuZ2UubGV2ZWxbMF0uY2F0KTsKK291dDoKKwlyZXR1cm4gcmM7Cit9CisK
K2lubGluZSBpbnQgbWxzX2NvbnRleHRfY21wKHN0cnVjdCBjb250ZXh0ICpj
MSwgc3RydWN0IGNvbnRleHQgKmMyKQoreworCWlmICghcG9saWN5ZGIuc2Vs
aW51eF9tbHNfZW5hYmxlZCkKKwkJcmV0dXJuIDE7CisKKwlyZXR1cm4gYzEt
PnJhbmdlLmxldmVsWzBdLnNlbnMgPT0gYzItPnJhbmdlLmxldmVsWzBdLnNl
bnMgJiYKKwkJZWJpdG1hcF9jbXAoJmMxLT5yYW5nZS5sZXZlbFswXS5jYXQs
ICZjMi0+cmFuZ2UubGV2ZWxbMF0uY2F0KSAmJgorCQljMS0+cmFuZ2UubGV2
ZWxbMV0uc2VucyA9PSBjMi0+cmFuZ2UubGV2ZWxbMV0uc2VucyAmJgorCQll
Yml0bWFwX2NtcCgmYzEtPnJhbmdlLmxldmVsWzFdLmNhdCwgJmMyLT5yYW5n
ZS5sZXZlbFsxXS5jYXQpOworfQorCitpbmxpbmUgdm9pZCBtbHNfY29udGV4
dF9kZXN0cm95KHN0cnVjdCBwb2xpY3lkYiAqcCwgc3RydWN0IGNvbnRleHQg
KmMpCit7CisJaWYgKCFwLT5zZWxpbnV4X21sc19lbmFibGVkKQorCQlyZXR1
cm47CisKKwllYml0bWFwX2Rlc3Ryb3koJmMtPnJhbmdlLmxldmVsWzBdLmNh
dCk7CisJZWJpdG1hcF9kZXN0cm95KCZjLT5yYW5nZS5sZXZlbFsxXS5jYXQp
OworCW1sc19jb250ZXh0X2luaXQoYyk7Cit9CisKK2lubGluZSB2b2lkIGNv
bnRleHRfaW5pdChzdHJ1Y3QgY29udGV4dCAqYykKK3sKKwltZW1zZXQoYywg
MCwgc2l6ZW9mKCpjKSk7Cit9CisKK2lubGluZSBpbnQgY29udGV4dF9jcHko
c3RydWN0IGNvbnRleHQgKmRzdCwgc3RydWN0IGNvbnRleHQgKnNyYykKK3sK
KwlpbnQgcmM7CisKKwlkc3QtPnVzZXIgPSBzcmMtPnVzZXI7CisJZHN0LT5y
b2xlID0gc3JjLT5yb2xlOworCWRzdC0+dHlwZSA9IHNyYy0+dHlwZTsKKwlp
ZiAoc3JjLT5zdHIpIHsKKwkJZHN0LT5zdHIgPSBrc3RyZHVwKHNyYy0+c3Ry
LCBHRlBfQVRPTUlDKTsKKwkJaWYgKCFkc3QtPnN0cikKKwkJCXJldHVybiAt
RU5PTUVNOworCQlkc3QtPmxlbiA9IHNyYy0+bGVuOworCX0gZWxzZSB7CisJ
CWRzdC0+c3RyID0gTlVMTDsKKwkJZHN0LT5sZW4gPSAwOworCX0KKwlyYyA9
IG1sc19jb250ZXh0X2NweShkc3QsIHNyYyk7CisJaWYgKHJjKSB7CisJCWtm
cmVlKGRzdC0+c3RyKTsKKwkJcmV0dXJuIHJjOworCX0KKwlyZXR1cm4gMDsK
K30KKworaW5saW5lIHZvaWQgY29udGV4dF9kZXN0cm95KHN0cnVjdCBwb2xp
Y3lkYiAqcCwgc3RydWN0IGNvbnRleHQgKmMpCit7CisJYy0+dXNlciA9IGMt
PnJvbGUgPSBjLT50eXBlID0gMDsKKwlrZnJlZShjLT5zdHIpOworCWMtPnN0
ciA9IE5VTEw7CisJYy0+bGVuID0gMDsKKwltbHNfY29udGV4dF9kZXN0cm95
KHAsIGMpOworfQorCitpbmxpbmUgaW50IGNvbnRleHRfY21wKHN0cnVjdCBj
b250ZXh0ICpjMSwgc3RydWN0IGNvbnRleHQgKmMyKQoreworCWlmIChjMS0+
bGVuICYmIGMyLT5sZW4pCisJCXJldHVybiAoYzEtPmxlbiA9PSBjMi0+bGVu
ICYmICFzdHJjbXAoYzEtPnN0ciwgYzItPnN0cikpOworCWlmIChjMS0+bGVu
IHx8IGMyLT5sZW4pCisJCXJldHVybiAwOworCXJldHVybiAoKGMxLT51c2Vy
ID09IGMyLT51c2VyKSAmJgorCQkoYzEtPnJvbGUgPT0gYzItPnJvbGUpICYm
CisJCShjMS0+dHlwZSA9PSBjMi0+dHlwZSkgJiYKKwkJbWxzX2NvbnRleHRf
Y21wKGMxLCBjMikpOworfQorCmRpZmYgLXBydU4gc2VjdXJpdHktdGVzdGlu
Zy0yLjYvc2VjdXJpdHkvc2VsaW51eC9zcy9jb250ZXh0Lmggc2VjdXJpdHkt
dGVzdGluZy0yLjYtbmV3L3NlY3VyaXR5L3NlbGludXgvc3MvY29udGV4dC5o
Ci0tLSBzZWN1cml0eS10ZXN0aW5nLTIuNi9zZWN1cml0eS9zZWxpbnV4L3Nz
L2NvbnRleHQuaAkyMDEwLTAxLTI5IDAxOjA2OjQyLjE2MDA2MDMzMiArMDEw
MAorKysgc2VjdXJpdHktdGVzdGluZy0yLjYtbmV3L3NlY3VyaXR5L3NlbGlu
dXgvc3MvY29udGV4dC5oCTIwMTAtMDEtMzEgMjE6Mzg6MDYuNTE3MzQ5NDY0
ICswMTAwCkBAIC0xMiw2ICsxMiw3IEBACiAgKgogICogQXV0aG9yIDogU3Rl
cGhlbiBTbWFsbGV5LCA8c2RzQGVwb2NoLm5jc2MubWlsPgogICovCisKICNp
Zm5kZWYgX1NTX0NPTlRFWFRfSF8KICNkZWZpbmUgX1NTX0NPTlRFWFRfSF8K
IApAQCAtMTksNiArMjAsOCBAQAogI2luY2x1ZGUgIm1sc190eXBlcy5oIgog
I2luY2x1ZGUgInNlY3VyaXR5LmgiCiAKK2V4dGVybiBzdHJ1Y3QgcG9saWN5
ZGIgcG9saWN5ZGI7CisKIC8qCiAgKiBBIHNlY3VyaXR5IGNvbnRleHQgY29u
c2lzdHMgb2YgYW4gYXV0aGVudGljYXRlZCB1c2VyCiAgKiBpZGVudGl0eSwg
YSByb2xlLCBhIHR5cGUgYW5kIGEgTUxTIHJhbmdlLgpAQCAtMzIsMTI0ICsz
NSwxNSBAQCBzdHJ1Y3QgY29udGV4dCB7CiAJY2hhciAqc3RyOwkvKiBzdHJp
bmcgcmVwcmVzZW50YXRpb24gaWYgY29udGV4dCBjYW5ub3QgYmUgbWFwcGVk
LiAqLwogfTsKIAotc3RhdGljIGlubGluZSB2b2lkIG1sc19jb250ZXh0X2lu
aXQoc3RydWN0IGNvbnRleHQgKmMpCi17Ci0JbWVtc2V0KCZjLT5yYW5nZSwg
MCwgc2l6ZW9mKGMtPnJhbmdlKSk7Ci19Ci0KLXN0YXRpYyBpbmxpbmUgaW50
IG1sc19jb250ZXh0X2NweShzdHJ1Y3QgY29udGV4dCAqZHN0LCBzdHJ1Y3Qg
Y29udGV4dCAqc3JjKQotewotCWludCByYzsKLQotCWlmICghc2VsaW51eF9t
bHNfZW5hYmxlZCkKLQkJcmV0dXJuIDA7Ci0KLQlkc3QtPnJhbmdlLmxldmVs
WzBdLnNlbnMgPSBzcmMtPnJhbmdlLmxldmVsWzBdLnNlbnM7Ci0JcmMgPSBl
Yml0bWFwX2NweSgmZHN0LT5yYW5nZS5sZXZlbFswXS5jYXQsICZzcmMtPnJh
bmdlLmxldmVsWzBdLmNhdCk7Ci0JaWYgKHJjKQotCQlnb3RvIG91dDsKLQot
CWRzdC0+cmFuZ2UubGV2ZWxbMV0uc2VucyA9IHNyYy0+cmFuZ2UubGV2ZWxb
MV0uc2VuczsKLQlyYyA9IGViaXRtYXBfY3B5KCZkc3QtPnJhbmdlLmxldmVs
WzFdLmNhdCwgJnNyYy0+cmFuZ2UubGV2ZWxbMV0uY2F0KTsKLQlpZiAocmMp
Ci0JCWViaXRtYXBfZGVzdHJveSgmZHN0LT5yYW5nZS5sZXZlbFswXS5jYXQp
Owotb3V0OgotCXJldHVybiByYzsKLX0KLQotLyoKLSAqIFNldHMgYm90aCBs
ZXZlbHMgaW4gdGhlIE1MUyByYW5nZSBvZiAnZHN0JyB0byB0aGUgbG93IGxl
dmVsIG9mICdzcmMnLgotICovCi1zdGF0aWMgaW5saW5lIGludCBtbHNfY29u
dGV4dF9jcHlfbG93KHN0cnVjdCBjb250ZXh0ICpkc3QsIHN0cnVjdCBjb250
ZXh0ICpzcmMpCi17Ci0JaW50IHJjOwotCi0JaWYgKCFzZWxpbnV4X21sc19l
bmFibGVkKQotCQlyZXR1cm4gMDsKLQotCWRzdC0+cmFuZ2UubGV2ZWxbMF0u
c2VucyA9IHNyYy0+cmFuZ2UubGV2ZWxbMF0uc2VuczsKLQlyYyA9IGViaXRt
YXBfY3B5KCZkc3QtPnJhbmdlLmxldmVsWzBdLmNhdCwgJnNyYy0+cmFuZ2Uu
bGV2ZWxbMF0uY2F0KTsKLQlpZiAocmMpCi0JCWdvdG8gb3V0OwotCi0JZHN0
LT5yYW5nZS5sZXZlbFsxXS5zZW5zID0gc3JjLT5yYW5nZS5sZXZlbFswXS5z
ZW5zOwotCXJjID0gZWJpdG1hcF9jcHkoJmRzdC0+cmFuZ2UubGV2ZWxbMV0u
Y2F0LCAmc3JjLT5yYW5nZS5sZXZlbFswXS5jYXQpOwotCWlmIChyYykKLQkJ
ZWJpdG1hcF9kZXN0cm95KCZkc3QtPnJhbmdlLmxldmVsWzBdLmNhdCk7Ci1v
dXQ6Ci0JcmV0dXJuIHJjOwotfQotCi1zdGF0aWMgaW5saW5lIGludCBtbHNf
Y29udGV4dF9jbXAoc3RydWN0IGNvbnRleHQgKmMxLCBzdHJ1Y3QgY29udGV4
dCAqYzIpCi17Ci0JaWYgKCFzZWxpbnV4X21sc19lbmFibGVkKQotCQlyZXR1
cm4gMTsKLQotCXJldHVybiAoKGMxLT5yYW5nZS5sZXZlbFswXS5zZW5zID09
IGMyLT5yYW5nZS5sZXZlbFswXS5zZW5zKSAmJgotCQllYml0bWFwX2NtcCgm
YzEtPnJhbmdlLmxldmVsWzBdLmNhdCwgJmMyLT5yYW5nZS5sZXZlbFswXS5j
YXQpICYmCi0JCShjMS0+cmFuZ2UubGV2ZWxbMV0uc2VucyA9PSBjMi0+cmFu
Z2UubGV2ZWxbMV0uc2VucykgJiYKLQkJZWJpdG1hcF9jbXAoJmMxLT5yYW5n
ZS5sZXZlbFsxXS5jYXQsICZjMi0+cmFuZ2UubGV2ZWxbMV0uY2F0KSk7Ci19
Ci0KLXN0YXRpYyBpbmxpbmUgdm9pZCBtbHNfY29udGV4dF9kZXN0cm95KHN0
cnVjdCBjb250ZXh0ICpjKQotewotCWlmICghc2VsaW51eF9tbHNfZW5hYmxl
ZCkKLQkJcmV0dXJuOwotCi0JZWJpdG1hcF9kZXN0cm95KCZjLT5yYW5nZS5s
ZXZlbFswXS5jYXQpOwotCWViaXRtYXBfZGVzdHJveSgmYy0+cmFuZ2UubGV2
ZWxbMV0uY2F0KTsKLQltbHNfY29udGV4dF9pbml0KGMpOwotfQotCi1zdGF0
aWMgaW5saW5lIHZvaWQgY29udGV4dF9pbml0KHN0cnVjdCBjb250ZXh0ICpj
KQotewotCW1lbXNldChjLCAwLCBzaXplb2YoKmMpKTsKLX0KLQotc3RhdGlj
IGlubGluZSBpbnQgY29udGV4dF9jcHkoc3RydWN0IGNvbnRleHQgKmRzdCwg
c3RydWN0IGNvbnRleHQgKnNyYykKLXsKLQlpbnQgcmM7Ci0KLQlkc3QtPnVz
ZXIgPSBzcmMtPnVzZXI7Ci0JZHN0LT5yb2xlID0gc3JjLT5yb2xlOwotCWRz
dC0+dHlwZSA9IHNyYy0+dHlwZTsKLQlpZiAoc3JjLT5zdHIpIHsKLQkJZHN0
LT5zdHIgPSBrc3RyZHVwKHNyYy0+c3RyLCBHRlBfQVRPTUlDKTsKLQkJaWYg
KCFkc3QtPnN0cikKLQkJCXJldHVybiAtRU5PTUVNOwotCQlkc3QtPmxlbiA9
IHNyYy0+bGVuOwotCX0gZWxzZSB7Ci0JCWRzdC0+c3RyID0gTlVMTDsKLQkJ
ZHN0LT5sZW4gPSAwOwotCX0KLQlyYyA9IG1sc19jb250ZXh0X2NweShkc3Qs
IHNyYyk7Ci0JaWYgKHJjKSB7Ci0JCWtmcmVlKGRzdC0+c3RyKTsKLQkJcmV0
dXJuIHJjOwotCX0KLQlyZXR1cm4gMDsKLX0KLQotc3RhdGljIGlubGluZSB2
b2lkIGNvbnRleHRfZGVzdHJveShzdHJ1Y3QgY29udGV4dCAqYykKLXsKLQlj
LT51c2VyID0gYy0+cm9sZSA9IGMtPnR5cGUgPSAwOwotCWtmcmVlKGMtPnN0
cik7Ci0JYy0+c3RyID0gTlVMTDsKLQljLT5sZW4gPSAwOwotCW1sc19jb250
ZXh0X2Rlc3Ryb3koYyk7Ci19Ci0KLXN0YXRpYyBpbmxpbmUgaW50IGNvbnRl
eHRfY21wKHN0cnVjdCBjb250ZXh0ICpjMSwgc3RydWN0IGNvbnRleHQgKmMy
KQotewotCWlmIChjMS0+bGVuICYmIGMyLT5sZW4pCi0JCXJldHVybiAoYzEt
PmxlbiA9PSBjMi0+bGVuICYmICFzdHJjbXAoYzEtPnN0ciwgYzItPnN0cikp
OwotCWlmIChjMS0+bGVuIHx8IGMyLT5sZW4pCi0JCXJldHVybiAwOwotCXJl
dHVybiAoKGMxLT51c2VyID09IGMyLT51c2VyKSAmJgotCQkoYzEtPnJvbGUg
PT0gYzItPnJvbGUpICYmCi0JCShjMS0+dHlwZSA9PSBjMi0+dHlwZSkgJiYK
LQkJbWxzX2NvbnRleHRfY21wKGMxLCBjMikpOwotfQoraW5saW5lIHZvaWQg
bWxzX2NvbnRleHRfaW5pdChzdHJ1Y3QgY29udGV4dCAqYyk7CitpbmxpbmUg
aW50IG1sc19jb250ZXh0X2NweShzdHJ1Y3QgY29udGV4dCAqZHN0LCBzdHJ1
Y3QgY29udGV4dCAqc3JjKTsKK2lubGluZSBpbnQgbWxzX2NvbnRleHRfY3B5
X2xvdyhzdHJ1Y3QgY29udGV4dCAqZHN0LCBzdHJ1Y3QgY29udGV4dCAqc3Jj
KTsKK2lubGluZSBpbnQgbWxzX2NvbnRleHRfY21wKHN0cnVjdCBjb250ZXh0
ICpjMSwgc3RydWN0IGNvbnRleHQgKmMyKTsKK2lubGluZSB2b2lkIG1sc19j
b250ZXh0X2Rlc3Ryb3koc3RydWN0IHBvbGljeWRiICpwLCBzdHJ1Y3QgY29u
dGV4dCAqYyk7CitpbmxpbmUgdm9pZCBjb250ZXh0X2luaXQoc3RydWN0IGNv
bnRleHQgKmMpOworaW5saW5lIGludCBjb250ZXh0X2NweShzdHJ1Y3QgY29u
dGV4dCAqZHN0LCBzdHJ1Y3QgY29udGV4dCAqc3JjKTsKK2lubGluZSB2b2lk
IGNvbnRleHRfZGVzdHJveShzdHJ1Y3QgcG9saWN5ZGIgKnAsIHN0cnVjdCBj
b250ZXh0ICpjKTsKK2lubGluZSBpbnQgY29udGV4dF9jbXAoc3RydWN0IGNv
bnRleHQgKmMxLCBzdHJ1Y3QgY29udGV4dCAqYzIpOwogCiAjZW5kaWYJLyog
X1NTX0NPTlRFWFRfSF8gKi8KIApkaWZmIC1wcnVOIHNlY3VyaXR5LXRlc3Rp
bmctMi42L3NlY3VyaXR5L3NlbGludXgvc3MvbWxzLmMgc2VjdXJpdHktdGVz
dGluZy0yLjYtbmV3L3NlY3VyaXR5L3NlbGludXgvc3MvbWxzLmMKLS0tIHNl
Y3VyaXR5LXRlc3RpbmctMi42L3NlY3VyaXR5L3NlbGludXgvc3MvbWxzLmMJ
MjAxMC0wMS0yOSAwMjowMjo0Ny43MzkwNDYxNzcgKzAxMDAKKysrIHNlY3Vy
aXR5LXRlc3RpbmctMi42LW5ldy9zZWN1cml0eS9zZWxpbnV4L3NzL21scy5j
CTIwMTAtMDEtMzEgMjE6NDk6MzguNzA0MzQ4MzEwICswMTAwCkBAIC0zOSw3
ICszOSw3IEBAIGludCBtbHNfY29tcHV0ZV9jb250ZXh0X2xlbihzdHJ1Y3Qg
Y29udGUKIAlzdHJ1Y3QgZWJpdG1hcCAqZTsKIAlzdHJ1Y3QgZWJpdG1hcF9u
b2RlICpub2RlOwogCi0JaWYgKCFzZWxpbnV4X21sc19lbmFibGVkKQorCWlm
ICghcG9saWN5ZGIuc2VsaW51eF9tbHNfZW5hYmxlZCkKIAkJcmV0dXJuIDA7
CiAKIAlsZW4gPSAxOyAvKiBmb3IgdGhlIGJlZ2lubmluZyAiOiIgKi8KQEAg
LTkzLDcgKzkzLDcgQEAgdm9pZCBtbHNfc2lkX3RvX2NvbnRleHQoc3RydWN0
IGNvbnRleHQgKgogCXN0cnVjdCBlYml0bWFwICplOwogCXN0cnVjdCBlYml0
bWFwX25vZGUgKm5vZGU7CiAKLQlpZiAoIXNlbGludXhfbWxzX2VuYWJsZWQp
CisJaWYgKCFwb2xpY3lkYi5zZWxpbnV4X21sc19lbmFibGVkKQogCQlyZXR1
cm47CiAKIAlzY29udGV4dHAgPSAqc2NvbnRleHQ7CkBAIC0yMDAsNyArMjAw
LDcgQEAgaW50IG1sc19jb250ZXh0X2lzdmFsaWQoc3RydWN0IHBvbGljeWRi
IAogewogCXN0cnVjdCB1c2VyX2RhdHVtICp1c3JkYXR1bTsKIAotCWlmICgh
c2VsaW51eF9tbHNfZW5hYmxlZCkKKwlpZiAoIXAtPnNlbGludXhfbWxzX2Vu
YWJsZWQpCiAJCXJldHVybiAxOwogCiAJaWYgKCFtbHNfcmFuZ2VfaXN2YWxp
ZChwLCAmYy0+cmFuZ2UpKQpAQCAtMjUzLDcgKzI1Myw3IEBAIGludCBtbHNf
Y29udGV4dF90b19zaWQoc3RydWN0IHBvbGljeWRiICoKIAlzdHJ1Y3QgY2F0
X2RhdHVtICpjYXRkYXR1bSwgKnJuZ2RhdHVtOwogCWludCBsLCByYyA9IC1F
SU5WQUw7CiAKLQlpZiAoIXNlbGludXhfbWxzX2VuYWJsZWQpIHsKKwlpZiAo
IXBvbC0+c2VsaW51eF9tbHNfZW5hYmxlZCkgewogCQlpZiAoZGVmX3NpZCAh
PSBTRUNTSURfTlVMTCAmJiBvbGRjKQogCQkJKnNjb250ZXh0ICs9IHN0cmxl
bigqc2NvbnRleHQpKzE7CiAJCXJldHVybiAwOwpAQCAtMzg3LDcgKzM4Nyw3
IEBAIGludCBtbHNfZnJvbV9zdHJpbmcoY2hhciAqc3RyLCBzdHJ1Y3QgY28K
IAljaGFyICp0bXBzdHIsICpmcmVlc3RyOwogCWludCByYzsKIAotCWlmICgh
c2VsaW51eF9tbHNfZW5hYmxlZCkKKwlpZiAoIXBvbGljeWRiLnNlbGludXhf
bWxzX2VuYWJsZWQpCiAJCXJldHVybiAtRUlOVkFMOwogCiAJLyogd2UgbmVl
ZCBmcmVlc3RyIGJlY2F1c2UgbWxzX2NvbnRleHRfdG9fc2lkIHdpbGwgY2hh
bmdlCkBAIC00MDcsNyArNDA3LDcgQEAgaW50IG1sc19mcm9tX3N0cmluZyhj
aGFyICpzdHIsIHN0cnVjdCBjbwogLyoKICAqIENvcGllcyB0aGUgTUxTIHJh
bmdlIGByYW5nZScgaW50byBgY29udGV4dCcuCiAgKi8KLXN0YXRpYyBpbmxp
bmUgaW50IG1sc19yYW5nZV9zZXQoc3RydWN0IGNvbnRleHQgKmNvbnRleHQs
CitpbmxpbmUgaW50IG1sc19yYW5nZV9zZXQoc3RydWN0IGNvbnRleHQgKmNv
bnRleHQsCiAJCQkJc3RydWN0IG1sc19yYW5nZSAqcmFuZ2UpCiB7CiAJaW50
IGwsIHJjID0gMDsKQEAgLTQyNyw3ICs0MjcsNyBAQCBzdGF0aWMgaW5saW5l
IGludCBtbHNfcmFuZ2Vfc2V0KHN0cnVjdCBjCiBpbnQgbWxzX3NldHVwX3Vz
ZXJfcmFuZ2Uoc3RydWN0IGNvbnRleHQgKmZyb21jb24sIHN0cnVjdCB1c2Vy
X2RhdHVtICp1c2VyLAogCQkJIHN0cnVjdCBjb250ZXh0ICp1c2VyY29uKQog
ewotCWlmIChzZWxpbnV4X21sc19lbmFibGVkKSB7CisJaWYgKHBvbGljeWRi
LnNlbGludXhfbWxzX2VuYWJsZWQpIHsKIAkJc3RydWN0IG1sc19sZXZlbCAq
ZnJvbWNvbl9zZW4gPSAmKGZyb21jb24tPnJhbmdlLmxldmVsWzBdKTsKIAkJ
c3RydWN0IG1sc19sZXZlbCAqZnJvbWNvbl9jbHIgPSAmKGZyb21jb24tPnJh
bmdlLmxldmVsWzFdKTsKIAkJc3RydWN0IG1sc19sZXZlbCAqdXNlcl9sb3cg
PSAmKHVzZXItPnJhbmdlLmxldmVsWzBdKTsKQEAgLTQ3Nyw3ICs0NzcsNyBA
QCBpbnQgbWxzX2NvbnZlcnRfY29udGV4dChzdHJ1Y3QgcG9saWN5ZGIgCiAJ
c3RydWN0IGViaXRtYXBfbm9kZSAqbm9kZTsKIAlpbnQgbCwgaTsKIAotCWlm
ICghc2VsaW51eF9tbHNfZW5hYmxlZCkKKwlpZiAoIXBvbGljeWRiLnNlbGlu
dXhfbWxzX2VuYWJsZWQpCiAJCXJldHVybiAwOwogCiAJZm9yIChsID0gMDsg
bCA8IDI7IGwrKykgewpAQCAtNTE2LDcgKzUxNiw3IEBAIGludCBtbHNfY29t
cHV0ZV9zaWQoc3RydWN0IGNvbnRleHQgKnNjb24KIAlzdHJ1Y3QgcmFuZ2Vf
dHJhbnMgcnRyOwogCXN0cnVjdCBtbHNfcmFuZ2UgKnI7CiAKLQlpZiAoIXNl
bGludXhfbWxzX2VuYWJsZWQpCisJaWYgKCFwb2xpY3lkYi5zZWxpbnV4X21s
c19lbmFibGVkKQogCQlyZXR1cm4gMDsKIAogCXN3aXRjaCAoc3BlY2lmaWVk
KSB7CkBAIC01NTksNyArNTU5LDcgQEAgaW50IG1sc19jb21wdXRlX3NpZChz
dHJ1Y3QgY29udGV4dCAqc2Nvbgogdm9pZCBtbHNfZXhwb3J0X25ldGxibF9s
dmwoc3RydWN0IGNvbnRleHQgKmNvbnRleHQsCiAJCQkgICBzdHJ1Y3QgbmV0
bGJsX2xzbV9zZWNhdHRyICpzZWNhdHRyKQogewotCWlmICghc2VsaW51eF9t
bHNfZW5hYmxlZCkKKwlpZiAoIXBvbGljeWRiLnNlbGludXhfbWxzX2VuYWJs
ZWQpCiAJCXJldHVybjsKIAogCXNlY2F0dHItPmF0dHIubWxzLmx2bCA9IGNv
bnRleHQtPnJhbmdlLmxldmVsWzBdLnNlbnMgLSAxOwpAQCAtNTc5LDcgKzU3
OSw3IEBAIHZvaWQgbWxzX2V4cG9ydF9uZXRsYmxfbHZsKHN0cnVjdCBjb250
ZXgKIHZvaWQgbWxzX2ltcG9ydF9uZXRsYmxfbHZsKHN0cnVjdCBjb250ZXh0
ICpjb250ZXh0LAogCQkJICAgc3RydWN0IG5ldGxibF9sc21fc2VjYXR0ciAq
c2VjYXR0cikKIHsKLQlpZiAoIXNlbGludXhfbWxzX2VuYWJsZWQpCisJaWYg
KCFwb2xpY3lkYi5zZWxpbnV4X21sc19lbmFibGVkKQogCQlyZXR1cm47CiAK
IAljb250ZXh0LT5yYW5nZS5sZXZlbFswXS5zZW5zID0gc2VjYXR0ci0+YXR0
ci5tbHMubHZsICsgMTsKQEAgLTYwMSw3ICs2MDEsNyBAQCBpbnQgbWxzX2V4
cG9ydF9uZXRsYmxfY2F0KHN0cnVjdCBjb250ZXh0CiB7CiAJaW50IHJjOwog
Ci0JaWYgKCFzZWxpbnV4X21sc19lbmFibGVkKQorCWlmICghcG9saWN5ZGIu
c2VsaW51eF9tbHNfZW5hYmxlZCkKIAkJcmV0dXJuIDA7CiAKIAlyYyA9IGVi
aXRtYXBfbmV0bGJsX2V4cG9ydCgmY29udGV4dC0+cmFuZ2UubGV2ZWxbMF0u
Y2F0LApAQCAtNjI5LDcgKzYyOSw3IEBAIGludCBtbHNfaW1wb3J0X25ldGxi
bF9jYXQoc3RydWN0IGNvbnRleHQKIHsKIAlpbnQgcmM7CiAKLQlpZiAoIXNl
bGludXhfbWxzX2VuYWJsZWQpCisJaWYgKCFwb2xpY3lkYi5zZWxpbnV4X21s
c19lbmFibGVkKQogCQlyZXR1cm4gMDsKIAogCXJjID0gZWJpdG1hcF9uZXRs
YmxfaW1wb3J0KCZjb250ZXh0LT5yYW5nZS5sZXZlbFswXS5jYXQsCmRpZmYg
LXBydU4gc2VjdXJpdHktdGVzdGluZy0yLjYvc2VjdXJpdHkvc2VsaW51eC9z
cy9tbHMuaCBzZWN1cml0eS10ZXN0aW5nLTIuNi1uZXcvc2VjdXJpdHkvc2Vs
aW51eC9zcy9tbHMuaAotLS0gc2VjdXJpdHktdGVzdGluZy0yLjYvc2VjdXJp
dHkvc2VsaW51eC9zcy9tbHMuaAkyMDEwLTAxLTI5IDAxOjA2OjQyLjE2ODA1
MTQzMSArMDEwMAorKysgc2VjdXJpdHktdGVzdGluZy0yLjYtbmV3L3NlY3Vy
aXR5L3NlbGludXgvc3MvbWxzLmgJMjAxMC0wMS0zMSAyMTo1MDoxNy45MjMz
MzA5ODAgKzAxMDAKQEAgLTI0LDYgKzI0LDggQEAKICNpbmNsdWRlICJjb250
ZXh0LmgiCiAjaW5jbHVkZSAicG9saWN5ZGIuaCIKIAorZXh0ZXJuIHN0cnVj
dCBwb2xpY3lkYiBwb2xpY3lkYjsKKwogaW50IG1sc19jb21wdXRlX2NvbnRl
eHRfbGVuKHN0cnVjdCBjb250ZXh0ICpjb250ZXh0KTsKIHZvaWQgbWxzX3Np
ZF90b19jb250ZXh0KHN0cnVjdCBjb250ZXh0ICpjb250ZXh0LCBjaGFyICoq
c2NvbnRleHQpOwogaW50IG1sc19jb250ZXh0X2lzdmFsaWQoc3RydWN0IHBv
bGljeWRiICpwLCBzdHJ1Y3QgY29udGV4dCAqYyk7CkBAIC0zOSw2ICs0MSw4
IEBAIGludCBtbHNfY29udGV4dF90b19zaWQoc3RydWN0IHBvbGljeWRiICoK
IAogaW50IG1sc19mcm9tX3N0cmluZyhjaGFyICpzdHIsIHN0cnVjdCBjb250
ZXh0ICpjb250ZXh0LCBnZnBfdCBnZnBfbWFzayk7CiAKK2lubGluZSBpbnQg
bWxzX3JhbmdlX3NldChzdHJ1Y3QgY29udGV4dCAqY29udGV4dCwgc3RydWN0
IG1sc19yYW5nZSAqcmFuZ2UpOworCiBpbnQgbWxzX2NvbnZlcnRfY29udGV4
dChzdHJ1Y3QgcG9saWN5ZGIgKm9sZHAsCiAJCQlzdHJ1Y3QgcG9saWN5ZGIg
Km5ld3AsCiAJCQlzdHJ1Y3QgY29udGV4dCAqY29udGV4dCk7CmRpZmYgLXBy
dU4gc2VjdXJpdHktdGVzdGluZy0yLjYvc2VjdXJpdHkvc2VsaW51eC9zcy9t
bHNfdHlwZXMuYyBzZWN1cml0eS10ZXN0aW5nLTIuNi1uZXcvc2VjdXJpdHkv
c2VsaW51eC9zcy9tbHNfdHlwZXMuYwotLS0gc2VjdXJpdHktdGVzdGluZy0y
LjYvc2VjdXJpdHkvc2VsaW51eC9zcy9tbHNfdHlwZXMuYwkxOTcwLTAxLTAx
IDAxOjAwOjAwLjAwMDAwMDAwMCArMDEwMAorKysgc2VjdXJpdHktdGVzdGlu
Zy0yLjYtbmV3L3NlY3VyaXR5L3NlbGludXgvc3MvbWxzX3R5cGVzLmMJMjAx
MC0wMS0yOSAwMjozNjo0OS41MjgwNDUwNDEgKzAxMDAKQEAgLTAsMCArMSwy
NyBAQAorLyoKKyAqIEF1eGlsaWFyeSBmdW5jdGlvbnMgZm9yIHRoZSBtdWx0
aS1sZXZlbCBzZWN1cml0eSAoTUxTKSBwb2xpY3kuCisgKgorICogQXV0aG9y
IDogU3RlcGhlbiBTbWFsbGV5LCA8c2RzQGVwb2NoLm5jc2MubWlsPgorICov
CisKKyNpbmNsdWRlICJtbHNfdHlwZXMuaCIKKyNpbmNsdWRlICJwb2xpY3lk
Yi5oIgorCitpbmxpbmUgaW50IG1sc19sZXZlbF9lcShzdHJ1Y3QgbWxzX2xl
dmVsICpsMSwgc3RydWN0IG1sc19sZXZlbCAqbDIpCit7CisJaWYgKCFwb2xp
Y3lkYi5zZWxpbnV4X21sc19lbmFibGVkKQorCQlyZXR1cm4gMTsKKworCXJl
dHVybiAoKGwxLT5zZW5zID09IGwyLT5zZW5zKSAmJgorCQllYml0bWFwX2Nt
cCgmbDEtPmNhdCwgJmwyLT5jYXQpKTsKK30KKworaW5saW5lIGludCBtbHNf
bGV2ZWxfZG9tKHN0cnVjdCBtbHNfbGV2ZWwgKmwxLCBzdHJ1Y3QgbWxzX2xl
dmVsICpsMikKK3sKKwlpZiAoIXBvbGljeWRiLnNlbGludXhfbWxzX2VuYWJs
ZWQpCisJCXJldHVybiAxOworCisJcmV0dXJuICgobDEtPnNlbnMgPj0gbDIt
PnNlbnMpICYmCisJCWViaXRtYXBfY29udGFpbnMoJmwxLT5jYXQsICZsMi0+
Y2F0KSk7Cit9CisKZGlmZiAtcHJ1TiBzZWN1cml0eS10ZXN0aW5nLTIuNi9z
ZWN1cml0eS9zZWxpbnV4L3NzL21sc190eXBlcy5oIHNlY3VyaXR5LXRlc3Rp
bmctMi42LW5ldy9zZWN1cml0eS9zZWxpbnV4L3NzL21sc190eXBlcy5oCi0t
LSBzZWN1cml0eS10ZXN0aW5nLTIuNi9zZWN1cml0eS9zZWxpbnV4L3NzL21s
c190eXBlcy5oCTIwMTAtMDEtMjkgMDE6MDY6NDIuMTY4MDUxNDMxICswMTAw
CisrKyBzZWN1cml0eS10ZXN0aW5nLTIuNi1uZXcvc2VjdXJpdHkvc2VsaW51
eC9zcy9tbHNfdHlwZXMuaAkyMDEwLTAxLTI5IDAyOjIzOjM5LjAxNzA0NDM4
NyArMDEwMApAQCAtMTQsNyArMTQsOSBAQAogI2lmbmRlZiBfU1NfTUxTX1RZ
UEVTX0hfCiAjZGVmaW5lIF9TU19NTFNfVFlQRVNfSF8KIAotI2luY2x1ZGUg
InNlY3VyaXR5LmgiCisjaW5jbHVkZSAiZWJpdG1hcC5oIgorCitleHRlcm4g
c3RydWN0IHBvbGljeWRiIHBvbGljeWRiOwogCiBzdHJ1Y3QgbWxzX2xldmVs
IHsKIAl1MzIgc2VuczsJCS8qIHNlbnNpdGl2aXR5ICovCkBAIC0yNSwyMyAr
MjcsOCBAQCBzdHJ1Y3QgbWxzX3JhbmdlIHsKIAlzdHJ1Y3QgbWxzX2xldmVs
IGxldmVsWzJdOyAvKiBsb3cgPT0gbGV2ZWxbMF0sIGhpZ2ggPT0gbGV2ZWxb
MV0gKi8KIH07CiAKLXN0YXRpYyBpbmxpbmUgaW50IG1sc19sZXZlbF9lcShz
dHJ1Y3QgbWxzX2xldmVsICpsMSwgc3RydWN0IG1sc19sZXZlbCAqbDIpCi17
Ci0JaWYgKCFzZWxpbnV4X21sc19lbmFibGVkKQotCQlyZXR1cm4gMTsKLQot
CXJldHVybiAoKGwxLT5zZW5zID09IGwyLT5zZW5zKSAmJgotCQllYml0bWFw
X2NtcCgmbDEtPmNhdCwgJmwyLT5jYXQpKTsKLX0KLQotc3RhdGljIGlubGlu
ZSBpbnQgbWxzX2xldmVsX2RvbShzdHJ1Y3QgbWxzX2xldmVsICpsMSwgc3Ry
dWN0IG1sc19sZXZlbCAqbDIpCi17Ci0JaWYgKCFzZWxpbnV4X21sc19lbmFi
bGVkKQotCQlyZXR1cm4gMTsKLQotCXJldHVybiAoKGwxLT5zZW5zID49IGwy
LT5zZW5zKSAmJgotCQllYml0bWFwX2NvbnRhaW5zKCZsMS0+Y2F0LCAmbDIt
PmNhdCkpOwotfQoraW5saW5lIGludCBtbHNfbGV2ZWxfZXEoc3RydWN0IG1s
c19sZXZlbCAqbDEsIHN0cnVjdCBtbHNfbGV2ZWwgKmwyKTsKK2lubGluZSBp
bnQgbWxzX2xldmVsX2RvbShzdHJ1Y3QgbWxzX2xldmVsICpsMSwgc3RydWN0
IG1sc19sZXZlbCAqbDIpOwogCiAjZGVmaW5lIG1sc19sZXZlbF9pbmNvbXAo
bDEsIGwyKSBcCiAoIW1sc19sZXZlbF9kb20oKGwxKSwgKGwyKSkgJiYgIW1s
c19sZXZlbF9kb20oKGwyKSwgKGwxKSkpCmRpZmYgLXBydU4gc2VjdXJpdHkt
dGVzdGluZy0yLjYvc2VjdXJpdHkvc2VsaW51eC9zcy9wb2xpY3lkYi5jIHNl
Y3VyaXR5LXRlc3RpbmctMi42LW5ldy9zZWN1cml0eS9zZWxpbnV4L3NzL3Bv
bGljeWRiLmMKLS0tIHNlY3VyaXR5LXRlc3RpbmctMi42L3NlY3VyaXR5L3Nl
bGludXgvc3MvcG9saWN5ZGIuYwkyMDEwLTAxLTI5IDAyOjAyOjQ3Ljc0MDA0
NjA3NyArMDEwMAorKysgc2VjdXJpdHktdGVzdGluZy0yLjYtbmV3L3NlY3Vy
aXR5L3NlbGludXgvc3MvcG9saWN5ZGIuYwkyMDEwLTAxLTMxIDIxOjQxOjQ0
LjMwNjMyNzg4MiArMDEwMApAQCAtNTIsOCArNTIsNiBAQCBzdGF0aWMgY2hh
ciAqc3ltdGFiX25hbWVbU1lNX05VTV0gPSB7CiB9OwogI2VuZGlmCiAKLWlu
dCBzZWxpbnV4X21sc19lbmFibGVkOwotCiBzdGF0aWMgdW5zaWduZWQgaW50
IHN5bXRhYl9zaXplc1tTWU1fTlVNXSA9IHsKIAkyLAogCTMyLApAQCAtNDU1
LDcgKzQ1Myw3IEBAIHN0YXRpYyBpbnQgcG9saWN5ZGJfaW5kZXhfb3RoZXJz
KHN0cnVjdCAKIAogCXByaW50ayhLRVJOX0RFQlVHICJTRUxpbnV4OiAgJWQg
dXNlcnMsICVkIHJvbGVzLCAlZCB0eXBlcywgJWQgYm9vbHMiLAogCSAgICAg
ICBwLT5wX3VzZXJzLm5wcmltLCBwLT5wX3JvbGVzLm5wcmltLCBwLT5wX3R5
cGVzLm5wcmltLCBwLT5wX2Jvb2xzLm5wcmltKTsKLQlpZiAoc2VsaW51eF9t
bHNfZW5hYmxlZCkKKwlpZiAocC0+c2VsaW51eF9tbHNfZW5hYmxlZCkKIAkJ
cHJpbnRrKCIsICVkIHNlbnMsICVkIGNhdHMiLCBwLT5wX2xldmVscy5ucHJp
bSwKIAkJICAgICAgIHAtPnBfY2F0cy5ucHJpbSk7CiAJcHJpbnRrKCJcbiIp
OwpAQCAtNjU2LDEwICs2NTQsMTAgQEAgc3RhdGljIGludCByYW5nZV90cl9k
ZXN0cm95KHZvaWQgKmtleSwgdgogCXJldHVybiAwOwogfQogCi1zdGF0aWMg
dm9pZCBvY29udGV4dF9kZXN0cm95KHN0cnVjdCBvY29udGV4dCAqYywgaW50
IGkpCitzdGF0aWMgdm9pZCBvY29udGV4dF9kZXN0cm95KHN0cnVjdCBwb2xp
Y3lkYiAqcCwgc3RydWN0IG9jb250ZXh0ICpjLCBpbnQgaSkKIHsKLQljb250
ZXh0X2Rlc3Ryb3koJmMtPmNvbnRleHRbMF0pOwotCWNvbnRleHRfZGVzdHJv
eSgmYy0+Y29udGV4dFsxXSk7CisJY29udGV4dF9kZXN0cm95KHAsICZjLT5j
b250ZXh0WzBdKTsKKwljb250ZXh0X2Rlc3Ryb3kocCwgJmMtPmNvbnRleHRb
MV0pOwogCWlmIChpID09IE9DT05fSVNJRCB8fCBpID09IE9DT05fRlMgfHwK
IAkgICAgaSA9PSBPQ09OX05FVElGIHx8IGkgPT0gT0NPTl9GU1VTRSkKIAkJ
a2ZyZWUoYy0+dS5uYW1lKTsKQEAgLTY5OSw3ICs2OTcsNyBAQCB2b2lkIHBv
bGljeWRiX2Rlc3Ryb3koc3RydWN0IHBvbGljeWRiICpwCiAJCXdoaWxlIChj
KSB7CiAJCQljdG1wID0gYzsKIAkJCWMgPSBjLT5uZXh0OwotCQkJb2NvbnRl
eHRfZGVzdHJveShjdG1wLCBpKTsKKwkJCW9jb250ZXh0X2Rlc3Ryb3kocCwg
Y3RtcCwgaSk7CiAJCX0KIAkJcC0+b2NvbnRleHRzW2ldID0gTlVMTDsKIAl9
CkBAIC03MTIsNyArNzEwLDcgQEAgdm9pZCBwb2xpY3lkYl9kZXN0cm95KHN0
cnVjdCBwb2xpY3lkYiAqcAogCQl3aGlsZSAoYykgewogCQkJY3RtcCA9IGM7
CiAJCQljID0gYy0+bmV4dDsKLQkJCW9jb250ZXh0X2Rlc3Ryb3koY3RtcCwg
T0NPTl9GU1VTRSk7CisJCQlvY29udGV4dF9kZXN0cm95KHAsIGN0bXAsIE9D
T05fRlNVU0UpOwogCQl9CiAJCWd0bXAgPSBnOwogCQlnID0gZy0+bmV4dDsK
QEAgLTk0Miw3ICs5NDAsNyBAQCBzdGF0aWMgaW50IGNvbnRleHRfcmVhZF9h
bmRfdmFsaWRhdGUoc3RyCiAKIAlpZiAoIXBvbGljeWRiX2NvbnRleHRfaXN2
YWxpZChwLCBjKSkgewogCQlwcmludGsoS0VSTl9FUlIgIlNFTGludXg6ICBp
bnZhbGlkIHNlY3VyaXR5IGNvbnRleHRcbiIpOwotCQljb250ZXh0X2Rlc3Ry
b3koYyk7CisJCWNvbnRleHRfZGVzdHJveShwLCBjKTsKIAkJcmMgPSAtRUlO
VkFMOwogCX0KIG91dDoKQEAgLTE3ODcsMTIgKzE3ODUsNyBAQCBpbnQgcG9s
aWN5ZGJfcmVhZChzdHJ1Y3QgcG9saWN5ZGIgKnAsIHZvCiAJfQogCiAJaWYg
KChsZTMyX3RvX2NwdShidWZbMV0pICYgUE9MSUNZREJfQ09ORklHX01MUykp
IHsKLQkJaWYgKHNzX2luaXRpYWxpemVkICYmICFzZWxpbnV4X21sc19lbmFi
bGVkKSB7Ci0JCQlwcmludGsoS0VSTl9FUlIgIlNFTGludXg6IENhbm5vdCBz
d2l0Y2ggYmV0d2VlbiBub24tTUxTIgotCQkJCSIgYW5kIE1MUyBwb2xpY2ll
c1xuIik7Ci0JCQlnb3RvIGJhZDsKLQkJfQotCQlzZWxpbnV4X21sc19lbmFi
bGVkID0gMTsKKwkJcC0+c2VsaW51eF9tbHNfZW5hYmxlZCA9IDE7CiAJCWNv
bmZpZyB8PSBQT0xJQ1lEQl9DT05GSUdfTUxTOwogCiAJCWlmIChwLT5wb2xp
Y3l2ZXJzIDwgUE9MSUNZREJfVkVSU0lPTl9NTFMpIHsKQEAgLTE4MDEsMTIg
KzE3OTQsNiBAQCBpbnQgcG9saWN5ZGJfcmVhZChzdHJ1Y3QgcG9saWN5ZGIg
KnAsIHZvCiAJCQkJcC0+cG9saWN5dmVycyk7CiAJCQlnb3RvIGJhZDsKIAkJ
fQotCX0gZWxzZSB7Ci0JCWlmIChzc19pbml0aWFsaXplZCAmJiBzZWxpbnV4
X21sc19lbmFibGVkKSB7Ci0JCQlwcmludGsoS0VSTl9FUlIgIlNFTGludXg6
IENhbm5vdCBzd2l0Y2ggYmV0d2VlbiBNTFMgYW5kIgotCQkJCSIgbm9uLU1M
UyBwb2xpY2llc1xuIik7Ci0JCQlnb3RvIGJhZDsKLQkJfQogCX0KIAlwLT5y
ZWplY3RfdW5rbm93biA9ICEhKGxlMzJfdG9fY3B1KGJ1ZlsxXSkgJiBSRUpF
Q1RfVU5LTk9XTik7CiAJcC0+YWxsb3dfdW5rbm93biA9ICEhKGxlMzJfdG9f
Y3B1KGJ1ZlsxXSkgJiBBTExPV19VTktOT1dOKTsKQEAgLTIyMzQsNyArMjIy
MSw3IEBAIGludCBwb2xpY3lkYl9yZWFkKHN0cnVjdCBwb2xpY3lkYiAqcCwg
dm8KIG91dDoKIAlyZXR1cm4gcmM7CiBiYWRfbmV3YzoKLQlvY29udGV4dF9k
ZXN0cm95KG5ld2MsIE9DT05fRlNVU0UpOworCW9jb250ZXh0X2Rlc3Ryb3ko
cCwgbmV3YywgT0NPTl9GU1VTRSk7CiBiYWQ6CiAJaWYgKCFyYykKIAkJcmMg
PSAtRUlOVkFMOwpkaWZmIC1wcnVOIHNlY3VyaXR5LXRlc3RpbmctMi42L3Nl
Y3VyaXR5L3NlbGludXgvc3MvcG9saWN5ZGIuaCBzZWN1cml0eS10ZXN0aW5n
LTIuNi1uZXcvc2VjdXJpdHkvc2VsaW51eC9zcy9wb2xpY3lkYi5oCi0tLSBz
ZWN1cml0eS10ZXN0aW5nLTIuNi9zZWN1cml0eS9zZWxpbnV4L3NzL3BvbGlj
eWRiLmgJMjAxMC0wMS0yOSAwMjowMjo0Ny43NDAwNDYwNzcgKzAxMDAKKysr
IHNlY3VyaXR5LXRlc3RpbmctMi42LW5ldy9zZWN1cml0eS9zZWxpbnV4L3Nz
L3BvbGljeWRiLmgJMjAxMC0wMS0yOSAwMjozMzowMS4zOTMwNDU5MzQgKzAx
MDAKQEAgLTE4NSw2ICsxODUsOCBAQCBzdHJ1Y3QgZ2VuZnMgewogCiAvKiBU
aGUgcG9saWN5IGRhdGFiYXNlICovCiBzdHJ1Y3QgcG9saWN5ZGIgeworCWlu
dCBzZWxpbnV4X21sc19lbmFibGVkOworCiAJLyogc3ltYm9sIHRhYmxlcyAq
LwogCXN0cnVjdCBzeW10YWIgc3ltdGFiW1NZTV9OVU1dOwogI2RlZmluZSBw
X2NvbW1vbnMgc3ltdGFiW1NZTV9DT01NT05TXQpkaWZmIC1wcnVOIHNlY3Vy
aXR5LXRlc3RpbmctMi42L3NlY3VyaXR5L3NlbGludXgvc3Mvc2VydmljZXMu
YyBzZWN1cml0eS10ZXN0aW5nLTIuNi1uZXcvc2VjdXJpdHkvc2VsaW51eC9z
cy9zZXJ2aWNlcy5jCi0tLSBzZWN1cml0eS10ZXN0aW5nLTIuNi9zZWN1cml0
eS9zZWxpbnV4L3NzL3NlcnZpY2VzLmMJMjAxMC0wMS0yOSAwMjowMjo0Ny43
NDIwNDI4MDUgKzAxMDAKKysrIHNlY3VyaXR5LXRlc3RpbmctMi42LW5ldy9z
ZWN1cml0eS9zZWxpbnV4L3NzL3NlcnZpY2VzLmMJMjAxMC0wMS0zMSAyMzoy
ODoyNi40NDAzMzY2MzggKzAxMDAKQEAgLTI2LDYgKzI2LDEwIEBACiAgKgog
ICogIEFkZGVkIHN1cHBvcnQgZm9yIGJvdW5kcyBkb21haW4gYW5kIGF1ZGl0
IG1lc3NhZ2VkIG9uIG1hc2tlZCBwZXJtaXNzaW9ucwogICoKKyAqIFVwZGF0
ZWQ6IEd1aWRvIFRyZW50YWxhbmNpYSA8Z3VpZG9AdHJlbnRhbGFuY2lhLmNv
bT4KKyAqCisgKiAgQWRkZWQgc3VwcG9ydCBmb3IgcnVudGltZSBzd2l0Y2hp
bmcgb2YgdGhlIHBvbGljeSB0eXBlCisgKgogICogQ29weXJpZ2h0IChDKSAy
MDA4LCAyMDA5IE5FQyBDb3Jwb3JhdGlvbgogICogQ29weXJpZ2h0IChDKSAy
MDA2LCAyMDA3IEhld2xldHQtUGFja2FyZCBEZXZlbG9wbWVudCBDb21wYW55
LCBMLlAuCiAgKiBDb3B5cmlnaHQgKEMpIDIwMDQtMjAwNiBUcnVzdGVkIENv
bXB1dGVyIFNvbHV0aW9ucywgSW5jLgpAQCAtMTE0NSw3ICsxMTQ5LDcgQEAg
c3RhdGljIGludCBzdHJpbmdfdG9fY29udGV4dF9zdHJ1Y3Qoc3RydQogCXJj
ID0gMDsKIG91dDoKIAlpZiAocmMpCi0JCWNvbnRleHRfZGVzdHJveShjdHgp
OworCQljb250ZXh0X2Rlc3Ryb3kocG9sLCBjdHgpOwogCXJldHVybiByYzsK
IH0KIApAQCAtMTE5OCw3ICsxMjAyLDcgQEAgc3RhdGljIGludCBzZWN1cml0
eV9jb250ZXh0X3RvX3NpZF9jb3JlKAogCX0gZWxzZSBpZiAocmMpCiAJCWdv
dG8gb3V0OwogCXJjID0gc2lkdGFiX2NvbnRleHRfdG9fc2lkKCZzaWR0YWIs
ICZjb250ZXh0LCBzaWQpOwotCWNvbnRleHRfZGVzdHJveSgmY29udGV4dCk7
CisJY29udGV4dF9kZXN0cm95KCZwb2xpY3lkYiwgJmNvbnRleHQpOwogb3V0
OgogCXJlYWRfdW5sb2NrKCZwb2xpY3lfcndsb2NrKTsKIAlrZnJlZShzY29u
dGV4dDIpOwpAQCAtMTQxOSw3ICsxNDIzLDcgQEAgc3RhdGljIGludCBzZWN1
cml0eV9jb21wdXRlX3NpZCh1MzIgc3NpZAogCXJjID0gc2lkdGFiX2NvbnRl
eHRfdG9fc2lkKCZzaWR0YWIsICZuZXdjb250ZXh0LCBvdXRfc2lkKTsKIG91
dF91bmxvY2s6CiAJcmVhZF91bmxvY2soJnBvbGljeV9yd2xvY2spOwotCWNv
bnRleHRfZGVzdHJveSgmbmV3Y29udGV4dCk7CisJY29udGV4dF9kZXN0cm95
KCZwb2xpY3lkYiwgJm5ld2NvbnRleHQpOwogb3V0OgogCXJldHVybiByYzsK
IH0KQEAgLTE1NDcsNiArMTU1MSw4IEBAIHN0YXRpYyBpbnQgY29udmVydF9j
b250ZXh0KHUzMiBrZXksCiB7CiAJc3RydWN0IGNvbnZlcnRfY29udGV4dF9h
cmdzICphcmdzOwogCXN0cnVjdCBjb250ZXh0IG9sZGM7CisJc3RydWN0IG9j
b250ZXh0ICpvYzsKKwlzdHJ1Y3QgbWxzX3JhbmdlICpyYW5nZTsKIAlzdHJ1
Y3Qgcm9sZV9kYXR1bSAqcm9sZTsKIAlzdHJ1Y3QgdHlwZV9kYXR1bSAqdHlw
ZGF0dW07CiAJc3RydWN0IHVzZXJfZGF0dW0gKnVzcmRhdHVtOwpAQCAtMTYx
NCw5ICsxNjIwLDI5IEBAIHN0YXRpYyBpbnQgY29udmVydF9jb250ZXh0KHUz
MiBrZXksCiAJCWdvdG8gYmFkOwogCWMtPnR5cGUgPSB0eXBkYXR1bS0+dmFs
dWU7CiAKLQlyYyA9IG1sc19jb252ZXJ0X2NvbnRleHQoYXJncy0+b2xkcCwg
YXJncy0+bmV3cCwgYyk7Ci0JaWYgKHJjKQotCQlnb3RvIGJhZDsKKwkvKiBD
b252ZXJ0IHRoZSBNTFMvTUNTIGZpZWxkcyBvciBkZWFsIHdpdGggcG9saWN5
IHR5cGUgc3dpdGNoICovCisJaWYgKGFyZ3MtPm9sZHAtPnNlbGludXhfbWxz
X2VuYWJsZWQKKwkgICAgJiYgYXJncy0+bmV3cC0+c2VsaW51eF9tbHNfZW5h
YmxlZCkgeworCQlyYyA9IG1sc19jb252ZXJ0X2NvbnRleHQoYXJncy0+b2xk
cCwgYXJncy0+bmV3cCwgYyk7CisJCWlmIChyYykKKwkJCWdvdG8gYmFkOwor
CX0gZWxzZSBpZiAoYXJncy0+b2xkcC0+c2VsaW51eF9tbHNfZW5hYmxlZAor
CQkgICAmJiAhYXJncy0+bmV3cC0+c2VsaW51eF9tbHNfZW5hYmxlZCkKKwkv
KiBTd2l0Y2hpbmcgYmV0d2VlbiBNTFMvTUNTIGFuZCBub24tTUxTL25vbi1N
Q1MgcG9saWN5OiAqLworCS8qIGZyZWUgYW55IHN0b3JhZ2UgdXNlZCBieSB0
aGUgTUxTIGZpZWxkcyBpbiB0aGUgICAgICAgICovCisJLyogY29udGV4dCBm
b3IgYWxsIGV4aXN0aW5nIGVudHJpZXMgaW4gdGhlIHNpZHRhYi4gICAgICAg
Ki8KKwkJbWxzX2NvbnRleHRfZGVzdHJveShhcmdzLT5vbGRwLCBjKTsKKwll
bHNlIGlmICghYXJncy0+b2xkcC0+c2VsaW51eF9tbHNfZW5hYmxlZAorCQkg
JiYgYXJncy0+bmV3cC0+c2VsaW51eF9tbHNfZW5hYmxlZCkgeworCS8qIFN3
aXRjaGluZyBiZXR3ZWVuIG5vbi1NTFMvbm9uLU1DUyBhbmQgTUxTL01DUyBw
b2xpY3k6ICAqLworCS8qIGVuc3VyZSB0aGF0IHRoZSBNTFMgZmllbGRzIG9m
IHRoZSBjb250ZXh0IGZvciBhbGwgICAgICAqLworCS8qIGV4aXN0aW5nIGVu
dHJpZXMgaW4gdGhlIHNpZHRhYiBhcmUgZmlsbGVkIGluIHdpdGggYSAgICAq
LworCS8qIHN1aXRhYmxlIGRlZmF1bHQgdmFsdWUsIGxpa2VseSB0YWtlbiBm
cm9tIG9uZSBvZiB0aGUgICAqLworCS8qIGluaXRpYWwgU0lEcy4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqLworCQlvYyA9
IGFyZ3MtPm5ld3AtPm9jb250ZXh0c1tPQ09OX0lTSURdOworCQlyYW5nZSA9
ICZvYy0+Y29udGV4dFswXS5yYW5nZTsKKwkJbWxzX3JhbmdlX3NldChjLCBy
YW5nZSk7CisJfQogCiAJLyogQ2hlY2sgdGhlIHZhbGlkaXR5IG9mIHRoZSBu
ZXcgY29udGV4dC4gKi8KIAlpZiAoIXBvbGljeWRiX2NvbnRleHRfaXN2YWxp
ZChhcmdzLT5uZXdwLCBjKSkgewpAQCAtMTYyNSw3ICsxNjUxLDcgQEAgc3Rh
dGljIGludCBjb252ZXJ0X2NvbnRleHQodTMyIGtleSwKIAkJCWdvdG8gYmFk
OwogCX0KIAotCWNvbnRleHRfZGVzdHJveSgmb2xkYyk7CisJY29udGV4dF9k
ZXN0cm95KGFyZ3MtPm9sZHAsICZvbGRjKTsKIAlyYyA9IDA7CiBvdXQ6CiAJ
cmV0dXJuIHJjOwpAQCAtMTYzMyw4ICsxNjU5LDggQEAgYmFkOgogCS8qIE1h
cCBvbGQgcmVwcmVzZW50YXRpb24gdG8gc3RyaW5nIGFuZCBzYXZlIGl0LiAq
LwogCWlmIChjb250ZXh0X3N0cnVjdF90b19zdHJpbmcoJm9sZGMsICZzLCAm
bGVuKSkKIAkJcmV0dXJuIC1FTk9NRU07Ci0JY29udGV4dF9kZXN0cm95KCZv
bGRjKTsKLQljb250ZXh0X2Rlc3Ryb3koYyk7CisJY29udGV4dF9kZXN0cm95
KGFyZ3MtPm9sZHAsICZvbGRjKTsKKwljb250ZXh0X2Rlc3Ryb3koYXJncy0+
bmV3cCwgYyk7CiAJYy0+c3RyID0gczsKIAljLT5sZW4gPSBsZW47CiAJcHJp
bnRrKEtFUk5fSU5GTwpAQCAtMTcxMiw2ICsxNzM4LDE1IEBAIGludCBzZWN1
cml0eV9sb2FkX3BvbGljeSh2b2lkICpkYXRhLCBzaXoKIAlpZiAocG9saWN5
ZGJfcmVhZCgmbmV3cG9saWN5ZGIsIGZwKSkKIAkJcmV0dXJuIC1FSU5WQUw7
CiAKKwkvKiBJZiBzd2l0Y2hpbmcgYmV0d2VlbiBkaWZmZXJlbnQgcG9saWN5
IHR5cGVzLCBsb2cgaXQgKi8KKwlpZiAocG9saWN5ZGIuc2VsaW51eF9tbHNf
ZW5hYmxlZCAmJiBuZXdwb2xpY3lkYi5zZWxpbnV4X21sc19lbmFibGVkKQor
CQlwcmludGsoS0VSTl9JTkZPICJTRUxpbnV4OiBTd2l0Y2hpbmcgYmV0d2Vl
biBNTFMvTUNTIgorCQkJIiBhbmQgc3RhbmRhcmQgcG9saWN5Li4uXG4iKTsK
KwllbHNlIGlmICghcG9saWN5ZGIuc2VsaW51eF9tbHNfZW5hYmxlZAorCSAg
JiYgbmV3cG9saWN5ZGIuc2VsaW51eF9tbHNfZW5hYmxlZCkKKwkJcHJpbnRr
KEtFUk5fSU5GTyAiU0VMaW51eDogU3dpdGNoaW5nIGJldHdlZW4gc3RhbmRh
cmQiCisJCQkiIGFuZCBNTFMvTUNTIHBvbGljeS4uLlxuIik7CisKIAlpZiAo
c2lkdGFiX2luaXQoJm5ld3NpZHRhYikpIHsKIAkJcG9saWN5ZGJfZGVzdHJv
eSgmbmV3cG9saWN5ZGIpOwogCQlyZXR1cm4gLUVOT01FTTsKQEAgLTE3NDEs
OCArMTc3NiwxMiBAQCBpbnQgc2VjdXJpdHlfbG9hZF9wb2xpY3kodm9pZCAq
ZGF0YSwgc2l6CiAJYXJncy5vbGRwID0gJnBvbGljeWRiOwogCWFyZ3MubmV3
cCA9ICZuZXdwb2xpY3lkYjsKIAlyYyA9IHNpZHRhYl9tYXAoJm5ld3NpZHRh
YiwgY29udmVydF9jb250ZXh0LCAmYXJncyk7Ci0JaWYgKHJjKQorCWlmIChy
YykgeworCQlwcmludGsoS0VSTl9FUlIgIlNFTGludXg6ICB1bmFibGUgdG8g
Y29udmVydCB0aGUgaW50ZXJuYWwiCisJCQkiIHJlcHJlc2VudGF0aW9uIG9m
IGNvbnRleHRzIGluIHRoZSBuZXcgU0lEIgorCQkJIiB0YWJsZVxuIik7CiAJ
CWdvdG8gZXJyOworCX0KIAogCS8qIFNhdmUgdGhlIG9sZCBwb2xpY3lkYiBh
bmQgU0lEIHRhYmxlIHRvIGZyZWUgbGF0ZXIuICovCiAJbWVtY3B5KCZvbGRw
b2xpY3lkYiwgJnBvbGljeWRiLCBzaXplb2YgcG9saWN5ZGIpOwpAQCAtMTc2
MSw3ICsxODAwLDcgQEAgaW50IHNlY3VyaXR5X2xvYWRfcG9saWN5KHZvaWQg
KmRhdGEsIHNpegogCiAJLyogRnJlZSB0aGUgb2xkIHBvbGljeWRiIGFuZCBT
SUQgdGFibGUuICovCiAJcG9saWN5ZGJfZGVzdHJveSgmb2xkcG9saWN5ZGIp
OwotCXNpZHRhYl9kZXN0cm95KCZvbGRzaWR0YWIpOworCXNpZHRhYl9kZXN0
cm95KCZvbGRwb2xpY3lkYiwgJm9sZHNpZHRhYik7CiAJa2ZyZWUob2xkbWFw
KTsKIAogCWF2Y19zc19yZXNldChzZXFubyk7CkBAIC0xNzczLDcgKzE4MTIs
NyBAQCBpbnQgc2VjdXJpdHlfbG9hZF9wb2xpY3kodm9pZCAqZGF0YSwgc2l6
CiAKIGVycjoKIAlrZnJlZShtYXApOwotCXNpZHRhYl9kZXN0cm95KCZuZXdz
aWR0YWIpOworCXNpZHRhYl9kZXN0cm95KCZuZXdwb2xpY3lkYiwgJm5ld3Np
ZHRhYik7CiAJcG9saWN5ZGJfZGVzdHJveSgmbmV3cG9saWN5ZGIpOwogCXJl
dHVybiByYzsKIApAQCAtMjMzOCw3ICsyMzc3LDcgQEAgaW50IHNlY3VyaXR5
X3NpZF9tbHNfY29weSh1MzIgc2lkLCB1MzIgbQogCXUzMiBsZW47CiAJaW50
IHJjID0gMDsKIAotCWlmICghc3NfaW5pdGlhbGl6ZWQgfHwgIXNlbGludXhf
bWxzX2VuYWJsZWQpIHsKKwlpZiAoIXNzX2luaXRpYWxpemVkIHx8ICFwb2xp
Y3lkYi5zZWxpbnV4X21sc19lbmFibGVkKSB7CiAJCSpuZXdfc2lkID0gc2lk
OwogCQlnb3RvIG91dDsKIAl9CkBAIC0yMzg4LDcgKzI0MjcsNyBAQCBiYWQ6
CiAKIG91dF91bmxvY2s6CiAJcmVhZF91bmxvY2soJnBvbGljeV9yd2xvY2sp
OwotCWNvbnRleHRfZGVzdHJveSgmbmV3Y29uKTsKKwljb250ZXh0X2Rlc3Ry
b3koJnBvbGljeWRiLCAmbmV3Y29uKTsKIG91dDoKIAlyZXR1cm4gcmM7CiB9
CkBAIC0yNDM5LDcgKzI0NzgsNyBAQCBpbnQgc2VjdXJpdHlfbmV0X3BlZXJz
aWRfcmVzb2x2ZSh1MzIgbmxiCiAJLyogd2UgZG9uJ3QgbmVlZCB0byBjaGVj
ayBzc19pbml0aWFsaXplZCBoZXJlIHNpbmNlIHRoZSBvbmx5IHdheSBib3Ro
CiAJICogbmxibF9zaWQgYW5kIHhmcm1fc2lkIGFyZSBub3QgZXF1YWwgdG8g
U0VDU0lEX05VTEwgd291bGQgYmUgaWYgdGhlCiAJICogc2VjdXJpdHkgc2Vy
dmVyIHdhcyBpbml0aWFsaXplZCBhbmQgc3NfaW5pdGlhbGl6ZWQgd2FzIHRy
dWUgKi8KLQlpZiAoIXNlbGludXhfbWxzX2VuYWJsZWQpIHsKKwlpZiAoIXBv
bGljeWRiLnNlbGludXhfbWxzX2VuYWJsZWQpIHsKIAkJKnBlZXJfc2lkID0g
U0VDU0lEX05VTEw7CiAJCXJldHVybiAwOwogCX0KQEAgLTI2MTIsNyArMjY1
MSw3IEBAIHZvaWQgc2VsaW51eF9hdWRpdF9ydWxlX2ZyZWUodm9pZCAqdnJ1
bGUKIAlzdHJ1Y3Qgc2VsaW51eF9hdWRpdF9ydWxlICpydWxlID0gdnJ1bGU7
CiAKIAlpZiAocnVsZSkgewotCQljb250ZXh0X2Rlc3Ryb3koJnJ1bGUtPmF1
X2N0eHQpOworCQljb250ZXh0X2Rlc3Ryb3koJnBvbGljeWRiLCAmcnVsZS0+
YXVfY3R4dCk7CiAJCWtmcmVlKHJ1bGUpOwogCX0KIH0KZGlmZiAtcHJ1TiBz
ZWN1cml0eS10ZXN0aW5nLTIuNi9zZWN1cml0eS9zZWxpbnV4L3NzL3NlcnZp
Y2VzLmggc2VjdXJpdHktdGVzdGluZy0yLjYtbmV3L3NlY3VyaXR5L3NlbGlu
dXgvc3Mvc2VydmljZXMuaAotLS0gc2VjdXJpdHktdGVzdGluZy0yLjYvc2Vj
dXJpdHkvc2VsaW51eC9zcy9zZXJ2aWNlcy5oCTIwMTAtMDEtMjkgMDE6MDY6
NDIuMTc0MDQ0NDA2ICswMTAwCisrKyBzZWN1cml0eS10ZXN0aW5nLTIuNi1u
ZXcvc2VjdXJpdHkvc2VsaW51eC9zcy9zZXJ2aWNlcy5oCTIwMTAtMDEtMzEg
MjM6MjQ6MzYuNjc3MzQ3NzExICswMTAwCkBAIC0zLDYgKzMsNyBAQAogICoK
ICAqIEF1dGhvciA6IFN0ZXBoZW4gU21hbGxleSwgPHNkc0BlcG9jaC5uY3Nj
Lm1pbD4KICAqLworCiAjaWZuZGVmIF9TU19TRVJWSUNFU19IXwogI2RlZmlu
ZSBfU1NfU0VSVklDRVNfSF8KIApAQCAtMTEsNSArMTIsNTEgQEAKIAogZXh0
ZXJuIHN0cnVjdCBwb2xpY3lkYiBwb2xpY3lkYjsKIAoraW50IHNlY3VyaXR5
X2JvdW5kZWRfdHJhbnNpdGlvbih1MzIgb2xkX3NpZCwgdTMyIG5ld19zaWQp
Owordm9pZCBzZWN1cml0eV9jb21wdXRlX2F2KHUzMiBzc2lkLCB1MzIgdHNp
ZCwgdTE2IG9yaWdfdGNsYXNzLAorCQkJIHN0cnVjdCBhdl9kZWNpc2lvbiAq
YXZkKTsKK3ZvaWQgc2VjdXJpdHlfY29tcHV0ZV9hdl91c2VyKHUzMiBzc2lk
LCB1MzIgdHNpZCwgdTE2IHRjbGFzcywKKwkJCSAgICAgIHN0cnVjdCBhdl9k
ZWNpc2lvbiAqYXZkKTsKK2NvbnN0IGNoYXIgKnNlY3VyaXR5X2dldF9pbml0
aWFsX3NpZF9jb250ZXh0KHUzMiBzaWQpOworaW50IHNlY3VyaXR5X3NpZF90
b19jb250ZXh0KHUzMiBzaWQsIGNoYXIgKipzY29udGV4dCwgdTMyICpzY29u
dGV4dF9sZW4pOworaW50IHNlY3VyaXR5X3NpZF90b19jb250ZXh0X2ZvcmNl
KHUzMiBzaWQsIGNoYXIgKipzY29udGV4dCwgdTMyICpzY29udGV4dF9sZW4p
OworaW50IHNlY3VyaXR5X2NvbnRleHRfdG9fc2lkKGNvbnN0IGNoYXIgKnNj
b250ZXh0LCB1MzIgc2NvbnRleHRfbGVuLCB1MzIgKnNpZCk7CitpbnQgc2Vj
dXJpdHlfY29udGV4dF90b19zaWRfZGVmYXVsdChjb25zdCBjaGFyICpzY29u
dGV4dCwgdTMyIHNjb250ZXh0X2xlbiwKKwkJCQkgICAgdTMyICpzaWQsIHUz
MiBkZWZfc2lkLCBnZnBfdCBnZnBfZmxhZ3MpOworaW50IHNlY3VyaXR5X2Nv
bnRleHRfdG9fc2lkX2ZvcmNlKGNvbnN0IGNoYXIgKnNjb250ZXh0LCB1MzIg
c2NvbnRleHRfbGVuLAorCQkJCSAgdTMyICpzaWQpOworaW50IHNlY3VyaXR5
X3RyYW5zaXRpb25fc2lkKHUzMiBzc2lkLCB1MzIgdHNpZCwgdTE2IHRjbGFz
cywgdTMyICpvdXRfc2lkKTsKK2ludCBzZWN1cml0eV90cmFuc2l0aW9uX3Np
ZF91c2VyKHUzMiBzc2lkLCB1MzIgdHNpZCwgdTE2IHRjbGFzcywgdTMyICpv
dXRfc2lkKTsKK2ludCBzZWN1cml0eV9tZW1iZXJfc2lkKHUzMiBzc2lkLCB1
MzIgdHNpZCwgdTE2IHRjbGFzcywgdTMyICpvdXRfc2lkKTsKK2ludCBzZWN1
cml0eV9jaGFuZ2Vfc2lkKHUzMiBzc2lkLCB1MzIgdHNpZCwgdTE2IHRjbGFz
cywgdTMyICpvdXRfc2lkKTsKK2ludCBzZWN1cml0eV9sb2FkX3BvbGljeSh2
b2lkICpkYXRhLCBzaXplX3QgbGVuKTsKK2ludCBzZWN1cml0eV9wb3J0X3Np
ZCh1OCBwcm90b2NvbCwgdTE2IHBvcnQsIHUzMiAqb3V0X3NpZCk7CitpbnQg
c2VjdXJpdHlfbmV0aWZfc2lkKGNoYXIgKm5hbWUsIHUzMiAqaWZfc2lkKTsK
K2ludCBzZWN1cml0eV9ub2RlX3NpZCh1MTYgZG9tYWluLCB2b2lkICphZGRy
cCwgdTMyIGFkZHJsZW4sIHUzMiAqb3V0X3NpZCk7CitpbnQgc2VjdXJpdHlf
Z2V0X3VzZXJfc2lkcyh1MzIgZnJvbXNpZCwgY2hhciAqdXNlcm5hbWUsIHUz
MiAqKnNpZHMsIHUzMiAqbmVsKTsKK2ludCBzZWN1cml0eV9nZW5mc19zaWQo
Y29uc3QgY2hhciAqZnN0eXBlLCBjaGFyICpwYXRoLCB1MTYgb3JpZ19zY2xh
c3MsCisJCSAgICAgICB1MzIgKnNpZCk7CitpbnQgc2VjdXJpdHlfZnNfdXNl
KGNvbnN0IGNoYXIgKmZzdHlwZSwgdW5zaWduZWQgaW50ICpiZWhhdmlvciwg
dTMyICpzaWQpOworaW50IHNlY3VyaXR5X2dldF9ib29scyhpbnQgKmxlbiwg
Y2hhciAqKipuYW1lcywgaW50ICoqdmFsdWVzKTsKK2ludCBzZWN1cml0eV9z
ZXRfYm9vbHMoaW50IGxlbiwgaW50ICp2YWx1ZXMpOworaW50IHNlY3VyaXR5
X2dldF9ib29sX3ZhbHVlKGludCBib29sKTsKK2ludCBzZWN1cml0eV9zaWRf
bWxzX2NvcHkodTMyIHNpZCwgdTMyIG1sc19zaWQsIHUzMiAqbmV3X3NpZCk7
CitpbnQgc2VjdXJpdHlfbmV0X3BlZXJzaWRfcmVzb2x2ZSh1MzIgbmxibF9z
aWQsIHUzMiBubGJsX3R5cGUsIHUzMiB4ZnJtX3NpZCwKKwkJCQkgdTMyICpw
ZWVyX3NpZCk7CitpbnQgc2VjdXJpdHlfZ2V0X2NsYXNzZXMoY2hhciAqKipj
bGFzc2VzLCBpbnQgKm5jbGFzc2VzKTsKK2ludCBzZWN1cml0eV9nZXRfcGVy
bWlzc2lvbnMoY2hhciAqY2xhc3MsIGNoYXIgKioqcGVybXMsIGludCAqbnBl
cm1zKTsKK2ludCBzZWN1cml0eV9nZXRfcmVqZWN0X3Vua25vd24odm9pZCk7
CitpbnQgc2VjdXJpdHlfZ2V0X2FsbG93X3Vua25vd24odm9pZCk7CitpbnQg
c2VjdXJpdHlfcG9saWN5Y2FwX3N1cHBvcnRlZCh1bnNpZ25lZCBpbnQgcmVx
X2NhcCk7Cit2b2lkIHNlbGludXhfYXVkaXRfcnVsZV9mcmVlKHZvaWQgKnZy
dWxlKTsKK2ludCBzZWxpbnV4X2F1ZGl0X3J1bGVfaW5pdCh1MzIgZmllbGQs
IHUzMiBvcCwgY2hhciAqcnVsZXN0ciwgdm9pZCAqKnZydWxlKTsKK2ludCBz
ZWxpbnV4X2F1ZGl0X3J1bGVfa25vd24oc3RydWN0IGF1ZGl0X2tydWxlICpy
dWxlKTsKK2ludCBzZWxpbnV4X2F1ZGl0X3J1bGVfbWF0Y2godTMyIHNpZCwg
dTMyIGZpZWxkLCB1MzIgb3AsIHZvaWQgKnZydWxlLAorCQkJICAgICBzdHJ1
Y3QgYXVkaXRfY29udGV4dCAqYWN0eCk7CitpbnQgc2VjdXJpdHlfbmV0bGJs
X3NlY2F0dHJfdG9fc2lkKHN0cnVjdCBuZXRsYmxfbHNtX3NlY2F0dHIgKnNl
Y2F0dHIsCisJCQkJICAgdTMyICpzaWQpOworaW50IHNlY3VyaXR5X25ldGxi
bF9zaWRfdG9fc2VjYXR0cih1MzIgc2lkLCBzdHJ1Y3QgbmV0bGJsX2xzbV9z
ZWNhdHRyICpzZWNhdHRyKTsKKworCiAjZW5kaWYJLyogX1NTX1NFUlZJQ0VT
X0hfICovCiAKZGlmZiAtcHJ1TiBzZWN1cml0eS10ZXN0aW5nLTIuNi9zZWN1
cml0eS9zZWxpbnV4L3NzL3NpZHRhYi5jIHNlY3VyaXR5LXRlc3RpbmctMi42
LW5ldy9zZWN1cml0eS9zZWxpbnV4L3NzL3NpZHRhYi5jCi0tLSBzZWN1cml0
eS10ZXN0aW5nLTIuNi9zZWN1cml0eS9zZWxpbnV4L3NzL3NpZHRhYi5jCTIw
MTAtMDEtMjkgMDE6MDY6NDIuMTc0MDQ0NDA2ICswMTAwCisrKyBzZWN1cml0
eS10ZXN0aW5nLTIuNi1uZXcvc2VjdXJpdHkvc2VsaW51eC9zcy9zaWR0YWIu
YwkyMDEwLTAxLTMxIDIxOjQyOjU1LjY0OTg5NjM0OSArMDEwMApAQCAtMjMy
LDcgKzIzMiw3IEBAIHZvaWQgc2lkdGFiX2hhc2hfZXZhbChzdHJ1Y3Qgc2lk
dGFiICpoLCAKIAkgICAgICAgbWF4X2NoYWluX2xlbik7CiB9CiAKLXZvaWQg
c2lkdGFiX2Rlc3Ryb3koc3RydWN0IHNpZHRhYiAqcykKK3ZvaWQgc2lkdGFi
X2Rlc3Ryb3koc3RydWN0IHBvbGljeWRiICpwLCBzdHJ1Y3Qgc2lkdGFiICpz
KQogewogCWludCBpOwogCXN0cnVjdCBzaWR0YWJfbm9kZSAqY3VyLCAqdGVt
cDsKQEAgLTI0NSw3ICsyNDUsNyBAQCB2b2lkIHNpZHRhYl9kZXN0cm95KHN0
cnVjdCBzaWR0YWIgKnMpCiAJCXdoaWxlIChjdXIpIHsKIAkJCXRlbXAgPSBj
dXI7CiAJCQljdXIgPSBjdXItPm5leHQ7Ci0JCQljb250ZXh0X2Rlc3Ryb3ko
JnRlbXAtPmNvbnRleHQpOworCQkJY29udGV4dF9kZXN0cm95KHAsICZ0ZW1w
LT5jb250ZXh0KTsKIAkJCWtmcmVlKHRlbXApOwogCQl9CiAJCXMtPmh0YWJs
ZVtpXSA9IE5VTEw7CmRpZmYgLXBydU4gc2VjdXJpdHktdGVzdGluZy0yLjYv
c2VjdXJpdHkvc2VsaW51eC9zcy9zaWR0YWIuaCBzZWN1cml0eS10ZXN0aW5n
LTIuNi1uZXcvc2VjdXJpdHkvc2VsaW51eC9zcy9zaWR0YWIuaAotLS0gc2Vj
dXJpdHktdGVzdGluZy0yLjYvc2VjdXJpdHkvc2VsaW51eC9zcy9zaWR0YWIu
aAkyMDEwLTAxLTI5IDAxOjA2OjQyLjE3NTA0NzY1OSArMDEwMAorKysgc2Vj
dXJpdHktdGVzdGluZy0yLjYtbmV3L3NlY3VyaXR5L3NlbGludXgvc3Mvc2lk
dGFiLmgJMjAxMC0wMS0zMSAyMTo0MjozMS4wNTIzNDg3NDAgKzAxMDAKQEAg
LTQ1LDcgKzQ1LDcgQEAgaW50IHNpZHRhYl9jb250ZXh0X3RvX3NpZChzdHJ1
Y3Qgc2lkdGFiIAogCQkJICB1MzIgKnNpZCk7CiAKIHZvaWQgc2lkdGFiX2hh
c2hfZXZhbChzdHJ1Y3Qgc2lkdGFiICpoLCBjaGFyICp0YWcpOwotdm9pZCBz
aWR0YWJfZGVzdHJveShzdHJ1Y3Qgc2lkdGFiICpzKTsKK3ZvaWQgc2lkdGFi
X2Rlc3Ryb3koc3RydWN0IHBvbGljeWRiICpwLCBzdHJ1Y3Qgc2lkdGFiICpz
KTsKIHZvaWQgc2lkdGFiX3NldChzdHJ1Y3Qgc2lkdGFiICpkc3QsIHN0cnVj
dCBzaWR0YWIgKnNyYyk7CiB2b2lkIHNpZHRhYl9zaHV0ZG93bihzdHJ1Y3Qg
c2lkdGFiICpzKTsKIAo=


------_=_NextPart_000_9cb81d9739ca038815a898bcce47220a--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
