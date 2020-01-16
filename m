Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C075C33CAF
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 21:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2DA2073A
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 21:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbgAPVsU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:48:20 -0500
Received: from ns.lynxeye.de ([87.118.118.114]:52671 "EHLO lynxeye.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729878AbgAPVsU (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 16 Jan 2020 16:48:20 -0500
X-Greylist: delayed 513 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jan 2020 16:48:19 EST
Received: by lynxeye.de (Postfix, from userid 501)
        id 5BB29E74222; Thu, 16 Jan 2020 22:39:45 +0100 (CET)
Received: from radon.fritz.box (a89-183-70-203.net-htp.de [89.183.70.203])
        by lynxeye.de (Postfix) with ESMTPA id 9321AE7414D;
        Thu, 16 Jan 2020 22:39:42 +0100 (CET)
From:   Lucas Stach <dev@lynxeye.de>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC] selinux: policydb - convert filename trans hash to rhashtable
Date:   Thu, 16 Jan 2020 22:39:37 +0100
Message-Id: <20200116213937.77795-1-dev@lynxeye.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The current hash is too small for current usages in, e.g. the Fedora standard
policy. On file creates a considerable amount of CPU time is spent walking the
the hash chains. Increasing the number of hash buckets somewhat mitigates the
issue, but doesn't completely get rid of the long hash chains.

This patch does take the bit more invasive route by converting the filename
trans hash to a rhashtable to allow this hash to scale with load.

fs_mark create benchmark on a SSD device, no ramdisk:
Count          Size       Files/sec     App Overhead
before:
10000          512        512.3           147715
after:
10000          512        572.3            75141

filenametr_cmp(), which was the topmost function in the CPU cycle trace before
at ~5% of the overall CPU time, is now down in the noise.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
---
 security/selinux/ss/policydb.c | 140 +++++++++++++++++++++++----------
 security/selinux/ss/policydb.h |  14 ++--
 security/selinux/ss/services.c |  31 +-------
 3 files changed, 109 insertions(+), 76 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index e20624a68f5d..d059317c15b6 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -34,6 +34,7 @@
 #include <linux/string.h>
 #include <linux/errno.h>
 #include <linux/audit.h>
+#include <linux/rhashtable.h>
 #include "security.h"
 
 #include "policydb.h"
@@ -334,15 +335,13 @@ static int (*destroy_f[SYM_NUM]) (void *key, void *datum, void *datap) =
 	cat_destroy,
 };
 
-static int filenametr_destroy(void *key, void *datum, void *p)
+static void filenametr_destroy(void *ptr, void *arg)
 {
-	struct filename_trans *ft = key;
+	struct filename_trans *ft = ptr;
 
 	kfree(ft->name);
-	kfree(key);
-	kfree(datum);
+	kfree(ft);
 	cond_resched();
-	return 0;
 }
 
 static int range_tr_destroy(void *key, void *datum, void *p)
@@ -404,9 +403,9 @@ static int roles_init(struct policydb *p)
 	return rc;
 }
 
-static u32 filenametr_hash(struct hashtab *h, const void *k)
+static u32 filenametr_hash(const void *data, u32 len, u32 seed)
 {
-	const struct filename_trans *ft = k;
+	const struct filename_trans *ft = data;
 	unsigned long hash;
 	unsigned int byte_num;
 	unsigned char focus;
@@ -416,13 +415,15 @@ static u32 filenametr_hash(struct hashtab *h, const void *k)
 	byte_num = 0;
 	while ((focus = ft->name[byte_num++]))
 		hash = partial_name_hash(focus, hash);
-	return hash & (h->size - 1);
+
+	return end_name_hash(hash);
 }
 
-static int filenametr_cmp(struct hashtab *h, const void *k1, const void *k2)
+static int filenametr_cmp(struct rhashtable_compare_arg *arg,
+			  const void *obj)
 {
-	const struct filename_trans *ft1 = k1;
-	const struct filename_trans *ft2 = k2;
+	const struct filename_trans *ft1 = arg->key;
+	const struct filename_trans *ft2 = obj;
 	int v;
 
 	v = ft1->stype - ft2->stype;
@@ -441,6 +442,39 @@ static int filenametr_cmp(struct hashtab *h, const void *k1, const void *k2)
 
 }
 
+static const struct rhashtable_params filename_trans_hashparams = {
+	.nelem_hint		= 1024,
+	.head_offset		= offsetof(struct filename_trans, hash_head),
+	.obj_hashfn		= filenametr_hash,
+	.obj_cmpfn		= filenametr_cmp,
+};
+
+void policydb_filename_compute_type(struct policydb *policydb,
+				    struct context *newcontext,
+				    u32 stype, u32 ttype, u16 tclass,
+				    const char *objname)
+{
+	struct filename_trans key, *ft;
+
+	/*
+	 * Most filename trans rules are going to live in specific directories
+	 * like /dev or /var/run.  This bitmap will quickly skip rule searches
+	 * if the ttype does not contain any rules.
+	 */
+	if (!ebitmap_get_bit(&policydb->filename_trans_ttypes, ttype))
+		return;
+
+	key.stype = stype;
+	key.ttype = ttype;
+	key.tclass = tclass;
+	key.name = objname;
+
+	ft = rhashtable_lookup(&policydb->filename_trans, &key,
+			       filename_trans_hashparams);
+	if (ft)
+		newcontext->type = ft->otype;
+}
+
 static u32 rangetr_hash(struct hashtab *h, const void *k)
 {
 	const struct range_trans *key = k;
@@ -494,12 +528,7 @@ static int policydb_init(struct policydb *p)
 	if (rc)
 		goto out;
 
-	p->filename_trans = hashtab_create(filenametr_hash, filenametr_cmp,
-					   (1 << 10));
-	if (!p->filename_trans) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	rhashtable_init(&p->filename_trans, &filename_trans_hashparams);
 
 	p->range_tr = hashtab_create(rangetr_hash, rangetr_cmp, 256);
 	if (!p->range_tr) {
@@ -513,7 +542,7 @@ static int policydb_init(struct policydb *p)
 
 	return 0;
 out:
-	hashtab_destroy(p->filename_trans);
+	rhashtable_destroy(&p->filename_trans);
 	hashtab_destroy(p->range_tr);
 	for (i = 0; i < SYM_NUM; i++) {
 		hashtab_map(p->symtab[i].table, destroy_f[i], NULL);
@@ -831,8 +860,8 @@ void policydb_destroy(struct policydb *p)
 	}
 	kfree(lra);
 
-	hashtab_map(p->filename_trans, filenametr_destroy, NULL);
-	hashtab_destroy(p->filename_trans);
+	rhashtable_free_and_destroy(&p->filename_trans, filenametr_destroy,
+				    NULL);
 
 	hashtab_map(p->range_tr, range_tr_destroy, NULL);
 	hashtab_destroy(p->range_tr);
@@ -1878,7 +1907,6 @@ static int range_read(struct policydb *p, void *fp)
 static int filename_trans_read(struct policydb *p, void *fp)
 {
 	struct filename_trans *ft;
-	struct filename_trans_datum *otype;
 	char *name;
 	u32 nel, len;
 	__le32 buf[4];
@@ -1893,7 +1921,6 @@ static int filename_trans_read(struct policydb *p, void *fp)
 	nel = le32_to_cpu(buf[0]);
 
 	for (i = 0; i < nel; i++) {
-		otype = NULL;
 		name = NULL;
 
 		rc = -ENOMEM;
@@ -1901,11 +1928,6 @@ static int filename_trans_read(struct policydb *p, void *fp)
 		if (!ft)
 			goto out;
 
-		rc = -ENOMEM;
-		otype = kmalloc(sizeof(*otype), GFP_KERNEL);
-		if (!otype)
-			goto out;
-
 		/* length of the path component string */
 		rc = next_entry(buf, fp, sizeof(u32));
 		if (rc)
@@ -1926,14 +1948,14 @@ static int filename_trans_read(struct policydb *p, void *fp)
 		ft->stype = le32_to_cpu(buf[0]);
 		ft->ttype = le32_to_cpu(buf[1]);
 		ft->tclass = le32_to_cpu(buf[2]);
-
-		otype->otype = le32_to_cpu(buf[3]);
+		ft->otype = le32_to_cpu(buf[3]);
 
 		rc = ebitmap_set_bit(&p->filename_trans_ttypes, ft->ttype, 1);
 		if (rc)
 			goto out;
 
-		rc = hashtab_insert(p->filename_trans, ft, otype);
+		rc = rhashtable_insert_fast(&p->filename_trans, &ft->hash_head,
+					    filename_trans_hashparams);
 		if (rc) {
 			/*
 			 * Do not return -EEXIST to the caller, or the system
@@ -1944,15 +1966,12 @@ static int filename_trans_read(struct policydb *p, void *fp)
 			/* But free memory to avoid memory leak. */
 			kfree(ft);
 			kfree(name);
-			kfree(otype);
 		}
 	}
-	hash_eval(p->filename_trans, "filenametr");
 	return 0;
 out:
 	kfree(ft);
 	kfree(name);
-	kfree(otype);
 
 	return rc;
 }
@@ -3323,12 +3342,10 @@ static int range_write(struct policydb *p, void *fp)
 	return 0;
 }
 
-static int filename_write_helper(void *key, void *data, void *ptr)
+static int filename_write_helper(struct filename_trans *ft,
+				 struct policy_file *fp)
 {
 	__le32 buf[4];
-	struct filename_trans *ft = key;
-	struct filename_trans_datum *otype = data;
-	void *fp = ptr;
 	int rc;
 	u32 len;
 
@@ -3345,7 +3362,7 @@ static int filename_write_helper(void *key, void *data, void *ptr)
 	buf[0] = cpu_to_le32(ft->stype);
 	buf[1] = cpu_to_le32(ft->ttype);
 	buf[2] = cpu_to_le32(ft->tclass);
-	buf[3] = cpu_to_le32(otype->otype);
+	buf[3] = cpu_to_le32(ft->otype);
 
 	rc = put_entry(buf, sizeof(u32), 4, fp);
 	if (rc)
@@ -3356,15 +3373,34 @@ static int filename_write_helper(void *key, void *data, void *ptr)
 
 static int filename_trans_write(struct policydb *p, void *fp)
 {
-	u32 nel;
+	u32 nel = 0;
 	__le32 buf[1];
-	int rc;
+	int rc = 0;
+	struct rhashtable_iter iter;
 
 	if (p->policyvers < POLICYDB_VERSION_FILENAME_TRANS)
 		return 0;
 
-	nel = 0;
-	rc = hashtab_map(p->filename_trans, hashtab_cnt, &nel);
+	rhashtable_walk_enter(&p->filename_trans, &iter);
+	rhashtable_walk_start(&iter);
+	for(;;) {
+		struct filename_trans *trans;
+
+		trans = rhashtable_walk_next(&iter);
+		if (!trans)
+			break;
+		if (IS_ERR(trans)) {
+			if (PTR_ERR(trans) == -EAGAIN) {
+				nel = 0;
+				continue;
+			}
+			rc = PTR_ERR(trans);
+			break;
+		}
+		nel++;
+	};
+	rhashtable_walk_stop(&iter);
+	rhashtable_walk_exit(&iter);
 	if (rc)
 		return rc;
 
@@ -3373,7 +3409,25 @@ static int filename_trans_write(struct policydb *p, void *fp)
 	if (rc)
 		return rc;
 
-	rc = hashtab_map(p->filename_trans, filename_write_helper, fp);
+	rhashtable_walk_enter(&p->filename_trans, &iter);
+	rhashtable_walk_start(&iter);
+	for(;;) {
+		struct filename_trans *trans;
+
+		trans = rhashtable_walk_next(&iter);
+		if (!trans)
+			break;
+		if (IS_ERR(trans)) {
+			if (PTR_ERR(trans) == -EAGAIN) {
+				continue;
+			}
+			rc = PTR_ERR(trans);
+			break;
+		}
+		filename_write_helper(trans, fp);
+	};
+	rhashtable_walk_stop(&iter);
+	rhashtable_walk_exit(&iter);
 	if (rc)
 		return rc;
 
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index bc56b14e2216..f1d2f5166af2 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -29,6 +29,7 @@
 #include "mls_types.h"
 #include "context.h"
 #include "constraint.h"
+#include <linux/rhashtable.h>
 
 /*
  * A datum type is defined for each kind of symbol
@@ -90,16 +91,14 @@ struct role_trans {
 };
 
 struct filename_trans {
+	struct rhash_head hash_head;
+	u32 otype;
 	u32 stype;		/* current process */
 	u32 ttype;		/* parent dir context */
 	u16 tclass;		/* class of new object */
 	const char *name;	/* last path component */
 };
 
-struct filename_trans_datum {
-	u32 otype;		/* expected of new object */
-};
-
 struct role_allow {
 	u32 role;		/* current role */
 	u32 new_role;		/* new role */
@@ -266,7 +265,7 @@ struct policydb {
 	/* quickly exclude lookups when parent ttype has no rules */
 	struct ebitmap filename_trans_ttypes;
 	/* actual set of filename_trans rules */
-	struct hashtab *filename_trans;
+	struct rhashtable filename_trans;
 
 	/* bools indexed by (value - 1) */
 	struct cond_bool_datum **bool_val_to_struct;
@@ -318,6 +317,11 @@ extern int policydb_role_isvalid(struct policydb *p, unsigned int role);
 extern int policydb_read(struct policydb *p, void *fp);
 extern int policydb_write(struct policydb *p, void *fp);
 
+void policydb_filename_compute_type(struct policydb *policydb,
+				    struct context *newcontext,
+				    u32 stype, u32 ttype, u16 tclass,
+				    const char *objname);
+
 #define PERM_SYMTAB_SIZE 32
 
 #define POLICYDB_CONFIG_MLS    1
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index a5813c7629c1..60a98d900dd3 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1607,32 +1607,6 @@ static int compute_sid_handle_invalid_context(
 	return -EACCES;
 }
 
-static void filename_compute_type(struct policydb *policydb,
-				  struct context *newcontext,
-				  u32 stype, u32 ttype, u16 tclass,
-				  const char *objname)
-{
-	struct filename_trans ft;
-	struct filename_trans_datum *otype;
-
-	/*
-	 * Most filename trans rules are going to live in specific directories
-	 * like /dev or /var/run.  This bitmap will quickly skip rule searches
-	 * if the ttype does not contain any rules.
-	 */
-	if (!ebitmap_get_bit(&policydb->filename_trans_ttypes, ttype))
-		return;
-
-	ft.stype = stype;
-	ft.ttype = ttype;
-	ft.tclass = tclass;
-	ft.name = objname;
-
-	otype = hashtab_search(policydb->filename_trans, &ft);
-	if (otype)
-		newcontext->type = otype->otype;
-}
-
 static int security_compute_sid(struct selinux_state *state,
 				u32 ssid,
 				u32 tsid,
@@ -1770,8 +1744,9 @@ static int security_compute_sid(struct selinux_state *state,
 
 	/* if we have a objname this is a file trans check so check those rules */
 	if (objname)
-		filename_compute_type(policydb, &newcontext, scontext->type,
-				      tcontext->type, tclass, objname);
+		policydb_filename_compute_type(policydb, &newcontext,
+					       scontext->type, tcontext->type,
+					       tclass, objname);
 
 	/* Check for class-specific changes. */
 	if (specified & AVTAB_TRANSITION) {
-- 
2.24.1

