Return-Path: <SRS0=RDES=B7=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3103C433E1
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 15:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D2B7207C3
	for <selinux@archiver.kernel.org>; Fri, 21 Aug 2020 15:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cvFPL5/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgHUPrN (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 21 Aug 2020 11:47:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47564 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725828AbgHUPrM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 21 Aug 2020 11:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598024831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=89XL5jbhJ0am0PDzlPem+xSBcjCEWg9EHt3LKJM5rq4=;
        b=cvFPL5/iaijnFLpY5JOIYTS283LfiVISBUV+8AV3nC4zy9y8S2+Mm+0zOzNCeC0kyvH9uZ
        YWp+inAM2o3Nufrj6gV1pOSeJzajuNC75t1KKOmgIzNjFRJphEDbx3GOsu6WYyQUBnVGFz
        l4cjW6pKZ8AXB+kiCFDozS68hXFIWig=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-f369zrWFOHmc33ZgUMuZaw-1; Fri, 21 Aug 2020 11:47:07 -0400
X-MC-Unique: f369zrWFOHmc33ZgUMuZaw-1
Received: by mail-wm1-f71.google.com with SMTP id b73so970084wmb.0
        for <selinux@vger.kernel.org>; Fri, 21 Aug 2020 08:47:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=89XL5jbhJ0am0PDzlPem+xSBcjCEWg9EHt3LKJM5rq4=;
        b=quZ1x7I4NHBFGiyxQjPOWGkMnqAVmiYMI3mAqa3YKOtkrCjFnUgV6EjyopC80oNMt1
         u/9rVdlzKaeKpoLPIWgRDhFBFi0sQL7Vseg1yo3UeaqGc9UtU24lkFFniR71zCWtXx5i
         TzO0jk3e6E8KvprzuD97gYPftq0hUAh7xVgv2dV1FDL/JR2a8I1ECmJD1M2n3ZS5iGso
         XzOFvrS17xgyHP+sM+awubSM+bRHqDxJUBX+Jn/5zNdbqkZFrLRJGpf/AoDOYQ/aKQWB
         dbYVf0tawtP53fFKTRefke8vDrWYtTGQCgjHPCfRR7iRN7cpwvMqXWhSK9j7YaK3s67/
         12IQ==
X-Gm-Message-State: AOAM530XjXp9KsdnvbTYPHq0vUbtkPFetV+XTYncCX5l0s5ZIhYIuqKb
        4WuzuKX/3tXgSWBFDlqw6oZ9dXzc8i71OkrdSqKD6OgJ0d5rx+6NgoF/jYXvLxFShP8jqvZeAHl
        gS1UNzmHyAhk6k/ypLw==
X-Received: by 2002:a05:600c:202:: with SMTP id 2mr3768259wmi.139.1598024826471;
        Fri, 21 Aug 2020 08:47:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzr0RfYM3GGq+3k1Kc0BZbsH2xLiBm59K/0J1stQdCDA7IyykuBEcAc0mKbJyptV6cgjsLYbQ==
X-Received: by 2002:a05:600c:202:: with SMTP id 2mr3768243wmi.139.1598024826230;
        Fri, 21 Aug 2020 08:47:06 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b103:4000:e83d:a4fb:e589:6902])
        by smtp.gmail.com with ESMTPSA id g8sm5953354wme.13.2020.08.21.08.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 08:47:05 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] selinux: fix a race condition in security_read_policy()
Date:   Fri, 21 Aug 2020 17:47:04 +0200
Message-Id: <20200821154704.1214330-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In security_read_policy(), the policy length is computed using
security_policydb_len(), which does a separate transaction, and then
another transaction is done to write the policydb into a buffer of this
length.

The bug is that the policy might be re-loaded in between the two
transactions and so the length can be wrong. In case the new length is
lower than the old length, the length is corrected at the end of the
function. In case the new length is higher than the old one, an error is
returned.

Fix it by doing everything in a single transaction and getting the
length directly from policydb instead of calling
security_policydb_len().

Fixes: cee74f47a6ba ("SELinux: allow userspace to read policy back out of the kernel")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/services.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index a48fc1b337ba9..ab4de2a01634a 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -3842,22 +3842,25 @@ int security_read_policy(struct selinux_state *state,
 			 void **data, size_t *len)
 {
 	int rc;
+	struct policydb *policydb;
 	struct policy_file fp;
 
 	if (!selinux_initialized(state))
 		return -EINVAL;
 
-	*len = security_policydb_len(state);
+	read_lock(&state->ss->policy_rwlock);
+	policydb = &state->ss->policy->policydb;
 
+	*len = policydb->len;
 	*data = vmalloc_user(*len);
-	if (!*data)
-		return -ENOMEM;
-
-	fp.data = *data;
-	fp.len = *len;
+	if (!*data) {
+		rc = -ENOMEM;
+	} else {
+		fp.data = *data;
+		fp.len = *len;
 
-	read_lock(&state->ss->policy_rwlock);
-	rc = policydb_write(&state->ss->policy->policydb, &fp);
+		rc = policydb_write(policydb, &fp);
+	}
 	read_unlock(&state->ss->policy_rwlock);
 
 	if (rc)
-- 
2.26.2

