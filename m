Return-Path: <SRS0=fbu5=RL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E03C10F09
	for <selinux@archiver.kernel.org>; Fri,  8 Mar 2019 16:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78D4B20868
	for <selinux@archiver.kernel.org>; Fri,  8 Mar 2019 16:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h80Ua8pb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfCHQHo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:07:44 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40418 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfCHQHo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 8 Mar 2019 11:07:44 -0500
Received: by mail-pf1-f196.google.com with SMTP id h1so14474319pfo.7;
        Fri, 08 Mar 2019 08:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=XB2pbo+rYUPVkhxEnnF/KwFaBKK+JA+5Hj3ANc6sk/s=;
        b=h80Ua8pbXnpSZfOwrgWxUeg6Uoj2Tjfatlon/RYiwruuuWZpFCe9XcPHU2GbuHjz0Z
         E3dJsxNoUj6kplC1MhuUVpZkl6oTotIUzRF+da/u9EUYQ1MyAMdbrPev88Y5hg4zxy2o
         FZv+dOEvFo40pw2ytIDME5jJZq10W6mvMceActK8sor5K9Gtaucon6McX/gEmKcIWnw6
         pbVFQJ/McNRbWprGu0m4rAQ1VwksPjQ4dAgD5/nRGQmtVdrqJCSYmCJxg8/mKEgCtxM3
         d2udP7bwe+2KNAx2DG7h5e7ixQsfs0cpzOlLLVpt9gig4+wBRqGMBpgs7Vr6mdB5FX48
         Wsog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XB2pbo+rYUPVkhxEnnF/KwFaBKK+JA+5Hj3ANc6sk/s=;
        b=ehXaIanT5y0gTXNQ4jKyq9efumiO1Up2Zaf25kOULix0KTRTXva2bXjtEwlO4TZZ8q
         0UBEShDWbWqP9Js51Wd49ZD6zpBchBDV9+QDsY5pFai4zNbAZNow2BQPH8kFbHyKCNbU
         5rGNuzbz60gN5ct4ffbf+NRBiz5+7q5uOBx5tv/yIXBQPT5m6z6SpuIPNLoMF8LcZBWd
         auWAYTOQF3y2PlIEQnBSp23a+2NcnAuSapVlh6C8Y/ZPpOrOV4GRS79Vjg1qOvanxsmD
         qvZfj0bIAjiD36fQxRigdKszHudM7tVMk5h6dcyPJNkk1ChsxdW4mXVfQoz3RKHUSR/V
         h/lA==
X-Gm-Message-State: APjAAAVawd5zVzU0RADJTVSirVvmNcTds6yrxfShjhBDGPi4DzyFW2Kd
        fswj494HJI3c34nzgHSO+MzXMmr9
X-Google-Smtp-Source: APXvYqxEEm+Ai/mutAj5RKt5QLOq0Syu8blKGDXaDIocBGh8Sp5UhuHlooYzHTotvjs57SZl3Wm+0A==
X-Received: by 2002:a17:902:ba84:: with SMTP id k4mr19799834pls.103.1552061262619;
        Fri, 08 Mar 2019 08:07:42 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s6sm12802588pgm.90.2019.03.08.08.07.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Mar 2019 08:07:42 -0800 (PST)
From:   Xin Long <lucien.xin@gmail.com>
To:     selinux@vger.kernel.org, network dev <netdev@vger.kernel.org>,
        linux-sctp@vger.kernel.org
Cc:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Paul Moore <paul@paul-moore.com>,
        Richard Haines <richard_c_haines@btinternet.com>
Subject: [PATCH net] selinux: add the missing walk_size + len check in selinux_sctp_bind_connect
Date:   Sat,  9 Mar 2019 00:07:34 +0800
Message-Id: <1e5accb3a4a5575ada1dbdfc6e5d9e4358131f83.1552061254.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.1.0
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

As does in __sctp_connect(), when checking addrs in a while loop, after
get the addr len according to sa_family, it's necessary to do the check
walk_size + af->sockaddr_len > addrs_size to make sure it won't access
an out-of-bounds addr.

The same thing is needed in selinux_sctp_bind_connect(), otherwise an
out-of-bounds issue can be triggered:

  [14548.772313] BUG: KASAN: slab-out-of-bounds in selinux_sctp_bind_connect+0x1aa/0x1f0
  [14548.927083] Call Trace:
  [14548.938072]  dump_stack+0x9a/0xe9
  [14548.953015]  print_address_description+0x65/0x22e
  [14548.996524]  kasan_report.cold.6+0x92/0x1a6
  [14549.015335]  selinux_sctp_bind_connect+0x1aa/0x1f0
  [14549.036947]  security_sctp_bind_connect+0x58/0x90
  [14549.058142]  __sctp_setsockopt_connectx+0x5a/0x150 [sctp]
  [14549.081650]  sctp_setsockopt.part.24+0x1322/0x3ce0 [sctp]

Fixes: d452930fd3b9 ("selinux: Add SCTP support")
Reported-by: Chunyu Hu <chuhu@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 security/selinux/hooks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index f0e36c3..dac9bdb 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5120,6 +5120,9 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
 			return -EINVAL;
 		}
 
+		if (walk_size + len > addrlen)
+			return -EINVAL;
+
 		err = -EINVAL;
 		switch (optname) {
 		/* Bind checks */
-- 
2.1.0

