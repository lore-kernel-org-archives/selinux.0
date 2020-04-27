Return-Path: <SRS0=pnJ1=6L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60A2C54FCB
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96DC8206E2
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWVLb8BX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgD0UXi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726776AbgD0UXi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Apr 2020 16:23:38 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73E8C0610D5
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:37 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a7so119583pju.2
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zfah9HSGQgGYpQi+daihMCdQ48cIJqxp2wzwkAq8SWQ=;
        b=fWVLb8BXY6mp6xSVNWNbTKXqyU7PxAOTfXGeefIb/nZG/s1TNxVCWjiX+nJ3P6AR0n
         1OIeY5PIXTlHsvsDGw8pxRq5K/ez783cLmc4ZF6l3dwXQSf00DzkJKtooIEKY1WeHzte
         EZrzIjR50wXzAe7j/xcCIseocwr7h6x9dIK6BrtODOhiUR8ByfSLc/q+pJsmkzdkP9ie
         AaGERGvKJ8/aH8dsjSghvUJwfXrv2nCxKHOOQDDe4N+Qjr2aSk8suFfo+XjpqKUaJD+8
         P4xSLf5u7YUaSZ3BZU4ISS1A0NKcTWHzF1Q02iKDlcVzE8oZ0tiJ3FjgVz1GARYBNBM1
         IBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zfah9HSGQgGYpQi+daihMCdQ48cIJqxp2wzwkAq8SWQ=;
        b=GQ4ZeO4a3gNJQQv3hmqImXSJ/WnanPr+nDnXWP0kM612QvJCxuE0gIjEpZqjXK0dt0
         jYf3foWDMj1sj+yjJxZybb0FdTCoMSi8lq5pbtayAisvC2ES8cFwJWh0S4JiQaENgrY7
         u+aTRsqmGz2o1to8XBhspDWUT7T5yDvwWKz+8IkNw1LoKHYdRG0ctlSr6k3P3EPoPkL+
         +cQzCk7M1tacS7cjpPkCIeHNEQzcHu02Oad7RxZlfuPaFmAdkK5ImnLilaxm6K6CYYHN
         Pnl0CqkwjTvdA3E6kMZXh8SeOK0WNp0jj+gcbTSF4232dvc9rb/v3K/xWvLUk6t5MRCj
         SE8Q==
X-Gm-Message-State: AGi0PuZbW4CWwkLUMNpVXatvTh8AChWZrTp3GJV8uhh1Iu4MEwW8KS8X
        0PiAiIAd3MihsVcSaW39AYI=
X-Google-Smtp-Source: APiQypKi/m2x6fc9GESNRsOgIyHbOrzgWs7SZn815/APRiTA1xM3O7Pfdv3w5QJWYd8L0yUSQ8gQ4w==
X-Received: by 2002:a17:902:7c0c:: with SMTP id x12mr13851442pll.12.1588019017427;
        Mon, 27 Apr 2020 13:23:37 -0700 (PDT)
Received: from localhost.localdomain ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id n30sm13329438pfq.88.2020.04.27.13.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 13:23:37 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v4 09/18] matchpathcon_init: annotate deprecated
Date:   Mon, 27 Apr 2020 15:23:06 -0500
Message-Id: <20200427202315.4943-10-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427202315.4943-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <20200427202315.4943-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/include/selinux/selinux.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 9dcb3220264a..940c43eff8c9 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -465,7 +465,11 @@ extern void set_matchpathcon_flags(unsigned int flags);
    function also checks for a 'path'.homedirs file and 
    a 'path'.local file and loads additional specifications 
    from them if present. */
-extern int matchpathcon_init(const char *path);
+extern int matchpathcon_init(const char *path)
+#ifdef __GNUC__
+   __attribute__ ((deprecated("Use selabel_open with backend SELABEL_CTX_FILE")))
+#endif
+;
 
 /* Same as matchpathcon_init, but only load entries with
    regexes that have stems that are prefixes of 'prefix'. */
-- 
2.17.1

