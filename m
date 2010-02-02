Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o12EMvln012852
	for <selinux@tycho.nsa.gov>; Tue, 2 Feb 2010 09:22:57 -0500
Received: from authsmtp.register.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o12EMjp5011641
	for <selinux@tycho.nsa.gov>; Tue, 2 Feb 2010 14:22:46 GMT
Subject: [PATCH] Allowing MLS->non-MLS and vice versa upon policy reload
From: Guido Trentalancia <guido@trentalancia.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg="sha1"; protocol="application/x-pkcs7-signature"; boundary="=-a/6Nwt7ixu2bY2GjE1us"
Date: Tue, 02 Feb 2010 15:22:46 +0100
Message-Id: <1265120566.3003.5.camel@tesla.lan>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-a/6Nwt7ixu2bY2GjE1us
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Author: Guido Trentalancia <guido@trentalancia.com>
Date:   Mon Feb 02 14:23:05 2010 +0100

    Allow runtime switching between different policy types (e.g. from a MLS=
/MCS
    policy to a non-MLS/non-MCS policy or viceversa).

    Signed-off-by: Guido Trentalancia <guido@trentalancia.com>

 security/selinux/include/security.h |    3 -
 security/selinux/selinuxfs.c        |    3 -
 security/selinux/ss/context.h       |    9 +--
 security/selinux/ss/mls.c           |   26 ++++-----
 security/selinux/ss/mls.h           |    2=20
 security/selinux/ss/mls_types.h     |    5 +
 security/selinux/ss/policydb.c      |   24 +-------
 security/selinux/ss/policydb.h      |    4 +
 security/selinux/ss/services.c      |   73 +++++++++++++++++++++++---
 9 files changed, 100 insertions(+), 49 deletions(-)

diff -pruN security-testing-2.6/security/selinux/include/security.h securit=
y-testing-2.6-new/security/selinux/include/security.h
--- security-testing-2.6/security/selinux/include/security.h	2010-01-29 02:=
02:47.737045258 +0100
+++ security-testing-2.6-new/security/selinux/include/security.h	2010-02-01=
 23:12:28.898233272 +0100
@@ -57,7 +57,6 @@
 struct netlbl_lsm_secattr;
=20
 extern int selinux_enabled;
-extern int selinux_mls_enabled;
=20
 /* Policy capabilities */
 enum {
@@ -80,6 +79,8 @@ extern int selinux_policycap_openperm;
 /* limitation of boundary depth  */
 #define POLICYDB_BOUNDS_MAXDEPTH	4
=20
+int security_mls_enabled(void);
+
 int security_load_policy(void *data, size_t len);
=20
 int security_policycap_supported(unsigned int req_cap);
diff -pruN security-testing-2.6/security/selinux/selinuxfs.c security-testi=
ng-2.6-new/security/selinux/selinuxfs.c
--- security-testing-2.6/security/selinux/selinuxfs.c	2010-01-29 02:02:47.7=
38046835 +0100
+++ security-testing-2.6-new/security/selinux/selinuxfs.c	2010-02-01 22:06:=
21.709234039 +0100
@@ -282,7 +282,8 @@ static ssize_t sel_read_mls(struct file=20
 	char tmpbuf[TMPBUFLEN];
 	ssize_t length;
=20
-	length =3D scnprintf(tmpbuf, TMPBUFLEN, "%d", selinux_mls_enabled);
+	length =3D scnprintf(tmpbuf, TMPBUFLEN, "%d",
+			   security_mls_enabled());
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, length);
 }
=20
diff -pruN security-testing-2.6/security/selinux/ss/context.h security-test=
ing-2.6-new/security/selinux/ss/context.h
--- security-testing-2.6/security/selinux/ss/context.h	2010-01-29 01:06:42.=
160060332 +0100
+++ security-testing-2.6-new/security/selinux/ss/context.h	2010-02-01 23:13=
:35.857235582 +0100
@@ -41,7 +41,7 @@ static inline int mls_context_cpy(struct
 {
 	int rc;
=20
-	if (!selinux_mls_enabled)
+	if (!security_mls_enabled())
 		return 0;
=20
 	dst->range.level[0].sens =3D src->range.level[0].sens;
@@ -64,7 +64,7 @@ static inline int mls_context_cpy_low(st
 {
 	int rc;
=20
-	if (!selinux_mls_enabled)
+	if (!security_mls_enabled())
 		return 0;
=20
 	dst->range.level[0].sens =3D src->range.level[0].sens;
@@ -82,7 +82,7 @@ out:
=20
 static inline int mls_context_cmp(struct context *c1, struct context *c2)
 {
-	if (!selinux_mls_enabled)
+	if (!security_mls_enabled())
 		return 1;
=20
 	return ((c1->range.level[0].sens =3D=3D c2->range.level[0].sens) &&
@@ -93,9 +93,6 @@ static inline int mls_context_cmp(struct
=20
 static inline void mls_context_destroy(struct context *c)
 {
-	if (!selinux_mls_enabled)
-		return;
-
 	ebitmap_destroy(&c->range.level[0].cat);
 	ebitmap_destroy(&c->range.level[1].cat);
 	mls_context_init(c);
diff -pruN security-testing-2.6/security/selinux/ss/mls.c security-testing-=
2.6-new/security/selinux/ss/mls.c
--- security-testing-2.6/security/selinux/ss/mls.c	2010-01-29 02:02:47.7390=
46177 +0100
+++ security-testing-2.6-new/security/selinux/ss/mls.c	2010-02-01 22:15:48.=
062233721 +0100
@@ -39,7 +39,7 @@ int mls_compute_context_len(struct conte
 	struct ebitmap *e;
 	struct ebitmap_node *node;
=20
-	if (!selinux_mls_enabled)
+	if (!policydb.mls_enabled)
 		return 0;
=20
 	len =3D 1; /* for the beginning ":" */
@@ -93,7 +93,7 @@ void mls_sid_to_context(struct context *
 	struct ebitmap *e;
 	struct ebitmap_node *node;
=20
-	if (!selinux_mls_enabled)
+	if (!policydb.mls_enabled)
 		return;
=20
 	scontextp =3D *scontext;
@@ -200,7 +200,7 @@ int mls_context_isvalid(struct policydb=20
 {
 	struct user_datum *usrdatum;
=20
-	if (!selinux_mls_enabled)
+	if (!p->mls_enabled)
 		return 1;
=20
 	if (!mls_range_isvalid(p, &c->range))
@@ -253,7 +253,7 @@ int mls_context_to_sid(struct policydb *
 	struct cat_datum *catdatum, *rngdatum;
 	int l, rc =3D -EINVAL;
=20
-	if (!selinux_mls_enabled) {
+	if (!pol->mls_enabled) {
 		if (def_sid !=3D SECSID_NULL && oldc)
 			*scontext +=3D strlen(*scontext)+1;
 		return 0;
@@ -387,7 +387,7 @@ int mls_from_string(char *str, struct co
 	char *tmpstr, *freestr;
 	int rc;
=20
-	if (!selinux_mls_enabled)
+	if (!policydb.mls_enabled)
 		return -EINVAL;
=20
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
@@ -477,7 +477,7 @@ int mls_convert_context(struct policydb=20
 	struct ebitmap_node *node;
 	int l, i;
=20
-	if (!selinux_mls_enabled)
+	if (!policydb.mls_enabled)
 		return 0;
=20
 	for (l =3D 0; l < 2; l++) {
@@ -516,7 +516,7 @@ int mls_compute_sid(struct context *scon
 	struct range_trans rtr;
 	struct mls_range *r;
=20
-	if (!selinux_mls_enabled)
+	if (!policydb.mls_enabled)
 		return 0;
=20
 	switch (specified) {
@@ -559,7 +559,7 @@ int mls_compute_sid(struct context *scon
 void mls_export_netlbl_lvl(struct context *context,
 			   struct netlbl_lsm_secattr *secattr)
 {
-	if (!selinux_mls_enabled)
+	if (!policydb.mls_enabled)
 		return;
=20
 	secattr->attr.mls.lvl =3D context->range.level[0].sens - 1;
@@ -579,7 +579,7 @@ void mls_export_netlbl_lvl(struct contex
 void mls_import_netlbl_lvl(struct context *context,
 			   struct netlbl_lsm_secattr *secattr)
 {
-	if (!selinux_mls_enabled)
+	if (!policydb.mls_enabled)
 		return;
=20
 	context->range.level[0].sens =3D secattr->attr.mls.lvl + 1;
@@ -601,7 +601,7 @@ int mls_export_netlbl_cat(struct context
 {
 	int rc;
=20
-	if (!selinux_mls_enabled)
+	if (!policydb.mls_enabled)
 		return 0;
=20
 	rc =3D ebitmap_netlbl_export(&context->range.level[0].cat,
@@ -629,7 +629,7 @@ int mls_import_netlbl_cat(struct context
 {
 	int rc;
=20
-	if (!selinux_mls_enabled)
+	if (!policydb.mls_enabled)
 		return 0;
=20
 	rc =3D ebitmap_netlbl_import(&context->range.level[0].cat,
diff -pruN security-testing-2.6/security/selinux/ss/mls.h security-testing-=
2.6-new/security/selinux/ss/mls.h
--- security-testing-2.6/security/selinux/ss/mls.h	2010-01-29 01:06:42.1680=
51431 +0100
+++ security-testing-2.6-new/security/selinux/ss/mls.h	2010-02-01 23:17:31.=
025223083 +0100
@@ -39,6 +39,8 @@ int mls_context_to_sid(struct policydb *
=20
 int mls_from_string(char *str, struct context *context, gfp_t gfp_mask);
=20
+int mls_range_set(struct context *context, struct mls_range *range);
+
 int mls_convert_context(struct policydb *oldp,
 			struct policydb *newp,
 			struct context *context);
diff -pruN security-testing-2.6/security/selinux/ss/mls_types.h security-te=
sting-2.6-new/security/selinux/ss/mls_types.h
--- security-testing-2.6/security/selinux/ss/mls_types.h	2010-01-29 01:06:4=
2.168051431 +0100
+++ security-testing-2.6-new/security/selinux/ss/mls_types.h	2010-02-01 22:=
23:11.799224771 +0100
@@ -15,6 +15,7 @@
 #define _SS_MLS_TYPES_H_
=20
 #include "security.h"
+#include "ebitmap.h"
=20
 struct mls_level {
 	u32 sens;		/* sensitivity */
@@ -27,7 +28,7 @@ struct mls_range {
=20
 static inline int mls_level_eq(struct mls_level *l1, struct mls_level *l2)
 {
-	if (!selinux_mls_enabled)
+	if (!security_mls_enabled())
 		return 1;
=20
 	return ((l1->sens =3D=3D l2->sens) &&
@@ -36,7 +37,7 @@ static inline int mls_level_eq(struct ml
=20
 static inline int mls_level_dom(struct mls_level *l1, struct mls_level *l2=
)
 {
-	if (!selinux_mls_enabled)
+	if (!security_mls_enabled())
 		return 1;
=20
 	return ((l1->sens >=3D l2->sens) &&
diff -pruN security-testing-2.6/security/selinux/ss/policydb.c security-tes=
ting-2.6-new/security/selinux/ss/policydb.c
--- security-testing-2.6/security/selinux/ss/policydb.c	2010-01-29 02:02:47=
.740046077 +0100
+++ security-testing-2.6-new/security/selinux/ss/policydb.c	2010-02-01 22:1=
2:18.601226073 +0100
@@ -52,8 +52,6 @@ static char *symtab_name[SYM_NUM] =3D {
 };
 #endif
=20
-int selinux_mls_enabled;
-
 static unsigned int symtab_sizes[SYM_NUM] =3D {
 	2,
 	32,
@@ -455,7 +453,7 @@ static int policydb_index_others(struct=20
=20
 	printk(KERN_DEBUG "SELinux:  %d users, %d roles, %d types, %d bools",
 	       p->p_users.nprim, p->p_roles.nprim, p->p_types.nprim, p->p_bools.n=
prim);
-	if (selinux_mls_enabled)
+	if (p->mls_enabled)
 		printk(", %d sens, %d cats", p->p_levels.nprim,
 		       p->p_cats.nprim);
 	printk("\n");
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
=20
-	config =3D 0;
-
 	rc =3D policydb_init(p);
 	if (rc)
 		goto out;
@@ -1772,7 +1768,7 @@ int policydb_read(struct policydb *p, vo
 	kfree(policydb_str);
 	policydb_str =3D NULL;
=20
-	/* Read the version, config, and table sizes. */
+	/* Read the version and table sizes. */
 	rc =3D next_entry(buf, fp, sizeof(u32)*4);
 	if (rc < 0)
 		goto bad;
@@ -1787,13 +1783,7 @@ int policydb_read(struct policydb *p, vo
 	}
=20
 	if ((le32_to_cpu(buf[1]) & POLICYDB_CONFIG_MLS)) {
-		if (ss_initialized && !selinux_mls_enabled) {
-			printk(KERN_ERR "SELinux: Cannot switch between non-MLS"
-				" and MLS policies\n");
-			goto bad;
-		}
-		selinux_mls_enabled =3D 1;
-		config |=3D POLICYDB_CONFIG_MLS;
+		p->mls_enabled =3D 1;
=20
 		if (p->policyvers < POLICYDB_VERSION_MLS) {
 			printk(KERN_ERR "SELinux: security policydb version %d "
@@ -1801,12 +1791,6 @@ int policydb_read(struct policydb *p, vo
 				p->policyvers);
 			goto bad;
 		}
-	} else {
-		if (ss_initialized && selinux_mls_enabled) {
-			printk(KERN_ERR "SELinux: Cannot switch between MLS and"
-				" non-MLS policies\n");
-			goto bad;
-		}
 	}
 	p->reject_unknown =3D !!(le32_to_cpu(buf[1]) & REJECT_UNKNOWN);
 	p->allow_unknown =3D !!(le32_to_cpu(buf[1]) & ALLOW_UNKNOWN);
diff -pruN security-testing-2.6/security/selinux/ss/policydb.h security-tes=
ting-2.6-new/security/selinux/ss/policydb.h
--- security-testing-2.6/security/selinux/ss/policydb.h	2010-01-29 02:02:47=
.740046077 +0100
+++ security-testing-2.6-new/security/selinux/ss/policydb.h	2010-02-01 20:4=
7:08.352232380 +0100
@@ -27,6 +27,8 @@
 #include "symtab.h"
 #include "avtab.h"
 #include "sidtab.h"
+#include "ebitmap.h"
+#include "mls_types.h"
 #include "context.h"
 #include "constraint.h"
=20
@@ -185,6 +187,8 @@ struct genfs {
=20
 /* The policy database */
 struct policydb {
+	int mls_enabled;
+
 	/* symbol tables */
 	struct symtab symtab[SYM_NUM];
 #define p_commons symtab[SYM_COMMONS]
diff -pruN security-testing-2.6/security/selinux/ss/services.c security-tes=
ting-2.6-new/security/selinux/ss/services.c
--- security-testing-2.6/security/selinux/ss/services.c	2010-01-29 02:02:47=
.742042805 +0100
+++ security-testing-2.6-new/security/selinux/ss/services.c	2010-02-02 14:2=
8:05.222993305 +0100
@@ -26,6 +26,10 @@
  *
  *  Added support for bounds domain and audit messaged on masked permissio=
ns
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
=20
+/*
+ * Returns a boolean value.
+ * True: if the currently active policy is MLS or MCS
+ * False: if the currently active policy is a standard policy
+ * 	  without MLS/MCS support
+ */
+int security_mls_enabled(void)
+{
+	return policydb.mls_enabled;
+}
=20
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
@@ -1614,9 +1630,42 @@ static int convert_context(u32 key,
 		goto bad;
 	c->type =3D typdatum->value;
=20
-	rc =3D mls_convert_context(args->oldp, args->newp, c);
-	if (rc)
-		goto bad;
+	/* Convert the MLS/MCS fields if dealing with MLS/MCS policies */
+	if (args->oldp->mls_enabled && args->newp->mls_enabled) {
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
+	else if (args->oldp->mls_enabled && !args->newp->mls_enabled)
+		mls_context_destroy(c);
+
+	/*
+	 * Switching between non-MLS/non-MCS and MLS/MCS policy:
+	 * ensure that the MLS fields of the context for all
+	 * existing entries in the sidtab are filled in with a
+	 * suitable default value, likely taken from one of the
+	 * initial SIDs.
+	 */
+	else if (!args->oldp->mls_enabled && args->newp->mls_enabled) {
+		oc =3D args->newp->ocontexts[OCON_ISID];
+		while (oc && oc->sid[0] !=3D SECINITSID_UNLABELED)
+			oc =3D oc->next;
+		if (!oc) {
+			printk(KERN_ERR "SELinux:  unable to look up"
+				" the initial SIDs list\n");
+			goto bad;
+		}
+		range =3D &oc->context[0].range;
+		rc =3D mls_range_set(c, range);
+		if (rc)
+			goto bad;
+	}
=20
 	/* Check the validity of the new context. */
 	if (!policydb_context_isvalid(args->newp, c)) {
@@ -1712,6 +1761,14 @@ int security_load_policy(void *data, siz
 	if (policydb_read(&newpolicydb, fp))
 		return -EINVAL;
=20
+	/* If switching between different policy types, log it */
+	if (policydb.mls_enabled && !newpolicydb.mls_enabled)
+		printk(KERN_INFO "SELinux: Switching between MLS/MCS"
+			" and standard policy...\n");
+	else if (!policydb.mls_enabled && newpolicydb.mls_enabled)
+		printk(KERN_INFO "SELinux: Switching between standard"
+			" and MLS/MCS policy...\n");
+
 	if (sidtab_init(&newsidtab)) {
 		policydb_destroy(&newpolicydb);
 		return -ENOMEM;
@@ -1741,8 +1798,12 @@ int security_load_policy(void *data, siz
 	args.oldp =3D &policydb;
 	args.newp =3D &newpolicydb;
 	rc =3D sidtab_map(&newsidtab, convert_context, &args);
-	if (rc)
+	if (rc) {
+		printk(KERN_ERR "SELinux:  unable to convert the internal"
+			" representation of contexts in the new SID"
+			" table\n");
 		goto err;
+	}
=20
 	/* Save the old policydb and SID table to free later. */
 	memcpy(&oldpolicydb, &policydb, sizeof policydb);
@@ -2338,7 +2399,7 @@ int security_sid_mls_copy(u32 sid, u32 m
 	u32 len;
 	int rc =3D 0;
=20
-	if (!ss_initialized || !selinux_mls_enabled) {
+	if (!ss_initialized || !policydb.mls_enabled) {
 		*new_sid =3D sid;
 		goto out;
 	}
@@ -2439,7 +2500,7 @@ int security_net_peersid_resolve(u32 nlb
 	/* we don't need to check ss_initialized here since the only way both
 	 * nlbl_sid and xfrm_sid are not equal to SECSID_NULL would be if the
 	 * security server was initialized and ss_initialized was true */
-	if (!selinux_mls_enabled) {
+	if (!policydb.mls_enabled) {
 		*peer_sid =3D SECSID_NULL;
 		return 0;
 	}


--=-a/6Nwt7ixu2bY2GjE1us
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIRQDCCA+Mw
ggLLoAMCAQICCwQAAAAAAR5Epd8xMA0GCSqGSIb3DQEBBQUAMFcxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMRAwDgYDVQQLEwdSb290IENBMRswGQYDVQQDExJHbG9iYWxT
aWduIFJvb3QgQ0EwHhcNOTkwMTI4MTMwMDAwWhcNMTcwMTI3MTIwMDAwWjBtMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEbMBkGA1UECxMSUHJpbWFyeSBDbGFzcyAyIENB
MSYwJAYDVQQDEx1HbG9iYWxTaWduIFByaW1hcnkgQ2xhc3MgMiBDQTCCASIwDQYJKoZIhvcNAQEB
BQADggEPADCCAQoCggEBAJKM/u/0RY4XQW782L8hb6sGnVLBLACdP46FuH9Kj72gYyrKSSeuWoL0
dOJVkv/C0ap5orb61Z2CBE/GssZeY6c6utju64pvn7a7KEHAIvtOSBoGkte/18+52b04TzsNRG5V
Qf78CdvYv/OOIfHoErX2E6XTxkyTIrAC/+4dDMSoa091aFbo3CgSUPeoJJ0uJDn7CQXe5aNkSSHQ
aH5xMJGxYOA59FD4ek2YAGt8ebpOzkriujYdt8U2FZWcZELqX8S69UAFvuE6Wb2Epxm43k1TUM4H
0dJR0+8NgWzm523LXXw/fMzsT4MnJf9wUPaDWXWEBmZYLN6JjQCmSfmlQ3cCAwEAAaOBmTCBljAO
BgNVHQ8BAf8EBAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUfOeysSzesadr6XYM4aP9
TmzHufYwMwYDVR0fBCwwKjAooCagJIYiaHR0cDovL2NybC5nbG9iYWxzaWduLm5ldC9Sb290LmNy
bDAfBgNVHSMEGDAWgBRge2YaRQ2XyolQL30EzTSo//z9SzANBgkqhkiG9w0BAQUFAAOCAQEAaBGO
Ogw8U53EnefKCVUq5Csfopg5Xle/KA6opTuhHyjrXDha/GyF7/EJg1I8Azk1RUZFt+yNwQJ61umV
nTOsN9xrmbtj3/0cWo5N3ABbV1cyB3FOKVHVVNG2105crky3BP0AeT/pOc/FeNGtJ33Li498UTll
MLekCSXffKLk1ut7foPdqikDwqVsTEB/z8Dyn9fTz4LGf81gfCUI9/KeD0B2v7P+3TLoq5EZ0uCE
2oxnJTGnjqqKlqJ5YMVVV7ClZ+5KSHkuwHbgH0FuVyG+5umdSyQsbaGGrIDjnhln2jJhWxWE28TX
YXSEBLk0+FD7d716nvgIhVAUWAlzIdQW9TCCBEgwggMwoAMCAQICCwEAAAAAARnEKxYdMA0GCSqG
SIb3DQEBBQUAMHcxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSAwHgYD
VQQLExdQZXJzb25hbFNpZ24gQ2xhc3MgMiBDQTErMCkGA1UEAxMiR2xvYmFsU2lnbiBQZXJzb25h
bFNpZ24gQ2xhc3MgMiBDQTAeFw0wODA1MDcxNjE1NTZaFw0xMTA1MDcxNjE1NTZaMFExCzAJBgNV
BAYTAklUMRswGQYDVQQDExJHdWlkbyBUcmVudGFsYW5jaWExJTAjBgkqhkiG9w0BCQEWFmd1aWRv
QHRyZW50YWxhbmNpYS5jb20wgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAK11FqVBG7mNDn6k
StMwmEfRraPRBK92ZlBcss85omBCowomOm1fSB3qa6MeDZ3heLOBeUvDt1oi1X90lYNYb9hIvECC
jppBNIogKa4XGlYHRVDgtdJ52llG68uMsIWv4vSFI52iOQn+ARn7TDF4rhGLW4s1EPXBcHsueVWR
w3NfAgMBAAGjggF9MIIBeTAfBgNVHSMEGDAWgBRtxCvBfYUQoPkTFg1VKwO6NkwhMTBWBggrBgEF
BQcBAQRKMEgwRgYIKwYBBQUHMAKGOmh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5uZXQvY2FjZXJ0
L1BlcnNvbmFsU2lnbkNsYXNzMi5jcnQwQQYDVR0fBDowODA2oDSgMoYwaHR0cDovL2NybC5nbG9i
YWxzaWduLm5ldC9QZXJzb25hbFNpZ25DbGFzczIuY3JsMCEGA1UdEQQaMBiBFmd1aWRvQHRyZW50
YWxhbmNpYS5jb20wCQYDVR0TBAIwADAOBgNVHQ8BAf8EBAMCBPAwHQYDVR0lBBYwFAYIKwYBBQUH
AwIGCCsGAQUFBwMEMEsGA1UdIAREMEIwQAYJKwYBBAGgMgEoMDMwMQYIKwYBBQUHAgEWJWh0dHA6
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
cS7/svfjAczX3YkAphIkwyRE2LaJgk6oQJARBSwgXFXy4XaJOIZ6X2TxLviBXpN4TgRXCuRReCqz
6Pkku0leRSmL8Te1qZtDHzdxnMQyq+EqAzO9Hh+SavdJW90ps0Puaqt4uJSeCOkyUDG+av/37ooy
6DRxwF2fJAUBqQ6YWRnN9WHkxGKGFpMriAHIiPjo7K7yRv2l3DkxxYJ2mzlIcUtchYuEJKVkAYn0
9GQp0l7DHcIWx3Mm259HKuY1TnL2dKXZNqMCAwEAAaOCAVIwggFOMA4GA1UdDwEB/wQEAwIBBjAS
BgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdDgQWBBRtxCvBfYUQoPkTFg1VKwO6NkwhMTBKBgNVHSAE
QzBBMD8GCSsGAQQBoDIBKDAyMDAGCCsGAQUFBwIBFiRodHRwOi8vd3d3Lmdsb2JhbHNpZ24ubmV0
L3JlcG9zaXRvcnkwOQYDVR0fBDIwMDAuoCygKoYoaHR0cDovL2NybC5nbG9iYWxzaWduLm5ldC9w
cmltY2xhc3MyLmNybDBOBggrBgEFBQcBAQRCMEAwPgYIKwYBBQUHMAKGMmh0dHA6Ly9zZWN1cmUu
Z2xvYmFsc2lnbi5uZXQvY2FjZXJ0L1ByaW1DbGFzczIuY3J0MBEGCWCGSAGG+EIBAQQEAwIBBjAf
BgNVHSMEGDAWgBR857KxLN6xp2vpdgzho/1ObMe59jANBgkqhkiG9w0BAQUFAAOCAQEAIeiZXpNE
cfQVJPkS+Xi17bLQlIRYfUAWl3576ZJ849BwN9K1kM4j8xg4MMqXxQ3LoJv/yI9p6qfqrudb8m4a
XkeI/05AQXBhvB00XoVLtHuyfmTcTmDwPb1aHG8g2p5I0i4/w6byU5VyY27aX9d4TjN/IxWzbRIv
QIhx+OR2q+IpYnK5vy6lqfSOqV0h5fi64JqycIqL7eAznQPxK/AFjRuly36QbnYkhLDZLdxsEdwc
247May7y2/XsjK8qMKIyvvkAwS2iCuzYVc2yoOEPptjZgKLslYMBWzPwHW9C0Ib9+3+ZfzhQ8L+/
N+H07wcP2/YLBC6chg9h79lhGSrIbzGCAsQwggLAAgEBMIGGMHcxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSAwHgYDVQQLExdQZXJzb25hbFNpZ24gQ2xhc3MgMiBDQTEr
MCkGA1UEAxMiR2xvYmFsU2lnbiBQZXJzb25hbFNpZ24gQ2xhc3MgMiBDQQILAQAAAAABGcQrFh0w
CQYFKw4DAhoFAKCCAZMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcN
MTAwMjAyMTQyMjI4WjAjBgkqhkiG9w0BCQQxFgQUNtVJkhlVKQxdtFzo/AOSOl12MYIwgZcGCSsG
AQQBgjcQBDGBiTCBhjB3MQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEg
MB4GA1UECxMXUGVyc29uYWxTaWduIENsYXNzIDIgQ0ExKzApBgNVBAMTIkdsb2JhbFNpZ24gUGVy
c29uYWxTaWduIENsYXNzIDIgQ0ECCwEAAAAAARnEKxYdMIGZBgsqhkiG9w0BCRACCzGBiaCBhjB3
MQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEgMB4GA1UECxMXUGVyc29u
YWxTaWduIENsYXNzIDIgQ0ExKzApBgNVBAMTIkdsb2JhbFNpZ24gUGVyc29uYWxTaWduIENsYXNz
IDIgQ0ECCwEAAAAAARnEKxYdMA0GCSqGSIb3DQEBAQUABIGAA6UVBh/NHUoHX/P7uek4R6rou4V4
5Y9fOgq6k8p9Yx6vJAdyZwt9bh9BSoFe4VNsu8Zz6Pr5NRN6RmLEe4I9P7blNvVxYOTMbgVmcUSR
vTTgbvQZCKTvZ/PQUF7R3S4lDjZTHyThhmLbGi6KvCXd+2A61bDElTODSuMcvdgb6q0AAAAAAAA=


--=-a/6Nwt7ixu2bY2GjE1us--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
