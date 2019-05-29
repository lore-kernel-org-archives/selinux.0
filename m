Return-Path: <SRS0=VF96=T5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47243C04E84
	for <selinux@archiver.kernel.org>; Wed, 29 May 2019 07:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC0A208C3
	for <selinux@archiver.kernel.org>; Wed, 29 May 2019 07:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfE2HiK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 May 2019 03:38:10 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37754 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfE2HiK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 May 2019 03:38:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so797468wmo.2
        for <selinux@vger.kernel.org>; Wed, 29 May 2019 00:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JYnDVo1ekUtEUCmB2exrVYyH/XleJUU2wtWrEFgeED0=;
        b=b5TergOuLyMsYRAq1juUOTK1MS784lqA1YfQuvDxYzw14YSkNC3p6eVc9zcMf473XW
         UygI01PaAAPQYgEOQ0J+dJ6OxPHlLr7pwOOJw9FwLMi6y4GqAB8fRQHwKzYg5PS3Sqlv
         eoiSiH4gEpnG+p0/oa+znObdJPAYt+SORHo3wqchlIwA4NY6b4KdrsiVCN1jCH4qD8hy
         hJbs9EB6MW3Jaz424eTzjqTLxWcgcaxVbstsC0U7Lksgj1bkgTi3gVm3g3wETaQoYZ+U
         k40pLYhgT8X+LJf+fd77tjYrVL6knWj3cZkOyVIKEAIAPV/BMLpZMLZbOep6tObAZDVf
         NcUg==
X-Gm-Message-State: APjAAAX1O93LAnsCvXta5A43Bb9bdBwLoULo1wq7FZmj1NBuaRc3OIXa
        QKdHZ6IMvJMpOU8mNq1XyXILf6cHC5o=
X-Google-Smtp-Source: APXvYqzPM5rVKuHuBHfsjMjaFDfCrmBW7heKsRmYAjha8jBZXSx0DJLgYYyi4jXwwrOixwTO6opxdA==
X-Received: by 2002:a7b:c34b:: with SMTP id l11mr6019190wmj.69.1559115488487;
        Wed, 29 May 2019 00:38:08 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id p16sm32024877wrg.49.2019.05.29.00.38.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 00:38:07 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@tycho.nsa.gov>
Subject: [PATCH userspace v3 5/7] checkpolicy: add flag to enable policy optimization
Date:   Wed, 29 May 2019 09:37:57 +0200
Message-Id: <20190529073759.20548-6-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529073759.20548-1-omosnace@redhat.com>
References: <20190529073759.20548-1-omosnace@redhat.com>
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
 1 file changed, 14 insertions(+), 2 deletions(-)

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
-- 
2.20.1

