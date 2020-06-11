Return-Path: <SRS0=nmhN=7Y=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99DEC433DF
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 15:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89460206A4
	for <selinux@archiver.kernel.org>; Thu, 11 Jun 2020 15:58:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EZsoJdTV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgFKP6p (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:58:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51127 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728258AbgFKP6m (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Jun 2020 11:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591891121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=w+ltTGgilIWFB1kDQPEZ/eaSLvQzZ8qt2YQ/v22wotc=;
        b=EZsoJdTVNytPrfluHgk1SpCLRFdYarwH83NakvV34iwqAI7I97Pi3K858JIStFaSXO2Hi4
        ukzvI21fpSYpGiCNtpWp4Ikzr7jpljsCGVM1XP52cLXxeDSnLEHxoMSAd+4JhQhRPCrHVL
        RAcD1REH4wBSjez1+tBW9/kTkxB2Mos=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-4M0y-6r5N6Knnu9GJ4YIKg-1; Thu, 11 Jun 2020 11:58:36 -0400
X-MC-Unique: 4M0y-6r5N6Knnu9GJ4YIKg-1
Received: by mail-qk1-f200.google.com with SMTP id h18so5483195qkj.13
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2020 08:58:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w+ltTGgilIWFB1kDQPEZ/eaSLvQzZ8qt2YQ/v22wotc=;
        b=LIhguxUuZdwt9eKUXC/Bvm5QUXqj4SICQMzgSSRwuie0a9eLO3kaULblfpjacW0Iu6
         3h/HwFqbJ3tpFXumTbXUrTuYEAbK49yFHvmEPHOwRvbYiFD9k3i9DRGIDICNUDzM85Gf
         OAld3eS202CtWz51ZLgiAudbqc8EHP6wkMK+zew6RboRtLCiRURveSJQnY1jY6w9cUzH
         MbQ7sjfUOYP8BmYQ2scIafEroYfT+dwD4k8gqs9wNV3j9AG4kG4KtgUitrS9DYTu+ynA
         zWG3dvB+6fMHNs3I2mJfyA8qPD9uOaxWUNpRpbaErY4E+EedjzBsYASozmPTKCUZrvNC
         Ovfw==
X-Gm-Message-State: AOAM531ejZH0PRWQDrmEgjVp5DkM9UGa6jg8FLqtYUHBrfMXXeg7yis1
        SMNJQQu3zl8Ul0Kh1LJQMHxTP5wubktD6JTageDuqsG6YmqTwsRDsqkEgCjyrYPdt+nF/UClRxm
        RqaL5Pf5wDHHpu7mH0g==
X-Received: by 2002:a05:620a:21d3:: with SMTP id h19mr8714747qka.375.1591891116488;
        Thu, 11 Jun 2020 08:58:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHPj8jU9GZgzfn0ZyMBnQzNm18FKM1jLhw2T20/zWTSphsfmMdFNVJsWRU9XsOmqJ3dOqmdQ==
X-Received: by 2002:a05:620a:21d3:: with SMTP id h19mr8714732qka.375.1591891116294;
        Thu, 11 Jun 2020 08:58:36 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k34sm826332qtf.35.2020.06.11.08.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 08:58:35 -0700 (PDT)
From:   trix@redhat.com
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, omosnace@redhat.com, weiyongjun1@huawei.com
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] selinux: fix another double free
Date:   Thu, 11 Jun 2020 08:58:30 -0700
Message-Id: <20200611155830.8941-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this double free error

security/selinux/ss/conditional.c:139:2: warning: Attempt to free released memory [unix.Malloc]
        kfree(node->expr.nodes);
        ^~~~~~~~~~~~~~~~~~~~~~~

When cond_read_node fails, it calls cond_node_destroy which frees the
node but does not poison the entry in the node list.  So when it
returns to its caller cond_read_list, cond_read_list deletes the
partial list.  The latest entry in the list will be deleted twice.

So instead of freeing the node in cond_read_node, let list freeing in
code_read_list handle the freeing the problem node along with all of the the
earlier nodes.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 security/selinux/ss/conditional.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index da94a1b4bfda..ffb31af22f4f 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -411,7 +411,6 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
 		goto err;
 	return 0;
 err:
-	cond_node_destroy(node);
 	return rc;
 }
 
-- 
2.18.1

