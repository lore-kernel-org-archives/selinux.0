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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3AEC54FCB
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 919592075E
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kv5/45Z6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgD0UXr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726992AbgD0UXr (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Apr 2020 16:23:47 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30F4C0610D5
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:46 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id n24so7399034plp.13
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PSoRouKHeNtmv+72lDynxRu0K13hdFcIhm1sS5pa+Xk=;
        b=kv5/45Z658XBZIRa4mYUcGQef31AoPEfUDpP7mCHoTqZUKTccWW8eXxn08yxnXMyn9
         gGORUIPWzGN6qxeiNpa6Z4/BMfKM8ilf/Hav6Z/JoYNCQi9kwL4o5PGsas++jzl2HVDO
         y+ehgHRlBainToU5802MHK8nit18+xAW3Z1yLlRBeIVH9EoqwliWOIN02aEgQfzm7oCr
         fzkFdexlXcU8iE8sCjWDVMXSE27537l9UFATGr62bnOpM9zAGegHsHxE167L1FsJ5jI3
         r9TXCg2y/ErRpaGU53alChuu1oskarkSomYLc9mEUSo6KKr+22X6yHJ3M/eaBbu3E6IV
         noWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PSoRouKHeNtmv+72lDynxRu0K13hdFcIhm1sS5pa+Xk=;
        b=ghqvT7SW+o8LaHldSHQsnulETqYP1FjEqbzQIOtBQMOVcuqFRfYZJplNJ665ZHPzPr
         snBDT9i12F7fvDtzvaigyZbvRtSUsm7r4bUmW6Pl+Dda4y5LQ2plvJ1hFC7q+YdRArA+
         fgZ2AQ5Uqa3o8h5+TYl25tbBZAF39d0QysLCDSbB1AaDBiChXc+hX3ySbHc+OaR0pg3w
         nr5Hs44fTCmNlmHzJGV0LTv3gw+LaUftDy3Cwx6cCF6FmMMRTeb0nE+q1ivGPan2nM72
         9WVYrdEm8et/FWNxkkr8OsUTAGM1kWCnYZ4bHGZzu7OB55JMOcLgAeCh8ov2NZhmTKKW
         Di9w==
X-Gm-Message-State: AGi0PuZzYouXGWC+O0z28MVB94VJMOO8g+pX4XUOo4Aggfjti9wYxc6g
        r7K+sDahh3wMlXr/FVLwF7f0Xr6ZTr4=
X-Google-Smtp-Source: APiQypLQ1AerL4Fuphxzo91JMltHxqKvqRgGu5HSck29STUP8DFIUzDSWRwTM5Wms40dRFpAqPYCWA==
X-Received: by 2002:a17:90a:d34e:: with SMTP id i14mr473821pjx.135.1588019026403;
        Mon, 27 Apr 2020 13:23:46 -0700 (PDT)
Received: from localhost.localdomain ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id n30sm13329438pfq.88.2020.04.27.13.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 13:23:46 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v4 14/18] matchpathcon: create internal matchpathcon_fini interface
Date:   Mon, 27 Apr 2020 15:23:11 -0500
Message-Id: <20200427202315.4943-15-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200427202315.4943-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
 <20200427202315.4943-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Now that matchpathcon_fini is marked deprecated, create an
matchpathcon_fini2 interface for internal users. We create
a new header file for matchpathcon_internal interfaces.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/src/matchpathcon.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
index bddf77a49ce1..2ec66650cae0 100644
--- a/libselinux/src/matchpathcon.c
+++ b/libselinux/src/matchpathcon.c
@@ -315,9 +315,19 @@ void matchpathcon_filespec_destroy(void)
 	fl_head = NULL;
 }
 
+static void matchpathcon_fini_internal(void)
+{
+	free_array_elts();
+
+	if (hnd) {
+		selabel_close(hnd);
+		hnd = NULL;
+	}
+}
+
 static void matchpathcon_thread_destructor(void __attribute__((unused)) *ptr)
 {
-	matchpathcon_fini();
+	matchpathcon_fini_internal();
 }
 
 void __attribute__((destructor)) matchpathcon_lib_destructor(void);
@@ -359,12 +369,7 @@ int matchpathcon_init(const char *path)
 
 void matchpathcon_fini(void)
 {
-	free_array_elts();
-
-	if (hnd) {
-		selabel_close(hnd);
-		hnd = NULL;
-	}
+	matchpathcon_fini_internal();
 }
 
 /*
@@ -427,7 +432,7 @@ out:
 	return rc;
 }
 
-int matchpathcon(const char *path, mode_t mode, char ** con)
+static int matchpathcon_internal(const char *path, mode_t mode, char ** con)
 {
 	char stackpath[PATH_MAX + 1];
 	char *p = NULL;
@@ -448,9 +453,13 @@ int matchpathcon(const char *path, mode_t mode, char ** con)
 		selabel_lookup(hnd, con, path, mode);
 }
 
+int matchpathcon(const char *path, mode_t mode, char ** con) {
+	return matchpathcon_internal(path, mode, con);
+}
+
 int matchpathcon_index(const char *name, mode_t mode, char ** con)
 {
-	int i = matchpathcon(name, mode, con);
+	int i = matchpathcon_internal(name, mode, con);
 
 	if (i < 0)
 		return -1;
-- 
2.17.1

