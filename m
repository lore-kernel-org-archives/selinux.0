Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E91DC4338F
	for <selinux@archiver.kernel.org>; Thu,  5 Aug 2021 14:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 351016054E
	for <selinux@archiver.kernel.org>; Thu,  5 Aug 2021 14:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241657AbhHEO0k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 5 Aug 2021 10:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241660AbhHEO0f (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 5 Aug 2021 10:26:35 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E27C061799
        for <selinux@vger.kernel.org>; Thu,  5 Aug 2021 07:26:20 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id yk17so9869309ejb.11
        for <selinux@vger.kernel.org>; Thu, 05 Aug 2021 07:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=EX7cn+uDoO+qXuwXHKxjXopNzfspr/KdB6g/6+eRst4=;
        b=JY+SU10BKOPIXrR/5Z0JOwvumLdGXYoT5aKT5FKmVMN+wEOlc1C/ypLrWKiKGQ0Qx6
         f1mLmOAQ05eFXuiAuwhxzdXZmua93RDau1QzAaBmjQ+DqPG+B7pVqoteqGo/EF5Azs4m
         tYQlGBZ/91IqFvOZV8ND7S2fS6frtXVHplHXLZpPxBd8lZqgL/5IqPpDdFrfYpNSGcOF
         m7mhxNxXqjI0WhUYGvoKj4mcCpAFGmspd1r7YeKAPXWRjSN/DIGX1G46t4UNo0hisYOM
         dTjjNn5E4fehfIRR27SGbfgArCNJr5v/gfTBzC8+vE1U1xXi2Y1qFu4MC3XGMbdxH/ER
         cmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EX7cn+uDoO+qXuwXHKxjXopNzfspr/KdB6g/6+eRst4=;
        b=QeSNWFecjoEVsU5PrsL2T7MUe4sBT/J1KQaVkK+LeWGZgtw319P5CLYWw9rNmJTmmL
         qy0DAkPVD4xH7tdfcqsN/2AiVHNni6gn3jWmRQwi3mMNXMrC0lRxVimyX17kZRvUqeQG
         DXhiZfDOuN02aN4RCRC2O+15g5SSd6H+O2tyKDTnRVYhyqcubn20PGkMMldbpdlUJHq+
         8KZhUA2SgBmSDZ9qKutaTLmzPT7j1oqhYVnKNMxNvUyQResXK/IOc4pCgHM4wIPQQ5cu
         9IGtMWZMPKpyxDbRw/OPvWVZO3d67uYRkJiWbZe4kPL1pbksLeSxX7TQIdze5Map02Wb
         e8VQ==
X-Gm-Message-State: AOAM531OuXJMBm0zdqH4yXVLJ/zWwNhdxfHgFiP9bWljuPhqEjo7saru
        9mD3CE7s7JZaGj4C6OOlm1e26SQ84T8=
X-Google-Smtp-Source: ABdhPJw2bjrnDdp/EEfK69XhJHrjR35Hz5FIb9hNwU8lgl4UAGs2mih4e6iZ3d9fkgIivdNIFSu0MQ==
X-Received: by 2002:a17:907:375:: with SMTP id rs21mr5238563ejb.252.1628173579132;
        Thu, 05 Aug 2021 07:26:19 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-008-149-099.77.8.pool.telefonica.de. [77.8.149.99])
        by smtp.gmail.com with ESMTPSA id f15sm1768887ejt.75.2021.08.05.07.26.18
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 07:26:18 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH SYSTEMD 7/7] core: tweak job_type_to_access_method SELinux permissions
Date:   Thu,  5 Aug 2021 16:24:45 +0200
Message-Id: <20210805142445.61725-8-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805142445.61725-1-cgzones@googlemail.com>
References: <20210805142445.61725-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

JOB_RELOAD_OR_START might collapse into JOB_START and JOB_VERIFY_ACTIVE
is similar to JOB_START.  Use the more heavy and appropriate permission
"start" instead of "reload".
---
 src/core/job.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/src/core/job.c b/src/core/job.c
index dd16a0b280..0b2e0373c6 100644
--- a/src/core/job.c
+++ b/src/core/job.c
@@ -1557,12 +1557,20 @@ const char* job_type_to_access_method(JobType t) {
         assert(t >= 0);
         assert(t < _JOB_TYPE_MAX);
 
-        if (IN_SET(t, JOB_START, JOB_RESTART, JOB_TRY_RESTART))
+        switch (t) {
+        case JOB_START:
+        case JOB_RESTART:
+        case JOB_TRY_RESTART:
+        case JOB_RELOAD_OR_START:
+        case JOB_VERIFY_ACTIVE:
                 return "start";
-        else if (t == JOB_STOP)
+        case JOB_STOP:
                 return "stop";
-        else
+        case JOB_RELOAD:
+        case JOB_TRY_RELOAD:
+        default:
                 return "reload";
+        }
 }
 
 /*
-- 
2.32.0

