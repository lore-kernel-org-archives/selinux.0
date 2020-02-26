Return-Path: <SRS0=jqI3=4O=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471F3C4BA12
	for <selinux@archiver.kernel.org>; Wed, 26 Feb 2020 15:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E812222C2
	for <selinux@archiver.kernel.org>; Wed, 26 Feb 2020 15:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0mw/rXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgBZPzA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:55:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55647 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728470AbgBZPzA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Feb 2020 10:55:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582732498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YtBCFit32zevDjrLbnfahzcFDYWTFvTQWzVmOmPXGi8=;
        b=i0mw/rXxjxIym1N8w35YDRQhc62zIeRJf2qyeu+WK0Yd0PJWKqLncSa8L/rLJrwRvFiUCq
        4doSP0vIWo8won+qxu0lDl5E5kTPqQNETKZ8eQ5mv+1+YL6JZ7JWFJRHxi6gx77MIPsbit
        oPx+AKa9QN/gCOFNn9itsikRYtnHUDc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-Yqy3U-CUNJ-AeliWy8Dqyg-1; Wed, 26 Feb 2020 10:54:56 -0500
X-MC-Unique: Yqy3U-CUNJ-AeliWy8Dqyg-1
Received: by mail-wr1-f71.google.com with SMTP id h4so1653522wrp.13
        for <selinux@vger.kernel.org>; Wed, 26 Feb 2020 07:54:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YtBCFit32zevDjrLbnfahzcFDYWTFvTQWzVmOmPXGi8=;
        b=nNVKPNu9LZ1urMhBvhKHyS3c1z8zfhB1qt1gygPjl9/SEa2BDOxlTNFcILjvNp7fZ8
         f58ZRiNweZh0F71vaDjJNC0YgWFU1FZ/P/M6kNY68UozVgAFP163KVKi4XHJRUZjgFfJ
         CFer3S+gQyQeghaQCgOvo4y7MIfUFoV7Pqw7YiBKo5YLdhhJXckROyGfLW25C4+3LWsk
         qmjjMX2oyxbjr9itK1K9vh8LVfIFuevY7aZrAsijbdhFibFb1rss75YUC4LOkJrFswu1
         MWwGyl19hqaWWmAoQqEfei0Na5/gCF7A7ocwkIyv8HZC7Hupz7I4SDaatuwXqrrmBTQY
         4MOw==
X-Gm-Message-State: APjAAAXId33LcDUk6JJqHDiWn0LECKIqx+11f38HWKG7J23BHERSY6d3
        j76Jm8++4eVHnYQdmx4Xelz7v/3vri3ln5ISbbFeMf6mfJxBk9OdDk/gHYyW9+PjIDVr6815UCk
        5MpYcVrOYfQmtrz9Zhw==
X-Received: by 2002:adf:ec50:: with SMTP id w16mr296935wrn.9.1582732495275;
        Wed, 26 Feb 2020 07:54:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqykWbT7fkMR8PHddoL9lPwHvuxDvsY8DgsTAC6l204injnMp+kJP+Di5dJrSR5jVX4VgyyChg==
X-Received: by 2002:adf:ec50:: with SMTP id w16mr296914wrn.9.1582732494933;
        Wed, 26 Feb 2020 07:54:54 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a9sm4000901wrn.3.2020.02.26.07.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 07:54:54 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH v3] selinux: reduce the use of hard-coded hash sizes
Date:   Wed, 26 Feb 2020 16:54:52 +0100
Message-Id: <20200226155452.301544-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Instead allocate hash tables with just the right size based on the
actual number of elements (which is almost always known beforehand, we
just need to defer the hashtab allocation to the right time). The only
case when we don't know the size (with the current policy format) is the
new filename transitions hashtable. Here I just left the existing value.

After this patch, the time to load Fedora policy on x86_64 decreases
from 790 ms to 167 ms. If the unconfined module is removed, it decreases
from 750 ms to 122 ms. It is also likely that other operations are going
to be faster, mainly string_to_context_struct() or mls_compute_sid(),
but I didn't try to quantify that.

The memory usage of all hash table arrays increases from ~58 KB to
~163 KB (with Fedora policy on x86_64).

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

Changed in v3:
 - switch to simpler and more logical hash size heuristic
 - add comment explaining the choice of the heuristic

Changed in v2:
 - guard against h->size == 0 in hashtab_search() and hashtab_insert()

 security/selinux/ss/hashtab.c  | 28 +++++++++++++++---
 security/selinux/ss/hashtab.h  |  2 +-
 security/selinux/ss/policydb.c | 53 +++++++++++++---------------------
 security/selinux/ss/policydb.h |  2 --
 4 files changed, 45 insertions(+), 40 deletions(-)

diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index ebfdaa31ee32..883f19d32c28 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -12,12 +12,29 @@
 
 static struct kmem_cache *hashtab_node_cachep;
 
+/*
+ * Here we simply round the number of elements up to the nearest power of two.
+ * I tried also other options like rouding down or rounding to the closest
+ * power of two (up or down based on which is closer), but I was unable to
+ * find any significant difference in lookup/insert performance that would
+ * justify switching to a different (less intuitive) formula. It could be that
+ * a different formula is actually more optimal, but any future changes here
+ * should be supported with performance/memory usage data.
+ *
+ * The total memory used by the htable arrays (only) with Fedora policy loaded
+ * is approximately 163 KB at the time of writing.
+ */
+static u32 hashtab_compute_size(u32 nel)
+{
+	return nel == 0 ? 0 : roundup_pow_of_two(nel);
+}
+
 struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *key),
 			       int (*keycmp)(struct hashtab *h, const void *key1, const void *key2),
-			       u32 size)
+			       u32 nel_hint)
 {
 	struct hashtab *p;
-	u32 i;
+	u32 i, size = hashtab_compute_size(nel_hint);
 
 	p = kzalloc(sizeof(*p), GFP_KERNEL);
 	if (!p)
@@ -27,6 +44,9 @@ struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *
 	p->nel = 0;
 	p->hash_value = hash_value;
 	p->keycmp = keycmp;
+	if (!size)
+		return p;
+
 	p->htable = kmalloc_array(size, sizeof(*p->htable), GFP_KERNEL);
 	if (!p->htable) {
 		kfree(p);
@@ -46,7 +66,7 @@ int hashtab_insert(struct hashtab *h, void *key, void *datum)
 
 	cond_resched();
 
-	if (!h || h->nel == HASHTAB_MAX_NODES)
+	if (!h || !h->size || h->nel == HASHTAB_MAX_NODES)
 		return -EINVAL;
 
 	hvalue = h->hash_value(h, key);
@@ -82,7 +102,7 @@ void *hashtab_search(struct hashtab *h, const void *key)
 	u32 hvalue;
 	struct hashtab_node *cur;
 
-	if (!h)
+	if (!h || !h->size)
 		return NULL;
 
 	hvalue = h->hash_value(h, key);
diff --git a/security/selinux/ss/hashtab.h b/security/selinux/ss/hashtab.h
index 3e3e42bfd150..dde54d9ff01c 100644
--- a/security/selinux/ss/hashtab.h
+++ b/security/selinux/ss/hashtab.h
@@ -42,7 +42,7 @@ struct hashtab_info {
  */
 struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *key),
 			       int (*keycmp)(struct hashtab *h, const void *key1, const void *key2),
-			       u32 size);
+			       u32 nel_hint);
 
 /*
  * Inserts the specified (key, datum) pair into the specified hash table.
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 32b3a8acf96f..7ca8c74efba3 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -56,17 +56,6 @@ static const char *symtab_name[SYM_NUM] = {
 };
 #endif
 
-static unsigned int symtab_sizes[SYM_NUM] = {
-	2,
-	32,
-	16,
-	512,
-	128,
-	16,
-	16,
-	16,
-};
-
 struct policydb_compat_info {
 	int version;
 	int sym_num;
@@ -478,20 +467,10 @@ static int policydb_init(struct policydb *p)
 
 	memset(p, 0, sizeof(*p));
 
-	for (i = 0; i < SYM_NUM; i++) {
-		rc = symtab_init(&p->symtab[i], symtab_sizes[i]);
-		if (rc)
-			goto out;
-	}
-
 	rc = avtab_init(&p->te_avtab);
 	if (rc)
 		goto out;
 
-	rc = roles_init(p);
-	if (rc)
-		goto out;
-
 	rc = cond_policydb_init(p);
 	if (rc)
 		goto out;
@@ -503,20 +482,12 @@ static int policydb_init(struct policydb *p)
 		goto out;
 	}
 
-	p->range_tr = hashtab_create(rangetr_hash, rangetr_cmp, 256);
-	if (!p->range_tr) {
-		rc = -ENOMEM;
-		goto out;
-	}
-
 	ebitmap_init(&p->filename_trans_ttypes);
 	ebitmap_init(&p->policycaps);
 	ebitmap_init(&p->permissive_map);
 
 	return 0;
 out:
-	hashtab_destroy(p->filename_trans);
-	hashtab_destroy(p->range_tr);
 	for (i = 0; i < SYM_NUM; i++) {
 		hashtab_map(p->symtab[i].table, destroy_f[i], NULL);
 		hashtab_destroy(p->symtab[i].table);
@@ -1142,12 +1113,12 @@ static int common_read(struct policydb *p, struct hashtab *h, void *fp)
 
 	len = le32_to_cpu(buf[0]);
 	comdatum->value = le32_to_cpu(buf[1]);
+	nel = le32_to_cpu(buf[3]);
 
-	rc = symtab_init(&comdatum->permissions, PERM_SYMTAB_SIZE);
+	rc = symtab_init(&comdatum->permissions, nel);
 	if (rc)
 		goto bad;
 	comdatum->permissions.nprim = le32_to_cpu(buf[2]);
-	nel = le32_to_cpu(buf[3]);
 
 	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
@@ -1308,12 +1279,12 @@ static int class_read(struct policydb *p, struct hashtab *h, void *fp)
 	len = le32_to_cpu(buf[0]);
 	len2 = le32_to_cpu(buf[1]);
 	cladatum->value = le32_to_cpu(buf[2]);
+	nel = le32_to_cpu(buf[4]);
 
-	rc = symtab_init(&cladatum->permissions, PERM_SYMTAB_SIZE);
+	rc = symtab_init(&cladatum->permissions, nel);
 	if (rc)
 		goto bad;
 	cladatum->permissions.nprim = le32_to_cpu(buf[3]);
-	nel = le32_to_cpu(buf[4]);
 
 	ncons = le32_to_cpu(buf[5]);
 
@@ -1826,6 +1797,11 @@ static int range_read(struct policydb *p, void *fp)
 		return rc;
 
 	nel = le32_to_cpu(buf[0]);
+
+	p->range_tr = hashtab_create(rangetr_hash, rangetr_cmp, nel);
+	if (!p->range_tr)
+		return -ENOMEM;
+
 	for (i = 0; i < nel; i++) {
 		rc = -ENOMEM;
 		rt = kzalloc(sizeof(*rt), GFP_KERNEL);
@@ -2418,6 +2394,17 @@ int policydb_read(struct policydb *p, void *fp)
 			goto bad;
 		nprim = le32_to_cpu(buf[0]);
 		nel = le32_to_cpu(buf[1]);
+
+		rc = symtab_init(&p->symtab[i], nel);
+		if (rc)
+			goto out;
+
+		if (i == SYM_ROLES) {
+			rc = roles_init(p);
+			if (rc)
+				goto out;
+		}
+
 		for (j = 0; j < nel; j++) {
 			rc = read_f[i](p, p->symtab[i].table, fp);
 			if (rc)
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index 41ad78a1f17b..72e2932fb12d 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -321,8 +321,6 @@ extern int policydb_role_isvalid(struct policydb *p, unsigned int role);
 extern int policydb_read(struct policydb *p, void *fp);
 extern int policydb_write(struct policydb *p, void *fp);
 
-#define PERM_SYMTAB_SIZE 32
-
 #define POLICYDB_CONFIG_MLS    1
 
 /* the config flags related to unknown classes/perms are bits 2 and 3 */
-- 
2.24.1

