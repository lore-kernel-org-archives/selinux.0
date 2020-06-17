Return-Path: <SRS0=Tm5b=76=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B590C433E0
	for <selinux@archiver.kernel.org>; Wed, 17 Jun 2020 12:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 469C420707
	for <selinux@archiver.kernel.org>; Wed, 17 Jun 2020 12:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VhwvvM2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgFQMkk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Jun 2020 08:40:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45308 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726825AbgFQMkh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Jun 2020 08:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592397635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=2RQrT3EjDVr3su/B3tRPDza7pUR3iLPl4siz1SBOLw8=;
        b=VhwvvM2zR0Ek3NV+afguqwJGM90wFxpgeEQmJq4ZAUg7C1P7+WeLibLeoy4pFZwdYRwmvi
        oHUI0CqunvFyBV5TRWtk340CSyUYJClJbdRZJ81pSIwyhzok4YN4DiFUoqKaCcPm83bj0q
        bbMnISMIDkwmJY/I9NvdQ6qf/WsGqcw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-wpEKOqpaOYqEW1nW10z19w-1; Wed, 17 Jun 2020 08:40:34 -0400
X-MC-Unique: wpEKOqpaOYqEW1nW10z19w-1
Received: by mail-qk1-f197.google.com with SMTP id p7so1686315qkf.21
        for <selinux@vger.kernel.org>; Wed, 17 Jun 2020 05:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2RQrT3EjDVr3su/B3tRPDza7pUR3iLPl4siz1SBOLw8=;
        b=BPWRW0DhSiLcjeWFyJGBTenDIdNFAfceMv0A94vGQGIcyq0r6bYfPRU84FU9kHu/8c
         nhsEdXx81UZhC3p9w1Q1d1IIPrUj2xthZY3FaLqnfLhWU5Noxcn8BVnZwo3m2IqY+Ns3
         g6GfFC91LJBAfzx3xpuZk4gugCwLJDPqjr6pjLNXeOscNZFsHICpLWrPpVsxcnVwJzWp
         pB/p9M6DYFGbhjPN2Ak82OLhFpMRidtQr5tpPXasR4Z7PQTxH4pMz79bdqfosTfoUBm8
         /0Y8vDBRYuJaXA2xe4BeuvzAep8QxTAtjnFEHXIuM6NWBBs2TlYViMvTaPkXnkqgJMhr
         RIVA==
X-Gm-Message-State: AOAM532+am+EErU0HDAUInzTZd0pKrrMW5R/tluyLoPPciZRYJLCg33R
        3GzWAuuvCIliOr8eWoUSKeut7xr6JWqx/NHA66ailhZC9t0VszUpv4t9Jlzqr7M3QHbmw9yea1o
        oK22ydSjEMxpUBNwkOQ==
X-Received: by 2002:a37:2c85:: with SMTP id s127mr23808533qkh.35.1592397634147;
        Wed, 17 Jun 2020 05:40:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwRdA5/LRmzm5WOE/vH5imSdM/e0uBC09qFzet2IijFSRmUYeFsucAw0atfWaZlDq4biKMDmQ==
X-Received: by 2002:a37:2c85:: with SMTP id s127mr23808515qkh.35.1592397633918;
        Wed, 17 Jun 2020 05:40:33 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 69sm17054463qkh.15.2020.06.17.05.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 05:40:33 -0700 (PDT)
From:   trix@redhat.com
To:     paul@paul-moore.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, omosnace@redhat.com, weiyongjun1@huawei.com
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] selinux: fix undefined return of cond_evaluate_expr
Date:   Wed, 17 Jun 2020 05:40:28 -0700
Message-Id: <20200617124028.14130-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports an undefined return

security/selinux/ss/conditional.c:79:2: warning: Undefined or garbage value returned to caller [core.uninitialized.UndefReturn]
        return s[0];
        ^~~~~~~~~~~

static int cond_evaluate_expr( ...
{
	u32 i;
	int s[COND_EXPR_MAXDEPTH];

	for (i = 0; i < expr->len; i++)
	  ...

	return s[0];

When expr->len is 0, the loop which sets s[0] never runs.

So return -1 if the loop never runs.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 security/selinux/ss/conditional.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 450bc02f4cd2..0cc7cdd58465 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -27,6 +27,9 @@ static int cond_evaluate_expr(struct policydb *p, struct cond_expr *expr)
 	int s[COND_EXPR_MAXDEPTH];
 	int sp = -1;
 
+	if (expr->len == 0)
+		return -1;
+
 	for (i = 0; i < expr->len; i++) {
 		struct cond_expr_node *node = &expr->nodes[i];
 
-- 
2.18.1

