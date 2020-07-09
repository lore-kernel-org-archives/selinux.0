Return-Path: <SRS0=XbfQ=AU=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC39C433DF
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 19:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE0382078B
	for <selinux@archiver.kernel.org>; Thu,  9 Jul 2020 19:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUH/icUd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgGITUE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Jul 2020 15:20:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51062 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726196AbgGITUE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Jul 2020 15:20:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594322401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yxYaf5z44UFBm5eXaCjc6krdUoAOLBfqPh9i83VQ0Rc=;
        b=NUH/icUd0+VSoGV0u3Dz+wvBQrq2oY3IeZuRbamGbqa0fEzTUVnQNuKkwNJo19PJs1REnw
        S/zcFgxUHgw1FCSoBzrgO4u4T2knB4P2+l1mHONZqstQQfvr9SKMlZu2T0+SQfM9fpSfFd
        aTMR5/Kovgkj5FAXefDbIoqwxi5DMuM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-cfsVaU5-PuuC0r6iclhTpw-1; Thu, 09 Jul 2020 15:19:57 -0400
X-MC-Unique: cfsVaU5-PuuC0r6iclhTpw-1
Received: by mail-wm1-f72.google.com with SMTP id t18so3172483wmj.5
        for <selinux@vger.kernel.org>; Thu, 09 Jul 2020 12:19:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yxYaf5z44UFBm5eXaCjc6krdUoAOLBfqPh9i83VQ0Rc=;
        b=L9W4bZwo+RC/zzW9IadI42XpbTOJK0Hfekho1Bi9RfPJo6XEEnLNQVO2DtMeinn58u
         8R8dpNgWBFn8ZV7/MVmmPPmY6V7RNwMyaYCvQgt1gItHitqGO1ztXRZBQ0u7uarLJlIE
         rLuDWEM7n8fM+rpNvcrhc/LAQFesaxOEUD0glmMNz400lC42b5H2kscgjNGTZv+JPIdg
         At5uZsiGfomDXGddn2Ou2IdN2GFXp+nGUaNkTbZZlRq/NmgM4CA4AnJFDbU4hBh1/pnu
         kWDlRd3jwXbo3NxYzRLSHATFuUN3wrDjd+2+/VquQYfpqFT/WFkU5jd3vqLypiYm3dix
         tgSw==
X-Gm-Message-State: AOAM531uip7+f036SATRMgZeYFvnf3grdRmeEQ7stGc7e92fEZX+xPU/
        Lt6sHjWlpc4E/BZ+LUIpD1I7WfV7xe8VHWMSvciHoOBj6n2WMhBmhOURGk+rUtvN0v9iIj18L/9
        v2SQVrNWB2hucFJdn3Q==
X-Received: by 2002:a05:600c:4109:: with SMTP id j9mr1360051wmi.157.1594322396009;
        Thu, 09 Jul 2020 12:19:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzz9OsaTncXpkGD9CVKT+havhzetDwPJlXvC2MnyPwwsfMXIU4gXAqdm0OrU6ew3vPKEyB6FQ==
X-Received: by 2002:a05:600c:4109:: with SMTP id j9mr1360022wmi.157.1594322395446;
        Thu, 09 Jul 2020 12:19:55 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id f14sm7205086wro.90.2020.07.09.12.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 12:19:55 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 1/2] selinux: prepare for inlining of hashtab functions
Date:   Thu,  9 Jul 2020 21:19:51 +0200
Message-Id: <20200709191952.435970-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200709191952.435970-1-omosnace@redhat.com>
References: <20200709191952.435970-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Refactor searching and inserting into hashtabs to pave the way for
converting hashtab_search() and hashtab_insert() to inline functions in
the next patch. This will avoid indirect calls and allow the compiler to
better optimize individual callers, leading to a significant performance
improvement.

In order to avoid the indirect calls, the key hashing and comparison
callbacks need to be extracted from the hashtab struct and passed
directly to hashtab_search()/_insert() by the callers so that the
callback address is always known at compile time. The kernel's
rhashtable library (<linux/rhashtable*.h>) does the same thing.

This of course makes the hashtab functions slightly easier to misuse by
passing a wrong callback set, but unfortunately there is no better way
to implement a hash table that is both generic and efficient in C. This
patch tries to somewhat mitigate this by only calling the hashtab
functions in the same file where the corresponding callbacks are
defined (wrapping them into more specialized functions as needed).

Note that this patch doesn't bring any benefit without also moving the
definitions of hashtab_search() and -_insert() to the header file, which
is done in a follow-up patch for easier review of the hashtab.c changes
in this patch.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/hashtab.c  | 44 ++++++++++----------
 security/selinux/ss/hashtab.h  | 22 +++++-----
 security/selinux/ss/mls.c      |  2 +-
 security/selinux/ss/policydb.c | 76 ++++++++++++++++++++++++----------
 security/selinux/ss/policydb.h |  9 ++++
 security/selinux/ss/services.c |  4 +-
 security/selinux/ss/symtab.c   | 16 ++++---
 7 files changed, 110 insertions(+), 63 deletions(-)

diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index 5ee868116d706..8126b909a7574 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -29,16 +29,10 @@ static u32 hashtab_compute_size(u32 nel)
 	return nel == 0 ? 0 : roundup_pow_of_two(nel);
 }
 
-int hashtab_init(struct hashtab *h,
-		 u32 (*hash_value)(struct hashtab *h, const void *key),
-		 int (*keycmp)(struct hashtab *h, const void *key1,
-			       const void *key2),
-		 u32 nel_hint)
+int hashtab_init(struct hashtab *h, u32 nel_hint)
 {
 	h->size = hashtab_compute_size(nel_hint);
 	h->nel = 0;
-	h->hash_value = hash_value;
-	h->keycmp = keycmp;
 	if (!h->size)
 		return 0;
 
@@ -46,7 +40,8 @@ int hashtab_init(struct hashtab *h,
 	return h->htable ? 0 : -ENOMEM;
 }
 
-int hashtab_insert(struct hashtab *h, void *key, void *datum)
+int hashtab_insert(struct hashtab *h, void *key, void *datum,
+		   struct hashtab_key_params key_params)
 {
 	u32 hvalue;
 	struct hashtab_node *prev, *cur, *newnode;
@@ -56,17 +51,20 @@ int hashtab_insert(struct hashtab *h, void *key, void *datum)
 	if (!h->size || h->nel == HASHTAB_MAX_NODES)
 		return -EINVAL;
 
-	hvalue = h->hash_value(h, key);
+	hvalue = key_params.hash(key) & (h->size - 1);
 	prev = NULL;
 	cur = h->htable[hvalue];
-	while (cur && h->keycmp(h, key, cur->key) > 0) {
+	while (cur) {
+		int cmp = key_params.cmp(key, cur->key);
+
+		if (cmp == 0)
+			return -EEXIST;
+		if (cmp < 0)
+			break;
 		prev = cur;
 		cur = cur->next;
 	}
 
-	if (cur && (h->keycmp(h, key, cur->key) == 0))
-		return -EEXIST;
-
 	newnode = kmem_cache_zalloc(hashtab_node_cachep, GFP_KERNEL);
 	if (!newnode)
 		return -ENOMEM;
@@ -84,7 +82,8 @@ int hashtab_insert(struct hashtab *h, void *key, void *datum)
 	return 0;
 }
 
-void *hashtab_search(struct hashtab *h, const void *key)
+void *hashtab_search(struct hashtab *h, const void *key,
+		     struct hashtab_key_params key_params)
 {
 	u32 hvalue;
 	struct hashtab_node *cur;
@@ -92,15 +91,18 @@ void *hashtab_search(struct hashtab *h, const void *key)
 	if (!h->size)
 		return NULL;
 
-	hvalue = h->hash_value(h, key);
+	hvalue = key_params.hash(key) & (h->size - 1);
 	cur = h->htable[hvalue];
-	while (cur && h->keycmp(h, key, cur->key) > 0)
-		cur = cur->next;
+	while (cur) {
+		int cmp = key_params.cmp(key, cur->key);
 
-	if (!cur || (h->keycmp(h, key, cur->key) != 0))
-		return NULL;
-
-	return cur->datum;
+		if (cmp == 0)
+			return cur->datum;
+		if (cmp < 0)
+			break;
+		cur = cur->next;
+	}
+	return NULL;
 }
 
 void hashtab_destroy(struct hashtab *h)
diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.h
index 31c11511fe100..4885234257d40 100644
--- a/security/selinux/ss/hashtab.h
+++ b/security/selinux/ss/hashtab.h
@@ -13,6 +13,12 @@
 
 #define HASHTAB_MAX_NODES	0xffffffff
 
+struct hashtab_key_params {
+	u32 (*hash)(const void *key);	/* hash function */
+	int (*cmp)(const void *key1, const void *key2);
+					/* key comparison function */
+};
+
 struct hashtab_node {
 	void *key;
 	void *datum;
@@ -23,10 +29,6 @@ struct hashtab {
 	struct hashtab_node **htable;	/* hash table */
 	u32 size;			/* number of slots in hash table */
 	u32 nel;			/* number of elements in hash table */
-	u32 (*hash_value)(struct hashtab *h, const void *key);
-					/* hash function */
-	int (*keycmp)(struct hashtab *h, const void *key1, const void *key2);
-					/* key comparison function */
 };
 
 struct hashtab_info {
@@ -39,11 +41,7 @@ struct hashtab_info {
  *
  * Returns -ENOMEM if insufficient space is available or 0 otherwise.
  */
-int hashtab_init(struct hashtab *h,
-		 u32 (*hash_value)(struct hashtab *h, const void *key),
-		 int (*keycmp)(struct hashtab *h, const void *key1,
-			       const void *key2),
-		 u32 nel_hint);
+int hashtab_init(struct hashtab *h, u32 nel_hint);
 
 /*
  * Inserts the specified (key, datum) pair into the specified hash table.
@@ -53,7 +51,8 @@ int hashtab_init(struct hashtab *h,
  * -EINVAL for general errors or
   0 otherwise.
  */
-int hashtab_insert(struct hashtab *h, void *k, void *d);
+int hashtab_insert(struct hashtab *h, void *k, void *d,
+		   struct hashtab_key_params key_params);
 
 /*
  * Searches for the entry with the specified key in the hash table.
@@ -61,7 +60,8 @@ int hashtab_insert(struct hashtab *h, void *k, void *d);
  * Returns NULL if no entry has the specified key or
  * the datum of the entry otherwise.
  */
-void *hashtab_search(struct hashtab *h, const void *k);
+void *hashtab_search(struct hashtab *h, const void *k,
+		     struct hashtab_key_params key_params);
 
 /*
  * Destroys the specified hash table.
diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index 5be241b6b1900..408d306895f8f 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -507,7 +507,7 @@ int mls_compute_sid(struct policydb *p,
 		rtr.source_type = scontext->type;
 		rtr.target_type = tcontext->type;
 		rtr.target_class = tclass;
-		r = hashtab_search(&p->range_tr, &rtr);
+		r = policydb_rangetr_search(p, &rtr);
 		if (r)
 			return mls_range_set(newcontext, r);
 
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 02b722c5c189d..9fccf417006b0 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -411,7 +411,7 @@ out:
 	return rc;
 }
 
-static u32 filenametr_hash(struct hashtab *h, const void *k)
+static u32 filenametr_hash(const void *k)
 {
 	const struct filename_trans_key *ft = k;
 	unsigned long hash;
@@ -423,10 +423,10 @@ static u32 filenametr_hash(struct hashtab *h, const void *k)
 	byte_num = 0;
 	while ((focus = ft->name[byte_num++]))
 		hash = partial_name_hash(focus, hash);
-	return hash & (h->size - 1);
+	return hash;
 }
 
-static int filenametr_cmp(struct hashtab *h, const void *k1, const void *k2)
+static int filenametr_cmp(const void *k1, const void *k2)
 {
 	const struct filename_trans_key *ft1 = k1;
 	const struct filename_trans_key *ft2 = k2;
@@ -444,15 +444,26 @@ static int filenametr_cmp(struct hashtab *h, const void *k1, const void *k2)
 
 }
 
-static u32 rangetr_hash(struct hashtab *h, const void *k)
+static const struct hashtab_key_params filenametr_key_params = {
+	.hash = filenametr_hash,
+	.cmp = filenametr_cmp,
+};
+
+struct filename_trans_datum *policydb_filenametr_search(
+	struct policydb *p, struct filename_trans_key *key)
+{
+	return hashtab_search(&p->filename_trans, key, filenametr_key_params);
+}
+
+static u32 rangetr_hash(const void *k)
 {
 	const struct range_trans *key = k;
 
-	return (key->source_type + (key->target_type << 3) +
-		(key->target_class << 5)) & (h->size - 1);
+	return key->source_type + (key->target_type << 3) +
+		(key->target_class << 5);
 }
 
-static int rangetr_cmp(struct hashtab *h, const void *k1, const void *k2)
+static int rangetr_cmp(const void *k1, const void *k2)
 {
 	const struct range_trans *key1 = k1, *key2 = k2;
 	int v;
@@ -470,15 +481,25 @@ static int rangetr_cmp(struct hashtab *h, const void *k1, const void *k2)
 	return v;
 }
 
-static u32 role_trans_hash(struct hashtab *h, const void *k)
+static const struct hashtab_key_params rangetr_key_params = {
+	.hash = rangetr_hash,
+	.cmp = rangetr_cmp,
+};
+
+struct mls_range *policydb_rangetr_search(struct policydb *p,
+					  struct range_trans *key)
+{
+	return hashtab_search(&p->range_tr, key, rangetr_key_params);
+}
+
+static u32 role_trans_hash(const void *k)
 {
 	const struct role_trans_key *key = k;
 
-	return (key->role + (key->type << 3) + (key->tclass << 5)) &
-		(h->size - 1);
+	return key->role + (key->type << 3) + (key->tclass << 5);
 }
 
-static int role_trans_cmp(struct hashtab *h, const void *k1, const void *k2)
+static int role_trans_cmp(const void *k1, const void *k2)
 {
 	const struct role_trans_key *key1 = k1, *key2 = k2;
 	int v;
@@ -494,6 +515,17 @@ static int role_trans_cmp(struct hashtab *h, const void *k1, const void *k2)
 	return key1->tclass - key2->tclass;
 }
 
+static const struct hashtab_key_params roletr_key_params = {
+	.hash = role_trans_hash,
+	.cmp = role_trans_cmp,
+};
+
+struct role_trans_datum *policydb_roletr_search(struct policydb *p,
+						struct role_trans_key *key)
+{
+	return hashtab_search(&p->role_tr, key, roletr_key_params);
+}
+
 /*
  * Initialize a policy database structure.
  */
@@ -1796,7 +1828,7 @@ static int range_read(struct policydb *p, void *fp)
 
 	nel = le32_to_cpu(buf[0]);
 
-	rc = hashtab_init(&p->range_tr, rangetr_hash, rangetr_cmp, nel);
+	rc = hashtab_init(&p->range_tr, nel);
 	if (rc)
 		return rc;
 
@@ -1841,7 +1873,7 @@ static int range_read(struct policydb *p, void *fp)
 			goto out;
 		}
 
-		rc = hashtab_insert(&p->range_tr, rt, r);
+		rc = hashtab_insert(&p->range_tr, rt, r, rangetr_key_params);
 		if (rc)
 			goto out;
 
@@ -1888,7 +1920,7 @@ static int filename_trans_read_helper_compat(struct policydb *p, void *fp)
 	otype = le32_to_cpu(buf[3]);
 
 	last = NULL;
-	datum = hashtab_search(&p->filename_trans, &key);
+	datum = policydb_filenametr_search(p, &key);
 	while (datum) {
 		if (unlikely(ebitmap_get_bit(&datum->stypes, stype - 1))) {
 			/* conflicting/duplicate rules are ignored */
@@ -1918,7 +1950,8 @@ static int filename_trans_read_helper_compat(struct policydb *p, void *fp)
 			if (!ft)
 				goto out;
 
-			rc = hashtab_insert(&p->filename_trans, ft, datum);
+			rc = hashtab_insert(&p->filename_trans, ft, datum,
+					    filenametr_key_params);
 			if (rc)
 				goto out;
 			name = NULL;
@@ -2006,7 +2039,8 @@ static int filename_trans_read_helper(struct policydb *p, void *fp)
 	ft->tclass = tclass;
 	ft->name = name;
 
-	rc = hashtab_insert(&p->filename_trans, ft, first);
+	rc = hashtab_insert(&p->filename_trans, ft, first,
+			    filenametr_key_params);
 	if (rc == -EEXIST)
 		pr_err("SELinux:  Duplicate filename transition key\n");
 	if (rc)
@@ -2044,8 +2078,7 @@ static int filename_trans_read(struct policydb *p, void *fp)
 	if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
 		p->compat_filename_trans_count = nel;
 
-		rc = hashtab_init(&p->filename_trans, filenametr_hash,
-				  filenametr_cmp, (1 << 11));
+		rc = hashtab_init(&p->filename_trans, (1 << 11));
 		if (rc)
 			return rc;
 
@@ -2055,8 +2088,7 @@ static int filename_trans_read(struct policydb *p, void *fp)
 				return rc;
 		}
 	} else {
-		rc = hashtab_init(&p->filename_trans, filenametr_hash,
-				  filenametr_cmp, nel);
+		rc = hashtab_init(&p->filename_trans, nel);
 		if (rc)
 			return rc;
 
@@ -2539,7 +2571,7 @@ int policydb_read(struct policydb *p, void *fp)
 		goto bad;
 	nel = le32_to_cpu(buf[0]);
 
-	rc = hashtab_init(&p->role_tr, role_trans_hash, role_trans_cmp, nel);
+	rc = hashtab_init(&p->role_tr, nel);
 	if (rc)
 		goto bad;
 	for (i = 0; i < nel; i++) {
@@ -2576,7 +2608,7 @@ int policydb_read(struct policydb *p, void *fp)
 		    !policydb_role_isvalid(p, rtd->new_role))
 			goto bad;
 
-		rc = hashtab_insert(&p->role_tr, rtk, rtd);
+		rc = hashtab_insert(&p->role_tr, rtk, rtd, roletr_key_params);
 		if (rc)
 			goto bad;
 
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 9591c9587cb69..c24d4e1063ea0 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -324,6 +324,15 @@ extern int policydb_role_isvalid(struct policydb *p, unsigned int role);
 extern int policydb_read(struct policydb *p, void *fp);
 extern int policydb_write(struct policydb *p, void *fp);
 
+extern struct filename_trans_datum *policydb_filenametr_search(
+	struct policydb *p, struct filename_trans_key *key);
+
+extern struct mls_range *policydb_rangetr_search(
+	struct policydb *p, struct range_trans *key);
+
+extern struct role_trans_datum *policydb_roletr_search(
+	struct policydb *p, struct role_trans_key *key);
+
 #define POLICYDB_CONFIG_MLS    1
 
 /* the config flags related to unknown classes/perms are bits 2 and 3 */
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 1d12bb9ff3dd6..9e76a80db6e1f 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1671,7 +1671,7 @@ static void filename_compute_type(struct policydb *policydb,
 	ft.tclass = tclass;
 	ft.name = objname;
 
-	datum = hashtab_search(&policydb->filename_trans, &ft);
+	datum = policydb_filenametr_search(policydb, &ft);
 	while (datum) {
 		if (ebitmap_get_bit(&datum->stypes, stype - 1)) {
 			newcontext->type = datum->otype;
@@ -1834,7 +1834,7 @@ static int security_compute_sid(struct selinux_state *state,
 			.tclass = tclass,
 		};
 
-		rtd = hashtab_search(&policydb->role_tr, &rtk);
+		rtd = policydb_roletr_search(policydb, &rtk);
 		if (rtd)
 			newcontext.role = rtd->new_role;
 	}
diff --git a/security/selinux/ss/symtab.c b/security/selinux/ss/symtab.c
index 48f523ef93aae..c42a6648a07df 100644
--- a/security/selinux/ss/symtab.c
+++ b/security/selinux/ss/symtab.c
@@ -9,7 +9,7 @@
 #include <linux/errno.h>
 #include "symtab.h"
 
-static unsigned int symhash(struct hashtab *h, const void *key)
+static unsigned int symhash(const void *key)
 {
 	const char *p, *keyp;
 	unsigned int size;
@@ -20,10 +20,10 @@ static unsigned int symhash(struct hashtab *h, const void *key)
 	size = strlen(keyp);
 	for (p = keyp; (p - keyp) < size; p++)
 		val = (val << 4 | (val >> (8*sizeof(unsigned int)-4))) ^ (*p);
-	return val & (h->size - 1);
+	return val;
 }
 
-static int symcmp(struct hashtab *h, const void *key1, const void *key2)
+static int symcmp(const void *key1, const void *key2)
 {
 	const char *keyp1, *keyp2;
 
@@ -32,19 +32,23 @@ static int symcmp(struct hashtab *h, const void *key1, const void *key2)
 	return strcmp(keyp1, keyp2);
 }
 
+static const struct hashtab_key_params symtab_key_params = {
+	.hash = symhash,
+	.cmp = symcmp,
+};
 
 int symtab_init(struct symtab *s, unsigned int size)
 {
 	s->nprim = 0;
-	return hashtab_init(&s->table, symhash, symcmp, size);
+	return hashtab_init(&s->table, size);
 }
 
 int symtab_insert(struct symtab *s, char *name, void *datum)
 {
-	return hashtab_insert(&s->table, name, datum);
+	return hashtab_insert(&s->table, name, datum, symtab_key_params);
 }
 
 void *symtab_search(struct symtab *s, const char *name)
 {
-	return hashtab_search(&s->table, name);
+	return hashtab_search(&s->table, name, symtab_key_params);
 }
-- 
2.26.2

