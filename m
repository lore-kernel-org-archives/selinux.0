Return-Path: <SRS0=L/M1=UM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97D2C31E45
	for <selinux@archiver.kernel.org>; Thu, 13 Jun 2019 15:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8237206BB
	for <selinux@archiver.kernel.org>; Thu, 13 Jun 2019 15:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbfFMP0V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:26:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43408 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729221AbfFMLqH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Jun 2019 07:46:07 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so10324416wru.10
        for <selinux@vger.kernel.org>; Thu, 13 Jun 2019 04:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=noc+4n7n8rJoqKCZ+8pPcl9Q42KnX0P3ic9sERe4fMw=;
        b=BA/4FViYtpiBlRpHUNV4sxPBDYvCKLeBYLqTxmAYlDc3HxXe3oo05htHsj9mFgo4/Y
         vi0Kv94NrNKsFCK562mjf9rpEX7pTKP+wCjAhP7AYZLR0QAaTYAvdIMlf2OJmqbyFfOe
         JfeWE+pqXPp+3UNEHShg/bX24CFwOgu+JjGsZLRU1TGGtnmCnIaF3scogwwcO4Q+90Pk
         HTdwKMh+5GA8ZG/+4K617MQST+65cyZxkfh9dmz71AwlA34Pv40892GvmODxS+03djPC
         cl43RSWsyoxeK6C+XYz9lI4Rh0ntMkkGQWn8fSzdtJd34ioccBEvfdr1XTTXbNOb05gM
         IzXA==
X-Gm-Message-State: APjAAAUfJHy2lXE9LV3Yu3dc8pkekDModmwofZy8b1aTQ9DxZig32VH8
        uTnMkr/HXud9p4eTOcHbbWvM4AdllIc=
X-Google-Smtp-Source: APXvYqy6kLsO/tkJAoIFyJyk7AIPAoPjwJIqa5zEChEp3fY38wgcdJJvlUlEEzqssc52wZ8uPEIIog==
X-Received: by 2002:a05:6000:1289:: with SMTP id f9mr20971212wrx.125.1560426364641;
        Thu, 13 Jun 2019 04:46:04 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b203sm2906357wmd.41.2019.06.13.04.46.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 04:46:03 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@tycho.nsa.gov>
Subject: [PATCH userspace v4 4/4] checkpolicy: add flag to enable policy optimization
Date:   Thu, 13 Jun 2019 13:45:58 +0200
Message-Id: <20190613114558.32621-5-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613114558.32621-1-omosnace@redhat.com>
References: <20190613114558.32621-1-omosnace@redhat.com>
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
[omosnace: update man page]
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 checkpolicy/checkpolicy.8 |  3 +++
 checkpolicy/checkpolicy.c | 16 ++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/checkpolicy/checkpolicy.8 b/checkpolicy/checkpolicy.8
index 8f7dad41..1552f497 100644
--- a/checkpolicy/checkpolicy.8
+++ b/checkpolicy/checkpolicy.8
@@ -48,6 +48,9 @@ Sort ocontexts before writing out the binary policy. This option makes output of
 .B \-t,\-\-target
 Specify the target platform (selinux or xen).
 .TP
+.B \-O,\-\-optimize
+Optimize the final kernel policy (remove redundant rules).
+.TP
 .B \-V,\-\-version
 Show version information.
 .TP
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

