Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDFDC4360C
	for <selinux@archiver.kernel.org>; Thu,  1 Apr 2021 18:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D975C610C7
	for <selinux@archiver.kernel.org>; Thu,  1 Apr 2021 18:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237187AbhDASDk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Apr 2021 14:03:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36574 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237455AbhDASAE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Apr 2021 14:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617300004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WciXP7WGatJunz8hP+XQIDpDEkLti4CoCq2onoLzwAg=;
        b=OWPyTvoFGGML9aAaKmL5CDHkngWucIKQpV5Kg2a010xtw1VLkcpkJsD/qyy3fJP95Gvch8
        3nrwNKPUXpq5j3rp0tomRcvfr4OenIJ6G2jVK+FRyLdb7TdgoGKXOAfct2Xj6/rKjHkmL9
        awj+2f3aK/UqA3NxjFEUOKZi9ugl2rE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-7hcQ9CbEMrWARvAOQZtylg-1; Thu, 01 Apr 2021 11:59:19 -0400
X-MC-Unique: 7hcQ9CbEMrWARvAOQZtylg-1
Received: by mail-ed1-f70.google.com with SMTP id t27so3066976edi.2
        for <selinux@vger.kernel.org>; Thu, 01 Apr 2021 08:59:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WciXP7WGatJunz8hP+XQIDpDEkLti4CoCq2onoLzwAg=;
        b=OxOTEIrtw54aHVxGg+PS2vNn61C+AYQY1letgourAh1wFKqhQPTjAMLeVIJQ5pRGXs
         VZdwExPcyXuKBA+2vNDccHPzFf0YJ6FQ9+R1etlq8x41ebVMPsenn1RdBCmZzsMDZ4WY
         N1D6hrqJlFzOpOSXAWju8I0MrIandEzNtYgguWxottYgzbTK1tvdB8W8awHLv5Rlazrw
         jC8MAMuzUSSaJP/dIPgvNT7sjq+ahoGSdL9TWyoiNmOXINEIVs0BNAPZ2oLNfODVjxGW
         66gP8Bjht3KPWBKSooHad4UV3P5WX+ZMnYRC+9QBW94gnnfwCJOY1MhxIXI6S7Fe7v0j
         BgUw==
X-Gm-Message-State: AOAM530umMP7Rn3RIVKs8vinh3jgcM0yspS0G7sUiXsM4hda2fnDf5iN
        kRK+OyPt2zabkVrnyx4IMIrkZDi/JiTD5FIOAICHZ3sLpDFmyw50MwzY0KMf8pQaqf8kGw6wEQR
        GjsbuVmfsDQFJyntDy3p35AQvgVcQgAu+1KXXyGsBTDoWO21sqEkVFJxUoNp3C2phBzzsag==
X-Received: by 2002:a17:907:98f5:: with SMTP id ke21mr9932576ejc.552.1617292757674;
        Thu, 01 Apr 2021 08:59:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzVvwnUHDvxYPxFO70slgTCRtYfLNDctRBFGnIpXzsBA51SbgCsJpnmCIYBk8X06AmawXRUw==
X-Received: by 2002:a17:907:98f5:: with SMTP id ke21mr9932559ejc.552.1617292757414;
        Thu, 01 Apr 2021 08:59:17 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id x4sm3537000edd.58.2021.04.01.08.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:59:17 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 2/2] selinux: fix cond_list corruption when changing booleans
Date:   Thu,  1 Apr 2021 17:59:13 +0200
Message-Id: <20210401155913.1693097-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210401155913.1693097-1-omosnace@redhat.com>
References: <20210401155913.1693097-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Currently, duplicate_policydb_cond_list() first copies the whole
conditional avtab and then tries to link to the correct entries in
cond_dup_av_list() using avtab_search(). However, since the conditional
avtab may contain multiple entries with the same key, this approach
often fails to find the right entry, potentially leading to wrong rules
being activated/deactivated when booleans are changed.

To fix this, instead start with an empty conditional avtab and add the
individual entries one-by-one while building the new av_lists. This
approach leads to the correct result, since each entry is present in the
av_lists exactly once.

The issue can be reproduced with Fedora policy as follows:

    # sesearch -s ftpd_t -t public_content_rw_t -c dir -p create -A
    allow ftpd_t non_security_file_type:dir { add_name create getattr ioctl link lock open read remove_name rename reparent rmdir search setattr unlink watch watch_reads write }; [ ftpd_full_access ]:True
    allow ftpd_t public_content_rw_t:dir { add_name create link remove_name rename reparent rmdir setattr unlink watch watch_reads write }; [ ftpd_anon_write ]:True
    # setsebool ftpd_anon_write=off ftpd_connect_all_unreserved=off ftpd_connect_db=off ftpd_full_access=off

On fixed kernels, the sesearch output is the same after the setsebool
command:

    # sesearch -s ftpd_t -t public_content_rw_t -c dir -p create -A
    allow ftpd_t non_security_file_type:dir { add_name create getattr ioctl link lock open read remove_name rename reparent rmdir search setattr unlink watch watch_reads write }; [ ftpd_full_access ]:True
    allow ftpd_t public_content_rw_t:dir { add_name create link remove_name rename reparent rmdir setattr unlink watch watch_reads write }; [ ftpd_anon_write ]:True

While on the broken kernels, it will be different:

    # sesearch -s ftpd_t -t public_content_rw_t -c dir -p create -A
    allow ftpd_t non_security_file_type:dir { add_name create getattr ioctl link lock open read remove_name rename reparent rmdir search setattr unlink watch watch_reads write }; [ ftpd_full_access ]:True
    allow ftpd_t non_security_file_type:dir { add_name create getattr ioctl link lock open read remove_name rename reparent rmdir search setattr unlink watch watch_reads write }; [ ftpd_full_access ]:True
    allow ftpd_t non_security_file_type:dir { add_name create getattr ioctl link lock open read remove_name rename reparent rmdir search setattr unlink watch watch_reads write }; [ ftpd_full_access ]:True

While there, also simplify the computation of nslots. This changes the
nslots values for nrules 2 or 3 to just two slots instead of 4, which
makes the sequence more consistent.

Fixes: c7c556f1e81b ("selinux: refactor changing booleans")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/avtab.c       | 88 +++++++++----------------------
 security/selinux/ss/avtab.h       |  2 +-
 security/selinux/ss/conditional.c | 12 ++---
 3 files changed, 33 insertions(+), 69 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 2aee4c965c25..f9d60010041e 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -308,24 +308,10 @@ void avtab_init(struct avtab *h)
 	h->mask = 0;
 }
 
-int avtab_alloc(struct avtab *h, u32 nrules)
+static int avtab_alloc_common(struct avtab *h, u32 nslot)
 {
-	u32 shift = 0;
-	u32 work = nrules;
-	u32 nslot;
-
-	if (nrules == 0)
-		goto avtab_alloc_out;
-
-	while (work) {
-		work  = work >> 1;
-		shift++;
-	}
-	if (shift > 2)
-		shift = shift - 2;
-	nslot = 1 << shift;
-	if (nslot > MAX_AVTAB_HASH_BUCKETS)
-		nslot = MAX_AVTAB_HASH_BUCKETS;
+	if (!nslot)
+		return 0;
 
 	h->htable = kvcalloc(nslot, sizeof(void *), GFP_KERNEL);
 	if (!h->htable)
@@ -333,59 +319,37 @@ int avtab_alloc(struct avtab *h, u32 nrules)
 
 	h->nslot = nslot;
 	h->mask = nslot - 1;
-
-avtab_alloc_out:
-	pr_debug("SELinux: %d avtab hash slots, %d rules.\n",
-	       h->nslot, nrules);
 	return 0;
 }
 
-int avtab_duplicate(struct avtab *new, struct avtab *orig)
+int avtab_alloc(struct avtab *h, u32 nrules)
 {
-	int i;
-	struct avtab_node *node, *tmp, *tail;
-
-	memset(new, 0, sizeof(*new));
-
-	new->htable = kvcalloc(orig->nslot, sizeof(void *), GFP_KERNEL);
-	if (!new->htable)
-		return -ENOMEM;
-	new->nslot = orig->nslot;
-	new->mask = orig->mask;
-
-	for (i = 0; i < orig->nslot; i++) {
-		tail = NULL;
-		for (node = orig->htable[i]; node; node = node->next) {
-			tmp = kmem_cache_zalloc(avtab_node_cachep, GFP_KERNEL);
-			if (!tmp)
-				goto error;
-			tmp->key = node->key;
-			if (tmp->key.specified & AVTAB_XPERMS) {
-				tmp->datum.u.xperms =
-					kmem_cache_zalloc(avtab_xperms_cachep,
-							GFP_KERNEL);
-				if (!tmp->datum.u.xperms) {
-					kmem_cache_free(avtab_node_cachep, tmp);
-					goto error;
-				}
-				tmp->datum.u.xperms = node->datum.u.xperms;
-			} else
-				tmp->datum.u.data = node->datum.u.data;
-
-			if (tail)
-				tail->next = tmp;
-			else
-				new->htable[i] = tmp;
-
-			tail = tmp;
-			new->nel++;
+	int rc;
+	u32 nslot = 0;
+
+	if (nrules != 0) {
+		u32 shift = 1;
+		u32 work = nrules >> 3;
+		while (work) {
+			work >>= 1;
+			shift++;
 		}
+		nslot = 1 << shift;
+		if (nslot > MAX_AVTAB_HASH_BUCKETS)
+			nslot = MAX_AVTAB_HASH_BUCKETS;
 	}
 
+	rc = avtab_alloc_common(h, nslot);
+	if (rc)
+		return rc;
+
+	pr_debug("SELinux: %d avtab hash slots, %d rules.\n", nslot, nrules);
 	return 0;
-error:
-	avtab_destroy(new);
-	return -ENOMEM;
+}
+
+int avtab_alloc_dup(struct avtab *new, const struct avtab *orig)
+{
+	return avtab_alloc_common(new, orig->nslot);
 }
 
 void avtab_hash_eval(struct avtab *h, char *tag)
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index 4c4445ca9118..f2eeb36265d1 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -89,7 +89,7 @@ struct avtab {
 
 void avtab_init(struct avtab *h);
 int avtab_alloc(struct avtab *, u32);
-int avtab_duplicate(struct avtab *new, struct avtab *orig);
+int avtab_alloc_dup(struct avtab *new, const struct avtab *orig);
 struct avtab_datum *avtab_search(struct avtab *h, struct avtab_key *k);
 void avtab_destroy(struct avtab *h);
 void avtab_hash_eval(struct avtab *h, char *tag);
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 0b32f3ab025e..1ef74c085f2b 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -605,7 +605,6 @@ static int cond_dup_av_list(struct cond_av_list *new,
 			struct cond_av_list *orig,
 			struct avtab *avtab)
 {
-	struct avtab_node *avnode;
 	u32 i;
 
 	memset(new, 0, sizeof(*new));
@@ -615,10 +614,11 @@ static int cond_dup_av_list(struct cond_av_list *new,
 		return -ENOMEM;
 
 	for (i = 0; i < orig->len; i++) {
-		avnode = avtab_search_node(avtab, &orig->nodes[i]->key);
-		if (WARN_ON(!avnode))
-			return -EINVAL;
-		new->nodes[i] = avnode;
+		new->nodes[i] = avtab_insert_nonunique(avtab,
+						       &orig->nodes[i]->key,
+						       &orig->nodes[i]->datum);
+		if (!new->nodes[i])
+			return -ENOMEM;
 		new->len++;
 	}
 
@@ -630,7 +630,7 @@ static int duplicate_policydb_cond_list(struct policydb *newp,
 {
 	int rc, i, j;
 
-	rc = avtab_duplicate(&newp->te_cond_avtab, &origp->te_cond_avtab);
+	rc = avtab_alloc_dup(&newp->te_cond_avtab, &origp->te_cond_avtab);
 	if (rc)
 		return rc;
 
-- 
2.30.2

