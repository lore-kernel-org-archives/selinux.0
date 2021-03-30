Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02323C433E0
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 13:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4E12619BD
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 13:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbhC3NRC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:17:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59087 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232134AbhC3NQ4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Mar 2021 09:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617110216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cgCviOM9iWG29JeybGODE4wzEs1gIDGTp3vx4pUISc8=;
        b=hBa+qySTgkVULqxZj7cW6XajXBbGwaga5dcj3L+umsBz13rY9B+pnUcv/mA5bhIqb/ix7u
        QdguDk0eOCCyoxIqDw7A1zglliUMVsr3kptgCyCtsvNYVQM9RC5WrYR6+ErO0aX6QWCUyr
        zGL2/12sOMKHNwXn9khx3auXXSvmusc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-512-c9g7y1VjPpqzCLDkSeEsOQ-1; Tue, 30 Mar 2021 09:16:54 -0400
X-MC-Unique: c9g7y1VjPpqzCLDkSeEsOQ-1
Received: by mail-ed1-f70.google.com with SMTP id i12so6806053edu.23
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 06:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cgCviOM9iWG29JeybGODE4wzEs1gIDGTp3vx4pUISc8=;
        b=ZtA5uhNN14p5oJP45LKUzutvOEvGG1F47qVA3xbmTpByAO/H2Q6jGCPLeo3fSCXD0V
         YLo4jB91JeKAeTW7xZE/x2XCEnq5tcxmZ7kG5NqTE7Wpkxpk//9vHKMKed/LQhhzT2s2
         Yr0B1JWBeZ1MWoGJL5lRsdTGA05BoJICLbWOUaXiD3MAaDu97OwBMng5Tr/6ejwS9B/L
         y14H/f1Yo58rgQajRDaksB00rsya1IrmQVxj+P6TTOpdVjVlCUbsdnt2lej5sqxu7bE0
         KF9xyfRmYipDAizqcepqy4N/pvn+6NhJlGq69b2AL3SBJYp0k9WWGflaq2cSZtYB1vzF
         qwXg==
X-Gm-Message-State: AOAM533ejBWeljRHqC3HFu25ks7buT5N/UpMOSDge8CYN8kd6EEh29X/
        ASWoJ2HYvcGH5Yre1Ugw91OoubvTUXUXhZ08li20wtCElKeXIyACtcuZv0Bg1EIzGLZQxtuVHK/
        YVIPKnhVOugM+wPAnJqk13QHgLbT44pqFS09Z4vgCW8bG7xFpsiJIEGVo1HhuTH+t5B7m2Q==
X-Received: by 2002:a05:6402:30bb:: with SMTP id df27mr16228002edb.147.1617110212980;
        Tue, 30 Mar 2021 06:16:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNL4+qLDVJhPotzB4P/xQmzVS9ATqc40ihX8I6PwTSOQZeyp7yhrRJ1HdAlDjglpVns5jkxA==
X-Received: by 2002:a05:6402:30bb:: with SMTP id df27mr16227977edb.147.1617110212768;
        Tue, 30 Mar 2021 06:16:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id u16sm11178245edq.4.2021.03.30.06.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:16:52 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 3/3] selinux: constify some avtab function arguments
Date:   Tue, 30 Mar 2021 15:16:46 +0200
Message-Id: <20210330131646.1401838-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330131646.1401838-1-omosnace@redhat.com>
References: <20210330131646.1401838-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This makes the code a bit easier to reason about.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/avtab.c       | 28 +++++++++++++++-------------
 security/selinux/ss/avtab.h       | 16 +++++++++-------
 security/selinux/ss/conditional.c |  3 ++-
 3 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 11f8f524de98..f6f09bb8116a 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -29,7 +29,7 @@ static struct kmem_cache *avtab_xperms_cachep __ro_after_init;
 /* Based on MurmurHash3, written by Austin Appleby and placed in the
  * public domain.
  */
-static inline int avtab_hash(struct avtab_key *keyp, u32 mask)
+static inline int avtab_hash(const struct avtab_key *keyp, u32 mask)
 {
 	static const u32 c1 = 0xcc9e2d51;
 	static const u32 c2 = 0x1b873593;
@@ -68,7 +68,7 @@ static inline int avtab_hash(struct avtab_key *keyp, u32 mask)
 static struct avtab_node*
 avtab_insert_node(struct avtab *h, int hvalue,
 		  struct avtab_node *prev, struct avtab_node *cur,
-		  struct avtab_key *key, struct avtab_datum *datum)
+		  const struct avtab_key *key, const struct avtab_datum *datum)
 {
 	struct avtab_node *newnode;
 	struct avtab_extended_perms *xperms;
@@ -103,7 +103,8 @@ avtab_insert_node(struct avtab *h, int hvalue,
 	return newnode;
 }
 
-static int avtab_insert(struct avtab *h, struct avtab_key *key, struct avtab_datum *datum)
+static int avtab_insert(struct avtab *h, const struct avtab_key *key,
+			const struct avtab_datum *datum)
 {
 	int hvalue;
 	struct avtab_node *prev, *cur, *newnode;
@@ -147,8 +148,9 @@ static int avtab_insert(struct avtab *h, struct avtab_key *key, struct avtab_dat
  * key/specified mask into the table, as needed by the conditional avtab.
  * It also returns a pointer to the node inserted.
  */
-struct avtab_node *
-avtab_insert_nonunique(struct avtab *h, struct avtab_key *key, struct avtab_datum *datum)
+struct avtab_node *avtab_insert_nonunique(struct avtab *h,
+					  const struct avtab_key *key,
+					  const struct avtab_datum *datum)
 {
 	int hvalue;
 	struct avtab_node *prev, *cur;
@@ -178,7 +180,7 @@ avtab_insert_nonunique(struct avtab *h, struct avtab_key *key, struct avtab_datu
 	return avtab_insert_node(h, hvalue, prev, cur, key, datum);
 }
 
-struct avtab_datum *avtab_search(struct avtab *h, struct avtab_key *key)
+struct avtab_datum *avtab_search(struct avtab *h, const struct avtab_key *key)
 {
 	int hvalue;
 	struct avtab_node *cur;
@@ -213,8 +215,8 @@ struct avtab_datum *avtab_search(struct avtab *h, struct avtab_key *key)
 /* This search function returns a node pointer, and can be used in
  * conjunction with avtab_search_next_node()
  */
-struct avtab_node*
-avtab_search_node(struct avtab *h, struct avtab_key *key)
+struct avtab_node *avtab_search_node(struct avtab *h,
+				     const struct avtab_key *key)
 {
 	int hvalue;
 	struct avtab_node *cur;
@@ -393,8 +395,8 @@ static uint16_t spec_order[] = {
 };
 
 int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
-		    int (*insertf)(struct avtab *a, struct avtab_key *k,
-				   struct avtab_datum *d, void *p),
+		    int (*insertf)(struct avtab *a, const struct avtab_key *k,
+				   const struct avtab_datum *d, void *p),
 		    void *p)
 {
 	__le16 buf16[4];
@@ -554,8 +556,8 @@ int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
 	return insertf(a, &key, &datum, p);
 }
 
-static int avtab_insertf(struct avtab *a, struct avtab_key *k,
-			 struct avtab_datum *d, void *p)
+static int avtab_insertf(struct avtab *a, const struct avtab_key *k,
+			 const struct avtab_datum *d, void *p)
 {
 	return avtab_insert(a, k, d);
 }
@@ -604,7 +606,7 @@ bad:
 	goto out;
 }
 
-int avtab_write_item(struct policydb *p, struct avtab_node *cur, void *fp)
+int avtab_write_item(struct policydb *p, const struct avtab_node *cur, void *fp)
 {
 	__le16 buf16[4];
 	__le32 buf32[ARRAY_SIZE(cur->datum.u.xperms->perms.p)];
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index f2eeb36265d1..d3ebea8d146f 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -90,24 +90,26 @@ struct avtab {
 void avtab_init(struct avtab *h);
 int avtab_alloc(struct avtab *, u32);
 int avtab_alloc_dup(struct avtab *new, const struct avtab *orig);
-struct avtab_datum *avtab_search(struct avtab *h, struct avtab_key *k);
+struct avtab_datum *avtab_search(struct avtab *h, const struct avtab_key *k);
 void avtab_destroy(struct avtab *h);
 void avtab_hash_eval(struct avtab *h, char *tag);
 
 struct policydb;
 int avtab_read_item(struct avtab *a, void *fp, struct policydb *pol,
-		    int (*insert)(struct avtab *a, struct avtab_key *k,
-				  struct avtab_datum *d, void *p),
+		    int (*insert)(struct avtab *a, const struct avtab_key *k,
+				  const struct avtab_datum *d, void *p),
 		    void *p);
 
 int avtab_read(struct avtab *a, void *fp, struct policydb *pol);
-int avtab_write_item(struct policydb *p, struct avtab_node *cur, void *fp);
+int avtab_write_item(struct policydb *p, const struct avtab_node *cur, void *fp);
 int avtab_write(struct policydb *p, struct avtab *a, void *fp);
 
-struct avtab_node *avtab_insert_nonunique(struct avtab *h, struct avtab_key *key,
-					  struct avtab_datum *datum);
+struct avtab_node *avtab_insert_nonunique(struct avtab *h,
+					  const struct avtab_key *key,
+					  const struct avtab_datum *datum);
 
-struct avtab_node *avtab_search_node(struct avtab *h, struct avtab_key *key);
+struct avtab_node *avtab_search_node(struct avtab *h,
+				     const struct avtab_key *key);
 
 struct avtab_node *avtab_search_node_next(struct avtab_node *node, int specified);
 
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index f6dfa9c821d6..2ec6e5cd25d9 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -254,7 +254,8 @@ struct cond_insertf_data {
 	struct cond_av_list *other;
 };
 
-static int cond_insertf(struct avtab *a, struct avtab_key *k, struct avtab_datum *d, void *ptr)
+static int cond_insertf(struct avtab *a, const struct avtab_key *k,
+			const struct avtab_datum *d, void *ptr)
 {
 	struct cond_insertf_data *data = ptr;
 	struct policydb *p = data->p;
-- 
2.30.2

