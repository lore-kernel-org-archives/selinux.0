Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8166EC77B72
	for <selinux@archiver.kernel.org>; Thu, 20 Apr 2023 13:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjDTN6S (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Apr 2023 09:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjDTN6P (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Apr 2023 09:58:15 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73FA6A40
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 06:58:11 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id dx24so6494886ejb.11
        for <selinux@vger.kernel.org>; Thu, 20 Apr 2023 06:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1681999090; x=1684591090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2P05TwsZ01gAf8SJpOOkQ99qZ/U/7GBu8NTvpZCyjs=;
        b=snQgJF1JqSlPcx2Q6o3DRQL3UNPj7RaMRpkM1Rf4h+rIftWNstBahUovR2veLZVaDu
         yUsuDMSWz5RxLE+uLLGOxwZiwjBOa0FqqYzktrRk2owleZAWZZhdq//aRj8jyRSCj8VT
         kFSYCwemlOzKTlNvpuHyDXdWg3I94g+V2mnorXso0YcREFsicWfGnlw/iOOWvVCLAIou
         TQBuzlSY67p3nh2FpEwpC5lq0o++6oYwfmPBPLKn//Y2NYH230KoBQvCvq6CVIo4Cgrv
         PUiLdOum12TM40YoR6cAIoiYQH18/iqREFfx/8UA4OUFEX7XO+bEEpHgYUFh7UP/02sY
         RXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681999090; x=1684591090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2P05TwsZ01gAf8SJpOOkQ99qZ/U/7GBu8NTvpZCyjs=;
        b=IWwZXsMYegfJxhSqvnYCMq3AzjuaK3n4eQyVAcsH1O98BcN3/CDNpImsHZj3oGxsQ7
         e2LfqFBoayRHBzXSI3eP0XK3hnruro8hyHEgls/mAfLkEqOSUeYlweV9tkSZ6dsZNwJX
         SlFgApzaAYji7Xmta8tKdVNdNP+dH1/XHMNJENVt9qJUP1g88ApegECb8YvkdUUp5ZDB
         GQ0msClX4Ndy8Txiqg24Ht2aIKcHYVwUQpaDiSbe9zW86Y+ZvuJkwR9LAulNYgFFl9+p
         mseVfqtT0Z8PSPX4dZ9Wy4Fo1VmRlCHmatO9U7StDEkL4YFm9OjpYa6uVeleTkQf2BLu
         2iqQ==
X-Gm-Message-State: AAQBX9dxqrlXfZWg1wPei15KMdwlTVsc1zjqbrg06QU7mh+66x+N0Si9
        i7AXjC82/AeK3flI8gnzgOi685R/c4A=
X-Google-Smtp-Source: AKy350YJzcgTzFwA+1cs5PBWQQFS83FYgtVb4bevpyoqM1+RUeWoxe1h9qxugZs+IeShj4ryEY608A==
X-Received: by 2002:a17:906:1db:b0:94a:76f6:8e52 with SMTP id 27-20020a17090601db00b0094a76f68e52mr1691140ejj.35.1681999090196;
        Thu, 20 Apr 2023 06:58:10 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-119-201-251.95.119.pool.telefonica.de. [95.119.201.251])
        by smtp.gmail.com with ESMTPSA id re4-20020a170906d8c400b0094a82a236cbsm746688ejb.129.2023.04.20.06.58.09
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 06:58:09 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [TESTSUITE PATCH] README.md: update dependencies
Date:   Thu, 20 Apr 2023 15:58:03 +0200
Message-Id: <20230420135803.4692-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add libibverbs-dev, required since 4b4922e1 ("tests/infiniband*:
simplify test activation"):

    create_modify_qp.c:10:10: fatal error: infiniband/verbs.h: No such file or directory
       10 | #include <infiniband/verbs.h>
          |          ^~~~~~~~~~~~~~~~~~~~

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 README.md | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/README.md b/README.md
index 7bd1dbc..5256cda 100644
--- a/README.md
+++ b/README.md
@@ -82,6 +82,7 @@ following command (NOTE: On Fedora 32 and below you need to remove
 		lksctp-tools-devel \
 		attr \
 		libbpf-devel \
+		libibverbs-devel \
 		keyutils-libs-devel \
 		quota \
 		xfsprogs-devel \
@@ -124,6 +125,7 @@ command:
 		libselinux1-dev \
 		net-tools \
 		iptables \
+		libibverbs-dev \
 		libsctp-dev \
 		attr \
 		libbpf-dev \
-- 
2.40.0

