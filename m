Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DF1C433EF
	for <selinux@archiver.kernel.org>; Thu, 13 Jan 2022 14:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbiAMOjw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Jan 2022 09:39:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47173 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235708AbiAMOjv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Jan 2022 09:39:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642084791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F6drO9fgBI9ia3c1itBqOudqszqh42+PegtO9ooNfT0=;
        b=LxAXXij/R0JuWrJ7Yv4S8agK7QHkyjUaYohVHw4D8hM3VNGr05+Ibfkswc4Ht6sU60w5I4
        bGuE/LUVwCGR1K5Eoe0nGK02g8QaCr3g6AfjnyINs75WLJmi/nhU46ih+uNSlOgnOO57b7
        DkSSb29mZBTy7PSZzPlaVedh3zesjks=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-596-MAgeWgt1NdKCSDZMg0Qx6Q-1; Thu, 13 Jan 2022 09:39:49 -0500
X-MC-Unique: MAgeWgt1NdKCSDZMg0Qx6Q-1
Received: by mail-ed1-f72.google.com with SMTP id b8-20020a056402350800b003f8f42a883dso5517540edd.16
        for <selinux@vger.kernel.org>; Thu, 13 Jan 2022 06:39:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F6drO9fgBI9ia3c1itBqOudqszqh42+PegtO9ooNfT0=;
        b=CSCtKpMIf8abVUQhCmVEn4ARGFIkAFQGR2FDLhbKcFxQriBuJsJnvY0aOkXlQrlaSq
         oz1FENdhq5V9AuM9S4HqnphvUALBSs8NWcdqbQoMYnLD6v8A9v+HyGLCaz0Bf4n4qTMU
         0lgXdASe//+h7aX0mOTJWGEKzVVmiszHYLbcSavPhxU3Foue5JDRKMGp6iA6+MEZelsH
         4H/JEI1yfaJxiJ+GMCo8IrXw/jqzO5Qavf2/7xJQi9gdsdRWAjcZZNogmR+fk0wGmgT4
         L/9LAo+0PECvYkkAiTPVKmjKAQ4OmDvQiiOetbt/gk6XuWMdBqO/TR3HYEqQFLVn0QOn
         oyNg==
X-Gm-Message-State: AOAM531tAeq1r0HYHfKU+Y+K9B0B+xAcTGrYUtPjb4ZkbOkvy8G4xGNR
        dezPljF1RMRfML0OLCnTU9nxdwAloHhcrS/BwFR2dnbU+ENlCTbYF5F822K4Emx39DzWiAht58M
        JPaWm9KTmZj79kZtx6sG6TcWIcUh5uCO+AMn4TrbnaZgzc//EsDhFsgXUUAH0+QBBaD8kgQ==
X-Received: by 2002:a17:907:a08b:: with SMTP id hu11mr3773137ejc.556.1642084788278;
        Thu, 13 Jan 2022 06:39:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw64w9rHv/2qH1vYhM7LfmL/enM34NszzRJWVC8HiLzahWaaG5/Kye21NZy7QRMest5cNlegg==
X-Received: by 2002:a17:907:a08b:: with SMTP id hu11mr3773120ejc.556.1642084787999;
        Thu, 13 Jan 2022 06:39:47 -0800 (PST)
Received: from localhost.localdomain ([2a02:8308:b106:e300:d5c1:b1da:9874:b302])
        by smtp.gmail.com with ESMTPSA id sc7sm964242ejc.87.2022.01.13.06.39.47
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 06:39:47 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH userspace 5/5] semodule: add command-line option to detect module changes
Date:   Thu, 13 Jan 2022 15:39:35 +0100
Message-Id: <20220113143935.195125-6-omosnace@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113143935.195125-1-omosnace@redhat.com>
References: <20220113143935.195125-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a new command-line option "--smart" (for the lack of a better
name...) to control the newly introduced check_ext_changes libsemanage
flag.

For example, running `semodule -B --smart` will ensure that any
externally added/removed modules (e.g. by an RPM transaction) are
reflected in the compiled policy, while skipping the most expensive part
of the rebuild if no module change was deteceted since the last
libsemanage transaction.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policycoreutils/semodule/semodule.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index a5b71fc4..638edb39 100644
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
@@ -149,6 +150,8 @@ static void usage(char *progname)
 	printf("  -c, --cil extract module as cil. This only affects module extraction.\n");
 	printf("  -H, --hll extract module as hll. This only affects module extraction.\n");
 	printf("  -m, --checksum   print module checksum (SHA256).\n");
+	printf("      --smart      force policy rebuild if module content changed since\n"
+	       "                   last rebuild (based on checksum)\n");
 }
 
 /* Sets the global mode variable to new_mode, but only if no other
@@ -180,6 +183,7 @@ static void set_mode(enum client_modes new_mode, char *arg)
 static void parse_command_line(int argc, char **argv)
 {
 	static struct option opts[] = {
+		{"smart", 0, NULL, '\0'},
 		{"store", required_argument, NULL, 's'},
 		{"base", required_argument, NULL, 'b'},
 		{"help", 0, NULL, 'h'},
@@ -207,15 +211,26 @@ static void parse_command_line(int argc, char **argv)
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
+			case 0: /* --smart */
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
@@ -813,6 +828,8 @@ cleanup_disable:
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

