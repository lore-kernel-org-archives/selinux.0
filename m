Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F530C77B75
	for <selinux@archiver.kernel.org>; Tue, 16 May 2023 22:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjEPWM6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 16 May 2023 18:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEPWM5 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 16 May 2023 18:12:57 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E129C4231
        for <selinux@vger.kernel.org>; Tue, 16 May 2023 15:12:56 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-757742c2e5fso16366385a.1
        for <selinux@vger.kernel.org>; Tue, 16 May 2023 15:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684275175; x=1686867175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2W3vG9pXFnfsTZfR+HWBWPKe1k/st289rupPWK1I6sw=;
        b=FO9el/uzvnTFS6MB6hCS4sMuYphNxShA2CY0iACnJp6PSDmmthdmhVzxh4brO2CIaG
         TO50pfk79YWb21jR93l1W/nnn0bV6sZF1nxbUnYAfVjtH7jas4qlQ1VtCnulpDi66Ol3
         vjTBTASXT3igQPz7OIQCyVwbRGQEJvEgzkmt8KV50ftr2EtnsSlomE1p7t9rBSm/nPl9
         /hpsnKDPEJvnY++WTiDvCnz+wNU06to6IdKSvOggfpeRvFL67RVLPxAYihx13R3RzI8y
         kQkkfHSX1tCRh5sVs0Y+YADwWhFzidVk7NVAWIsIRAtKEudo2Pa1XhDPY9jvWGeNHDDL
         lKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684275176; x=1686867176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2W3vG9pXFnfsTZfR+HWBWPKe1k/st289rupPWK1I6sw=;
        b=XaWPZ0m2fg4a8vep1itVe1+c7MPgJnrJpE8VMljTzHq9J8Rc/kRKQMoui2na/z+2RM
         ylEaZNf8NtHsWm7L7chZuETPzSCfZDaiOW7w67XV+WgXw2D9rZAEmVUNQ9SVmCG49BAf
         hsxWm8Aqttg4txnXjfCkJzHefwhSFQm2dt0zHjWql4v22A5+20KgjsmkJwpZ4W8tiKmm
         cEdqFD6EJ30f38DL7v6o9lP/mXqTPkA4cZNj0u2PMSOKNdiu2RRHfRzh1NfBYgbAide2
         F7kdFSnZ1tFRbJDrNNjcV70LySvYstwReOSwKWJvVxUJjGa9m1QlekE1Ftw24RiTxcez
         A75w==
X-Gm-Message-State: AC+VfDyL0p49/ZLUhJAX+f9Unb2HqrgCm7MwKXU+fu8CuUjASQuY6RCF
        v/SZChz7RhENPcvXkslwXEfkRLFJCGyABNZ5rg==
X-Google-Smtp-Source: ACHHUZ72m6XQqsTYLnhK9ON+JaeMtBUqMfsEOt78MYDGje0IBrmrN4mmSR6BQFyuVTLB7PZ2wgwbaA==
X-Received: by 2002:a05:622a:651:b0:3f3:8f4a:a5e1 with SMTP id a17-20020a05622a065100b003f38f4aa5e1mr54122796qtb.19.1684275175598;
        Tue, 16 May 2023 15:12:55 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id d9-20020ac86149000000b003e3918f350dsm6551517qtm.25.2023.05.16.15.12.54
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 15:12:54 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH] selinux: TESTING ONLY, PLEASE IGNORE
Date:   Tue, 16 May 2023 18:12:53 -0400
Message-Id: <20230516221253.506628-1-paul@paul-moore.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1491; i=paul@paul-moore.com; h=from:subject; bh=AuP9IUgiz8b9opSSxcbMgfhmkAyr9Xy7WBYl8p7R6KI=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBkY//fnXA74Apm3PIGnYEKy5p/Yp7KD8xdszINx ggmW/EoPi+JAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZGP/3wAKCRDqIPLalzeJ c8F7EACWH2ryDKDqnd1ftc5fWXs7J8QIC73kkMzakfxvBXZ+PBl0A0HOjv0OL+hnkDtMzmTxsK1 qzeRZXqF6qMEZNp4VzZYUfWWYTT6NonTlrUVMIld4V9Ww3SgdhAa41UmxXPu5NhFdMmpDB/hvMc DRLfe7QheIsifbDr3C29MgMa3LmBnJAEXa1yn5e1e4GH8RNAeyqtJh27yMYsuHdgVoFZ1Amd2B3 nHRTXt0WhScPfj+LOeztV8ZDlMPYpv8sAHZ/SfgJLlhjBbBpoq1zO42Drb1JLIx7Wb6OmZNNjNP qR1D0kiPJD4V+JXxeDoXx2KwSErf7KyJHndHLrcxHGgHPPHtoAL08cpR+ZErfGZBrURGIrw5/D+ oOhJIiuBLdK3+7yWgNPt/P+DemCvRBKzZ43hRBppMOYVMKVtxBrE1GdMt82DQ1tEgJ5FVCNo89J k0YSAAbasueMUrv1KSo1EDqUxAb25MUWBkLCeJx+/csBoR6SdYet0YuFL3U+Gs9orVDKJBPeNAk CttGPCjlAtpEEGIvalxGnD0NIciQ3YyuMfy2RNrXeG9m9YOMuHeevtsTHxkiBu4jZlLIrTZuS5+ lm9A0yLv/2d3qbk/MJB0E7iIGpZoeCIJNxzqqkl7tWcQnca+3RXrh1gdMkAZ5ZWtuJAdisK/rV5 mYuPunNoDYjJe5g==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch can be safely ignored, I'm testing some new automated
tooling and needed to do an on-list test.  My apologies for the
noise.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/netlabel.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 767c670d33ea..575e7597c3aa 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -97,8 +97,8 @@ static struct netlbl_lsm_secattr *selinux_netlbl_sock_genattr(struct sock *sk)
  *
  */
 static struct netlbl_lsm_secattr *selinux_netlbl_sock_getattr(
-							const struct sock *sk,
-							u32 sid)
+	const struct sock *sk,
+	u32 sid)
 {
 	struct sk_security_struct *sksec = sk->sk_security;
 	struct netlbl_lsm_secattr *secattr = sksec->nlbl_secattr;
@@ -268,7 +268,7 @@ int selinux_netlbl_skbuff_setsid(struct sk_buff *skb,
  *
  */
 int selinux_netlbl_sctp_assoc_request(struct sctp_association *asoc,
-				     struct sk_buff *skb)
+				      struct sk_buff *skb)
 {
 	int rc;
 	struct netlbl_lsm_secattr secattr;
@@ -480,7 +480,7 @@ int selinux_netlbl_sock_rcv_skb(struct sk_security_struct *sksec,
 static inline int selinux_netlbl_option(int level, int optname)
 {
 	return (level == IPPROTO_IP && optname == IP_OPTIONS) ||
-		(level == IPPROTO_IPV6 && optname == IPV6_HOPOPTS);
+	       (level == IPPROTO_IPV6 && optname == IPV6_HOPOPTS);
 }
 
 /**
-- 
2.40.1

