Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771192DF6EA
	for <selinux@vger.kernel.org>; Fri, 20 Mar 2026 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027712; cv=none; b=LHR88aQnVTNYFDJlrBxmTJiK05HZc9lvPlByiE1zhUZHfshnFU10gnatDFxd9BCo/kpJ6W9n+oL0MCkNmkU4wy25Q22bQ3BjAQXRApeEr4YKWkdaaYbWj1E8bQGYgMNNqxmtwKJ1t8Ypt31SOJPzYps392Qel1TMmlgjUA4fQDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027712; c=relaxed/simple;
	bh=EOFOqupoiJHFVydnsX3sVZtto0WbnjWofgsOIBesLH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EJo4wgFktCMn9FBAg2fAgapNwGFwV9YqSW/xJn7YsXnndvAcFkrE2s5YLTW0asadZQaYPPEUnbXJfAFUsPrPCis5/c1AkKS3Z2RiX99mOm5ADtadxyCo6XWmVl3wfZ6HlmJ7fbp2ffIKYrzmmczPo3B7kC3xA4imLPbKhV+MIT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=uvv2M+BX; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="uvv2M+BX"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1774027708;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=XtyNdeW9612qKFWDd7wm+yF0f0ZVq5PXU6j85N2bpT0=;
	b=uvv2M+BXpr5WDQ0WByfuMnS05+S6i7wPC3mQjpV9PTUuvX8bmELlzy7XuVCluzyMbvQumv
	HMtbOJZ4mTBoSZ5ExTb9GnilFSAGAto8/c6zwFW1hckIA1x9fRjSID04aaTe1KSO8+Zi1f
	g3WMxikMMiNxzwbczfMvFXWwnptYCxJHm6VyIEcmlSMU5Q/oJqsReOZJBzwIQ1H/TH56Bt
	g90k0oitprjnPgAm1i7CwrVFj9+RZsZv1byaxNNmlDL2bN8p5sNuU8caKkiewbpqUN1KzD
	WsgODzpPyFTcccnhoI/jGHTB1K/BYeUdtmKObToYACe/jq0Zrkplo/poBSxBeQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [DEV-TOOL - DO NOT APPLY] selabel_partial_match_all
Date: Fri, 20 Mar 2026 18:28:23 +0100
Message-ID: <20260320172823.97791-1-cgoettsche@seltendoof.de>
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

Tool to test the patch "libselinux: correctly find partial matches".

---
 libselinux/include/selinux/label.h           |   1 +
 libselinux/src/label.c                       |   9 ++
 libselinux/src/label_file.c                  |   6 +
 libselinux/src/label_internal.h              |   1 +
 libselinux/src/libselinux.map                |   5 +
 libselinux/utils/.gitignore                  |   1 +
 libselinux/utils/Makefile                    |   2 +-
 libselinux/utils/selabel_partial_match_all.c | 156 +++++++++++++++++++
 8 files changed, 180 insertions(+), 1 deletion(-)
 create mode 100644 libselinux/utils/selabel_partial_match_all.c

diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
index ce189a3a..cbf4b482 100644
--- a/libselinux/include/selinux/label.h
+++ b/libselinux/include/selinux/label.h
@@ -105,6 +105,7 @@ extern int selabel_lookup_raw(struct selabel_handle *handle, char **con,
 			      const char *key, int type);
 
 extern bool selabel_partial_match(struct selabel_handle *handle, const char *key);
+extern struct lookup_result *selabel_partial_match_all(struct selabel_handle *handle, const char *key);
 
 extern bool selabel_get_digests_all_partial_matches(struct selabel_handle *rec,
 						    const char *key,
diff --git a/libselinux/src/label.c b/libselinux/src/label.c
index 2c510290..7269864e 100644
--- a/libselinux/src/label.c
+++ b/libselinux/src/label.c
@@ -310,6 +310,15 @@ bool selabel_partial_match(struct selabel_handle *rec, const char *key)
 	return rec->func_partial_match(rec, key);
 }
 
+struct lookup_result *selabel_partial_match_all(struct selabel_handle *rec, const char *key)
+{
+	if (!rec->func_partial_match_all) {
+		return NULL;
+	}
+
+	return rec->func_partial_match_all(rec, key);
+}
+
 bool selabel_get_digests_all_partial_matches(struct selabel_handle *rec,
 					     const char *key,
 					     uint8_t **calculated_digest,
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 31f134f9..2412a6d7 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -2204,6 +2204,11 @@ static bool partial_match(struct selabel_handle *rec, const char *key)
 	return !!lookup_common(rec, key, 0, true, &buf);
 }
 
+static struct lookup_result *partial_match_all(struct selabel_handle *rec, const char *key)
+{
+	return lookup_all(rec, key, 0, true, true, NULL);
+}
+
 static struct selabel_lookup_rec *lookup_best_match(struct selabel_handle *rec,
 						    const char *key,
 						    const char **aliases,
@@ -2634,6 +2639,7 @@ int selabel_file_init(struct selabel_handle *rec,
 	rec->func_stats = &stats;
 	rec->func_lookup = &lookup;
 	rec->func_partial_match = &partial_match;
+	rec->func_partial_match_all = &partial_match_all;
 	rec->func_get_digests_all_partial_matches = &get_digests_all_partial_matches;
 	rec->func_hash_all_partial_matches = &hash_all_partial_matches;
 	rec->func_lookup_best_match = &lookup_best_match;
diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
index 743dbf94..33b93b77 100644
--- a/libselinux/src/label_internal.h
+++ b/libselinux/src/label_internal.h
@@ -87,6 +87,7 @@ struct selabel_handle {
 	void (*func_close) (struct selabel_handle *h);
 	void (*func_stats) (struct selabel_handle *h);
 	bool (*func_partial_match) (struct selabel_handle *h, const char *key);
+	struct lookup_result* (*func_partial_match_all) (struct selabel_handle *h, const char *key);
 	bool (*func_get_digests_all_partial_matches) (struct selabel_handle *h,
 						      const char *key,
 						      uint8_t **calculated_digest,
diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.map
index 95cd53b0..a62f6bca 100644
--- a/libselinux/src/libselinux.map
+++ b/libselinux/src/libselinux.map
@@ -267,3 +267,8 @@ LIBSELINUX_3.10 {
   global:
     selinux_restorecon_get_relabeled_files;
 } LIBSELINUX_3.9;
+
+LIBSELINUX_3.11 {
+  global:
+    selabel_partial_match_all;
+} LIBSELINUX_3.10;
diff --git a/libselinux/utils/.gitignore b/libselinux/utils/.gitignore
index 2e10b14f..141fe76c 100644
--- a/libselinux/utils/.gitignore
+++ b/libselinux/utils/.gitignore
@@ -22,6 +22,7 @@ selabel_get_digests_all_partial_matches
 selabel_lookup
 selabel_lookup_best_match
 selabel_partial_match
+selabel_partial_match_all
 selinux_check_securetty_context
 selinuxenabled
 selinuxexeccon
diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index 20dc44eb..c653d71a 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -58,7 +58,7 @@ sefcontext_compile: LDLIBS += ../src/libselinux.a -lsepol
 PCRE_USERS = matchpathcon sefcontext_compile selabel_compare \
 	selabel_digest selabel_get_digests_all_partial_matches \
 	selabel_lookup selabel_lookup_best_match \
-	selabel_partial_match
+	selabel_partial_match selabel_partial_match_all
 $(PCRE_USERS): LDLIBS += $(PCRE_LDLIBS)
 
 all: $(TARGETS)
diff --git a/libselinux/utils/selabel_partial_match_all.c b/libselinux/utils/selabel_partial_match_all.c
new file mode 100644
index 00000000..a78b0c97
--- /dev/null
+++ b/libselinux/utils/selabel_partial_match_all.c
@@ -0,0 +1,156 @@
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <getopt.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <selinux/selinux.h>
+#include <selinux/label.h>
+
+static __attribute__ ((__noreturn__)) void usage(const char *progname)
+{
+	fprintf(stderr,
+		"usage:  %s [-v] -p <path> [-f file]\n\n"
+		"Where:\n\t"
+		"-v  Validate file_contxts entries against loaded policy.\n\t"
+		"-p  Path to check if a match or partial match is possible\n\t"
+		"    against a regex entry in the file_contexts file.\n\t"
+		"-f  Optional file_contexts file (defaults to current policy).\n\n"
+		"Example:\n\t"
+		"%s -p /sys/devices/system/cpu/online\n\t"
+		"   Return all partial matches the path\n\t"
+		"   \"/sys/devices/system/cpu/online\".\n\n",
+		progname, progname);
+	exit(1);
+}
+
+struct selabel_lookup_rec {
+	char * ctx_raw;
+	char * ctx_trans;
+	pthread_mutex_t lock;	/* lock for validation and translation */
+	unsigned int lineno;
+	bool validated;
+};
+
+struct lookup_result {
+	const char *regex_str;
+	struct selabel_lookup_rec *lr;
+	uint16_t prefix_len;
+	uint8_t file_kind;
+	bool has_meta_chars;
+	struct lookup_result *next;
+};
+
+static void free_lookup_result(struct lookup_result *result)
+{
+	struct lookup_result *tmp;
+
+	while (result) {
+		tmp = result->next;
+		free(result);
+		result = tmp;
+	}
+}
+
+#define LABEL_FILE_KIND_INVALID		255
+#define LABEL_FILE_KIND_ALL		0
+#define LABEL_FILE_KIND_DIR		1
+#define LABEL_FILE_KIND_CHR		2
+#define LABEL_FILE_KIND_BLK		3
+#define LABEL_FILE_KIND_SOCK		4
+#define LABEL_FILE_KIND_FIFO		5
+#define LABEL_FILE_KIND_LNK		6
+#define LABEL_FILE_KIND_REG		7
+
+static inline const char* file_kind_to_string(uint8_t file_kind)
+{
+	switch (file_kind) {
+		case LABEL_FILE_KIND_BLK:
+			return "-b";
+		case LABEL_FILE_KIND_CHR:
+			return "-c";
+		case LABEL_FILE_KIND_DIR:
+			return "-d";
+		case LABEL_FILE_KIND_FIFO:
+			return "-p";
+		case LABEL_FILE_KIND_LNK:
+			return "-l";
+		case LABEL_FILE_KIND_SOCK:
+			return "-s";
+		case LABEL_FILE_KIND_REG:
+			return "--";
+		case LABEL_FILE_KIND_ALL:
+			return "  ";
+		default:
+			return "!!";
+	}
+}
+
+int main(int argc, char **argv)
+{
+	int opt;
+	struct lookup_result *all_matches;
+	size_t count;
+	const char *validate = NULL, *path = NULL, *file = NULL;
+
+	struct selabel_handle *hnd;
+	struct selinux_opt selabel_option[] = {
+		{ SELABEL_OPT_PATH, file },
+		{ SELABEL_OPT_VALIDATE, validate }
+	};
+
+	if (argc < 2)
+		usage(argv[0]);
+
+	while ((opt = getopt(argc, argv, "f:vp:")) > 0) {
+		switch (opt) {
+		case 'f':
+			file = optarg;
+			break;
+		case 'v':
+			validate = (char *)1;
+			break;
+		case 'p':
+			path = optarg;
+			break;
+		default:
+			usage(argv[0]);
+		}
+	}
+
+	if (!path || optind != argc)
+		usage(argv[0]);
+
+	selabel_option[0].value = file;
+	selabel_option[1].value = validate;
+
+	hnd = selabel_open(SELABEL_CTX_FILE, selabel_option, 2);
+	if (!hnd) {
+		fprintf(stderr, "ERROR: selabel_open - Could not obtain "
+							     "handle:  %s\n",
+							     strerror(errno));
+		return -1;
+	}
+
+	all_matches = selabel_partial_match_all(hnd, path);
+	if (!all_matches) {
+		printf("No partial match\n");
+		selabel_close(hnd);
+		return 0;
+	}
+
+	count = 0;
+	for (const struct lookup_result *res = all_matches; res; res = res->next) {
+		count++;
+		printf("  %s  %s%-50s\t--     %s\n",
+		       file_kind_to_string(res->file_kind),
+		       res->has_meta_chars ? "(r) " : "",
+		       res->regex_str,
+		       res->lr->ctx_raw);
+	}
+
+	printf("Found %zu partial matches\n", count);
+	free_lookup_result(all_matches);
+	selabel_close(hnd);
+	return 1;
+}
-- 
2.53.0

