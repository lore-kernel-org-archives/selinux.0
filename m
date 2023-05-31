Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC6EC77B73
	for <selinux@archiver.kernel.org>; Wed, 31 May 2023 11:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjEaLcr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 May 2023 07:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233024AbjEaLcp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 May 2023 07:32:45 -0400
Received: from sender11-of-o52.zoho.eu (sender11-of-o52.zoho.eu [31.186.226.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0F9132
        for <selinux@vger.kernel.org>; Wed, 31 May 2023 04:32:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685532754; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=fBA6Z5ZRK6rItSq7G6O9pBMwZAa2tcImWbCp5KKj75E9U8IcMwNP6mna+X6yUAfjZcvfrELa2LZIKD2dJy8vcInML07lK8F0P9hUHrHrsMoJuXkPek/qOEbak/GQN29kF0HsCQZZFomw1m0uVzVaN5dKQeHIMhYcJNBhR8bgoCo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1685532754; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=UUfCud7Was1fdoE2+mBB0S0D6ta6gyloHW/eQTFbHi8=; 
        b=jyklAiUKGThgsCAkJz1LeiUEcTeDbpMFCS5f85lJajLF8hWtXhEVhvKPZ0NpWBZQEyihDJ8R4wlQjW37z+eYL2yAs3gRcmsLMohvc9qUMBTmSdMUZ28NTsuQmlcSz05J9gqIl3R8kJZi4t/uFb8W5GznrbU52lTSnkk8sfCwlrE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=jurajmarcin.com;
        spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
        dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1685532754;
        s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=UUfCud7Was1fdoE2+mBB0S0D6ta6gyloHW/eQTFbHi8=;
        b=eSEzdR3RU63LmCZcLY5s4J5YzcMrqwkiWoWqUmWTUhdwXA+3jowMSFWo0zYgZI3y
        9nAlzplNK1z0VIBwS/OfKjRzc3CBLJicmdKVXPFCPbjXUHgTmV1+7/gwnURtEjJBcyw
        gtb3cdfSgEcS/aclEm64TE+Hbj4++Lq9yM+1qDhg=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
        with SMTPS id 1685532752529749.0499511845534; Wed, 31 May 2023 13:32:32 +0200 (CEST)
Received: from jmarcin-t14s-01.redhat.com (unknown [147.251.183.113])
        by morty01.jurajmarcin.com (Postfix) with ESMTPSA id E8A552081F76;
        Wed, 31 May 2023 11:32:31 +0000 (UTC)
From:   Juraj Marcin <juraj@jurajmarcin.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH 3/5] selinux: implement new binary format for filename transitions in avtab
Date:   Wed, 31 May 2023 13:29:26 +0200
Message-Id: <20230531112927.1957093-4-juraj@jurajmarcin.com>
In-Reply-To: <20230531112927.1957093-1-juraj@jurajmarcin.com>
References: <20230531112927.1957093-1-juraj@jurajmarcin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Implement a new binary policy format that closely matches the new
internal representation introduced in the previous patch.

This patch bumps the maximum kernel policy version and implements
reading/writing functions such that kernel binary policy structure
matches internal representation.

These changes cause the binary policy to grow in size due to effectively
undoing the benefits of the commit 430059024389 ("selinux: implement new
format of filename transitions"), as well as increase its loading time,
but this will be mitigated by adding the prefix/suffix support as
described in the previous patch.

Kernel     | Policy file  |  Policy size | Policy load
           | version      |              | time
-----------+--------------+--------------+-------------
reference  |           33 |       3.5 MB |       78 ms
prev patch |           33 |       3.5 MB |      230 ms
this patch |           34 |       5.5 MB |      113 ms

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
---
 security/selinux/include/security.h |   3 +-
 security/selinux/ss/avtab.c         | 189 ++++++++++++++++++++++++++--
 security/selinux/ss/policydb.c      |  21 +++-
 3 files changed, 195 insertions(+), 18 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/inclu=
de/security.h
index 8746fafeb778..c483680fe22e 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -46,10 +46,11 @@
 #define POLICYDB_VERSION_INFINIBAND		31
 #define POLICYDB_VERSION_GLBLUB		32
 #define POLICYDB_VERSION_COMP_FTRANS	33 /* compressed filename transitio=
ns */
+#define POLICYDB_VERSION_AVTAB_FTRANS	34 /* filename transitions moved t=
o avtab */
=20
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN   POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_COMP_FTRANS
+#define POLICYDB_VERSION_MAX   POLICYDB_VERSION_AVTAB_FTRANS
=20
 /* Mask for just the mount related flags */
 #define SE_MNTMASK	0x0f
diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index fe921e1586e5..2cd9eabf796c 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -426,6 +426,95 @@ static const uint16_t spec_order[] =3D {
 	AVTAB_XPERMS_DONTAUDIT
 };
=20
+static int avtab_trans_read_name_trans(struct policydb *pol,
+					   struct symtab *target, void *fp)
+{
+	int rc;
+	__le32 buf32[2];
+	u32 nfnts, i, len, *fnt_otype =3D NULL;
+	char *name =3D NULL;
+
+	/* read number of name transitions */
+	rc =3D next_entry(buf32, fp, sizeof(u32));
+	if (rc)
+		return rc;
+	nfnts =3D le32_to_cpu(buf32[0]);
+
+	rc =3D symtab_init(target, nfnts);
+	if (rc)
+		return rc;
+
+	/* read name transitions */
+	for (i =3D 0; i < nfnts; i++) {
+		rc =3D -ENOMEM;
+		fnt_otype =3D kmalloc(sizeof(u32), GFP_KERNEL);
+		if (!fnt_otype)
+			goto exit;
+
+		/* read name transition otype and name length */
+		rc =3D next_entry(buf32, fp, sizeof(u32) * 2);
+		if (rc)
+			goto exit;
+		*fnt_otype =3D le32_to_cpu(buf32[0]);
+		len =3D le32_to_cpu(buf32[1]);
+		if (!policydb_type_isvalid(pol, *fnt_otype)) {
+			pr_err("SELinux: avtab: invalid filename transition type\n");
+			rc =3D -EINVAL;
+			goto exit;
+		}
+
+		/* read the name */
+		rc =3D str_read(&name, GFP_KERNEL, fp, len);
+		if (rc)
+			goto exit;
+
+		/* insert to the table */
+		rc =3D symtab_insert(target, name, fnt_otype);
+		if (rc)
+			goto exit;
+		name =3D NULL;
+		fnt_otype =3D NULL;
+	}
+
+exit:
+	kfree(fnt_otype);
+	kfree(name);
+	return rc;
+}
+
+static int avtab_trans_read(void *fp, struct policydb *pol,
+			    struct avtab_trans *trans)
+{
+	int rc;
+	__le32 buf32[1];
+
+	if (pol->policyvers < POLICYDB_VERSION_AVTAB_FTRANS) {
+		rc =3D next_entry(buf32, fp, sizeof(u32));
+		if (rc) {
+			pr_err("SELinux: avtab: truncated entry\n");
+			return rc;
+		}
+		trans->otype =3D le32_to_cpu(*buf32);
+		return 0;
+	}
+
+	/* read default otype */
+	rc =3D next_entry(buf32, fp, sizeof(u32));
+	if (rc)
+		return rc;
+	trans->otype =3D le32_to_cpu(buf32[0]);
+
+	rc =3D avtab_trans_read_name_trans(pol, &trans->name_trans, fp);
+	if (rc)
+		goto bad;
+
+	return 0;
+
+bad:
+	avtab_trans_destroy(trans);
+	return rc;
+}
+
 int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 		    int (*insertf)(struct avtab *a, const struct avtab_key *k,
 				   const struct avtab_datum *d, void *p),
@@ -433,7 +522,7 @@ int avtab_read_item(struct avtab *a, void *fp, struct=
 policydb *pol,
 {
 	__le16 buf16[4];
 	u16 enabled;
-	u32 items, items2, val, vers =3D pol->policyvers;
+	u32 otype, items, items2, val, vers =3D pol->policyvers;
 	struct avtab_key key;
 	struct avtab_datum datum;
 	struct avtab_trans trans;
@@ -584,12 +673,9 @@ int avtab_read_item(struct avtab *a, void *fp, struc=
t policydb *pol,
 		datum.u.xperms =3D &xperms;
 	} else if (key.specified & AVTAB_TRANSITION) {
 		memset(&trans, 0, sizeof(struct avtab_trans));
-		rc =3D next_entry(buf32, fp, sizeof(u32));
-		if (rc) {
-			pr_err("SELinux: avtab: truncated entry\n");
+		rc =3D avtab_trans_read(fp, pol, &trans);
+		if (rc)
 			return rc;
-		}
-		trans.otype =3D le32_to_cpu(*buf32);
 		datum.u.trans =3D &trans;
 	} else {
 		rc =3D next_entry(buf32, fp, sizeof(u32));
@@ -600,11 +686,24 @@ int avtab_read_item(struct avtab *a, void *fp, stru=
ct policydb *pol,
 		datum.u.data =3D le32_to_cpu(*buf32);
 	}
 	if (key.specified & AVTAB_TRANSITION) {
-		if (!policydb_type_isvalid(pol, datum.u.trans->otype)) {
+		/* if otype is set (non-zero), it must by a valid type */
+		otype =3D datum.u.trans->otype;
+		if (otype && !policydb_type_isvalid(pol, otype)) {
 			pr_err("SELinux: avtab: invalid transition type\n");
 			avtab_trans_destroy(&trans);
 			return -EINVAL;
 		}
+		/*
+		 * also each transition entry must meet at least one condition
+		 * to be considered non-empty:
+		 *  - set (non-zero) otype
+		 *  - non-empty filename transitions table
+		 */
+		if (!otype && !datum.u.trans->name_trans.table.nel) {
+			pr_err("SELinux: avtab: empty transition\n");
+			avtab_trans_destroy(&trans);
+			return -EINVAL;
+		}
 	} else if (key.specified & AVTAB_TYPE) {
 		if (!policydb_type_isvalid(pol, datum.u.data)) {
 			pr_err("SELinux: avtab: invalid type\n");
@@ -667,6 +766,59 @@ int avtab_read(struct avtab *a, void *fp, struct pol=
icydb *pol)
 	goto out;
 }
=20
+static int avtab_trans_write_helper(void *k, void *d, void *fp)
+{
+	char *name =3D k;
+	u32 *otype =3D d;
+	int rc;
+	__le32 buf32[2];
+	u32 len;
+
+	/* write filename transition otype and name length */
+	len =3D strlen(name);
+	buf32[0] =3D cpu_to_le32(*otype);
+	buf32[1] =3D cpu_to_le32(len);
+	rc =3D put_entry(buf32, sizeof(u32), 2, fp);
+	if (rc)
+		return rc;
+
+	/* write filename transition name */
+	rc =3D put_entry(name, sizeof(char), len, fp);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static int avtab_trans_write(struct policydb *p, struct avtab_trans *cur=
,
+			     void *fp)
+{
+	int rc;
+	__le32 buf32[2];
+
+	if (p->policyvers >=3D POLICYDB_VERSION_AVTAB_FTRANS) {
+		/* write otype and number of filename transitions */
+		buf32[0] =3D cpu_to_le32(cur->otype);
+		buf32[1] =3D cpu_to_le32(cur->name_trans.table.nel);
+		rc =3D put_entry(buf32, sizeof(u32), 2, fp);
+		if (rc)
+			return rc;
+
+		/* write filename transitions */
+		rc =3D hashtab_map(&cur->name_trans.table,
+				 avtab_trans_write_helper, fp);
+		if (rc)
+			return rc;
+	} else if (cur->otype) {
+		buf32[0] =3D cpu_to_le32(cur->otype);
+		rc =3D put_entry(buf32, sizeof(u32), 1, fp);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
 int avtab_write_item(struct policydb *p, const struct avtab_node *cur, v=
oid *fp)
 {
 	__le16 buf16[4];
@@ -674,7 +826,8 @@ int avtab_write_item(struct policydb *p, const struct=
 avtab_node *cur, void *fp)
 	int rc;
 	unsigned int i;
=20
-	if (cur->key.specified & AVTAB_TRANSITION &&
+	if (p->policyvers < POLICYDB_VERSION_AVTAB_FTRANS &&
+	    cur->key.specified & AVTAB_TRANSITION &&
 	    !cur->datum.u.trans->otype)
 		return 0;
=20
@@ -698,8 +851,7 @@ int avtab_write_item(struct policydb *p, const struct=
 avtab_node *cur, void *fp)
 		rc =3D put_entry(buf32, sizeof(u32),
 				ARRAY_SIZE(cur->datum.u.xperms->perms.p), fp);
 	} else if (cur->key.specified & AVTAB_TRANSITION) {
-		buf32[0] =3D cpu_to_le32(cur->datum.u.trans->otype);
-		rc =3D put_entry(buf32, sizeof(u32), 1, fp);
+		rc =3D avtab_trans_write(p, cur->datum.u.trans, fp);
 	} else {
 		buf32[0] =3D cpu_to_le32(cur->datum.u.data);
 		rc =3D put_entry(buf32, sizeof(u32), 1, fp);
@@ -715,8 +867,23 @@ int avtab_write(struct policydb *p, struct avtab *a,=
 void *fp)
 	int rc =3D 0;
 	struct avtab_node *cur;
 	__le32 buf[1];
+	u32 nel;
=20
-	buf[0] =3D cpu_to_le32(a->nel);
+	nel =3D a->nel;
+	if (p->policyvers < POLICYDB_VERSION_AVTAB_FTRANS) {
+		/*
+		 * in older version, skip entries with only filename transition,
+		 * as these are written out separately
+		 */
+		for (i =3D 0; i < a->nslot; i++) {
+			for (cur =3D a->htable[i]; cur; cur =3D cur->next) {
+				if (cur->key.specified & AVTAB_TRANSITION &&
+				    !cur->datum.u.trans->otype)
+					nel--;
+			}
+		}
+	}
+	buf[0] =3D cpu_to_le32(nel);
 	rc =3D put_entry(buf, sizeof(u32), 1, fp);
 	if (rc)
 		return rc;
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
index 928a08835db8..96b8d5bd8e4e 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -157,6 +157,11 @@ static const struct policydb_compat_info policydb_co=
mpat[] =3D {
 		.sym_num	=3D SYM_NUM,
 		.ocon_num	=3D OCON_NUM,
 	},
+	{
+		.version	=3D POLICYDB_VERSION_AVTAB_FTRANS,
+		.sym_num	=3D SYM_NUM,
+		.ocon_num	=3D OCON_NUM,
+	},
 };
=20
 static const struct policydb_compat_info *policydb_lookup_compat(int ver=
sion)
@@ -2354,9 +2359,11 @@ int policydb_read(struct policydb *p, void *fp)
 		lra =3D ra;
 	}
=20
-	rc =3D avtab_filename_trans_read(&p->te_avtab, fp, p);
-	if (rc)
-		goto bad;
+	if (p->policyvers < POLICYDB_VERSION_AVTAB_FTRANS) {
+		rc =3D avtab_filename_trans_read(&p->te_avtab, fp, p);
+		if (rc)
+			goto bad;
+	}
=20
 	rc =3D policydb_index(p);
 	if (rc)
@@ -3310,9 +3317,11 @@ int policydb_write(struct policydb *p, void *fp)
 	if (rc)
 		return rc;
=20
-	rc =3D avtab_filename_trans_write(p, &p->te_avtab, fp);
-	if (rc)
-		return rc;
+	if (p->policyvers < POLICYDB_VERSION_AVTAB_FTRANS) {
+		rc =3D avtab_filename_trans_write(p, &p->te_avtab, fp);
+		if (rc)
+			return rc;
+	}
=20
 	rc =3D ocontext_write(p, info, fp);
 	if (rc)
--=20
2.40.0

