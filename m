Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96CCC54E76
	for <selinux@archiver.kernel.org>; Tue, 17 Jan 2023 17:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjAQRWs (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Jan 2023 12:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbjAQRWN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Jan 2023 12:22:13 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D922C2B0B4
        for <selinux@vger.kernel.org>; Tue, 17 Jan 2023 09:21:22 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id mg12so4657996ejc.5
        for <selinux@vger.kernel.org>; Tue, 17 Jan 2023 09:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=69t2zaQiM68Ndj+2KF3jZQMOv0KxuhDjzCMl2tKdJTw=;
        b=mXjUaU3vSL9lteURHVdbn96erZ2+nFGeX3202mVmI04ERzN/nUG2YDIBEpSrEZTdXu
         BvGw43RlRIH6viQ5GK36zKSz6zU6gOGKVYaSeuUqoGLGgg4x/GONUFlOXyqaOk67K1W3
         KXm6KFGAWsEODvfEgKaPQ9wbIix+1IgSpK7NxL4sQU4tTN9yPIxjoRP3ZEkD6GlKUEFj
         f/JRF9Jr+R49x0ozXoYB1mz92FlKC7rirhIA47kegEQbDnUyPKtF4iIe6gtmbTIUUgx1
         sEgkSppb0RsiG0aKxWkEtwL3F2XC5PRohEQMMDBT2KoyPw2x97f6G7fCEbcKBB4r9y1z
         WlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=69t2zaQiM68Ndj+2KF3jZQMOv0KxuhDjzCMl2tKdJTw=;
        b=N6CseHZAnSrmt/XX9COHy9pVYBdU+RZ8fZTp/WGnCZU4Q+zUnEB8gDXA0w39EhSVJ8
         9+yDcvxGlPpkUYkgQnBHmWMWAp++4bi6k06xCHyqFdhPdGa6lxhw9RXmRb4syJsvncsl
         hG0lg5Hoh5C7rasee1Wr6atOlZvmx2dIY/qbh4+MnOsjY8P/5PqwXDgcN/cIAb4+e0/m
         YrTGgoygDG6zyAcJ9PFxikREoyE6kULYOALjBoLS/A1h/yT/jmIe5AeQhRmOLVi+5wCk
         gyQfr6wVSrVAQRIKozE+e48Mg3cwWkbPe+HujK7W+Vs+2f+4awM/OC+N57VqFRZsjxnl
         wmjg==
X-Gm-Message-State: AFqh2kq+g/M1IkNMcd04U8VNob6Hb8PXWcHZhF4qZBWPKcbGKr6bGFON
        guz/hTQcKuhZUsPaxnpqrEVp273ueUBh7A==
X-Google-Smtp-Source: AMrXdXvVJjzo2/xYnqBD/NW1B/lR7fZuxOl8pqo/ahCVq2VPKtPcjc3oU0g+6fnavzLAuh1KJ1Kdmw==
X-Received: by 2002:a17:906:36c4:b0:85c:e3fd:d39 with SMTP id b4-20020a17090636c400b0085ce3fd0d39mr17080707ejc.37.1673976081451;
        Tue, 17 Jan 2023 09:21:21 -0800 (PST)
Received: from debianHome.localdomain (dynamic-095-116-176-035.95.116.pool.telefonica.de. [95.116.176.35])
        by smtp.gmail.com with ESMTPSA id sb25-20020a1709076d9900b007a4e02e32ffsm13526242ejc.60.2023.01.17.09.21.20
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:21:20 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] mcstrans: preserve runtime directory
Date:   Tue, 17 Jan 2023 18:20:50 +0100
Message-Id: <20230117172050.18462-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Do not remove the runtime directory /run/setrans/, which is the parent
for the security context translation socket .setrans-unix, when the
service is stopped, so the path can not be taken over by a foreign
program, which could lead to a compromise of the context translation of
libselinux.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 mcstrans/src/mcstrans.service | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mcstrans/src/mcstrans.service b/mcstrans/src/mcstrans.service
index c13cd09a..fdcfb0d4 100644
--- a/mcstrans/src/mcstrans.service
+++ b/mcstrans/src/mcstrans.service
@@ -9,6 +9,7 @@ Conflicts=shutdown.target
 [Service]
 ExecStart=/sbin/mcstransd -f
 RuntimeDirectory=setrans
+RuntimeDirectoryPreserve=true
 
 [Install]
 WantedBy=multi-user.target
-- 
2.39.0

