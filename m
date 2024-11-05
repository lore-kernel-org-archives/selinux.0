Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879411E6DCD
	for <selinux@vger.kernel.org>; Tue,  5 Nov 2024 18:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831609; cv=none; b=n8QKSAh3J6A7h4x1SCVfmzZ6qohsIdhIBbPpopI5aMLbOR1V5DzPXDxk3BK3KCeBvQmxRMw3Z4VNeo5wKX+eDJpfwyAOHGtJyZAubWDkT5ZSkAAeMvuJYyYrgp11TND28LnhZ06Nx8KadacQZhhaTRkjqZjaTta1blG3SvzTq2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831609; c=relaxed/simple;
	bh=7TjSWdal1fJ5jJd1CoGqc+MyKwRE/dr/L3dlofBlOFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEIWaEr5zpc4wK5e2W9JJLrm1gMNj2Jl7eCA+7ZvM4F5MddqN+V8QxmOKQGfyQ3KcXLSwZ/EYf9SQm8UV3nCLK+3H6QdCXiloP5MDcLtz9uytq76IX2sLALx1L74X6xRxGdIj2+Rg80atyOUXZhQ/12R+LjuX9gkScAvSrCwAV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=HqQR2Moo; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="HqQR2Moo"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1730831605;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CZzXl71UqrpurA0M2pvOQ6mxrFu255NQsUTq9gJQjGU=;
	b=HqQR2MooMQWdp/PEY3aHDdjiPPeYTVUK7XErg/VD2sdZcQw4One+eXRn+dWvDeS43xW7HY
	zz3nHUxyF4Nus03/shUbETCAh4fF3XHYojB0cQkMQighghZeDIBWtDU9Akz4se8FpXW3Ec
	vum4Yq/QkXOO2LOuik8iUenms8FUJm9thiBO7RGFpPeoRec9EBADLWrrx/MXPLHPR32q3j
	Auotuk7/h4nEiDcB4cwEnEHMKrvFpYsNHLp1ABtnSlMKaKqAcGcqMwWkeMJ2v+33OsZra7
	/sWt6fXMYYfAXZKHZft066sZ95XGTclm8kJkLl3Xnu86hGj0LWWil1lp4zvXOQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v3 2/9] libselinux/utils: introduce selabel_compare
Date: Tue,  5 Nov 2024 19:33:12 +0100
Message-ID: <20241105183319.250410-3-cgoettsche@seltendoof.de>
In-Reply-To: <20241105183319.250410-1-cgoettsche@seltendoof.de>
References: <20241105183319.250410-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

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
2.45.2

