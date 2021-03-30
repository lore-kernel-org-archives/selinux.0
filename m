Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34864C433E1
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 13:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6E64600CD
	for <selinux@archiver.kernel.org>; Tue, 30 Mar 2021 13:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbhC3NRB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Mar 2021 09:17:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53003 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232122AbhC3NQz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Mar 2021 09:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617110215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9pwB6l9VhZhkITrbtGxLTExvtQ9kVVt5unFgEjPuUiA=;
        b=cwWnZyU8O5BjMwy8fZbGnututSJAU+Guw5/7XJ2WcSaEPSxDDNpAFRM6QESBlegntTsipM
        MthkrGVztWhdF5NxXbtbdXNmFfhV44rP6Z1otjTby/+aOcuK8A6wrZd+7t+IoAQn16/8Cf
        f/2YwrvBji6wq4m7opVVhNrKYY6DYwc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-k1rk3yenOYG0ZyWE1rPFLg-1; Tue, 30 Mar 2021 09:16:52 -0400
X-MC-Unique: k1rk3yenOYG0ZyWE1rPFLg-1
Received: by mail-ed1-f69.google.com with SMTP id y10so10156830edr.20
        for <selinux@vger.kernel.org>; Tue, 30 Mar 2021 06:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9pwB6l9VhZhkITrbtGxLTExvtQ9kVVt5unFgEjPuUiA=;
        b=lsExHxMEBPuWEoK0tEGEYuyISqbUZLlQj5DYzsai4Vl7CiXqZxy/VLAmppWdjIWVoj
         1BajtkfmkDWdCDMIkDEvyTliOL6owsisrhrgyY0f/jLC8DS4T7/lacet0QCh9z/1sh4J
         18M/zy3Nx9zvuIifVOW4T+VnvWzFDfeFL5Bu3Ks9U51o4qygjjR4WdaoEQKKNMw2OgPv
         0HDo7xy/tb8nIO4VQpZUbAsB+ylaTR2l1tPQ95jIwC5JganjRS7APfs0r3IVXOILxd9t
         +SoiiHjNtKLxNWVCJ2uzleXRjVatnQaku3DBzC5WjW5OLnfHWGO2IjcELt19f2689BIG
         rUlw==
X-Gm-Message-State: AOAM532lFVXqroMFHHGrnBPMtq5E/o2OEjwpi08gqu4swpUO3ZMN9cCb
        CCiy+HNYvsbuDHRNyGILYIFsU7MD/C+4E0GNxjL1dhnWQph8r68iBkzwFxvV0lTjB7OuSkDvPXl
        VyqSK6tBHCL6tJrqxAnXdUmLsvYSeQ1MQFHGPOID0HBbpRBSnJN0yIv4jA7t6niOmwPRdDA==
X-Received: by 2002:a05:6402:888:: with SMTP id e8mr33072129edy.51.1617110211538;
        Tue, 30 Mar 2021 06:16:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEwPhv2Xgu6VCvPTLLDcsMfqpfizij2aOCOupirctgQRagwpkTf/+rppBvlK0zJKG0R0CZew==
X-Received: by 2002:a05:6402:888:: with SMTP id e8mr33072104edy.51.1617110211346;
        Tue, 30 Mar 2021 06:16:51 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id u16sm11178245edq.4.2021.03.30.06.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:16:50 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/3] selinux: simplify duplicate_policydb_cond_list() by using kmemdup()
Date:   Tue, 30 Mar 2021 15:16:45 +0200
Message-Id: <20210330131646.1401838-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330131646.1401838-1-omosnace@redhat.com>
References: <20210330131646.1401838-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

We can do the allocation + copying of expr.nodes in one go using
kmemdup().

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/conditional.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 1ef74c085f2b..f6dfa9c821d6 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -628,7 +628,8 @@ static int cond_dup_av_list(struct cond_av_list *new,
 static int duplicate_policydb_cond_list(struct policydb *newp,
 					struct policydb *origp)
 {
-	int rc, i, j;
+	int rc;
+	u32 i;
 
 	rc = avtab_alloc_dup(&newp->te_cond_avtab, &origp->te_cond_avtab);
 	if (rc)
@@ -648,12 +649,12 @@ static int duplicate_policydb_cond_list(struct policydb *newp,
 		newp->cond_list_len++;
 
 		newn->cur_state = orign->cur_state;
-		newn->expr.nodes = kcalloc(orign->expr.len,
-					sizeof(*newn->expr.nodes), GFP_KERNEL);
+		newn->expr.nodes = kmemdup(orign->expr.nodes,
+				orign->expr.len * sizeof(*orign->expr.nodes),
+				GFP_KERNEL);
 		if (!newn->expr.nodes)
 			goto error;
-		for (j = 0; j < orign->expr.len; j++)
-			newn->expr.nodes[j] = orign->expr.nodes[j];
+
 		newn->expr.len = orign->expr.len;
 
 		rc = cond_dup_av_list(&newn->true_list, &orign->true_list,
-- 
2.30.2

