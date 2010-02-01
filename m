Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o11MalAr024862
	for <selinux@tycho.nsa.gov>; Mon, 1 Feb 2010 17:36:47 -0500
Received: from hostingsmtp.register.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o11MaaLk007353
	for <selinux@tycho.nsa.gov>; Mon, 1 Feb 2010 22:36:37 GMT
Message-Id: <201002012236.o11MahUM003325@vivaldi39.register.it>
From: "Guido Trentalancia" <guido@trentalancia.com>
Reply-To: "Guido Trentalancia" <guido@trentalancia.com>
To: sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, eparis@parisplace.org, jmorris@namei.org
Subject: Re: [PATCH] Allowing MLS->non-MLS and vice versa upon policy reload
Date: Mon, 01 Feb 2010 23:36:43 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_c85787edbb3ee0869c8977d5d0c5acb1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------_=_NextPart_000_c85787edbb3ee0869c8977d5d0c5acb1
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_1fa12e482e8745509338e98bd0e98b4a"


------_=_NextPart_001_1fa12e482e8745509338e98bd0e98b4a
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Stephen,

my reply follows your quoted text.

>On Mon, 2010-02-01 at 22:49 +0100, Guido Trentalancia wrote:
>> +	if (!args->oldp->mls_enabled && args->newp->mls_enabled) {
>> +		oc =3D args->newp->ocontexts[OCON_ISID];
>> +		while (oc && oc->sid[0] !=3D SECINITSID_UNLABELED)
>> +			oc =3D oc->next;
>
>Just in case, I'd test if (!oc) and bail with an error.

if (!oc) {
                        printk(KERN_ERR "SELinux:  unable to look up"
                                " the initial SIDs listn");
                        goto bad;
                }

>> +		range =3D &oc->context[0].range;
>> +		rc =3D mls_range_set(c, range);
>> +		if (rc) {
>> +			if (context_struct_to_string(&oldc, &s, &len))
>> +				return -ENOMEM;
>> +			context_destroy(&oldc);
>> +			context_destroy(c);
>> +			c->str =3D s;
>> +			c->len =3D len;
>> +			printk(KERN_ERR "SELinux:  Failed to set"
>> +				" the MLS/MCS range for context"
>> +				" %sn", c->str);
>> +			goto out;
>
>goto bad ?

Ok, goto bad. It improves readability.

Final version follows. You don't like to appear as any of Acked-by, Signed-off-by or Reviewed-by ? Nobody else commented, I would say it's ready to be submitted then (has been reviewed, checks fine, builds fine, diffstat included and I will have a kernel ready in a few minutes for a final test just in case).

Author: Guido Trentalancia <guido@trentalancia.com>
Date:   Mon Feb 01 23:29:52 2010 +0100

    Allow runtime switching between different policy types (e.g. from a MLS/MCS
    policy to a non-MLS/non-MCS policy or viceversa).

    Signed-off-by: Guido Trentalancia <guido@trentalancia.com>

 security/selinux/include/security.h |    3 -
 security/selinux/selinuxfs.c        |    3 -
 security/selinux/ss/.policydb.c.swp |binary
 security/selinux/ss/context.h       |    9 +--
 security/selinux/ss/mls.c           |   26 ++++-----
 security/selinux/ss/mls.h           |    2
 security/selinux/ss/mls_types.h     |    5 +
 security/selinux/ss/policydb.c      |   24 +-------
 security/selinux/ss/policydb.h      |    4 +
 security/selinux/ss/services.c      |   74 +++++++++++++++++++++++---
 10 files changed, 101 insertions(+), 49 deletions(-)

diff -pruN security-testing-2.6/security/selinux/include/security.h security-testing-2.6-new/security/selinux/include/security.h
--- security-testing-2.6/security/selinux/include/security.h	2010-01-29 02:02:47.737045258 +0100
+++ security-testing-2.6-new/security/selinux/include/security.h	2010-02-01 23:12:28.898233272 +0100
@@ -57,7 +57,6 @@
 struct netlbl_lsm_secattr;
 
 extern int selinux_enabled;
-extern int selinux_mls_enabled;
 
 /* Policy capabilities */
 enum {
@@ -80,6 +79,8 @@ extern int selinux_policycap_openperm;
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
 
diff -pruN security-testing-2.6/security/selinux/ss/context.h security-testing-2.6-new/security/selinux/ss/context.h
--- security-testing-2.6/security/selinux/ss/context.h	2010-01-29 01:06:42.160060332 +0100
+++ security-testing-2.6-new/security/selinux/ss/context.h	2010-02-01 23:13:35.857235582 +0100
@@ -41,7 +41,7 @@ static inline int mls_context_cpy(struct
 {
 	int rc;
 
-	if (!selinux_mls_enabled)
+	if (!security_mls_enabled())
 		return 0;
 
 	dst->range.level[0].sens =3D src->range.level[0].sens;
@@ -64,7 +64,7 @@ static inline int mls_context_cpy_low(st
 {
 	int rc;
 
-	if (!selinux_mls_enabled)
+	if (!security_mls_enabled())
 		return 0;
 
 	dst->range.level[0].sens =3D src->range.level[0].sens;
@@ -82,7 +82,7 @@ out:
 
 static inline int mls_context_cmp(struct context *c1, struct context *c2)
 {
-	if (!selinux_mls_enabled)
+	if (!security_mls_enabled())
 		return 1;
 
 	return ((c1->range.level[0].sens =3D=3D c2->range.level[0].sens) &&
@@ -93,9 +93,6 @@ static inline int mls_context_cmp(struct
 
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
+++ security-testing-2.6-new/security/selinux/ss/mls.h	2010-02-01 23:17:31.025223083 +0100
@@ -39,6 +39,8 @@ int mls_context_to_sid(struct policydb *
 
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
+++ security-testing-2.6-new/security/selinux/ss/services.c	2010-02-01 23:28:02.338227931 +0100
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
@@ -1614,9 +1630,43 @@ static int convert_context(u32 key,
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
+		if (!oc) {
+			printk(KERN_ERR "SELinux:  unable to look up"
+				" the initial SIDs listn");
+			goto bad;
+		}
+		range =3D &oc->context[0].range;
+		rc =3D mls_range_set(c, range);
+		if (rc)
+			goto bad;
+	}
 
 	/* Check the validity of the new context. */
 	if (!policydb_context_isvalid(args->newp, c)) {
@@ -1712,6 +1762,14 @@ int security_load_policy(void *data, siz
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
@@ -1741,8 +1799,12 @@ int security_load_policy(void *data, siz
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
@@ -2338,7 +2400,7 @@ int security_sid_mls_copy(u32 sid, u32 m
 	u32 len;
 	int rc =3D 0;
 
-	if (!ss_initialized || !selinux_mls_enabled) {
+	if (!ss_initialized || !policydb.mls_enabled) {
 		*new_sid =3D sid;
 		goto out;
 	}
@@ -2439,7 +2501,7 @@ int security_net_peersid_resolve(u32 nlb
 	/* we don't need to check ss_initialized here since the only way both
 	 * nlbl_sid and xfrm_sid are not equal to SECSID_NULL would be if the
 	 * security server was initialized and ss_initialized was true */
-	if (!selinux_mls_enabled) {
+	if (!policydb.mls_enabled) {
 		*peer_sid =3D SECSID_NULL;
 		return 0;
 	} 

------_=_NextPart_001_1fa12e482e8745509338e98bd0e98b4a--

------_=_NextPart_000_c85787edbb3ee0869c8977d5d0c5acb1
Content-Type: application/octet-stream;
	name="switch-policy.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="switch-policy.patch"

QXV0aG9yOiBHdWlkbyBUcmVudGFsYW5jaWEgPGd1aWRvQHRyZW50YWxhbmNp
YS5jb20+CkRhdGU6ICAgTW9uIEZlYiAwMSAyMzoyOTo1MiAyMDEwICswMTAw
CgogICAgQWxsb3cgcnVudGltZSBzd2l0Y2hpbmcgYmV0d2VlbiBkaWZmZXJl
bnQgcG9saWN5IHR5cGVzIChlLmcuIGZyb20gYSBNTFMvTUNTCiAgICBwb2xp
Y3kgdG8gYSBub24tTUxTL25vbi1NQ1MgcG9saWN5IG9yIHZpY2V2ZXJzYSku
CgogICAgU2lnbmVkLW9mZi1ieTogR3VpZG8gVHJlbnRhbGFuY2lhIDxndWlk
b0B0cmVudGFsYW5jaWEuY29tPgoKIHNlY3VyaXR5L3NlbGludXgvaW5jbHVk
ZS9zZWN1cml0eS5oIHwgICAgMyAtCiBzZWN1cml0eS9zZWxpbnV4L3NlbGlu
dXhmcy5jICAgICAgICB8ICAgIDMgLQogc2VjdXJpdHkvc2VsaW51eC9zcy8u
cG9saWN5ZGIuYy5zd3AgfGJpbmFyeQogc2VjdXJpdHkvc2VsaW51eC9zcy9j
b250ZXh0LmggICAgICAgfCAgICA5ICstLQogc2VjdXJpdHkvc2VsaW51eC9z
cy9tbHMuYyAgICAgICAgICAgfCAgIDI2ICsrKystLS0tLQogc2VjdXJpdHkv
c2VsaW51eC9zcy9tbHMuaCAgICAgICAgICAgfCAgICAyCiBzZWN1cml0eS9z
ZWxpbnV4L3NzL21sc190eXBlcy5oICAgICB8ICAgIDUgKwogc2VjdXJpdHkv
c2VsaW51eC9zcy9wb2xpY3lkYi5jICAgICAgfCAgIDI0ICstLS0tLS0tCiBz
ZWN1cml0eS9zZWxpbnV4L3NzL3BvbGljeWRiLmggICAgICB8ICAgIDQgKwog
c2VjdXJpdHkvc2VsaW51eC9zcy9zZXJ2aWNlcy5jICAgICAgfCAgIDc0ICsr
KysrKysrKysrKysrKysrKysrKysrLS0tCiAxMCBmaWxlcyBjaGFuZ2VkLCAx
MDEgaW5zZXJ0aW9ucygrKSwgNDkgZGVsZXRpb25zKC0pCgpkaWZmIC1wcnVO
IHNlY3VyaXR5LXRlc3RpbmctMi42L3NlY3VyaXR5L3NlbGludXgvaW5jbHVk
ZS9zZWN1cml0eS5oIHNlY3VyaXR5LXRlc3RpbmctMi42LW5ldy9zZWN1cml0
eS9zZWxpbnV4L2luY2x1ZGUvc2VjdXJpdHkuaAotLS0gc2VjdXJpdHktdGVz
dGluZy0yLjYvc2VjdXJpdHkvc2VsaW51eC9pbmNsdWRlL3NlY3VyaXR5LmgJ
MjAxMC0wMS0yOSAwMjowMjo0Ny43MzcwNDUyNTggKzAxMDAKKysrIHNlY3Vy
aXR5LXRlc3RpbmctMi42LW5ldy9zZWN1cml0eS9zZWxpbnV4L2luY2x1ZGUv
c2VjdXJpdHkuaAkyMDEwLTAyLTAxIDIzOjEyOjI4Ljg5ODIzMzI3MiArMDEw
MApAQCAtNTcsNyArNTcsNiBAQAogc3RydWN0IG5ldGxibF9sc21fc2VjYXR0
cjsKIAogZXh0ZXJuIGludCBzZWxpbnV4X2VuYWJsZWQ7Ci1leHRlcm4gaW50
IHNlbGludXhfbWxzX2VuYWJsZWQ7CiAKIC8qIFBvbGljeSBjYXBhYmlsaXRp
ZXMgKi8KIGVudW0gewpAQCAtODAsNiArNzksOCBAQCBleHRlcm4gaW50IHNl
bGludXhfcG9saWN5Y2FwX29wZW5wZXJtOwogLyogbGltaXRhdGlvbiBvZiBi
b3VuZGFyeSBkZXB0aCAgKi8KICNkZWZpbmUgUE9MSUNZREJfQk9VTkRTX01B
WERFUFRICTQKIAoraW50IHNlY3VyaXR5X21sc19lbmFibGVkKHZvaWQpOwor
CiBpbnQgc2VjdXJpdHlfbG9hZF9wb2xpY3kodm9pZCAqZGF0YSwgc2l6ZV90
IGxlbik7CiAKIGludCBzZWN1cml0eV9wb2xpY3ljYXBfc3VwcG9ydGVkKHVu
c2lnbmVkIGludCByZXFfY2FwKTsKZGlmZiAtcHJ1TiBzZWN1cml0eS10ZXN0
aW5nLTIuNi9zZWN1cml0eS9zZWxpbnV4L3NlbGludXhmcy5jIHNlY3VyaXR5
LXRlc3RpbmctMi42LW5ldy9zZWN1cml0eS9zZWxpbnV4L3NlbGludXhmcy5j
Ci0tLSBzZWN1cml0eS10ZXN0aW5nLTIuNi9zZWN1cml0eS9zZWxpbnV4L3Nl
bGludXhmcy5jCTIwMTAtMDEtMjkgMDI6MDI6NDcuNzM4MDQ2ODM1ICswMTAw
CisrKyBzZWN1cml0eS10ZXN0aW5nLTIuNi1uZXcvc2VjdXJpdHkvc2VsaW51
eC9zZWxpbnV4ZnMuYwkyMDEwLTAyLTAxIDIyOjA2OjIxLjcwOTIzNDAzOSAr
MDEwMApAQCAtMjgyLDcgKzI4Miw4IEBAIHN0YXRpYyBzc2l6ZV90IHNlbF9y
ZWFkX21scyhzdHJ1Y3QgZmlsZSAKIAljaGFyIHRtcGJ1ZltUTVBCVUZMRU5d
OwogCXNzaXplX3QgbGVuZ3RoOwogCi0JbGVuZ3RoID0gc2NucHJpbnRmKHRt
cGJ1ZiwgVE1QQlVGTEVOLCAiJWQiLCBzZWxpbnV4X21sc19lbmFibGVkKTsK
KwlsZW5ndGggPSBzY25wcmludGYodG1wYnVmLCBUTVBCVUZMRU4sICIlZCIs
CisJCQkgICBzZWN1cml0eV9tbHNfZW5hYmxlZCgpKTsKIAlyZXR1cm4gc2lt
cGxlX3JlYWRfZnJvbV9idWZmZXIoYnVmLCBjb3VudCwgcHBvcywgdG1wYnVm
LCBsZW5ndGgpOwogfQogCmRpZmYgLXBydU4gc2VjdXJpdHktdGVzdGluZy0y
LjYvc2VjdXJpdHkvc2VsaW51eC9zcy9jb250ZXh0Lmggc2VjdXJpdHktdGVz
dGluZy0yLjYtbmV3L3NlY3VyaXR5L3NlbGludXgvc3MvY29udGV4dC5oCi0t
LSBzZWN1cml0eS10ZXN0aW5nLTIuNi9zZWN1cml0eS9zZWxpbnV4L3NzL2Nv
bnRleHQuaAkyMDEwLTAxLTI5IDAxOjA2OjQyLjE2MDA2MDMzMiArMDEwMAor
Kysgc2VjdXJpdHktdGVzdGluZy0yLjYtbmV3L3NlY3VyaXR5L3NlbGludXgv
c3MvY29udGV4dC5oCTIwMTAtMDItMDEgMjM6MTM6MzUuODU3MjM1NTgyICsw
MTAwCkBAIC00MSw3ICs0MSw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IG1sc19j
b250ZXh0X2NweShzdHJ1Y3QKIHsKIAlpbnQgcmM7CiAKLQlpZiAoIXNlbGlu
dXhfbWxzX2VuYWJsZWQpCisJaWYgKCFzZWN1cml0eV9tbHNfZW5hYmxlZCgp
KQogCQlyZXR1cm4gMDsKIAogCWRzdC0+cmFuZ2UubGV2ZWxbMF0uc2VucyA9
IHNyYy0+cmFuZ2UubGV2ZWxbMF0uc2VuczsKQEAgLTY0LDcgKzY0LDcgQEAg
c3RhdGljIGlubGluZSBpbnQgbWxzX2NvbnRleHRfY3B5X2xvdyhzdAogewog
CWludCByYzsKIAotCWlmICghc2VsaW51eF9tbHNfZW5hYmxlZCkKKwlpZiAo
IXNlY3VyaXR5X21sc19lbmFibGVkKCkpCiAJCXJldHVybiAwOwogCiAJZHN0
LT5yYW5nZS5sZXZlbFswXS5zZW5zID0gc3JjLT5yYW5nZS5sZXZlbFswXS5z
ZW5zOwpAQCAtODIsNyArODIsNyBAQCBvdXQ6CiAKIHN0YXRpYyBpbmxpbmUg
aW50IG1sc19jb250ZXh0X2NtcChzdHJ1Y3QgY29udGV4dCAqYzEsIHN0cnVj
dCBjb250ZXh0ICpjMikKIHsKLQlpZiAoIXNlbGludXhfbWxzX2VuYWJsZWQp
CisJaWYgKCFzZWN1cml0eV9tbHNfZW5hYmxlZCgpKQogCQlyZXR1cm4gMTsK
IAogCXJldHVybiAoKGMxLT5yYW5nZS5sZXZlbFswXS5zZW5zID09IGMyLT5y
YW5nZS5sZXZlbFswXS5zZW5zKSAmJgpAQCAtOTMsOSArOTMsNiBAQCBzdGF0
aWMgaW5saW5lIGludCBtbHNfY29udGV4dF9jbXAoc3RydWN0CiAKIHN0YXRp
YyBpbmxpbmUgdm9pZCBtbHNfY29udGV4dF9kZXN0cm95KHN0cnVjdCBjb250
ZXh0ICpjKQogewotCWlmICghc2VsaW51eF9tbHNfZW5hYmxlZCkKLQkJcmV0
dXJuOwotCiAJZWJpdG1hcF9kZXN0cm95KCZjLT5yYW5nZS5sZXZlbFswXS5j
YXQpOwogCWViaXRtYXBfZGVzdHJveSgmYy0+cmFuZ2UubGV2ZWxbMV0uY2F0
KTsKIAltbHNfY29udGV4dF9pbml0KGMpOwpkaWZmIC1wcnVOIHNlY3VyaXR5
LXRlc3RpbmctMi42L3NlY3VyaXR5L3NlbGludXgvc3MvbWxzLmMgc2VjdXJp
dHktdGVzdGluZy0yLjYtbmV3L3NlY3VyaXR5L3NlbGludXgvc3MvbWxzLmMK
LS0tIHNlY3VyaXR5LXRlc3RpbmctMi42L3NlY3VyaXR5L3NlbGludXgvc3Mv
bWxzLmMJMjAxMC0wMS0yOSAwMjowMjo0Ny43MzkwNDYxNzcgKzAxMDAKKysr
IHNlY3VyaXR5LXRlc3RpbmctMi42LW5ldy9zZWN1cml0eS9zZWxpbnV4L3Nz
L21scy5jCTIwMTAtMDItMDEgMjI6MTU6NDguMDYyMjMzNzIxICswMTAwCkBA
IC0zOSw3ICszOSw3IEBAIGludCBtbHNfY29tcHV0ZV9jb250ZXh0X2xlbihz
dHJ1Y3QgY29udGUKIAlzdHJ1Y3QgZWJpdG1hcCAqZTsKIAlzdHJ1Y3QgZWJp
dG1hcF9ub2RlICpub2RlOwogCi0JaWYgKCFzZWxpbnV4X21sc19lbmFibGVk
KQorCWlmICghcG9saWN5ZGIubWxzX2VuYWJsZWQpCiAJCXJldHVybiAwOwog
CiAJbGVuID0gMTsgLyogZm9yIHRoZSBiZWdpbm5pbmcgIjoiICovCkBAIC05
Myw3ICs5Myw3IEBAIHZvaWQgbWxzX3NpZF90b19jb250ZXh0KHN0cnVjdCBj
b250ZXh0ICoKIAlzdHJ1Y3QgZWJpdG1hcCAqZTsKIAlzdHJ1Y3QgZWJpdG1h
cF9ub2RlICpub2RlOwogCi0JaWYgKCFzZWxpbnV4X21sc19lbmFibGVkKQor
CWlmICghcG9saWN5ZGIubWxzX2VuYWJsZWQpCiAJCXJldHVybjsKIAogCXNj
b250ZXh0cCA9ICpzY29udGV4dDsKQEAgLTIwMCw3ICsyMDAsNyBAQCBpbnQg
bWxzX2NvbnRleHRfaXN2YWxpZChzdHJ1Y3QgcG9saWN5ZGIgCiB7CiAJc3Ry
dWN0IHVzZXJfZGF0dW0gKnVzcmRhdHVtOwogCi0JaWYgKCFzZWxpbnV4X21s
c19lbmFibGVkKQorCWlmICghcC0+bWxzX2VuYWJsZWQpCiAJCXJldHVybiAx
OwogCiAJaWYgKCFtbHNfcmFuZ2VfaXN2YWxpZChwLCAmYy0+cmFuZ2UpKQpA
QCAtMjUzLDcgKzI1Myw3IEBAIGludCBtbHNfY29udGV4dF90b19zaWQoc3Ry
dWN0IHBvbGljeWRiICoKIAlzdHJ1Y3QgY2F0X2RhdHVtICpjYXRkYXR1bSwg
KnJuZ2RhdHVtOwogCWludCBsLCByYyA9IC1FSU5WQUw7CiAKLQlpZiAoIXNl
bGludXhfbWxzX2VuYWJsZWQpIHsKKwlpZiAoIXBvbC0+bWxzX2VuYWJsZWQp
IHsKIAkJaWYgKGRlZl9zaWQgIT0gU0VDU0lEX05VTEwgJiYgb2xkYykKIAkJ
CSpzY29udGV4dCArPSBzdHJsZW4oKnNjb250ZXh0KSsxOwogCQlyZXR1cm4g
MDsKQEAgLTM4Nyw3ICszODcsNyBAQCBpbnQgbWxzX2Zyb21fc3RyaW5nKGNo
YXIgKnN0ciwgc3RydWN0IGNvCiAJY2hhciAqdG1wc3RyLCAqZnJlZXN0cjsK
IAlpbnQgcmM7CiAKLQlpZiAoIXNlbGludXhfbWxzX2VuYWJsZWQpCisJaWYg
KCFwb2xpY3lkYi5tbHNfZW5hYmxlZCkKIAkJcmV0dXJuIC1FSU5WQUw7CiAK
IAkvKiB3ZSBuZWVkIGZyZWVzdHIgYmVjYXVzZSBtbHNfY29udGV4dF90b19z
aWQgd2lsbCBjaGFuZ2UKQEAgLTQwNyw3ICs0MDcsNyBAQCBpbnQgbWxzX2Zy
b21fc3RyaW5nKGNoYXIgKnN0ciwgc3RydWN0IGNvCiAvKgogICogQ29waWVz
IHRoZSBNTFMgcmFuZ2UgYHJhbmdlJyBpbnRvIGBjb250ZXh0Jy4KICAqLwot
c3RhdGljIGlubGluZSBpbnQgbWxzX3JhbmdlX3NldChzdHJ1Y3QgY29udGV4
dCAqY29udGV4dCwKK2ludCBtbHNfcmFuZ2Vfc2V0KHN0cnVjdCBjb250ZXh0
ICpjb250ZXh0LAogCQkJCXN0cnVjdCBtbHNfcmFuZ2UgKnJhbmdlKQogewog
CWludCBsLCByYyA9IDA7CkBAIC00MjcsNyArNDI3LDcgQEAgc3RhdGljIGlu
bGluZSBpbnQgbWxzX3JhbmdlX3NldChzdHJ1Y3QgYwogaW50IG1sc19zZXR1
cF91c2VyX3JhbmdlKHN0cnVjdCBjb250ZXh0ICpmcm9tY29uLCBzdHJ1Y3Qg
dXNlcl9kYXR1bSAqdXNlciwKIAkJCSBzdHJ1Y3QgY29udGV4dCAqdXNlcmNv
bikKIHsKLQlpZiAoc2VsaW51eF9tbHNfZW5hYmxlZCkgeworCWlmIChwb2xp
Y3lkYi5tbHNfZW5hYmxlZCkgewogCQlzdHJ1Y3QgbWxzX2xldmVsICpmcm9t
Y29uX3NlbiA9ICYoZnJvbWNvbi0+cmFuZ2UubGV2ZWxbMF0pOwogCQlzdHJ1
Y3QgbWxzX2xldmVsICpmcm9tY29uX2NsciA9ICYoZnJvbWNvbi0+cmFuZ2Uu
bGV2ZWxbMV0pOwogCQlzdHJ1Y3QgbWxzX2xldmVsICp1c2VyX2xvdyA9ICYo
dXNlci0+cmFuZ2UubGV2ZWxbMF0pOwpAQCAtNDc3LDcgKzQ3Nyw3IEBAIGlu
dCBtbHNfY29udmVydF9jb250ZXh0KHN0cnVjdCBwb2xpY3lkYiAKIAlzdHJ1
Y3QgZWJpdG1hcF9ub2RlICpub2RlOwogCWludCBsLCBpOwogCi0JaWYgKCFz
ZWxpbnV4X21sc19lbmFibGVkKQorCWlmICghcG9saWN5ZGIubWxzX2VuYWJs
ZWQpCiAJCXJldHVybiAwOwogCiAJZm9yIChsID0gMDsgbCA8IDI7IGwrKykg
ewpAQCAtNTE2LDcgKzUxNiw3IEBAIGludCBtbHNfY29tcHV0ZV9zaWQoc3Ry
dWN0IGNvbnRleHQgKnNjb24KIAlzdHJ1Y3QgcmFuZ2VfdHJhbnMgcnRyOwog
CXN0cnVjdCBtbHNfcmFuZ2UgKnI7CiAKLQlpZiAoIXNlbGludXhfbWxzX2Vu
YWJsZWQpCisJaWYgKCFwb2xpY3lkYi5tbHNfZW5hYmxlZCkKIAkJcmV0dXJu
IDA7CiAKIAlzd2l0Y2ggKHNwZWNpZmllZCkgewpAQCAtNTU5LDcgKzU1OSw3
IEBAIGludCBtbHNfY29tcHV0ZV9zaWQoc3RydWN0IGNvbnRleHQgKnNjb24K
IHZvaWQgbWxzX2V4cG9ydF9uZXRsYmxfbHZsKHN0cnVjdCBjb250ZXh0ICpj
b250ZXh0LAogCQkJICAgc3RydWN0IG5ldGxibF9sc21fc2VjYXR0ciAqc2Vj
YXR0cikKIHsKLQlpZiAoIXNlbGludXhfbWxzX2VuYWJsZWQpCisJaWYgKCFw
b2xpY3lkYi5tbHNfZW5hYmxlZCkKIAkJcmV0dXJuOwogCiAJc2VjYXR0ci0+
YXR0ci5tbHMubHZsID0gY29udGV4dC0+cmFuZ2UubGV2ZWxbMF0uc2VucyAt
IDE7CkBAIC01NzksNyArNTc5LDcgQEAgdm9pZCBtbHNfZXhwb3J0X25ldGxi
bF9sdmwoc3RydWN0IGNvbnRleAogdm9pZCBtbHNfaW1wb3J0X25ldGxibF9s
dmwoc3RydWN0IGNvbnRleHQgKmNvbnRleHQsCiAJCQkgICBzdHJ1Y3QgbmV0
bGJsX2xzbV9zZWNhdHRyICpzZWNhdHRyKQogewotCWlmICghc2VsaW51eF9t
bHNfZW5hYmxlZCkKKwlpZiAoIXBvbGljeWRiLm1sc19lbmFibGVkKQogCQly
ZXR1cm47CiAKIAljb250ZXh0LT5yYW5nZS5sZXZlbFswXS5zZW5zID0gc2Vj
YXR0ci0+YXR0ci5tbHMubHZsICsgMTsKQEAgLTYwMSw3ICs2MDEsNyBAQCBp
bnQgbWxzX2V4cG9ydF9uZXRsYmxfY2F0KHN0cnVjdCBjb250ZXh0CiB7CiAJ
aW50IHJjOwogCi0JaWYgKCFzZWxpbnV4X21sc19lbmFibGVkKQorCWlmICgh
cG9saWN5ZGIubWxzX2VuYWJsZWQpCiAJCXJldHVybiAwOwogCiAJcmMgPSBl
Yml0bWFwX25ldGxibF9leHBvcnQoJmNvbnRleHQtPnJhbmdlLmxldmVsWzBd
LmNhdCwKQEAgLTYyOSw3ICs2MjksNyBAQCBpbnQgbWxzX2ltcG9ydF9uZXRs
YmxfY2F0KHN0cnVjdCBjb250ZXh0CiB7CiAJaW50IHJjOwogCi0JaWYgKCFz
ZWxpbnV4X21sc19lbmFibGVkKQorCWlmICghcG9saWN5ZGIubWxzX2VuYWJs
ZWQpCiAJCXJldHVybiAwOwogCiAJcmMgPSBlYml0bWFwX25ldGxibF9pbXBv
cnQoJmNvbnRleHQtPnJhbmdlLmxldmVsWzBdLmNhdCwKZGlmZiAtcHJ1TiBz
ZWN1cml0eS10ZXN0aW5nLTIuNi9zZWN1cml0eS9zZWxpbnV4L3NzL21scy5o
IHNlY3VyaXR5LXRlc3RpbmctMi42LW5ldy9zZWN1cml0eS9zZWxpbnV4L3Nz
L21scy5oCi0tLSBzZWN1cml0eS10ZXN0aW5nLTIuNi9zZWN1cml0eS9zZWxp
bnV4L3NzL21scy5oCTIwMTAtMDEtMjkgMDE6MDY6NDIuMTY4MDUxNDMxICsw
MTAwCisrKyBzZWN1cml0eS10ZXN0aW5nLTIuNi1uZXcvc2VjdXJpdHkvc2Vs
aW51eC9zcy9tbHMuaAkyMDEwLTAyLTAxIDIzOjE3OjMxLjAyNTIyMzA4MyAr
MDEwMApAQCAtMzksNiArMzksOCBAQCBpbnQgbWxzX2NvbnRleHRfdG9fc2lk
KHN0cnVjdCBwb2xpY3lkYiAqCiAKIGludCBtbHNfZnJvbV9zdHJpbmcoY2hh
ciAqc3RyLCBzdHJ1Y3QgY29udGV4dCAqY29udGV4dCwgZ2ZwX3QgZ2ZwX21h
c2spOwogCitpbnQgbWxzX3JhbmdlX3NldChzdHJ1Y3QgY29udGV4dCAqY29u
dGV4dCwgc3RydWN0IG1sc19yYW5nZSAqcmFuZ2UpOworCiBpbnQgbWxzX2Nv
bnZlcnRfY29udGV4dChzdHJ1Y3QgcG9saWN5ZGIgKm9sZHAsCiAJCQlzdHJ1
Y3QgcG9saWN5ZGIgKm5ld3AsCiAJCQlzdHJ1Y3QgY29udGV4dCAqY29udGV4
dCk7CmRpZmYgLXBydU4gc2VjdXJpdHktdGVzdGluZy0yLjYvc2VjdXJpdHkv
c2VsaW51eC9zcy9tbHNfdHlwZXMuaCBzZWN1cml0eS10ZXN0aW5nLTIuNi1u
ZXcvc2VjdXJpdHkvc2VsaW51eC9zcy9tbHNfdHlwZXMuaAotLS0gc2VjdXJp
dHktdGVzdGluZy0yLjYvc2VjdXJpdHkvc2VsaW51eC9zcy9tbHNfdHlwZXMu
aAkyMDEwLTAxLTI5IDAxOjA2OjQyLjE2ODA1MTQzMSArMDEwMAorKysgc2Vj
dXJpdHktdGVzdGluZy0yLjYtbmV3L3NlY3VyaXR5L3NlbGludXgvc3MvbWxz
X3R5cGVzLmgJMjAxMC0wMi0wMSAyMjoyMzoxMS43OTkyMjQ3NzEgKzAxMDAK
QEAgLTE1LDYgKzE1LDcgQEAKICNkZWZpbmUgX1NTX01MU19UWVBFU19IXwog
CiAjaW5jbHVkZSAic2VjdXJpdHkuaCIKKyNpbmNsdWRlICJlYml0bWFwLmgi
CiAKIHN0cnVjdCBtbHNfbGV2ZWwgewogCXUzMiBzZW5zOwkJLyogc2Vuc2l0
aXZpdHkgKi8KQEAgLTI3LDcgKzI4LDcgQEAgc3RydWN0IG1sc19yYW5nZSB7
CiAKIHN0YXRpYyBpbmxpbmUgaW50IG1sc19sZXZlbF9lcShzdHJ1Y3QgbWxz
X2xldmVsICpsMSwgc3RydWN0IG1sc19sZXZlbCAqbDIpCiB7Ci0JaWYgKCFz
ZWxpbnV4X21sc19lbmFibGVkKQorCWlmICghc2VjdXJpdHlfbWxzX2VuYWJs
ZWQoKSkKIAkJcmV0dXJuIDE7CiAKIAlyZXR1cm4gKChsMS0+c2VucyA9PSBs
Mi0+c2VucykgJiYKQEAgLTM2LDcgKzM3LDcgQEAgc3RhdGljIGlubGluZSBp
bnQgbWxzX2xldmVsX2VxKHN0cnVjdCBtbAogCiBzdGF0aWMgaW5saW5lIGlu
dCBtbHNfbGV2ZWxfZG9tKHN0cnVjdCBtbHNfbGV2ZWwgKmwxLCBzdHJ1Y3Qg
bWxzX2xldmVsICpsMikKIHsKLQlpZiAoIXNlbGludXhfbWxzX2VuYWJsZWQp
CisJaWYgKCFzZWN1cml0eV9tbHNfZW5hYmxlZCgpKQogCQlyZXR1cm4gMTsK
IAogCXJldHVybiAoKGwxLT5zZW5zID49IGwyLT5zZW5zKSAmJgpkaWZmIC1w
cnVOIHNlY3VyaXR5LXRlc3RpbmctMi42L3NlY3VyaXR5L3NlbGludXgvc3Mv
cG9saWN5ZGIuYyBzZWN1cml0eS10ZXN0aW5nLTIuNi1uZXcvc2VjdXJpdHkv
c2VsaW51eC9zcy9wb2xpY3lkYi5jCi0tLSBzZWN1cml0eS10ZXN0aW5nLTIu
Ni9zZWN1cml0eS9zZWxpbnV4L3NzL3BvbGljeWRiLmMJMjAxMC0wMS0yOSAw
MjowMjo0Ny43NDAwNDYwNzcgKzAxMDAKKysrIHNlY3VyaXR5LXRlc3Rpbmct
Mi42LW5ldy9zZWN1cml0eS9zZWxpbnV4L3NzL3BvbGljeWRiLmMJMjAxMC0w
Mi0wMSAyMjoxMjoxOC42MDEyMjYwNzMgKzAxMDAKQEAgLTUyLDggKzUyLDYg
QEAgc3RhdGljIGNoYXIgKnN5bXRhYl9uYW1lW1NZTV9OVU1dID0gewogfTsK
ICNlbmRpZgogCi1pbnQgc2VsaW51eF9tbHNfZW5hYmxlZDsKLQogc3RhdGlj
IHVuc2lnbmVkIGludCBzeW10YWJfc2l6ZXNbU1lNX05VTV0gPSB7CiAJMiwK
IAkzMiwKQEAgLTQ1NSw3ICs0NTMsNyBAQCBzdGF0aWMgaW50IHBvbGljeWRi
X2luZGV4X290aGVycyhzdHJ1Y3QgCiAKIAlwcmludGsoS0VSTl9ERUJVRyAi
U0VMaW51eDogICVkIHVzZXJzLCAlZCByb2xlcywgJWQgdHlwZXMsICVkIGJv
b2xzIiwKIAkgICAgICAgcC0+cF91c2Vycy5ucHJpbSwgcC0+cF9yb2xlcy5u
cHJpbSwgcC0+cF90eXBlcy5ucHJpbSwgcC0+cF9ib29scy5ucHJpbSk7Ci0J
aWYgKHNlbGludXhfbWxzX2VuYWJsZWQpCisJaWYgKHAtPm1sc19lbmFibGVk
KQogCQlwcmludGsoIiwgJWQgc2VucywgJWQgY2F0cyIsIHAtPnBfbGV2ZWxz
Lm5wcmltLAogCQkgICAgICAgcC0+cF9jYXRzLm5wcmltKTsKIAlwcmludGso
IlxuIik7CkBAIC0xNzE3LDE0ICsxNzE1LDEyIEBAIGludCBwb2xpY3lkYl9y
ZWFkKHN0cnVjdCBwb2xpY3lkYiAqcCwgdm8KIAlpbnQgaSwgaiwgcmM7CiAJ
X19sZTMyIGJ1Zls0XTsKIAl1MzIgbm9kZWJ1Zls4XTsKLQl1MzIgbGVuLCBs
ZW4yLCBjb25maWcsIG5wcmltLCBuZWwsIG5lbDI7CisJdTMyIGxlbiwgbGVu
MiwgbnByaW0sIG5lbCwgbmVsMjsKIAljaGFyICpwb2xpY3lkYl9zdHI7CiAJ
c3RydWN0IHBvbGljeWRiX2NvbXBhdF9pbmZvICppbmZvOwogCXN0cnVjdCBy
YW5nZV90cmFucyAqcnQ7CiAJc3RydWN0IG1sc19yYW5nZSAqcjsKIAotCWNv
bmZpZyA9IDA7Ci0KIAlyYyA9IHBvbGljeWRiX2luaXQocCk7CiAJaWYgKHJj
KQogCQlnb3RvIG91dDsKQEAgLTE3NzIsNyArMTc2OCw3IEBAIGludCBwb2xp
Y3lkYl9yZWFkKHN0cnVjdCBwb2xpY3lkYiAqcCwgdm8KIAlrZnJlZShwb2xp
Y3lkYl9zdHIpOwogCXBvbGljeWRiX3N0ciA9IE5VTEw7CiAKLQkvKiBSZWFk
IHRoZSB2ZXJzaW9uLCBjb25maWcsIGFuZCB0YWJsZSBzaXplcy4gKi8KKwkv
KiBSZWFkIHRoZSB2ZXJzaW9uIGFuZCB0YWJsZSBzaXplcy4gKi8KIAlyYyA9
IG5leHRfZW50cnkoYnVmLCBmcCwgc2l6ZW9mKHUzMikqNCk7CiAJaWYgKHJj
IDwgMCkKIAkJZ290byBiYWQ7CkBAIC0xNzg3LDEzICsxNzgzLDcgQEAgaW50
IHBvbGljeWRiX3JlYWQoc3RydWN0IHBvbGljeWRiICpwLCB2bwogCX0KIAog
CWlmICgobGUzMl90b19jcHUoYnVmWzFdKSAmIFBPTElDWURCX0NPTkZJR19N
TFMpKSB7Ci0JCWlmIChzc19pbml0aWFsaXplZCAmJiAhc2VsaW51eF9tbHNf
ZW5hYmxlZCkgewotCQkJcHJpbnRrKEtFUk5fRVJSICJTRUxpbnV4OiBDYW5u
b3Qgc3dpdGNoIGJldHdlZW4gbm9uLU1MUyIKLQkJCQkiIGFuZCBNTFMgcG9s
aWNpZXNcbiIpOwotCQkJZ290byBiYWQ7Ci0JCX0KLQkJc2VsaW51eF9tbHNf
ZW5hYmxlZCA9IDE7Ci0JCWNvbmZpZyB8PSBQT0xJQ1lEQl9DT05GSUdfTUxT
OworCQlwLT5tbHNfZW5hYmxlZCA9IDE7CiAKIAkJaWYgKHAtPnBvbGljeXZl
cnMgPCBQT0xJQ1lEQl9WRVJTSU9OX01MUykgewogCQkJcHJpbnRrKEtFUk5f
RVJSICJTRUxpbnV4OiBzZWN1cml0eSBwb2xpY3lkYiB2ZXJzaW9uICVkICIK
QEAgLTE4MDEsMTIgKzE3OTEsNiBAQCBpbnQgcG9saWN5ZGJfcmVhZChzdHJ1
Y3QgcG9saWN5ZGIgKnAsIHZvCiAJCQkJcC0+cG9saWN5dmVycyk7CiAJCQln
b3RvIGJhZDsKIAkJfQotCX0gZWxzZSB7Ci0JCWlmIChzc19pbml0aWFsaXpl
ZCAmJiBzZWxpbnV4X21sc19lbmFibGVkKSB7Ci0JCQlwcmludGsoS0VSTl9F
UlIgIlNFTGludXg6IENhbm5vdCBzd2l0Y2ggYmV0d2VlbiBNTFMgYW5kIgot
CQkJCSIgbm9uLU1MUyBwb2xpY2llc1xuIik7Ci0JCQlnb3RvIGJhZDsKLQkJ
fQogCX0KIAlwLT5yZWplY3RfdW5rbm93biA9ICEhKGxlMzJfdG9fY3B1KGJ1
ZlsxXSkgJiBSRUpFQ1RfVU5LTk9XTik7CiAJcC0+YWxsb3dfdW5rbm93biA9
ICEhKGxlMzJfdG9fY3B1KGJ1ZlsxXSkgJiBBTExPV19VTktOT1dOKTsKZGlm
ZiAtcHJ1TiBzZWN1cml0eS10ZXN0aW5nLTIuNi9zZWN1cml0eS9zZWxpbnV4
L3NzL3BvbGljeWRiLmggc2VjdXJpdHktdGVzdGluZy0yLjYtbmV3L3NlY3Vy
aXR5L3NlbGludXgvc3MvcG9saWN5ZGIuaAotLS0gc2VjdXJpdHktdGVzdGlu
Zy0yLjYvc2VjdXJpdHkvc2VsaW51eC9zcy9wb2xpY3lkYi5oCTIwMTAtMDEt
MjkgMDI6MDI6NDcuNzQwMDQ2MDc3ICswMTAwCisrKyBzZWN1cml0eS10ZXN0
aW5nLTIuNi1uZXcvc2VjdXJpdHkvc2VsaW51eC9zcy9wb2xpY3lkYi5oCTIw
MTAtMDItMDEgMjA6NDc6MDguMzUyMjMyMzgwICswMTAwCkBAIC0yNyw2ICsy
Nyw4IEBACiAjaW5jbHVkZSAic3ltdGFiLmgiCiAjaW5jbHVkZSAiYXZ0YWIu
aCIKICNpbmNsdWRlICJzaWR0YWIuaCIKKyNpbmNsdWRlICJlYml0bWFwLmgi
CisjaW5jbHVkZSAibWxzX3R5cGVzLmgiCiAjaW5jbHVkZSAiY29udGV4dC5o
IgogI2luY2x1ZGUgImNvbnN0cmFpbnQuaCIKIApAQCAtMTg1LDYgKzE4Nyw4
IEBAIHN0cnVjdCBnZW5mcyB7CiAKIC8qIFRoZSBwb2xpY3kgZGF0YWJhc2Ug
Ki8KIHN0cnVjdCBwb2xpY3lkYiB7CisJaW50IG1sc19lbmFibGVkOworCiAJ
Lyogc3ltYm9sIHRhYmxlcyAqLwogCXN0cnVjdCBzeW10YWIgc3ltdGFiW1NZ
TV9OVU1dOwogI2RlZmluZSBwX2NvbW1vbnMgc3ltdGFiW1NZTV9DT01NT05T
XQpkaWZmIC1wcnVOIHNlY3VyaXR5LXRlc3RpbmctMi42L3NlY3VyaXR5L3Nl
bGludXgvc3Mvc2VydmljZXMuYyBzZWN1cml0eS10ZXN0aW5nLTIuNi1uZXcv
c2VjdXJpdHkvc2VsaW51eC9zcy9zZXJ2aWNlcy5jCi0tLSBzZWN1cml0eS10
ZXN0aW5nLTIuNi9zZWN1cml0eS9zZWxpbnV4L3NzL3NlcnZpY2VzLmMJMjAx
MC0wMS0yOSAwMjowMjo0Ny43NDIwNDI4MDUgKzAxMDAKKysrIHNlY3VyaXR5
LXRlc3RpbmctMi42LW5ldy9zZWN1cml0eS9zZWxpbnV4L3NzL3NlcnZpY2Vz
LmMJMjAxMC0wMi0wMSAyMzoyODowMi4zMzgyMjc5MzEgKzAxMDAKQEAgLTI2
LDYgKzI2LDEwIEBACiAgKgogICogIEFkZGVkIHN1cHBvcnQgZm9yIGJvdW5k
cyBkb21haW4gYW5kIGF1ZGl0IG1lc3NhZ2VkIG9uIG1hc2tlZCBwZXJtaXNz
aW9ucwogICoKKyAqIFVwZGF0ZWQ6IEd1aWRvIFRyZW50YWxhbmNpYSA8Z3Vp
ZG9AdHJlbnRhbGFuY2lhLmNvbT4KKyAqCisgKiAgQWRkZWQgc3VwcG9ydCBm
b3IgcnVudGltZSBzd2l0Y2hpbmcgb2YgdGhlIHBvbGljeSB0eXBlCisgKgog
ICogQ29weXJpZ2h0IChDKSAyMDA4LCAyMDA5IE5FQyBDb3Jwb3JhdGlvbgog
ICogQ29weXJpZ2h0IChDKSAyMDA2LCAyMDA3IEhld2xldHQtUGFja2FyZCBE
ZXZlbG9wbWVudCBDb21wYW55LCBMLlAuCiAgKiBDb3B5cmlnaHQgKEMpIDIw
MDQtMjAwNiBUcnVzdGVkIENvbXB1dGVyIFNvbHV0aW9ucywgSW5jLgpAQCAt
MjMyLDYgKzIzNiwxNiBAQCBzdGF0aWMgdm9pZCBtYXBfZGVjaXNpb24odTE2
IHRjbGFzcywgc3RyCiAJfQogfQogCisvKgorICogUmV0dXJucyBhIGJvb2xl
YW4gdmFsdWUuCisgKiBUcnVlOiBpZiB0aGUgc3BlY2lmaWVkIHBvbGljeSBp
cyBNTFMgb3IgTUNTCisgKiBGYWxzZTogaWYgdGhlIHNwZWNpZmllZCBwb2xp
Y3kgaXMgYSBzdGFuZGFyZCBwb2xpY3kKKyAqIAkgIHdpdGhvdXQgTUxTL01D
UyBzdXBwb3J0CisgKi8KK2ludCBzZWN1cml0eV9tbHNfZW5hYmxlZCh2b2lk
KQoreworCXJldHVybiBwb2xpY3lkYi5tbHNfZW5hYmxlZDsKK30KIAogLyoK
ICAqIFJldHVybiB0aGUgYm9vbGVhbiB2YWx1ZSBvZiBhIGNvbnN0cmFpbnQg
ZXhwcmVzc2lvbgpAQCAtMTU0Nyw2ICsxNTYxLDggQEAgc3RhdGljIGludCBj
b252ZXJ0X2NvbnRleHQodTMyIGtleSwKIHsKIAlzdHJ1Y3QgY29udmVydF9j
b250ZXh0X2FyZ3MgKmFyZ3M7CiAJc3RydWN0IGNvbnRleHQgb2xkYzsKKwlz
dHJ1Y3Qgb2NvbnRleHQgKm9jOworCXN0cnVjdCBtbHNfcmFuZ2UgKnJhbmdl
OwogCXN0cnVjdCByb2xlX2RhdHVtICpyb2xlOwogCXN0cnVjdCB0eXBlX2Rh
dHVtICp0eXBkYXR1bTsKIAlzdHJ1Y3QgdXNlcl9kYXR1bSAqdXNyZGF0dW07
CkBAIC0xNjE0LDkgKzE2MzAsNDMgQEAgc3RhdGljIGludCBjb252ZXJ0X2Nv
bnRleHQodTMyIGtleSwKIAkJZ290byBiYWQ7CiAJYy0+dHlwZSA9IHR5cGRh
dHVtLT52YWx1ZTsKIAotCXJjID0gbWxzX2NvbnZlcnRfY29udGV4dChhcmdz
LT5vbGRwLCBhcmdzLT5uZXdwLCBjKTsKLQlpZiAocmMpCi0JCWdvdG8gYmFk
OworCS8qIENvbnZlcnQgdGhlIE1MUy9NQ1MgZmllbGRzIGlmIGRlYWxpbmcg
d2l0aCBNTFMvTUNTIHBvbGljaWVzICovCisJaWYgKGFyZ3MtPm9sZHAtPm1s
c19lbmFibGVkCisJICAgICYmIGFyZ3MtPm5ld3AtPm1sc19lbmFibGVkKSB7
CisJCXJjID0gbWxzX2NvbnZlcnRfY29udGV4dChhcmdzLT5vbGRwLCBhcmdz
LT5uZXdwLCBjKTsKKwkJaWYgKHJjKQorCQkJZ290byBiYWQ7CisJfQorCisJ
LyoKKwkgKiBTd2l0Y2hpbmcgYmV0d2VlbiBNTFMvTUNTIGFuZCBub24tTUxT
L25vbi1NQ1MgcG9saWN5OgorCSAqIGZyZWUgYW55IHN0b3JhZ2UgdXNlZCBi
eSB0aGUgTUxTIGZpZWxkcyBpbiB0aGUKKwkgKiBjb250ZXh0IGZvciBhbGwg
ZXhpc3RpbmcgZW50cmllcyBpbiB0aGUgc2lkdGFiLgorCSAqLworCWlmIChh
cmdzLT5vbGRwLT5tbHNfZW5hYmxlZCAmJiAhYXJncy0+bmV3cC0+bWxzX2Vu
YWJsZWQpCisJCW1sc19jb250ZXh0X2Rlc3Ryb3koYyk7CisKKwkvKgorCSAq
IFN3aXRjaGluZyBiZXR3ZWVuIG5vbi1NTFMvbm9uLU1DUyBhbmQgTUxTL01D
UyBwb2xpY3k6CisJICogZW5zdXJlIHRoYXQgdGhlIE1MUyBmaWVsZHMgb2Yg
dGhlIGNvbnRleHQgZm9yIGFsbAorCSAqIGV4aXN0aW5nIGVudHJpZXMgaW4g
dGhlIHNpZHRhYiBhcmUgZmlsbGVkIGluIHdpdGggYQorCSAqIHN1aXRhYmxl
IGRlZmF1bHQgdmFsdWUsIGxpa2VseSB0YWtlbiBmcm9tIG9uZSBvZiB0aGUK
KwkgKiBpbml0aWFsIFNJRHMuCisJICovCisJaWYgKCFhcmdzLT5vbGRwLT5t
bHNfZW5hYmxlZCAmJiBhcmdzLT5uZXdwLT5tbHNfZW5hYmxlZCkgeworCQlv
YyA9IGFyZ3MtPm5ld3AtPm9jb250ZXh0c1tPQ09OX0lTSURdOworCQl3aGls
ZSAob2MgJiYgb2MtPnNpZFswXSAhPSBTRUNJTklUU0lEX1VOTEFCRUxFRCkK
KwkJCW9jID0gb2MtPm5leHQ7CisJCWlmICghb2MpIHsKKwkJCXByaW50ayhL
RVJOX0VSUiAiU0VMaW51eDogIHVuYWJsZSB0byBsb29rIHVwIgorCQkJCSIg
dGhlIGluaXRpYWwgU0lEcyBsaXN0XG4iKTsKKwkJCWdvdG8gYmFkOworCQl9
CisJCXJhbmdlID0gJm9jLT5jb250ZXh0WzBdLnJhbmdlOworCQlyYyA9IG1s
c19yYW5nZV9zZXQoYywgcmFuZ2UpOworCQlpZiAocmMpCisJCQlnb3RvIGJh
ZDsKKwl9CiAKIAkvKiBDaGVjayB0aGUgdmFsaWRpdHkgb2YgdGhlIG5ldyBj
b250ZXh0LiAqLwogCWlmICghcG9saWN5ZGJfY29udGV4dF9pc3ZhbGlkKGFy
Z3MtPm5ld3AsIGMpKSB7CkBAIC0xNzEyLDYgKzE3NjIsMTQgQEAgaW50IHNl
Y3VyaXR5X2xvYWRfcG9saWN5KHZvaWQgKmRhdGEsIHNpegogCWlmIChwb2xp
Y3lkYl9yZWFkKCZuZXdwb2xpY3lkYiwgZnApKQogCQlyZXR1cm4gLUVJTlZB
TDsKIAorCS8qIElmIHN3aXRjaGluZyBiZXR3ZWVuIGRpZmZlcmVudCBwb2xp
Y3kgdHlwZXMsIGxvZyBpdCAqLworCWlmIChwb2xpY3lkYi5tbHNfZW5hYmxl
ZCAmJiAhbmV3cG9saWN5ZGIubWxzX2VuYWJsZWQpCisJCXByaW50ayhLRVJO
X0lORk8gIlNFTGludXg6IFN3aXRjaGluZyBiZXR3ZWVuIE1MUy9NQ1MiCisJ
CQkiIGFuZCBzdGFuZGFyZCBwb2xpY3kuLi5cbiIpOworCWVsc2UgaWYgKCFw
b2xpY3lkYi5tbHNfZW5hYmxlZCAmJiBuZXdwb2xpY3lkYi5tbHNfZW5hYmxl
ZCkKKwkJcHJpbnRrKEtFUk5fSU5GTyAiU0VMaW51eDogU3dpdGNoaW5nIGJl
dHdlZW4gc3RhbmRhcmQiCisJCQkiIGFuZCBNTFMvTUNTIHBvbGljeS4uLlxu
Iik7CisKIAlpZiAoc2lkdGFiX2luaXQoJm5ld3NpZHRhYikpIHsKIAkJcG9s
aWN5ZGJfZGVzdHJveSgmbmV3cG9saWN5ZGIpOwogCQlyZXR1cm4gLUVOT01F
TTsKQEAgLTE3NDEsOCArMTc5OSwxMiBAQCBpbnQgc2VjdXJpdHlfbG9hZF9w
b2xpY3kodm9pZCAqZGF0YSwgc2l6CiAJYXJncy5vbGRwID0gJnBvbGljeWRi
OwogCWFyZ3MubmV3cCA9ICZuZXdwb2xpY3lkYjsKIAlyYyA9IHNpZHRhYl9t
YXAoJm5ld3NpZHRhYiwgY29udmVydF9jb250ZXh0LCAmYXJncyk7Ci0JaWYg
KHJjKQorCWlmIChyYykgeworCQlwcmludGsoS0VSTl9FUlIgIlNFTGludXg6
ICB1bmFibGUgdG8gY29udmVydCB0aGUgaW50ZXJuYWwiCisJCQkiIHJlcHJl
c2VudGF0aW9uIG9mIGNvbnRleHRzIGluIHRoZSBuZXcgU0lEIgorCQkJIiB0
YWJsZVxuIik7CiAJCWdvdG8gZXJyOworCX0KIAogCS8qIFNhdmUgdGhlIG9s
ZCBwb2xpY3lkYiBhbmQgU0lEIHRhYmxlIHRvIGZyZWUgbGF0ZXIuICovCiAJ
bWVtY3B5KCZvbGRwb2xpY3lkYiwgJnBvbGljeWRiLCBzaXplb2YgcG9saWN5
ZGIpOwpAQCAtMjMzOCw3ICsyNDAwLDcgQEAgaW50IHNlY3VyaXR5X3NpZF9t
bHNfY29weSh1MzIgc2lkLCB1MzIgbQogCXUzMiBsZW47CiAJaW50IHJjID0g
MDsKIAotCWlmICghc3NfaW5pdGlhbGl6ZWQgfHwgIXNlbGludXhfbWxzX2Vu
YWJsZWQpIHsKKwlpZiAoIXNzX2luaXRpYWxpemVkIHx8ICFwb2xpY3lkYi5t
bHNfZW5hYmxlZCkgewogCQkqbmV3X3NpZCA9IHNpZDsKIAkJZ290byBvdXQ7
CiAJfQpAQCAtMjQzOSw3ICsyNTAxLDcgQEAgaW50IHNlY3VyaXR5X25ldF9w
ZWVyc2lkX3Jlc29sdmUodTMyIG5sYgogCS8qIHdlIGRvbid0IG5lZWQgdG8g
Y2hlY2sgc3NfaW5pdGlhbGl6ZWQgaGVyZSBzaW5jZSB0aGUgb25seSB3YXkg
Ym90aAogCSAqIG5sYmxfc2lkIGFuZCB4ZnJtX3NpZCBhcmUgbm90IGVxdWFs
IHRvIFNFQ1NJRF9OVUxMIHdvdWxkIGJlIGlmIHRoZQogCSAqIHNlY3VyaXR5
IHNlcnZlciB3YXMgaW5pdGlhbGl6ZWQgYW5kIHNzX2luaXRpYWxpemVkIHdh
cyB0cnVlICovCi0JaWYgKCFzZWxpbnV4X21sc19lbmFibGVkKSB7CisJaWYg
KCFwb2xpY3lkYi5tbHNfZW5hYmxlZCkgewogCQkqcGVlcl9zaWQgPSBTRUNT
SURfTlVMTDsKIAkJcmV0dXJuIDA7CiAJfQo=


------_=_NextPart_000_c85787edbb3ee0869c8977d5d0c5acb1--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
