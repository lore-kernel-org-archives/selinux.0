Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o11LnTLd022113
	for <selinux@tycho.nsa.gov>; Mon, 1 Feb 2010 16:49:30 -0500
Received: from hostingsmtp.register.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o11LnILk009688
	for <selinux@tycho.nsa.gov>; Mon, 1 Feb 2010 21:49:20 GMT
Message-Id: <201002012149.o11LnOVX005278@vivaldi39.register.it>
From: "Guido Trentalancia" <guido@trentalancia.com>
Reply-To: "Guido Trentalancia" <guido@trentalancia.com>
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, eparis@parisplace.org, jmorris@namei.org
Subject: Re: [PATCH] Allowing MLS->non-MLS and vice versa upon policy reload
Date: Mon, 01 Feb 2010 22:49:24 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_a4082aefb076d7807edd6567bdc721de"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------_=_NextPart_000_a4082aefb076d7807edd6567bdc721de
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_9fe8a8d645530711cd3f253a87164eb0"


------_=_NextPart_001_9fe8a8d645530711cd3f253a87164eb0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Stephen,

yes you are right. There is no need to include policydb.h from security.h.

Please have a further look at the attached revised patch, while I do some testing of the resulting compiled kernel. I hope I did not miss any amendment.

If it is fine and nobody else has comments or suggestions to make, then we should probably post it to the kernel mailing list with your Acked-by or Reviewed-by line.

Best regards,

Guido

Author: Guido Trentalancia <guido@trentalancia.com>
Date:   Mon Feb 01 22:34:16 2010 +0100

    Allow runtime switching between different policy types (e.g. from a MLS/MCS
    policy to a non-MLS/non-MCS policy or viceversa).

    Signed-off-by: Guido Trentalancia <guido@trentalancia.com>

diff -pruN security-testing-2.6/security/selinux/include/security.h security-testing-2.6-new/security/selinux/include/security.h
--- security-testing-2.6/security/selinux/include/security.h	2010-01-29 02:02:47.737045258 +0100
+++ security-testing-2.6-new/security/selinux/include/security.h	2010-02-01 22:06:38.053225052 +0100
@@ -57,7 +57,7 @@
 struct netlbl_lsm_secattr;
 
 extern int selinux_enabled;
-extern int selinux_mls_enabled;
+extern struct policydb policydb;
 
 /* Policy capabilities */
 enum {
@@ -80,6 +80,8 @@ extern int selinux_policycap_openperm;
 /* limitation of boundary depth  */
 #define POLICYDB_BOUNDS_MAXDEPTH	4
 
+int security_mls_enabled(void);
+
 int security_load_policy(void *data, size_t len);
 
 int security_policycap_supported(unsigned int req_cap);
diff -pruN security-testing-2.6/security/selinux/selinuxfs.c security-testing-2.6-new/security/selinux/selinuxfs.c
--- security-testing-2.6/security/selinux/selinuxfs.c	2010-01-29 02:02:47.738046835 +0100
+++ security-testing-2.6-new/security/selinux/selinuxfs.c	2010-02-01 22:06:21.709234039 +0100
@@ -282,7 +282,8 @@ static ssize_t sel_read_mls(struct file 
 	char tmpbuf[TMPBUFLEN];
 	ssize_t length;
 
-	length =3D scnprintf(tmpbuf, TMPBUFLEN, "%d", selinux_mls_enabled);
+	length =3D scnprintf(tmpbuf, TMPBUFLEN, "%d",
+			   security_mls_enabled());
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
 }
 
diff -pruN security-testing-2.6/security/selinux/ss/constraint.h security-testing-2.6-new/security/selinux/ss/constraint.h
--- security-testing-2.6/security/selinux/ss/constraint.h	2010-01-29 01:06:42.160060332 +0100
+++ security-testing-2.6-new/security/selinux/ss/constraint.h	2010-02-01 20:50:19.860227025 +0100
@@ -12,6 +12,7 @@
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+
 #ifndef _SS_CONSTRAINT_H_
 #define _SS_CONSTRAINT_H_
 
diff -pruN security-testing-2.6/security/selinux/ss/context.h security-testing-2.6-new/security/selinux/ss/context.h
--- security-testing-2.6/security/selinux/ss/context.h	2010-01-29 01:06:42.160060332 +0100
+++ security-testing-2.6-new/security/selinux/ss/context.h	2010-02-01 22:22:33.090234587 +0100
@@ -12,6 +12,7 @@
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+
 #ifndef _SS_CONTEXT_H_
 #define _SS_CONTEXT_H_
 
@@ -41,7 +42,7 @@ static inline int mls_context_cpy(struct
 {
 	int rc;
 
-	if (!selinux_mls_enabled)
+	if (!security_mls_enabled())
 		return 0;
 
 	dst->range.level[0].sens =3D src->range.level[0].sens;
@@ -64,7 +65,7 @@ static inline int mls_context_cpy_low(st
 {
 	int rc;
 
-	if (!selinux_mls_enabled)
+	if (!security_mls_enabled())
 		return 0;
 
 	dst->range.level[0].sens =3D src->range.level[0].sens;
@@ -82,7 +83,7 @@ out:
 
 static inline int mls_context_cmp(struct context *c1, struct context *c2)
 {
-	if (!selinux_mls_enabled)
+	if (!security_mls_enabled())
 		return 1;
 
 	return ((c1->range.level[0].sens =3D=3D c2->range.level[0].sens) &&
@@ -93,9 +94,6 @@ static inline int mls_context_cmp(struct
 
 static inline void mls_context_destroy(struct context *c)
 {
-	if (!selinux_mls_enabled)
-		return;
-
 	ebitmap_destroy(&c->range.level[0].cat);
 	ebitmap_destroy(&c->range.level[1].cat);
 	mls_context_init(c);
diff -pruN security-testing-2.6/security/selinux/ss/mls.c security-testing-2.6-new/security/selinux/ss/mls.c
--- security-testing-2.6/security/selinux/ss/mls.c	2010-01-29 02:02:47.739046177 +0100
+++ security-testing-2.6-new/security/selinux/ss/mls.c	2010-02-01 22:15:48.062233721 +0100
@@ -39,7 +39,7 @@ int mls_compute_context_len(struct conte
 	struct ebitmap *e;
 	struct ebitmap_node *node;
 
-	if (!selinux_mls_enabled)
+	if (!policydb.mls_enabled)
 		return 0;
 
 	len =3D 1; /* for the beginning ":" */
@@ -93,7 +93,7 @@ void mls_sid_to_context(struct context *
 	struct ebitmap *e;
 	struct ebitmap_node *node;
 
-	if (!selinux_mls_enabled)
+	if (!policydb.mls_enabled)
 		return;
 
 	scontextp =3D *scontext;
@@ -200,7 +200,7 @@ int mls_context_isvalid(struct policydb 
 {
 	struct user_datum *usrdatum;
 
-	if (!selinux_mls_enabled)
+	if (!p->mls_enabled)
 		return 1;
 
 	if (!mls_range_isvalid(p, &c->range))
@@ -253,7 +253,7 @@ int mls_context_to_sid(struct policydb *
 	struct cat_datum *catdatum, *rngdatum;
 	int l, rc =3D -EINVAL;
 
-	if (!selinux_mls_enabled) {
+	if (!pol->mls_enabled) {
 		if (def_sid !=3D SECSID_NULL && oldc)
 			*scontext +=3D strlen(*scontext)+1;
 		return 0;
@@ -387,7 +387,7 @@ int mls_from_string(char *str, struct co
 	char *tmpstr, *freestr;
 	int rc;
 
-	if (!selinux_mls_enabled)
+	if (!policydb.mls_enabled)
 		return -EINVAL;
 
 	/* we need freestr because mls_context_to_sid will change
@@ -407,7 +407,7 @@ int mls_from_string(char *str, struct co
 /*
  * Copies the MLS range `range' into `context'.
  */
-static inline int mls_range_set(struct context *context,
+int mls_range_set(struct context *context,
 				struct mls_range *range)
 {
 	int l, rc =3D 0;
@@ -427,7 +427,7 @@ static inline int mls_range_set(struct c
 int mls_setup_user_range(struct context *fromcon, struct user_datum *user,
 			 struct context *usercon)
 {
-	if (selinux_mls_enabled) {
+	if (policydb.mls_enabled) {
 		struct mls_level *fromcon_sen =3D &(fromcon->range.level[0]);
 		struct mls_level *fromcon_clr =3D &(fromcon->range.level[1]);
 		struct mls_level *user_low =3D &(user->range.level[0]);
@@ -477,7 +477,7 @@ int mls_convert_context(struct policydb 
 	struct ebitmap_node *node;
 	int l, i;
 
-	if (!selinux_mls_enabled)
+	if (!policydb.mls_enabled)
 		return 0;
 
 	for (l =3D 0; l < 2; l++) {
@@ -516,7 +516,7 @@ int mls_compute_sid(struct context *scon
 	struct range_trans rtr;
 	struct mls_range *r;
 
-	if (!selinux_mls_enabled)
+	if (!policydb.mls_enabled)
 		return 0;
 
 	switch (specified) {
@@ -559,7 +559,7 @@ int mls_compute_sid(struct context *scon
 void mls_export_netlbl_lvl(struct context *context,
 			   struct netlbl_lsm_secattr *secattr)
 {
-	if (!selinux_mls_enabled)
+	if (!policydb.mls_enabled)
 		return;
 
 	secattr->attr.mls.lvl =3D context->range.level[0].sens - 1;
@@ -579,7 +579,7 @@ void mls_export_netlbl_lvl(struct contex
 void mls_import_netlbl_lvl(struct context *context,
 			   struct netlbl_lsm_secattr *secattr)
 {
-	if (!selinux_mls_enabled)
+	if (!policydb.mls_enabled)
 		return;
 
 	context->range.level[0].sens =3D secattr->attr.mls.lvl + 1;
@@ -601,7 +601,7 @@ int mls_export_netlbl_cat(struct context
 {
 	int rc;
 
-	if (!selinux_mls_enabled)
+	if (!policydb.mls_enabled)
 		return 0;
 
 	rc =3D ebitmap_netlbl_export(&context->range.level[0].cat,
@@ -629,7 +629,7 @@ int mls_import_netlbl_cat(struct context
 {
 	int rc;
 
-	if (!selinux_mls_enabled)
+	if (!policydb.mls_enabled)
 		return 0;
 
 	rc =3D ebitmap_netlbl_import(&context->range.level[0].cat,
diff -pruN security-testing-2.6/security/selinux/ss/mls.h security-testing-2.6-new/security/selinux/ss/mls.h
--- security-testing-2.6/security/selinux/ss/mls.h	2010-01-29 01:06:42.168051431 +0100
+++ security-testing-2.6-new/security/selinux/ss/mls.h	2010-02-01 18:57:42.693221952 +0100
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
 
+int mls_range_set(struct context *context, struct mls_range *range);
+
 int mls_convert_context(struct policydb *oldp,
 			struct policydb *newp,
 			struct context *context);
diff -pruN security-testing-2.6/security/selinux/ss/mls_types.h security-testing-2.6-new/security/selinux/ss/mls_types.h
--- security-testing-2.6/security/selinux/ss/mls_types.h	2010-01-29 01:06:42.168051431 +0100
+++ security-testing-2.6-new/security/selinux/ss/mls_types.h	2010-02-01 22:23:11.799224771 +0100
@@ -15,6 +15,7 @@
 #define _SS_MLS_TYPES_H_
 
 #include "security.h"
+#include "ebitmap.h"
 
 struct mls_level {
 	u32 sens;		/* sensitivity */
@@ -27,7 +28,7 @@ struct mls_range {
 
 static inline int mls_level_eq(struct mls_level *l1, struct mls_level *l2)
 {
-	if (!selinux_mls_enabled)
+	if (!security_mls_enabled())
 		return 1;
 
 	return ((l1->sens =3D=3D l2->sens) &&
@@ -36,7 +37,7 @@ static inline int mls_level_eq(struct ml
 
 static inline int mls_level_dom(struct mls_level *l1, struct mls_level *l2)
 {
-	if (!selinux_mls_enabled)
+	if (!security_mls_enabled())
 		return 1;
 
 	return ((l1->sens >=3D l2->sens) &&
diff -pruN security-testing-2.6/security/selinux/ss/policydb.c security-testing-2.6-new/security/selinux/ss/policydb.c
--- security-testing-2.6/security/selinux/ss/policydb.c	2010-01-29 02:02:47.740046077 +0100
+++ security-testing-2.6-new/security/selinux/ss/policydb.c	2010-02-01 22:12:18.601226073 +0100
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
+	if (p->mls_enabled)
 		printk(", %d sens, %d cats", p->p_levels.nprim,
 		       p->p_cats.nprim);
 	printk("n");
@@ -1717,14 +1715,12 @@ int policydb_read(struct policydb *p, vo
 	int i, j, rc;
 	__le32 buf[4];
 	u32 nodebuf[8];
-	u32 len, len2, config, nprim, nel, nel2;
+	u32 len, len2, nprim, nel, nel2;
 	char *policydb_str;
 	struct policydb_compat_info *info;
 	struct range_trans *rt;
 	struct mls_range *r;
 
-	config =3D 0;
-
 	rc =3D policydb_init(p);
 	if (rc)
 		goto out;
@@ -1772,7 +1768,7 @@ int policydb_read(struct policydb *p, vo
 	kfree(policydb_str);
 	policydb_str =3D NULL;
 
-	/* Read the version, config, and table sizes. */
+	/* Read the version and table sizes. */
 	rc =3D next_entry(buf, fp, sizeof(u32)*4);
 	if (rc < 0)
 		goto bad;
@@ -1787,13 +1783,7 @@ int policydb_read(struct policydb *p, vo
 	}
 
 	if ((le32_to_cpu(buf[1]) & POLICYDB_CONFIG_MLS)) {
-		if (ss_initialized && !selinux_mls_enabled) {
-			printk(KERN_ERR "SELinux: Cannot switch between non-MLS"
-				" and MLS policiesn");
-			goto bad;
-		}
-		selinux_mls_enabled =3D 1;
-		config |=3D POLICYDB_CONFIG_MLS;
+		p->mls_enabled =3D 1;
 
 		if (p->policyvers < POLICYDB_VERSION_MLS) {
 			printk(KERN_ERR "SELinux: security policydb version %d "
@@ -1801,12 +1791,6 @@ int policydb_read(struct policydb *p, vo
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
diff -pruN security-testing-2.6/security/selinux/ss/policydb.h security-testing-2.6-new/security/selinux/ss/policydb.h
--- security-testing-2.6/security/selinux/ss/policydb.h	2010-01-29 02:02:47.740046077 +0100
+++ security-testing-2.6-new/security/selinux/ss/policydb.h	2010-02-01 20:47:08.352232380 +0100
@@ -27,6 +27,8 @@
 #include "symtab.h"
 #include "avtab.h"
 #include "sidtab.h"
+#include "ebitmap.h"
+#include "mls_types.h"
 #include "context.h"
 #include "constraint.h"
 
@@ -185,6 +187,8 @@ struct genfs {
 
 /* The policy database */
 struct policydb {
+	int mls_enabled;
+
 	/* symbol tables */
 	struct symtab symtab[SYM_NUM];
 #define p_commons symtab[SYM_COMMONS]
diff -pruN security-testing-2.6/security/selinux/ss/services.c security-testing-2.6-new/security/selinux/ss/services.c
--- security-testing-2.6/security/selinux/ss/services.c	2010-01-29 02:02:47.742042805 +0100
+++ security-testing-2.6-new/security/selinux/ss/services.c	2010-02-01 22:41:08.730228020 +0100
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
@@ -232,6 +236,16 @@ static void map_decision(u16 tclass, str
 	}
 }
 
+/*
+ * Returns a boolean value.
+ * True: if the specified policy is MLS or MCS
+ * False: if the specified policy is a standard policy
+ * 	  without MLS/MCS support
+ */
+int security_mls_enabled(void)
+{
+	return policydb.mls_enabled;
+}
 
 /*
  * Return the boolean value of a constraint expression
@@ -1547,6 +1561,8 @@ static int convert_context(u32 key,
 {
 	struct convert_context_args *args;
 	struct context oldc;
+	struct ocontext *oc;
+	struct mls_range *range;
 	struct role_datum *role;
 	struct type_datum *typdatum;
 	struct user_datum *usrdatum;
@@ -1614,9 +1630,48 @@ static int convert_context(u32 key,
 		goto bad;
 	c->type =3D typdatum->value;
 
-	rc =3D mls_convert_context(args->oldp, args->newp, c);
-	if (rc)
-		goto bad;
+	/* Convert the MLS/MCS fields if dealing with MLS/MCS policies */
+	if (args->oldp->mls_enabled
+	    && args->newp->mls_enabled) {
+		rc =3D mls_convert_context(args->oldp, args->newp, c);
+		if (rc)
+			goto bad;
+	}
+
+	/*
+	 * Switching between MLS/MCS and non-MLS/non-MCS policy:
+	 * free any storage used by the MLS fields in the
+	 * context for all existing entries in the sidtab.
+	 */
+	if (args->oldp->mls_enabled && !args->newp->mls_enabled)
+		mls_context_destroy(c);
+
+	/*
+	 * Switching between non-MLS/non-MCS and MLS/MCS policy:
+	 * ensure that the MLS fields of the context for all
+	 * existing entries in the sidtab are filled in with a
+	 * suitable default value, likely taken from one of the
+	 * initial SIDs.
+	 */
+	if (!args->oldp->mls_enabled && args->newp->mls_enabled) {
+		oc =3D args->newp->ocontexts[OCON_ISID];
+		while (oc && oc->sid[0] !=3D SECINITSID_UNLABELED)
+			oc =3D oc->next;
+		range =3D &oc->context[0].range;
+		rc =3D mls_range_set(c, range);
+		if (rc) {
+			if (context_struct_to_string(&oldc, &s, &len))
+				return -ENOMEM;
+			context_destroy(&oldc);
+			context_destroy(c);
+			c->str =3D s;
+			c->len =3D len;
+			printk(KERN_ERR "SELinux:  Failed to set"
+				" the MLS/MCS range for context"
+				" %sn", c->str);
+			goto out;
+		}
+	}
 
 	/* Check the validity of the new context. */
 	if (!policydb_context_isvalid(args->newp, c)) {
@@ -1712,6 +1767,14 @@ int security_load_policy(void *data, siz
 	if (policydb_read(&newpolicydb, fp))
 		return -EINVAL;
 
+	/* If switching between different policy types, log it */
+	if (policydb.mls_enabled && !newpolicydb.mls_enabled)
+		printk(KERN_INFO "SELinux: Switching between MLS/MCS"
+			" and standard policy...n");
+	else if (!policydb.mls_enabled && newpolicydb.mls_enabled)
+		printk(KERN_INFO "SELinux: Switching between standard"
+			" and MLS/MCS policy...n");
+
 	if (sidtab_init(&newsidtab)) {
 		policydb_destroy(&newpolicydb);
 		return -ENOMEM;
@@ -1741,8 +1804,12 @@ int security_load_policy(void *data, siz
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
@@ -2338,7 +2405,7 @@ int security_sid_mls_copy(u32 sid, u32 m
 	u32 len;
 	int rc =3D 0;
 
-	if (!ss_initialized || !selinux_mls_enabled) {
+	if (!ss_initialized || !policydb.mls_enabled) {
 		*new_sid =3D sid;
 		goto out;
 	}
@@ -2439,7 +2506,7 @@ int security_net_peersid_resolve(u32 nlb
 	/* we don't need to check ss_initialized here since the only way both
 	 * nlbl_sid and xfrm_sid are not equal to SECSID_NULL would be if the
 	 * security server was initialized and ss_initialized was true */
-	if (!selinux_mls_enabled) {
+	if (!policydb.mls_enabled) {
 		*peer_sid =3D SECSID_NULL;
 		return 0;
 	}
diff -pruN security-testing-2.6/security/selinux/ss/services.h security-testing-2.6-new/security/selinux/ss/services.h
--- security-testing-2.6/security/selinux/ss/services.h	2010-01-29 01:06:42.174044406 +0100
+++ security-testing-2.6-new/security/selinux/ss/services.h	2010-02-01 18:26:32.682234915 +0100
@@ -3,6 +3,7 @@
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+
 #ifndef _SS_SERVICES_H_
 #define _SS_SERVICES_H_
 
diff -pruN security-testing-2.6/security/selinux/ss/sidtab.h security-testing-2.6-new/security/selinux/ss/sidtab.h
--- security-testing-2.6/security/selinux/ss/sidtab.h	2010-01-29 01:06:42.175047659 +0100
+++ security-testing-2.6-new/security/selinux/ss/sidtab.h	2010-02-01 20:38:09.350520786 +0100
@@ -51,4 +51,3 @@ void sidtab_shutdown(struct sidtab *s);
 
 #endif	/* _SS_SIDTAB_H_ */
 
-
diff -pruN security-testing-2.6/security/selinux/ss/symtab.h security-testing-2.6-new/security/selinux/ss/symtab.h
--- security-testing-2.6/security/selinux/ss/symtab.h	2010-01-29 01:06:42.176055661 +0100
+++ security-testing-2.6-new/security/selinux/ss/symtab.h	2010-02-01 20:50:54.661232717 +0100
@@ -6,6 +6,7 @@
  *
  * Author : Stephen Smalley, <sds@epoch.ncsc.mil>
  */
+
 #ifndef _SS_SYMTAB_H_
 #define _SS_SYMTAB_H_
  

------_=_NextPart_001_9fe8a8d645530711cd3f253a87164eb0--

------_=_NextPart_000_a4082aefb076d7807edd6567bdc721de
Content-Type: application/octet-stream;
	name="switch-policy.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="switch-policy.patch"

QXV0aG9yOiBHdWlkbyBUcmVudGFsYW5jaWEgPGd1aWRvQHRyZW50YWxhbmNp
YS5jb20+CkRhdGU6ICAgTW9uIEZlYiAwMSAyMjozNDoxNiAyMDEwICswMTAw
CgogICAgQWxsb3cgcnVudGltZSBzd2l0Y2hpbmcgYmV0d2VlbiBkaWZmZXJl
bnQgcG9saWN5IHR5cGVzIChlLmcuIGZyb20gYSBNTFMvTUNTCiAgICBwb2xp
Y3kgdG8gYSBub24tTUxTL25vbi1NQ1MgcG9saWN5IG9yIHZpY2V2ZXJzYSku
CgogICAgU2lnbmVkLW9mZi1ieTogR3VpZG8gVHJlbnRhbGFuY2lhIDxndWlk
b0B0cmVudGFsYW5jaWEuY29tPgoKZGlmZiAtcHJ1TiBzZWN1cml0eS10ZXN0
aW5nLTIuNi9zZWN1cml0eS9zZWxpbnV4L2luY2x1ZGUvc2VjdXJpdHkuaCBz
ZWN1cml0eS10ZXN0aW5nLTIuNi1uZXcvc2VjdXJpdHkvc2VsaW51eC9pbmNs
dWRlL3NlY3VyaXR5LmgKLS0tIHNlY3VyaXR5LXRlc3RpbmctMi42L3NlY3Vy
aXR5L3NlbGludXgvaW5jbHVkZS9zZWN1cml0eS5oCTIwMTAtMDEtMjkgMDI6
MDI6NDcuNzM3MDQ1MjU4ICswMTAwCisrKyBzZWN1cml0eS10ZXN0aW5nLTIu
Ni1uZXcvc2VjdXJpdHkvc2VsaW51eC9pbmNsdWRlL3NlY3VyaXR5LmgJMjAx
MC0wMi0wMSAyMjowNjozOC4wNTMyMjUwNTIgKzAxMDAKQEAgLTU3LDcgKzU3
LDcgQEAKIHN0cnVjdCBuZXRsYmxfbHNtX3NlY2F0dHI7CiAKIGV4dGVybiBp
bnQgc2VsaW51eF9lbmFibGVkOwotZXh0ZXJuIGludCBzZWxpbnV4X21sc19l
bmFibGVkOworZXh0ZXJuIHN0cnVjdCBwb2xpY3lkYiBwb2xpY3lkYjsKIAog
LyogUG9saWN5IGNhcGFiaWxpdGllcyAqLwogZW51bSB7CkBAIC04MCw2ICs4
MCw4IEBAIGV4dGVybiBpbnQgc2VsaW51eF9wb2xpY3ljYXBfb3BlbnBlcm07
CiAvKiBsaW1pdGF0aW9uIG9mIGJvdW5kYXJ5IGRlcHRoICAqLwogI2RlZmlu
ZSBQT0xJQ1lEQl9CT1VORFNfTUFYREVQVEgJNAogCitpbnQgc2VjdXJpdHlf
bWxzX2VuYWJsZWQodm9pZCk7CisKIGludCBzZWN1cml0eV9sb2FkX3BvbGlj
eSh2b2lkICpkYXRhLCBzaXplX3QgbGVuKTsKIAogaW50IHNlY3VyaXR5X3Bv
bGljeWNhcF9zdXBwb3J0ZWQodW5zaWduZWQgaW50IHJlcV9jYXApOwpkaWZm
IC1wcnVOIHNlY3VyaXR5LXRlc3RpbmctMi42L3NlY3VyaXR5L3NlbGludXgv
c2VsaW51eGZzLmMgc2VjdXJpdHktdGVzdGluZy0yLjYtbmV3L3NlY3VyaXR5
L3NlbGludXgvc2VsaW51eGZzLmMKLS0tIHNlY3VyaXR5LXRlc3RpbmctMi42
L3NlY3VyaXR5L3NlbGludXgvc2VsaW51eGZzLmMJMjAxMC0wMS0yOSAwMjow
Mjo0Ny43MzgwNDY4MzUgKzAxMDAKKysrIHNlY3VyaXR5LXRlc3RpbmctMi42
LW5ldy9zZWN1cml0eS9zZWxpbnV4L3NlbGludXhmcy5jCTIwMTAtMDItMDEg
MjI6MDY6MjEuNzA5MjM0MDM5ICswMTAwCkBAIC0yODIsNyArMjgyLDggQEAg
c3RhdGljIHNzaXplX3Qgc2VsX3JlYWRfbWxzKHN0cnVjdCBmaWxlIAogCWNo
YXIgdG1wYnVmW1RNUEJVRkxFTl07CiAJc3NpemVfdCBsZW5ndGg7CiAKLQls
ZW5ndGggPSBzY25wcmludGYodG1wYnVmLCBUTVBCVUZMRU4sICIlZCIsIHNl
bGludXhfbWxzX2VuYWJsZWQpOworCWxlbmd0aCA9IHNjbnByaW50Zih0bXBi
dWYsIFRNUEJVRkxFTiwgIiVkIiwKKwkJCSAgIHNlY3VyaXR5X21sc19lbmFi
bGVkKCkpOwogCXJldHVybiBzaW1wbGVfcmVhZF9mcm9tX2J1ZmZlcihidWYs
IGNvdW50LCBwcG9zLCB0bXBidWYsIGxlbmd0aCk7CiB9CiAKZGlmZiAtcHJ1
TiBzZWN1cml0eS10ZXN0aW5nLTIuNi9zZWN1cml0eS9zZWxpbnV4L3NzL2Nv
bnN0cmFpbnQuaCBzZWN1cml0eS10ZXN0aW5nLTIuNi1uZXcvc2VjdXJpdHkv
c2VsaW51eC9zcy9jb25zdHJhaW50LmgKLS0tIHNlY3VyaXR5LXRlc3Rpbmct
Mi42L3NlY3VyaXR5L3NlbGludXgvc3MvY29uc3RyYWludC5oCTIwMTAtMDEt
MjkgMDE6MDY6NDIuMTYwMDYwMzMyICswMTAwCisrKyBzZWN1cml0eS10ZXN0
aW5nLTIuNi1uZXcvc2VjdXJpdHkvc2VsaW51eC9zcy9jb25zdHJhaW50LmgJ
MjAxMC0wMi0wMSAyMDo1MDoxOS44NjAyMjcwMjUgKzAxMDAKQEAgLTEyLDYg
KzEyLDcgQEAKICAqCiAgKiBBdXRob3IgOiBTdGVwaGVuIFNtYWxsZXksIDxz
ZHNAZXBvY2gubmNzYy5taWw+CiAgKi8KKwogI2lmbmRlZiBfU1NfQ09OU1RS
QUlOVF9IXwogI2RlZmluZSBfU1NfQ09OU1RSQUlOVF9IXwogCmRpZmYgLXBy
dU4gc2VjdXJpdHktdGVzdGluZy0yLjYvc2VjdXJpdHkvc2VsaW51eC9zcy9j
b250ZXh0Lmggc2VjdXJpdHktdGVzdGluZy0yLjYtbmV3L3NlY3VyaXR5L3Nl
bGludXgvc3MvY29udGV4dC5oCi0tLSBzZWN1cml0eS10ZXN0aW5nLTIuNi9z
ZWN1cml0eS9zZWxpbnV4L3NzL2NvbnRleHQuaAkyMDEwLTAxLTI5IDAxOjA2
OjQyLjE2MDA2MDMzMiArMDEwMAorKysgc2VjdXJpdHktdGVzdGluZy0yLjYt
bmV3L3NlY3VyaXR5L3NlbGludXgvc3MvY29udGV4dC5oCTIwMTAtMDItMDEg
MjI6MjI6MzMuMDkwMjM0NTg3ICswMTAwCkBAIC0xMiw2ICsxMiw3IEBACiAg
KgogICogQXV0aG9yIDogU3RlcGhlbiBTbWFsbGV5LCA8c2RzQGVwb2NoLm5j
c2MubWlsPgogICovCisKICNpZm5kZWYgX1NTX0NPTlRFWFRfSF8KICNkZWZp
bmUgX1NTX0NPTlRFWFRfSF8KIApAQCAtNDEsNyArNDIsNyBAQCBzdGF0aWMg
aW5saW5lIGludCBtbHNfY29udGV4dF9jcHkoc3RydWN0CiB7CiAJaW50IHJj
OwogCi0JaWYgKCFzZWxpbnV4X21sc19lbmFibGVkKQorCWlmICghc2VjdXJp
dHlfbWxzX2VuYWJsZWQoKSkKIAkJcmV0dXJuIDA7CiAKIAlkc3QtPnJhbmdl
LmxldmVsWzBdLnNlbnMgPSBzcmMtPnJhbmdlLmxldmVsWzBdLnNlbnM7CkBA
IC02NCw3ICs2NSw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IG1sc19jb250ZXh0
X2NweV9sb3coc3QKIHsKIAlpbnQgcmM7CiAKLQlpZiAoIXNlbGludXhfbWxz
X2VuYWJsZWQpCisJaWYgKCFzZWN1cml0eV9tbHNfZW5hYmxlZCgpKQogCQly
ZXR1cm4gMDsKIAogCWRzdC0+cmFuZ2UubGV2ZWxbMF0uc2VucyA9IHNyYy0+
cmFuZ2UubGV2ZWxbMF0uc2VuczsKQEAgLTgyLDcgKzgzLDcgQEAgb3V0Ogog
CiBzdGF0aWMgaW5saW5lIGludCBtbHNfY29udGV4dF9jbXAoc3RydWN0IGNv
bnRleHQgKmMxLCBzdHJ1Y3QgY29udGV4dCAqYzIpCiB7Ci0JaWYgKCFzZWxp
bnV4X21sc19lbmFibGVkKQorCWlmICghc2VjdXJpdHlfbWxzX2VuYWJsZWQo
KSkKIAkJcmV0dXJuIDE7CiAKIAlyZXR1cm4gKChjMS0+cmFuZ2UubGV2ZWxb
MF0uc2VucyA9PSBjMi0+cmFuZ2UubGV2ZWxbMF0uc2VucykgJiYKQEAgLTkz
LDkgKzk0LDYgQEAgc3RhdGljIGlubGluZSBpbnQgbWxzX2NvbnRleHRfY21w
KHN0cnVjdAogCiBzdGF0aWMgaW5saW5lIHZvaWQgbWxzX2NvbnRleHRfZGVz
dHJveShzdHJ1Y3QgY29udGV4dCAqYykKIHsKLQlpZiAoIXNlbGludXhfbWxz
X2VuYWJsZWQpCi0JCXJldHVybjsKLQogCWViaXRtYXBfZGVzdHJveSgmYy0+
cmFuZ2UubGV2ZWxbMF0uY2F0KTsKIAllYml0bWFwX2Rlc3Ryb3koJmMtPnJh
bmdlLmxldmVsWzFdLmNhdCk7CiAJbWxzX2NvbnRleHRfaW5pdChjKTsKZGlm
ZiAtcHJ1TiBzZWN1cml0eS10ZXN0aW5nLTIuNi9zZWN1cml0eS9zZWxpbnV4
L3NzL21scy5jIHNlY3VyaXR5LXRlc3RpbmctMi42LW5ldy9zZWN1cml0eS9z
ZWxpbnV4L3NzL21scy5jCi0tLSBzZWN1cml0eS10ZXN0aW5nLTIuNi9zZWN1
cml0eS9zZWxpbnV4L3NzL21scy5jCTIwMTAtMDEtMjkgMDI6MDI6NDcuNzM5
MDQ2MTc3ICswMTAwCisrKyBzZWN1cml0eS10ZXN0aW5nLTIuNi1uZXcvc2Vj
dXJpdHkvc2VsaW51eC9zcy9tbHMuYwkyMDEwLTAyLTAxIDIyOjE1OjQ4LjA2
MjIzMzcyMSArMDEwMApAQCAtMzksNyArMzksNyBAQCBpbnQgbWxzX2NvbXB1
dGVfY29udGV4dF9sZW4oc3RydWN0IGNvbnRlCiAJc3RydWN0IGViaXRtYXAg
KmU7CiAJc3RydWN0IGViaXRtYXBfbm9kZSAqbm9kZTsKIAotCWlmICghc2Vs
aW51eF9tbHNfZW5hYmxlZCkKKwlpZiAoIXBvbGljeWRiLm1sc19lbmFibGVk
KQogCQlyZXR1cm4gMDsKIAogCWxlbiA9IDE7IC8qIGZvciB0aGUgYmVnaW5u
aW5nICI6IiAqLwpAQCAtOTMsNyArOTMsNyBAQCB2b2lkIG1sc19zaWRfdG9f
Y29udGV4dChzdHJ1Y3QgY29udGV4dCAqCiAJc3RydWN0IGViaXRtYXAgKmU7
CiAJc3RydWN0IGViaXRtYXBfbm9kZSAqbm9kZTsKIAotCWlmICghc2VsaW51
eF9tbHNfZW5hYmxlZCkKKwlpZiAoIXBvbGljeWRiLm1sc19lbmFibGVkKQog
CQlyZXR1cm47CiAKIAlzY29udGV4dHAgPSAqc2NvbnRleHQ7CkBAIC0yMDAs
NyArMjAwLDcgQEAgaW50IG1sc19jb250ZXh0X2lzdmFsaWQoc3RydWN0IHBv
bGljeWRiIAogewogCXN0cnVjdCB1c2VyX2RhdHVtICp1c3JkYXR1bTsKIAot
CWlmICghc2VsaW51eF9tbHNfZW5hYmxlZCkKKwlpZiAoIXAtPm1sc19lbmFi
bGVkKQogCQlyZXR1cm4gMTsKIAogCWlmICghbWxzX3JhbmdlX2lzdmFsaWQo
cCwgJmMtPnJhbmdlKSkKQEAgLTI1Myw3ICsyNTMsNyBAQCBpbnQgbWxzX2Nv
bnRleHRfdG9fc2lkKHN0cnVjdCBwb2xpY3lkYiAqCiAJc3RydWN0IGNhdF9k
YXR1bSAqY2F0ZGF0dW0sICpybmdkYXR1bTsKIAlpbnQgbCwgcmMgPSAtRUlO
VkFMOwogCi0JaWYgKCFzZWxpbnV4X21sc19lbmFibGVkKSB7CisJaWYgKCFw
b2wtPm1sc19lbmFibGVkKSB7CiAJCWlmIChkZWZfc2lkICE9IFNFQ1NJRF9O
VUxMICYmIG9sZGMpCiAJCQkqc2NvbnRleHQgKz0gc3RybGVuKCpzY29udGV4
dCkrMTsKIAkJcmV0dXJuIDA7CkBAIC0zODcsNyArMzg3LDcgQEAgaW50IG1s
c19mcm9tX3N0cmluZyhjaGFyICpzdHIsIHN0cnVjdCBjbwogCWNoYXIgKnRt
cHN0ciwgKmZyZWVzdHI7CiAJaW50IHJjOwogCi0JaWYgKCFzZWxpbnV4X21s
c19lbmFibGVkKQorCWlmICghcG9saWN5ZGIubWxzX2VuYWJsZWQpCiAJCXJl
dHVybiAtRUlOVkFMOwogCiAJLyogd2UgbmVlZCBmcmVlc3RyIGJlY2F1c2Ug
bWxzX2NvbnRleHRfdG9fc2lkIHdpbGwgY2hhbmdlCkBAIC00MDcsNyArNDA3
LDcgQEAgaW50IG1sc19mcm9tX3N0cmluZyhjaGFyICpzdHIsIHN0cnVjdCBj
bwogLyoKICAqIENvcGllcyB0aGUgTUxTIHJhbmdlIGByYW5nZScgaW50byBg
Y29udGV4dCcuCiAgKi8KLXN0YXRpYyBpbmxpbmUgaW50IG1sc19yYW5nZV9z
ZXQoc3RydWN0IGNvbnRleHQgKmNvbnRleHQsCitpbnQgbWxzX3JhbmdlX3Nl
dChzdHJ1Y3QgY29udGV4dCAqY29udGV4dCwKIAkJCQlzdHJ1Y3QgbWxzX3Jh
bmdlICpyYW5nZSkKIHsKIAlpbnQgbCwgcmMgPSAwOwpAQCAtNDI3LDcgKzQy
Nyw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IG1sc19yYW5nZV9zZXQoc3RydWN0
IGMKIGludCBtbHNfc2V0dXBfdXNlcl9yYW5nZShzdHJ1Y3QgY29udGV4dCAq
ZnJvbWNvbiwgc3RydWN0IHVzZXJfZGF0dW0gKnVzZXIsCiAJCQkgc3RydWN0
IGNvbnRleHQgKnVzZXJjb24pCiB7Ci0JaWYgKHNlbGludXhfbWxzX2VuYWJs
ZWQpIHsKKwlpZiAocG9saWN5ZGIubWxzX2VuYWJsZWQpIHsKIAkJc3RydWN0
IG1sc19sZXZlbCAqZnJvbWNvbl9zZW4gPSAmKGZyb21jb24tPnJhbmdlLmxl
dmVsWzBdKTsKIAkJc3RydWN0IG1sc19sZXZlbCAqZnJvbWNvbl9jbHIgPSAm
KGZyb21jb24tPnJhbmdlLmxldmVsWzFdKTsKIAkJc3RydWN0IG1sc19sZXZl
bCAqdXNlcl9sb3cgPSAmKHVzZXItPnJhbmdlLmxldmVsWzBdKTsKQEAgLTQ3
Nyw3ICs0NzcsNyBAQCBpbnQgbWxzX2NvbnZlcnRfY29udGV4dChzdHJ1Y3Qg
cG9saWN5ZGIgCiAJc3RydWN0IGViaXRtYXBfbm9kZSAqbm9kZTsKIAlpbnQg
bCwgaTsKIAotCWlmICghc2VsaW51eF9tbHNfZW5hYmxlZCkKKwlpZiAoIXBv
bGljeWRiLm1sc19lbmFibGVkKQogCQlyZXR1cm4gMDsKIAogCWZvciAobCA9
IDA7IGwgPCAyOyBsKyspIHsKQEAgLTUxNiw3ICs1MTYsNyBAQCBpbnQgbWxz
X2NvbXB1dGVfc2lkKHN0cnVjdCBjb250ZXh0ICpzY29uCiAJc3RydWN0IHJh
bmdlX3RyYW5zIHJ0cjsKIAlzdHJ1Y3QgbWxzX3JhbmdlICpyOwogCi0JaWYg
KCFzZWxpbnV4X21sc19lbmFibGVkKQorCWlmICghcG9saWN5ZGIubWxzX2Vu
YWJsZWQpCiAJCXJldHVybiAwOwogCiAJc3dpdGNoIChzcGVjaWZpZWQpIHsK
QEAgLTU1OSw3ICs1NTksNyBAQCBpbnQgbWxzX2NvbXB1dGVfc2lkKHN0cnVj
dCBjb250ZXh0ICpzY29uCiB2b2lkIG1sc19leHBvcnRfbmV0bGJsX2x2bChz
dHJ1Y3QgY29udGV4dCAqY29udGV4dCwKIAkJCSAgIHN0cnVjdCBuZXRsYmxf
bHNtX3NlY2F0dHIgKnNlY2F0dHIpCiB7Ci0JaWYgKCFzZWxpbnV4X21sc19l
bmFibGVkKQorCWlmICghcG9saWN5ZGIubWxzX2VuYWJsZWQpCiAJCXJldHVy
bjsKIAogCXNlY2F0dHItPmF0dHIubWxzLmx2bCA9IGNvbnRleHQtPnJhbmdl
LmxldmVsWzBdLnNlbnMgLSAxOwpAQCAtNTc5LDcgKzU3OSw3IEBAIHZvaWQg
bWxzX2V4cG9ydF9uZXRsYmxfbHZsKHN0cnVjdCBjb250ZXgKIHZvaWQgbWxz
X2ltcG9ydF9uZXRsYmxfbHZsKHN0cnVjdCBjb250ZXh0ICpjb250ZXh0LAog
CQkJICAgc3RydWN0IG5ldGxibF9sc21fc2VjYXR0ciAqc2VjYXR0cikKIHsK
LQlpZiAoIXNlbGludXhfbWxzX2VuYWJsZWQpCisJaWYgKCFwb2xpY3lkYi5t
bHNfZW5hYmxlZCkKIAkJcmV0dXJuOwogCiAJY29udGV4dC0+cmFuZ2UubGV2
ZWxbMF0uc2VucyA9IHNlY2F0dHItPmF0dHIubWxzLmx2bCArIDE7CkBAIC02
MDEsNyArNjAxLDcgQEAgaW50IG1sc19leHBvcnRfbmV0bGJsX2NhdChzdHJ1
Y3QgY29udGV4dAogewogCWludCByYzsKIAotCWlmICghc2VsaW51eF9tbHNf
ZW5hYmxlZCkKKwlpZiAoIXBvbGljeWRiLm1sc19lbmFibGVkKQogCQlyZXR1
cm4gMDsKIAogCXJjID0gZWJpdG1hcF9uZXRsYmxfZXhwb3J0KCZjb250ZXh0
LT5yYW5nZS5sZXZlbFswXS5jYXQsCkBAIC02MjksNyArNjI5LDcgQEAgaW50
IG1sc19pbXBvcnRfbmV0bGJsX2NhdChzdHJ1Y3QgY29udGV4dAogewogCWlu
dCByYzsKIAotCWlmICghc2VsaW51eF9tbHNfZW5hYmxlZCkKKwlpZiAoIXBv
bGljeWRiLm1sc19lbmFibGVkKQogCQlyZXR1cm4gMDsKIAogCXJjID0gZWJp
dG1hcF9uZXRsYmxfaW1wb3J0KCZjb250ZXh0LT5yYW5nZS5sZXZlbFswXS5j
YXQsCmRpZmYgLXBydU4gc2VjdXJpdHktdGVzdGluZy0yLjYvc2VjdXJpdHkv
c2VsaW51eC9zcy9tbHMuaCBzZWN1cml0eS10ZXN0aW5nLTIuNi1uZXcvc2Vj
dXJpdHkvc2VsaW51eC9zcy9tbHMuaAotLS0gc2VjdXJpdHktdGVzdGluZy0y
LjYvc2VjdXJpdHkvc2VsaW51eC9zcy9tbHMuaAkyMDEwLTAxLTI5IDAxOjA2
OjQyLjE2ODA1MTQzMSArMDEwMAorKysgc2VjdXJpdHktdGVzdGluZy0yLjYt
bmV3L3NlY3VyaXR5L3NlbGludXgvc3MvbWxzLmgJMjAxMC0wMi0wMSAxODo1
Nzo0Mi42OTMyMjE5NTIgKzAxMDAKQEAgLTI0LDYgKzI0LDggQEAKICNpbmNs
dWRlICJjb250ZXh0LmgiCiAjaW5jbHVkZSAicG9saWN5ZGIuaCIKIAorZXh0
ZXJuIHN0cnVjdCBwb2xpY3lkYiBwb2xpY3lkYjsKKwogaW50IG1sc19jb21w
dXRlX2NvbnRleHRfbGVuKHN0cnVjdCBjb250ZXh0ICpjb250ZXh0KTsKIHZv
aWQgbWxzX3NpZF90b19jb250ZXh0KHN0cnVjdCBjb250ZXh0ICpjb250ZXh0
LCBjaGFyICoqc2NvbnRleHQpOwogaW50IG1sc19jb250ZXh0X2lzdmFsaWQo
c3RydWN0IHBvbGljeWRiICpwLCBzdHJ1Y3QgY29udGV4dCAqYyk7CkBAIC0z
OSw2ICs0MSw4IEBAIGludCBtbHNfY29udGV4dF90b19zaWQoc3RydWN0IHBv
bGljeWRiICoKIAogaW50IG1sc19mcm9tX3N0cmluZyhjaGFyICpzdHIsIHN0
cnVjdCBjb250ZXh0ICpjb250ZXh0LCBnZnBfdCBnZnBfbWFzayk7CiAKK2lu
dCBtbHNfcmFuZ2Vfc2V0KHN0cnVjdCBjb250ZXh0ICpjb250ZXh0LCBzdHJ1
Y3QgbWxzX3JhbmdlICpyYW5nZSk7CisKIGludCBtbHNfY29udmVydF9jb250
ZXh0KHN0cnVjdCBwb2xpY3lkYiAqb2xkcCwKIAkJCXN0cnVjdCBwb2xpY3lk
YiAqbmV3cCwKIAkJCXN0cnVjdCBjb250ZXh0ICpjb250ZXh0KTsKZGlmZiAt
cHJ1TiBzZWN1cml0eS10ZXN0aW5nLTIuNi9zZWN1cml0eS9zZWxpbnV4L3Nz
L21sc190eXBlcy5oIHNlY3VyaXR5LXRlc3RpbmctMi42LW5ldy9zZWN1cml0
eS9zZWxpbnV4L3NzL21sc190eXBlcy5oCi0tLSBzZWN1cml0eS10ZXN0aW5n
LTIuNi9zZWN1cml0eS9zZWxpbnV4L3NzL21sc190eXBlcy5oCTIwMTAtMDEt
MjkgMDE6MDY6NDIuMTY4MDUxNDMxICswMTAwCisrKyBzZWN1cml0eS10ZXN0
aW5nLTIuNi1uZXcvc2VjdXJpdHkvc2VsaW51eC9zcy9tbHNfdHlwZXMuaAky
MDEwLTAyLTAxIDIyOjIzOjExLjc5OTIyNDc3MSArMDEwMApAQCAtMTUsNiAr
MTUsNyBAQAogI2RlZmluZSBfU1NfTUxTX1RZUEVTX0hfCiAKICNpbmNsdWRl
ICJzZWN1cml0eS5oIgorI2luY2x1ZGUgImViaXRtYXAuaCIKIAogc3RydWN0
IG1sc19sZXZlbCB7CiAJdTMyIHNlbnM7CQkvKiBzZW5zaXRpdml0eSAqLwpA
QCAtMjcsNyArMjgsNyBAQCBzdHJ1Y3QgbWxzX3JhbmdlIHsKIAogc3RhdGlj
IGlubGluZSBpbnQgbWxzX2xldmVsX2VxKHN0cnVjdCBtbHNfbGV2ZWwgKmwx
LCBzdHJ1Y3QgbWxzX2xldmVsICpsMikKIHsKLQlpZiAoIXNlbGludXhfbWxz
X2VuYWJsZWQpCisJaWYgKCFzZWN1cml0eV9tbHNfZW5hYmxlZCgpKQogCQly
ZXR1cm4gMTsKIAogCXJldHVybiAoKGwxLT5zZW5zID09IGwyLT5zZW5zKSAm
JgpAQCAtMzYsNyArMzcsNyBAQCBzdGF0aWMgaW5saW5lIGludCBtbHNfbGV2
ZWxfZXEoc3RydWN0IG1sCiAKIHN0YXRpYyBpbmxpbmUgaW50IG1sc19sZXZl
bF9kb20oc3RydWN0IG1sc19sZXZlbCAqbDEsIHN0cnVjdCBtbHNfbGV2ZWwg
KmwyKQogewotCWlmICghc2VsaW51eF9tbHNfZW5hYmxlZCkKKwlpZiAoIXNl
Y3VyaXR5X21sc19lbmFibGVkKCkpCiAJCXJldHVybiAxOwogCiAJcmV0dXJu
ICgobDEtPnNlbnMgPj0gbDItPnNlbnMpICYmCmRpZmYgLXBydU4gc2VjdXJp
dHktdGVzdGluZy0yLjYvc2VjdXJpdHkvc2VsaW51eC9zcy9wb2xpY3lkYi5j
IHNlY3VyaXR5LXRlc3RpbmctMi42LW5ldy9zZWN1cml0eS9zZWxpbnV4L3Nz
L3BvbGljeWRiLmMKLS0tIHNlY3VyaXR5LXRlc3RpbmctMi42L3NlY3VyaXR5
L3NlbGludXgvc3MvcG9saWN5ZGIuYwkyMDEwLTAxLTI5IDAyOjAyOjQ3Ljc0
MDA0NjA3NyArMDEwMAorKysgc2VjdXJpdHktdGVzdGluZy0yLjYtbmV3L3Nl
Y3VyaXR5L3NlbGludXgvc3MvcG9saWN5ZGIuYwkyMDEwLTAyLTAxIDIyOjEy
OjE4LjYwMTIyNjA3MyArMDEwMApAQCAtNTIsOCArNTIsNiBAQCBzdGF0aWMg
Y2hhciAqc3ltdGFiX25hbWVbU1lNX05VTV0gPSB7CiB9OwogI2VuZGlmCiAK
LWludCBzZWxpbnV4X21sc19lbmFibGVkOwotCiBzdGF0aWMgdW5zaWduZWQg
aW50IHN5bXRhYl9zaXplc1tTWU1fTlVNXSA9IHsKIAkyLAogCTMyLApAQCAt
NDU1LDcgKzQ1Myw3IEBAIHN0YXRpYyBpbnQgcG9saWN5ZGJfaW5kZXhfb3Ro
ZXJzKHN0cnVjdCAKIAogCXByaW50ayhLRVJOX0RFQlVHICJTRUxpbnV4OiAg
JWQgdXNlcnMsICVkIHJvbGVzLCAlZCB0eXBlcywgJWQgYm9vbHMiLAogCSAg
ICAgICBwLT5wX3VzZXJzLm5wcmltLCBwLT5wX3JvbGVzLm5wcmltLCBwLT5w
X3R5cGVzLm5wcmltLCBwLT5wX2Jvb2xzLm5wcmltKTsKLQlpZiAoc2VsaW51
eF9tbHNfZW5hYmxlZCkKKwlpZiAocC0+bWxzX2VuYWJsZWQpCiAJCXByaW50
aygiLCAlZCBzZW5zLCAlZCBjYXRzIiwgcC0+cF9sZXZlbHMubnByaW0sCiAJ
CSAgICAgICBwLT5wX2NhdHMubnByaW0pOwogCXByaW50aygiXG4iKTsKQEAg
LTE3MTcsMTQgKzE3MTUsMTIgQEAgaW50IHBvbGljeWRiX3JlYWQoc3RydWN0
IHBvbGljeWRiICpwLCB2bwogCWludCBpLCBqLCByYzsKIAlfX2xlMzIgYnVm
WzRdOwogCXUzMiBub2RlYnVmWzhdOwotCXUzMiBsZW4sIGxlbjIsIGNvbmZp
ZywgbnByaW0sIG5lbCwgbmVsMjsKKwl1MzIgbGVuLCBsZW4yLCBucHJpbSwg
bmVsLCBuZWwyOwogCWNoYXIgKnBvbGljeWRiX3N0cjsKIAlzdHJ1Y3QgcG9s
aWN5ZGJfY29tcGF0X2luZm8gKmluZm87CiAJc3RydWN0IHJhbmdlX3RyYW5z
ICpydDsKIAlzdHJ1Y3QgbWxzX3JhbmdlICpyOwogCi0JY29uZmlnID0gMDsK
LQogCXJjID0gcG9saWN5ZGJfaW5pdChwKTsKIAlpZiAocmMpCiAJCWdvdG8g
b3V0OwpAQCAtMTc3Miw3ICsxNzY4LDcgQEAgaW50IHBvbGljeWRiX3JlYWQo
c3RydWN0IHBvbGljeWRiICpwLCB2bwogCWtmcmVlKHBvbGljeWRiX3N0cik7
CiAJcG9saWN5ZGJfc3RyID0gTlVMTDsKIAotCS8qIFJlYWQgdGhlIHZlcnNp
b24sIGNvbmZpZywgYW5kIHRhYmxlIHNpemVzLiAqLworCS8qIFJlYWQgdGhl
IHZlcnNpb24gYW5kIHRhYmxlIHNpemVzLiAqLwogCXJjID0gbmV4dF9lbnRy
eShidWYsIGZwLCBzaXplb2YodTMyKSo0KTsKIAlpZiAocmMgPCAwKQogCQln
b3RvIGJhZDsKQEAgLTE3ODcsMTMgKzE3ODMsNyBAQCBpbnQgcG9saWN5ZGJf
cmVhZChzdHJ1Y3QgcG9saWN5ZGIgKnAsIHZvCiAJfQogCiAJaWYgKChsZTMy
X3RvX2NwdShidWZbMV0pICYgUE9MSUNZREJfQ09ORklHX01MUykpIHsKLQkJ
aWYgKHNzX2luaXRpYWxpemVkICYmICFzZWxpbnV4X21sc19lbmFibGVkKSB7
Ci0JCQlwcmludGsoS0VSTl9FUlIgIlNFTGludXg6IENhbm5vdCBzd2l0Y2gg
YmV0d2VlbiBub24tTUxTIgotCQkJCSIgYW5kIE1MUyBwb2xpY2llc1xuIik7
Ci0JCQlnb3RvIGJhZDsKLQkJfQotCQlzZWxpbnV4X21sc19lbmFibGVkID0g
MTsKLQkJY29uZmlnIHw9IFBPTElDWURCX0NPTkZJR19NTFM7CisJCXAtPm1s
c19lbmFibGVkID0gMTsKIAogCQlpZiAocC0+cG9saWN5dmVycyA8IFBPTElD
WURCX1ZFUlNJT05fTUxTKSB7CiAJCQlwcmludGsoS0VSTl9FUlIgIlNFTGlu
dXg6IHNlY3VyaXR5IHBvbGljeWRiIHZlcnNpb24gJWQgIgpAQCAtMTgwMSwx
MiArMTc5MSw2IEBAIGludCBwb2xpY3lkYl9yZWFkKHN0cnVjdCBwb2xpY3lk
YiAqcCwgdm8KIAkJCQlwLT5wb2xpY3l2ZXJzKTsKIAkJCWdvdG8gYmFkOwog
CQl9Ci0JfSBlbHNlIHsKLQkJaWYgKHNzX2luaXRpYWxpemVkICYmIHNlbGlu
dXhfbWxzX2VuYWJsZWQpIHsKLQkJCXByaW50ayhLRVJOX0VSUiAiU0VMaW51
eDogQ2Fubm90IHN3aXRjaCBiZXR3ZWVuIE1MUyBhbmQiCi0JCQkJIiBub24t
TUxTIHBvbGljaWVzXG4iKTsKLQkJCWdvdG8gYmFkOwotCQl9CiAJfQogCXAt
PnJlamVjdF91bmtub3duID0gISEobGUzMl90b19jcHUoYnVmWzFdKSAmIFJF
SkVDVF9VTktOT1dOKTsKIAlwLT5hbGxvd191bmtub3duID0gISEobGUzMl90
b19jcHUoYnVmWzFdKSAmIEFMTE9XX1VOS05PV04pOwpkaWZmIC1wcnVOIHNl
Y3VyaXR5LXRlc3RpbmctMi42L3NlY3VyaXR5L3NlbGludXgvc3MvcG9saWN5
ZGIuaCBzZWN1cml0eS10ZXN0aW5nLTIuNi1uZXcvc2VjdXJpdHkvc2VsaW51
eC9zcy9wb2xpY3lkYi5oCi0tLSBzZWN1cml0eS10ZXN0aW5nLTIuNi9zZWN1
cml0eS9zZWxpbnV4L3NzL3BvbGljeWRiLmgJMjAxMC0wMS0yOSAwMjowMjo0
Ny43NDAwNDYwNzcgKzAxMDAKKysrIHNlY3VyaXR5LXRlc3RpbmctMi42LW5l
dy9zZWN1cml0eS9zZWxpbnV4L3NzL3BvbGljeWRiLmgJMjAxMC0wMi0wMSAy
MDo0NzowOC4zNTIyMzIzODAgKzAxMDAKQEAgLTI3LDYgKzI3LDggQEAKICNp
bmNsdWRlICJzeW10YWIuaCIKICNpbmNsdWRlICJhdnRhYi5oIgogI2luY2x1
ZGUgInNpZHRhYi5oIgorI2luY2x1ZGUgImViaXRtYXAuaCIKKyNpbmNsdWRl
ICJtbHNfdHlwZXMuaCIKICNpbmNsdWRlICJjb250ZXh0LmgiCiAjaW5jbHVk
ZSAiY29uc3RyYWludC5oIgogCkBAIC0xODUsNiArMTg3LDggQEAgc3RydWN0
IGdlbmZzIHsKIAogLyogVGhlIHBvbGljeSBkYXRhYmFzZSAqLwogc3RydWN0
IHBvbGljeWRiIHsKKwlpbnQgbWxzX2VuYWJsZWQ7CisKIAkvKiBzeW1ib2wg
dGFibGVzICovCiAJc3RydWN0IHN5bXRhYiBzeW10YWJbU1lNX05VTV07CiAj
ZGVmaW5lIHBfY29tbW9ucyBzeW10YWJbU1lNX0NPTU1PTlNdCmRpZmYgLXBy
dU4gc2VjdXJpdHktdGVzdGluZy0yLjYvc2VjdXJpdHkvc2VsaW51eC9zcy9z
ZXJ2aWNlcy5jIHNlY3VyaXR5LXRlc3RpbmctMi42LW5ldy9zZWN1cml0eS9z
ZWxpbnV4L3NzL3NlcnZpY2VzLmMKLS0tIHNlY3VyaXR5LXRlc3RpbmctMi42
L3NlY3VyaXR5L3NlbGludXgvc3Mvc2VydmljZXMuYwkyMDEwLTAxLTI5IDAy
OjAyOjQ3Ljc0MjA0MjgwNSArMDEwMAorKysgc2VjdXJpdHktdGVzdGluZy0y
LjYtbmV3L3NlY3VyaXR5L3NlbGludXgvc3Mvc2VydmljZXMuYwkyMDEwLTAy
LTAxIDIyOjQxOjA4LjczMDIyODAyMCArMDEwMApAQCAtMjYsNiArMjYsMTAg
QEAKICAqCiAgKiAgQWRkZWQgc3VwcG9ydCBmb3IgYm91bmRzIGRvbWFpbiBh
bmQgYXVkaXQgbWVzc2FnZWQgb24gbWFza2VkIHBlcm1pc3Npb25zCiAgKgor
ICogVXBkYXRlZDogR3VpZG8gVHJlbnRhbGFuY2lhIDxndWlkb0B0cmVudGFs
YW5jaWEuY29tPgorICoKKyAqICBBZGRlZCBzdXBwb3J0IGZvciBydW50aW1l
IHN3aXRjaGluZyBvZiB0aGUgcG9saWN5IHR5cGUKKyAqCiAgKiBDb3B5cmln
aHQgKEMpIDIwMDgsIDIwMDkgTkVDIENvcnBvcmF0aW9uCiAgKiBDb3B5cmln
aHQgKEMpIDIwMDYsIDIwMDcgSGV3bGV0dC1QYWNrYXJkIERldmVsb3BtZW50
IENvbXBhbnksIEwuUC4KICAqIENvcHlyaWdodCAoQykgMjAwNC0yMDA2IFRy
dXN0ZWQgQ29tcHV0ZXIgU29sdXRpb25zLCBJbmMuCkBAIC0yMzIsNiArMjM2
LDE2IEBAIHN0YXRpYyB2b2lkIG1hcF9kZWNpc2lvbih1MTYgdGNsYXNzLCBz
dHIKIAl9CiB9CiAKKy8qCisgKiBSZXR1cm5zIGEgYm9vbGVhbiB2YWx1ZS4K
KyAqIFRydWU6IGlmIHRoZSBzcGVjaWZpZWQgcG9saWN5IGlzIE1MUyBvciBN
Q1MKKyAqIEZhbHNlOiBpZiB0aGUgc3BlY2lmaWVkIHBvbGljeSBpcyBhIHN0
YW5kYXJkIHBvbGljeQorICogCSAgd2l0aG91dCBNTFMvTUNTIHN1cHBvcnQK
KyAqLworaW50IHNlY3VyaXR5X21sc19lbmFibGVkKHZvaWQpCit7CisJcmV0
dXJuIHBvbGljeWRiLm1sc19lbmFibGVkOworfQogCiAvKgogICogUmV0dXJu
IHRoZSBib29sZWFuIHZhbHVlIG9mIGEgY29uc3RyYWludCBleHByZXNzaW9u
CkBAIC0xNTQ3LDYgKzE1NjEsOCBAQCBzdGF0aWMgaW50IGNvbnZlcnRfY29u
dGV4dCh1MzIga2V5LAogewogCXN0cnVjdCBjb252ZXJ0X2NvbnRleHRfYXJn
cyAqYXJnczsKIAlzdHJ1Y3QgY29udGV4dCBvbGRjOworCXN0cnVjdCBvY29u
dGV4dCAqb2M7CisJc3RydWN0IG1sc19yYW5nZSAqcmFuZ2U7CiAJc3RydWN0
IHJvbGVfZGF0dW0gKnJvbGU7CiAJc3RydWN0IHR5cGVfZGF0dW0gKnR5cGRh
dHVtOwogCXN0cnVjdCB1c2VyX2RhdHVtICp1c3JkYXR1bTsKQEAgLTE2MTQs
OSArMTYzMCw0OCBAQCBzdGF0aWMgaW50IGNvbnZlcnRfY29udGV4dCh1MzIg
a2V5LAogCQlnb3RvIGJhZDsKIAljLT50eXBlID0gdHlwZGF0dW0tPnZhbHVl
OwogCi0JcmMgPSBtbHNfY29udmVydF9jb250ZXh0KGFyZ3MtPm9sZHAsIGFy
Z3MtPm5ld3AsIGMpOwotCWlmIChyYykKLQkJZ290byBiYWQ7CisJLyogQ29u
dmVydCB0aGUgTUxTL01DUyBmaWVsZHMgaWYgZGVhbGluZyB3aXRoIE1MUy9N
Q1MgcG9saWNpZXMgKi8KKwlpZiAoYXJncy0+b2xkcC0+bWxzX2VuYWJsZWQK
KwkgICAgJiYgYXJncy0+bmV3cC0+bWxzX2VuYWJsZWQpIHsKKwkJcmMgPSBt
bHNfY29udmVydF9jb250ZXh0KGFyZ3MtPm9sZHAsIGFyZ3MtPm5ld3AsIGMp
OworCQlpZiAocmMpCisJCQlnb3RvIGJhZDsKKwl9CisKKwkvKgorCSAqIFN3
aXRjaGluZyBiZXR3ZWVuIE1MUy9NQ1MgYW5kIG5vbi1NTFMvbm9uLU1DUyBw
b2xpY3k6CisJICogZnJlZSBhbnkgc3RvcmFnZSB1c2VkIGJ5IHRoZSBNTFMg
ZmllbGRzIGluIHRoZQorCSAqIGNvbnRleHQgZm9yIGFsbCBleGlzdGluZyBl
bnRyaWVzIGluIHRoZSBzaWR0YWIuCisJICovCisJaWYgKGFyZ3MtPm9sZHAt
Pm1sc19lbmFibGVkICYmICFhcmdzLT5uZXdwLT5tbHNfZW5hYmxlZCkKKwkJ
bWxzX2NvbnRleHRfZGVzdHJveShjKTsKKworCS8qCisJICogU3dpdGNoaW5n
IGJldHdlZW4gbm9uLU1MUy9ub24tTUNTIGFuZCBNTFMvTUNTIHBvbGljeToK
KwkgKiBlbnN1cmUgdGhhdCB0aGUgTUxTIGZpZWxkcyBvZiB0aGUgY29udGV4
dCBmb3IgYWxsCisJICogZXhpc3RpbmcgZW50cmllcyBpbiB0aGUgc2lkdGFi
IGFyZSBmaWxsZWQgaW4gd2l0aCBhCisJICogc3VpdGFibGUgZGVmYXVsdCB2
YWx1ZSwgbGlrZWx5IHRha2VuIGZyb20gb25lIG9mIHRoZQorCSAqIGluaXRp
YWwgU0lEcy4KKwkgKi8KKwlpZiAoIWFyZ3MtPm9sZHAtPm1sc19lbmFibGVk
ICYmIGFyZ3MtPm5ld3AtPm1sc19lbmFibGVkKSB7CisJCW9jID0gYXJncy0+
bmV3cC0+b2NvbnRleHRzW09DT05fSVNJRF07CisJCXdoaWxlIChvYyAmJiBv
Yy0+c2lkWzBdICE9IFNFQ0lOSVRTSURfVU5MQUJFTEVEKQorCQkJb2MgPSBv
Yy0+bmV4dDsKKwkJcmFuZ2UgPSAmb2MtPmNvbnRleHRbMF0ucmFuZ2U7CisJ
CXJjID0gbWxzX3JhbmdlX3NldChjLCByYW5nZSk7CisJCWlmIChyYykgewor
CQkJaWYgKGNvbnRleHRfc3RydWN0X3RvX3N0cmluZygmb2xkYywgJnMsICZs
ZW4pKQorCQkJCXJldHVybiAtRU5PTUVNOworCQkJY29udGV4dF9kZXN0cm95
KCZvbGRjKTsKKwkJCWNvbnRleHRfZGVzdHJveShjKTsKKwkJCWMtPnN0ciA9
IHM7CisJCQljLT5sZW4gPSBsZW47CisJCQlwcmludGsoS0VSTl9FUlIgIlNF
TGludXg6ICBGYWlsZWQgdG8gc2V0IgorCQkJCSIgdGhlIE1MUy9NQ1MgcmFu
Z2UgZm9yIGNvbnRleHQiCisJCQkJIiAlc1xuIiwgYy0+c3RyKTsKKwkJCWdv
dG8gb3V0OworCQl9CisJfQogCiAJLyogQ2hlY2sgdGhlIHZhbGlkaXR5IG9m
IHRoZSBuZXcgY29udGV4dC4gKi8KIAlpZiAoIXBvbGljeWRiX2NvbnRleHRf
aXN2YWxpZChhcmdzLT5uZXdwLCBjKSkgewpAQCAtMTcxMiw2ICsxNzY3LDE0
IEBAIGludCBzZWN1cml0eV9sb2FkX3BvbGljeSh2b2lkICpkYXRhLCBzaXoK
IAlpZiAocG9saWN5ZGJfcmVhZCgmbmV3cG9saWN5ZGIsIGZwKSkKIAkJcmV0
dXJuIC1FSU5WQUw7CiAKKwkvKiBJZiBzd2l0Y2hpbmcgYmV0d2VlbiBkaWZm
ZXJlbnQgcG9saWN5IHR5cGVzLCBsb2cgaXQgKi8KKwlpZiAocG9saWN5ZGIu
bWxzX2VuYWJsZWQgJiYgIW5ld3BvbGljeWRiLm1sc19lbmFibGVkKQorCQlw
cmludGsoS0VSTl9JTkZPICJTRUxpbnV4OiBTd2l0Y2hpbmcgYmV0d2VlbiBN
TFMvTUNTIgorCQkJIiBhbmQgc3RhbmRhcmQgcG9saWN5Li4uXG4iKTsKKwll
bHNlIGlmICghcG9saWN5ZGIubWxzX2VuYWJsZWQgJiYgbmV3cG9saWN5ZGIu
bWxzX2VuYWJsZWQpCisJCXByaW50ayhLRVJOX0lORk8gIlNFTGludXg6IFN3
aXRjaGluZyBiZXR3ZWVuIHN0YW5kYXJkIgorCQkJIiBhbmQgTUxTL01DUyBw
b2xpY3kuLi5cbiIpOworCiAJaWYgKHNpZHRhYl9pbml0KCZuZXdzaWR0YWIp
KSB7CiAJCXBvbGljeWRiX2Rlc3Ryb3koJm5ld3BvbGljeWRiKTsKIAkJcmV0
dXJuIC1FTk9NRU07CkBAIC0xNzQxLDggKzE4MDQsMTIgQEAgaW50IHNlY3Vy
aXR5X2xvYWRfcG9saWN5KHZvaWQgKmRhdGEsIHNpegogCWFyZ3Mub2xkcCA9
ICZwb2xpY3lkYjsKIAlhcmdzLm5ld3AgPSAmbmV3cG9saWN5ZGI7CiAJcmMg
PSBzaWR0YWJfbWFwKCZuZXdzaWR0YWIsIGNvbnZlcnRfY29udGV4dCwgJmFy
Z3MpOwotCWlmIChyYykKKwlpZiAocmMpIHsKKwkJcHJpbnRrKEtFUk5fRVJS
ICJTRUxpbnV4OiAgdW5hYmxlIHRvIGNvbnZlcnQgdGhlIGludGVybmFsIgor
CQkJIiByZXByZXNlbnRhdGlvbiBvZiBjb250ZXh0cyBpbiB0aGUgbmV3IFNJ
RCIKKwkJCSIgdGFibGVcbiIpOwogCQlnb3RvIGVycjsKKwl9CiAKIAkvKiBT
YXZlIHRoZSBvbGQgcG9saWN5ZGIgYW5kIFNJRCB0YWJsZSB0byBmcmVlIGxh
dGVyLiAqLwogCW1lbWNweSgmb2xkcG9saWN5ZGIsICZwb2xpY3lkYiwgc2l6
ZW9mIHBvbGljeWRiKTsKQEAgLTIzMzgsNyArMjQwNSw3IEBAIGludCBzZWN1
cml0eV9zaWRfbWxzX2NvcHkodTMyIHNpZCwgdTMyIG0KIAl1MzIgbGVuOwog
CWludCByYyA9IDA7CiAKLQlpZiAoIXNzX2luaXRpYWxpemVkIHx8ICFzZWxp
bnV4X21sc19lbmFibGVkKSB7CisJaWYgKCFzc19pbml0aWFsaXplZCB8fCAh
cG9saWN5ZGIubWxzX2VuYWJsZWQpIHsKIAkJKm5ld19zaWQgPSBzaWQ7CiAJ
CWdvdG8gb3V0OwogCX0KQEAgLTI0MzksNyArMjUwNiw3IEBAIGludCBzZWN1
cml0eV9uZXRfcGVlcnNpZF9yZXNvbHZlKHUzMiBubGIKIAkvKiB3ZSBkb24n
dCBuZWVkIHRvIGNoZWNrIHNzX2luaXRpYWxpemVkIGhlcmUgc2luY2UgdGhl
IG9ubHkgd2F5IGJvdGgKIAkgKiBubGJsX3NpZCBhbmQgeGZybV9zaWQgYXJl
IG5vdCBlcXVhbCB0byBTRUNTSURfTlVMTCB3b3VsZCBiZSBpZiB0aGUKIAkg
KiBzZWN1cml0eSBzZXJ2ZXIgd2FzIGluaXRpYWxpemVkIGFuZCBzc19pbml0
aWFsaXplZCB3YXMgdHJ1ZSAqLwotCWlmICghc2VsaW51eF9tbHNfZW5hYmxl
ZCkgeworCWlmICghcG9saWN5ZGIubWxzX2VuYWJsZWQpIHsKIAkJKnBlZXJf
c2lkID0gU0VDU0lEX05VTEw7CiAJCXJldHVybiAwOwogCX0KZGlmZiAtcHJ1
TiBzZWN1cml0eS10ZXN0aW5nLTIuNi9zZWN1cml0eS9zZWxpbnV4L3NzL3Nl
cnZpY2VzLmggc2VjdXJpdHktdGVzdGluZy0yLjYtbmV3L3NlY3VyaXR5L3Nl
bGludXgvc3Mvc2VydmljZXMuaAotLS0gc2VjdXJpdHktdGVzdGluZy0yLjYv
c2VjdXJpdHkvc2VsaW51eC9zcy9zZXJ2aWNlcy5oCTIwMTAtMDEtMjkgMDE6
MDY6NDIuMTc0MDQ0NDA2ICswMTAwCisrKyBzZWN1cml0eS10ZXN0aW5nLTIu
Ni1uZXcvc2VjdXJpdHkvc2VsaW51eC9zcy9zZXJ2aWNlcy5oCTIwMTAtMDIt
MDEgMTg6MjY6MzIuNjgyMjM0OTE1ICswMTAwCkBAIC0zLDYgKzMsNyBAQAog
ICoKICAqIEF1dGhvciA6IFN0ZXBoZW4gU21hbGxleSwgPHNkc0BlcG9jaC5u
Y3NjLm1pbD4KICAqLworCiAjaWZuZGVmIF9TU19TRVJWSUNFU19IXwogI2Rl
ZmluZSBfU1NfU0VSVklDRVNfSF8KIApkaWZmIC1wcnVOIHNlY3VyaXR5LXRl
c3RpbmctMi42L3NlY3VyaXR5L3NlbGludXgvc3Mvc2lkdGFiLmggc2VjdXJp
dHktdGVzdGluZy0yLjYtbmV3L3NlY3VyaXR5L3NlbGludXgvc3Mvc2lkdGFi
LmgKLS0tIHNlY3VyaXR5LXRlc3RpbmctMi42L3NlY3VyaXR5L3NlbGludXgv
c3Mvc2lkdGFiLmgJMjAxMC0wMS0yOSAwMTowNjo0Mi4xNzUwNDc2NTkgKzAx
MDAKKysrIHNlY3VyaXR5LXRlc3RpbmctMi42LW5ldy9zZWN1cml0eS9zZWxp
bnV4L3NzL3NpZHRhYi5oCTIwMTAtMDItMDEgMjA6Mzg6MDkuMzUwNTIwNzg2
ICswMTAwCkBAIC01MSw0ICs1MSwzIEBAIHZvaWQgc2lkdGFiX3NodXRkb3du
KHN0cnVjdCBzaWR0YWIgKnMpOwogCiAjZW5kaWYJLyogX1NTX1NJRFRBQl9I
XyAqLwogCi0KZGlmZiAtcHJ1TiBzZWN1cml0eS10ZXN0aW5nLTIuNi9zZWN1
cml0eS9zZWxpbnV4L3NzL3N5bXRhYi5oIHNlY3VyaXR5LXRlc3RpbmctMi42
LW5ldy9zZWN1cml0eS9zZWxpbnV4L3NzL3N5bXRhYi5oCi0tLSBzZWN1cml0
eS10ZXN0aW5nLTIuNi9zZWN1cml0eS9zZWxpbnV4L3NzL3N5bXRhYi5oCTIw
MTAtMDEtMjkgMDE6MDY6NDIuMTc2MDU1NjYxICswMTAwCisrKyBzZWN1cml0
eS10ZXN0aW5nLTIuNi1uZXcvc2VjdXJpdHkvc2VsaW51eC9zcy9zeW10YWIu
aAkyMDEwLTAyLTAxIDIwOjUwOjU0LjY2MTIzMjcxNyArMDEwMApAQCAtNiw2
ICs2LDcgQEAKICAqCiAgKiBBdXRob3IgOiBTdGVwaGVuIFNtYWxsZXksIDxz
ZHNAZXBvY2gubmNzYy5taWw+CiAgKi8KKwogI2lmbmRlZiBfU1NfU1lNVEFC
X0hfCiAjZGVmaW5lIF9TU19TWU1UQUJfSF8KIAo=


------_=_NextPart_000_a4082aefb076d7807edd6567bdc721de--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
