Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E0DC77B7C
	for <selinux@archiver.kernel.org>; Wed, 31 May 2023 11:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjEaLcq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 31 May 2023 07:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbjEaLcp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 31 May 2023 07:32:45 -0400
Received: from sender11-of-o52.zoho.eu (sender11-of-o52.zoho.eu [31.186.226.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44ACC126
        for <selinux@vger.kernel.org>; Wed, 31 May 2023 04:32:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685532748; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=IP0vryHo9PaH7PkXneMiEe7SIsTOJZEGT59ef5DDbOyHJaipEX3aObTGmw1U8QJPyx0qUn6/0PVJfMlhttFGzJLaL3156IIkATxTHp3CYB249Dt1mSj/aTLH1UyICIqo7fZv0nhEnyIGj5DU4EWfGn/lffau7LTpEprFR6EBOmo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1685532748; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=xIyLZyT2jksBJDRbhfNmmc5LCHTOBgUAKz7/tqnxopM=; 
        b=kKR3HMRqcfx95cFTbHkpQkscH9ni9oZ+ii3JH6Y/m1HYXDOvUzvdV3YUXTA1kKr6YvbDn4eE2JwnvgnBbZ895wBdQBzoxykEyjAynxl75S10ow1GTjiSr04OAwdvWwBcivmRbg7sCiRbZanRr3eXZ81H8j3nqLAxQO6+fKhzHAo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=jurajmarcin.com;
        spf=pass  smtp.mailfrom=juraj@jurajmarcin.com;
        dmarc=pass header.from=<juraj@jurajmarcin.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1685532748;
        s=zoho; d=jurajmarcin.com; i=juraj@jurajmarcin.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=xIyLZyT2jksBJDRbhfNmmc5LCHTOBgUAKz7/tqnxopM=;
        b=efL1ls0MTcl6/fnmgN2K4yoxbjyxj0r98qbhGMLhZ2MVDsU2y7+aEh7mucaTSOcF
        3rDg7gvSJ8E+HYDdEv8BNucWi9Si2xnZP+7KppK9GEuPsXNbpUhGcKswZK9lwQOn23U
        +jWYe2G3en4vvpWe/9rLcobt1wgWPqs919JHAC9A=
Received: from morty01.jurajmarcin.com (129.159.244.31 [129.159.244.31]) by mx.zoho.eu
        with SMTPS id 1685532747100817.8019150565543; Wed, 31 May 2023 13:32:27 +0200 (CEST)
Received: from jmarcin-t14s-01.redhat.com (unknown [147.251.183.113])
        by morty01.jurajmarcin.com (Postfix) with ESMTPSA id 6D9482081F76;
        Wed, 31 May 2023 11:32:26 +0000 (UTC)
From:   Juraj Marcin <juraj@jurajmarcin.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH 2/5] selinux: move filename transitions to avtab
Date:   Wed, 31 May 2023 13:29:25 +0200
Message-Id: <20230531112927.1957093-3-juraj@jurajmarcin.com>
In-Reply-To: <20230531112927.1957093-1-juraj@jurajmarcin.com>
References: <20230531112927.1957093-1-juraj@jurajmarcin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Currently, filename transitions are stored separately from other type
enforcement rules. This leads to possibly sub-optimal performance and
makes further improvements cumbersome.

This patch adds a symbol table of filename transitions to the transition
structure added to avtab in the previous patch. It also implements
functions required for reading and writing filename transitions in
kernel policy format and updates computation of new type to use filename
transitions embedded in avtab. Last but not least, it updates the
conflict check in the conditional avtab to account for empty transitions
in the non-conditional avtab.

These changes are expected to cause higher memory usage, as now there
needs to be a filename transition structure for every stype. This patch
effectively undoes most of the commit c3a276111ea2 ("selinux: optimize
storage of filename transitions"), but this will be mitigated by
providing support for matching prefix/suffix of the filename for
filename transitions in future patches which will reduce to need to have
so many of them.

On the other hand, the changes do not significantly slow down the
creation of new files.

Kernel     | Mem   | Create test_tty | Create test_tty | osbench [1]
           | usage | (real time)     | (kernel time)   | create_files
-----------+-------+-----------------+-----------------+--------------
reference  | 155MB |  1.3440 ms/file |  1.0071 ms/file | 10.6507 us/file
this patch | 198MB |  1.3912 ms/file |  1.0172 ms/file | 10.5567 us/file

Create test_tty benchmark:

    mknod /dev/test_tty c 4 1
    time for i in `seq 1 10000`; do
        mknod /dev/test_tty$i c 4 1
    done

This benchmark should simulate the worst case scenario as many filename
transitions affect files created in the /dev directory.

[1] https://github.com/mbitsnbites/osbench

Reviewed-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>
---
 security/selinux/ss/avtab.c       | 516 ++++++++++++++++++++++++++++++
 security/selinux/ss/avtab.h       |   7 +
 security/selinux/ss/conditional.c |   6 +-
 security/selinux/ss/hashtab.h     |   6 +
 security/selinux/ss/policydb.c    | 399 +----------------------
 security/selinux/ss/policydb.h    |  25 +-
 security/selinux/ss/services.c    |  54 +---
 7 files changed, 555 insertions(+), 458 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index a7f348e4509d..fe921e1586e5 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -22,6 +22,7 @@
 #include <linux/errno.h>
 #include "avtab.h"
 #include "policydb.h"
+#include "hashtab.h"
=20
 static struct kmem_cache *avtab_node_cachep __ro_after_init;
 static struct kmem_cache *avtab_trans_cachep __ro_after_init;
@@ -286,6 +287,19 @@ avtab_search_node_next(struct avtab_node *node, int =
specified)
 	return NULL;
 }
=20
+static int avtab_trans_destroy_helper(void *k, void *d, void *args)
+{
+	kfree(k);
+	kfree(d);
+	return 0;
+}
+
+static void avtab_trans_destroy(struct avtab_trans *trans)
+{
+	hashtab_map(&trans->name_trans.table, avtab_trans_destroy_helper, NULL)=
;
+	hashtab_destroy(&trans->name_trans.table);
+}
+
 void avtab_destroy(struct avtab *h)
 {
 	int i;
@@ -303,6 +317,7 @@ void avtab_destroy(struct avtab *h)
 				kmem_cache_free(avtab_xperms_cachep,
 						temp->datum.u.xperms);
 			} else if (temp->key.specified & AVTAB_TRANSITION) {
+				avtab_trans_destroy(temp->datum.u.trans);
 				kmem_cache_free(avtab_trans_cachep,
 						temp->datum.u.trans);
 			}
@@ -587,6 +602,7 @@ int avtab_read_item(struct avtab *a, void *fp, struct=
 policydb *pol,
 	if (key.specified & AVTAB_TRANSITION) {
 		if (!policydb_type_isvalid(pol, datum.u.trans->otype)) {
 			pr_err("SELinux: avtab: invalid transition type\n");
+			avtab_trans_destroy(&trans);
 			return -EINVAL;
 		}
 	} else if (key.specified & AVTAB_TYPE) {
@@ -596,6 +612,8 @@ int avtab_read_item(struct avtab *a, void *fp, struct=
 policydb *pol,
 		}
 	}
 	rc =3D insertf(a, &key, &datum, p);
+	if (rc && key.specified & AVTAB_TRANSITION)
+		avtab_trans_destroy(&trans);
 	return rc;
 }
=20
@@ -656,6 +674,10 @@ int avtab_write_item(struct policydb *p, const struc=
t avtab_node *cur, void *fp)
 	int rc;
 	unsigned int i;
=20
+	if (cur->key.specified & AVTAB_TRANSITION &&
+	    !cur->datum.u.trans->otype)
+		return 0;
+
 	buf16[0] =3D cpu_to_le16(cur->key.source_type);
 	buf16[1] =3D cpu_to_le16(cur->key.target_type);
 	buf16[2] =3D cpu_to_le16(cur->key.target_class);
@@ -723,3 +745,497 @@ void __init avtab_cache_init(void)
 						sizeof(struct avtab_extended_perms),
 						0, SLAB_PANIC, NULL);
 }
+
+/* policydb filename transitions compatibility */
+
+static int avtab_insert_filename_trans(struct avtab *a,
+				       const struct avtab_key *key,
+				       char *name, u32 otype)
+{
+	int rc;
+	struct avtab_node *node;
+	struct avtab_trans new_trans =3D {0};
+	struct avtab_datum new_datum =3D {.u.trans =3D &new_trans};
+	struct avtab_datum *datum;
+	u32 *otype_datum =3D NULL;
+
+	datum =3D avtab_search(a, key);
+	if (!datum) {
+		/*
+		 * insert is acctually unique, but with this function we can get
+		 * the inserted node and therefore the datum
+		 */
+		node =3D avtab_insert_nonunique(a, key, &new_datum);
+		if (!node)
+			return -ENOMEM;
+		datum =3D &node->datum;
+	}
+
+	if (hashtab_is_empty(&datum->u.trans->name_trans.table)) {
+		rc =3D symtab_init(&datum->u.trans->name_trans, 1 << 8);
+		if (rc)
+			return rc;
+	}
+
+	otype_datum =3D kmalloc(sizeof(u32), GFP_KERNEL);
+	if (!otype_datum)
+		return -ENOMEM;
+	*otype_datum =3D otype;
+
+	rc =3D symtab_insert(&datum->u.trans->name_trans, name, otype_datum);
+	if (rc)
+		kfree(otype_datum);
+
+	return rc;
+}
+
+static int filename_trans_read_item(struct avtab *a, void *fp)
+{
+	int rc;
+	__le32 buf32[4];
+	u32 len, otype;
+	char *name =3D NULL;
+	struct avtab_key key;
+
+	/* read length of the name */
+	rc =3D next_entry(buf32, fp, sizeof(u32));
+	if (rc)
+		return rc;
+	len =3D le32_to_cpu(buf32[0]);
+
+	/* read the name */
+	rc =3D str_read(&name, GFP_KERNEL, fp, len);
+	if (rc)
+		return rc;
+
+	/* read stype, ttype, tclass and otype */
+	rc =3D next_entry(buf32, fp, sizeof(u32) * 4);
+	if (rc)
+		goto bad;
+
+	key.source_type =3D le32_to_cpu(buf32[0]);
+	key.target_type =3D le32_to_cpu(buf32[1]);
+	key.target_class =3D le32_to_cpu(buf32[2]);
+	key.specified =3D AVTAB_TRANSITION;
+
+	otype =3D le32_to_cpu(buf32[3]);
+
+	rc =3D avtab_insert_filename_trans(a, &key, name, otype);
+	if (rc)
+		goto bad;
+
+	return rc;
+
+bad:
+	kfree(name);
+	return rc;
+}
+
+static int filename_trans_comp_read_item(struct avtab *a, void *fp)
+{
+	int rc;
+	__le32 buf32[3];
+	u32 len, ndatum, i, bit, otype;
+	char *name =3D NULL, *name_copy =3D NULL;
+	struct avtab_key key;
+	struct ebitmap stypes;
+	struct ebitmap_node *node;
+
+	/* read length of the name */
+	rc =3D next_entry(buf32, fp, sizeof(u32));
+	if (rc)
+		return rc;
+	len =3D le32_to_cpu(*buf32);
+
+	/* read the name */
+	rc =3D str_read(&name, GFP_KERNEL, fp, len);
+	if (rc)
+		goto out;
+
+	/* read target type, target class and number of elements for key */
+	rc =3D next_entry(buf32, fp, sizeof(u32) * 3);
+	if (rc)
+		goto out;
+
+	key.specified =3D AVTAB_TRANSITION;
+	key.target_type =3D le32_to_cpu(buf32[0]);
+	key.target_class =3D le32_to_cpu(buf32[1]);
+
+	ndatum =3D le32_to_cpu(buf32[2]);
+	if (ndatum =3D=3D 0) {
+		pr_err("SELinux:  Filename transition key with no datum\n");
+		rc =3D -ENOENT;
+		goto out;
+	}
+
+	for (i =3D 0; i < ndatum; i++) {
+		rc =3D ebitmap_read(&stypes, fp);
+		if (rc)
+			goto out;
+
+		rc =3D next_entry(buf32, fp, sizeof(u32));
+		if (rc) {
+			ebitmap_destroy(&stypes);
+			goto out;
+		}
+		otype =3D le32_to_cpu(*buf32);
+
+		ebitmap_for_each_positive_bit(&stypes, node, bit) {
+			key.source_type =3D bit + 1;
+
+			name_copy =3D kmemdup(name, len + 1, GFP_KERNEL);
+			if (!name_copy) {
+				ebitmap_destroy(&stypes);
+				goto out;
+			}
+
+			rc =3D avtab_insert_filename_trans(a, &key, name_copy,
+							 otype);
+			if (rc) {
+				ebitmap_destroy(&stypes);
+				kfree(name_copy);
+				goto out;
+			}
+		}
+
+		ebitmap_destroy(&stypes);
+	}
+	rc =3D 0;
+
+out:
+	kfree(name);
+	return rc;
+}
+
+int avtab_filename_trans_read(struct avtab *a, void *fp, struct policydb=
 *p)
+{
+	int rc;
+	__le32 buf[1];
+	u32 nel, i;
+
+	if (p->policyvers < POLICYDB_VERSION_FILENAME_TRANS)
+		return 0;
+
+	rc =3D next_entry(buf, fp, sizeof(u32));
+	if (rc)
+		return rc;
+	nel =3D le32_to_cpu(buf[0]);
+
+	if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
+		for (i =3D 0; i < nel; i++) {
+			rc =3D filename_trans_read_item(a, fp);
+			if (rc)
+				return rc;
+		}
+	} else {
+		for (i =3D 0; i < nel; i++) {
+			rc =3D filename_trans_comp_read_item(a, fp);
+			if (rc)
+				return rc;
+		}
+	}
+
+	return 0;
+}
+
+
+struct filenametr_write_args {
+	void *fp;
+	struct avtab_key *key;
+};
+
+static int filenametr_write_helper(void *k, void *d, void *a)
+{
+	char *name =3D k;
+	u32 *otype =3D d;
+	struct filenametr_write_args *args =3D a;
+	int rc;
+	u32 len;
+	__le32 buf32[4];
+
+	len =3D strlen(name);
+	buf32[0] =3D cpu_to_le32(len);
+	rc =3D put_entry(buf32, sizeof(u32), 1, args->fp);
+	if (rc)
+		return rc;
+
+	rc =3D put_entry(name, sizeof(char), len, args->fp);
+	if (rc)
+		return rc;
+
+	buf32[0] =3D cpu_to_le32(args->key->source_type);
+	buf32[1] =3D cpu_to_le32(args->key->target_type);
+	buf32[2] =3D cpu_to_le32(args->key->target_class);
+	buf32[3] =3D cpu_to_le32(*otype);
+
+	rc =3D put_entry(buf32, sizeof(u32), 4, args->fp);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+struct filenametr_key {
+	u32 ttype;		/* parent dir context */
+	u16 tclass;		/* class of new object */
+	const char *name;	/* last path component */
+};
+
+struct filenametr_datum {
+	struct ebitmap stypes;	/* bitmap of source types for this otype */
+	u32 otype;		/* resulting type of new object */
+	struct filenametr_datum *next;	/* record for next otype*/
+};
+
+static int filenametr_comp_write_helper(void *k, void *d, void *fp)
+{
+	struct filenametr_key *key =3D k;
+	struct filenametr_datum *datum =3D d;
+	__le32 buf[3];
+	int rc;
+	u32 ndatum, len =3D strlen(key->name);
+	struct filenametr_datum *cur;
+
+	buf[0] =3D cpu_to_le32(len);
+	rc =3D put_entry(buf, sizeof(u32), 1, fp);
+	if (rc)
+		return rc;
+
+	rc =3D put_entry(key->name, sizeof(char), len, fp);
+	if (rc)
+		return rc;
+
+	ndatum =3D 0;
+	cur =3D datum;
+	do {
+		ndatum++;
+		cur =3D cur->next;
+	} while (unlikely(cur));
+
+	buf[0] =3D cpu_to_le32(key->ttype);
+	buf[1] =3D cpu_to_le32(key->tclass);
+	buf[2] =3D cpu_to_le32(ndatum);
+	rc =3D put_entry(buf, sizeof(u32), 3, fp);
+	if (rc)
+		return rc;
+
+	cur =3D datum;
+	do {
+		rc =3D ebitmap_write(&cur->stypes, fp);
+		if (rc)
+			return rc;
+
+		buf[0] =3D cpu_to_le32(cur->otype);
+		rc =3D put_entry(buf, sizeof(u32), 1, fp);
+		if (rc)
+			return rc;
+
+		cur =3D cur->next;
+	} while (unlikely(cur));
+
+	return 0;
+}
+
+static int filenametr_destroy(void *k, void *d, void *args)
+{
+	struct filenametr_key *key =3D k;
+	struct filenametr_datum *datum =3D d;
+	struct filenametr_datum *next;
+
+	kfree(key);
+	do {
+		ebitmap_destroy(&datum->stypes);
+		next =3D datum->next;
+		kfree(datum);
+		datum =3D next;
+	} while (unlikely(datum));
+	cond_resched();
+	return 0;
+}
+
+static u32 filenametr_hash(const void *k)
+{
+	const struct filenametr_key *ft =3D k;
+	unsigned long hash;
+	unsigned int byte_num;
+	unsigned char focus;
+
+	hash =3D ft->ttype ^ ft->tclass;
+
+	byte_num =3D 0;
+	while ((focus =3D ft->name[byte_num++]))
+		hash =3D partial_name_hash(focus, hash);
+	return hash;
+}
+
+static int filenametr_cmp(const void *k1, const void *k2)
+{
+	const struct filenametr_key *ft1 =3D k1;
+	const struct filenametr_key *ft2 =3D k2;
+	int v;
+
+	v =3D ft1->ttype - ft2->ttype;
+	if (v)
+		return v;
+
+	v =3D ft1->tclass - ft2->tclass;
+	if (v)
+		return v;
+
+	return strcmp(ft1->name, ft2->name);
+}
+
+static const struct hashtab_key_params filenametr_key_params =3D {
+	.hash =3D filenametr_hash,
+	.cmp =3D filenametr_cmp,
+};
+
+struct filenametr_tab_insert_args {
+	struct avtab_key *key;
+	struct hashtab *tab;
+};
+
+static int filenametr_tab_insert(void *k, void *d, void *a)
+{
+	char *name =3D k;
+	u32 *otype =3D d;
+	struct filenametr_tab_insert_args *args	=3D a;
+	struct filenametr_key key, *ft =3D NULL;
+	struct filenametr_datum *last, *datum =3D NULL;
+	int rc;
+
+	key.ttype =3D args->key->target_type;
+	key.tclass =3D args->key->target_class;
+	key.name =3D name;
+
+	last =3D NULL;
+	datum =3D hashtab_search(args->tab, &key, filenametr_key_params);
+	while (datum) {
+		if (unlikely(ebitmap_get_bit(&datum->stypes,
+					     args->key->source_type - 1))) {
+			/* conflicting/duplicate rules are ignored */
+			datum =3D NULL;
+			goto bad;
+		}
+		if (likely(datum->otype =3D=3D *otype))
+			break;
+		last =3D datum;
+		datum =3D datum->next;
+	}
+	if (!datum) {
+		rc =3D -ENOMEM;
+		datum =3D kmalloc(sizeof(*datum), GFP_KERNEL);
+		if (!datum)
+			goto bad;
+
+		ebitmap_init(&datum->stypes);
+		datum->otype =3D *otype;
+		datum->next =3D NULL;
+
+		if (unlikely(last)) {
+			last->next =3D datum;
+		} else {
+			rc =3D -ENOMEM;
+			ft =3D kmemdup(&key, sizeof(key), GFP_KERNEL);
+			if (!ft)
+				goto bad;
+
+			ft->name =3D kmemdup(key.name, strlen(key.name) + 1,
+					   GFP_KERNEL);
+			if (!ft->name)
+				goto bad;
+
+			rc =3D hashtab_insert(args->tab, ft, datum,
+					    filenametr_key_params);
+			if (rc)
+				goto bad;
+		}
+	}
+
+	return ebitmap_set_bit(&datum->stypes, args->key->source_type - 1, 1);
+
+bad:
+	if (ft)
+		kfree(ft->name);
+	kfree(ft);
+	kfree(datum);
+	return rc;
+}
+
+int avtab_filename_trans_write(struct policydb *p, struct avtab *a, void=
 *fp)
+{
+	int rc;
+	__le32 buf32[1];
+	u32 i, nel =3D 0;
+	struct avtab_node *cur;
+	struct hashtab fnts_tab;
+	struct filenametr_tab_insert_args tab_insert_args =3D {.tab =3D &fnts_t=
ab};
+	struct filenametr_write_args write_args =3D {.fp =3D fp};
+
+	if (p->policyvers < POLICYDB_VERSION_FILENAME_TRANS)
+		return 0;
+
+	/* count number of filename transitions */
+	for (i =3D 0; i < a->nslot; i++) {
+		for (cur =3D a->htable[i]; cur; cur =3D cur->next) {
+			if (cur->key.specified & AVTAB_TRANSITION)
+				nel +=3D cur->datum.u.trans->name_trans.table.nel;
+		}
+	}
+
+	if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
+		buf32[0] =3D cpu_to_le32(nel);
+		rc =3D put_entry(buf32, sizeof(u32), 1, fp);
+		if (rc)
+			return rc;
+
+		/* write filename transitions */
+		for (i =3D 0; i < a->nslot; i++) {
+			for (cur =3D a->htable[i]; cur; cur =3D cur->next) {
+				if (cur->key.specified & AVTAB_TRANSITION) {
+					write_args.key =3D &cur->key;
+					rc =3D hashtab_map(&cur->datum.u.trans->name_trans.table,
+							 filenametr_write_helper,
+							 &write_args);
+					if (rc)
+						return rc;
+				}
+			}
+		}
+
+		return 0;
+	}
+
+	/* init temp filename transition table */
+	rc =3D hashtab_init(&fnts_tab, nel);
+	if (rc)
+		return rc;
+
+	for (i =3D 0; i < a->nslot; i++) {
+		for (cur =3D a->htable[i]; cur; cur =3D cur->next) {
+			if (cur->key.specified & AVTAB_TRANSITION) {
+				tab_insert_args.key =3D &cur->key;
+				rc =3D hashtab_map(&cur->datum.u.trans->name_trans.table,
+						 filenametr_tab_insert,
+						 &tab_insert_args);
+				if (rc)
+					goto out;
+			}
+		}
+	}
+
+	/* write compressed filename transitions */
+	buf32[0] =3D cpu_to_le32(fnts_tab.nel);
+	rc =3D put_entry(buf32, sizeof(u32), 1, fp);
+	if (rc)
+		goto out;
+
+	rc =3D hashtab_map(&fnts_tab, filenametr_comp_write_helper, fp);
+
+out:
+	/* destroy temp filename transitions table */
+	hashtab_map(&fnts_tab, filenametr_destroy, NULL);
+	hashtab_destroy(&fnts_tab);
+
+	return rc;
+}
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index 6c8eb7c379cf..162ef1be85e7 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -22,6 +22,7 @@
 #define _SS_AVTAB_H_
=20
 #include "security.h"
+#include "symtab.h"
=20
 struct avtab_key {
 	u16 source_type;	/* source type */
@@ -49,6 +50,7 @@ struct avtab_key {
=20
 struct avtab_trans {
 	u32 otype;		/* default resulting type of the new object */
+	struct symtab name_trans;	/* filename transitions */
 };
=20
 /*
@@ -121,5 +123,10 @@ struct avtab_node *avtab_search_node_next(struct avt=
ab_node *node, int specified
 #define MAX_AVTAB_HASH_BITS 16
 #define MAX_AVTAB_HASH_BUCKETS (1 << MAX_AVTAB_HASH_BITS)
=20
+/* policydb filename transitions compatibility */
+
+int avtab_filename_trans_read(struct avtab *a, void *fp, struct policydb=
 *p);
+int avtab_filename_trans_write(struct policydb *p, struct avtab *a, void=
 *fp);
+
 #endif	/* _SS_AVTAB_H_ */
=20
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/cond=
itional.c
index e11219fdf9f7..91392d65563e 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -263,6 +263,7 @@ static int cond_insertf(struct avtab *a, const struct=
 avtab_key *k,
 	struct policydb *p =3D data->p;
 	struct cond_av_list *other =3D data->other;
 	struct avtab_node *node_ptr;
+	struct avtab_datum *existing;
 	u32 i;
 	bool found;
=20
@@ -272,7 +273,10 @@ static int cond_insertf(struct avtab *a, const struc=
t avtab_key *k,
 	 * cond_te_avtab.
 	 */
 	if (k->specified & AVTAB_TYPE) {
-		if (avtab_search(&p->te_avtab, k)) {
+		existing =3D avtab_search(&p->te_avtab, k);
+		/* empty transition rule is not a conflict */
+		if (existing && !(k->specified & AVTAB_TRANSITION &&
+				  !existing->u.trans->otype)) {
 			pr_err("SELinux: type rule already exists outside of a conditional.\n=
");
 			return -EINVAL;
 		}
diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.=
h
index 043a773bf0b7..4d04acf4d5af 100644
--- a/security/selinux/ss/hashtab.h
+++ b/security/selinux/ss/hashtab.h
@@ -145,4 +145,10 @@ int hashtab_duplicate(struct hashtab *new, struct ha=
shtab *orig,
 /* Fill info with some hash table statistics */
 void hashtab_stat(struct hashtab *h, struct hashtab_info *info);
=20
+/* Checks if the hashtab is empty (its size is zero) */
+static inline int hashtab_is_empty(struct hashtab *h)
+{
+	return !h->size;
+}
+
 #endif	/* _SS_HASHTAB_H */
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policyd=
b.c
index 97c0074f9312..928a08835db8 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -323,23 +323,6 @@ static int (*const destroy_f[SYM_NUM]) (void *key, v=
oid *datum, void *datap) =3D {
 	cat_destroy,
 };
=20
-static int filenametr_destroy(void *key, void *datum, void *p)
-{
-	struct filename_trans_key *ft =3D key;
-	struct filename_trans_datum *next, *d =3D datum;
-
-	kfree(ft->name);
-	kfree(key);
-	do {
-		ebitmap_destroy(&d->stypes);
-		next =3D d->next;
-		kfree(d);
-		d =3D next;
-	} while (unlikely(d));
-	cond_resched();
-	return 0;
-}
-
 static int range_tr_destroy(void *key, void *datum, void *p)
 {
 	struct mls_range *rt =3D datum;
@@ -406,50 +389,6 @@ static int roles_init(struct policydb *p)
 	return rc;
 }
=20
-static u32 filenametr_hash(const void *k)
-{
-	const struct filename_trans_key *ft =3D k;
-	unsigned long hash;
-	unsigned int byte_num;
-	unsigned char focus;
-
-	hash =3D ft->ttype ^ ft->tclass;
-
-	byte_num =3D 0;
-	while ((focus =3D ft->name[byte_num++]))
-		hash =3D partial_name_hash(focus, hash);
-	return hash;
-}
-
-static int filenametr_cmp(const void *k1, const void *k2)
-{
-	const struct filename_trans_key *ft1 =3D k1;
-	const struct filename_trans_key *ft2 =3D k2;
-	int v;
-
-	v =3D ft1->ttype - ft2->ttype;
-	if (v)
-		return v;
-
-	v =3D ft1->tclass - ft2->tclass;
-	if (v)
-		return v;
-
-	return strcmp(ft1->name, ft2->name);
-
-}
-
-static const struct hashtab_key_params filenametr_key_params =3D {
-	.hash =3D filenametr_hash,
-	.cmp =3D filenametr_cmp,
-};
-
-struct filename_trans_datum *policydb_filenametr_search(
-	struct policydb *p, struct filename_trans_key *key)
-{
-	return hashtab_search(&p->filename_trans, key, filenametr_key_params);
-}
-
 static u32 rangetr_hash(const void *k)
 {
 	const struct range_trans *key =3D k;
@@ -531,7 +470,6 @@ static void policydb_init(struct policydb *p)
 	avtab_init(&p->te_avtab);
 	cond_policydb_init(p);
=20
-	ebitmap_init(&p->filename_trans_ttypes);
 	ebitmap_init(&p->policycaps);
 	ebitmap_init(&p->permissive_map);
 }
@@ -839,9 +777,6 @@ void policydb_destroy(struct policydb *p)
 	}
 	kfree(lra);
=20
-	hashtab_map(&p->filename_trans, filenametr_destroy, NULL);
-	hashtab_destroy(&p->filename_trans);
-
 	hashtab_map(&p->range_tr, range_tr_destroy, NULL);
 	hashtab_destroy(&p->range_tr);
=20
@@ -851,7 +786,6 @@ void policydb_destroy(struct policydb *p)
 		kvfree(p->type_attr_map_array);
 	}
=20
-	ebitmap_destroy(&p->filename_trans_ttypes);
 	ebitmap_destroy(&p->policycaps);
 	ebitmap_destroy(&p->permissive_map);
 }
@@ -1066,7 +1000,7 @@ static int context_read_and_validate(struct context=
 *c,
  * binary representation file.
  */
=20
-static int str_read(char **strp, gfp_t flags, void *fp, u32 len)
+int str_read(char **strp, gfp_t flags, void *fp, u32 len)
 {
 	int rc;
 	char *str;
@@ -1880,220 +1814,6 @@ static int range_read(struct policydb *p, void *f=
p)
 	return rc;
 }
=20
-static int filename_trans_read_helper_compat(struct policydb *p, void *f=
p)
-{
-	struct filename_trans_key key, *ft =3D NULL;
-	struct filename_trans_datum *last, *datum =3D NULL;
-	char *name =3D NULL;
-	u32 len, stype, otype;
-	__le32 buf[4];
-	int rc;
-
-	/* length of the path component string */
-	rc =3D next_entry(buf, fp, sizeof(u32));
-	if (rc)
-		return rc;
-	len =3D le32_to_cpu(buf[0]);
-
-	/* path component string */
-	rc =3D str_read(&name, GFP_KERNEL, fp, len);
-	if (rc)
-		return rc;
-
-	rc =3D next_entry(buf, fp, sizeof(u32) * 4);
-	if (rc)
-		goto out;
-
-	stype =3D le32_to_cpu(buf[0]);
-	key.ttype =3D le32_to_cpu(buf[1]);
-	key.tclass =3D le32_to_cpu(buf[2]);
-	key.name =3D name;
-
-	otype =3D le32_to_cpu(buf[3]);
-
-	last =3D NULL;
-	datum =3D policydb_filenametr_search(p, &key);
-	while (datum) {
-		if (unlikely(ebitmap_get_bit(&datum->stypes, stype - 1))) {
-			/* conflicting/duplicate rules are ignored */
-			datum =3D NULL;
-			goto out;
-		}
-		if (likely(datum->otype =3D=3D otype))
-			break;
-		last =3D datum;
-		datum =3D datum->next;
-	}
-	if (!datum) {
-		rc =3D -ENOMEM;
-		datum =3D kmalloc(sizeof(*datum), GFP_KERNEL);
-		if (!datum)
-			goto out;
-
-		ebitmap_init(&datum->stypes);
-		datum->otype =3D otype;
-		datum->next =3D NULL;
-
-		if (unlikely(last)) {
-			last->next =3D datum;
-		} else {
-			rc =3D -ENOMEM;
-			ft =3D kmemdup(&key, sizeof(key), GFP_KERNEL);
-			if (!ft)
-				goto out;
-
-			rc =3D hashtab_insert(&p->filename_trans, ft, datum,
-					    filenametr_key_params);
-			if (rc)
-				goto out;
-			name =3D NULL;
-
-			rc =3D ebitmap_set_bit(&p->filename_trans_ttypes,
-					     key.ttype, 1);
-			if (rc)
-				return rc;
-		}
-	}
-	kfree(name);
-	return ebitmap_set_bit(&datum->stypes, stype - 1, 1);
-
-out:
-	kfree(ft);
-	kfree(name);
-	kfree(datum);
-	return rc;
-}
-
-static int filename_trans_read_helper(struct policydb *p, void *fp)
-{
-	struct filename_trans_key *ft =3D NULL;
-	struct filename_trans_datum **dst, *datum, *first =3D NULL;
-	char *name =3D NULL;
-	u32 len, ttype, tclass, ndatum, i;
-	__le32 buf[3];
-	int rc;
-
-	/* length of the path component string */
-	rc =3D next_entry(buf, fp, sizeof(u32));
-	if (rc)
-		return rc;
-	len =3D le32_to_cpu(buf[0]);
-
-	/* path component string */
-	rc =3D str_read(&name, GFP_KERNEL, fp, len);
-	if (rc)
-		return rc;
-
-	rc =3D next_entry(buf, fp, sizeof(u32) * 3);
-	if (rc)
-		goto out;
-
-	ttype =3D le32_to_cpu(buf[0]);
-	tclass =3D le32_to_cpu(buf[1]);
-
-	ndatum =3D le32_to_cpu(buf[2]);
-	if (ndatum =3D=3D 0) {
-		pr_err("SELinux:  Filename transition key with no datum\n");
-		rc =3D -ENOENT;
-		goto out;
-	}
-
-	dst =3D &first;
-	for (i =3D 0; i < ndatum; i++) {
-		rc =3D -ENOMEM;
-		datum =3D kmalloc(sizeof(*datum), GFP_KERNEL);
-		if (!datum)
-			goto out;
-
-		*dst =3D datum;
-
-		/* ebitmap_read() will at least init the bitmap */
-		rc =3D ebitmap_read(&datum->stypes, fp);
-		if (rc)
-			goto out;
-
-		rc =3D next_entry(buf, fp, sizeof(u32));
-		if (rc)
-			goto out;
-
-		datum->otype =3D le32_to_cpu(buf[0]);
-		datum->next =3D NULL;
-
-		dst =3D &datum->next;
-	}
-
-	rc =3D -ENOMEM;
-	ft =3D kmalloc(sizeof(*ft), GFP_KERNEL);
-	if (!ft)
-		goto out;
-
-	ft->ttype =3D ttype;
-	ft->tclass =3D tclass;
-	ft->name =3D name;
-
-	rc =3D hashtab_insert(&p->filename_trans, ft, first,
-			    filenametr_key_params);
-	if (rc =3D=3D -EEXIST)
-		pr_err("SELinux:  Duplicate filename transition key\n");
-	if (rc)
-		goto out;
-
-	return ebitmap_set_bit(&p->filename_trans_ttypes, ttype, 1);
-
-out:
-	kfree(ft);
-	kfree(name);
-	while (first) {
-		datum =3D first;
-		first =3D first->next;
-
-		ebitmap_destroy(&datum->stypes);
-		kfree(datum);
-	}
-	return rc;
-}
-
-static int filename_trans_read(struct policydb *p, void *fp)
-{
-	u32 nel;
-	__le32 buf[1];
-	int rc, i;
-
-	if (p->policyvers < POLICYDB_VERSION_FILENAME_TRANS)
-		return 0;
-
-	rc =3D next_entry(buf, fp, sizeof(u32));
-	if (rc)
-		return rc;
-	nel =3D le32_to_cpu(buf[0]);
-
-	if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
-		p->compat_filename_trans_count =3D nel;
-
-		rc =3D hashtab_init(&p->filename_trans, (1 << 11));
-		if (rc)
-			return rc;
-
-		for (i =3D 0; i < nel; i++) {
-			rc =3D filename_trans_read_helper_compat(p, fp);
-			if (rc)
-				return rc;
-		}
-	} else {
-		rc =3D hashtab_init(&p->filename_trans, nel);
-		if (rc)
-			return rc;
-
-		for (i =3D 0; i < nel; i++) {
-			rc =3D filename_trans_read_helper(p, fp);
-			if (rc)
-				return rc;
-		}
-	}
-	hash_eval(&p->filename_trans, "filenametr");
-	return 0;
-}
-
 static int genfs_read(struct policydb *p, void *fp)
 {
 	int i, j, rc;
@@ -2634,7 +2354,7 @@ int policydb_read(struct policydb *p, void *fp)
 		lra =3D ra;
 	}
=20
-	rc =3D filename_trans_read(p, fp);
+	rc =3D avtab_filename_trans_read(&p->te_avtab, fp, p);
 	if (rc)
 		goto bad;
=20
@@ -3480,119 +3200,6 @@ static int range_write(struct policydb *p, void *=
fp)
 	return 0;
 }
=20
-static int filename_write_helper_compat(void *key, void *data, void *ptr=
)
-{
-	struct filename_trans_key *ft =3D key;
-	struct filename_trans_datum *datum =3D data;
-	struct ebitmap_node *node;
-	void *fp =3D ptr;
-	__le32 buf[4];
-	int rc;
-	u32 bit, len =3D strlen(ft->name);
-
-	do {
-		ebitmap_for_each_positive_bit(&datum->stypes, node, bit) {
-			buf[0] =3D cpu_to_le32(len);
-			rc =3D put_entry(buf, sizeof(u32), 1, fp);
-			if (rc)
-				return rc;
-
-			rc =3D put_entry(ft->name, sizeof(char), len, fp);
-			if (rc)
-				return rc;
-
-			buf[0] =3D cpu_to_le32(bit + 1);
-			buf[1] =3D cpu_to_le32(ft->ttype);
-			buf[2] =3D cpu_to_le32(ft->tclass);
-			buf[3] =3D cpu_to_le32(datum->otype);
-
-			rc =3D put_entry(buf, sizeof(u32), 4, fp);
-			if (rc)
-				return rc;
-		}
-
-		datum =3D datum->next;
-	} while (unlikely(datum));
-
-	return 0;
-}
-
-static int filename_write_helper(void *key, void *data, void *ptr)
-{
-	struct filename_trans_key *ft =3D key;
-	struct filename_trans_datum *datum;
-	void *fp =3D ptr;
-	__le32 buf[3];
-	int rc;
-	u32 ndatum, len =3D strlen(ft->name);
-
-	buf[0] =3D cpu_to_le32(len);
-	rc =3D put_entry(buf, sizeof(u32), 1, fp);
-	if (rc)
-		return rc;
-
-	rc =3D put_entry(ft->name, sizeof(char), len, fp);
-	if (rc)
-		return rc;
-
-	ndatum =3D 0;
-	datum =3D data;
-	do {
-		ndatum++;
-		datum =3D datum->next;
-	} while (unlikely(datum));
-
-	buf[0] =3D cpu_to_le32(ft->ttype);
-	buf[1] =3D cpu_to_le32(ft->tclass);
-	buf[2] =3D cpu_to_le32(ndatum);
-	rc =3D put_entry(buf, sizeof(u32), 3, fp);
-	if (rc)
-		return rc;
-
-	datum =3D data;
-	do {
-		rc =3D ebitmap_write(&datum->stypes, fp);
-		if (rc)
-			return rc;
-
-		buf[0] =3D cpu_to_le32(datum->otype);
-		rc =3D put_entry(buf, sizeof(u32), 1, fp);
-		if (rc)
-			return rc;
-
-		datum =3D datum->next;
-	} while (unlikely(datum));
-
-	return 0;
-}
-
-static int filename_trans_write(struct policydb *p, void *fp)
-{
-	__le32 buf[1];
-	int rc;
-
-	if (p->policyvers < POLICYDB_VERSION_FILENAME_TRANS)
-		return 0;
-
-	if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
-		buf[0] =3D cpu_to_le32(p->compat_filename_trans_count);
-		rc =3D put_entry(buf, sizeof(u32), 1, fp);
-		if (rc)
-			return rc;
-
-		rc =3D hashtab_map(&p->filename_trans,
-				 filename_write_helper_compat, fp);
-	} else {
-		buf[0] =3D cpu_to_le32(p->filename_trans.nel);
-		rc =3D put_entry(buf, sizeof(u32), 1, fp);
-		if (rc)
-			return rc;
-
-		rc =3D hashtab_map(&p->filename_trans, filename_write_helper, fp);
-	}
-	return rc;
-}
-
 /*
  * Write the configuration data in a policy database
  * structure to a policy database binary representation
@@ -3703,7 +3310,7 @@ int policydb_write(struct policydb *p, void *fp)
 	if (rc)
 		return rc;
=20
-	rc =3D filename_trans_write(p, fp);
+	rc =3D avtab_filename_trans_write(p, &p->te_avtab, fp);
 	if (rc)
 		return rc;
=20
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policyd=
b.h
index ffc4e7bad205..2ecb24a1611a 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -91,18 +91,6 @@ struct role_trans_datum {
 	u32 new_role;		/* new role */
 };
=20
-struct filename_trans_key {
-	u32 ttype;		/* parent dir context */
-	u16 tclass;		/* class of new object */
-	const char *name;	/* last path component */
-};
-
-struct filename_trans_datum {
-	struct ebitmap stypes;	/* bitmap of source types for this otype */
-	u32 otype;		/* resulting type of new object */
-	struct filename_trans_datum *next;	/* record for next otype*/
-};
-
 struct role_allow {
 	u32 role;		/* current role */
 	u32 new_role;		/* new role */
@@ -265,14 +253,6 @@ struct policydb {
 	/* role transitions */
 	struct hashtab role_tr;
=20
-	/* file transitions with the last path component */
-	/* quickly exclude lookups when parent ttype has no rules */
-	struct ebitmap filename_trans_ttypes;
-	/* actual set of filename_trans rules */
-	struct hashtab filename_trans;
-	/* only used if policyvers < POLICYDB_VERSION_COMP_FTRANS */
-	u32 compat_filename_trans_count;
-
 	/* bools indexed by (value - 1) */
 	struct cond_bool_datum **bool_val_to_struct;
 	/* type enforcement conditional access vectors and transitions */
@@ -324,9 +304,6 @@ extern int policydb_role_isvalid(struct policydb *p, =
unsigned int role);
 extern int policydb_read(struct policydb *p, void *fp);
 extern int policydb_write(struct policydb *p, void *fp);
=20
-extern struct filename_trans_datum *policydb_filenametr_search(
-	struct policydb *p, struct filename_trans_key *key);
-
 extern struct mls_range *policydb_rangetr_search(
 	struct policydb *p, struct range_trans *key);
=20
@@ -379,6 +356,8 @@ static inline int put_entry(const void *buf, size_t b=
ytes, int num, struct polic
 	return 0;
 }
=20
+extern int str_read(char **strp, gfp_t flags, void *fp, u32 len);
+
 static inline char *sym_name(struct policydb *p, unsigned int sym_num, u=
nsigned int element_nr)
 {
 	return p->sym_val_to_name[sym_num][element_nr];
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/service=
s.c
index 8ed12406acba..131647e7ec68 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1661,36 +1661,6 @@ static int compute_sid_handle_invalid_context(
 	return -EACCES;
 }
=20
-static void filename_compute_type(struct policydb *policydb,
-				  struct context *newcontext,
-				  u32 stype, u32 ttype, u16 tclass,
-				  const char *objname)
-{
-	struct filename_trans_key ft;
-	struct filename_trans_datum *datum;
-
-	/*
-	 * Most filename trans rules are going to live in specific directories
-	 * like /dev or /var/run.  This bitmap will quickly skip rule searches
-	 * if the ttype does not contain any rules.
-	 */
-	if (!ebitmap_get_bit(&policydb->filename_trans_ttypes, ttype))
-		return;
-
-	ft.ttype =3D ttype;
-	ft.tclass =3D tclass;
-	ft.name =3D objname;
-
-	datum =3D policydb_filenametr_search(policydb, &ft);
-	while (datum) {
-		if (ebitmap_get_bit(&datum->stypes, stype - 1)) {
-			newcontext->type =3D datum->otype;
-			return;
-		}
-		datum =3D datum->next;
-	}
-}
-
 static int security_compute_sid(u32 ssid,
 				u32 tsid,
 				u16 orig_tclass,
@@ -1711,6 +1681,7 @@ static int security_compute_sid(u32 ssid,
 	u16 tclass;
 	int rc =3D 0;
 	bool sock;
+	u32 *otype;
=20
 	if (!selinux_initialized()) {
 		switch (orig_tclass) {
@@ -1830,17 +1801,24 @@ static int security_compute_sid(u32 ssid,
=20
 	if (avdatum) {
 		/* Use the type from the type transition/member/change rule. */
-		if (avkey.specified & AVTAB_TRANSITION)
-			newcontext.type =3D avdatum->u.trans->otype;
-		else
+		if (avkey.specified & AVTAB_TRANSITION) {
+			/*
+			 * use default otype if not empty and then to try to
+			 * find more specific rule using objname
+			 */
+			if (avdatum->u.trans->otype)
+				newcontext.type =3D avdatum->u.trans->otype;
+			if (objname) {
+				otype =3D symtab_search(&avdatum->u.trans->name_trans,
+						      objname);
+				if (otype)
+					newcontext.type =3D *otype;
+			}
+		} else {
 			newcontext.type =3D avdatum->u.data;
+		}
 	}
=20
-	/* if we have a objname this is a file trans check so check those rules=
 */
-	if (objname)
-		filename_compute_type(policydb, &newcontext, scontext->type,
-				      tcontext->type, tclass, objname);
-
 	/* Check for class-specific changes. */
 	if (specified & AVTAB_TRANSITION) {
 		/* Look for a role transition rule. */
--=20
2.40.0

