Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9157BEB64D7
	for <selinux@archiver.kernel.org>; Tue, 20 Jun 2023 09:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjFTJCi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 20 Jun 2023 05:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjFTJCg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 20 Jun 2023 05:02:36 -0400
Received: from sender11-of-o52.zoho.eu (sender11-of-o52.zoho.eu [31.186.226.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BB510DC
        for <selinux@vger.kernel.org>; Tue, 20 Jun 2023 02:02:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687251746; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=iHJB4HzMPmHnjtV+U45WJtUUTyRRaxExLaAlyt0bX/puvH0sjElUGmrp2Hk6dNiIBcNZXcoSsO+/otLFIVBvOxCo3qZaxlux6RAqq/oU0KVGNR7KjlutzyFRwp9S88w23IVb1t8vwcraBBZwjCaa5MifqN9+st+PCShCday5VG4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1687251746; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=y9ZhCNVBAloE7l4glUSm2MlpKfa0I0SO+Us6kfzd+EQ=; 
        b=Ofw3dQT5PXZzAh3YQ3pOpy2B+TlJKhFwgbvZdr6d9Yo/thZG6aYYPa57BvHFBkTjZqNmUyBAU0nqrMxWctXeeUFhFPanCYXk0LgLNTw2GIH9Y9xwJ/BvD2JGCiIBKkcE4C4mhHLZJ5HbTGdIJCciOGOfTdoTbJpJydzpccDutLE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=jurajmarcin.com;
        spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
        dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1687251746;
        s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=y9ZhCNVBAloE7l4glUSm2MlpKfa0I0SO+Us6kfzd+EQ=;
        b=G9s06DySu/bucTb2u6R0ZDs50l6GslDf9o3iDZXyG5R/auUie+ybXg5fWbAa6L2K
        RDaPLyY8JJ2KnYYxztZe+U0O9nVV3Uri9MpcThuNjwqzPWCGGxBYJNZfUSEXd3ff3/a
        RXqtit7+DxJmppDXq8AkuQZwY6cQpF78qNCdljI0=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
        with SMTPS id 1687251745083555.4385759342427; Tue, 20 Jun 2023 11:02:25 +0200 (CEST)
Received: from jmarcin-t14s-01.redhat.com (unknown [213.175.37.12])
        by morty01.jurajmarcin.com (Postfix) with ESMTPSA id 7BC2F2081F76;
        Tue, 20 Jun 2023 09:02:24 +0000 (UTC)
From:   Juraj Marcin <juraj@jurajmarcin.com>
To:     selinux@vger.kernel.org
Cc:     Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v2 4/8] libsepol: implement new kernel binary format for avtab
Date:   Tue, 20 Jun 2023 11:01:19 +0200
Message-Id: <c8d835747992f8b4446beb94fbf758786143267d.1687251081.git.juraj@jurajmarcin.com>
In-Reply-To: <cover.1687251081.git.juraj@jurajmarcin.com>
References: <cover.1687251081.git.juraj@jurajmarcin.com>
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

These changes can cause the binary policy to grow in size due to
effectively undoing the benefits of the commit 8206b8cb ("libsepol:
implement POLICYDB_VERSION_COMP_FTRANS "), but this will be mitigated by
adding the prefix/suffix support as described in the previous patch.

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
---
 libsepol/include/sepol/policydb/policydb.h |  3 +-
 libsepol/src/avtab.c                       | 88 ++++++++++++++++++++--
 libsepol/src/policydb.c                    |  8 ++
 libsepol/src/write.c                       | 86 +++++++++++++++++----
 4 files changed, 164 insertions(+), 21 deletions(-)

diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/includ=
e/sepol/policydb/policydb.h
index d30f26af..528c1cad 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -722,10 +722,11 @@ extern int policydb_set_target_platform(policydb_t =
*p, int platform);
 #define POLICYDB_VERSION_INFINIBAND		31 /* Linux-specific */
 #define POLICYDB_VERSION_GLBLUB		32
 #define POLICYDB_VERSION_COMP_FTRANS	33 /* compressed filename transitio=
ns */
+#define POLICYDB_VERSION_AVTAB_FTRANS	34 /* filename transitions moved t=
o avtab */
=20
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN	POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_COMP_FTRANS
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_AVTAB_FTRANS
=20
 /* Module versions and specific changes*/
 #define MOD_POLICYDB_VERSION_BASE		4
diff --git a/libsepol/src/avtab.c b/libsepol/src/avtab.c
index eef259cf..2a9564ba 100644
--- a/libsepol/src/avtab.c
+++ b/libsepol/src/avtab.c
@@ -446,6 +446,87 @@ void avtab_hash_eval(avtab_t * h, char *tag)
 	     tag, h->nel, slots_used, h->nslot, max_chain_len);
 }
=20
+static int avtab_read_name_trans(policy_file_t *fp, symtab_t *target)
+{
+	int rc;
+	uint32_t buf32[2], nel, i, len, *otype =3D NULL;
+	char *name =3D NULL;
+
+	/* read number of name transitions */
+	rc =3D next_entry(buf32, fp, sizeof(uint32_t) * 1);
+	if (rc < 0)
+		return rc;
+	nel =3D le32_to_cpu(buf32[0]);
+
+	rc =3D symtab_init(target, nel);
+	if (rc < 0)
+		return rc;
+
+	/* read name transitions */
+	for (i =3D 0; i < nel; i++) {
+		rc =3D SEPOL_ENOMEM;
+		otype =3D malloc(sizeof(uint32_t));
+		if (!otype)
+			goto exit;
+
+		/* read name transition otype and name length */
+		rc =3D next_entry(buf32, fp, sizeof(uint32_t) * 2);
+		if (rc < 0)
+			goto exit;
+		*otype =3D le32_to_cpu(buf32[0]);
+		len =3D le32_to_cpu(buf32[1]);
+
+		/* read the name */
+		rc =3D str_read(&name, fp, len);
+		if (rc < 0)
+			goto exit;
+
+		rc =3D hashtab_insert(target->table, name, otype);
+		if (rc < 0)
+			goto exit;
+		otype =3D NULL;
+		name =3D NULL;
+	}
+
+exit:
+	free(otype);
+	free(name);
+	return rc;
+}
+
+static int avtab_trans_read(policy_file_t *fp, uint32_t vers,
+			    avtab_trans_t *trans)
+{
+	int rc;
+	uint32_t buf32[1];
+
+	if (vers < POLICYDB_VERSION_AVTAB_FTRANS) {
+		rc =3D next_entry(buf32, fp, sizeof(uint32_t));
+		if (rc < 0) {
+			ERR(fp->handle, "truncated entry");
+			return SEPOL_ERR;
+		}
+		trans->otype =3D le32_to_cpu(*buf32);
+		return SEPOL_OK;
+	}
+
+	/* read otype */
+	rc =3D next_entry(buf32, fp, sizeof(uint32_t) * 1);
+	if (rc < 0)
+		return rc;
+	trans->otype =3D le32_to_cpu(buf32[0]);
+
+	rc =3D avtab_read_name_trans(fp, &trans->name_trans);
+	if (rc < 0)
+		goto bad;
+
+	return SEPOL_OK;
+
+bad:
+	avtab_trans_destroy(trans);
+	return rc;
+}
+
 /* Ordering of datums in the original avtab format in the policy file. *=
/
 static const uint16_t spec_order[] =3D {
 	AVTAB_ALLOWED,
@@ -609,12 +690,9 @@ int avtab_read_item(struct policy_file *fp, uint32_t=
 vers, avtab_t * a,
 			xperms.perms[i] =3D le32_to_cpu(buf32[i]);
 		datum.xperms =3D &xperms;
 	} else if (key.specified & AVTAB_TRANSITION) {
-		rc =3D next_entry(buf32, fp, sizeof(uint32_t));
-		if (rc < 0) {
-			ERR(fp->handle, "truncated entry");
+		rc =3D avtab_trans_read(fp, vers, &trans);
+		if (rc < 0)
 			return -1;
-		}
-		trans.otype =3D le32_to_cpu(*buf32);
 		datum.trans =3D &trans;
 	} else {
 		rc =3D next_entry(buf32, fp, sizeof(uint32_t));
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 4913ee21..b15d4163 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -208,6 +208,13 @@ static const struct policydb_compat_info policydb_co=
mpat[] =3D {
 	 .ocon_num =3D OCON_IBENDPORT + 1,
 	 .target_platform =3D SEPOL_TARGET_SELINUX,
 	},
+	{
+	 .type =3D POLICY_KERN,
+	 .version =3D POLICYDB_VERSION_AVTAB_FTRANS,
+	 .sym_num =3D SYM_NUM,
+	 .ocon_num =3D OCON_IBENDPORT + 1,
+	 .target_platform =3D SEPOL_TARGET_SELINUX,
+	},
 	{
 	 .type =3D POLICY_BASE,
 	 .version =3D MOD_POLICYDB_VERSION_BASE,
@@ -4099,6 +4106,7 @@ int policydb_read(policydb_t * p, struct policy_fil=
e *fp, unsigned verbose)
 		if (role_allow_read(&p->role_allow, fp))
 			goto bad;
 		if (r_policyvers >=3D POLICYDB_VERSION_FILENAME_TRANS &&
+		    r_policyvers < POLICYDB_VERSION_AVTAB_FTRANS &&
 		    avtab_filename_trans_read(fp, r_policyvers, &p->te_avtab))
 			goto bad;
 	} else {
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 2035b350..68495198 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -102,6 +102,56 @@ static uint16_t spec_order[] =3D {
 	AVTAB_MEMBER
 };
=20
+static int avtab_trans_write_helper(hashtab_key_t hkey, hashtab_datum_t =
hdatum,
+				    void *fp)
+{
+	char *name =3D hkey;
+	uint32_t *otype =3D hdatum;
+	uint32_t buf32[2], len;
+	size_t items;
+
+	/* write filename transition otype and name length */
+	len =3D strlen(name);
+	buf32[0] =3D cpu_to_le32(*otype);
+	buf32[1] =3D cpu_to_le32(len);
+	items =3D put_entry(buf32, sizeof(uint32_t), 2, fp);
+	if (items !=3D 2)
+		return -1;
+
+	/* write filename transition name */
+	items =3D put_entry(name, sizeof(char), len, fp);
+	if (items !=3D len)
+		return -1;
+
+	return 0;
+}
+
+static int avtab_trans_write(policydb_t *p, const avtab_trans_t *cur,
+			     policy_file_t *fp)
+{
+	size_t items;
+	uint32_t buf32[2];
+
+	if (p->policyvers >=3D POLICYDB_VERSION_AVTAB_FTRANS) {
+		/* write otype and number of filename transitions */
+		buf32[0] =3D cpu_to_le32(cur->otype);
+		buf32[1] =3D cpu_to_le32(hashtab_nel(cur->name_trans.table));
+		items =3D put_entry(buf32, sizeof(uint32_t), 2, fp);
+		if (items !=3D 2)
+			return -1;
+
+		/* write filename transitions */
+		return hashtab_map(cur->name_trans.table,
+				   avtab_trans_write_helper, fp);
+	} else if (cur->otype) {
+		buf32[0] =3D cpu_to_le32(cur->otype);
+		items =3D put_entry(buf32, sizeof(uint32_t), 1, fp);
+		if (items !=3D 1)
+			return -1;
+	}
+	return 0;
+}
+
 static int avtab_write_item(policydb_t * p,
 			    avtab_ptr_t cur, struct policy_file *fp,
 			    unsigned merge, unsigned commit, uint32_t * nel)
@@ -116,8 +166,12 @@ static int avtab_write_item(policydb_t * p,
 				&& p->policyvers < POLICYDB_VERSION_AVTAB);
 	unsigned int i;
=20
-	/* skip entries which only contain filename transitions */
-	if (cur->key.specified & AVTAB_TRANSITION && !cur->datum.trans->otype) =
{
+	/*
+	 * skip entries which only contain filename transitions in versions
+	 * before filename transitions were moved to avtab
+	 */
+	if (p->policyvers < POLICYDB_VERSION_AVTAB_FTRANS &&
+	    cur->key.specified & AVTAB_TRANSITION && !cur->datum.trans->otype) =
{
 		/* if oldvers, reduce nel, because this node will be skipped */
 		if (oldvers && nel)
 			(*nel)--;
@@ -271,9 +325,7 @@ static int avtab_write_item(policydb_t * p,
 		if (items !=3D 8)
 			return POLICYDB_ERROR;
 	} else if (cur->key.specified & AVTAB_TRANSITION) {
-		buf32[0] =3D cpu_to_le32(cur->datum.trans->otype);
-		items =3D put_entry(buf32, sizeof(uint32_t), 1, fp);
-		if (items !=3D 1)
+		if (avtab_trans_write(p, cur->datum.trans, fp) < 0)
 			return POLICYDB_ERROR;
 	} else {
 		buf32[0] =3D cpu_to_le32(cur->datum.data);
@@ -326,15 +378,18 @@ static int avtab_write(struct policydb *p, avtab_t =
* a, struct policy_file *fp)
 		 * filename transitions.
 		 */
 		nel =3D a->nel;
-		/*
-		 * entries containing only filename transitions are skipped and
-		 * written out later
-		 */
-		for (i =3D 0; i < a->nslot; i++) {
-			for (cur =3D a->htable[i]; cur; cur =3D cur->next) {
-				if (cur->key.specified & AVTAB_TRANSITION &&
-				    !cur->datum.trans->otype)
-					nel--;
+		if (p->policyvers < POLICYDB_VERSION_AVTAB_FTRANS) {
+			/*
+			 * entries containing only filename transitions are
+			 * skipped and written out later
+			 */
+			for (i =3D 0; i < a->nslot; i++) {
+				for (cur =3D a->htable[i]; cur; cur =3D cur->next) {
+					if ((cur->key.specified
+					     & AVTAB_TRANSITION) &&
+					    !cur->datum.trans->otype)
+						nel--;
+				}
 			}
 		}
 		nel =3D cpu_to_le32(nel);
@@ -2626,7 +2681,8 @@ int policydb_write(policydb_t * p, struct policy_fi=
le *fp)
 		if (role_allow_write(p->role_allow, fp))
 			return POLICYDB_ERROR;
 		if (p->policyvers >=3D POLICYDB_VERSION_FILENAME_TRANS) {
-			if (avtab_filename_trans_write(p, &p->te_avtab, fp))
+			if (p->policyvers < POLICYDB_VERSION_AVTAB_FTRANS &&
+			    avtab_filename_trans_write(p, &p->te_avtab, fp))
 				return POLICYDB_ERROR;
 		} else if (avtab_has_filename_transitions(&p->te_avtab)) {
 			WARN(fp->handle,
--=20
2.40.0

