Return-Path: <SRS0=POVk=T4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13E7C072B1
	for <selinux@archiver.kernel.org>; Tue, 28 May 2019 14:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80005206BA
	for <selinux@archiver.kernel.org>; Tue, 28 May 2019 14:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbfE1O7U (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 May 2019 10:59:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33616 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfE1O7T (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 May 2019 10:59:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id d9so20616614wrx.0
        for <selinux@vger.kernel.org>; Tue, 28 May 2019 07:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=19iPoGpOiSMwycDnEvf8l/yr1xOm+2SSCbxvSVojWOw=;
        b=CVTff+MY34YnGrutEbVp1brTOXV6/msQjToRynQvt+3/NMjyzsXr7TOoWTbsd6bhNx
         eGUQmpSmh9MCyhCGvelh8XnuRslfaBewW0gBUCw/0GOpHB5YzwWh9u6uA3pmQ5P37nKH
         xAxm1RHTV6GUh4jquZD4tecqCJwmoJgJRdXwSFFO9HTJ3Bm2JGRSBp92bKAslUi4f5gs
         Ec4I3g/8wXZM5eJwJuQPlGbpWuxvLBYJ8qOP8xldodSPnMI3nlC3NNS/jo89ea1tohF4
         jYmt1CbYNhq3zKVAyd0Z1nt+sOOcHSZ+oCN1iuDL0R8cUZi+LujlN2zCPNk915ghKLtl
         xVew==
X-Gm-Message-State: APjAAAX26xBNBbUAn3oNcs9yeisVw3Do8fKG384e21vRkeX03jogLAr0
        I4kKYm5tT3Y2hLN2EP6pPo1KGbjRhRo=
X-Google-Smtp-Source: APXvYqw/LpvWQz2X16vwWQihT9NV05RLBCFYcrYoSbXDW10PodSPJ5qYvVKMYPi/hSYGUmI2XH1DsQ==
X-Received: by 2002:a5d:45c7:: with SMTP id b7mr55651979wrs.176.1559055558119;
        Tue, 28 May 2019 07:59:18 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id p17sm14118849wrq.95.2019.05.28.07.59.17
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 07:59:17 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v2 3/7] semodule: add flag to enable policy optimization
Date:   Tue, 28 May 2019 16:59:08 +0200
Message-Id: <20190528145912.13827-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528145912.13827-1-omosnace@redhat.com>
References: <20190528145912.13827-1-omosnace@redhat.com>
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

