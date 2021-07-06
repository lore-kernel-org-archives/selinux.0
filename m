Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E103AC07E96
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 17:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C704661C3C
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 17:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbhGFR51 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Jul 2021 13:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhGFR50 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Jul 2021 13:57:26 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE90C061760
        for <selinux@vger.kernel.org>; Tue,  6 Jul 2021 10:54:47 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id m1so29170282edq.8
        for <selinux@vger.kernel.org>; Tue, 06 Jul 2021 10:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+HGkori73bQZSmpkTJo4RO4NyngSpe/QDhj/TY3MWgM=;
        b=hLfarYaRnPsp7UTIahQ1bzG6FhZs5JpIWKd5hksxOmHZVonUrVi4UoZSlECYUxrO80
         YFlorRdlqpvRpvBbuYr8pmCSRg8sQcLcj7/XWT65LZ8h6jtPB83BzXDmuiH9BchCIvGQ
         gUxi4gPyzMIFY14vYk4iXTt9NLiLZv9njXxvCOxu7D3NywW/oXYtIsvjh4Fsq1lr73nH
         C6ReD7i32NZ/BS6CFJ1oa1fVVVeBbkv/vV6rsd38UtR0JoBTb2uyBRmTvTdQT2/cf9Km
         /AEPUcFqzRTfNzCCtZaodgdZLthlg48H9GYL4SEgzkOgO8+1HFKuCI+stft0mVoDXL3B
         p6qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+HGkori73bQZSmpkTJo4RO4NyngSpe/QDhj/TY3MWgM=;
        b=U+mKjnui7dP2A25tmD059XdYBaQms4vR6PNx9Wkr0zwtB4B5N+lJEypQtwVoGuRNsR
         1WxXDMw8C7mXtVRmDWcEDnNBtz5vJn5vIBayjVLZOv3wzARH+HsWV6he38HoUAqrcV94
         nFxn6ec7Wn5CpxYho7dydv10e6a7CjyT5dL2LSstUu9kKEPvE483SxRYKz3WNN10sCZR
         inpSJ82r5VWvOi3W4uqt3Hv/E4uYbxBXgzotBXNg86wlQk0SFXzQMFpJB4Ph9K0jULF9
         UUItHdRgYnUBNlrqDx+tnecbuwR6wIf6exdcjfAMMWhwqRl07QHCb/k3dK/KRwwfuBtM
         dwhg==
X-Gm-Message-State: AOAM533A07wxwoY88eT9Fwao0QzPHB9lY63c9LhIuca8RSbaZ1UqJX9Y
        VvFzqyvKp40Ct2bg28MKn4yaMYOLOno=
X-Google-Smtp-Source: ABdhPJxn88Bcmm6yrpz4XnwaG1y72C4O55gPYCbDd8gl4/CW+RtTwGO8Sbxwu0zXtERtNS2JAdvOKA==
X-Received: by 2002:a05:6402:1688:: with SMTP id a8mr22878080edv.4.1625594085955;
        Tue, 06 Jul 2021 10:54:45 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-100-174.95.116.pool.telefonica.de. [95.116.100.174])
        by smtp.gmail.com with ESMTPSA id lg16sm6050950ejb.69.2021.07.06.10.54.45
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 10:54:45 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 11/13] checkpolicy: parse_util drop unused declaration
Date:   Tue,  6 Jul 2021 19:54:31 +0200
Message-Id: <20210706175433.29270-11-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210706175433.29270-1-cgzones@googlemail.com>
References: <20210706175433.29270-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/parse_util.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/checkpolicy/parse_util.c b/checkpolicy/parse_util.c
index f2809b48..1795e93c 100644
--- a/checkpolicy/parse_util.c
+++ b/checkpolicy/parse_util.c
@@ -28,7 +28,6 @@ extern int yyparse(void);
 extern void yyrestart(FILE *);
 extern queue_t id_queue;
 extern unsigned int policydb_errors;
-extern unsigned long policydb_lineno;
 extern policydb_t *policydbp;
 extern int mlspol;
 extern void set_source_file(const char *name);
-- 
2.32.0

