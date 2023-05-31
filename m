Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EBBC77B73
	for <selinux@archiver.kernel.org>; Wed, 31 May 2023 11:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjEaLcj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 May 2023 07:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjEaLch (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 May 2023 07:32:37 -0400
Received: from sender11-of-o52.zoho.eu (sender11-of-o52.zoho.eu [31.186.226.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B0F18F
        for <selinux@vger.kernel.org>; Wed, 31 May 2023 04:32:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685532740; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=jIcP8HBvh+hRGcxqttkN/RqbneRYuQo/aR0E11WWQ3FSsc4rQet9hFVDdUAV4x15FLRW6PvnfQeboSgjhOKQ6oPdtgFVArjYshTNOdl3WfdtbXAksZN5pM7gBJjqziqEwjSIQclJ0L12EGDskLQW/7Q6B037eq5DKFIj/9SRnro=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1685532740; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ItTSBFytDvSRgOXEUTTZS36SFbs/HssU43x9M9D8vzM=; 
        b=TgXYHXGRWwziDSL+R1P9ETx4r+5JFgbap5rZwT5g9ia1DSkxNOsCKW6c5tv4elzjzN19ZS0c0sksZxF6/XdJk+DzuCXXFi3vE8bv9uVzjkArzI8n/7SC7W6de1fTeQhMufIVdowEkK46JSK6SSidNRLW98qvuXjKfb9iMGNekZM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=jurajmarcin.com;
        spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
        dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1685532740;
        s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=ItTSBFytDvSRgOXEUTTZS36SFbs/HssU43x9M9D8vzM=;
        b=PZUG0fDY08P5Q0AilSHhLNaHfE+mYnmylXmityH67Uw0UnDkygEZcCbaQ2MxKA7Y
        SaHShPcJfOkRnWmlHOLg2sPnD0zYj1hN0Q062KkTUq7M5G7CrHw0w/JxkRTZ0g51XIC
        MYMAKPh4u6R8jMFgoOT8ZtCkd1WDInaz/dNgtFFw=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
        with SMTPS id 1685532739281307.85207014981677; Wed, 31 May 2023 13:32:19 +0200 (CEST)
Received: from jmarcin-t14s-01.redhat.com (unknown [147.251.183.113])
        by morty01.jurajmarcin.com (Postfix) with ESMTPSA id AAD762081F76;
        Wed, 31 May 2023 11:32:18 +0000 (UTC)
From:   Juraj Marcin <juraj@jurajmarcin.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH 1/5] selinux: move transition to separate structure in avtab_datum
Date:   Wed, 31 May 2023 13:29:24 +0200
Message-Id: <20230531112927.1957093-2-juraj@jurajmarcin.com>
In-Reply-To: <20230531112927.1957093-1-juraj@jurajmarcin.com>
References: <20230531112927.1957093-1-juraj@jurajmarcin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is a preparation to move filename transitions to be part of the
avtab data structure. To do that, we first need to create space for it
in the avtab_datum structure which holds the rule for certain
combination of stype, ttype and tclass.

As only type transitions have a special variant that uses a filename, it
would be suboptimal to add a (mostly empty) pointer to some structure to
all avtab rules.

Therefore, this patch adds a new structure to the union in avtab_datum
and moves the otype of the transition to this structure. In the next
patch, this structure will also hold filename transitions for the
combination of stype, ttype and tclass. As the union already contains a
pointer, the size of avtab_datum does not increase. The only trade-off
is that each transition requires at least 4 more bytes and structure
allocation.

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
---
 security/selinux/ss/avtab.c    | 60 ++++++++++++++++++++++++++++++----
 security/selinux/ss/avtab.h    |  7 +++-
 security/selinux/ss/services.c |  5 ++-
 3 files changed, 63 insertions(+), 9 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 6766edc0fe68..a7f348e4509d 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -24,6 +24,7 @@
 #include "policydb.h"
=20
 static struct kmem_cache *avtab_node_cachep __ro_after_init;
+static struct kmem_cache *avtab_trans_cachep __ro_after_init;
 static struct kmem_cache *avtab_xperms_cachep __ro_after_init;
=20
 /* Based on MurmurHash3, written by Austin Appleby and placed in the
@@ -71,6 +72,7 @@ avtab_insert_node(struct avtab *h, int hvalue,
 		  const struct avtab_key *key, const struct avtab_datum *datum)
 {
 	struct avtab_node *newnode;
+	struct avtab_trans *trans;
 	struct avtab_extended_perms *xperms;
 	newnode =3D kmem_cache_zalloc(avtab_node_cachep, GFP_KERNEL);
 	if (newnode =3D=3D NULL)
@@ -85,6 +87,14 @@ avtab_insert_node(struct avtab *h, int hvalue,
 		}
 		*xperms =3D *(datum->u.xperms);
 		newnode->datum.u.xperms =3D xperms;
+	} else if (key->specified & AVTAB_TRANSITION) {
+		trans =3D kmem_cache_zalloc(avtab_trans_cachep, GFP_KERNEL);
+		if (!trans) {
+			kmem_cache_free(avtab_node_cachep, newnode);
+			return NULL;
+		}
+		*trans =3D *datum->u.trans;
+		newnode->datum.u.trans =3D trans;
 	} else {
 		newnode->datum.u.data =3D datum->u.data;
 	}
@@ -289,9 +299,13 @@ void avtab_destroy(struct avtab *h)
 		while (cur) {
 			temp =3D cur;
 			cur =3D cur->next;
-			if (temp->key.specified & AVTAB_XPERMS)
+			if (temp->key.specified & AVTAB_XPERMS) {
 				kmem_cache_free(avtab_xperms_cachep,
 						temp->datum.u.xperms);
+			} else if (temp->key.specified & AVTAB_TRANSITION) {
+				kmem_cache_free(avtab_trans_cachep,
+						temp->datum.u.trans);
+			}
 			kmem_cache_free(avtab_node_cachep, temp);
 		}
 	}
@@ -407,6 +421,7 @@ int avtab_read_item(struct avtab *a, void *fp, struct=
 policydb *pol,
 	u32 items, items2, val, vers =3D pol->policyvers;
 	struct avtab_key key;
 	struct avtab_datum datum;
+	struct avtab_trans trans;
 	struct avtab_extended_perms xperms;
 	__le32 buf32[ARRAY_SIZE(xperms.perms.p)];
 	int i, rc;
@@ -473,7 +488,16 @@ int avtab_read_item(struct avtab *a, void *fp, struc=
t policydb *pol,
 		for (i =3D 0; i < ARRAY_SIZE(spec_order); i++) {
 			if (val & spec_order[i]) {
 				key.specified =3D spec_order[i] | enabled;
-				datum.u.data =3D le32_to_cpu(buf32[items++]);
+				if (key.specified & AVTAB_TRANSITION) {
+					memset(&trans, 0,
+					       sizeof(struct avtab_trans));
+					trans.otype =3D
+						le32_to_cpu(buf32[items++]);
+					datum.u.trans =3D &trans;
+				} else {
+					datum.u.data =3D
+						le32_to_cpu(buf32[items++]);
+				}
 				rc =3D insertf(a, &key, &datum, p);
 				if (rc)
 					return rc;
@@ -543,6 +567,15 @@ int avtab_read_item(struct avtab *a, void *fp, struc=
t policydb *pol,
 		for (i =3D 0; i < ARRAY_SIZE(xperms.perms.p); i++)
 			xperms.perms.p[i] =3D le32_to_cpu(buf32[i]);
 		datum.u.xperms =3D &xperms;
+	} else if (key.specified & AVTAB_TRANSITION) {
+		memset(&trans, 0, sizeof(struct avtab_trans));
+		rc =3D next_entry(buf32, fp, sizeof(u32));
+		if (rc) {
+			pr_err("SELinux: avtab: truncated entry\n");
+			return rc;
+		}
+		trans.otype =3D le32_to_cpu(*buf32);
+		datum.u.trans =3D &trans;
 	} else {
 		rc =3D next_entry(buf32, fp, sizeof(u32));
 		if (rc) {
@@ -551,12 +584,19 @@ int avtab_read_item(struct avtab *a, void *fp, stru=
ct policydb *pol,
 		}
 		datum.u.data =3D le32_to_cpu(*buf32);
 	}
-	if ((key.specified & AVTAB_TYPE) &&
-	    !policydb_type_isvalid(pol, datum.u.data)) {
-		pr_err("SELinux: avtab: invalid type\n");
-		return -EINVAL;
+	if (key.specified & AVTAB_TRANSITION) {
+		if (!policydb_type_isvalid(pol, datum.u.trans->otype)) {
+			pr_err("SELinux: avtab: invalid transition type\n");
+			return -EINVAL;
+		}
+	} else if (key.specified & AVTAB_TYPE) {
+		if (!policydb_type_isvalid(pol, datum.u.data)) {
+			pr_err("SELinux: avtab: invalid type\n");
+			return -EINVAL;
+		}
 	}
-	return insertf(a, &key, &datum, p);
+	rc =3D insertf(a, &key, &datum, p);
+	return rc;
 }
=20
 static int avtab_insertf(struct avtab *a, const struct avtab_key *k,
@@ -635,6 +675,9 @@ int avtab_write_item(struct policydb *p, const struct=
 avtab_node *cur, void *fp)
 			buf32[i] =3D cpu_to_le32(cur->datum.u.xperms->perms.p[i]);
 		rc =3D put_entry(buf32, sizeof(u32),
 				ARRAY_SIZE(cur->datum.u.xperms->perms.p), fp);
+	} else if (cur->key.specified & AVTAB_TRANSITION) {
+		buf32[0] =3D cpu_to_le32(cur->datum.u.trans->otype);
+		rc =3D put_entry(buf32, sizeof(u32), 1, fp);
 	} else {
 		buf32[0] =3D cpu_to_le32(cur->datum.u.data);
 		rc =3D put_entry(buf32, sizeof(u32), 1, fp);
@@ -673,6 +716,9 @@ void __init avtab_cache_init(void)
 	avtab_node_cachep =3D kmem_cache_create("avtab_node",
 					      sizeof(struct avtab_node),
 					      0, SLAB_PANIC, NULL);
+	avtab_trans_cachep =3D kmem_cache_create("avtab_trans",
+					       sizeof(struct avtab_trans),
+					       0, SLAB_PANIC, NULL);
 	avtab_xperms_cachep =3D kmem_cache_create("avtab_extended_perms",
 						sizeof(struct avtab_extended_perms),
 						0, SLAB_PANIC, NULL);
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index d6742fd9c560..6c8eb7c379cf 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -47,6 +47,10 @@ struct avtab_key {
 	u16 specified;	/* what field is specified */
 };
=20
+struct avtab_trans {
+	u32 otype;		/* default resulting type of the new object */
+};
+
 /*
  * For operations that require more than the 32 permissions provided by =
the avc
  * extended permissions may be used to provide 256 bits of permissions.
@@ -69,7 +73,8 @@ struct avtab_extended_perms {
=20
 struct avtab_datum {
 	union {
-		u32 data; /* access vector or type value */
+		u32 data; /* access vector, member or change value */
+		struct avtab_trans *trans;	/* transition value */
 		struct avtab_extended_perms *xperms;
 	} u;
 };
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
index 78946b71c1c1..8ed12406acba 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1830,7 +1830,10 @@ static int security_compute_sid(u32 ssid,
=20
 	if (avdatum) {
 		/* Use the type from the type transition/member/change rule. */
-		newcontext.type =3D avdatum->u.data;
+		if (avkey.specified & AVTAB_TRANSITION)
+			newcontext.type =3D avdatum->u.trans->otype;
+		else
+			newcontext.type =3D avdatum->u.data;
 	}
=20
 	/* if we have a objname this is a file trans check so check those rules=
 */
--=20
2.40.0

