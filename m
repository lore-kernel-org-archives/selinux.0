Return-Path: <SRS0=VF96=T5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFEDC04E84
	for <selinux@archiver.kernel.org>; Wed, 29 May 2019 07:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56A9208C3
	for <selinux@archiver.kernel.org>; Wed, 29 May 2019 07:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfE2HiI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 May 2019 03:38:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38060 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfE2HiI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 May 2019 03:38:08 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so914771wrs.5
        for <selinux@vger.kernel.org>; Wed, 29 May 2019 00:38:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=19iPoGpOiSMwycDnEvf8l/yr1xOm+2SSCbxvSVojWOw=;
        b=ttOrbI5cGcBuxK9jgRJHIxKqk0ck92cvR/hucsP27f2zaoy0gY+s420E7CGo+G2qp9
         cH9uj9zPIfMtKZJBO08Bjw4KKtx3WMuft5ZjOcTjIldJHUBAE0LOgj+5gdubZH4mkYMF
         QdtLFG8Q48xf1D/U6mHkeElIxng+ZQvHQI9LOUlG73A90/7+1YyUX0F4kbQdgOfgesC0
         ZQMMowu+tW0i/yOG+PzTgGauAJnLiHh3K7/D+3RioHfu22MTlDVOXIHS4nu3ZNtiOd2a
         Gph7KJm5x/Lcu/RTL8J70P1h6Y4LctQKX/wm7xJY2qO7tjF1r3j3n8HLGKCbw662WI0T
         1ZPg==
X-Gm-Message-State: APjAAAUOKv536cLE5R34qsACIKxeTF0HBvCcItB7KKmZm6PQSNHWbAwT
        4K+vmB5lqv5wARg7XA7K9uuUA0mgtrE=
X-Google-Smtp-Source: APXvYqyLaGVFHjTdOxyyjQfjTtqKGTKnmcteHjTHSeinE4a8IzV4+/QudT+kGg1CQLfoDcAPam3Chg==
X-Received: by 2002:adf:8306:: with SMTP id 6mr67874939wrd.155.1559115486436;
        Wed, 29 May 2019 00:38:06 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id p16sm32024877wrg.49.2019.05.29.00.38.05
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 00:38:05 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v3 3/7] semodule: add flag to enable policy optimization
Date:   Wed, 29 May 2019 09:37:55 +0200
Message-Id: <20190529073759.20548-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529073759.20548-1-omosnace@redhat.com>
References: <20190529073759.20548-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a command-line option -O/--optimize to enable policy optimization
when building kernel policy.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policycoreutils/semodule/semodule.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index a76797f5..40314117 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -46,6 +46,7 @@ static int verbose;
 static int reload;
 static int no_reload;
 static int build;
+static int optimize;
 static int disable_dontaudit;
 static int preserve_tunables;
 static int ignore_module_cache;
@@ -123,9 +124,10 @@ static void usage(char *progname)
 	printf("usage:  %s [option]... MODE...\n", progname);
 	printf("Manage SELinux policy modules.\n");
 	printf("MODES:\n");
-	printf("  -R, --reload		    reload policy\n");
-	printf("  -B, --build		    build and reload policy\n");
+	printf("  -R,--reload		    reload policy\n");
+	printf("  -B,--build		    build and reload policy\n");
 	printf("  -D,--disable_dontaudit    Remove dontaudits from policy\n");
+	printf("  -O,--optimize		    optimize built policy\n");
 	printf("  -i,--install=MODULE_PKG   install a new module\n");
 	printf("  -r,--remove=MODULE_NAME   remove existing module at desired priority\n");
 	printf("  -l[KIND],--list-modules[=KIND]  display list of installed modules\n");
@@ -191,6 +193,7 @@ static void parse_command_line(int argc, char **argv)
 		{"reload", 0, NULL, 'R'},
 		{"noreload", 0, NULL, 'n'},
 		{"build", 0, NULL, 'B'},
+		{"optimize", 0, NULL, 'O'},
 		{"disable_dontaudit", 0, NULL, 'D'},
 		{"preserve_tunables", 0, NULL, 'P'},
 		{"ignore-module-cache", 0, NULL, 'C'},
@@ -207,9 +210,10 @@ static void parse_command_line(int argc, char **argv)
 	verbose = 0;
 	reload = 0;
 	no_reload = 0;
+	optimize = 0;
 	priority = 400;
 	while ((i =
-		getopt_long(argc, argv, "s:b:hi:l::vr:u:RnNBDCPX:e:d:p:S:E:cH", opts,
+		getopt_long(argc, argv, "s:b:hi:l::vr:u:RnNBDOCPX:e:d:p:S:E:cH", opts,
 			    NULL)) != -1) {
 		switch (i) {
 		case 'b':
@@ -268,6 +272,9 @@ static void parse_command_line(int argc, char **argv)
 		case 'B':
 			build = 1;
 			break;
+		case 'O':
+			optimize = 1;
+			break;
 		case 'D':
 			disable_dontaudit = 1;
 			break;
@@ -738,6 +745,8 @@ cleanup_disable:
 			semanage_set_reload(sh, 0);
 		if (build)
 			semanage_set_rebuild(sh, 1);
+		if (optimize)
+			semanage_set_optimize(sh, 1);
 		if (disable_dontaudit)
 			semanage_set_disable_dontaudit(sh, 1);
 		else if (build)
-- 
2.20.1

