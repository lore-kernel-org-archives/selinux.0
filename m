Return-Path: <SRS0=8MrU=TX=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE09C282DD
	for <selinux@archiver.kernel.org>; Thu, 23 May 2019 10:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2910421019
	for <selinux@archiver.kernel.org>; Thu, 23 May 2019 10:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbfEWKY4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 23 May 2019 06:24:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36694 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfEWKY4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 23 May 2019 06:24:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id j187so5192878wmj.1
        for <selinux@vger.kernel.org>; Thu, 23 May 2019 03:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l7eNceQIxpLjyVEp44KrcmLqz4sl3sg1Xkdmlo5pBuA=;
        b=T5MNgqW73BnMwH5E0h/EJ4TL/76K62Aejd3V1ey+viVKJnfO3076SX0UiZUWJKde8w
         xMRMjXBWThXUDW0OOLRG6XEKu8CZ1mkd4sqrRLvcb7KoP3oHKmToQNakTsyUklifPnqI
         dN97NGd6IjrdFuvrk2iQ3H7XeiQLttMbnuFs30n+XHdSfaz6940u9xjLLY3X3Il/oglq
         HX8n3iWDnWvHqtY8g8ofYQ/bPXT97H/PW+bOnZiIT4D80FNhOnssPgIlJyYrfv/DY6cg
         3L6b3NF7wAIIO3bMTiIXZ+mZisyyaMCXEWAdo4zP5NNNY0CTsDzwH4fbEcieAaVX0jna
         b2mw==
X-Gm-Message-State: APjAAAWdLhm8rBg88iiusL8+DE/QhntALsDPr05Ur+BXputYbjoFbj1J
        qL4p2seklKqyrK1pxDq0RUrTwIPEcOE=
X-Google-Smtp-Source: APXvYqwh9Fla04tICw1YBf3Jotjx/NPAWNxMxj+IZTMBAg2fCBqHqhEphwNnca28+kQ+WH8zE7HArA==
X-Received: by 2002:a1c:254:: with SMTP id 81mr10973646wmc.151.1558607094310;
        Thu, 23 May 2019 03:24:54 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id x22sm10423388wmi.4.2019.05.23.03.24.53
        for <selinux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 03:24:53 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace 2/4] secilc: optimize policy before writing
Date:   Thu, 23 May 2019 12:24:47 +0200
Message-Id: <20190523102449.9621-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523102449.9621-1-omosnace@redhat.com>
References: <20190523102449.9621-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Call sepol_policydb_optimize() on the final policydb before writing it
out. Also add a command-line flag to optionally skip this step.

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

