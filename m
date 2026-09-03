Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409384CA77A
	for <selinux@vger.kernel.org>; Thu,  3 Sep 2026 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448514; cv=none; b=ou1Fqtcp1fjOIfFGTT/juBhOPkaIurnPt26adu+HlPwk8Q1e3OHAAGhmTPQGvIJauk11TRrfP8wGFlAyNBcmzXAsKLhu1A3eoQNXUAirtrmUEKWYHzmI1LzlTSHb1YDvvyCovycvebrGXC+PwYYiQWKMh+RqWAEK9zkkji1QDmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448514; c=relaxed/simple;
	bh=ojKHgSmuNCxVw7ozRny9mfgShGXjugjSRVN2wzX6OWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hwgeTRFRK3zd2DxTvDqWEHHe1eYIMhVNd5zfwqR95CCLBv47jQVlK24FRSK4cFni5KNqgfrRHG6vq2d85pVk/SQLBH3F/wCNO8WacJJ+Ojnov5oklq/r0fnQ9So2V2yjfsIlGdqUkOrXSqs9ybAgUPxRTTTqDkJgkO7iu1YFHGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZL4iAikz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZL4iAikz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788448511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tTxLcxVqkYrNLRjdrBSScDRkG/JQ2Wt4Jo54SN4kctI=;
	b=ZL4iAikzeu48AiM3hdfFAtNw+lcbkknexXB6OQjVyTqH9mM7XqDh2NRt6ura9DhYbmj3wr
	1S7dvNLY7YLtFip/9MH6UFnDHXyH2e2Ei73P5eE3ikK8Wygvlt+PNuYXQwndWAOlucPR8o
	2Bh0rXc1yqnAVNHXztMpR5L//nfHrG8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-VvqXsMNBP2WkOEv3GGf9Lw-1; Thu,
 03 Sep 2026 11:15:09 -0400
X-MC-Unique: VvqXsMNBP2WkOEv3GGf9Lw-1
X-Mimecast-MFC-AGG-ID: VvqXsMNBP2WkOEv3GGf9Lw_1788448509
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D73B8195F17C;
	Thu,  3 Sep 2026 15:15:08 +0000 (UTC)
Received: from p16v.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 666D01955F72;
	Thu,  3 Sep 2026 15:15:07 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	=?UTF-8?q?Ondrej=20Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
Subject: [PATCH v3] Add support for UTF-8 in file context labels
Date: Thu,  3 Sep 2026 17:12:17 +0200
Message-ID: <20260903151347.1513631-2-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

- libselinux to be able to read UTF-8 spec entries
- libselinux to compile regexes with UTF strings
- initialize locales in setfiles, sefcontext_compile, semodule
- semanage_exec_prog to execute external programs with LC_CTYPE set to
the current environment
- disable UTF-8 support build time using DISABLE_UTF=y environment
variable

Fixes:
    # cat unicode.cil
    (filecon "/opt/žluťoučký(/.*)?" any (system_u object_r user_home_t ((s0) (s0))))

    # semodule -i unicode.cil
    /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file_contexts:  line 2145 error due to: Non-ASCII characters found
    /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file_contexts:  line 2145 error due to: Non-ASCII characters found
    /var/lib/selinux/final/targeted/contexts/files/file_contexts: Invalid argument
    libsemanage.semanage_validate_and_compile_fcontexts: setfiles returned error code 1.
    semodule:  Failed!

    # semanage fcontext --add -t user_home_t "/opt/žluťoučký(/.*)?"
    /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file_contexts.local:  line 4 error due to: Non-ASCII characters found
    /sbin/setfiles: /var/lib/selinux/final/targeted/contexts/files/file_contexts.local:  line 4 error due to: Non-ASCII characters found
    /var/lib/selinux/final/targeted/contexts/files/file_contexts: Invalid argument
    libsemanage.semanage_validate_and_compile_fcontexts: setfiles returned error code 1.
    OSError: Error

Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>
---

- dropped mbrtowc() and implemented utf8_char_len() based on rfc3629

 libselinux/Makefile                   |  4 ++
 libselinux/src/label_support.c        | 86 +++++++++++++++++++++++++++
 libselinux/src/regex.c                |  7 ++-
 libselinux/utils/sefcontext_compile.c |  5 ++
 libsemanage/src/semanage_store.c      | 12 +++-
 policycoreutils/semodule/semodule.c   |  5 ++
 policycoreutils/setfiles/setfiles.c   |  4 ++
 python/semanage/semanage-fcontext.8   |  8 +--
 8 files changed, 124 insertions(+), 7 deletions(-)

diff --git a/libselinux/Makefile b/libselinux/Makefile
index 48c0206a0a4b..aa8d053e359f 100644
--- a/libselinux/Makefile
+++ b/libselinux/Makefile
@@ -3,6 +3,7 @@ SUBDIRS = include src utils man
 PKG_CONFIG ?= pkg-config
 DISABLE_SETRANS ?= n
 DISABLE_RPM ?= n
+DISABLE_UTF ?= n
 ANDROID_HOST ?= n
 LABEL_BACKEND_ANDROID ?= n
 ifeq ($(ANDROID_HOST),y)
@@ -21,6 +22,9 @@ endif
 ifeq ($(DISABLE_X11),y)
 	DISABLE_FLAGS+= -DNO_X_BACKEND
 endif
+ifeq ($(DISABLE_UTF),y)
+	DISABLE_FLAGS+= -DNO_UTF
+endif
 export DISABLE_SETRANS DISABLE_RPM DISABLE_FLAGS ANDROID_HOST DISABLE_X11 LABEL_BACKEND_ANDROID
 
 USE_PCRE2 ?= y
diff --git a/libselinux/src/label_support.c b/libselinux/src/label_support.c
index cc5c279e88fa..e3c916c225e8 100644
--- a/libselinux/src/label_support.c
+++ b/libselinux/src/label_support.c
@@ -13,6 +13,79 @@
 #include <errno.h>
 #include "label_internal.h"
 
+#ifndef NO_UTF
+
+#define UTF8tail(x) (x >= 0x80 && x <= 0xBF)
+
+static size_t utf8_char_len(const unsigned char *s)
+{
+/* rfc3629
+ *  UTF8-octets = *( UTF8-char )
+ *  UTF8-char   = UTF8-1 / UTF8-2 / UTF8-3 / UTF8-4
+ *  UTF8-1      = %x00-7F
+ *  UTF8-2      = %xC2-DF UTF8-tail
+ *  UTF8-3      = %xE0 %xA0-BF UTF8-tail / %xE1-EC 2( UTF8-tail ) /
+ *                %xED %x80-9F UTF8-tail / %xEE-EF 2( UTF8-tail )
+ *  UTF8-4      = %xF0 %x90-BF 2( UTF8-tail ) / %xF1-F3 3( UTF8-tail ) /
+ *                %xF4 %x80-8F 2( UTF8-tail )
+ *  UTF8-tail   = %x80-BF
+ */
+	if (s[0] == '\0')
+		return 0;
+
+	if (s[0] < 0x80)
+		return 1;
+
+	if (s[0] < 0xC2 || s[1] == '\0')
+		return 0;
+
+	if (s[0] <= 0xDF && UTF8tail(s[1]))
+		return 2;
+
+	if (s[2] == '\0')
+		return 0;
+
+	/* %xE0 %xA0-BF UTF8-tail */
+	if (s[0] == 0xE0 &&
+	    s[1] >= 0xA0 && s[1] <= 0xBF &&
+	    UTF8tail(s[2])
+	)
+		return 3;
+
+	/* %xE1-EC 2( UTF8-tail ) */
+	if (s[0] >= 0xE1 && s[0] <= 0xEC && UTF8tail(s[1]) && UTF8tail(s[2]))
+		return 3;
+
+	/* %xED %x80-9F UTF8-tail */
+	if (s[0] == 0xED && s[1] >= 0x80 && s[1] <= 0x9F && UTF8tail(s[2]))
+		return 3;
+
+	/* %xEE-EF 2( UTF8-tail ) */
+	if (s[0] >= 0xEE && s[0] <= 0xEF && UTF8tail(s[1]) && UTF8tail(s[2]))
+		return 3;
+
+	if (s[3] == '\0')
+		return 0;
+
+	/* %xF0 %x90-BF 2( UTF8-tail ) */
+	if (s[0] == 0xF0 && s[1] >= 0x90 && s[1] <= 0xBF &&
+	    UTF8tail(s[2]) && UTF8tail(s[3]))
+		return 4;
+
+	/* %xF1-F3 3( UTF8-tail ) */
+	if (s[0] >= 0xF1 && s[0] <= 0xF3 && UTF8tail(s[1]) && UTF8tail(s[2]) &&
+	    UTF8tail(s[3]))
+		return 4;
+
+	/* %xF4 %x80-8F 2( UTF8-tail ) */
+	if (s[0] == 0xF4 && s[1] >= 0x80 && s[1] <= 0x8F &&
+	    UTF8tail(s[2]) && UTF8tail(s[3]))
+		return 4;
+
+	return 0;
+}
+#endif
+
 /*
  * Read an entry from a spec file (e.g. file_contexts)
  * entry - Buffer to allocate for the entry.
@@ -36,6 +109,7 @@ static inline int read_spec_entry(char **entry, const char **ptr, size_t *len,
 	*len = 0;
 
 	while (!isspace((unsigned char)**ptr) && **ptr != '\0') {
+#ifdef NO_UTF
 		if (!isascii((unsigned char)**ptr)) {
 			errno = EINVAL;
 			*errbuf = "Non-ASCII characters found";
@@ -43,6 +117,18 @@ static inline int read_spec_entry(char **entry, const char **ptr, size_t *len,
 		}
 		(*ptr)++;
 		(*len)++;
+#else
+		size_t char_len = utf8_char_len((const unsigned char *)*ptr);
+
+		if (char_len == 0) {
+			errno = EINVAL;
+			*errbuf = "Invalid UTF-8 encoding";
+			return -1;
+		}
+
+		*ptr += char_len;
+		*len += char_len;
+#endif
 	}
 
 	if (*len) {
diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index d6b5bf0252ba..f632a87275d4 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -96,7 +96,12 @@ int regex_prepare_data(struct regex_data **regex, char const *pattern_string,
 		return -1;
 
 	(*regex)->regex = pcre2_compile((PCRE2_SPTR)pattern_string,
-					PCRE2_ZERO_TERMINATED, PCRE2_DOTALL,
+					PCRE2_ZERO_TERMINATED,
+#ifdef NO_UTF
+					PCRE2_DOTALL,
+#else
+					PCRE2_DOTALL | PCRE2_UTF,
+#endif
 					&errordata->error_code,
 					&errordata->error_offset, NULL);
 	if (!(*regex)->regex) {
diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index e504b5084c8d..04c86053b2c8 100644
--- a/libselinux/utils/sefcontext_compile.c
+++ b/libselinux/utils/sefcontext_compile.c
@@ -1,6 +1,7 @@
 #include <endian.h>
 #include <errno.h>
 #include <getopt.h>
+#include <locale.h>
 #include <stdint.h>
 #include <stdio.h>
 #include <string.h>
@@ -564,6 +565,10 @@ int main(int argc, char *argv[])
 	struct spec_node *root = NULL;
 	struct sidtab stab = {};
 
+	/* Initialize locale for UTF-8 support */
+	setlocale(LC_ALL, "");
+
+
 	if (argc < 2)
 		usage(argv[0]);
 
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index f6ca1afbacd4..9e478bd039dd 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -58,6 +58,7 @@ typedef struct dbase_policydb dbase_t;
 #include <sys/wait.h>
 #include <limits.h>
 #include <libgen.h>
+#include <locale.h>
 
 #include "debug.h"
 #include "utilities.h"
@@ -1493,6 +1494,11 @@ static int semanage_exec_prog(semanage_handle_t *sh, external_prog_t *e,
 	char **argv;
 	pid_t forkval;
 	int status = 0;
+	char *envp[] = { NULL, NULL};
+
+	/* we expect that locales are already initialized */
+	if (asprintf(&envp[0], "LC_CTYPE=%s", setlocale(LC_CTYPE, NULL)) == -1)
+		envp[0] = NULL;
 
 	argv = split_args(e->path, e->args, new_name, old_name);
 	if (argv == NULL) {
@@ -1506,11 +1512,13 @@ static int semanage_exec_prog(semanage_handle_t *sh, external_prog_t *e,
 	if (forkval == 0) {
 		/* child process.  file descriptors will be closed
 		 * because they were set as close-on-exec. */
-		execve(e->path, argv, NULL);
-		_exit(EXIT_FAILURE); /* if execve() failed */
+		execve(e->path, argv, envp);
+		_exit(EXIT_FAILURE);	/* if execve() failed */
 	}
 
 	free_argv(argv);
+	if (envp[0])
+		free(envp[0]);
 
 	if (forkval == -1) {
 		ERR(sh, "Error while forking process.");
diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index 14e2f201f555..aac225c3c114 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -21,6 +21,7 @@
 #include <sys/types.h>
 #include <libgen.h>
 #include <limits.h>
+#include <locale.h>
 
 #include <sepol/cil/cil.h>
 #include <semanage/modules.h>
@@ -433,6 +434,10 @@ int main(int argc, char *argv[])
 	int i, commit = 0;
 	int result;
 	int status = EXIT_FAILURE;
+
+	/* Initialize locale for UTF-8 support */
+	setlocale(LC_ALL, "");
+
 	const char *genhomedirconargv[] = { "genhomedircon", "-B", "-n" };
 	create_signal_handlers();
 	if (strcmp(basename(argv[0]), "genhomedircon") == 0) {
diff --git a/policycoreutils/setfiles/setfiles.c b/policycoreutils/setfiles/setfiles.c
index 7f1c0a31b7d4..1b135c4e9a79 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -8,6 +8,7 @@
 #include <regex.h>
 #include <sys/vfs.h>
 #include <libgen.h>
+#include <locale.h>
 #ifdef USE_AUDIT
 #include <libaudit.h>
 
@@ -179,6 +180,9 @@ int main(int argc, char **argv)
 	long unsigned skipped_errors;
 	long unsigned relabeled_files;
 
+	/* Initialize locale for UTF-8 support */
+	setlocale(LC_ALL, "");
+
 	/* Initialize variables */
 	memset(&r_opts, 0, sizeof(r_opts));
 	altpath = NULL;
diff --git a/python/semanage/semanage-fcontext.8 b/python/semanage/semanage-fcontext.8
index b037491e3394..8e1238fb373c 100644
--- a/python/semanage/semanage-fcontext.8
+++ b/python/semanage/semanage-fcontext.8
@@ -15,10 +15,10 @@ This command maps file paths using regular expressions to SELinux labels.
 
 FILE_SPEC may contain either a fully qualified path,
 or a Perl compatible regular expression (PCRE),
-describing fully qualified path(s). The only PCRE flag in use is PCRE2_DOTALL,
-which causes a wildcard '.' to match anything, including a new line.
-Strings representing paths are processed as bytes (as opposed to Unicode),
-meaning that non-ASCII characters are not matched by a single wildcard.
+describing fully qualified path(s). PCRE flags in use are PCRE2_DOTALL and
+PCRE2_UTF. PCRE2_DOTALL causes a wildcard '.' to match anything, including
+a new line. PCRE2_UTF treats pattern and subjects as UTF strings and can be
+disabled build time via `DISABLE_UTF=y` environment variable.
 
 Note, that file context definitions specified using 'semanage fcontext'
 (i.e. local file context modifications stored in file_contexts.local)
-- 
2.55.0

