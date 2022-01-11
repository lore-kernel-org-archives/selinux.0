Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D70EC433F5
	for <selinux@archiver.kernel.org>; Tue, 11 Jan 2022 21:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345266AbiAKVzT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Jan 2022 16:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbiAKVzG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Jan 2022 16:55:06 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833B7C06175D
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:55:05 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id bp39so839277qtb.6
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CEfa5+omoDzwLmrn6ck4iz87TuJFgKvummx5dT/Q7Ak=;
        b=RZjoEEdgR7F8zMREBBSBtNQDbBarI4qanS1iQ/QqryeD7q2Fak1Bpe2aniKXQn8WuW
         fRv2/u1B+lU2bzlaEhEmZQQCkiYN4L1pn5xhvW+RB3GLE43BpmmT2E7p4AEh4ZGqq07+
         ZcPWWbl4vmlI+NDvt7EhTBIHE3W0cbvcP9/MLtZ1AP1g/ilh7d7bzzONeaQOOltxrDw4
         OVT8Nx1/LwIv3YiJ/vHemVZLZLQPevZa7PfjVUMTPjIDsgT7VsrIJtUnzJKaW61s/ga4
         Gz/FMHICaJn+J6/IKNDxyU8sLDCb7nx6MQ1IYtTlOxMF23dSXCHcyqzcqKhIpFFjAXGQ
         EfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CEfa5+omoDzwLmrn6ck4iz87TuJFgKvummx5dT/Q7Ak=;
        b=uRqlgNovLX8YqZ36P4pNYRwkgnXZC723YyobV8XdHHK1qyUeKJWfm55P6xhjd+ZTbA
         V2SdGoylmmcSpVpB7ptFmCoLvZw8cPoOtdmpLoOH3Khwt++xohRxj+St+Ntc1J7NVqFl
         g3iBxv3y2ifjpP6ovCRKh1oQpSqcrkauG7T6WIaLNLBE5LJvq6syR1fh35X0uEqS86XP
         ATjvRcKgi5PzGjzC1Wt6wlxk3FhzGgBRHaCfi4G3D1m25kTskuFz+MRyryVzXRcnY5+v
         s9jDSqCgW4Bi6tZHZDSODblABIdSvcajWmTyiZAGavCzHgY2WvL1yAKRPdoQnuA8JVmg
         +ojQ==
X-Gm-Message-State: AOAM531BNHI9SIFagem8P1mwsekT8PbSiiza0L8/Zn2P6hcbQLMfvHsF
        rrmvjnFeQvKipK6zSuTXy4iuQNm5YT4=
X-Google-Smtp-Source: ABdhPJzA15JrYiMQz02LR4/RcxPDdGFzuXkkPQ9nA5VfjkeftAz4Sid/7uFMC6HrZNWLCUKrbCdK+A==
X-Received: by 2002:a05:622a:1493:: with SMTP id t19mr1563704qtx.230.1641938104673;
        Tue, 11 Jan 2022 13:55:04 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id j22sm5826949qko.46.2022.01.11.13.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 13:55:04 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 15/16 v2] libsepol: Set args avtab pointer when reporting assertion violations
Date:   Tue, 11 Jan 2022 16:54:45 -0500
Message-Id: <20220111215446.595516-16-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220111215446.595516-1-jwcart2@gmail.com>
References: <20220111215446.595516-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The changes are the same as in a patch sent by Christian Göttsche
<cgzones@googlemail.com> to support adding not-self to neverallowxperm
checking, but it is needed for normal neverallowxperm checking as well
and the following explanation reflects that.

When reporting neverallowxperm violations, the avtab is searched to
find the rule that violates the assertion. If the avtab pointer of
the args is not set, then it will report the error as if no extended
permissions existed for the source and target (so allowing the ioctl
permission at all violates the neverallowxperm).

Example (where t1 has attribute attr):
  allow attr attr:CLASS ioctl;
  allowxperm attr attr:CLASS ioctl 0x9411;
  neverallowxperm t1 self:CLASS ioctl 0x9411;
Would be reported as:
  neverallowxperm on line 3 of policy.conf (or line 3 of policy.conf)
  violated by
  allow t1 t1:CLASS { ioctl };
Instead of:
  neverallowxperm on line 3 of policy.conf (or line 3 of policy.conf)
  violated by
  allowxperm attr attr:CLASS ioctl { 0x9411 };

Reported-by: Christian Göttsche <cgzones@googlemail.com>
Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/assertion.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index 1c69f4d9..b21c83ba 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -292,10 +292,12 @@ static int report_assertion_failures(sepol_handle_t *handle, policydb_t *p, avru
 	args.avrule = avrule;
 	args.errors = 0;
 
+	args.avtab =  &p->te_avtab;
 	rc = avtab_map(&p->te_avtab, report_assertion_avtab_matches, &args);
 	if (rc < 0)
 		goto oom;
 
+	args.avtab =  &p->te_cond_avtab;
 	rc = avtab_map(&p->te_cond_avtab, report_assertion_avtab_matches, &args);
 	if (rc < 0)
 		goto oom;
-- 
2.31.1

