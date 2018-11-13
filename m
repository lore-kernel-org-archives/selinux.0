Return-Path: <SRS0=smjq=NY=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F71C43610
	for <selinux@archiver.kernel.org>; Tue, 13 Nov 2018 13:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB1BE206BA
	for <selinux@archiver.kernel.org>; Tue, 13 Nov 2018 13:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB1BE206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733023AbeKMXv0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:51:26 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33004 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733140AbeKMXv0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 13 Nov 2018 18:51:26 -0500
Received: by mail-wr1-f68.google.com with SMTP id u9-v6so13425798wrr.0
        for <selinux@vger.kernel.org>; Tue, 13 Nov 2018 05:53:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kfWlC2l2R91YZ+YHJArmlUB/9Y4aLz4Qmy86b3cwAL4=;
        b=SD/lLJn3XSb/suqOxbuI/UEY1pAMrUe2i2Yizy1pdtGlMiWfSDQRUa6lG5IONdx0+l
         j/uCEqeCrSobxZ1jwk0ddXKyw1+r+ymghlANkBn+K8MlEIekfZMGE9ymvQi91uTBCtLk
         oKw+KN5LN9BLByHObe+FQsIMJmEXLKCmPlzqHaCpOwLneD3ZlWx4tiJO7KLVsm7eSy4l
         U5HO3E7PVHVVBBdDaiNBH5UfhEFQhk/1/aOimi9E1MznR0vPzxdcIAVwFA35b90VK90w
         qPqxn7mAd2KMVHBkjgblUCakXD2bzTxEQ1TGwvTzOLZnDPDxjHOCb+2q0meJ/RwI6uO2
         NeSg==
X-Gm-Message-State: AGRZ1gK4KjG7EIYS5f0YDiF3FectlRwVKHTtc56D8U602rfryv/xuW9w
        znantYWAWcUNms9WXupFeXkuX45XZQ4=
X-Google-Smtp-Source: AJdET5cwDhPzxDpokg64OjjxxTF00G56OQSmMV94mLCR0Mz3WBq81lVdc2ury7x2YNtjWAnuRd1dsQ==
X-Received: by 2002:adf:9d4a:: with SMTP id o10-v6mr5234893wre.94.1542117189548;
        Tue, 13 Nov 2018 05:53:09 -0800 (PST)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t187-v6sm10342609wmt.45.2018.11.13.05.53.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 05:53:08 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [RFC PATCH 1/3] selinux: refactor sidtab conversion
Date:   Tue, 13 Nov 2018 14:52:53 +0100
Message-Id: <20181113135255.26045-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181113135255.26045-1-omosnace@redhat.com>
References: <20181113135255.26045-1-omosnace@redhat.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This is a purely cosmetic change that encapsulates the three-step sidtab
conversion logic (shutdown -> clone -> map) into a single function
defined in sidtab.c (as opposed to services.c).

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/services.c | 22 +--------------
 security/selinux/ss/sidtab.c   | 50 ++++++++++++++++++++++++----------
 security/selinux/ss/sidtab.h   | 11 ++++----
 3 files changed, 42 insertions(+), 41 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 12e414394530..7337db24a6a8 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -1880,19 +1880,6 @@ int security_change_sid(struct selinux_state *state,
 				    out_sid, false);
 }
 
-/* Clone the SID into the new SID table. */
-static int clone_sid(u32 sid,
-		     struct context *context,
-		     void *arg)
-{
-	struct sidtab *s = arg;
-
-	if (sid > SECINITSID_NUM)
-		return sidtab_insert(s, sid, context);
-	else
-		return 0;
-}
-
 static inline int convert_context_handle_invalid_context(
 	struct selinux_state *state,
 	struct context *context)
@@ -2186,13 +2173,6 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 		goto err;
 	}
 
-	/* Clone the SID table. */
-	sidtab_shutdown(sidtab);
-
-	rc = sidtab_map(sidtab, clone_sid, &newsidtab);
-	if (rc)
-		goto err;
-
 	/*
 	 * Convert the internal representations of contexts
 	 * in the new SID table.
@@ -2200,7 +2180,7 @@ int security_load_policy(struct selinux_state *state, void *data, size_t len)
 	args.state = state;
 	args.oldp = policydb;
 	args.newp = newpolicydb;
-	rc = sidtab_map(&newsidtab, convert_context, &args);
+	rc = sidtab_convert(sidtab, &newsidtab, convert_context, &args);
 	if (rc) {
 		pr_err("SELinux:  unable to convert the internal"
 			" representation of contexts in the new SID"
diff --git a/security/selinux/ss/sidtab.c b/security/selinux/ss/sidtab.c
index fd75a12fa8fc..e66a2ab3d1c2 100644
--- a/security/selinux/ss/sidtab.c
+++ b/security/selinux/ss/sidtab.c
@@ -116,11 +116,11 @@ struct context *sidtab_search_force(struct sidtab *s, u32 sid)
 	return sidtab_search_core(s, sid, 1);
 }
 
-int sidtab_map(struct sidtab *s,
-	       int (*apply) (u32 sid,
-			     struct context *context,
-			     void *args),
-	       void *args)
+static int sidtab_map(struct sidtab *s,
+		      int (*apply) (u32 sid,
+				    struct context *context,
+				    void *args),
+		      void *args)
 {
 	int i, rc = 0;
 	struct sidtab_node *cur;
@@ -141,6 +141,37 @@ out:
 	return rc;
 }
 
+/* Clone the SID into the new SID table. */
+static int clone_sid(u32 sid, struct context *context, void *arg)
+{
+	struct sidtab *s = arg;
+
+	if (sid > SECINITSID_NUM)
+		return sidtab_insert(s, sid, context);
+	else
+		return 0;
+}
+
+int sidtab_convert(struct sidtab *s, struct sidtab *news,
+		   int (*convert) (u32 sid,
+				   struct context *context,
+				   void *args),
+		   void *args)
+{
+	unsigned long flags;
+	int rc;
+
+	spin_lock_irqsave(&s->lock, flags);
+	s->shutdown = 1;
+	spin_unlock_irqrestore(&s->lock, flags);
+
+	rc = sidtab_map(s, clone_sid, news);
+	if (rc)
+		return rc;
+
+	return sidtab_map(news, convert, args);
+}
+
 static void sidtab_update_cache(struct sidtab *s, struct sidtab_node *n, int loc)
 {
 	BUG_ON(loc >= SIDTAB_CACHE_LEN);
@@ -295,12 +326,3 @@ void sidtab_set(struct sidtab *dst, struct sidtab *src)
 		dst->cache[i] = NULL;
 	spin_unlock_irqrestore(&src->lock, flags);
 }
-
-void sidtab_shutdown(struct sidtab *s)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&s->lock, flags);
-	s->shutdown = 1;
-	spin_unlock_irqrestore(&s->lock, flags);
-}
diff --git a/security/selinux/ss/sidtab.h b/security/selinux/ss/sidtab.h
index a1a1d2617b6f..26c74fe7afc0 100644
--- a/security/selinux/ss/sidtab.h
+++ b/security/selinux/ss/sidtab.h
@@ -37,11 +37,11 @@ int sidtab_insert(struct sidtab *s, u32 sid, struct context *context);
 struct context *sidtab_search(struct sidtab *s, u32 sid);
 struct context *sidtab_search_force(struct sidtab *s, u32 sid);
 
-int sidtab_map(struct sidtab *s,
-	       int (*apply) (u32 sid,
-			     struct context *context,
-			     void *args),
-	       void *args);
+int sidtab_convert(struct sidtab *s, struct sidtab *news,
+		   int (*apply) (u32 sid,
+				 struct context *context,
+				 void *args),
+		   void *args);
 
 int sidtab_context_to_sid(struct sidtab *s,
 			  struct context *context,
@@ -50,7 +50,6 @@ int sidtab_context_to_sid(struct sidtab *s,
 void sidtab_hash_eval(struct sidtab *h, char *tag);
 void sidtab_destroy(struct sidtab *s);
 void sidtab_set(struct sidtab *dst, struct sidtab *src);
-void sidtab_shutdown(struct sidtab *s);
 
 #endif	/* _SS_SIDTAB_H_ */
 
-- 
2.17.2

