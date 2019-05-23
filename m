Return-Path: <SRS0=8MrU=TX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D8CC282E1
	for <selinux@archiver.kernel.org>; Thu, 23 May 2019 10:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC53621019
	for <selinux@archiver.kernel.org>; Thu, 23 May 2019 10:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730542AbfEWKY6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 May 2019 06:24:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34169 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfEWKY6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 May 2019 06:24:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id f8so5668908wrt.1
        for <selinux@vger.kernel.org>; Thu, 23 May 2019 03:24:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qNvXdQPNcpPM9ANBIdmry/EFGlB/yTFPC2GRHV1UuoU=;
        b=bQsJWWOIVisfcHT2IkySI0J2gbBE5tnP9/hShYep71yuNnM+E4hU5RDaBN8yptUc1l
         2U95pE/7VBjzpKhTaJuZHADEBzZTr2/bG0YVFAr/irehDzPKBLGqHLV9JlwUoc3JvF5j
         kBlmxQvqHci60MJeMVQm9Q+9VDQWMs3+SRgD8XlpbQkkT5Fj4Z9fk9w9VCI51PrqwvIP
         PVrm+83yCA3TKntrEro/5hYLXevqv01DsEbzXXT5Ph6iTZKKOdcih+mLfo0JiAIyts5n
         ezJOFL9X5j4mR0vRtiIN5UdkM6ScPIq/ajBU+ntSV7ITel/sVoSMWrJOiXesMkzhQD4/
         chEA==
X-Gm-Message-State: APjAAAWQSTKfO3aiDjRmPfeUTCgImfNKsD/dnm0RHmnB434kLoRrFk6Q
        s7jTanoBpYFNWg69jOh1aXzpJ3k1BVQ=
X-Google-Smtp-Source: APXvYqx6fVg9rctnR3yC+HAbCs/CATHNMSseAYwKcocdK2N3TUEqXxum5LKdqQbw40wIGEDvs6Cd6w==
X-Received: by 2002:adf:afdf:: with SMTP id y31mr55209239wrd.315.1558607096353;
        Thu, 23 May 2019 03:24:56 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id x22sm10423388wmi.4.2019.05.23.03.24.55
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 03:24:55 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace 4/4] semodule: add flag to disable policy optimization
Date:   Thu, 23 May 2019 12:24:49 +0200
Message-Id: <20190523102449.9621-5-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523102449.9621-1-omosnace@redhat.com>
References: <20190523102449.9621-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Skip binary policy optimization on rebuild when the --no-optimize
command-line flag is given.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policycoreutils/semodule/semodule.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index a76797f5..f490ca2e 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -46,6 +46,7 @@ static int verbose;
 static int reload;
 static int no_reload;
 static int build;
+static int no_optimize;
 static int disable_dontaudit;
 static int preserve_tunables;
 static int ignore_module_cache;
@@ -123,8 +124,9 @@ static void usage(char *progname)
 	printf("usage:  %s [option]... MODE...\n", progname);
 	printf("Manage SELinux policy modules.\n");
 	printf("MODES:\n");
-	printf("  -R, --reload		    reload policy\n");
-	printf("  -B, --build		    build and reload policy\n");
+	printf("  -R,--reload		    reload policy\n");
+	printf("  -B,--build		    build and reload policy\n");
+	printf("     --no-optimize	    do not optimize built policy\n");
 	printf("  -D,--disable_dontaudit    Remove dontaudits from policy\n");
 	printf("  -i,--install=MODULE_PKG   install a new module\n");
 	printf("  -r,--remove=MODULE_NAME   remove existing module at desired priority\n");
@@ -191,6 +193,7 @@ static void parse_command_line(int argc, char **argv)
 		{"reload", 0, NULL, 'R'},
 		{"noreload", 0, NULL, 'n'},
 		{"build", 0, NULL, 'B'},
+		{"no-optimize", 0, NULL, 'O'},
 		{"disable_dontaudit", 0, NULL, 'D'},
 		{"preserve_tunables", 0, NULL, 'P'},
 		{"ignore-module-cache", 0, NULL, 'C'},
@@ -268,6 +271,9 @@ static void parse_command_line(int argc, char **argv)
 		case 'B':
 			build = 1;
 			break;
+		case 'O':
+			no_optimize = 1;
+			break;
 		case 'D':
 			disable_dontaudit = 1;
 			break;
@@ -738,6 +744,8 @@ cleanup_disable:
 			semanage_set_reload(sh, 0);
 		if (build)
 			semanage_set_rebuild(sh, 1);
+		if (no_optimize)
+			semanage_set_optimize(sh, 0);
 		if (disable_dontaudit)
 			semanage_set_disable_dontaudit(sh, 1);
 		else if (build)
-- 
2.20.1

