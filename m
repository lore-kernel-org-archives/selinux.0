Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E6BC433C1
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 13:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8396F61969
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 13:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhC3NRB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:17:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36936 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232119AbhC3NQy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Mar 2021 09:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617110214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K7XcRY5QAtM+y7zJAE5m+E8fGUGxe1uqwiXVWbv4u/w=;
        b=CnqI30mRgSYdCYSUnpYys0MwVtCv7/OU9M/d7SfmYl5Iq4PwlOUOiXxI0H3hdSokrRXEJ7
        Z4g4iEw6ZEvVAGaCOOMU6KlC4jBsmfbmwX68Yg42XzSkCXeOwfOBoMvUUcq+lUpzumS97u
        Xrdtao0YA0aNbP08+kagtSmk6lHpffk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-66-oes3AwNCPO-foNqgMiyG9Q-1; Tue, 30 Mar 2021 09:16:51 -0400
X-MC-Unique: oes3AwNCPO-foNqgMiyG9Q-1
Received: by mail-ej1-f71.google.com with SMTP id d6so7127259ejd.15
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 06:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K7XcRY5QAtM+y7zJAE5m+E8fGUGxe1uqwiXVWbv4u/w=;
        b=ppVTwT6Pfr28nMQoYliozS4fT+USzYUbzUWeYLnkzdogmcnwp17H3NVEFxD7skcG50
         yRX7688JF9Bq/5lKUgptOjtJfoxPyc+ViB+s0tZmnY7TpDPuSUb+proZ9kopnMZ6JGtE
         qU4t3u9MN4Pem1I9fIjYAHeF7AWAra++hduT2BT47+hnERnKjegumSQLwvMBsVf9x68C
         OkHor4TJtzn9q+XYR8PRQnP1tBicG2ni9AdyerXuyzlz1L8GqIVcodMsBY/Jgd5e48dS
         SMP63ptwkOZCWWBZrZT/Kd2qCAKBUUwOLMRlpPhVmaKkR4O+l3dqeO5b+Q1ATp5sVr/V
         ITQw==
X-Gm-Message-State: AOAM530IDPZL5NiQxleoGv6USm8lZmu3NwQ8U72ubODp9uCxzNO9MOHW
        Cf3Kx+6m8OvDoxDRfs9a3RWomptwEGGyTWRsfADP3vguF+1SojMVUk9KWerKnp1SAomOjjoP+vJ
        sBWYlYyaCeAq+3jjpk0ZUOiwGpIxeNJAV1W8kAxlp5RG+pnz2gfggqBdtbNFpbJQxlr3cLg==
X-Received: by 2002:a17:906:4e57:: with SMTP id g23mr33201924ejw.47.1617110210012;
        Tue, 30 Mar 2021 06:16:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz114D5KBci8LXhPcLe80INnY6Y1JpZ3p2WYdcsUbDU3ws1i29FUJm//zP+I8OZnRKTm+bR0g==
X-Received: by 2002:a17:906:4e57:: with SMTP id g23mr33201905ejw.47.1617110209762;
        Tue, 30 Mar 2021 06:16:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id u16sm11178245edq.4.2021.03.30.06.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:16:49 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/3] selinux: fix cond_list corruption when changing booleans
Date:   Tue, 30 Mar 2021 15:16:44 +0200
Message-Id: <20210330131646.1401838-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330131646.1401838-1-omosnace@redhat.com>
References: <20210330131646.1401838-1-omosnace@redhat.com>
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

Fixes: c7c556f1e81b ("selinux: refactor changing booleans")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/avtab.c       | 90 +++++++++----------------------
 security/selinux/ss/avtab.h       |  2 +-
 security/selinux/ss/conditional.c | 12 ++---
 3 files changed, 33 insertions(+), 71 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 6dcb6aa4db7f..11f8f524de98 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -305,86 +305,48 @@ void avtab_init(struct avtab *h)
 	h->nel = 0;
 }
 
-int avtab_alloc(struct avtab *h, u32 nrules)
+static int avtab_alloc_common(struct avtab *h, u32 nslot)
 {
-	u32 mask = 0;
-	u32 shift = 0;
-	u32 work = nrules;
-	u32 nslot = 0;
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
-	mask = nslot - 1;
-
 	h->htable = kvcalloc(nslot, sizeof(void *), GFP_KERNEL);
 	if (!h->htable)
 		return -ENOMEM;
 
- avtab_alloc_out:
 	h->nel = 0;
 	h->nslot = nslot;
-	h->mask = mask;
-	pr_debug("SELinux: %d avtab hash slots, %d rules.\n",
-	       h->nslot, nrules);
+	h->mask = nslot - 1;
 	return 0;
 }
 
-int avtab_duplicate(struct avtab *new, struct avtab *orig)
+int avtab_alloc(struct avtab *h, u32 nrules)
 {
-	int i;
-	struct avtab_node *node, *tmp, *tail;
-
-	memset(new, 0, sizeof(*new));
+	int rc;
+	u32 shift = 0;
+	u32 work = nrules;
+	u32 nslot = 0;
 
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
+	if (nrules != 0) {
+		while (work) {
+			work  = work >> 1;
+			shift++;
 		}
+		if (shift > 2)
+			shift = shift - 2;
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

