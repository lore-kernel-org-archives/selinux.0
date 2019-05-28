Return-Path: <SRS0=POVk=T4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2B8C04AB6
	for <selinux@archiver.kernel.org>; Tue, 28 May 2019 14:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6D1206BA
	for <selinux@archiver.kernel.org>; Tue, 28 May 2019 14:59:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfE1O7V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 May 2019 10:59:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39425 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbfE1O7V (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 May 2019 10:59:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id x4so1486761wrt.6
        for <selinux@vger.kernel.org>; Tue, 28 May 2019 07:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9eYHtqKIFvk2sga2800OKaRZLw8u0KfBBn2TDnauC38=;
        b=fbNp0nbMJM21bRpg+zuUwKb7jeza4RlF76zDKUojWD7YN/03Jrvc7znjqxNuIKh7i/
         /4xd+DTdYG31Yg/0EflJrVTqnXLTFdHXfeRpT3cg4YwixbRVLOX2SoqxhcY2QpsLpOa/
         V/9YD+lz8T8llPm82GG4ru3TfGx0He6qAsRqOC/HUFCrqvcZhxLEEYzleiA4T5t6QXA9
         r6K6tXi/+TadqV6ZnT6eqSpIZ0yB0AKigZVqO3VeA7fOh5F5BeCdcW8ivVQjfRXv2u+X
         ziepPYlikXgktUxOSPsfUum952JiRSGydJ7My9HZ4jAGsf44yGhSwOAyxteJNgQMZhMK
         geTw==
X-Gm-Message-State: APjAAAX5UKmkU4awrv/XsA35IJ+A4sKhpm010qMfuJTcpYwJeOIYsNrA
        sOJnIMlua5gigbWsgI0OuSAsRzer6Yg=
X-Google-Smtp-Source: APXvYqyjfreNgVYSei789nkhGV1fwYfFQ3GIQhPYSoplo+vrt115D9QjHV84pURpOoU1WmHzj4guhA==
X-Received: by 2002:adf:deca:: with SMTP id i10mr6633086wrn.313.1559055558989;
        Tue, 28 May 2019 07:59:18 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id p17sm14118849wrq.95.2019.05.28.07.59.18
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 May 2019 07:59:18 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v2 4/7] secilc: add flag to enable policy optimization
Date:   Tue, 28 May 2019 16:59:09 +0200
Message-Id: <20190528145912.13827-5-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190528145912.13827-1-omosnace@redhat.com>
References: <20190528145912.13827-1-omosnace@redhat.com>
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
index ad6862ba..26996ef9 100644
--- a/secilc/secilc.c
+++ b/secilc/secilc.c
@@ -68,6 +68,7 @@ static __attribute__((__noreturn__)) void usage(const char *prog)
 	printf("  -G, --expand-generated         Expand and remove auto-generated attributes\n");
 	printf("  -X, --expand-size <SIZE>       Expand type attributes with fewer than <SIZE>\n");
 	printf("                                 members.\n");
+	printf("  -n, --no-optimize              do not optimize final policy\n");
 	printf("  -v, --verbose                  increment verbosity level\n");
 	printf("  -h, --help                     display usage information\n");
 	exit(1);
@@ -97,6 +98,7 @@ int main(int argc, char *argv[])
 	int policyvers = POLICYDB_VERSION_MAX;
 	int attrs_expand_generated = 0;
 	int attrs_expand_size = -1;
+	int optimize_policy = 1;
 	int opt_char;
 	int opt_index = 0;
 	char *fc_buf = NULL;
@@ -117,12 +119,13 @@ int main(int argc, char *argv[])
 		{"filecontexts", required_argument, 0, 'f'},
 		{"expand-generated", no_argument, 0, 'G'},
 		{"expand-size", required_argument, 0, 'X'},
+		{"no-optimize", no_argument, 0, 'n'},
 		{0, 0, 0, 0}
 	};
 	int i;
 
 	while (1) {
-		opt_char = getopt_long(argc, argv, "o:f:U:hvt:M:PDmNc:GX:", long_opts, &opt_index);
+		opt_char = getopt_long(argc, argv, "o:f:U:hvt:M:PDmNc:GX:n", long_opts, &opt_index);
 		if (opt_char == -1) {
 			break;
 		}
@@ -211,6 +214,9 @@ int main(int argc, char *argv[])
 				}
 				break;
 			}
+			case 'n':
+				optimize_policy = 0;
+				break;
 			case 'h':
 				usage(argv[0]);
 			case '?':
@@ -294,6 +300,14 @@ int main(int argc, char *argv[])
 		goto exit;
 	}
 
+	if (optimize_policy) {
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

