Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE819C0018A
	for <selinux@archiver.kernel.org>; Thu,  2 Nov 2023 15:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376854AbjKBPqE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Nov 2023 11:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376921AbjKBPp4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Nov 2023 11:45:56 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A74FB
        for <selinux@vger.kernel.org>; Thu,  2 Nov 2023 08:45:53 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-778927f2dd3so57474785a.2
        for <selinux@vger.kernel.org>; Thu, 02 Nov 2023 08:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698939951; x=1699544751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZcs9v+NlAPWID8sUF9D2iOwEy3ifPGCjskfmBqX9Jk=;
        b=FmfPDo1wLh/qDT0Qf1CaFikYD+PK6f1Sz75HjAsTZ4A3Lzs4PzWmTz/kFO4Z1tEVtP
         6AjLWeI5UhJ1lSohJjBVNeMrsR4CJLdEPNP21vi8EW4sNYHUbRw6GQ8OxeGxL7Zn+yTA
         /6EBc6bS5+pgeID+LMAXwLQSy3L6hCfuTY2Ik/gRczJpVmKpYuiPMjY7Qi9awJrhuLYf
         3KaJA1P/TPKN8PIKZOVLFfw0pSMovt4ec4I6xt1R3KxJuWVf5InUK8rdbERnIHjliSoG
         kdpP6gV2/xCniafluUeuNndncQbgUt5JDKnoKCM9+JgCv6s4obXnUwO8NLSOYPoAhrz9
         ggeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698939951; x=1699544751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZcs9v+NlAPWID8sUF9D2iOwEy3ifPGCjskfmBqX9Jk=;
        b=Zzsvrmv9KIIY/7l9aho2ANovT41xJHwEzaCp4gSi3sO+sacr5gDfQnfliuEcvgr7q+
         zRdnw5cH+/VGFTobWlAylRAig4QL20AG0dNa7eKiwnn/DtRsYkAPASt9jXuWdg5Nw5G+
         dmmW7S/vHjHP/LlxlYr+SZaXcyDWuODFTB3G2lJqKevC++gBtbBOMvyCgaczrrMGP127
         ximuwfAwIQkD2bEtJXT0Eg4pu5IXW1R2tZaZTjZLZgIYxi9gO8qWAVuEmjZX/Gggyv2T
         P65J1stMz52o0HKu3UFfbTTmIX88JfvvhFI/DlYcmZG0EO91aUe5j5k4NnaL5pBJkbAs
         fv1w==
X-Gm-Message-State: AOJu0YzwWMCsSqy/yjo/89EFQuH/7e3IcQepCzae3cbuCIuqHZ96gqBc
        /KXsnNSfVtQlJJY4mPNGDKl55TroHRA=
X-Google-Smtp-Source: AGHT+IGywy4sGt475/V9Yz0SC4y4w0Iziy5JzNiAnIYgepY8oKMHrGlPXnWXpav54fYZ9W1HLYptVA==
X-Received: by 2002:a05:620a:3cf:b0:775:be7b:d9db with SMTP id r15-20020a05620a03cf00b00775be7bd9dbmr17122859qkm.37.1698939951493;
        Thu, 02 Nov 2023 08:45:51 -0700 (PDT)
Received: from ip-10-113-85-151.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id l1-20020a05620a210100b0076e1e2d6496sm37691qkl.104.2023.11.02.08.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 08:45:49 -0700 (PDT)
From:   Jacob Satterfield <jsatterfield.linux@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Jacob Satterfield <jsatterfield.linux@gmail.com>,
        stephen.smalley.work@gmail.com, paul@paul-moore.com,
        omosnace@redhat.com
Subject: [PATCH v4 3/3] selinux: use arrays for avtab hashtable nodes
Date:   Thu,  2 Nov 2023 15:45:24 +0000
Message-Id: <20231102154524.12006-4-jsatterfield.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102154524.12006-1-jsatterfield.linux@gmail.com>
References: <20231102154524.12006-1-jsatterfield.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The current avtab hashtable employs a separate chaining collision
resolution strategy where each bucket/chain holds an ordered linked list
of pointers to kmem_cache allocated avtab_node elements.

On Fedora 38 (x86_64) using the default policy, avtab_node_cachep
uses 573 slabs each containing 170 objects totaling 2,337,840 bytes.
A call to kmem_cache_zalloc() is required for every single rule, which
in the default policy is currently 96,730 and continually rising.

When both sets of avtab_node (regular and cond.) are turned into arrays
with the hash table chain heads pointing into it, this results in only
two additional kvcalloc() calls and the complete removal of the
kmem_cache itself and its memory and runtime overheads.

Running "perf stat -r 100 -d load_policy" has shown a runtime reduction
of around 10% on a Fedora 38 x86_64 VM with this single patch. Future
patches focused on improving the hash table's collision resolution
strategy and array layout (struct-of-arrays vs. array-of-structs) may
elicit even more caching and therefore runtime performance improvements.

To prevent the conditional table from under-allocating the avtab_node
array, which creates a heap-overflow bug, the two-pass algorithm in the
patch "selinux: fix conditional avtab slot hint" is required.

Signed-off-by: Jacob Satterfield <jsatterfield.linux@gmail.com>
---
 security/selinux/ss/avtab.c | 36 ++++++++++++++++++++----------------
 security/selinux/ss/avtab.h |  2 ++
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index f437bd588b04..50c8db8eb511 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -24,7 +24,6 @@
 #include "avtab.h"
 #include "policydb.h"
 
-static struct kmem_cache *avtab_node_cachep __ro_after_init;
 static struct kmem_cache *avtab_xperms_cachep __ro_after_init;
 
 #define avtab_chain_for_each(pos, tab, slot) \
@@ -79,17 +78,15 @@ avtab_insert_node(struct avtab *h, struct avtab_node **dst,
 {
 	struct avtab_node *newnode;
 	struct avtab_extended_perms *xperms;
-	newnode = kmem_cache_zalloc(avtab_node_cachep, GFP_KERNEL);
-	if (newnode == NULL)
+	if (h->nel == h->nnodes)
 		return NULL;
+	newnode = &h->nodes[h->nel];
 	newnode->key = *key;
 
 	if (key->specified & AVTAB_XPERMS) {
 		xperms = kmem_cache_zalloc(avtab_xperms_cachep, GFP_KERNEL);
-		if (xperms == NULL) {
-			kmem_cache_free(avtab_node_cachep, newnode);
+		if (xperms == NULL)
 			return NULL;
-		}
 		*xperms = *(datum->u.xperms);
 		newnode->datum.u.xperms = xperms;
 	} else {
@@ -225,7 +222,7 @@ void avtab_destroy(struct avtab *h)
 	u32 i;
 	struct avtab_node *cur, *temp;
 
-	if (!h)
+	if (!h || !h->htable)
 		return;
 
 	for (i = 0; i < h->nslot; i++) {
@@ -236,11 +233,13 @@ void avtab_destroy(struct avtab *h)
 			if (temp->key.specified & AVTAB_XPERMS)
 				kmem_cache_free(avtab_xperms_cachep,
 						temp->datum.u.xperms);
-			kmem_cache_free(avtab_node_cachep, temp);
 		}
 	}
 	kvfree(h->htable);
+	kvfree(h->nodes);
 	h->htable = NULL;
+	h->nodes = NULL;
+	h->nnodes = 0;
 	h->nel = 0;
 	h->nslot = 0;
 	h->mask = 0;
@@ -249,20 +248,28 @@ void avtab_destroy(struct avtab *h)
 void avtab_init(struct avtab *h)
 {
 	h->htable = NULL;
+	h->nodes = NULL;
+	h->nnodes = 0;
 	h->nel = 0;
 	h->nslot = 0;
 	h->mask = 0;
 }
 
-static int avtab_alloc_common(struct avtab *h, u32 nslot)
+static int avtab_alloc_common(struct avtab *h, u32 nslot, u32 nrules)
 {
 	if (!nslot)
 		return 0;
 
-	h->htable = kvcalloc(nslot, sizeof(void *), GFP_KERNEL);
+	h->htable = kvcalloc(nslot, sizeof(*h->htable), GFP_KERNEL);
 	if (!h->htable)
 		return -ENOMEM;
-
+	h->nodes = kvcalloc(nrules, sizeof(*h->nodes), GFP_KERNEL);
+	if (!h->nodes) {
+		kvfree(h->htable);
+		h->htable = NULL;
+		return -ENOMEM;
+	}
+	h->nnodes = nrules;
 	h->nslot = nslot;
 	h->mask = nslot - 1;
 	return 0;
@@ -278,7 +285,7 @@ int avtab_alloc(struct avtab *h, u32 nrules)
 		if (nslot > MAX_AVTAB_HASH_BUCKETS)
 			nslot = MAX_AVTAB_HASH_BUCKETS;
 
-		rc = avtab_alloc_common(h, nslot);
+		rc = avtab_alloc_common(h, nslot, nrules);
 		if (rc)
 			return rc;
 	}
@@ -289,7 +296,7 @@ int avtab_alloc(struct avtab *h, u32 nrules)
 
 int avtab_alloc_dup(struct avtab *new, const struct avtab *orig)
 {
-	return avtab_alloc_common(new, orig->nslot);
+	return avtab_alloc_common(new, orig->nslot, orig->nel);
 }
 
 #ifdef CONFIG_SECURITY_SELINUX_DEBUG
@@ -614,9 +621,6 @@ int avtab_write(struct policydb *p, struct avtab *a, void *fp)
 
 void __init avtab_cache_init(void)
 {
-	avtab_node_cachep = kmem_cache_create("avtab_node",
-					      sizeof(struct avtab_node),
-					      0, SLAB_PANIC, NULL);
 	avtab_xperms_cachep = kmem_cache_create("avtab_extended_perms",
 						sizeof(struct avtab_extended_perms),
 						0, SLAB_PANIC, NULL);
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index 86fb6f793eec..5e465be6f057 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -82,6 +82,8 @@ struct avtab_node {
 
 struct avtab {
 	struct avtab_node **htable;
+	struct avtab_node *nodes;
+	u32 nnodes;	/* number of nodes */
 	u32 nel;	/* number of elements */
 	u32 nslot;      /* number of hash slots */
 	u32 mask;       /* mask to compute hash func */
-- 
2.34.1

