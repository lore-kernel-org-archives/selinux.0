Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9C7EB64D7
	for <selinux@archiver.kernel.org>; Tue, 20 Jun 2023 09:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjFTJCq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 20 Jun 2023 05:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjFTJCn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 20 Jun 2023 05:02:43 -0400
Received: from sender11-of-o52.zoho.eu (sender11-of-o52.zoho.eu [31.186.226.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD9A1727
        for <selinux@vger.kernel.org>; Tue, 20 Jun 2023 02:02:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687251749; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=dGhfzH86yMcjLgA0W+cAu3kK1/b+/UcymBuYrTOinqMN/KDJexO+b/lamTmaINJuCzfxafbTMny5xmGZnmy4mBVqshUaUvE92vMpKgSjGm1zrqhKnh+ZfRn25EhwJwbaxrvtonPxNf5/sMtocLc+dFWw81Q1LoY6J75ajT/ARMQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1687251749; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=kDLfbC2iXNX6QJ0fMhIsW5RhIaV4N2CGeC0JQd7Dkf8=; 
        b=MIuC5VWcTLVJywXsA+5+nndRWH6IXlqrq+eTdYkxtplfMChCjyDaxE+3R4Kcp5vvx7KOf7JoIdhMhRVhcdy+zvHv182RTzHnmziCCOnpw5PfeWazj3W71WzW9zTX60ULLjmL637Cpy858kkAheAZBbAW9cfeJ1CTq5fL56lbGKc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=jurajmarcin.com;
        spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
        dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1687251749;
        s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=kDLfbC2iXNX6QJ0fMhIsW5RhIaV4N2CGeC0JQd7Dkf8=;
        b=eKy3VBkxfZi/J87/GB3244vw44uObbjVjhEVXrHTb4poyhaFoABA9/T5Y/0QE0vd
        noSi6n4PHmouw/P1fe4zCq1RTxwHiUnI0/nb1T9E40xPj2xqpxQkDG1wRXqKI5yITO1
        1utnXstNoy1zZHZew8nfvr6TbJbzIMya/gyZeJyE=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
        with SMTPS id 1687251748292225.7484242147002; Tue, 20 Jun 2023 11:02:28 +0200 (CEST)
Received: from jmarcin-t14s-01.redhat.com (unknown [213.175.37.12])
        by morty01.jurajmarcin.com (Postfix) with ESMTPSA id C688C2081F76;
        Tue, 20 Jun 2023 09:02:27 +0000 (UTC)
From:   Juraj Marcin <juraj@jurajmarcin.com>
To:     selinux@vger.kernel.org
Cc:     Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v2 5/8] libsepol: implement new module binary format of avrule
Date:   Tue, 20 Jun 2023 11:01:20 +0200
Message-Id: <84f1ed9810a7b0df59238c2f97c6b3d05b29e6d6.1687251081.git.juraj@jurajmarcin.com>
In-Reply-To: <cover.1687251081.git.juraj@jurajmarcin.com>
References: <cover.1687251081.git.juraj@jurajmarcin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Implement a new module policy format that closely matches the new
internal representation of avrule introduced in the previous patch.

This patch bumps the maximum module policy version and implements
reading/writing functions such that the module binary policy structure
matches its internal representation, namely, the object name attribute
used for the filename transition rules.

These changes have no significant effect on the size of the module
policy file (tested with Fedora policy).

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
---
 libsepol/include/sepol/policydb/policydb.h |  3 ++-
 libsepol/src/policydb.c                    | 28 ++++++++++++++++++++++
 libsepol/src/write.c                       | 24 ++++++++++++++++---
 3 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/includ=
e/sepol/policydb/policydb.h
index 528c1cad..5efd0a47 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -749,9 +749,10 @@ extern int policydb_set_target_platform(policydb_t *=
p, int platform);
 #define MOD_POLICYDB_VERSION_INFINIBAND		19
 #define MOD_POLICYDB_VERSION_GLBLUB		20
 #define MOD_POLICYDB_VERSION_SELF_TYPETRANS	21
+#define MOD_POLICYDB_VERSION_AVRULE_FTRANS	22
=20
 #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
-#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_SELF_TYPETRANS
+#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_AVRULE_FTRANS
=20
 #define POLICYDB_CONFIG_MLS    1
=20
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index b15d4163..37bb97a1 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -341,6 +341,13 @@ static const struct policydb_compat_info policydb_co=
mpat[] =3D {
 	 .ocon_num =3D OCON_IBENDPORT + 1,
 	 .target_platform =3D SEPOL_TARGET_SELINUX,
 	},
+	{
+	 .type =3D POLICY_BASE,
+	 .version =3D MOD_POLICYDB_VERSION_AVRULE_FTRANS,
+	 .sym_num =3D SYM_NUM,
+	 .ocon_num =3D OCON_IBENDPORT + 1,
+	 .target_platform =3D SEPOL_TARGET_SELINUX,
+	},
 	{
 	 .type =3D POLICY_MOD,
 	 .version =3D MOD_POLICYDB_VERSION_BASE,
@@ -467,6 +474,13 @@ static const struct policydb_compat_info policydb_co=
mpat[] =3D {
 	 .ocon_num =3D 0,
 	 .target_platform =3D SEPOL_TARGET_SELINUX,
 	},
+	{
+	 .type =3D POLICY_MOD,
+	 .version =3D MOD_POLICYDB_VERSION_AVRULE_FTRANS,
+	 .sym_num =3D SYM_NUM,
+	 .ocon_num =3D 0,
+	 .target_platform =3D SEPOL_TARGET_SELINUX,
+	},
 };
=20
 #if 0
@@ -3202,6 +3216,19 @@ static avrule_t *avrule_read(policydb_t * p, struc=
t policy_file *fp)
 		tail =3D cur;
 	}
=20
+	if (p->policyvers >=3D MOD_POLICYDB_VERSION_AVRULE_FTRANS &&
+	    avrule->specified & AVRULE_TRANSITION) {
+		rc =3D next_entry(buf, fp, sizeof(uint32_t));
+		if (rc < 0)
+			goto bad;
+		len =3D le32_to_cpu(*buf);
+		if (len) {
+			rc =3D str_read(&avrule->object_name, fp, len);
+			if (rc < 0)
+				goto bad;
+		}
+	}
+
 	if (avrule->specified & AVRULE_XPERMS) {
 		uint8_t buf8;
 		size_t nel =3D ARRAY_SIZE(avrule->xperms->perms);
@@ -3633,6 +3660,7 @@ static int avrule_decl_read(policydb_t * p, avrule_=
decl_t * decl,
 	}
=20
 	if (p->policyvers >=3D MOD_POLICYDB_VERSION_FILENAME_TRANS &&
+	    p->policyvers < MOD_POLICYDB_VERSION_AVRULE_FTRANS &&
 	    filename_trans_rule_read(p, &decl->avrules, fp))
 		return -1;
=20
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 68495198..d7f47c8d 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -2025,8 +2025,9 @@ static int avrule_write(policydb_t *p, avrule_t * a=
vrule,
 	uint32_t buf[32], len;
 	class_perm_node_t *cur;
=20
-	/* skip filename transitions for now */
-	if (avrule->specified & AVRULE_TRANSITION && avrule->object_name)
+	/* skip filename transitions if writing older version without name */
+	if (p->policyvers < MOD_POLICYDB_VERSION_AVRULE_FTRANS &&
+	    avrule->specified & AVRULE_TRANSITION && avrule->object_name)
 		return POLICYDB_SUCCESS;
=20
 	if (p->policyvers < MOD_POLICYDB_VERSION_SELF_TYPETRANS &&
@@ -2073,6 +2074,21 @@ static int avrule_write(policydb_t *p, avrule_t * =
avrule,
 		cur =3D cur->next;
 	}
=20
+	if (p->policyvers >=3D MOD_POLICYDB_VERSION_AVRULE_FTRANS &&
+	    avrule->specified & AVRULE_TRANSITION) {
+		len =3D avrule->object_name ? strlen(avrule->object_name) : 0;
+		*buf =3D cpu_to_le32(len);
+		items =3D put_entry(buf, sizeof(uint32_t), 1, fp);
+		if (items !=3D 1)
+			return POLICYDB_ERROR;
+		if (avrule->object_name) {
+			items =3D put_entry(avrule->object_name, sizeof(char),
+					  len, fp);
+			if (items !=3D len)
+				return POLICYDB_ERROR;
+		}
+	}
+
 	if (avrule->specified & AVRULE_XPERMS) {
 		size_t nel =3D ARRAY_SIZE(avrule->xperms->perms);
 		uint32_t buf32[nel];
@@ -2122,7 +2138,8 @@ static int avrule_write_list(policydb_t *p, avrule_=
t * avrules,
 	avrule =3D avrules;
 	len =3D 0;
 	while (avrule) {
-		if (!(avrule->specified & AVRULE_TRANSITION &&
+		if (p->policyvers >=3D MOD_POLICYDB_VERSION_AVRULE_FTRANS ||
+		    !(avrule->specified & AVRULE_TRANSITION &&
 		      avrule->object_name))
 			len++;
 		avrule =3D avrule->next;
@@ -2357,6 +2374,7 @@ static int avrule_decl_write(avrule_decl_t * decl, =
int num_scope_syms,
 	}
=20
 	if (p->policyvers >=3D MOD_POLICYDB_VERSION_FILENAME_TRANS &&
+	    p->policyvers < MOD_POLICYDB_VERSION_AVRULE_FTRANS &&
 	    filename_trans_rule_write(p, decl->avrules, fp))
 		return POLICYDB_ERROR;
=20
--=20
2.40.0

