Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388012;
	b=ZkaNomI3d2mDbBuzVnPL8Znl28nX7tNJnAiQ/h7hTk1z+gNSofGLLoengEzyKWGEQAhL
	 caZCnjj0j6ciIV4dZRby9mkscSPbQyB/OmcJgDO9jIUOveouRIHwutQsg/mqWnr6FKfl0
	 6bNKGyZhZCKD2kAOxPal/vbqYPRyDdWewA14dQliDb+vpXxxrl6ufSwWEfjxJPn0FkrnS
	 w9JwyEr3ZqekAXPZe6jqzKsMru8mbPeyNL1K0cZDBWVmvQRPAuXVqeUhIZ7At9A7eI7jT
	 6LtjNtQ/dy2ViXgmQ3AClBdRs9FuzM2qQiyIa2pdHceSZRY+ccWlCBA7JwzzLYYGNug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FpdyuwjJ2/VBrjIvqOY7irRxId9nE9h5ztRMV1O0CT4=;
	b=ltV37df07IMFzhVau8u4spjeDCNjMvHWHCCV5GlpJki92C1mg0HYiQ4UEw7X1QKMFzBM
	 xoNKphlOGnzO4spworkiunC7YquCQdL3uJ1MWDrAABdadvp0J94iAd1H5UOBdhFun6u2T
	 WBW8u3SRLIJt3bgzg8Ez3IqMUIeeMgiW9k3PmADbOt2uH1pywISXmmRWQvww+JJiG6b/i
	 7C53GMNQh9zqKB24L3W8BaOfdRR6bQxkSBQh9E+TFf72j4cDY8yZJP1ukJLBi4aaCspID
	 XeV95VV9nJwtz281cnGeRmFIO94qrUNx2VFZ58mi34RDi4TVUim5tku7R4blOZC0gVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="uJbU2/hz";
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842E3606A31D
	for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 19:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 842E3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uJbU2/hz
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91c75267b0fso11125786d6.3
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 12:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793388011; x=1793992811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FpdyuwjJ2/VBrjIvqOY7irRxId9nE9h5ztRMV1O0CT4=;
        b=uJbU2/hznDlgbi0TYieGRaAahWBXTL7WG3c+BcwGL9BArDdk5mA0tvr0AUYloVmUil
         qCK8EL0JtcRoqW21ZgeJXnmVNv//OCvzZoFY42hVCh6+oBzhMAYl3IKGengZdgrMQwll
         mhlQauf/yfsRFG2HED+mkMAW+1fDcG7DHJ8irI3i961DGWA8PiD7Fx2nszI+F2HpdPJO
         Yr5f+aapzNL/XwUsrc1fv4CeGzib0ye002HZuPjxMwk0uNPGh9ermVZFs6SzzRqUNmhZ
         I37kTGBmUm6Fq/atZRm5syAhQggG/ZSpvtwB+qK9QeL5q/F7EhbrvtAD07C/L/s/esM/
         FkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793388011; x=1793992811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FpdyuwjJ2/VBrjIvqOY7irRxId9nE9h5ztRMV1O0CT4=;
        b=laBQhUHAwU2vFMfU/mg89QtHBP+XapMNs28iW4npNgGWumb5EdQTvplTwOeLTzkexQ
         x85h6N2WMfPRIFLtL7GUyUCIt0j2J9YUrH0wWmrWTUXpeGWL3z40SnaYWnjraF6Ol5ma
         GA93niq9cfqSyfKt4ZlmnFUGFvCfgxA8liX3pIetQ+WotfILuFn6BiMSjhaMscUf2QwW
         6BpSztyamLSo95vonjI8iu1Lq4CgJEgXBRZibDKkcgRNH6fYQ5MjkPnGYrEc2ZR5q1m+
         qCtQM7+1qSZXBc39UtdhFw3FQBeGSPk2qN0a8ZXOL1ORQIbvM46LjhYbxsIMaUfWWNh9
         Qiyw==
X-Gm-Message-State: AFq9FYKNuFWVDi2KElndNkM2l7MS60v9wmy7hSzB+N3O+qHsEZANpbO8
	Cnkp+sNua9yLHDRAPAtFG54iP+JJuNDIcEfkjMl08kKfVT0EWn/RkieAcRIwfoEr
X-Gm-Gg: AYBFou1LaPL4DO/CXubHRLMQF66DtU9lao744F5uJcyG9+BJy3MvsxQqQFg1ETlzGYN
	lesHZjI4Ey8ofROKoN2yKzXNbPYAotBa5mqphbSvBYok/8YfPrQQLuuUrM4FUa5BQ6lj6mVs7a7
	JwNwv2gKsuj6oQEDaTsM81jMh+KWxjVqHkhew3kC1IFU2vOigBRroxmjd4Z3UAafN0HMs1ihdOH
	U/yQ67tguHWwxADkYtWNhopunkM8yHIX6/BfOWLE2ZmoqbAekKZG0nPjPUkpHVVn7Lo36ZwxZkJ
	abg4lZG/z0/3MKrx9lNZhPFDNCSuiMpAPSzn2kPW2/IZ+f7+dj4kEsLUymDAvAqprKtv+HVdTdp
	xNJ2qPMkPTug6jJFIQhtRdX5sBPwozN9h9dyQe/8ZbhBqXutuIDPtzgNm8AmoGJDgy8wdVAG14S
	EtMDPw7UpsyPwjL2uLlV5DrlRd+jpVwu09rJ6PaJw5UhnJUKOMGQ+oQXMVKlEHDMmBZdC7tDkkJ
	ueF1VR/1ozPpNQqnk01fJ7pOMHISyXQ5pmR31Tmi5FWPsvnyWyeE0xNChiVr5RejOcklAiovlMj
	QB5P+pE+tmYHOpxHhQKahQqLooIMRXkZKNkMqveQToLGFsurokOlUGOH7zncp8FZKIV3XvgA2Dw
	ySETg1AZidb0hbUXrg+/P28mD+JpSBFjhyy23tFmYbT12uz9riWwAssDYoVIbM+fJWe0nVpIT55
	XiDIwlmPXwOKa0HmgLItQyQXLAyLXnfvtnJ2pI9lz3itq+LJe3EBf4
X-Received: by 2002:a05:6214:448e:b0:91c:8f2d:4025 with SMTP id 6a1803df08f44-91ca4ae89c9mr48872156d6.17.1793388011302;
        Fri, 30 Oct 2026 12:20:11 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca805be18sm22501076d6.31.2026.10.30.12.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:20:10 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 07/10] libselinux: clear consumed source children during context merge
Date: Fri, 30 Oct 2026 15:19:21 -0400
Message-ID: <20261030191924.150495-7-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030191924.150495-1-stephen.smalley.work@gmail.com>
References: <20261030191924.150495-1-stephen.smalley.work@gmail.com>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After merging a shared child, merge_mmap_spec_nodes frees the source
child contents but leaves its pointers and counts in the source array.
If merging a later sibling fails, load_mmap error cleanup visits that
child again, accessing and freeing already freed memory.

Clear each consumed source child after freeing its contents. Leave
source-only children and destination ownership unchanged.

Add 32 regression cases using compiler-generated local context files,
covering literal and regex rules, nested nodes, text fallback, transient
and persistent merge allocation failures, and a subsequent fresh open.

Fixes: 92306daf5219 ("libselinux: rework selabel_file(5) database")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/label_file.c         |   3 +
 libselinux/tests/.gitignore         |   1 +
 libselinux/tests/Makefile           |   7 +-
 libselinux/tests/test_label_merge.c | 143 ++++++++++++++++++++++++++++
 4 files changed, 152 insertions(+), 2 deletions(-)
 create mode 100644 libselinux/tests/test_label_merge.c

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index de4600dd..991cff7d 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -384,6 +384,9 @@ static int merge_mmap_spec_nodes(struct spec_node *restrict dest,
 					new_children[new_children_num++] =
 						*child_dest;
 					free_spec_node(child_source);
+					/* A later sibling failure may revisit this node. */
+					memset(child_source, 0,
+					       sizeof(*child_source));
 					iter_dest++;
 					iter_source++;
 				} else if (r < 0) {
diff --git a/libselinux/tests/.gitignore b/libselinux/tests/.gitignore
index a4695e6f..cf084570 100644
--- a/libselinux/tests/.gitignore
+++ b/libselinux/tests/.gitignore
@@ -4,3 +4,4 @@ test-restorecon-digest
 /test-restorecon-exclude
 /test-restorecon-xdev
 /test-label-init-oom
+/test-label-merge
diff --git a/libselinux/tests/Makefile b/libselinux/tests/Makefile
index babadfe8..032018a8 100644
--- a/libselinux/tests/Makefile
+++ b/libselinux/tests/Makefile
@@ -20,16 +20,17 @@ test-restorecon-errno: test_restorecon_errno.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(ERRNO_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
 
 .PHONY: test clean
-test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom
+test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge
 	./test-restorecon-digest
 	./test-restorecon-errors
 	./test-restorecon-errno
 	./test-restorecon-exclude
 	./test-restorecon-xdev
 	./test-label-init-oom
+	./test-label-merge ../utils/sefcontext_compile
 
 clean:
-	rm -f test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom
+	rm -f test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge
 
 test-restorecon-exclude: test_restorecon_exclude.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(EXCLUDE_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
@@ -37,3 +38,5 @@ test-restorecon-xdev: test_restorecon_xdev.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(XDEV_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
 test-label-init-oom: test_label_init_oom.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(INIT_OOM_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
+test-label-merge: test_label_merge.c ../src/libselinux.a
+	$(CC) $(CFLAGS) -I../src -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=8 $(LDFLAGS) -o $@ $^ -Wl,--wrap=reallocarray $(PCRE_LDLIBS) -ldl -pthread
diff --git a/libselinux/tests/test_label_merge.c b/libselinux/tests/test_label_merge.c
new file mode 100644
index 00000000..0f67fbbf
--- /dev/null
+++ b/libselinux/tests/test_label_merge.c
@@ -0,0 +1,143 @@
+/* SPDX-License-Identifier: CC0-1.0 */
+#define _GNU_SOURCE
+#undef NDEBUG
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <selinux/label.h>
+#include "label_file.h"
+
+static unsigned int fail_at, merges, faults;
+static bool use_regex, persistent;
+
+void *__real_reallocarray(void *ptr, size_t n, size_t size);
+void *__wrap_reallocarray(void *ptr, size_t n, size_t size);
+void *__wrap_reallocarray(void *ptr, size_t n, size_t size)
+{
+	if (n == 2 && size == (use_regex ? sizeof(struct regex_spec) :
+					   sizeof(struct literal_spec))) {
+		merges++;
+		if (fail_at &&
+		    (merges == fail_at || (persistent && merges > fail_at))) {
+			faults++;
+			errno = ENOMEM;
+			return NULL;
+		}
+	}
+	return __real_reallocarray(ptr, n, size);
+}
+
+static void check_lookup(struct selabel_handle *handle, const char *prefix,
+			 const char *stem, const char *type)
+{
+	char path[128], expected[128];
+	char *context = NULL;
+	assert(snprintf(path, sizeof(path), "%s/%s/file", prefix, stem) > 0);
+	assert(snprintf(expected, sizeof(expected), "system_u:object_r:%s:s0",
+			type) > 0);
+	assert(selabel_lookup_raw(handle, &context, path, S_IFREG) == 0);
+	assert(!strcmp(context, expected));
+	free(context);
+}
+
+static void check_handle(struct selabel_handle *handle, const char *prefix)
+{
+	assert(handle);
+	check_lookup(handle, prefix, "a", "local_t");
+	check_lookup(handle, prefix, "b", "local_t");
+	check_lookup(handle, prefix, "aa", "base_t");
+	check_lookup(handle, prefix, "ab", "local_t");
+	selabel_close(handle);
+}
+
+static void run_case(const char *compiler, bool regex, bool nested,
+		     bool keep_text, unsigned int failure)
+{
+	char root[] = "/tmp/label-merge-XXXXXX";
+	char base[256], local[256], binary[256];
+	const char *prefix = nested ? "/outer/inner" : "";
+	const char *suffix = regex ? ".*" : "";
+	assert(mkdtemp(root));
+	assert(snprintf(base, sizeof(base), "%s/fc", root) > 0);
+	assert(snprintf(local, sizeof(local), "%s/fc.local", root) > 0);
+	assert(snprintf(binary, sizeof(binary), "%s/fc.local.bin", root) > 0);
+	FILE *fp = fopen(base, "w");
+	assert(fp);
+	assert(fprintf(fp,
+		       "%s/a/file%s system_u:object_r:base_t:s0\n"
+		       "%s/aa/file%s system_u:object_r:base_t:s0\n"
+		       "%s/b/file%s system_u:object_r:base_t:s0\n",
+		       prefix, suffix, prefix, suffix, prefix, suffix) > 0);
+	assert(fclose(fp) == 0);
+	fp = fopen(local, "w");
+	assert(fp);
+	assert(fprintf(fp,
+		       "%s/a/file%s system_u:object_r:local_t:s0\n"
+		       "%s/ab/file%s system_u:object_r:local_t:s0\n"
+		       "%s/b/file%s system_u:object_r:local_t:s0\n",
+		       prefix, suffix, prefix, suffix, prefix, suffix) > 0);
+	assert(fclose(fp) == 0);
+	pid_t pid = fork();
+	int status;
+	assert(pid >= 0);
+	if (!pid) {
+		execl(compiler, compiler, "-o", binary, local, (char *)NULL);
+		_exit(127);
+	}
+	assert(waitpid(pid, &status, 0) == pid);
+	assert(WIFEXITED(status) && WEXITSTATUS(status) == 0);
+	struct stat sb;
+	assert(stat(binary, &sb) == 0);
+	struct timespec times[] = { sb.st_atim, sb.st_mtim };
+	assert(utimensat(AT_FDCWD, local, times, 0) == 0);
+	if (!keep_text)
+		assert(unlink(local) == 0);
+	use_regex = regex;
+	persistent = failure == 3;
+	fail_at = persistent ? 2 : failure;
+	struct selinux_opt opt = { SELABEL_OPT_PATH, base };
+	struct selabel_handle *handle = selabel_open(SELABEL_CTX_FILE, &opt, 1);
+	assert(faults == (failure ? (persistent && !keep_text ? 2 : 1) : 0));
+	if (persistent && !keep_text)
+		assert(handle == NULL);
+	else
+		check_handle(handle, prefix);
+	fail_at = 0;
+	check_handle(selabel_open(SELABEL_CTX_FILE, &opt, 1), prefix);
+	if (keep_text)
+		assert(unlink(local) == 0);
+	assert(unlink(base) == 0 && unlink(binary) == 0 && rmdir(root) == 0);
+}
+
+int main(int argc, char **argv)
+{
+	assert(argc == 2);
+	unsigned int cases = 0;
+	for (int regex = 0; regex < 2; regex++)
+		for (int nested = 0; nested < 2; nested++)
+			for (int text = 0; text < 2; text++)
+				for (unsigned int failure = 0; failure < 4;
+				     failure++) {
+					pid_t pid = fork();
+					int status;
+					assert(pid >= 0);
+					if (!pid) {
+						alarm(20);
+						run_case(argv[1], regex, nested,
+							 text, failure);
+						_exit(0);
+					}
+					assert(waitpid(pid, &status, 0) == pid);
+					assert(WIFEXITED(status) &&
+					       WEXITSTATUS(status) == 0);
+					cases++;
+				}
+	printf("Label merge cleanup: %u cases passed.\n", cases);
+	return 0;
+}
-- 
2.56.0

