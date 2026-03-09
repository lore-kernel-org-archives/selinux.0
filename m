Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DA33BD640
	for <selinux@vger.kernel.org>; Mon,  9 Mar 2026 14:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773067309; cv=none; b=Fca7xPGlnQ8P8r3gJZhrGO2dnjWNeRW72FIkxphWe6g5HP4ni5XGVGatT48e9/jVFQqqAoGFRRJbjm7uZCTL0SYo7UMkAiqxRdraI9JqWimpr38VrBiJv7X2cEJNfarFdx0DTkOFrOiuDj0+sJS51XOjp/Pjw18m7RC1FuCPdFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773067309; c=relaxed/simple;
	bh=NcCunelTFKIGfD2aCCIEns+qC4K4RhJnNiB05uINDso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dov1X4+crjF5vxEYDpDnSMzlrTvmahGRVh37jFess8wZUasjc+wv/3hDhIS0FnR80xr3NWCgMl7rAsUc9gnOgkwsvdKPVX0OeqOUxYvcdU7bnqHttttzeY4QoA4TnVkRmjvPBL9k+2IzzNjX7jvUCad7PubPKGmCqS3tN3JEGM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RoPiOkwg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RoPiOkwg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773067306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O09GZlyt/VMPhmgxnXvph5omqQLI1rgRWLvvSNM4qKQ=;
	b=RoPiOkwgWV38pREUECUTXKWknOmBD870qfrldFo2+tHri4TqbjSPp59egVVOUCIo8BtG0D
	c+urL5sdeDr1m96Tuq9RES5kKHapMvewRKVku1qhFVfpT+u8KCJZgdUJnBqQxee8p64ZoL
	GClEs5jv4K2qxo2jHJ5mjcYAQSepxZo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-P-6dxs7QNhGQQ6fq1cViQQ-1; Mon,
 09 Mar 2026 10:41:44 -0400
X-MC-Unique: P-6dxs7QNhGQQ6fq1cViQQ-1
X-Mimecast-MFC-AGG-ID: P-6dxs7QNhGQQ6fq1cViQQ_1773067304
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ED6A218002E8
	for <selinux@vger.kernel.org>; Mon,  9 Mar 2026 14:41:43 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.225.108])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D68E3180058B;
	Mon,  9 Mar 2026 14:41:42 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH v2] Add support for UTF-8 in file context labels
Date: Mon,  9 Mar 2026 15:40:41 +0100
Message-ID: <20260309144132.3039335-1-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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
Patch v2 changes:
- add posibility to disable UTF-8 support during build time via DISABLE_UTF=y

 libselinux/Makefile                   |  4 ++++
 libselinux/src/label_support.c        | 16 ++++++++++++++++
 libselinux/src/regex.c                | 12 +++++++++---
 libselinux/utils/sefcontext_compile.c |  5 +++++
 libsemanage/src/semanage_store.c      | 10 +++++++++-
 policycoreutils/semodule/semodule.c   |  5 +++++
 policycoreutils/setfiles/setfiles.c   |  4 ++++
 python/semanage/semanage-fcontext.8   |  8 ++++----
 8 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/libselinux/Makefile b/libselinux/Makefile
index aeede2b56e8e..0f8412ccf1ea 100644
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
index 57e191c8eb77..67fd2020bcf2 100644
--- a/libselinux/src/label_support.c
+++ b/libselinux/src/label_support.c
@@ -11,6 +11,7 @@
 #include <string.h>
 #include <stdio.h>
 #include <errno.h>
+#include <wchar.h>
 #include "label_internal.h"
 
 /*
@@ -35,6 +36,7 @@ static inline int read_spec_entry(char **entry, const char **ptr, size_t *len, c
 	*len = 0;
 
 	while (!isspace((unsigned char)**ptr) && **ptr != '\0') {
+#ifdef NO_UTF
 		if (!isascii((unsigned char)**ptr)) {
 			errno = EINVAL;
 			*errbuf = "Non-ASCII characters found";
@@ -42,6 +44,20 @@ static inline int read_spec_entry(char **entry, const char **ptr, size_t *len, c
 		}
 		(*ptr)++;
 		(*len)++;
+#else
+		size_t char_len;
+
+		char_len = mbrtowc(NULL, *ptr, MB_CUR_MAX, NULL);
+
+		if ((char_len == (size_t) -1) || (char_len == (size_t) -2)) {
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
index 976f00d4806d..2ebeb7c137c7 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -85,9 +85,15 @@ int regex_prepare_data(struct regex_data **regex, char const *pattern_string,
 	if (!(*regex))
 		return -1;
 
-	(*regex)->regex = pcre2_compile(
-	    (PCRE2_SPTR)pattern_string, PCRE2_ZERO_TERMINATED, PCRE2_DOTALL,
-	    &errordata->error_code, &errordata->error_offset, NULL);
+	(*regex)->regex = pcre2_compile((PCRE2_SPTR)pattern_string,
+					PCRE2_ZERO_TERMINATED,
+#ifdef NO_UTF
+					PCRE2_DOTALL,
+#else
+					PCRE2_DOTALL | PCRE2_UTF,
+#endif
+					&errordata->error_code,
+					&errordata->error_offset, NULL);
 	if (!(*regex)->regex) {
 		goto err;
 	}
diff --git a/libselinux/utils/sefcontext_compile.c b/libselinux/utils/sefcontext_compile.c
index 811b2a1a6a98..fb848ff112ca 100644
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
@@ -551,6 +552,10 @@ int main(int argc, char *argv[])
 	struct spec_node *root = NULL;
 	struct sidtab stab = {};
 
+	/* Initialize locale for UTF-8 support */
+	setlocale(LC_ALL, "");
+
+
 	if (argc < 2)
 		usage(argv[0]);
 
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index e3048c08df0e..21ee6dfb78b0 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -57,6 +57,7 @@ typedef struct dbase_policydb dbase_t;
 #include <sys/wait.h>
 #include <limits.h>
 #include <libgen.h>
+#include <locale.h>
 
 #include "debug.h"
 #include "utilities.h"
@@ -1479,6 +1480,11 @@ static int semanage_exec_prog(semanage_handle_t * sh,
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
@@ -1492,11 +1498,13 @@ static int semanage_exec_prog(semanage_handle_t * sh,
 	if (forkval == 0) {
 		/* child process.  file descriptors will be closed
 		 * because they were set as close-on-exec. */
-		execve(e->path, argv, NULL);
+		execve(e->path, argv, envp);
 		_exit(EXIT_FAILURE);	/* if execve() failed */
 	}
 
 	free_argv(argv);
+	if (envp[0])
+		free(envp[0]);
 
 	if (forkval == -1) {
 		ERR(sh, "Error while forking process.");
diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index ab5168ebdc00..aea22f6e94e8 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -21,6 +21,7 @@
 #include <sys/types.h>
 #include <libgen.h>
 #include <limits.h>
+#include <locale.h>
 
 #include <sepol/cil/cil.h>
 #include <semanage/modules.h>
@@ -418,6 +419,10 @@ int main(int argc, char *argv[])
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
index 351940f33a9b..7824cffe460e 100644
--- a/policycoreutils/setfiles/setfiles.c
+++ b/policycoreutils/setfiles/setfiles.c
@@ -7,6 +7,7 @@
 #include <regex.h>
 #include <sys/vfs.h>
 #include <libgen.h>
+#include <locale.h>
 #ifdef USE_AUDIT
 #include <libaudit.h>
 
@@ -153,6 +154,9 @@ int main(int argc, char **argv)
 	long unsigned skipped_errors;
 	long unsigned relabeled_files;
 
+	/* Initialize locale for UTF-8 support */
+	setlocale(LC_ALL, "");
+
 	/* Initialize variables */
 	memset(&r_opts, 0, sizeof(r_opts));
 	altpath = NULL;
diff --git a/python/semanage/semanage-fcontext.8 b/python/semanage/semanage-fcontext.8
index a29b74994763..f590ea30fe9e 100644
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
2.53.0

