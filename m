Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE94C07E96
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 17:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63AA861C3C
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 17:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhGFR5Y (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Jul 2021 13:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhGFR5Y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Jul 2021 13:57:24 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD15C06175F
        for <selinux@vger.kernel.org>; Tue,  6 Jul 2021 10:54:45 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ch27so2767847edb.10
        for <selinux@vger.kernel.org>; Tue, 06 Jul 2021 10:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=F1B0uHrskLQnDB/5joLw9v6pW5a1r8MdgcnxKiuvrhk=;
        b=WJ8vIHnMyYlkQStGPL9ODxKuo9eoTwpqJ0j5UmfUaJ/tYY+ktKSeem7kfFSdV1a+el
         fnitSYOQo+eYr1cj9Bf4Nb25y+dibHstX/db5CNzKwDTyN5j+QBRXGpJm5iDIbi+vm7T
         H+Eghn5xJLf8EOPgqRoeYph+N1ynEdODXi4nTUJg/xpsRBvZZKO2F/cCtII+qq9VGOEp
         bXr443DTXdtBf+xx7CmDiJoYRf6gqynR2Ey1QH3cqFOnZhMFcYRMBtlocVE5F2q+wGTH
         ZiPwP0lxcRsYLamq7Ua+lGhAg1jN0irkX0HI37gSUwVw7iFlD6sx0BJbulo71O7jhgyV
         q5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F1B0uHrskLQnDB/5joLw9v6pW5a1r8MdgcnxKiuvrhk=;
        b=sc9xkw6i74wsPJyFjByrrlazjvXNPYNQL5hzmISA+McD1SaCaci1bC1AQNITEH86WW
         776MclETpqAkpL8C7bpjYPKaba0xXf+LQiWNsTFdANbIKifiNqgVHJL/Z3y6ZpIMiC7i
         iX4xP+sIu52b8Jr7herh5/WTLxvUckpTwJ+r7P3hmXKP4AZgA9OVy/X4f9b0KHOC/YKq
         BnAe5OYlW3eWhXDpiFBbisSuZ+IJcvBb0wnv5qUAUxSA8zMjbnL+n55B5gbFZuXACBlQ
         c5nGFH5Iv4bFlXyo5cfICAPF9v49mH1b4Q+/6ZtP3junbiKwCI9Ck65Sl12QrlXdrUKA
         /r/g==
X-Gm-Message-State: AOAM5304JThla125s0Ps6W044919UZ35c1tOhvKa+2syRtkUqpXcSRXN
        Ild4foJxhN6lzSrWuOX+qKBgVVOFlrI=
X-Google-Smtp-Source: ABdhPJwT+NG3izQpJ/DOMvWsYxF/2GRUOgWleFS4MuR25gYiHqmKTmOlbjapW7+CJ0ff04wxRWp5Tw==
X-Received: by 2002:a05:6402:520c:: with SMTP id s12mr25407711edd.357.1625594084212;
        Tue, 06 Jul 2021 10:54:44 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-100-174.95.116.pool.telefonica.de. [95.116.100.174])
        by smtp.gmail.com with ESMTPSA id lg16sm6050950ejb.69.2021.07.06.10.54.43
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 10:54:43 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 08/13] checkpolicy: check before potential NULL dereference
Date:   Tue,  6 Jul 2021 19:54:28 +0200
Message-Id: <20210706175433.29270-8-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210706175433.29270-1-cgzones@googlemail.com>
References: <20210706175433.29270-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

    policy_define.c: In function ‘define_te_avtab_extended_perms’:
    policy_define.c:1946:17: error: potential null pointer dereference [-Werror=null-dereference]
     1946 |         r->omit = omit;
          |                 ^

In the case of `r` being NULL, avrule_read_ioctls() would return
with its parameter `rangehead` being a pointer to NULL, which is
considered a failure in its caller `avrule_ioctl_ranges`.
So it is not necessary to alter the return value.

Found by GCC 11 with LTO enabled.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 22218c07..370ff8e3 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1943,7 +1943,9 @@ int avrule_read_ioctls(struct av_ioctl_range_list **rangehead)
 		}
 	}
 	r = *rangehead;
-	r->omit = omit;
+	if (r) {
+		r->omit = omit;
+	}
 	return 0;
 error:
 	yyerror("out of memory");
-- 
2.32.0

