Return-Path: <SRS0=L/M1=UM=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02443C31E4A
	for <selinux@archiver.kernel.org>; Thu, 13 Jun 2019 15:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E832082C
	for <selinux@archiver.kernel.org>; Thu, 13 Jun 2019 15:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbfFMP0V (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:26:21 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35756 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729220AbfFMLqG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Jun 2019 07:46:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id c6so9809104wml.0
        for <selinux@vger.kernel.org>; Thu, 13 Jun 2019 04:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QS17Kf4IFQ3CkNgeh/iJndUe8J5r8dyCU5F990FbKuI=;
        b=gk+KpVABkPJSDZhoQJw5awa6/azXWBKYwFV+vd28rqMRxrgGznum05+dJXXdiEjqw3
         YP6ZdplARqYPV7STE7NmxXh8mdPcduy26/ubNmgfZZb+/CB3nsJfIbjLOSnGldVK6OoY
         HCPOPiWar+4QEJKbU9EAgdztV6egBgvNVdrHxhfCVhrRHaTLTMV6CzmoSE0fCTpxE2+h
         3oboeZ6OypzpfrNt+VyFV35XysdBKTLqAsjNvYhoRA2N/97moPdLvFndqxS6o94TTmVj
         KmGrnYq01SEnyVOGHb5dDIRJ7nKtD+E8IRV5zs9yA8Jd9VeZ+o/YryrZypxhNq7qqOoP
         yxhw==
X-Gm-Message-State: APjAAAVeDeBxcxJwiKzbVcF8BplKbzYXwUs5w/ki880d/88go2BhPNK1
        aHOwE4C8nePCISlj8JfKlEZLxk3jpvs=
X-Google-Smtp-Source: APXvYqxSeOdtYFF6sgbe8VyPJ5CcjHUkLPO67FsbpSLpV56WyctQuMgqqxkJQXkl505rrO1TfLWYig==
X-Received: by 2002:a1c:be0a:: with SMTP id o10mr3411941wmf.91.1560426363601;
        Thu, 13 Jun 2019 04:46:03 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b203sm2906357wmd.41.2019.06.13.04.46.02
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 04:46:02 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace v4 3/4] secilc: add flag to enable policy optimization
Date:   Thu, 13 Jun 2019 13:45:57 +0200
Message-Id: <20190613114558.32621-4-omosnace@redhat.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613114558.32621-1-omosnace@redhat.com>
References: <20190613114558.32621-1-omosnace@redhat.com>
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
 secilc/secilc.8.xml |  5 +++++
 secilc/secilc.c     | 16 +++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/secilc/secilc.8.xml b/secilc/secilc.8.xml
index e08a9624..2b734f09 100644
--- a/secilc/secilc.8.xml
+++ b/secilc/secilc.8.xml
@@ -95,6 +95,11 @@
             <listitem><para>Expand type attributes with fewer than <emphasis role="bold">&lt;SIZE></emphasis> members.</para></listitem>
          </varlistentry>
 
+         <varlistentry>
+            <term><option>-O, --optimize</option></term>
+            <listitem><para>Optimize final policy (remove redundant rules).</para></listitem>
+         </varlistentry>
+
          <varlistentry>
             <term><option>-v, --verbose</option></term>
             <listitem><para>Increment verbosity level.</para></listitem>
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

