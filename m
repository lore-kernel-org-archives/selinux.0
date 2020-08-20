Return-Path: <SRS0=r9sn=B6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1978C433DF
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 15:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79B3C206DA
	for <selinux@archiver.kernel.org>; Thu, 20 Aug 2020 15:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="qixFvoo5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgHTPQn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 20 Aug 2020 11:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbgHTPQj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 20 Aug 2020 11:16:39 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E55C061385
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2020 08:16:39 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a26so2983494ejc.2
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2020 08:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Jj4OewNc8SUNJrPdf1DKOyzfNDUns5TZTwi5DAqpwc=;
        b=qixFvoo5hyw4Vyuf2ltlwb2jglEtJyyJXEV2XCkMP5S8y+3Kr6IZk1kBA51L7C/pa7
         7dZy2guMZCHrreDj9O2Zu4dF+T2M1XwavocP033fzonExq+i/4+gVyxSCbc5EB/53YT6
         y3c+AhAMhZX0Uu0vz7vOClgXt8YVLeuhSEQo40RXKPTlVOQ27pLr1Fh5pxkQz1PqUMZq
         0Id6WEFreSv5ELMOghVpBNw7H1/lttDU/PmXFa683Oszr711fQx4iJnr3dQPkH9O6npL
         GJgJ+gcRnbxyjRaYnA/nnkHMA5tn++nv+9PE0uFHMSs4mgsK6Llw8gD6WiFz/DvbqRgx
         aIZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9Jj4OewNc8SUNJrPdf1DKOyzfNDUns5TZTwi5DAqpwc=;
        b=jTAA2IxrO7cBYb5yHlFrKbMgfbDS9sW563MUFAuK+D+NhV9s3VNkDLHYY7Pw0zah64
         AsaKn7PQYq7ifLGu5/YfO/rWdK3YPaSjze+wLCxMgADivT0Minducix3DQfarVT7n0gl
         DLW/CdliZtx1V6F8Q/9srCO4zZUS1ZijtfUz+OWtErs3KTquRTr3B38piXbIuoHcji/x
         PKMUVXfYXgAJROIoYcLyIf+XeyT4eOnOrHBVRbBMcQQ33v+lC+ZNJFgtRW+LTNGcGS6u
         5gQDg7tlKmX74DJuFDUq49nEJ41fRb3/zClNSqaFg5z/8JERpHH+1cq5VtsvuSQ/PfBU
         w4GQ==
X-Gm-Message-State: AOAM532ws/3cdTLo4lk8hSwikB/yEQMPZhd0Z9M219oi1WoxnoJPoFfk
        ufaV+QOHsghCliwY0TfRM72N6qKHNxo=
X-Google-Smtp-Source: ABdhPJxTmlfQm3S8EDhNhuIOZ0e5REaKQOINYYzsBMhbKUb3HOfukKjm+/ZgW/KpO261VYnr3Uq+Rw==
X-Received: by 2002:a17:906:9382:: with SMTP id l2mr3628333ejx.513.1597936597630;
        Thu, 20 Aug 2020 08:16:37 -0700 (PDT)
Received: from dlaptop.localdomain (x5f708693.dyn.telefonica.de. [95.112.134.147])
        by smtp.gmail.com with ESMTPSA id d7sm1599797ejk.99.2020.08.20.08.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 08:16:37 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Cc:     =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] libselinux: use full argument specifiers for security_check_context in man page
Date:   Thu, 20 Aug 2020 17:15:51 +0200
Message-Id: <20200820151551.18235-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The argument for security_check_context(_raw) is defined as `const char *`.

Say so in the man page.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/man/man3/security_check_context.3 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/man/man3/security_check_context.3 b/libselinux/man/man3/security_check_context.3
index 2b9a2d4c..213ac282 100644
--- a/libselinux/man/man3/security_check_context.3
+++ b/libselinux/man/man3/security_check_context.3
@@ -5,9 +5,9 @@ security_check_context \- check the validity of a SELinux context
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "int security_check_context(char *" con );
+.BI "int security_check_context(const char *" con );
 .sp
-.BI "int security_check_context_raw(char *" con );
+.BI "int security_check_context_raw(const char *" con );
 .
 .SH "DESCRIPTION"
 .BR security_check_context ()
-- 
2.28.0

