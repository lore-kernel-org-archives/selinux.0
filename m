Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230B1C04FE0
	for <selinux@archiver.kernel.org>; Fri, 11 Aug 2023 16:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjHKQ17 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 11 Aug 2023 12:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjHKQ15 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 11 Aug 2023 12:27:57 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C506819AE
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:56 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so301017866b.3
        for <selinux@vger.kernel.org>; Fri, 11 Aug 2023 09:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1691771275; x=1692376075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VNSVLz+2snj6v4+tEhoQzyNUr3LpxDI/LvJXtCV0YHg=;
        b=Yh0caa+2a7pSV9xhcBUiWimMTX3e4dgA5XdBqoZGYYDS4UU4pxbyEUKqmMmU7kyUFF
         zR7OCBgLAA+QGVfQQh3f6ZhqDoP3YMkxg1Fungkq9pXHMv+Kmr1jvxjIHpnVCW/3KrFD
         z0rlzzXUHoHoAw33J5uajUDERuX1nWW/LqDahplbHd7C12XjywJnQEWubvmk0A7jLcj8
         kJ7FHTAJcSTtdMsu/lU5wPByBdZEDbesoLUeIhT/GD4Sbg5eY9viBsQwIzET6prrGqNy
         tYjnrs6OvLf1kbJyhkbRWvswcTzluwHKkwTO0zbvIOkq6FFgzO8zMJzadghr86IQJvRS
         DFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771275; x=1692376075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNSVLz+2snj6v4+tEhoQzyNUr3LpxDI/LvJXtCV0YHg=;
        b=cxhoYFS4nt1FsgN4WdXEiylkrRS2Ezkk1BeRd0kI7g5dsZlf/XjxoVxFBjvridlGIR
         3tZNMty1aVa3aT7l3U960c6IfoL1KCjVnEpPCKW1nXewkFXE98J1GvYi7m8z6LTALhYh
         XZC/B0tm3wmza3W6nl6WbPqxSuSJofsVJo2ZFSgmxuY/idMLX5kElWKK4Ci30t/iv/Y2
         u+MZpNSNI4jjYdPM5fiPGyYKPaA5Qq7wwEUv7l76P2ibUf3FjYmVua32Mu/vAWIiAQVC
         AwCtPkM+Vw//oDyrLKLQNTEscD2v7B4tM8CYEdHqp8UYC8LdwHJYI4Ak5BN2ZiuKBrqb
         CDhA==
X-Gm-Message-State: AOJu0Yxzoy+o0f7kgeQHmXGODh0nSqaKDVFgvtpAiSJ4vPNdwnGB5J7w
        ChCd1zNYDRE5U18C7H1uvmWhu9kizguk1w==
X-Google-Smtp-Source: AGHT+IGpFw67C0fvLCP7aJJNzzFC4OTLMDAFe/IMe5PtUlX26l4aUZtUgBQKCQlRhREYAkdwkDQO4A==
X-Received: by 2002:a17:907:7789:b0:99b:d178:f059 with SMTP id ky9-20020a170907778900b0099bd178f059mr1819468ejc.35.1691771275176;
        Fri, 11 Aug 2023 09:27:55 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-077-000-174-226.77.0.pool.telefonica.de. [77.0.174.226])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906b20900b00992afee724bsm2408807ejz.76.2023.08.11.09.27.54
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 09:27:54 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH 13/24] libselinux/utils: introduce selabel_compare
Date:   Fri, 11 Aug 2023 18:27:20 +0200
Message-Id: <20230811162731.50697-14-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230811162731.50697-1-cgzones@googlemail.com>
References: <20230811162731.50697-1-cgzones@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Add a utility around selabel_cmp(3).

Can be used by users to compare a pre-compiled fcontext file to an
original text-based file context definition file.

Can be used for development to verify compilation and parsing of the
pre-compiled fcontext format works correctly.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/.gitignore        |   1 +
 libselinux/utils/selabel_compare.c | 119 +++++++++++++++++++++++++++++
 2 files changed, 120 insertions(+)
 create mode 100644 libselinux/utils/selabel_compare.c

diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
index a92e1e94..4e2dfba8 100644
--- a/libselinux/utils/.gitignore
+++ b/libselinux/utils/.gitignore
@@ -16,6 +16,7 @@ getseuser
 matchpathcon
 policyvers
 sefcontext_compile
+selabel_compare
 selabel_digest
 selabel_get_digests_all_partial_matches
 selabel_lookup
diff --git a/libselinux/utils/selabel_compare.c b/libselinux/utils/selabel_compare.c
new file mode 100644
index 00000000..f4325f7e
--- /dev/null
+++ b/libselinux/utils/selabel_compare.c
@@ -0,0 +1,119 @@
+#include <getopt.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <selinux/label.h>
+
+
+static void usage(const char *progname)
+{
+	fprintf(stderr,
+		"usage: %s [-b backend] [-v] file1 file2\n\n"
+		"Where:\n\t"
+		"-b           The backend - \"file\", \"media\", \"x\", \"db\" or \"prop\" (defaults to \"file\")\n\t"
+		"-v           Validate entries against loaded policy.\n\t"
+		"file1/file2  Files containing the specs.\n",
+		progname);
+}
+
+int main(int argc, char *argv[])
+{
+	unsigned int backend = SELABEL_CTX_FILE;
+	int opt;
+	const char *validate = NULL, *file1 = NULL, *file2 = NULL;
+
+	if (argc < 3) {
+		usage(argv[0]);
+		return EXIT_FAILURE;
+	}
+
+	while ((opt = getopt(argc, argv, "b:v")) > 0) {
+		switch (opt) {
+		case 'b':
+			if (!strcasecmp(optarg, "file")) {
+				backend = SELABEL_CTX_FILE;
+			} else if (!strcmp(optarg, "media")) {
+				backend = SELABEL_CTX_MEDIA;
+			} else if (!strcmp(optarg, "x")) {
+				backend = SELABEL_CTX_X;
+			} else if (!strcmp(optarg, "db")) {
+				backend = SELABEL_CTX_DB;
+			} else if (!strcmp(optarg, "prop")) {
+				backend = SELABEL_CTX_ANDROID_PROP;
+			} else if (!strcmp(optarg, "service")) {
+				backend = SELABEL_CTX_ANDROID_SERVICE;
+			} else {
+				fprintf(stderr, "Unknown backend: %s\n", optarg);
+				usage(argv[0]);
+				return EXIT_FAILURE;
+			}
+			break;
+		case 'v':
+			validate = (char *)1;
+			break;
+		default:
+			usage(argv[0]);
+			return EXIT_FAILURE;
+		}
+	}
+
+	if (argc != optind + 2) {
+		usage(argv[0]);
+		return EXIT_FAILURE;
+	}
+
+	file1 = argv[optind++];
+	file2 = argv[optind];
+
+	{
+		struct selabel_handle *hnd1, *hnd2;
+		const struct selinux_opt selabel_option1[] = {
+			{ SELABEL_OPT_PATH, file1 },
+			{ SELABEL_OPT_VALIDATE, validate }
+		};
+		const struct selinux_opt selabel_option2[] = {
+			{ SELABEL_OPT_PATH, file2 },
+			{ SELABEL_OPT_VALIDATE, validate }
+		};
+		enum selabel_cmp_result result;
+
+		hnd1 = selabel_open(backend, selabel_option1, 2);
+		if (!hnd1) {
+			fprintf(stderr, "ERROR: selabel_open - Could not obtain handle for %s:  %m\n", file1);
+			return EXIT_FAILURE;
+		}
+
+		hnd2 = selabel_open(backend, selabel_option2, 2);
+		if (!hnd2) {
+			fprintf(stderr, "ERROR: selabel_open - Could not obtain handle for %s:  %m\n", file2);
+			selabel_close(hnd1);
+			return EXIT_FAILURE;
+		}
+
+		result = selabel_cmp(hnd1, hnd2);
+
+		selabel_close(hnd2);
+		selabel_close(hnd1);
+
+		switch (result) {
+		case SELABEL_SUBSET:
+			printf("spec %s is a subset of spec %s\n", file1, file2);
+			break;
+		case SELABEL_EQUAL:
+			printf("spec %s is equal to spec %s\n", file1, file2);
+			break;
+		case SELABEL_SUPERSET:
+			printf("spec %s is a superset of spec %s\n", file1, file2);
+			break;
+		case SELABEL_INCOMPARABLE:
+			printf("spec %s is uncompareable to spec %s\n", file1, file2);
+			break;
+		default:
+			fprintf(stderr, "ERROR: selabel_cmp - Unexpected result %d\n", result);
+			return EXIT_FAILURE;
+		}
+
+		return EXIT_SUCCESS;
+	}
+}
-- 
2.40.1

