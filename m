Return-Path: <SRS0=F/Jq=4N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77EEC35E04
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB17721556
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlyop63e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731449AbgBYUDH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:03:07 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39298 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgBYUDH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Feb 2020 15:03:07 -0500
Received: by mail-pj1-f67.google.com with SMTP id e9so184546pjr.4
        for <selinux@vger.kernel.org>; Tue, 25 Feb 2020 12:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+5ji0qf9xxgPhc+Nmd1gWKTklZ3TKBMYpM1qRp9y2Kg=;
        b=hlyop63ej/CxCDG1fiyWCMOI7jhrWN7Wdva9Ox+9iWJQqylHhPCwGPMu60HL+xlbKU
         pczeGsenr7x0Enqo0Q0W18oRC/cLsc6Bh4r5ZWRogeAD/PszwogCn2YPm0+aTtVMND0K
         cs3LzKrogUi1RAgx1nTkwMJf2inzZjAd9fDJhnUBofK3hgyw6hgn88e/30PAlkAjJiBE
         ddvOoIVOSXY2hxg9I+mCbLkueHVy2uWfj3GoV6FxLL3MB9rDdZY/31LctUZm91l4b2U/
         sTwP6Z3VLvV7bmdGGCkoYqWlXVaG2LX6NjKEG6AWN+sRNXepBNKmAgt5pn9Fz/4JLIiM
         D+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+5ji0qf9xxgPhc+Nmd1gWKTklZ3TKBMYpM1qRp9y2Kg=;
        b=Odg3AzYvr6VsSbpYNaOVujkBXZkee9SjjaBfX3YynCYME7HiZyu5NaWYJDLkAnCxY7
         O4E4nanOAjtHzN2dXMj+J+Iw64YwPCzmV82V12zNT/hPLUpyvtVy6qoDvKtvBqL22CpH
         BvGzBhiMm7MB41W2RiS+LnwTo6m1lOW74SLnegF8zbBqNYz0KW3rk/i1z/e3MlEzWF8D
         mLSrldcMq7jTm8uvLJAfeXspWj75sSrGquDmuDBGQwooBs9firrEMD2wsZAQAdeGZoNO
         wZrC3BvM+0wHMcpheozVr+aaLmJ1FATmtRKLXWc1RdBd6YQQo9+OgB4iE5yV/rM2EU6q
         G7UA==
X-Gm-Message-State: APjAAAVHJSiLInkb7svNRELk5k8QODycRPRACOBn3cWS4wufj2yp2GSs
        ixzCyBXXQrx24M/d/CPWLBo=
X-Google-Smtp-Source: APXvYqz5RoPhIMwa91zhv153Rdiz6woDw36eDCwXCO/2WFNWgoh5TeIOsRKUMcfeWGvEgLnDJ7oQqQ==
X-Received: by 2002:a17:90b:3c9:: with SMTP id go9mr776523pjb.7.1582660986536;
        Tue, 25 Feb 2020 12:03:06 -0800 (PST)
Received: from localhost.localdomain (fmdmzpr03-ext.fm.intel.com. [192.55.54.38])
        by smtp.gmail.com with ESMTPSA id v29sm10636362pgc.72.2020.02.25.12.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 12:03:05 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     sds@tycho.nsa.gov, plautrba@redhat.com, selinux@vger.kernel.org
Cc:     William Roberts <william.c.roberts@intel.com>
Subject: [PATCH 16/17] src/matchpathcon: allow use of deprecated funcs
Date:   Tue, 25 Feb 2020 14:02:18 -0600
Message-Id: <20200225200219.6163-17-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225200219.6163-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Internally users of deprecated functions are ok so allow it.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/matchpathcon.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index 05a5cfa4cfd5..2e5aa347b52b 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -317,7 +317,10 @@ void matchpathcon_filespec_destroy(void)
 
 static void matchpathcon_thread_destructor(void __attribute__((unused)) *ptr)
 {
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
 	matchpathcon_fini();
+#pragma GCC diagnostic pop
 }
 
 void __attribute__((destructor)) matchpathcon_lib_destructor(void);
@@ -451,8 +454,10 @@ int matchpathcon(const char *path, mode_t mode, char ** con)
 
 int matchpathcon_index(const char *name, mode_t mode, char ** con)
 {
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
 	int i = matchpathcon(name, mode, con);
-
+#pragma GCC diagnostic pop
 	if (i < 0)
 		return -1;
 
-- 
2.17.1

