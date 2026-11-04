Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804981;
	b=qZm9xA2IeRP6iplUHkd5C6tmOu2Blb3hRqYRwfLACPKSnrWJiNhWcJLfJ2oIs9SQl3E1
	 2VWe3KsyWjFFlVzEBBgpKZWn/Flg68HAU/CvwqNY3pinfqKY6GQVzc6audtjfceH6fTu5
	 caQ3gHkxX4CPcOVl9ae3mKK20jZ28DGeL4wIZZ+XmmKKquhT3uCwIehbH/XM/WsUAW/23
	 368X0nRCrNfDJjXirVoPaoGFZyWya5Kgyfm1AEBaRnNOKOzfL5IxXyqK5bbshU2R6SPLJ
	 1AQoTXLHe0Kc5OAUoFAwhOiAUVWqsNKqqh7wnmhD8HSBMT2Q/VvNNoINB0QIuFO+UsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804981;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FpdyuwjJ2/VBrjIvqOY7irRxId9nE9h5ztRMV1O0CT4=;
	b=Vqn8mgbzzc7c6zMauA4JKNgM7iI4ShAXO5abDcXu4wb81C0kJQwP84u5hCHvSGxYWh7p
	 sbUKtCjPSgfPHmJcKB7vnM6RFc1EUWc2IryZs2nG/fDJ29Zi7gZBN6P0wjyl8Eus2Q83B
	 XiiY5qine1JwmTPyBmBSYkquy4tzgGDRowj9ks6da7SKa28W8toYcbiPdHI+KwrxtecbV
	 Uuz2FhTT8kOwU5Ho16/pWCzdCUQdfQtEn94gdVo0eGlUlXEbdfhtENv6UcrvP/THCuRvQ
	 RA9mSxbD7DRiIY+Ad/xiLGYUqNxHopSx5XkxZhcRbkMKBneUgThzSHRyHDABUwoa0gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DvgvJFjN;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE11E606A32C
	for <selinux@vger.kernel.org>; Wed,  4 Nov 2026 15:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE11E606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DvgvJFjN
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-533797e72e8so4723571cf.2
        for <selinux@vger.kernel.org>; Wed, 04 Nov 2026 07:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793804980; x=1794409780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FpdyuwjJ2/VBrjIvqOY7irRxId9nE9h5ztRMV1O0CT4=;
        b=DvgvJFjNCu4spqzIMsJGYUziMoaP2M68woGWjfeY5MpzbuCDM7EoscYjGO3OxkD8xf
         ai6y1Vnx5lRD42uS+8qLQFa6hzoZK1UPhaq+xeKq2fn76FGxsTYDga7AJ7q2n5pB2QQf
         +Cu+8BAcMAmr6NAZ5JqMORGkyVFoGAajz28yLMnz+xTvgirCBc2Esh24ayq0K+j4Xq3K
         VKiVUKOYF60l4Avrz0vsfaseJ2OtxkMfG0IkKDMEiZzyvB3In/4ZlrdM/pnnrltJO0rm
         NvbjAJjsuD5u9Zdu6K0AiZ6OLir/BulrBMEtG8JhSurGBs4rpmTVpiPUtyCCPaoQBhFA
         HKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804980; x=1794409780;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FpdyuwjJ2/VBrjIvqOY7irRxId9nE9h5ztRMV1O0CT4=;
        b=gfjpTahlJI0BAo7YXuNfmlusq6kksi4vvgLVwCUOFvhaAim8w8zWgbC9FdZgDC4u4o
         rakKEUknCYNakimr6q7x+0q2FSL78le0I5nnkhy0F5oAtcHzAVVXYTkRuBqhCYzaGOhe
         Wgo7Ksf52owe3/HcNALMcpBf6eEgxH8iEUDjYb2HVJr9ewlJgmfwXGEJhOh4DEhqYwes
         Y9URCGoCAtLHrZw6ebj0nd3fVNNNc+lRvDqf1yNtgIJaf66Tp6wkLvWNRU211RT9V9o3
         zqLSrIqg4BF1rJ2sY0w0ss3Ecq39x8HWbnLZOFlZ8xpBfo2PNtloPiGfLVmOVljFvHdg
         kBtA==
X-Gm-Message-State: APuU4Z/lYESTIfgVR8BZjubFSe2s8LxB1t8ZeYuZ07WRbnu5UHaA4ogJ
	MHqc3gIdqMi63HIG19pzB1XgsE7zeHrW7bd2/9ctEVCaOFaXRCaJPUT3+IwZRsU8
X-Gm-Gg: AYBFou0C4Q5Qo8iXJaLhlrOk4nyWgMKlREVlKpGoBkPHwXthiinqVTFdj70cQGWRzqm
	tIcBRE+6eP+Zu4JfRvHWw0ItemmYIqWkhwcq49FUOaTTAeFbrD0obZZ3ubR+INdwNtQ9tI9rzta
	tzj6pNW0DEagacUQc6FkR/95VYJBM8jigH36JQJfYfoV382VMnLHOgsB1fUPvp+oHjTc6pgS2jn
	XSOCPAfyT9Qr9nAz6E58qQKqIYNbgyKjIpB3FGLKFNnzYX+qITUL1kZpF0joPVWuyJYfd7u/Fau
	pssOZ3edAYcFQBJAJth1rI8Rv1g3frh3ApDTFMHm9L7SycuZYaAKrTcrZ5W7O1t2dWqKyF25QkA
	4g+Dfef5Y8EYm1poF761GkqeXIA1j24xT0TyGPD/k7PZBYV/vA6TYY4UdueuN3XudrM14RApiJI
	a9PSPXs66/fIpQGvUeK6X6gKXN7sWm8sISKvgkjdZfaCA5+FxuXWiXeTJLCK45um3lvz9aP/WoG
	pH6i51Z4xHCkpK7vIsNvV6dRxkrVfdRJqch3BYkdOFQfoo9+Q+hBGJTdryWDYc4hWEm6TevbS9f
	JiSzGZeb57hw21yB/ienKf7TgwBnqlyC3phEoOF5FX0KOUVBtGvCNxCIecdAb4lPsi0S4fQlSpi
	dJQ5eAqdmEjsTcYpqdn8XnhxyXx9CRms3cjbntSEoBQMFyTrRwev9x39QlEIS6RJV6/HUTXInjt
	IC+Wl43sOguJ1v6+0dqjh4Kb5TLIx5CD85mTFms3VQPQIz5DOXrZQKg4Rwlq5wzMQs8uyWPS2a
X-Received: by 2002:ac8:5d8c:0:b0:536:64d5:553e with SMTP id d75a77b69052e-542b397df4fmr263647161cf.3.1793804979892;
        Wed, 04 Nov 2026 07:09:39 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10cdc3d3sm25683041cf.28.2026.11.04.07.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:09:39 -0800 (PST)
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
Subject: [PATCH v3 07/20] libselinux: clear consumed source children during context merge
Date: Wed,  4 Nov 2026 10:09:02 -0500
Message-ID: <20261104150915.175923-7-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104150915.175923-1-stephen.smalley.work@gmail.com>
References: <20261104150915.175923-1-stephen.smalley.work@gmail.com>
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

