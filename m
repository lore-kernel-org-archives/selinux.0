Return-Path: <SRS0=6moO=64=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E3DC433DF
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 16:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A2412065D
	for <selinux@archiver.kernel.org>; Thu, 14 May 2020 16:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="RIJ6zhoJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgENQJc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 14 May 2020 12:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgENQJ3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 14 May 2020 12:09:29 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74014C061A0C
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 09:09:29 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u16so33467931wmc.5
        for <selinux@vger.kernel.org>; Thu, 14 May 2020 09:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8xL1/nQH01hBgZAMEcAeBGGMoCJYdpq9Gs9HzoylV3A=;
        b=RIJ6zhoJxJaOVCgHVfBmkzNhGZ7C4KMMgGSGaqaenfq6z/B/+/pftGTE9SNaPq4qoA
         eODxUuMhvxMFKBClDwD5Os5TkrxRBnOULdVlAp1bzqpk9v6wXaZtP1GFwcv0IJeQmBK/
         joqrnKGhCm75EvS7EkCKs4tCee39SAQVjqiWLH++OMsUrJ7CuGIiF9NrjGTex0YJDObj
         1t3T+m8I7jgaaXfl/xTPnwasw4k+gfBP8b80g8hfVqi7ao6dEHcfeocyCywyHpc5Kilw
         BOgFMs7hro3eLCpCc2rHucHeEKPwD3sEdxVwPvt+5SpFiIvHsPZQ4Xun/ydF5Jv0f5P9
         B0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8xL1/nQH01hBgZAMEcAeBGGMoCJYdpq9Gs9HzoylV3A=;
        b=ak5FXRgXYTUMM+i+yKpzmzq2OARZQ9lxxHGouXWy8OOTYaTgtMsJE9wHZGNgOzTL5l
         Qlu2TWWptiQ3iHMlt4rclMKhzDVhFbgxidrTT1ywqd6dtt3odxi6Wzq+07jDp9W1MQaG
         WtNBkm2u8cqjjixcmN8Nm1k8gwpei8GxHBOOpOBE9JBwD5Mkik1Dgt4HBcQVD8J+5f5a
         XAnM1N8fxaYmW/kuXE2ocNtSsNjbkd/hfbNEGq5dQbUYYnUUM9tP2h3LeskAJhWg89/k
         UoiPQnOW56KaQadAZNSY/k1JUSNRmqWIvRHcCjS5K+AFu45wu6wiE8fcD8tjY+t657zB
         FbOQ==
X-Gm-Message-State: AOAM5319TgcIY+/8FK9Jixg4wkz1fevE7MvPX8B0CHSbMxwMl69wuZYg
        UUYl5PsXia5XjpfLlACq+NETFQS7
X-Google-Smtp-Source: ABdhPJyPBLDprL6CTyEDL3H1Je5CbEJLQPidp9cRLlxSoF9Q5r6vyFTGTVBF/K6WcBYRs7G6aaqToA==
X-Received: by 2002:a1c:7914:: with SMTP id l20mr15281568wme.120.1589472568017;
        Thu, 14 May 2020 09:09:28 -0700 (PDT)
Received: from debianHome.localdomain (x4d0094c9.dyn.telefonica.de. [77.0.148.201])
        by smtp.gmail.com with ESMTPSA id u127sm41184587wme.8.2020.05.14.09.09.27
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 09:09:27 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH] selinux: add note to avoid permissions with _perms suffix
Date:   Thu, 14 May 2020 18:09:22 +0200
Message-Id: <20200514160922.37513-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The suffix "_perms" is used in Referency Policy style policies for
permission macros, bundling several single raw permissions.

Add a note to not confuse policy writers/readers.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/include/classmap.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 986f3ac14282..b06ea7b23760 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -2,6 +2,11 @@
 #include <linux/capability.h>
 #include <linux/socket.h>
 
+/*
+ * Note: The name for a permission should not end with the suffix "_perms",
+ *       to prevent confusion with Refpolicy style permission macros.
+ */
+
 #define COMMON_FILE_SOCK_PERMS "ioctl", "read", "write", "create", \
     "getattr", "setattr", "lock", "relabelfrom", "relabelto", "append", "map"
 
-- 
2.26.2

