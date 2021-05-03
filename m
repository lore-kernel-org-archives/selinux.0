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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E77C433B4
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5601761183
	for <selinux@archiver.kernel.org>; Mon,  3 May 2021 17:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbhECRrk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 3 May 2021 13:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhECRrj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 3 May 2021 13:47:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D35C06174A
        for <selinux@vger.kernel.org>; Mon,  3 May 2021 10:46:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id w3so9160759ejc.4
        for <selinux@vger.kernel.org>; Mon, 03 May 2021 10:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=puFpeJ8xPj2aaiwVvulUlTByr85/hI/Yk9PaKda99Lc=;
        b=QsrHuk7+26muP/9HWz0SBa3glfjkrp/I6cVHAbL82W9WlUHPG5xS4eEN1B9IX5xu6I
         tmzCFGN0coA/+gD+lP4LPnRoiZdpHP+r9tTCu7h+VaW55bsUgpXY7AJ8ZRHDcFH0Iy4Z
         enVRkyxh9FHTaMyVT/vBOzHvnLfoVW9vEKFKR9Zvh8YuAYZDcffVPKvSEQZiow1xWlOO
         slCaFOlz4b3kG0akI5SibPc1tWmxx99jm3ew6uFChzrtSTXHvqoQZFdy1W2q+lP9gMhk
         DXODJanYHOFBxdsA/AxMoZdU1fHnezNSOgpGeBpJc2uP36J7voiWRAZFD5cPx24e3jbi
         /4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=puFpeJ8xPj2aaiwVvulUlTByr85/hI/Yk9PaKda99Lc=;
        b=eic+olcdvMaCBGBV1oKqgQ0kU6GUUJ3AlPW96BAuI3Y33QFGBvPBcyYVmQMkCLTat9
         cencoMLsAlmc9TKClY9jBVn8wTI3bMNAMBSuASxgB38rb4TcKYg3XSvDs8VQBKOA5nal
         41A+O/IMLV1FwVFNZJIVf87r5+HYwn8SvLf0e2VyRJ1TFAOYamFwSnMMS5FSEIwRWlCv
         rbiRn113JUQtQFzqY8LambB43GojHB8lBATRs9HAvrxaj40EFcQJ0ZfK7tYrJX63J3Yl
         2ZUY37GXqdtfdvNMbOYuAQfVLIHGfubncRNpayZVzdAPj8dXmGCI4IqaGPwJn1QJswrG
         rGCg==
X-Gm-Message-State: AOAM532xRwU4+bxlq5uxfdDSS/tcJPArH8GZIK1CxGW6nJwux4Su32lc
        vRwEyDrhGOZSGR20/+134odnFCWaR88m2g==
X-Google-Smtp-Source: ABdhPJw9r7q57GtDeiFAf6VTObK6zoZxbp4drIoZyFG900xKohY1boBcs12PKEgxbrTt+No3Flqt/Q==
X-Received: by 2002:a17:906:fa19:: with SMTP id lo25mr4511602ejb.394.1620064003895;
        Mon, 03 May 2021 10:46:43 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-000-172-037.77.0.pool.telefonica.de. [77.0.172.37])
        by smtp.gmail.com with ESMTPSA id u11sm12636985edr.13.2021.05.03.10.46.43
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 10:46:43 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH] libselinux: selinux_check_passwd_access_internal(): respect deny_unknown
Date:   Mon,  3 May 2021 19:46:36 +0200
Message-Id: <20210503174636.54579-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

`selinux_check_passwd_access_internal()`, and thereby
`checkPasswdAccess(3)` and `selinux_check_passwd_access(3)`, does not
respect the policy defined setting of `deny_unknown`, like
`selinux_check_access(3)` does.
This means in case the security class `passwd` is not defined, success
is returned instead of failure, i.e. permission denied.

Most policies should define the `passwd` class and the two affected
public functions are marked deprecated.

Align the behavior with `selinux_check_passwd_access(3)` and respect
the deny_unknown setting in case the security class is not defined.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/checkAccess.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/checkAccess.c b/libselinux/src/checkAccess.c
index b337ea64..022cd6b5 100644
--- a/libselinux/src/checkAccess.c
+++ b/libselinux/src/checkAccess.c
@@ -78,7 +78,9 @@ static int selinux_check_passwd_access_internal(access_vector_t requested)
 		passwd_class = string_to_security_class("passwd");
 		if (passwd_class == 0) {
 			freecon(user_context);
-			return 0;
+			if (security_deny_unknown() == 0)
+				return 0;
+			return -1;
 		}
 
 		retval = security_compute_av_raw(user_context,
-- 
2.31.1

