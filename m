Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E764C433DF
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 07:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 425342076C
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 07:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqmGwRMt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgHYHAh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:00:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56185 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729137AbgHYHAW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 03:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598338799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y+2EZTOHD/9tP1KriYT9wCpC52KwmoTCji6kfRWG+1M=;
        b=VqmGwRMtaqi7TLMO08sTiKG8i0gHUA2E1XLU0ATFD0LhKNRw6KlcdqfxvQ5vgpensV68Nv
        xXUt/UoCBWQfx0GkyVNl6SYgjNfCjtl2IhhezoGFND0LZTW9RE03h8xOB1o4vyOMIvpiQq
        DoJEG6TEzWpzKtmTLy5lw7zrtRgzD74=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-SyfPOY6kOZaTryZSrL0oMQ-1; Tue, 25 Aug 2020 02:59:58 -0400
X-MC-Unique: SyfPOY6kOZaTryZSrL0oMQ-1
Received: by mail-wm1-f71.google.com with SMTP id r14so384570wmh.1
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 23:59:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y+2EZTOHD/9tP1KriYT9wCpC52KwmoTCji6kfRWG+1M=;
        b=q4y3dWM3kBaK+uTO0KEtHstIwrOr1tefZ/JUKAhy2ZAaT+jravvMgMrye+bC0R1AL3
         KTOH0t8hq2mZno6aOQOOTm+8M2wTcFM9nUBZeu1ND2TtwcNsuC+rI74J5qFC+SqwJEQ6
         2UYuI/ePUgwG4db9+HpSYtkOw6ljMiaFynsR6ohzobY0zT1bc+SfiGPc3M41X0rJi5IW
         kWeb631rH5YUF6JKLG/nn4HrssanrwymdCDOjKlylMTz/Z/0oKYYD/JYnDwNBif0H7id
         7R4xvXbWpOpZ6mbIh8H8J2HlXvcFYh3p5CGuNyzTeKK7WppeJ3sGmIp/NOO8zWGNu1+e
         UeVA==
X-Gm-Message-State: AOAM532515Cb9LcOaCk1Eb2qazvGPlfiHf6wi43C2VQmblKl96bAQMCF
        gcnQ6U753hYp4JV2u6p7Va07AuvNAX+Q8zgqsd+hLNBG+M2pCF4P1AM907Brkl7JIH2siN3HAnz
        9MdDAtOdjbcCzMjwdMA==
X-Received: by 2002:adf:ba10:: with SMTP id o16mr9271496wrg.100.1598338796848;
        Mon, 24 Aug 2020 23:59:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLV8/RBJukm8QWNSiD5VJvdL8VzAJ301duu/pmxDinKDwYck7HZzHv4FIPz+QKy7iAlV1JGQ==
X-Received: by 2002:adf:ba10:: with SMTP id o16mr9271485wrg.100.1598338796658;
        Mon, 24 Aug 2020 23:59:56 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id h6sm28714644wrv.40.2020.08.24.23.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 23:59:56 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 1/2] selinux: switch unnecessary GFP_ATOMIC allocs to GFP_KERNEL
Date:   Tue, 25 Aug 2020 08:59:52 +0200
Message-Id: <20200825065953.1566718-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200825065953.1566718-1-omosnace@redhat.com>
References: <20200825065953.1566718-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

There seems to be no reason to use GFP_ATOMIC in these cases.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/hooks.c       |  6 +++---
 security/selinux/ss/policydb.c | 10 +++++-----
 security/selinux/ss/services.c |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 89d3753b7bd5d..4de962daffbde 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3171,7 +3171,7 @@ static int selinux_inode_setxattr(struct dentry *dentry, const char *name,
 				audit_size = 0;
 			}
 			ab = audit_log_start(audit_context(),
-					     GFP_ATOMIC, AUDIT_SELINUX_ERR);
+					     GFP_KERNEL, AUDIT_SELINUX_ERR);
 			audit_log_format(ab, "op=setxattr invalid_context=");
 			audit_log_n_untrustedstring(ab, value, audit_size);
 			audit_log_end(ab);
@@ -6388,7 +6388,7 @@ static int selinux_setprocattr(const char *name, void *value, size_t size)
 				else
 					audit_size = size;
 				ab = audit_log_start(audit_context(),
-						     GFP_ATOMIC,
+						     GFP_KERNEL,
 						     AUDIT_SELINUX_ERR);
 				audit_log_format(ab, "op=fscreate invalid_context=");
 				audit_log_n_untrustedstring(ab, value, audit_size);
@@ -6854,7 +6854,7 @@ static int selinux_lockdown(enum lockdown_reason what)
 
 	if (WARN(invalid_reason, "Invalid lockdown reason")) {
 		audit_log(audit_context(),
-			  GFP_ATOMIC, AUDIT_SELINUX_ERR,
+			  GFP_KERNEL, AUDIT_SELINUX_ERR,
 			  "lockdown_reason=invalid");
 		return -EINVAL;
 	}
diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 9fccf417006b0..c1437de04e1d9 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -1577,7 +1577,7 @@ static int sens_read(struct policydb *p, struct symtab *s, void *fp)
 	__le32 buf[2];
 	u32 len;
 
-	levdatum = kzalloc(sizeof(*levdatum), GFP_ATOMIC);
+	levdatum = kzalloc(sizeof(*levdatum), GFP_KERNEL);
 	if (!levdatum)
 		return -ENOMEM;
 
@@ -1588,12 +1588,12 @@ static int sens_read(struct policydb *p, struct symtab *s, void *fp)
 	len = le32_to_cpu(buf[0]);
 	levdatum->isalias = le32_to_cpu(buf[1]);
 
-	rc = str_read(&key, GFP_ATOMIC, fp, len);
+	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
 		goto bad;
 
 	rc = -ENOMEM;
-	levdatum->level = kmalloc(sizeof(*levdatum->level), GFP_ATOMIC);
+	levdatum->level = kmalloc(sizeof(*levdatum->level), GFP_KERNEL);
 	if (!levdatum->level)
 		goto bad;
 
@@ -1618,7 +1618,7 @@ static int cat_read(struct policydb *p, struct symtab *s, void *fp)
 	__le32 buf[3];
 	u32 len;
 
-	catdatum = kzalloc(sizeof(*catdatum), GFP_ATOMIC);
+	catdatum = kzalloc(sizeof(*catdatum), GFP_KERNEL);
 	if (!catdatum)
 		return -ENOMEM;
 
@@ -1630,7 +1630,7 @@ static int cat_read(struct policydb *p, struct symtab *s, void *fp)
 	catdatum->value = le32_to_cpu(buf[1]);
 	catdatum->isalias = le32_to_cpu(buf[2]);
 
-	rc = str_read(&key, GFP_ATOMIC, fp, len);
+	rc = str_read(&key, GFP_KERNEL, fp, len);
 	if (rc)
 		goto bad;
 
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index a48fc1b337ba9..fa61a54bc1440 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -109,7 +109,7 @@ static int selinux_set_mapping(struct policydb *pol,
 		i++;
 
 	/* Allocate space for the class records, plus one for class zero */
-	out_map->mapping = kcalloc(++i, sizeof(*out_map->mapping), GFP_ATOMIC);
+	out_map->mapping = kcalloc(++i, sizeof(*out_map->mapping), GFP_KERNEL);
 	if (!out_map->mapping)
 		return -ENOMEM;
 
@@ -2982,7 +2982,7 @@ int security_set_bools(struct selinux_state *state, u32 len, int *values)
 		int old_state = newpolicy->policydb.bool_val_to_struct[i]->state;
 
 		if (new_state != old_state) {
-			audit_log(audit_context(), GFP_ATOMIC,
+			audit_log(audit_context(), GFP_KERNEL,
 				AUDIT_MAC_CONFIG_CHANGE,
 				"bool=%s val=%d old_val=%d auid=%u ses=%u",
 				sym_name(&newpolicy->policydb, SYM_BOOLS, i),
-- 
2.26.2

