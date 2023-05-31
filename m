Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79361C7EE31
	for <selinux@archiver.kernel.org>; Wed, 31 May 2023 11:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjEaLcu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 May 2023 07:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjEaLct (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 May 2023 07:32:49 -0400
Received: from sender11-of-o52.zoho.eu (sender11-of-o52.zoho.eu [31.186.226.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4D4B2
        for <selinux@vger.kernel.org>; Wed, 31 May 2023 04:32:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685532763; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=HKDOCR7cScIUMnyjHsu2s+0K8M0ke2fIW8HeX0T7OREP0EtRwoqg1nhigIJzJ7KHTP+U3l2bTfS7wTud/CRSyP7Dl6K0CWiraHDnulgHVeJKmEA0TaUBchEEPaS2DX0m3Qm4r4ll4jKliJOoJViPQR8os9mgr/RR3Ec5GQsEoZU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1685532763; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=I+52IdUDvPBaUKjSOxvO/U3gSWccVwotlotI9R/0pOw=; 
        b=W/ItSZQXeamStiOYSFr77QObatEnd3j807eMdIzabi1F2Pumwr1y6McLBIE3fXu3poaeMYyjlZhLzY0sYCkFhBzel1VYoU2VWeceZlyfnTlJqZH3Xnuvg4TH5zPGlHk48uf+Rzn/qyCkxJGJxd9ndHMFgeduAlQpAY0FiqFDYlY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=jurajmarcin.com;
        spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
        dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1685532763;
        s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=I+52IdUDvPBaUKjSOxvO/U3gSWccVwotlotI9R/0pOw=;
        b=SWqVUmbbt9ykPYIvbcvGbLQvwQgtKsD7V1qjpkWA0Dlna0uGOAu09rqVG4w6ORPi
        wwX74nf/eauPLap2Zl4lWuBKFZVpwT0DM6/ahBja1etx628B76mI5bc6KInjDGTm8Av
        GL1MgEwQpQnXU8Qt1DxBMYOz9uLdwUPhKMk+eKMY=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
        with SMTPS id 1685532762045924.6464679151087; Wed, 31 May 2023 13:32:42 +0200 (CEST)
Received: from jmarcin-t14s-01.redhat.com (unknown [147.251.183.113])
        by morty01.jurajmarcin.com (Postfix) with ESMTPSA id 6D5C92081F76;
        Wed, 31 May 2023 11:32:41 +0000 (UTC)
From:   Juraj Marcin <juraj@jurajmarcin.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH 5/5] selinux: add prefix/suffix matching support to filename type transitions
Date:   Wed, 31 May 2023 13:29:28 +0200
Message-Id: <20230531112927.1957093-6-juraj@jurajmarcin.com>
In-Reply-To: <20230531112927.1957093-1-juraj@jurajmarcin.com>
References: <20230531112927.1957093-1-juraj@jurajmarcin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Currently, filename type transitions support only exact name matching.
However, in practice, the names contain variable parts. This leads to
many duplicated rules in the policy that differ only in the part of the
name, or it is even impossible to cover all possible combinations.

This patch extends the filename type transitions structures to include
new types of filename transitions - prefix and suffix filename
transitions. It also implements the reading and writing of those rules
in the kernel binary policy format together with increasing its version.
Last, it updates the function responsible for determining the new
context to also include the prefix and suffix filename transitions in
the process. It does that by first checking for the exact match, then
the longest matching prefix and then the longest matching suffix, in
that order. That way the exact match rules have precedence before new
rules, to ensure compatibility with older policies.

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
---
 security/selinux/include/security.h |  3 +-
 security/selinux/ss/avtab.c         | 53 +++++++++++++++++++--
 security/selinux/ss/avtab.h         |  2 +
 security/selinux/ss/avtab_test.c    | 16 +++++++
 security/selinux/ss/policydb.c      |  5 ++
 security/selinux/ss/services.c      | 71 ++++++++++++++++++++++++-----
 6 files changed, 133 insertions(+), 17 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/inclu=
de/security.h
index c483680fe22e..0cf0767d061b 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -47,10 +47,11 @@
 #define POLICYDB_VERSION_GLBLUB		32
 #define POLICYDB_VERSION_COMP_FTRANS	33 /* compressed filename transitio=
ns */
 #define POLICYDB_VERSION_AVTAB_FTRANS	34 /* filename transitions moved t=
o avtab */
+#define POLICYDB_VERSION_PREFIX_SUFFIX	35 /* prefix/suffix support for f=
ilename transitions */
=20
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_AVTAB_FTRANS
+#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_PREFIX_SUFFIX
=20
 /* Mask for just the mount related flags */
 #define SE_MNTMASK	0x0f
diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index db7123670ef8..f58707930189 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -301,6 +301,12 @@ static void avtab_trans_destroy(struct avtab_trans *=
trans)
 {
 	hashtab_map(&trans->name_trans.table, avtab_trans_destroy_helper, NULL)=
;
 	hashtab_destroy(&trans->name_trans.table);
+	hashtab_map(&trans->prefix_trans.table, avtab_trans_destroy_helper,
+		    NULL);
+	hashtab_destroy(&trans->prefix_trans.table);
+	hashtab_map(&trans->suffix_trans.table, avtab_trans_destroy_helper,
+		    NULL);
+	hashtab_destroy(&trans->suffix_trans.table);
 }
=20
 void avtab_destroy(struct avtab *h)
@@ -517,6 +523,14 @@ static int avtab_trans_read(void *fp, struct policyd=
b *pol,
 	if (rc)
 		goto bad;
=20
+	if (pol->policyvers >=3D POLICYDB_VERSION_PREFIX_SUFFIX) {
+		rc =3D avtab_trans_read_name_trans(pol, &trans->prefix_trans, fp);
+		if (rc)
+			goto bad;
+		rc =3D avtab_trans_read_name_trans(pol, &trans->suffix_trans, fp);
+		if (rc)
+			goto bad;
+	}
 	return 0;
=20
 bad:
@@ -706,9 +720,14 @@ int avtab_read_item(struct avtab *a, void *fp, struc=
t policydb *pol,
 		 * also each transition entry must meet at least one condition
 		 * to be considered non-empty:
 		 *  - set (non-zero) otype
-		 *  - non-empty filename transitions table
+		 *  - non-empty full name transitions table
+		 *  - non-empty prefix name transitions table
+		 *  - non-empty suffix name transitions table
 		 */
-		if (!otype && !datum.u.trans->name_trans.table.nel) {
+		if (!otype &&
+		    !datum.u.trans->name_trans.table.nel &&
+		    !datum.u.trans->prefix_trans.table.nel &&
+		    !datum.u.trans->suffix_trans.table.nel) {
 			pr_err("SELinux: avtab: empty transition\n");
 			avtab_trans_destroy(&trans);
 			return -EINVAL;
@@ -809,18 +828,44 @@ static int avtab_trans_write(struct policydb *p, st=
ruct avtab_trans *cur,
 	__le32 buf32[2];
=20
 	if (p->policyvers >=3D POLICYDB_VERSION_AVTAB_FTRANS) {
-		/* write otype and number of filename transitions */
+		/* write otype and number of name transitions */
 		buf32[0] =3D cpu_to_le32(cur->otype);
 		buf32[1] =3D cpu_to_le32(cur->name_trans.table.nel);
 		rc =3D put_entry(buf32, sizeof(u32), 2, fp);
 		if (rc)
 			return rc;
=20
-		/* write filename transitions */
+		/* write name transitions */
 		rc =3D hashtab_map(&cur->name_trans.table,
 				 avtab_trans_write_helper, fp);
 		if (rc)
 			return rc;
+
+		if (p->policyvers >=3D POLICYDB_VERSION_PREFIX_SUFFIX) {
+			/* write number of prefix transitions */
+			buf32[0] =3D cpu_to_le32(cur->prefix_trans.table.nel);
+			rc =3D put_entry(buf32, sizeof(u32), 1, fp);
+			if (rc)
+				return rc;
+
+			/* write prefix transitions */
+			rc =3D hashtab_map(&cur->prefix_trans.table,
+					 avtab_trans_write_helper, fp);
+			if (rc)
+				return rc;
+
+			/* write number of suffix transitions */
+			buf32[0] =3D cpu_to_le32(cur->suffix_trans.table.nel);
+			rc =3D put_entry(buf32, sizeof(u32), 1, fp);
+			if (rc)
+				return rc;
+
+			/* write suffix transitions */
+			rc =3D hashtab_map(&cur->suffix_trans.table,
+					 avtab_trans_write_helper, fp);
+			if (rc)
+				return rc;
+		}
 	} else if (cur->otype) {
 		buf32[0] =3D cpu_to_le32(cur->otype);
 		rc =3D put_entry(buf32, sizeof(u32), 1, fp);
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index 162ef1be85e7..929e322715d1 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -51,6 +51,8 @@ struct avtab_key {
 struct avtab_trans {
 	u32 otype;		/* default resulting type of the new object */
 	struct symtab name_trans;	/* filename transitions */
+	struct symtab prefix_trans;	/* prefix filename transitions */
+	struct symtab suffix_trans;	/* prefix filename transitions */
 };
=20
 /*
diff --git a/security/selinux/ss/avtab_test.c b/security/selinux/ss/avtab=
_test.c
index daa8e4cfaeb2..7e63204629fd 100644
--- a/security/selinux/ss/avtab_test.c
+++ b/security/selinux/ss/avtab_test.c
@@ -124,6 +124,8 @@ static void filename_trans_read__simple(struct kunit =
*test)
 	KUNIT_ASSERT_NOT_NULL(test, node);
 	KUNIT_EXPECT_EQ(test, 0, node->u.trans->otype);
 	KUNIT_EXPECT_EQ(test, 1, node->u.trans->name_trans.table.nel);
+	KUNIT_EXPECT_EQ(test, 0, node->u.trans->prefix_trans.table.nel);
+	KUNIT_EXPECT_EQ(test, 0, node->u.trans->suffix_trans.table.nel);
=20
 	otype =3D symtab_search(&node->u.trans->name_trans, "file1");
 	KUNIT_ASSERT_NOT_NULL(test, otype);
@@ -134,6 +136,8 @@ static void filename_trans_read__simple(struct kunit =
*test)
 	KUNIT_ASSERT_NOT_NULL(test, node);
 	KUNIT_EXPECT_EQ(test, 0, node->u.trans->otype);
 	KUNIT_EXPECT_EQ(test, 2, node->u.trans->name_trans.table.nel);
+	KUNIT_EXPECT_EQ(test, 0, node->u.trans->prefix_trans.table.nel);
+	KUNIT_EXPECT_EQ(test, 0, node->u.trans->suffix_trans.table.nel);
=20
 	otype =3D symtab_search(&node->u.trans->name_trans, "file2");
 	KUNIT_ASSERT_NOT_NULL(test, otype);
@@ -213,6 +217,8 @@ static void filename_trans_read__comp_simple(struct k=
unit *test)
 	KUNIT_ASSERT_NOT_NULL(test, node);
 	KUNIT_EXPECT_EQ(test, 0, node->u.trans->otype);
 	KUNIT_EXPECT_EQ(test, 1, node->u.trans->name_trans.table.nel);
+	KUNIT_EXPECT_EQ(test, 0, node->u.trans->prefix_trans.table.nel);
+	KUNIT_EXPECT_EQ(test, 0, node->u.trans->suffix_trans.table.nel);
=20
 	otype =3D symtab_search(&node->u.trans->name_trans, "file1");
 	KUNIT_ASSERT_NOT_NULL(test, otype);
@@ -223,6 +229,8 @@ static void filename_trans_read__comp_simple(struct k=
unit *test)
 	KUNIT_ASSERT_NOT_NULL(test, node);
 	KUNIT_EXPECT_EQ(test, 0, node->u.trans->otype);
 	KUNIT_EXPECT_EQ(test, 2, node->u.trans->name_trans.table.nel);
+	KUNIT_EXPECT_EQ(test, 0, node->u.trans->prefix_trans.table.nel);
+	KUNIT_EXPECT_EQ(test, 0, node->u.trans->suffix_trans.table.nel);
=20
 	otype =3D symtab_search(&node->u.trans->name_trans, "file2");
 	KUNIT_ASSERT_NOT_NULL(test, otype);
@@ -493,12 +501,16 @@ static void read__pre_avtab_ftrans(struct kunit *te=
st)
 	KUNIT_ASSERT_NOT_NULL(test, node);
 	KUNIT_EXPECT_EQ(test, 45, node->u.trans->otype);
 	KUNIT_EXPECT_EQ(test, 0, node->u.trans->name_trans.table.nel);
+	KUNIT_EXPECT_EQ(test, 0, node->u.trans->prefix_trans.table.nel);
+	KUNIT_EXPECT_EQ(test, 0, node->u.trans->suffix_trans.table.nel);
=20
 	key =3D (struct avtab_key){46, 47, 48, AVTAB_TRANSITION};
 	node =3D avtab_search(&p.te_avtab, &key);
 	KUNIT_ASSERT_NOT_NULL(test, node);
 	KUNIT_EXPECT_EQ(test, 49, node->u.trans->otype);
 	KUNIT_EXPECT_EQ(test, 0, node->u.trans->name_trans.table.nel);
+	KUNIT_EXPECT_EQ(test, 0, node->u.trans->prefix_trans.table.nel);
+	KUNIT_EXPECT_EQ(test, 0, node->u.trans->suffix_trans.table.nel);
=20
 	avtab_destroy(&p.te_avtab);
 }
@@ -555,6 +567,8 @@ static void read__simple(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, node);
 	KUNIT_EXPECT_EQ(test, 41, node->u.trans->otype);
 	KUNIT_EXPECT_EQ(test, 1, node->u.trans->name_trans.table.nel);
+	KUNIT_EXPECT_EQ(test, 0, node->u.trans->prefix_trans.table.nel);
+	KUNIT_EXPECT_EQ(test, 0, node->u.trans->suffix_trans.table.nel);
=20
 	otype =3D symtab_search(&node->u.trans->name_trans, "file1");
 	KUNIT_ASSERT_NOT_NULL(test, otype);
@@ -565,6 +579,8 @@ static void read__simple(struct kunit *test)
 	KUNIT_ASSERT_NOT_NULL(test, node);
 	KUNIT_EXPECT_EQ(test, 40, node->u.trans->otype);
 	KUNIT_EXPECT_EQ(test, 2, node->u.trans->name_trans.table.nel);
+	KUNIT_EXPECT_EQ(test, 0, node->u.trans->prefix_trans.table.nel);
+	KUNIT_EXPECT_EQ(test, 0, node->u.trans->suffix_trans.table.nel);
=20
 	otype =3D symtab_search(&node->u.trans->name_trans, "file2");
 	KUNIT_ASSERT_NOT_NULL(test, otype);
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
index 96b8d5bd8e4e..db759ec3e1ce 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -162,6 +162,11 @@ static const struct policydb_compat_info policydb_co=
mpat[] =3D {
 		.sym_num	=3D SYM_NUM,
 		.ocon_num	=3D OCON_NUM,
 	},
+	{
+		.version	=3D POLICYDB_VERSION_PREFIX_SUFFIX,
+		.sym_num	=3D SYM_NUM,
+		.ocon_num	=3D OCON_NUM,
+	},
 };
=20
 static const struct policydb_compat_info *policydb_lookup_compat(int ver=
sion)
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
index 131647e7ec68..2faf92bf12da 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1661,6 +1661,60 @@ static int compute_sid_handle_invalid_context(
 	return -EACCES;
 }
=20
+static int security_compute_type_trans_otype(struct avtab_trans *trans,
+					     const char *name, u32 *res_type)
+{
+	u32 *otype;
+	size_t len;
+	char *namedup =3D NULL;
+	size_t i;
+
+	/*
+	 * use default otype if not empty and then try to find more specific
+	 * rule using name
+	 */
+	if (trans->otype)
+		*res_type =3D trans->otype;
+	if (!name)
+		return 0;
+
+	/* try to find full name */
+	otype =3D symtab_search(&trans->name_trans, name);
+	if (otype) {
+		*res_type =3D *otype;
+		return 0;
+	}
+
+	/* copy name for shortening */
+	len =3D strlen(name);
+	namedup =3D kmemdup(name, len + 1, GFP_KERNEL);
+	if (!namedup)
+		return -ENOMEM;
+
+	/* try to find possible prefixes of name starting from the longest */
+	for (i =3D len; i > 0; i--) {
+		namedup[i] =3D '\0';
+		otype =3D symtab_search(&trans->prefix_trans, namedup);
+		if (otype) {
+			kfree(namedup);
+			*res_type =3D *otype;
+			return 0;
+		}
+	}
+	kfree(namedup);
+
+	/*try to find possible suffixes of name starting from the longest */
+	for (i =3D 0; i < len; i++) {
+		otype =3D symtab_search(&trans->suffix_trans, &name[i]);
+		if (otype) {
+			*res_type =3D *otype;
+			return 0;
+		}
+	}
+
+	return 0;
+}
+
 static int security_compute_sid(u32 ssid,
 				u32 tsid,
 				u16 orig_tclass,
@@ -1802,18 +1856,11 @@ static int security_compute_sid(u32 ssid,
 	if (avdatum) {
 		/* Use the type from the type transition/member/change rule. */
 		if (avkey.specified & AVTAB_TRANSITION) {
-			/*
-			 * use default otype if not empty and then to try to
-			 * find more specific rule using objname
-			 */
-			if (avdatum->u.trans->otype)
-				newcontext.type =3D avdatum->u.trans->otype;
-			if (objname) {
-				otype =3D symtab_search(&avdatum->u.trans->name_trans,
-						      objname);
-				if (otype)
-					newcontext.type =3D *otype;
-			}
+			rc =3D security_compute_type_trans_otype(avdatum->u.trans,
+							       objname,
+							       &newcontext.type);
+			if (rc)
+				goto out_unlock;
 		} else {
 			newcontext.type =3D avdatum->u.data;
 		}
--=20
2.40.0

