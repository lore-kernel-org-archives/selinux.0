Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0180DEB64DD
	for <selinux@archiver.kernel.org>; Tue, 18 Jul 2023 18:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjGRStc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 14:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjGRSta (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 18 Jul 2023 14:49:30 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49B610B
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 11:49:28 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52165886aa3so6878693a12.3
        for <selinux@vger.kernel.org>; Tue, 18 Jul 2023 11:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1689706167; x=1692298167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZodW3TXnM31uibPuRNqYlwXl8LeWTene5W4t1FOYt7g=;
        b=afoT3Knbj+Px88LwcTVKJy9/bns/hdvSpRbgkMiNwddTXZ99Sg3q7ybNxWpBWwUt6T
         Yj7q/+Pcv5cDwPZvUFyVvu5Kl5bgowhFtjFyyDW6PH2XFpv1PDkOwh2b1NpHhosho+qY
         dPHotU+Eh1yB0z6V4p4WuyUCiLeFDF55NCeqXXX4kl8tGOCDvpKKeeW9rRZYxBWSCI7e
         TRJ7PWTrPFs9xnEbepSetdDldUvyND4FKUN9gebKHsRuLse57JQpv69YfhHF11DMuVhK
         lq49CHJ0ipJorgCEKln04bEJmxBwRs1iPa4g9kG7QLVPAjwsWxBiorECR7gIdQ7PCsnP
         YWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689706167; x=1692298167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZodW3TXnM31uibPuRNqYlwXl8LeWTene5W4t1FOYt7g=;
        b=ktmB8Lb1Zt0fazJJnjVcjhCHI0XYaBmLzRWJRxLT7szjbvqdeYr7qdzmK5NLM6piAA
         H+dmUjU94q8RZ+/M7z73PpFSrnx81qSlSjRJOj8Ud/ZGiL6osFd1RU8ObieI5roIPfUX
         /iDnPHdGv7IZ/RgMtLaxcVF8OgJVZC6ycdOzCpy++62/yJaS59ht2l9VKho0GPeJnuQh
         WTqMyy9QqBxveg9GqmnU30f87OqtNHbLetjZ5oYKtyxk/PCRKKQM+ZqGsCQ9hG/bmizk
         nnPpRxc6O516YSjgadOpYJcOF8VFLB+W/pWsk+U0V5EUer8t0G/Z16CSgxge6qJRR8cn
         6GcA==
X-Gm-Message-State: ABy/qLZ8kSHSXYm23VzUYZI6UCFx9ai0KPBlZPWJgbPs4FDShh4Pbgme
        Ziz73oJuNw9BTXfCT/ePuBA1ac3jE6uY6g==
X-Google-Smtp-Source: APBJJlFwAP33W4RI9oX28xa/uUWNp/F9Zk+zlmZ4wM4SZ+5germr0kJj99vMw4Pt2iGo2daxs4RZaw==
X-Received: by 2002:aa7:cc8c:0:b0:51d:d30d:a037 with SMTP id p12-20020aa7cc8c000000b0051dd30da037mr747596edt.10.1689706167284;
        Tue, 18 Jul 2023 11:49:27 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-119-136-221.95.119.pool.telefonica.de. [95.119.136.221])
        by smtp.gmail.com with ESMTPSA id c17-20020a056402121100b0051e1660a34esm1603758edw.51.2023.07.18.11.49.26
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 11:49:27 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/3] selinux: log missing anonclass in debug configuration
Date:   Tue, 18 Jul 2023 20:49:21 +0200
Message-Id: <20230718184921.112786-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230718184921.112786-1-cgzones@googlemail.com>
References: <20230718184921.112786-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Log under the SELinux debug configuration when a caller to the LSM hook
inode_init_security_anon does not pass a anonymous inode class name.
The class name allows policy writers to transition the anonymous inode
into a private type via a name based type transition.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/hooks.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index b8a8a4f0f2ad..f6ffab9958b6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2918,6 +2918,17 @@ static int selinux_inode_init_security_anon(struct inode *inode,
 	if (unlikely(!selinux_initialized()))
 		return 0;
 
+#ifdef CONFIG_SECURITY_SELINUX_DEBUG
+	/*
+	 * Allow policy writers to transition the anonymous inode into
+	 * a private type via a name based type transition.
+	 */
+	if (!name) {
+		pr_debug("SELinux:  no class given for anonymous inode\n");
+		dump_stack();
+	}
+#endif
+
 	isec = selinux_inode(inode);
 
 	/*
-- 
2.40.1

