Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3037C79DAC
	for <selinux@vger.kernel.org>; Wed, 31 Jan 2024 13:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706531; cv=none; b=ZmYVhgYoGVBWDFMvPyFLGiGwdtxUQeYB2VWDvvekzy2NeNnWQNcICVfLpqydaOk5p9nzoT5vzcyeigL1b0TlPbUNMHvdoFdCdOlpFo1VsbNgfO1r2cNtb+E0HUuW0Qrp5NbIG3+HYF6r/qFKpiT3qHn+EUtj+sBVwrA2vb39ITk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706531; c=relaxed/simple;
	bh=0851vmmIgh8+SmUY9KEPuuu43Y8pEeL3hbbvcKFwCu8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HLHS5PZvgelPcviRGaP6vRznqm9BA7Nk3sQ/nCxG6A+TLtm1bGYGwfshLVyytxRthMEqLuSrbOKni/9d8jN30b/JETmDQnZ8IbpR9inf8KNhbC1NK5897JJ9+1zGlJKYtakHPJsYfLhjvvoayPlz/tU+UtfkWeGmfUmXY+4d6rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=IkBeaSAX; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IkBeaSAX"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a35c0ed672cso449351366b.1
        for <selinux@vger.kernel.org>; Wed, 31 Jan 2024 05:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1706706528; x=1707311328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rIuTgB07hULnSdkm9iyX6/1iH/UnOca2f/RK7fwGyTI=;
        b=IkBeaSAXN2EPAvMGs6EAHNnmsLzVd4DfMi+YUwHdp7zwkAVm3TgNDPgcKDYJuKAxHV
         tw+t6+lSoxqSoXcTiSuT5dWM0x7ntkwNcaj0l06V/UxX6HzCsZk7NpsYisrRx4rhhE+b
         l0lbiJ7ZbZ2QzEXcttsdneCCdXy2eR7wIDSWCs9r+xYXzOpi1aKqJ89ci4ZTphDP704o
         T4hUQxkvZfamzvdgyIN4NyqL2mAfUL3alwt2UGMB/vUUaydWHk4eqTWzZiULRf4iFFoJ
         A6OvV632Z0+PMvxhTerDcIToJ0RRsNpajskNOhj1GN7iXYNpnKWM0V7AgxrqppZIIFdZ
         466Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706706528; x=1707311328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIuTgB07hULnSdkm9iyX6/1iH/UnOca2f/RK7fwGyTI=;
        b=uZrJxKb1jvliV7hTn4SSxfcLeN24W1+OP0S5EPq6oNSphnSS8fH2VvAHUDgTUIwEmr
         kavIXyInr8+NfYyjiEredrH8ZfSQtaLDSpjIiQp6gi5tNofOKNqZGt4YG6/R7wpLFgAr
         bnSP7Zq6+l1B6k8IeA4gUG16zNCkXyTcF4L2KSlIYapjTyUx7EcSpgo3CRGM5j147htW
         ei/bSdtbKSDMHN46T93GsBqENimarrB0VXk0dRZUheJWbwwsf627Kz9rHFerM+pWyz00
         LpZErTVD/M1tn3b3GcU8ydvQojScZkpGdg+bERbky5ehB3s6eg9oade6naaxXDg98ZsB
         FnfA==
X-Gm-Message-State: AOJu0YxzroLbfV0zmPR/3zNxuJujX7XCM8My8kO4EfwI1AD23U7OwJ/z
	ABQRYo0KCjvoQg+lTc0qY+VmR6MDn8XF7GUTsIX3yGxKmW3Z7XY/5qTJS1zL
X-Google-Smtp-Source: AGHT+IFrt7ii32kqgGprxZ+xze27ThKKPPO45BpjeG6WK9zVz/fpVy3fF1mvg+brngj727Gjn3scgw==
X-Received: by 2002:a17:906:f146:b0:a30:5881:4da with SMTP id gw6-20020a170906f14600b00a30588104damr1142685ejb.16.1706706528224;
        Wed, 31 Jan 2024 05:08:48 -0800 (PST)
Received: from ddev.DebianHome (dynamic-078-050-045-093.78.50.pool.telefonica.de. [78.50.45.93])
        by smtp.gmail.com with ESMTPSA id p14-20020a170906784e00b00a365c673251sm890351ejm.216.2024.01.31.05.08.47
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 05:08:47 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [RFC PATCH v2 2/9] libselinux/utils: introduce selabel_compare
Date: Wed, 31 Jan 2024 14:08:28 +0100
Message-ID: <20240131130840.48155-3-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131130840.48155-1-cgzones@googlemail.com>
References: <20240131130840.48155-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a utility around selabel_cmp(3).

Can be used by users to compare a pre-compiled fcontext file to an
original text-based file context definition file.

Can be used for development to verify compilation and parsing of the
pre-compiled fcontext format works correctly.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2:
   split nested block into own function
---
 libselinux/utils/.gitignore        |   1 +
 libselinux/utils/selabel_compare.c | 122 +++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+)
 create mode 100644 libselinux/utils/selabel_compare.c

diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
index b3311360..2e10b14f 100644
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
index 00000000..9ca6eff1
--- /dev/null
+++ b/libselinux/utils/selabel_compare.c
@@ -0,0 +1,122 @@
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
+static int compare(const char *file1, const char *file2, const char *validate, unsigned int backend)
+{
+	struct selabel_handle *hnd1, *hnd2;
+	const struct selinux_opt selabel_option1[] = {
+		{ SELABEL_OPT_PATH, file1 },
+		{ SELABEL_OPT_VALIDATE, validate }
+	};
+	const struct selinux_opt selabel_option2[] = {
+		{ SELABEL_OPT_PATH, file2 },
+		{ SELABEL_OPT_VALIDATE, validate }
+	};
+	enum selabel_cmp_result result;
+
+	hnd1 = selabel_open(backend, selabel_option1, 2);
+	if (!hnd1) {
+		fprintf(stderr, "ERROR: selabel_open - Could not obtain handle for %s:  %m\n", file1);
+		return EXIT_FAILURE;
+	}
+
+	hnd2 = selabel_open(backend, selabel_option2, 2);
+	if (!hnd2) {
+		fprintf(stderr, "ERROR: selabel_open - Could not obtain handle for %s:  %m\n", file2);
+		selabel_close(hnd1);
+		return EXIT_FAILURE;
+	}
+
+	result = selabel_cmp(hnd1, hnd2);
+
+	selabel_close(hnd2);
+	selabel_close(hnd1);
+
+	switch (result) {
+	case SELABEL_SUBSET:
+		printf("spec %s is a subset of spec %s\n", file1, file2);
+		break;
+	case SELABEL_EQUAL:
+		printf("spec %s is equal to spec %s\n", file1, file2);
+		break;
+	case SELABEL_SUPERSET:
+		printf("spec %s is a superset of spec %s\n", file1, file2);
+		break;
+	case SELABEL_INCOMPARABLE:
+		printf("spec %s is uncomparable to spec %s\n", file1, file2);
+		break;
+	default:
+		fprintf(stderr, "ERROR: selabel_cmp - Unexpected result %d\n", result);
+		return EXIT_FAILURE;
+	}
+
+	return EXIT_SUCCESS;
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
+	return compare(file1, file2, validate, backend);
+}
-- 
2.43.0

