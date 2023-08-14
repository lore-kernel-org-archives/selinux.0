Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31B2C16B13
	for <selinux@archiver.kernel.org>; Mon, 14 Aug 2023 13:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjHNNVV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Aug 2023 09:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjHNNU6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Aug 2023 09:20:58 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2119E10E5
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:49 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99357737980so575538766b.2
        for <selinux@vger.kernel.org>; Mon, 14 Aug 2023 06:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1692019247; x=1692624047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VNSVLz+2snj6v4+tEhoQzyNUr3LpxDI/LvJXtCV0YHg=;
        b=LwhoyhUA08IU5KakXBnUubLa050RqKFzdIa5xJYyISY/o20qZS2gFg/iEM0Ymn+i1j
         2h2n3NiCnKEEsnf3byhiKhevw0DKU3R6LUtOfWRFwJjnruQ7Os99JRPyHAhgrbWYDSoT
         KR60FA6b6U7w0hauAyIYEXWyj1fP/xG4gY8tcgY9Y+GXSjXiSG4I51efr1orE4U8yxAs
         2efRg6mvfordXwdoD2aZ5bnmdMkmIOvzzqJ7k9Qn+ngA3Ab3XbfLrU9111mO9jUVZCRl
         wGVrHug5ageL3oLdTL72qqJVa3utST7LfYPq3SIzZdmsWCSbWbkrn/jpl30cbgDGzAig
         En8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692019247; x=1692624047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VNSVLz+2snj6v4+tEhoQzyNUr3LpxDI/LvJXtCV0YHg=;
        b=BYxqznI9BgwGAGnN0wVfj52yboPE0/0Xr9H2FJ4zboEAx9DofnP97ZUzT46NJarf9G
         wq6XfavaLtAw55PdOx1M3+B0azSZaZVTU+IRMKc2rS4EnTApgRlG+6QD6IvnQs5gr0Be
         0ya85zvD2gfMsezd7qhhwLFqNtp+ayuRm5nZH6waUDciDtjHR5RPoVruTaAmd+z+MTxz
         BcMl/Dk4BkbmyZlZ1bdPSfbCk5Ash5wNoLXuonPhwKPcGlbxbZVyWTkZipmuJxb/onqN
         doEXzp9iQsrK8kRVq/hCLMxlKtcMzemtz8NusYhj1ws5OqqAOfpi9aKCPzxAelQXUZnE
         JaJg==
X-Gm-Message-State: AOJu0YwpM/HPfdr9o1l9ocXO5LYrc+K/EGs+TA7/osUXv5HPTKicvJk7
        f5zxaf2vUp9fxa9Cw+B8Z/nwTcWYT46/C4TTu/U=
X-Google-Smtp-Source: AGHT+IFe2MdPtRGAwmq8mt29apR/xMueO4iDTK1+sfkGJE0GKzjI0qfm7bKj5CUIVgWpmJSfFxlY8g==
X-Received: by 2002:a17:906:292a:b0:99b:d1d8:d747 with SMTP id v10-20020a170906292a00b0099bd1d8d747mr8644283ejd.27.1692019247562;
        Mon, 14 Aug 2023 06:20:47 -0700 (PDT)
Received: from debian_development.DebianHome (dynamic-095-112-167-009.95.112.pool.telefonica.de. [95.112.167.9])
        by smtp.gmail.com with ESMTPSA id ck9-20020a170906c44900b00993664a9987sm5683541ejb.103.2023.08.14.06.20.46
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 06:20:47 -0700 (PDT)
From:   =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To:     selinux@vger.kernel.org
Subject: [RFC PATCH v2 13/27] libselinux/utils: introduce selabel_compare
Date:   Mon, 14 Aug 2023 15:20:11 +0200
Message-Id: <20230814132025.45364-14-cgzones@googlemail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230814132025.45364-1-cgzones@googlemail.com>
References: <20230814132025.45364-1-cgzones@googlemail.com>
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

