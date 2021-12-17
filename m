Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6CDC43217
	for <selinux@archiver.kernel.org>; Fri, 17 Dec 2021 18:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240052AbhLQSTe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Dec 2021 13:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239981AbhLQSTe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Dec 2021 13:19:34 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB14C061574
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:34 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id l25so2982171qkl.5
        for <selinux@vger.kernel.org>; Fri, 17 Dec 2021 10:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JO2PmnmZZkFd18wSxIIzSNz2VBHTXfG2JJ83387mSyA=;
        b=qnwktJmz3KPGZ0aL53Yvci2+aYPS/Hw99KcY7pcksK6Uj6ehVl8ew7LdEk87MVNyju
         x9IBCwh+52DKPVkW49K54IHiqZWa458mKy3NNesmxOQRIHPsV5VA3GAeprT40MVmLGM2
         M4BNW+QHboGTuaEjTtDeQyj0SM+7TM8dBRzbzJ2pTADvyY+JR0aCmf87Til/ICttzO/Y
         IvMySziDamvTZCLGhAintq03ehXMhxkH/XeEpj9KF1lmYyh8x4XRBsHyXFkTFOWx12qj
         sVBLJFqZd/jNIojTfg6N+Viw415CP5a0w5JSxgsgEeU31dUbzQw/PCqflyx+rU1BixiB
         ikBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JO2PmnmZZkFd18wSxIIzSNz2VBHTXfG2JJ83387mSyA=;
        b=Y+aE90XOqw+hHFynFlhuMD8JRu9sVEv05P4sQiCGWGRWufwZQExBHEU0dBoRQYoVdU
         dGVXOj/E4gTjOb6I9PN+GZ1f4ZqosmZ1UO0p7dqjv7/NCl1aDCLz4sOsgFl7km3WNGWS
         TVsV6nc5wuw1KMFhsHQ9GdLm4ccFpjCuiE1bbhyfrsBskJQimmkqqOjZzjZwW+bL8niF
         e9PXHCKbYxVmHgsdfwjA+ACss8b81AcCPPUWnU/INv4p1wK+kubBYjcbgPr6rdkEfzwN
         wxhElJkeUj6BCHn2JLdJT7VTY+HFnUqcjoQgo7Y/46hWzHXktgHpsejLfTI9RaIdNjyh
         wyhA==
X-Gm-Message-State: AOAM5318IaiG8JAvLHRJel2goQHsRiLxka39UPqAqOtcZD8OiWhNGzF1
        9edDmpK4jhmlUadJ2o+XEEiKaf8mWrQ=
X-Google-Smtp-Source: ABdhPJw8Wk4oOMqTZ7JTVTajkR2aXcL3rGSds6h+ZvGduW9kOYjLzRG1e23bfzHwSsxH4ROHwWfTLw==
X-Received: by 2002:a05:620a:1789:: with SMTP id ay9mr2660257qkb.657.1639765173109;
        Fri, 17 Dec 2021 10:19:33 -0800 (PST)
Received: from localhost.localdomain (c-73-200-157-122.hsd1.md.comcast.net. [73.200.157.122])
        by smtp.gmail.com with ESMTPSA id o17sm7468094qtv.30.2021.12.17.10.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 10:19:32 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 15/16] libsepol: Set args avtab pointer when reporting assertion violations
Date:   Fri, 17 Dec 2021 13:19:12 -0500
Message-Id: <20211217181913.336360-16-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211217181913.336360-1-jwcart2@gmail.com>
References: <20211217181913.336360-1-jwcart2@gmail.com>
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
index ae3c18be..ecd3f567 100644
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

