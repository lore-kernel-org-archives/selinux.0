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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AC0C07E9E
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 17:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2652F61C44
	for <selinux@archiver.kernel.org>; Tue,  6 Jul 2021 17:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbhGFR50 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Jul 2021 13:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhGFR50 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Jul 2021 13:57:26 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AFCC06175F
        for <selinux@vger.kernel.org>; Tue,  6 Jul 2021 10:54:46 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id he13so16875183ejc.11
        for <selinux@vger.kernel.org>; Tue, 06 Jul 2021 10:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5+1JDzrlvP2/smXY+aB9mE2VxwJat1s6od2tQR7lYn0=;
        b=kA6/IjkbgLTHMRiDWz9AJnz5ouJbacmMw1GdWJCVd1tnfcmM7tGGQHK3SYNsv/T4AX
         o4qmQy9bRVvzp2BAqznHEYFJv3vuD3/MBeEOZ+arpgw0oK3maZRt/gKOB6XvSNVLwkHh
         lrYoxbWchPw6c3CYrl5iPIUCAH5OXXOdL+pBVXZwUnogycMJjTW4C3fnW2qB5OggLRL/
         kJCFxfmu53on/p4folRgDyBdlCz6kyLjxxyaBP1EsYmWA+dCZQUjKCr8yCK9qQxI4oku
         ah20uc+diOHuu196I25DvVU79FIuXV3ds53dc1B1fwMZhI+FPaY9vvan11cTPX3lgDnA
         n89w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5+1JDzrlvP2/smXY+aB9mE2VxwJat1s6od2tQR7lYn0=;
        b=WYXBJDKr1W+NB/f7XjpeN+ORREID+PM8hkU+lcTAYVWF1OeSNBZCTRpq/enoqnHuYp
         GrWJeBABLWP9X8RnMU6RYZX7SxhoZTVTe/xqA2swFM54rh4uIV4soSQxKdOZ07vbh8e+
         2tW+YrDUnXSmCHRBFEHyiJJklTaj2KO3GGpmz6orp2bfX325PWlw5AQ/1TnrMgpM6Zqg
         V4GjRgkJkYEtpAjmt4Kb7OqvGDQiwOeEzGpEdh0WtqbgtfZrSTSrZHkhGZN5qWzIoSG5
         8y1sruXOaub1Nkfuy5PbGPU5+00P4GkKSqRm9vFz4F7Blgxf8OBTNntfuzTKjPy1y5o1
         UIhg==
X-Gm-Message-State: AOAM533aqWOFTndNu+K+NhlpJo3jyeqbmDlcIb90NvJxmMtcIuq96KSi
        UK+cK2iKNTpw1XSFgXpkB30AqvVUS80=
X-Google-Smtp-Source: ABdhPJxi5Qw6IJGND4MyPCyOW30xrqmWFlwX/KjLjIc9P5gJGbMzTqUBDN1seu5p5MxlbbUzf6H9uw==
X-Received: by 2002:a17:907:3e0b:: with SMTP id hp11mr20492230ejc.523.1625594085372;
        Tue, 06 Jul 2021 10:54:45 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-095-116-100-174.95.116.pool.telefonica.de. [95.116.100.174])
        by smtp.gmail.com with ESMTPSA id lg16sm6050950ejb.69.2021.07.06.10.54.44
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 10:54:45 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 10/13] checkpolicy: drop redundant cast to the same type
Date:   Tue,  6 Jul 2021 19:54:30 +0200
Message-Id: <20210706175433.29270-10-cgzones@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210706175433.29270-1-cgzones@googlemail.com>
References: <20210706175433.29270-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Found by clang-tidy.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/policy_define.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 370ff8e3..462e3994 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1796,7 +1796,7 @@ int define_bool_tunable(int is_tunable)
 		return -1;
 	}
 
-	datum->state = (int)(bool_value[0] == 'T') ? 1 : 0;
+	datum->state = (bool_value[0] == 'T') ? 1 : 0;
 	free(bool_value);
 	return 0;
       cleanup:
-- 
2.32.0

