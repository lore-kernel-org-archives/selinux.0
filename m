Return-Path: <SRS0=crGG=7E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AE5C433E0
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 07:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D461207FB
	for <selinux@archiver.kernel.org>; Fri, 22 May 2020 07:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDGr+Lhr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgEVHqy (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 May 2020 03:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbgEVHqy (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 May 2020 03:46:54 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA2AC061A0E
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 00:46:54 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id n11so4625558pgl.9
        for <selinux@vger.kernel.org>; Fri, 22 May 2020 00:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3dDAEoAaclXPmIvJlXvxWj/lYkiLNFwnPuWgoSMCEuI=;
        b=gDGr+LhrOXCebEVrGKIKBUMKFmvHrTvjgJMVZ+3Mox3rw1nRtE5xQP+YZReS1bZjji
         G3bNQqcdLBQKkLD8kYG6nwLc+lRxKWnEZLDYCWdMwQB4gBgOgUpJFVUWfw75IE/J0WRj
         0P6e5dLAxZFBhShIa4v1XlXIXkJjGI4opfPvX6ffgP6pn1XHqjfBlZ9n1fKxhxX5E4yr
         V+tkD0Bzk0S8/pHY8ZdvkTYFOsy+SbxYFh4uxTGsAic0sG8T8LDdWZjUc7Av+3D90eIr
         z0Wp4XVnAwmOInxR7UQss69tBHTNFIYtksLr26H9s62VBzePuABax0A+WdlWkuOq4hxa
         fVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3dDAEoAaclXPmIvJlXvxWj/lYkiLNFwnPuWgoSMCEuI=;
        b=euyxkIPlAzdKqyjxdeAzAEEhN96eBSPKEcgTwVlJgvjaI/brAIhbaKDjTBzffcQkbl
         OLJPlVhi8GJ7d4Rky82furS7SJkTwUpIS4wuR0FxRijLnSYe0LML+HyCnyH1UYKRmHev
         IAS8PlbF7N+RhtI95IrhZt7bYBsUzxY3kWVhH7i4/euyCLYdJPp8NqNb6zg3fAxrahvw
         KYejBd8K48qqBrHSJvtHAXxRZzjr5fenU6+374pgPGDII2m4XMVS1XhyfJ5YrMbYorFw
         L+pn6MCViMyUpTDo2wb0lqIABCt52B+xLUrY1oOFyiap4WziRNywCOZOvsLpmbBy/ypG
         Y6nQ==
X-Gm-Message-State: AOAM53094D6FdpFgCAGqUW7QgnCbvM4YyNmehQ6UKItRbVd5jrTQpfBn
        n+bh3NwyW18Zt5f9AyoZJmZtaCe5
X-Google-Smtp-Source: ABdhPJyiwPEv9J2/RqkVqJWt8Q67+mjuajfwf/UWh0rP3R9dOA61mTPrmjvLw+w4xmkN6HTCDo7k8A==
X-Received: by 2002:a63:4f0e:: with SMTP id d14mr12521523pgb.445.1590133613586;
        Fri, 22 May 2020 00:46:53 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:cd6f:3908:64aa:a24d:1be1])
        by smtp.gmail.com with ESMTPSA id q25sm6253822pfh.94.2020.05.22.00.46.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 May 2020 00:46:53 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     selinux@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH] libselinux: utils: link with shared libfts
Date:   Fri, 22 May 2020 14:46:48 +0700
Message-Id: <20200522074648.24538-1-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0.4.gf5e7b24084
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Linux with musl libc, libfts isn't shipped with libc.
Hence, we link with $(FTS_LIBS) in src.

Some (most) musl-based distribution choose to ship libfts as
a standalone shared object because their libfts is licensed under either
very permissive license or that implementation of libfts requires
attribution in every usage.

Always link with $(FTS_LIBS) in utils to prevent undefined reference
problem on those platforms.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 libselinux/utils/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index aa2d3e1b..1a7da223 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -45,6 +45,8 @@ override CFLAGS += -I../include -D_GNU_SOURCE $(DISABLE_FLAGS) $(PCRE_CFLAGS)
 override LDFLAGS += -L../src
 override LDLIBS += -lselinux $(FTS_LDLIBS)
 PCRE_LDLIBS ?= -lpcre
+FTS_LDLIBS ?=
+override LDLIBS += $(FTS_LDLIBS)
 
 ifeq ($(ANDROID_HOST),y)
 TARGETS=sefcontext_compile
-- 
2.26.2.672.g232c24e857

