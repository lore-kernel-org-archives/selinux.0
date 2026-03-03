Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB70347C6
	for <selinux@vger.kernel.org>; Tue,  3 Mar 2026 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772540686; cv=none; b=UQMhUpUz9fM9/2hUlYuC57veMnH1DQI3MNXd1Rw3SRpTA0uaCHVckBCC2XO14qbgN2ti1T6zrEtqS9+LG1UlQ4JrpcHj/v1lyWSvso5JLZ5H4GKawvGkzNqPXE41dFg2HQ1mPq+3mFvQjfTrhejejBQqLFTzlksBi+G+Rn8Evcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772540686; c=relaxed/simple;
	bh=PuuUfJd4ExTI1JbLf8C5JJrcOeDMU3FX3bohChTY2yw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SvlfUQco8Pdg7semzZphbyvnWUYScEACq1NhRgHykUP3mTANAo1PJssKWQkqGSptWvr1dzXlctZkj6FW4tiyGZ3Wm+W0GybAI/wr25NruWlx8/JRKPjj6PcsGQXJ5yZ5ihMegwg04OCE7gC18hTgSgrLU7F5vQjliKAJ80U551I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JQkO4O20; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQkO4O20"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772540684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DGZC5kjUgrMXNi7H7O9ThIWdig9gl3ptG1k8IjUmG/8=;
	b=JQkO4O20wiSClaysLi2u5H+kVYhnnwUqHIKX2oDzYMjKUDCU1fZ4/2Z+nL09BuVyJlhfSi
	gT7l8Z0wgWDZcmFYkIhmcezBnMcXuca2N1YTBcki6kJ2wlieOg1PkdndAJVJ5GxnK5VJ2a
	WJuwIpjxU/tlsWzdYvgsUPzviDDVjCI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-JaH7FHXnMxyWe47uaiF2Sg-1; Tue,
 03 Mar 2026 07:24:42 -0500
X-MC-Unique: JaH7FHXnMxyWe47uaiF2Sg-1
X-Mimecast-MFC-AGG-ID: JaH7FHXnMxyWe47uaiF2Sg_1772540681
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEFD01956063
	for <selinux@vger.kernel.org>; Tue,  3 Mar 2026 12:24:41 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.45.226.22])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B1D761800348;
	Tue,  3 Mar 2026 12:24:40 +0000 (UTC)
From: Petr Lautrbach <lautrbach@redhat.com>
To: selinux@vger.kernel.org
Cc: Petr Lautrbach <lautrbach@redhat.com>
Subject: [PATCH] Add support for UTF-8 in file context labels
Date: Tue,  3 Mar 2026 13:23:30 +0100
Message-ID: <20260303122412.1596047-2-lautrbach@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

- libselinux to be able to read UTF-8 spec entries
- libselinux to compile regexes with UTF strings and unicode properties
- initialize locales in setfiles, sefcontext_compile, semodule
- semanage_exec_prog to execute external programs with LC_CTYPE set to
the current environment

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
 libselinux/src/label_support.c        | 15 +++++++++++----
 libselinux/src/regex.c                |  8 +++++---
 libselinux/utils/sefcontext_compile.c |  5 +++++
 libsemanage/src/semanage_store.c      | 10 +++++++++-
 policycoreutils/semodule/semodule.c   |  5 +++++
 policycoreutils/setfiles/setfiles.c   |  4 ++++
 6 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/libselinux/src/label_support.c b/libselinux/src/label_support.c
index 57e191c8eb77..2eed5b8cea51 100644
--- a/libselinux/src/label_support.c
+++ b/libselinux/src/label_support.c
@@ -11,6 +11,7 @@
 #include <string.h>
 #include <stdio.h>
 #include <errno.h>
+#include <wchar.h>
 #include "label_internal.h"
 
 /*
@@ -35,13 +36,19 @@ static inline int read_spec_entry(char **entry, const char **ptr, size_t *len, c
 	*len = 0;
 
 	while (!isspace((unsigned char)**ptr) && **ptr != '\0') {
-		if (!isascii((unsigned char)**ptr)) {
+		size_t char_len;
+
+		char_len = mbrtowc(NULL, *ptr, MB_CUR_MAX, NULL);
+
+		if ((char_len == (size_t) -1) || (char_len == (size_t) -2)) {
 			errno = EINVAL;
-			*errbuf = "Non-ASCII characters found";
+			*errbuf = "Invalid UTF-8 encoding";
 			return -1;
 		}
-		(*ptr)++;
-		(*len)++;
+
+		*ptr += char_len;
+		*len += char_len;
+
 	}
 
 	if (*len) {
diff --git a/libselinux/src/regex.c b/libselinux/src/regex.c
index 976f00d4806d..a6e3e899f397 100644
--- a/libselinux/src/regex.c
+++ b/libselinux/src/regex.c
@@ -85,9 +85,11 @@ int regex_prepare_data(struct regex_data **regex, char const *pattern_string,
 	if (!(*regex))
 		return -1;
 
-	(*regex)->regex = pcre2_compile(
-	    (PCRE2_SPTR)pattern_string, PCRE2_ZERO_TERMINATED, PCRE2_DOTALL,
-	    &errordata->error_code, &errordata->error_offset, NULL);
+	(*regex)->regex = pcre2_compile((PCRE2_SPTR)pattern_string,
+					PCRE2_ZERO_TERMINATED,
+					PCRE2_DOTALL | PCRE2_UTF | PCRE2_UCP,
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
-- 
2.53.0

