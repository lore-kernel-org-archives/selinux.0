Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A39C433EF
	for <selinux@archiver.kernel.org>; Thu,  3 Feb 2022 16:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352447AbiBCQxu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 3 Feb 2022 11:53:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55632 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352455AbiBCQxq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 3 Feb 2022 11:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643907225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3GN1YIOijkPerY3Twy/e4p+uRKzvmr+RrRlaKf/E0JU=;
        b=c5pK/3NBuslRyeaU7HNazdv+rxrvta9qEqeMwmGXj7AS2JwueMq5xm1M5SH6Ecf5isNlKE
        IS+1CJ62eul00Pj7qC+0n7rtlMaA/i+WA46V1hJQxE7NJA9Pewtsyd0tQCB5yaGjldh45t
        aEWsobe43gA5eAlxKZNNSvHAXNlfyUo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-527-DC2aF5FUMyuVTq0yTsVVOA-1; Thu, 03 Feb 2022 11:53:44 -0500
X-MC-Unique: DC2aF5FUMyuVTq0yTsVVOA-1
Received: by mail-ed1-f70.google.com with SMTP id n7-20020a05640205c700b0040b7be76147so1774549edx.10
        for <selinux@vger.kernel.org>; Thu, 03 Feb 2022 08:53:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3GN1YIOijkPerY3Twy/e4p+uRKzvmr+RrRlaKf/E0JU=;
        b=sU9Ikc07KDtdCrDHqy7IL4H2on+F/QRO+2oMocxQL041xpm49uIlU67S+tPY7BCP4V
         fH/tXeO4acEwc6D+JoNDZMMqZyl5fAcCZbuIxxW7ir5dM4ppUTLzgCxQZIXNptkdxAMO
         rgS909CMlTEJgOWihxahI9b6eWPlnnJZYrTfZUZt9s2YC2R107r68xB/rQ8NL8yCCLPH
         Kte4vF1qzhyyK2rKUl9Q3MPDXssP3W2FHmW6CZi863Q2RQSxxypnlm2BUnzVzvJfIZYX
         jzVfpboqVG9O2luBUyDGsImdOCqQeH7dbmiir07OvkGK0afrXjJDPmLpCuKrAchNDHRO
         ElNw==
X-Gm-Message-State: AOAM532afdGee4rkoT/JZIogJlTEwPdgm44u9XIo4z2jPZO1wlYGrA/6
        d24aC/ZUAK53OHLeDrOK85KmlBucGcoe70S2i2z8vYiw0KcdSczYa8qS3M9GGthzcPIXLrRNA48
        40pIX2qJIWdU05SxcDHp+ekzDLIOrGfMgz65hQP+5+u4HWvRyejX0SxNjU0CMps7pXhy2Bw==
X-Received: by 2002:a17:907:16a9:: with SMTP id hc41mr31647787ejc.289.1643907223033;
        Thu, 03 Feb 2022 08:53:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJykxSuYn+vNbSuimbDdJurbxbYNH4o5GIpOUkDzigj+/kklijd78X33Qmygn8uvVchR3KVgTA==
X-Received: by 2002:a17:907:16a9:: with SMTP id hc41mr31647758ejc.289.1643907222607;
        Thu, 03 Feb 2022 08:53:42 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id bs4sm18141027edb.84.2022.02.03.08.53.41
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 08:53:42 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v2 6/6] semodule: add command-line option to detect module changes
Date:   Thu,  3 Feb 2022 17:53:27 +0100
Message-Id: <20220203165327.213601-7-omosnace@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203165327.213601-1-omosnace@redhat.com>
References: <20220203165327.213601-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a new command-line option "--rebuild-if-modules-changed" to control
the newly introduced check_ext_changes libsemanage flag.

For example, running `semodule --rebuild-if-modules-changed` will ensure
that any externally added/removed modules (e.g. by an RPM transaction)
are reflected in the compiled policy, while skipping the most expensive
part of the rebuild if no module change was deteceted since the last
libsemanage transaction.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policycoreutils/semodule/semodule.8 |  7 +++++++
 policycoreutils/semodule/semodule.c | 32 ++++++++++++++++++++++-------
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/policycoreutils/semodule/semodule.8 b/policycoreutils/semodule/semodule.8
index 3a2fb21c..d1735d21 100644
--- a/policycoreutils/semodule/semodule.8
+++ b/policycoreutils/semodule/semodule.8
@@ -23,6 +23,13 @@ force a reload of policy
 .B \-B, \-\-build
 force a rebuild of policy (also reloads unless \-n is used)
 .TP
+.B \-\-rebuild-if-modules-changed
+Force a rebuild of the policy if any changes to module content are detected
+(by comparing with checksum from the last transaction).  One can use this
+instead of \-B to ensure that any changes to the module store done by an
+external tool (e.g. a package manager) are applied, while automatically
+skipping the rebuild if there are no new changes.
+.TP
 .B \-D, \-\-disable_dontaudit
 Temporarily remove dontaudits from policy.  Reverts whenever policy is rebuilt
 .TP
diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index f4a76289..1ed8e690 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -47,6 +47,7 @@ static int verbose;
 static int reload;
 static int no_reload;
 static int build;
+static int check_ext_changes;
 static int disable_dontaudit;
 static int preserve_tunables;
 static int ignore_module_cache;
@@ -149,6 +150,9 @@ static void usage(char *progname)
 	printf("  -c, --cil extract module as cil. This only affects module extraction.\n");
 	printf("  -H, --hll extract module as hll. This only affects module extraction.\n");
 	printf("  -m, --checksum   print module checksum (SHA256).\n");
+	printf("      --rebuild-if-modules-changed\n"
+	       "                   force policy rebuild if module content changed since\n"
+	       "                   last rebuild (based on checksum)\n");
 }
 
 /* Sets the global mode variable to new_mode, but only if no other
@@ -180,6 +184,7 @@ static void set_mode(enum client_modes new_mode, char *arg)
 static void parse_command_line(int argc, char **argv)
 {
 	static struct option opts[] = {
+		{"rebuild-if-modules-changed", 0, NULL, '\0'},
 		{"store", required_argument, NULL, 's'},
 		{"base", required_argument, NULL, 'b'},
 		{"help", 0, NULL, 'h'},
@@ -207,15 +212,26 @@ static void parse_command_line(int argc, char **argv)
 	};
 	int extract_selected = 0;
 	int cil_hll_set = 0;
-	int i;
+	int i, longind;
 	verbose = 0;
 	reload = 0;
 	no_reload = 0;
+	check_ext_changes = 0;
 	priority = 400;
 	while ((i =
-		getopt_long(argc, argv, "s:b:hi:l::vr:u:RnNBDCPX:e:d:p:S:E:cHm", opts,
-			    NULL)) != -1) {
+		getopt_long(argc, argv, "s:b:hi:l::vr:u:RnNBDCPX:e:d:p:S:E:cHm",
+			    opts, &longind)) != -1) {
 		switch (i) {
+		case '\0':
+			switch(longind) {
+			case 0: /* --rebuild-if-modules-changed */
+				check_ext_changes = 1;
+				break;
+			default:
+				usage(argv[0]);
+				exit(1);
+			}
+			break;
 		case 'b':
 			fprintf(stderr, "The --base option is deprecated. Use --install instead.\n");
 			set_mode(INSTALL_M, optarg);
@@ -300,13 +316,13 @@ static void parse_command_line(int argc, char **argv)
 			}
 		}
 	}
-	if ((build || reload) && num_commands) {
+	if ((build || reload || check_ext_changes) && num_commands) {
 		fprintf(stderr,
 			"build or reload should not be used with other commands\n");
 		usage(argv[0]);
 		exit(1);
 	}
-	if (num_commands == 0 && reload == 0 && build == 0) {
+	if (num_commands == 0 && reload == 0 && build == 0 && check_ext_changes == 0) {
 		fprintf(stderr, "At least one mode must be specified.\n");
 		usage(argv[0]);
 		exit(1);
@@ -395,7 +411,7 @@ int main(int argc, char *argv[])
 
 	cil_set_log_level(CIL_ERR + verbose);
 
-	if (build)
+	if (build || check_ext_changes)
 		commit = 1;
 
 	sh = semanage_handle_create();
@@ -434,7 +450,7 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	if (build) {
+	if (build || check_ext_changes) {
 		if ((result = semanage_begin_transaction(sh)) < 0) {
 			fprintf(stderr, "%s:  Could not begin transaction:  %s\n",
 				argv[0], errno ? strerror(errno) : "");
@@ -807,6 +823,8 @@ cleanup_disable:
 			semanage_set_reload(sh, 0);
 		if (build)
 			semanage_set_rebuild(sh, 1);
+		if (check_ext_changes)
+			semanage_set_check_ext_changes(sh, 1);
 		if (disable_dontaudit)
 			semanage_set_disable_dontaudit(sh, 1);
 		else if (build)
-- 
2.34.1

