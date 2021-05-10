Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83139C2B9F7
	for <selinux@archiver.kernel.org>; Mon, 10 May 2021 11:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D35610A7
	for <selinux@archiver.kernel.org>; Mon, 10 May 2021 11:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233494AbhEJLW0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 May 2021 07:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235795AbhEJLGJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 May 2021 07:06:09 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC76C061763
        for <selinux@vger.kernel.org>; Mon, 10 May 2021 03:56:52 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a4so23860575ejk.1
        for <selinux@vger.kernel.org>; Mon, 10 May 2021 03:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/rcmJv8nTcbgRLLFgkz6QJI4jGsZ2XdOfQEYgTdv044=;
        b=rZv1PeoJKGfS0Quz9QXMXLQztBNT+C3YrERUyHnnEOQJXjBkX4BCvOnCpQ1KDXiJ5x
         oyNnI8yPn9BMYcvjXfqTyJ9l1/xgqVcwqupB/FEE7cwqDUBCOQ9MSTbS22Zq7vpWg4zg
         21bzlWhZKxcFldQymIYQgMybVLqzp0dGk0QfOD2mFceWfAZsOCLXazpAnNzI2DNMIBiH
         C8/PccTHyatQJdLPVjPo/6LjuZxL7pfkeuaYTvMThzjD41PTSeWPsfEWrPrlBBMBXcaX
         E6KYQhP/PUsYA365ZAIggdcOVvhopaa3mH9B/xWXgcqIOoT4cJR33Q9V/R/ixQI2y/fZ
         1fIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/rcmJv8nTcbgRLLFgkz6QJI4jGsZ2XdOfQEYgTdv044=;
        b=ZJkYKhwLSBbzuykM0kbEr1662DJwZeTpba7ydk1e2jT4TqyisUP4/C1ky9VcKMsweo
         hCfxD3TU2LG6DU2XdjZGM+S0KtLVMb4PmdHnQMeR/tLZel1WhUvIA/GZHWJ+zgRona2N
         qY1Rt4qVrmjTcxyRiTRGeDCd74tznBrpBu3jpeO1BjngyXJlEH+MM34cK49+S1m7IKN7
         00t/o0utVWSqqK9Nqk8YEjwUKjoFsBgnLp7lfJvJGkDYThdwhRiiqc9tBvFEXbFkupuJ
         ORzMoPyC4OFAV8m3T6VQcPekLZKPx5Mp4fYn5ol+Pc1b4U20CMRC+1KQFmCPG6fJftKD
         FVig==
X-Gm-Message-State: AOAM53264LWfhGHDCHYoGhDGufsHeAwUoXnaDlAlW6lLmSqfPWZXF5md
        VUu1PQw7LTn8KGAif5ZPr15EiSV0JiuUQMMC
X-Google-Smtp-Source: ABdhPJwFcpM3P/SXEvDGOjeqO2qHVXbtI4AiJjA7qwLH0oQncDpiEDEmazqqNUxfzA9ugZV83VbTkw==
X-Received: by 2002:a17:907:20f7:: with SMTP id rh23mr24580928ejb.276.1620644211028;
        Mon, 10 May 2021 03:56:51 -0700 (PDT)
Received: from debianHome.localdomain (dynamic-077-003-162-005.77.3.pool.telefonica.de. [77.3.162.5])
        by smtp.gmail.com with ESMTPSA id z17sm8884162eju.65.2021.05.10.03.56.50
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 03:56:50 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [PATCH 3/3] libselinux: do not use status page fallback mode internally
Date:   Mon, 10 May 2021 12:56:48 +0200
Message-Id: <20210510105648.14635-4-cgzones@googlemail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510105648.14635-1-cgzones@googlemail.com>
References: <20210510105648.14635-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Currently `avc_init_internal()`, called by `avc_open(3)` and
`avc_init(3)`, does open the SELinux status page with fallback mode
enabled.

Quote from man:selinux_status_open(3):
    In this case, this function tries to open a netlink socket using
    .BR avc_netlink_open (3) and overwrite corresponding callbacks
    (setenforce and policyload).  Thus, we need to pay attention to the
    interaction with these interfaces, when fallback mode is enabled.

Calling `selinux_status_open` internally in fallback mode is bad, cause
it overrides callbacks from client applications or the internal
fallback-callbacks get overridden by client applications.
Note that `avc_open(3)` gets called under the hood by
`selinux_check_access(3)` without checking for failure.
Also the status page is available since Linux 2.6.37, so failures of
`selinux_status_open(3)` in non-fallback mode should only be caused by
policies not allowing the client process to open/read/map
the /sys/fs/selinux/status file.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/avc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
index 8314d7ba..daaedbc6 100644
--- a/libselinux/src/avc.c
+++ b/libselinux/src/avc.c
@@ -214,7 +214,7 @@ static int avc_init_internal(const char *prefix,
 		avc_enforcing = rc;
 	}
 
-	rc = selinux_status_open(1);
+	rc = selinux_status_open(0);
 	if (rc < 0) {
 		avc_log(SELINUX_ERROR,
 			"%s: could not open selinux status page: %d (%s)\n",
-- 
2.31.1

