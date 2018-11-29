Return-Path: <SRS0=qOBY=OI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8CFC43441
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 12:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986642081C
	for <selinux@archiver.kernel.org>; Thu, 29 Nov 2018 12:56:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 986642081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbeK3ACD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:02:03 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53178 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbeK3ACD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 29 Nov 2018 19:02:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id r11-v6so2156342wmb.2
        for <selinux@vger.kernel.org>; Thu, 29 Nov 2018 04:56:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E3yxnHF1CF4bQZPwk3MGsSJBhd+eAZaGZYnlCfuHJ/8=;
        b=Dafti+rMeOlHSkx0S58TH+RFbQ9CT5A9iMKBth5DL9/r/9tsbStK4mxL9l86oMrs8p
         FPsbYuLL7gT73ec16YiGjoG5INAg5HhmpUlM7Oen8A0xG0TY3z3XSJZZo8KQWxOqa0Du
         USxpfBSVfDjlsK5UioRvj6CkHmp/GqL/2PKOx99d9FqtE7tDnw4Gt7NpjnBG0K0uhjyY
         O30yGwe6s17BSGBAAy5cG+Bs3dInOsRVsOBTWzImGemewayJJ3XH2Us2gzGswn0VWFTd
         kRR0FL3WVKGAUDyMXHtBORZKHlidaRyeKlOR+RnNqI5HLRiE1+jEgH7nM8Bz3H6332ex
         YZGA==
X-Gm-Message-State: AA+aEWYNK4XC/eDpOb6ex4Oz3mwFgU/e0dMRLsPkU6t/zVok0d0jYdUO
        YOssMCsNUR4rGpRpA1jQS6/CGnu4nv8=
X-Google-Smtp-Source: AFSGD/Uem0qoVYTt7NfrASMWtTj8fs0+k4j585w9JE0ehG9fgxk0R8g53iJPa4svwuFESpvi/D/gxw==
X-Received: by 2002:a1c:1dc6:: with SMTP id d189mr1598558wmd.112.1543496204947;
        Thu, 29 Nov 2018 04:56:44 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 125sm2344952wml.35.2018.11.29.04.56.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 04:56:44 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [RFC PATCH v3 2/9] [squash] do not store entry for SECSID_NULL
Date:   Thu, 29 Nov 2018 13:53:55 +0100
Message-Id: <20181129125402.5900-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129125402.5900-1-omosnace@redhat.com>
References: <20181129125402.5900-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch is kept separate only for review. Eventually it will be
folded into the previous patch.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/policydb.c |  2 +-
 security/selinux/ss/sidtab.c   | 25 ++++++++++++++++---------
 security/selinux/ss/sidtab.h   |  3 ++-
 3 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 59359fa0bd74..a50d625e7946 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -912,7 +912,7 @@ int policydb_load_isids(struct policydb *p, struct sidtab *s)
 			sidtab_destroy(s);
 			goto out;
 		}
-		if (c->sid[0] > SECINITSID_NUM) {
+		if (c->sid[0] == SECSID_NULL || c->sid[0] > SECINITSID_NUM) {
 			pr_err("SELinux:  Initial SID %s out of range.\n",
 				c->u.name);
 			sidtab_destroy(s);
diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index fd8115b211a6..e157d8240cf1 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -23,7 +23,7 @@ int sidtab_init(struct sidtab *s)
 	if (!s->htable)
 		return -ENOMEM;
 
-	for (i = 0; i <= SECINITSID_NUM; i++)
+	for (i = 0; i < SECINITSID_NUM; i++)
 		s->isids[i].set = 0;
 
 	for (i = 0; i < SIDTAB_SIZE; i++)
@@ -86,8 +86,15 @@ static int sidtab_insert(struct sidtab *s, u32 sid, struct context *context)
 
 int sidtab_set_initial(struct sidtab *s, u32 sid, struct context *context)
 {
-	struct sidtab_isid_entry *entry = &s->isids[sid];
-	int rc = context_cpy(&entry->context, context);
+	struct sidtab_isid_entry *entry;
+	int rc;
+
+	if (sid == 0 || sid > SECINITSID_NUM)
+		return -EINVAL;
+
+	entry = &s->isids[sid - 1];
+
+	rc = context_cpy(&entry->context, context);
 	if (rc)
 		return rc;
 
@@ -116,19 +123,19 @@ static struct context *sidtab_search_core(struct sidtab *s, u32 sid, int force)
 	struct context *context;
 	struct sidtab_isid_entry *entry;
 
-	if (!s)
+	if (!s || sid == 0)
 		return NULL;
 
 	if (sid > SECINITSID_NUM) {
 		context = sidtab_lookup(s, sid - (SECINITSID_NUM + 1));
 	} else {
-		entry = &s->isids[sid];
+		entry = &s->isids[sid - 1];
 		context = entry->set ? &entry->context : NULL;
 	}
 	if (context && (!context->len || force))
 		return context;
 
-	entry = &s->isids[SECINITSID_UNLABELED];
+	entry = &s->isids[SECINITSID_UNLABELED - 1];
 	return entry->set ? &entry->context : NULL;
 }
 
@@ -283,11 +290,11 @@ int sidtab_context_to_sid(struct sidtab *s, struct context *context, u32 *sid)
 	int rc;
 	u32 i;
 
-	for (i = 0; i <= SECINITSID_NUM; i++) {
+	for (i = 0; i < SECINITSID_NUM; i++) {
 		struct sidtab_isid_entry *entry = &s->isids[i];
 
 		if (entry->set && context_cmp(context, &entry->context)) {
-			*sid = i;
+			*sid = i + 1;
 			return 0;
 		}
 	}
@@ -334,7 +341,7 @@ void sidtab_destroy(struct sidtab *s)
 	if (!s)
 		return;
 
-	for (i = 0; i <= SECINITSID_NUM; i++)
+	for (i = 0; i < SECINITSID_NUM; i++)
 		if (s->isids[i].set)
 			context_destroy(&s->isids[i].context);
 
diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
index dc0a80bc8894..e657ae6bf996 100644
--- a/security/selinux/ss/sidtab.h
+++ b/security/selinux/ss/sidtab.h
@@ -36,7 +36,8 @@ struct sidtab {
 	struct sidtab_node *cache[SIDTAB_CACHE_LEN];
 	spinlock_t lock;
 
-	struct sidtab_isid_entry isids[SECINITSID_NUM + 1];
+	/* index == SID - 1 (no entry for SECSID_NULL) */
+	struct sidtab_isid_entry isids[SECINITSID_NUM];
 };
 
 int sidtab_init(struct sidtab *s);
-- 
2.19.2

