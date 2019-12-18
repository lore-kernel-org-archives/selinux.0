Return-Path: <SRS0=xVDs=2I=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E981C2D0CD
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 14:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44B17218AC
	for <selinux@archiver.kernel.org>; Wed, 18 Dec 2019 14:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fKNCBT8K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfLRO2U (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 18 Dec 2019 09:28:20 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35258 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfLRO2T (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 18 Dec 2019 09:28:19 -0500
Received: by mail-ed1-f67.google.com with SMTP id f8so1818274edv.2
        for <selinux@vger.kernel.org>; Wed, 18 Dec 2019 06:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XjZnZBvmttmeOGqpL8pbqDIP10Md33lrux7FtyE8cpo=;
        b=fKNCBT8K8tRVrQDdyNagzrANSXhb5xE6nPvq8eIH2p5khxec93Gz8rgSQmMTGcv89E
         cEcIv+OvUiWojW1zDktL6o1D9HED3zrsj1B2dhT7EgqAs8XNKSOamTR1MvRyWUHskl4S
         lg285fJOab3nUwx7i9zjgcdPjs595ngLDA7ZelhSW3ncSu1u2Ai8mpVZwywdiNEZWa5d
         XGGg3rgPLeC3EeHZRgy3554nZHYE4TgMw6u2qFXJWZraSMB1OmuDFYb41jz+K+Y2nRJg
         GG/AZz3N2X1Q7dIfDTNwoFox7xzyZoaGyYXk1K4PRcqMiZpFiCdlKZXzHTtlWghrqdWu
         HEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XjZnZBvmttmeOGqpL8pbqDIP10Md33lrux7FtyE8cpo=;
        b=TUbptpOpzwuvr/p8qzHvhhJsthzViQaoXvR/uegIelRSA0lsxEX8dTDLg3zxoUGG3O
         46/Kn7N6S+RofHmi5iFt/qfESubw1VO5DDDXHkULG4ia6CgVz1Fg/oZov7Tgi74gW3gu
         9WCpo0Mx6vhOYaoQGeQYnvRNKk2A+TeMtXxiJVrbwCN4++/uQpBI/e/4SS2LOQCX5D+m
         okODC/ZD0VxbKbTAIpIPSrTBZvE95NdgLIgzqCjimB33ed5yYu3BHEcVlAEQ3fLGOI2u
         Jt6ppirZONPw6M+jvB4NY9Q3HTp9CBqDGTBkS+rxd+Op/xda9wDzfN0bB6wSulqpOKU1
         Yw9w==
X-Gm-Message-State: APjAAAXRrAfpd/xgpG3IyLE+qyiGeefWYg2mwnNpT2wsJrCuww309uvl
        PavIWFuq+2P2nYknkPNTtg9Tys/k
X-Google-Smtp-Source: APXvYqxLmLlavZTtmNWCOIe8ZQaRgJW+0w50jT2sXUeLqUPOMmwRTsFXF2ERoX5dqpk+Fog9KsI+Sw==
X-Received: by 2002:a17:906:2cc6:: with SMTP id r6mr2918687ejr.227.1576679297502;
        Wed, 18 Dec 2019 06:28:17 -0800 (PST)
Received: from desktopdebian.localdomain (x4d015122.dyn.telefonica.de. [77.1.81.34])
        by smtp.gmail.com with ESMTPSA id mh16sm96826ejb.46.2019.12.18.06.28.16
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 06:28:16 -0800 (PST)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 1/8] selinux-util: increase log severity
Date:   Wed, 18 Dec 2019 15:28:01 +0100
Message-Id: <20191218142808.30433-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218142808.30433-1-cgzones@googlemail.com>
References: <20191218142808.30433-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

`log_enforcing()` and `log_enforcing_errno()` are only used for important messages, which describe failures in enforced mode.
They are guarded either by `!mac_selinux_use()` or `!label_hnd` checks, where the latter is itself guarded by the former.
Only SELinux enabled systems print these logs.
This helps to configure a system in permissive mode, without getting surprising failures when switching to enforced mode.
---
 src/basic/selinux-util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/basic/selinux-util.c b/src/basic/selinux-util.c
index 2c6d407295..1d209d03d5 100644
--- a/src/basic/selinux-util.c
+++ b/src/basic/selinux-util.c
@@ -37,8 +37,8 @@ DEFINE_TRIVIAL_CLEANUP_FUNC(context_t, context_free);
 static int cached_use = -1;
 static struct selabel_handle *label_hnd = NULL;
 
-#define log_enforcing(...) log_full(security_getenforce() == 1 ? LOG_ERR : LOG_DEBUG, __VA_ARGS__)
-#define log_enforcing_errno(r, ...) log_full_errno(security_getenforce() == 1 ? LOG_ERR : LOG_DEBUG, r, __VA_ARGS__)
+#define log_enforcing(...) log_full(security_getenforce() == 1 ? LOG_ERR : LOG_WARNING, __VA_ARGS__)
+#define log_enforcing_errno(r, ...) log_full_errno(security_getenforce() == 1 ? LOG_ERR : LOG_WARNING, r, __VA_ARGS__)
 #endif
 
 bool mac_selinux_use(void) {
-- 
2.24.1

