Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F987C47092
	for <selinux@archiver.kernel.org>; Tue,  1 Jun 2021 15:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10D1060E0B
	for <selinux@archiver.kernel.org>; Tue,  1 Jun 2021 15:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbhFAPHR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Jun 2021 11:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbhFAPHP (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Jun 2021 11:07:15 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDF9C061574
        for <selinux@vger.kernel.org>; Tue,  1 Jun 2021 08:05:32 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id j10so17741594edw.8
        for <selinux@vger.kernel.org>; Tue, 01 Jun 2021 08:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6tqoYMbPLYSnvOmnsaWXnkAOjPrl48psAFbIIButfQg=;
        b=Ui4rvjT4xO6QsVm8PAaAjePPH+vT3L+9vsLCmXV3qV09n7CsKPbEt4aQVvbVYQ1Z+3
         rK1aTtlyNtV4zJxkDCg8H9kP53nv70Bt/ZyISqSNkpWEDIxqTFkzAqnQd57d4MPujYvW
         zGhoDCP3ckfYuo1o5zuvAur9PH3P2u/a9ckeAAAGe2pHSzbaQcTKqFGF4imOX7J45YUd
         0AVhQKBc2XqIaorleqOTacX5evcsF69GDlBHkwBWdy+lvgq7ZtNJl4K4+h9yguQ2nZU0
         0FFeycNbUgB0SSkKMVGr29QHgRPmVrHlm1OuV1WvCwr3o90a8+5J4Vg435xw9ZjX5hTG
         wtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6tqoYMbPLYSnvOmnsaWXnkAOjPrl48psAFbIIButfQg=;
        b=RasJm/UNcY5QxgyuOa6ZjlQT+CP5rLvrmmmq8OYPpzhMSgQf50HM2hBs6elazv7/06
         HRqVvw+V9DyWgZ6e4XObrOzwJIb9zHKs7xn59fzpxbrwup5W0Ys6zfsLJ8NXVPK+l2ss
         bGrPRsLbq2CPYQajVlMsPCpyKK+BhAkXgCaE1uabgFS3FgzXy6boZ7aZIRC+d6rjqy+d
         fb/zGMUYNW32hf8MDVaHY06mXM15Hta8JNP0qFIr19L7ddy7CHNUG9hc6Xv9JKsrvP2E
         jVBNTGpdIitSoqpPPKwNYOpglaCW03DNGxYFueQbIvSHq1DsydPAeV8xYmoieUUj/M5J
         Tgiw==
X-Gm-Message-State: AOAM532hsOvYcn0vUGLPJS6+A7VvsO0AghyhukVJe3BFPSpOg1QGPnIG
        0maL7vFWUlQv8ycdeTCD7FKlv6fCHus=
X-Google-Smtp-Source: ABdhPJwmZWpnH6ddiURR7+7wGaduB0D5Qr8N1N9zSxsKf68x3w02hyq5OyqZuBLYBi4u8vWaNZ0eFQ==
X-Received: by 2002:aa7:c9cf:: with SMTP id i15mr32131194edt.118.1622559930766;
        Tue, 01 Jun 2021 08:05:30 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-198-161.77.0.pool.telefonica.de. [77.0.198.161])
        by smtp.gmail.com with ESMTPSA id j1sm8606394edv.14.2021.06.01.08.05.30
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 08:05:30 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libselinux: selinux_status_open: return 1 in fallback mode
Date:   Tue,  1 Jun 2021 17:05:23 +0200
Message-Id: <20210601150523.7016-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0.rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

In case of a recurring call to `selinux_status_open(3)`, which
previously has been opened in fallback mode, return `1` according to its
documentation.

Fixes: c5a699046f4 ("libselinux: make selinux_status_open(3) reentrant")

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/sestatus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/sestatus.c b/libselinux/src/sestatus.c
index 531a522c..89c1f621 100644
--- a/libselinux/src/sestatus.c
+++ b/libselinux/src/sestatus.c
@@ -283,7 +283,7 @@ int selinux_status_open(int fallback)
 	uint32_t	seqno;
 
 	if (selinux_status != NULL) {
-		return 0;
+		return (selinux_status == MAP_FAILED) ? 1 : 0;
 	}
 
 	if (!selinux_mnt) {
-- 
2.32.0.rc2

