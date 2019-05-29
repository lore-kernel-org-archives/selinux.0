Return-Path: <SRS0=VF96=T5=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706E0C04AB3
	for <selinux@archiver.kernel.org>; Wed, 29 May 2019 07:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF4F208C3
	for <selinux@archiver.kernel.org>; Wed, 29 May 2019 07:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfE2HiK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 29 May 2019 03:38:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36262 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfE2HiJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 29 May 2019 03:38:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id s17so929022wru.3
        for <selinux@vger.kernel.org>; Wed, 29 May 2019 00:38:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z3emoAOqvRyp5FyeABXgrfZG4KaxiHsLNxvolGT7DXE=;
        b=T09enPqcUAF+KYXxDSonSY2MbG70IlXmnBrkmOs57IoYpYCA6Ur8quFs4lXkWmfz5A
         9f5YvLGzmp2U3BsdwtXMz8W25RvhxGorHnGf+PjmrmQ2+TZNGVW3d7niwRlkNCo9LoCM
         3S25VvDVvN8pzLh0sD5M/IujfnE7yVi269NzGqSLnQjh+SsG0THMIjIoHiF1g+RhL3c4
         cxZnBkKNjj4GxgZgLpoPHRYT6d48qGLOlvQp7lnPvpJJfIC6Y5WnEe48pzyQat3GmzL9
         uuBekU8/jzyRfHrVco/9zQKsXkBS68JErWBgv4eyPOC24BdhzJaZJQBu8lQUvPnXMKUN
         tF9w==
X-Gm-Message-State: APjAAAVK6K8eTNPl8bvurbwly3Z3q1cCdVo/iU5FH0fOR21zN74CjLoY
        bzK1PVOphpOJlkhQkLcs1JYO6T5tFkQ=
X-Google-Smtp-Source: APXvYqy/oLGZr/KCQ5CcssASfJ6GP+DsIShzqU1UKEzQCwRkfphOqZ+o5fhGbOB5JABDUC8AHbynhQ==
X-Received: by 2002:adf:ee0b:: with SMTP id y11mr10799797wrn.241.1559115487429;
        Wed, 29 May 2019 00:38:07 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id p16sm32024877wrg.49.2019.05.29.00.38.06
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 00:38:06 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v3 4/7] secilc: add flag to enable policy optimization
Date:   Wed, 29 May 2019 09:37:56 +0200
Message-Id: <20190529073759.20548-5-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529073759.20548-1-omosnace@redhat.com>
References: <20190529073759.20548-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a command-line option -O/--optimize to optimize the final policydb
using sepol_policydb_optimize() before writing it out.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 secilc/secilc.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/secilc/secilc.c b/secilc/secilc.c
index ad6862ba..186c5a73 100644
--- a/secilc/secilc.c
+++ b/secilc/secilc.c
@@ -68,6 +68,7 @@ static __attribute__((__noreturn__)) void usage(const char *prog)
 	printf("  -G, --expand-generated         Expand and remove auto-generated attributes\n");
 	printf("  -X, --expand-size <SIZE>       Expand type attributes with fewer than <SIZE>\n");
 	printf("                                 members.\n");
+	printf("  -O, --optimize                 optimize final policy\n");
 	printf("  -v, --verbose                  increment verbosity level\n");
 	printf("  -h, --help                     display usage information\n");
 	exit(1);
@@ -97,6 +98,7 @@ int main(int argc, char *argv[])
 	int policyvers = POLICYDB_VERSION_MAX;
 	int attrs_expand_generated = 0;
 	int attrs_expand_size = -1;
+	int optimize = 0;
 	int opt_char;
 	int opt_index = 0;
 	char *fc_buf = NULL;
@@ -117,12 +119,13 @@ int main(int argc, char *argv[])
 		{"filecontexts", required_argument, 0, 'f'},
 		{"expand-generated", no_argument, 0, 'G'},
 		{"expand-size", required_argument, 0, 'X'},
+		{"optimize", no_argument, 0, 'O'},
 		{0, 0, 0, 0}
 	};
 	int i;
 
 	while (1) {
-		opt_char = getopt_long(argc, argv, "o:f:U:hvt:M:PDmNc:GX:", long_opts, &opt_index);
+		opt_char = getopt_long(argc, argv, "o:f:U:hvt:M:PDmNOc:GX:n", long_opts, &opt_index);
 		if (opt_char == -1) {
 			break;
 		}
@@ -211,6 +214,9 @@ int main(int argc, char *argv[])
 				}
 				break;
 			}
+			case 'O':
+				optimize = 1;
+				break;
 			case 'h':
 				usage(argv[0]);
 			case '?':
@@ -294,6 +300,14 @@ int main(int argc, char *argv[])
 		goto exit;
 	}
 
+	if (optimize) {
+		rc = sepol_policydb_optimize(pdb);
+		if (rc != SEPOL_OK) {
+			fprintf(stderr, "Failed to optimize policydb\n");
+			goto exit;
+		}
+	}
+
 	if (output == NULL) {
 		int size = snprintf(NULL, 0, "policy.%d", policyvers);
 		output = malloc((size + 1) * sizeof(char));
-- 
2.20.1

