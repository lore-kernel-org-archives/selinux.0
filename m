Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6267EC433DF
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 15:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C1BC2071E
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 15:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bJrTQUPH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgHXPwV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:52:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42467 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726631AbgHXPwS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 11:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598284337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=whqo+s0PpYj6VGwaYxQ+CFJW6HvZcuDlPKqXnIk8v2w=;
        b=bJrTQUPH8idp+57a9eQWAhUO6jCfZPtIEmmX8OEgLOuIwK/lc33uCcId/y/qqO0fNpiZ40
        tST4k1eQbtUDTvRXlyiYFzsUQNNNiIGbuXVDYoEZHSLWICddxnM2sUKGnIIQs+fCMejoTK
        zzzjbv0NCFZHrfkQIF4ghiSHG9nmVgs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-PJMMCgAEMBmKogSDtbVeMQ-1; Mon, 24 Aug 2020 11:52:15 -0400
X-MC-Unique: PJMMCgAEMBmKogSDtbVeMQ-1
Received: by mail-wm1-f72.google.com with SMTP id z25so812500wmk.4
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 08:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=whqo+s0PpYj6VGwaYxQ+CFJW6HvZcuDlPKqXnIk8v2w=;
        b=Bq0EXmtGqQHF36slEO97+XicOT2E+wNv3xky1j1/ZiRUlhMLl4AA/+Fcr0Hb5cQzNe
         0kdnd+RKAxjulwVsLlWGJRoEGnis1cA4N3ok+zRp521ixHsticUMnaJQq8ksxLmP9u7O
         RiwU+uXozNosi90iagph8rELQTOqTYfbcNazLxgr3rJ8XymrkoHT8MS3f9+qFkP1t8UE
         BXX6+ewKyzr5lGx/7WLlvPYxV7EMmcIOdEPMdl/vYbJr8OOpSl7XM1hklPY1gC4fSxLP
         d4u6Yd4ixLCIaw/RF6qe1fU7YiIEXUXVXIOn2lIappwMg5FlmunIcVy39buWRTuS3Bql
         bXIw==
X-Gm-Message-State: AOAM531KeO9Mq8OwI1rp+sglRBMdCxuekUCIL3ogFXruDkFzEyhDbsx5
        Npbk8QlvL11KwplobRsG7WheUqg4dzzJetGy0EFIzufeMFkm7/zivEX9JeDEWWQRCdL4gMa1Dv1
        DYN5m5PcnqgKfUBgnyA==
X-Received: by 2002:a5d:5151:: with SMTP id u17mr6518687wrt.154.1598284333986;
        Mon, 24 Aug 2020 08:52:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxET3wyDwX+hEKfaY6JolTHURUAjey00zicF2izXypfInmg/GbEAJ5ZIvq3fbFlSQUXDxrSDw==
X-Received: by 2002:a5d:5151:: with SMTP id u17mr6518670wrt.154.1598284333753;
        Mon, 24 Aug 2020 08:52:13 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id x133sm25684215wmg.39.2020.08.24.08.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 08:52:13 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/2] selinux: switch unnecessary GFP_ATOMIC allocs to GFP_KERNEL
Date:   Mon, 24 Aug 2020 17:52:09 +0200
Message-Id: <20200824155210.1481720-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200824155210.1481720-1-omosnace@redhat.com>
References: <20200824155210.1481720-1-omosnace@redhat.com>
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
 2 files changed, 8 insertions(+), 8 deletions(-)

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
 
-- 
2.26.2

