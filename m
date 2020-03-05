Return-Path: <SRS0=pcXh=4W=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03086C3F2D2
	for <selinux@archiver.kernel.org>; Thu,  5 Mar 2020 20:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0ED2072D
	for <selinux@archiver.kernel.org>; Thu,  5 Mar 2020 20:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="lyCyOKt1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgCEUEh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Mar 2020 15:04:37 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43669 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgCEUEh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Mar 2020 15:04:37 -0500
Received: by mail-qk1-f196.google.com with SMTP id q18so43757qki.10
        for <selinux@vger.kernel.org>; Thu, 05 Mar 2020 12:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=WJl1RPERLVyAE/YfcGJJNsOwtunUZGbDAVW0hGcnkkg=;
        b=lyCyOKt139JuSfCKVxB79SO2lcMemh+KnX3mNKnJqhZZReOoapXBqMKpImSUNiEE3h
         cyxAdbxVQaG81pm/P0RPz5bBwVO9CTP0g7MLRkDtlZYuu2ja7+w4VnzOuxBFNwcrDf9w
         pqPYjn3/c9oR6UrS8SP6hMmgfgJq4KPr8HlI7cELqyZnx2cWSqWEcF/PeGnsS2oUSGru
         +nMrH4u9b2cjGHAY86MUtuqogrsdFB06064f11t17XrHXtbsogNn3eR9BtTkx7TJdmbg
         jhQ/WETUCfBbiRN8xmYHAdmQhPlNq9T96fckwNxm+q8IL28leQbAlojh7gNyZYXEtEYO
         41iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=WJl1RPERLVyAE/YfcGJJNsOwtunUZGbDAVW0hGcnkkg=;
        b=MgavuKB2mkDrPnYxRf60Le72jTkserXx/OK4q6ZMc6gpwaYDFl6hS4n92RMSg9tW10
         u3V6jPDFUXSi7Mf9PxsYBEO2lfDndQ0Gzs2TwK3r+Owm1gQlPyG+GPOLUu046aORYemO
         IKc089kkhfagwKUC92PPXAi2gHJIlzV4XQMuZbJOnCRWlkDmTSZzQsfhNuXDUkU8hDYD
         aQ80zr6pzEemfLxNuKRl3yphcs2DWXH0r/23C+FbBeRIpoSk5qxB4yxg2xdnGWoVMtFy
         UqXu8PYsPAwYxf6P73ZGox4O2Hx9ByjzHeoXIlrT97n24H24HCewSEAs3/QcghWCg78Y
         dfpQ==
X-Gm-Message-State: ANhLgQ2OErhH+QFGT4BsV/RA09FWaSHncJGqXDkNSCfkDJ2xhVaCxuJy
        0XUrmUAr0Tx3r9HxcwUEKJ9E8F4Saw==
X-Google-Smtp-Source: ADFU+vsR7iFAOVtuXqCrAutiJNG44+eXMtN4rNc9LT5wxXAp9nOUPFgEcSb5KqMya86WOllmzuEkhg==
X-Received: by 2002:a05:620a:22b0:: with SMTP id p16mr9215703qkh.468.1583438674497;
        Thu, 05 Mar 2020 12:04:34 -0800 (PST)
Received: from localhost (pool-71-245-238-133.bstnma.fios.verizon.net. [71.245.238.133])
        by smtp.gmail.com with ESMTPSA id g22sm1494623qtp.8.2020.03.05.12.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 12:04:33 -0800 (PST)
Subject: [PATCH] selinux: avtab_init() and cond_policydb_init() return void
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Date:   Thu, 05 Mar 2020 15:04:33 -0500
Message-ID: <158343867316.158870.5386750405980710812.stgit@chester>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The avtab_init() and cond_policydb_init() functions always return
zero so mark them as returning void and update the callers not to
check for a return value.

Suggested-by: Ondrej Mosnacek <omosnace@redhat.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/ss/avtab.c       |    3 +--
 security/selinux/ss/avtab.h       |    2 +-
 security/selinux/ss/conditional.c |   10 ++--------
 security/selinux/ss/conditional.h |    2 +-
 security/selinux/ss/policydb.c    |   11 ++---------
 5 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/security/selinux/ss/avtab.c b/security/selinux/ss/avtab.c
index 8c5800750fa8..01b300a4a882 100644
--- a/security/selinux/ss/avtab.c
+++ b/security/selinux/ss/avtab.c
@@ -299,12 +299,11 @@ void avtab_destroy(struct avtab *h)
 	h->mask = 0;
 }
 
-int avtab_init(struct avtab *h)
+void avtab_init(struct avtab *h)
 {
 	kvfree(h->htable);
 	h->htable = NULL;
 	h->nel = 0;
-	return 0;
 }
 
 int avtab_alloc(struct avtab *h, u32 nrules)
diff --git a/security/selinux/ss/avtab.h b/security/selinux/ss/avtab.h
index 837e938798ef..5fdcb6696bcc 100644
--- a/security/selinux/ss/avtab.h
+++ b/security/selinux/ss/avtab.h
@@ -87,7 +87,7 @@ struct avtab {
 	u32 mask;       /* mask to compute hash func */
 };
 
-int avtab_init(struct avtab *);
+void avtab_init(struct avtab *h);
 int avtab_alloc(struct avtab *, u32);
 struct avtab_datum *avtab_search(struct avtab *h, struct avtab_key *k);
 void avtab_destroy(struct avtab *h);
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index cce4a75fb3e7..939a74fd8fb4 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -125,19 +125,13 @@ void evaluate_cond_nodes(struct policydb *p)
 		evaluate_cond_node(p, &p->cond_list[i]);
 }
 
-int cond_policydb_init(struct policydb *p)
+void cond_policydb_init(struct policydb *p)
 {
-	int rc;
-
 	p->bool_val_to_struct = NULL;
 	p->cond_list = NULL;
 	p->cond_list_len = 0;
 
-	rc = avtab_init(&p->te_cond_avtab);
-	if (rc)
-		return rc;
-
-	return 0;
+	avtab_init(&p->te_cond_avtab);
 }
 
 static void cond_node_destroy(struct cond_node *node)
diff --git a/security/selinux/ss/conditional.h b/security/selinux/ss/conditional.h
index b9eb888ffa76..90c9c964f5f5 100644
--- a/security/selinux/ss/conditional.h
+++ b/security/selinux/ss/conditional.h
@@ -61,7 +61,7 @@ struct cond_node {
 	struct cond_av_list false_list;
 };
 
-int cond_policydb_init(struct policydb *p);
+void cond_policydb_init(struct policydb *p);
 void cond_policydb_destroy(struct policydb *p);
 
 int cond_init_bool_indexes(struct policydb *p);
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 00edcd216aaa..932b2b9bcdb2 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -463,17 +463,10 @@ static int rangetr_cmp(struct hashtab *h, const void *k1, const void *k2)
  */
 static int policydb_init(struct policydb *p)
 {
-	int rc;
-
 	memset(p, 0, sizeof(*p));
 
-	rc = avtab_init(&p->te_avtab);
-	if (rc)
-		return rc;
-
-	rc = cond_policydb_init(p);
-	if (rc)
-		return rc;
+	avtab_init(&p->te_avtab);
+	cond_policydb_init(p);
 
 	p->filename_trans = hashtab_create(filenametr_hash, filenametr_cmp,
 					   (1 << 11));

