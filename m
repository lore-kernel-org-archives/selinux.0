Return-Path: <SRS0=POVk=T4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46F5C04E84
	for <selinux@archiver.kernel.org>; Tue, 28 May 2019 14:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944A0206BA
	for <selinux@archiver.kernel.org>; Tue, 28 May 2019 14:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfE1O7W (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 May 2019 10:59:22 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44860 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfE1O7W (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 May 2019 10:59:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id w13so12231811wru.11
        for <selinux@vger.kernel.org>; Tue, 28 May 2019 07:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BFRGCuwo/XiRRgTN0vKcrXy5j3GKjJJf2MUtiHRDU24=;
        b=Bx70H7mw3vX6tfSmNhSA8org6cLpiy5xjS72n9D+1mnVUmVBUQph54wlBOj1tN561N
         1jFktudANn4Q8+/+4dtbVJ6JTKPQEafOYM0+Ide2KLJt8y2uQT+wtdmRYB5Ndf5RbSBA
         fmrPNqj3ImuKYgNwoi3k0TgPAu/U/46z+00SxXAmVaq3YPteOnPgZNkIQAYq7fETDg0s
         jrDCloq4r68OBcUCbenH7Lf1vaqPeE/I3kzVbpmofyFKEz9PvTrfjtycfaGK8jNhWBcz
         EYrkO5LkdTeKAUy04eNrg5ez0UrftNN2p6vwt87zhpbU3nbqZrO3l6DRlhP7yUJfFmpG
         E7UQ==
X-Gm-Message-State: APjAAAVphIrbRKMDiA7ZhWTcmwECzcXNSXHVXGPV16b2HWYRaePxL4I5
        LMmNSO8Jl1M2TgYerjhRKpimj84CUmM=
X-Google-Smtp-Source: APXvYqxNGeN6EaFoMJbgCPADmym+I2pdutd+QMbBDZTcFSGM4Sc7UTBkG9734ptzR1owKD1HIyayfQ==
X-Received: by 2002:adf:e98a:: with SMTP id h10mr11577008wrm.124.1559055560148;
        Tue, 28 May 2019 07:59:20 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id p17sm14118849wrq.95.2019.05.28.07.59.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 07:59:19 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@tycho.nsa.gov>
Subject: [PATCH userspace v2 5/7] checkpolicy: add flag to enable policy optimization
Date:   Tue, 28 May 2019 16:59:10 +0200
Message-Id: <20190528145912.13827-6-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528145912.13827-1-omosnace@redhat.com>
References: <20190528145912.13827-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: James Carter <jwcart2@tycho.nsa.gov>

Add the command-line option 'O' to checkpolicy to cause kernel policies
to be optimized by calling policydb_optimize() before being written out.

This option can be used on conf files and binary kernel policies, but
not when converting a conf file to CIL.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
[omosnace: make commit desc more consistent with the other patches]
[omosnace: fix a typo in the commit message]
[omosnace: directly use policydb_optimize() as also the rest of code already uses
 other policydb_*() functions...]
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 checkpolicy/checkpolicy.c | 16 ++++++++++++++--
 secilc/secilc.c           | 12 ++++++------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
index e0a00f7c..f928ec06 100644
--- a/checkpolicy/checkpolicy.c
+++ b/checkpolicy/checkpolicy.c
@@ -394,7 +394,7 @@ int main(int argc, char **argv)
 	size_t scontext_len, pathlen;
 	unsigned int i;
 	unsigned int protocol, port;
-	unsigned int binary = 0, debug = 0, sort = 0, cil = 0, conf = 0;
+	unsigned int binary = 0, debug = 0, sort = 0, cil = 0, conf = 0, optimize = 0;
 	struct val_to_name v;
 	int ret, ch, fd, target = SEPOL_TARGET_SELINUX;
 	unsigned int nel, uret;
@@ -419,11 +419,12 @@ int main(int argc, char **argv)
 		{"cil", no_argument, NULL, 'C'},
 		{"conf",no_argument, NULL, 'F'},
 		{"sort", no_argument, NULL, 'S'},
+		{"optimize", no_argument, NULL, 'O'},
 		{"help", no_argument, NULL, 'h'},
 		{NULL, 0, NULL, 0}
 	};
 
-	while ((ch = getopt_long(argc, argv, "o:t:dbU:MCFSVc:h", long_options, NULL)) != -1) {
+	while ((ch = getopt_long(argc, argv, "o:t:dbU:MCFSVc:Oh", long_options, NULL)) != -1) {
 		switch (ch) {
 		case 'o':
 			outfile = optarg;
@@ -466,6 +467,9 @@ int main(int argc, char **argv)
 		case 'S':
 			sort = 1;
 			break;
+		case 'O':
+			optimize = 1;
+			break;
 		case 'M':
 			mlspol = 1;
 			break;
@@ -625,6 +629,14 @@ int main(int argc, char **argv)
 	if (policydb_load_isids(&policydb, &sidtab))
 		exit(1);
 
+	if (optimize && policydbp->policy_type == POLICY_KERN) {
+		ret = policydb_optimize(policydbp);
+		if (ret) {
+			fprintf(stderr, "%s:  error optimizing policy\n", argv[0]);
+			exit(1);
+		}
+	}
+
 	if (outfile) {
 		outfp = fopen(outfile, "w");
 		if (!outfp) {
diff --git a/secilc/secilc.c b/secilc/secilc.c
index 26996ef9..9bea3a58 100644
--- a/secilc/secilc.c
+++ b/secilc/secilc.c
@@ -68,7 +68,7 @@ static __attribute__((__noreturn__)) void usage(const char *prog)
 	printf("  -G, --expand-generated         Expand and remove auto-generated attributes\n");
 	printf("  -X, --expand-size <SIZE>       Expand type attributes with fewer than <SIZE>\n");
 	printf("                                 members.\n");
-	printf("  -n, --no-optimize              do not optimize final policy\n");
+	printf("  -O, --optimize-policy          optimize final policy\n");
 	printf("  -v, --verbose                  increment verbosity level\n");
 	printf("  -h, --help                     display usage information\n");
 	exit(1);
@@ -98,7 +98,7 @@ int main(int argc, char *argv[])
 	int policyvers = POLICYDB_VERSION_MAX;
 	int attrs_expand_generated = 0;
 	int attrs_expand_size = -1;
-	int optimize_policy = 1;
+	int optimize_policy = 0;
 	int opt_char;
 	int opt_index = 0;
 	char *fc_buf = NULL;
@@ -119,13 +119,13 @@ int main(int argc, char *argv[])
 		{"filecontexts", required_argument, 0, 'f'},
 		{"expand-generated", no_argument, 0, 'G'},
 		{"expand-size", required_argument, 0, 'X'},
-		{"no-optimize", no_argument, 0, 'n'},
+		{"optimize-policy", no_argument, 0, 'O'},
 		{0, 0, 0, 0}
 	};
 	int i;
 
 	while (1) {
-		opt_char = getopt_long(argc, argv, "o:f:U:hvt:M:PDmNc:GX:n", long_opts, &opt_index);
+		opt_char = getopt_long(argc, argv, "o:f:U:hvt:M:PDmNOc:GX:n", long_opts, &opt_index);
 		if (opt_char == -1) {
 			break;
 		}
@@ -214,8 +214,8 @@ int main(int argc, char *argv[])
 				}
 				break;
 			}
-			case 'n':
-				optimize_policy = 0;
+			case 'O':
+				optimize_policy = 1;
 				break;
 			case 'h':
 				usage(argv[0]);
-- 
2.20.1

