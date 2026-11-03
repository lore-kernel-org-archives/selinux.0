Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732011;
	b=YCizIMDj135df6KASsrS0pQSmxoliUu4NTfb1iADo2p7Ox1P6GvZlYdKf/lLsjJk3Pw3
	 mx1DoenH7SrBaObz0Tvp0CqtPiXaVAbCFMYP4IByJlz3eN5zLVRDDEze0EzaCWmYYw+Jx
	 YJ5hDIIpGcHv8z89wSloFG5fcYIP385jJ5IOhrpr5U3qlPVpOHJJULYeRqGQmXNR9L3V7
	 OlHSEbv9OW/lTw3XEJ5D2PezIy2kiGqanFqTrzrmiIu/SgUgQPX1qneWDQCwK/PZGm+QH
	 qvfk0khRsEB5SI0nOWFDPm7wIgPcJXTjJVlkBb36zsBmpPya2baPn4Z1QPPTOAoD36g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732011;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FpdyuwjJ2/VBrjIvqOY7irRxId9nE9h5ztRMV1O0CT4=;
	b=O3+vBJ8vkrbSKvKyLhzY4wpWVesFzQXm8Eo9+ZrrTmfv1NRPYH9j9YmNP/h9B3S9t4LY
	 DjQfJQpAXx1CBlXNdd0i32CRpc5rbndnWscl3X5F2oKmcfk/+lj9lZbD9IBNX/WehyJ9M
	 z1qVvtD03aNMjHsTdGtISOYXph+05k8qToXj+cKzqJn8NUvspFMuozEd3S+Z3+/8JDRF9
	 42tMFv68ynHMozJSIauKYEVThQT3vGFpVu8GhbwCT/p5ej3CY9uh95UsVKooHhbwXn1Fq
	 PVHzbUh0aDWM1a89poNBwihYcZ/uv75O9Ww8hk6uShdi3QIRqYrJ5qEenhW7qjg328w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VwggetHt;
	arc=none smtp.remote-ip=209.85.219.43
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68FF606A33D
	for <selinux@vger.kernel.org>; Tue,  3 Nov 2026 18:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B68FF606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VwggetHt
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-91791ec1b83so35112956d6.1
        for <selinux@vger.kernel.org>; Tue, 03 Nov 2026 10:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793732009; x=1794336809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FpdyuwjJ2/VBrjIvqOY7irRxId9nE9h5ztRMV1O0CT4=;
        b=VwggetHth0y7OrSa6MkW+vby1HNBV+CSOM7dx40TB8WD4gEG7Ia+mHl7pDIArYgNV4
         GHhBH2B/wWO2LxkR+3ll1NYb+sc4Sh0YbXikb+KAbuu+TAgpN1TPk/Y7Z5hgcs2xm9YJ
         XjjJA2cRgWN1llim/Y0pIlszL+jQ/2DAdOGR90sMLgZR7Z1MHGzxIwP8NZ+yHrDTnGrm
         cuF0xBZO2ut2ZxPVffUvGNpEJsTJCKnRTIUxIR9Tr05D41jjn6fiZWKCqOV/PQ39XBWW
         6B8cYzHzdza7THOVnlIXRvJhA1BTdEyT6TSG+YJJOonLuqhhTGrQbX2BGS66MMRTIv86
         qmJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732009; x=1794336809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FpdyuwjJ2/VBrjIvqOY7irRxId9nE9h5ztRMV1O0CT4=;
        b=ZsuBlHuoAX6eSamYOZFigkEl1IuQ/ivkSyZZxxlZzAueUCwUAlbCRh34PZfo0cZFKR
         o5H05EeEMQtqFSigCQY/SPWZea6M/OFekurSgPENh4QmQKvVAc2HDt4aevBHp4djRIPl
         uZ04c5ZbItvIla5Z9dmH3Nt5Va6IMyRFWzlIoRjYo3Sv3lv5pD4ZXDP7w/2qqekM4V4H
         yjJXSUBBupF3M6bZzztDzU645i/gq4U+fSjSTsm94kf8jnTk3XWi4170vCKILJJ9mVVG
         Y/BZoiIqJmvs2zAgILcespdvawf6ZmeUSPPrT2KGc5GoV3TvdH38QX19hsmyH7MX2SOe
         BCVA==
X-Gm-Message-State: APuU4Z+4Jp9I/WRiTR0DrTGdY/FPc0WkkVLDwtgdHhSMQpvPlEb7YeX9
	MgwFSwEJESKyTA5sS+TaHugL6GAVB0hgnfGHGQEyGBtGbnBro0LITUE9U5+GEM7Y
X-Gm-Gg: AYBFou0GI9na7UtN48FZufj3s6NiY5+3SGIEiLk4Y4cAKxgMzRfiHwBEVu9lXux461V
	FiYiK1heODpbkSU4UsUTxDXCZ5sQe386GhQV9rbwtpu4YQUnPZahWdrI8Jzn8FNcg/S/yX2gVCZ
	5u4eK9f0x9KiD6EIk04W0pnW9AyHMtWysfAo+YALM5KbXNCNUyUSY/sb4bWKapfRvpQhX/SmH5Q
	s1Tc+/qAyCOQOCU4nA5UcgvxGgZ/YlaOuszVHO5Cc03WHcwfiFKG2GS3umLOdS40rQ12hTxYJ9p
	nmXignWHFbiJZvrm6IwpwvgVm9Fz7fizU+aUWHUWZguEKtrOmbrOKuDUngpZltgMl9wvegJBe37
	EmPZnLxca5lRhGFPoRoF51Bp9dK7xIITcEO3Mr7G77uvfVeTyVx5nwq0eiVnuqtsBPgKJnM2WIu
	dssnebEHD6MMkzBVdKgYP7FeDZy3RWIQZXG5iXPDaviZ4mawmcT2dZizAhBoqJzPc4L6GBjkKw/
	RQS9Z/Kiw9xJ8029tfbK83UxkxjKCpbSePnUgllKlwEpZ03HRzYyOkcG2X4S5ew4oiED0T8sOnj
	geQCz+eamDKDLJaX86z0cjbLr0mDR06fEb2vi8jS6gENo3CLmpSh5fLIeMysgg6f6oA2GTRy4s/
	oprYYddMZ+X6AynmDJOxGhb8meAr6djsGoansEfniE8MTZE1SmNzmha8oEiCyQab1164qG0Ugbl
	Y5QTH6FUwd/UUtpkKn0mEP8XaJULFYwPzc9KLVCkQ3d0w04hnijF1hNt35rUA35oseWR1uyoK9m
	w==
X-Received: by 2002:a05:6214:1bcb:b0:91c:7a10:7fbc with SMTP id 6a1803df08f44-91ca4a14adfmr236812736d6.4.1793732009505;
        Tue, 03 Nov 2026 10:53:29 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7c7881desm234016d6.29.2026.11.03.10.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:53:29 -0800 (PST)
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
Subject: [PATCH v2 07/20] libselinux: clear consumed source children during context merge
Date: Tue,  3 Nov 2026 13:52:54 -0500
Message-ID: <20261103185307.45924-7-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103185307.45924-1-stephen.smalley.work@gmail.com>
References: <20261103185307.45924-1-stephen.smalley.work@gmail.com>
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

