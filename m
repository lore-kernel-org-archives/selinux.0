Return-Path: <SRS0=OI58=4F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1630C35254
	for <selinux@archiver.kernel.org>; Mon, 17 Feb 2020 11:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEAF0206F4
	for <selinux@archiver.kernel.org>; Mon, 17 Feb 2020 11:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+e1j0zo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgBQLtv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Feb 2020 06:49:51 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26397 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgBQLtv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Feb 2020 06:49:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581940188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iXoHWA6D9wM/8NAAqFQYmrTwpC5D3yZJUy0yMju32k4=;
        b=R+e1j0zoIPpiYf29PpGXYYmL37yc+Ifo9lknuPJ/f5SDIwbA7Y0HNDhUZ2rDBgj4HfpGPX
        lWd3XSYaSFIEFP06Bg/NjAGfWBTrWi4Ub2Mzh7DPvwYMiUPOHh40p6P9DjS20jfw0xdwxw
        sk0awFN+FwJVNMCDDYTyMWXhayH5nzc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-QZN9B_ZpOk6bylBoUp9Bcg-1; Mon, 17 Feb 2020 06:49:47 -0500
X-MC-Unique: QZN9B_ZpOk6bylBoUp9Bcg-1
Received: by mail-wm1-f71.google.com with SMTP id t17so6122429wmi.7
        for <selinux@vger.kernel.org>; Mon, 17 Feb 2020 03:49:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iXoHWA6D9wM/8NAAqFQYmrTwpC5D3yZJUy0yMju32k4=;
        b=so9c2bQD11RZgJmwP+gnxeqZ3HdD2q9J65CS2yHcBrPeIG3pd3ysDiQ7icqcjnRFUK
         BqZ4ELwleFGi6HCfGgpHtj+X4mo/yQhz3K12dba4VNLCHZ6fmR7az/Ur75Yh/1c5Cl3d
         dFo0tqU4NSQ8GbV8iwBQVoIiurMNBIYyv59mbagch9syYfYAYg+ihLLl2AVQgqJYIDbJ
         uWcFVkOb2cMRIofjOt1vPcUiQZOLTE23ibmfR2v+7TSv2HiCsMMpJxIF3xtuTbEtIDV0
         s2vbIP8Qf9jNGEBedkTPHpOZh5pD0Ad3WmNdJOW7O5rmvbHZniAAOWvbPi+LgT84gE3/
         ok9A==
X-Gm-Message-State: APjAAAV4QDdZudbsUfS29S/YwzlmSfB4jyclKg7/NcoYLeKAbFDaa1J1
        heN1JJqmBp9S0JbQYAROa1KSxMpmkIVJfnckY7ESIIA0T8QzTozPz2xgGQKMdE41AAe6WgV7syM
        AmCuIjhZkGjK/ZotIRA==
X-Received: by 2002:a1c:a4c3:: with SMTP id n186mr21978877wme.25.1581940185554;
        Mon, 17 Feb 2020 03:49:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqxgQ3Hvro8OYzwlRTa4L6isSRJj7OEH6qI36Or7Kz5dvsl2W16FlUt9SfL4zj8bEVZ1mldXHg==
X-Received: by 2002:a1c:a4c3:: with SMTP id n186mr21978850wme.25.1581940185198;
        Mon, 17 Feb 2020 03:49:45 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id s8sm597256wrt.57.2020.02.17.03.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 03:49:44 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux: reduce the use of hard-coded hash sizes
Date:   Mon, 17 Feb 2020 12:49:43 +0100
Message-Id: <20200217114943.67607-1-omosnace@redhat.com>
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
from 950 ms to 220 ms. If the unconfined module is removed, it decreases
from 870 ms to 170 ms. It is also likely that other operations are going
to be faster, mainly string_to_context_struct() or mls_compute_sid(),
but I didn't try to quantify that.

The memory usage increases a bit after this patch, but only by ~1-2 MB
(it is hard to measure precisely). I believe it is a small price to pay
for the increased performance.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/hashtab.c  | 21 ++++++++++++--
 security/selinux/ss/hashtab.h  |  2 +-
 security/selinux/ss/policydb.c | 53 +++++++++++++---------------------
 security/selinux/ss/policydb.h |  2 --
 4 files changed, 40 insertions(+), 38 deletions(-)

diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index ebfdaa31ee32..554a91ef3f06 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -12,12 +12,26 @@
 
 static struct kmem_cache *hashtab_node_cachep;
 
+static u32 hashtab_compute_size(u32 nel)
+{
+	u32 size;
+
+	if (nel <= 2)
+		return nel;
+
+	/* use the nearest power of two to balance size and access time */
+	size = roundup_pow_of_two(nel);
+	if (size - nel > size / 4)
+		size /= 2;
+	return size;
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
@@ -27,6 +41,9 @@ struct hashtab *hashtab_create(u32 (*hash_value)(struct hashtab *h, const void *
 	p->nel = 0;
 	p->hash_value = hash_value;
 	p->keycmp = keycmp;
+	if (!size)
+		return p;
+
 	p->htable = kmalloc_array(size, sizeof(*p->htable), GFP_KERNEL);
 	if (!p->htable) {
 		kfree(p);
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
index 7bc791639d5b..b123cad55d66 100644
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
@@ -2419,6 +2395,17 @@ int policydb_read(struct policydb *p, void *fp)
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

