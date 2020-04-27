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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EC1C54EEB
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47427206E2
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKFjzPNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgD0UXn (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726972AbgD0UXm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Apr 2020 16:23:42 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD39BC0610D5
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:41 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id x26so9192193pgc.10
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W1L3bA+GPmHiUflkrWsIYtotwIeleU9ISeIFILRnHcw=;
        b=rKFjzPNqyF3DidioVqXxF+MNtlqxwstXef3LQxdIfll030WoJPZS1ag3S+Mhb1zjBx
         fAuDNdgu6PiCDaKnYuc6jKN/C/Xf5rsBIjVgote0cUmhAzb1RIL47HtJk5vQnXP/xXyj
         qiTi5b4tMGgK5O0uOGaPEYM/VTYItPhY0zQrThFUdbUrVwPseFJjiqMPHRZoUb7el0Rz
         7yFsfZwnzBSCxFwuNycfJxRsZ5+nMtahnJFqyL/JcR/w0tgiOyYEspX6b1EXb6uxgpvb
         VD2BpB2i//Dw3e7qBmHDEVpAFd8SEu6jbVZkDNRxPrAeeESvUaT/XCuEiDNK9bc1gZ5X
         HXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W1L3bA+GPmHiUflkrWsIYtotwIeleU9ISeIFILRnHcw=;
        b=qGFnWVIyYdrrar8g3Zvt7P3mfOnb5PGCzSeMu9UPi3zKs4VYHhonmgGSnrXzxzxcyV
         NnvsUX2j1l4ul3TYPejis1ZIVt2gNyfGojXGQlVdxh9Fr5fUH4zo04sQDMkciDCmj5/y
         k4nSg1XcU1N25FtcfF1n/LhSZcdehZQ6Phc1UO4w8gT2pb0zAnigBBMbe0WNgHELLD02
         XaaijZ+lFD4OeKex7yn9zrx1AwlnRlCQeMs7U89gCv1ZFP0GyOAtTH3uUmSQjMxTu/nw
         ZkGu0JJuFmdk2xy6PKrvG/5Ylo5aR2ORsU7InUK74O7Y0g0NKVfGeHoqQDz6SMv+5P2I
         KchA==
X-Gm-Message-State: AGi0PuYtQprrtbzjuDcjaEBI/ru9WJHuVgdPb2MeU8+xEqi0kXf/b9E4
        arzQIncxm5pPNorzlckodo4=
X-Google-Smtp-Source: APiQypKvOPTWHcCpz1G7sfIQEou/Wk9hxGrXMveIlJywMhE2T89AsiMremZM4H0H6ixyTuNGpEBWmg==
X-Received: by 2002:a62:1549:: with SMTP id 70mr24583945pfv.43.1588019021372;
        Mon, 27 Apr 2020 13:23:41 -0700 (PDT)
Received: from localhost.localdomain ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id n30sm13329438pfq.88.2020.04.27.13.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 13:23:41 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v4 11/18] matchpathcon: annotate deprecated
Date:   Mon, 27 Apr 2020 15:23:08 -0500
Message-Id: <20200427202315.4943-12-william.c.roberts@intel.com>
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
index b04f34a1b3bb..5633cf40607d 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -494,7 +494,11 @@ extern int realpath_not_final(const char *name, char *resolved_path);
    If matchpathcon_init has not already been called, then this function
    will call it upon its first invocation with a NULL path. */
 extern int matchpathcon(const char *path,
-			mode_t mode, char ** con);
+			mode_t mode, char ** con)
+#ifdef __GNUC__
+	__attribute__ ((deprecated("Use selabel_lookup instead")))
+#endif
+;
 
 /* Same as above, but return a specification index for 
    later use in a matchpathcon_filespec_add() call - see below. */
-- 
2.17.1

