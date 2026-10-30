Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388014;
	b=sY+X6dS6L8lEqMqZTpONhdokJDf1Y8CIJjQTQjfdNfeVW49lwkbT5clzfeAJ4LS3KW96
	 d3H2u5RrqySFzNja013BKtZraS3kZWbCA4Y8cYOnsIVzLiZiGmiClOUhmtHnaVUw5uxwx
	 pEyhpdaxUOjXiwiUKfIeZcOQWFwz07wg5GJNWOdxgIq3MuyIP2dIS0fFVKHAUJvmcmsWR
	 +yvyYBIk3k42P45oA627smxVcGGyHFblRLBgWi/aUyPu8LmMi1dYS+QhlBY+0E83lOM7P
	 8pfExkxcmEl2fmFM7IKyH5dpSfNj9ce0rK+Fc9ZG6WJixTg92Ptiys3P4FcKL7+9jEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+wH4m8H/dlipxc0OLQomc9o/t7dSBNu1eHj6GKtUj8w=;
	b=vbLu9iO+6l/Nbp+dnVKMAmaKhOLOBvNw3f8I4oIedi9N+LkDgi9j8x8UhGtDOXZwpxhr
	 BCgQt0nkdgOMGyEDrDPS+hs95LcknMSALk4cBZgZKKyBzAASeS02xKqcBra5KPJ9jzuun
	 AfXAWowYt7Gh8tciaW30mmaeukIFHOz8Xh9o7ismorXWusiS6jmgoz33A+luznGp/7uxl
	 /vshcV/hYpp/ecW9U5DgBPxzt6N0Rh5NSMAmiuptUzpl0/LiXqXnNTqYa5LDtQQYmHFsa
	 BtAem6csqAKWF3vgeJO/C+fV/E4ZDQHs+K5XVbTu8oLWGaTNo0a1BbO/VzCmOXky1pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H3+3yEYE;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55430606A31E
	for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 19:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55430606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H3+3yEYE
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-943e8d35f74so98480185a.0
        for <selinux@vger.kernel.org>; Fri, 30 Oct 2026 12:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793388013; x=1793992813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+wH4m8H/dlipxc0OLQomc9o/t7dSBNu1eHj6GKtUj8w=;
        b=H3+3yEYEsWpXfoEWX8+t+bYtchDy4CrXam+CXwD+4cxLX3lQzCa9zTar3y0FDwduyw
         56HAfpLix7M5J0JD+eMBUwPgwgf03XszVE0zyUwevVkUlTcka4r+4Gibb3bNggvgmSkT
         LDCTe9JHriGF5akKqNgCvBPAxPR2oTQroAlJOQRRO10vitxKNzhQodVl1p2VZv2U8lRQ
         i/iDP4MKsHgNHUsJiLuz5tmb1tbRXV2uYSA+lVnhGuXA70w8dft7/HG+yDYAnz8aii8a
         0Bj2QSUARnG38be7TAsNm0OuU6tA73CpFFv/38MiZgp/1JDw8flV9eK9DNSHPt6OPiM9
         9oGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793388013; x=1793992813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+wH4m8H/dlipxc0OLQomc9o/t7dSBNu1eHj6GKtUj8w=;
        b=qodlBonxdZMb3AZeuOsS45h73wDrljJNQiYW1OLen1uCUdyZxXV5rA/CzaNJDjud5R
         pzEpvV0EhKPG3aD6IGpruOzaZ4wRNXB/d7cRH4dhvPFPlGpuq3uQ+rxodno0WGLo4n5H
         U2LbUeU5gBDLCeckKKHvwQU24t03oOihXPlFWKsBeRDKIzG9QwrT0Fej7WV0+X2D+/Ch
         lT+SmYH+2T0pHVHBilXz96Qn6rAjlpYj3UbLUOg177FErUN1O1QR36MC6CYBv98jKG24
         gdQ/p8ZNp8d0nfUBv0g0h/vB+tdfk666wRSYcTAPNasZQFWuDLKLoPy6/lOpued3Gfa+
         V3DQ==
X-Gm-Message-State: AFq9FYKzCpLQJL0XI7IxTTQhoELLtdPZ9WfBnL7hhPzZvybC9BTG9Y//
	H34ZI/YG9UjnKo9cdoyGPzSm2mHiZFNrsDpdFYa6mfQIvDYVlUIj3MfWzM7oeiJD
X-Gm-Gg: AYBFou2Vsbh81eDlBRDeT/iUQLtQAGHE/nmfqL3fcI02JHuMwXTLYeVRz2PwzuFbdRZ
	e8HBL/0QWDUaejme/KqVHmG7asqTm8WiwHp1ZHyevBSRa49lvHrnI1zM2fIOIl8Lvg0GhS/ZNoz
	yLmC8fjTgq0Nij7BAq+T6cRhKMDxRhCoeo12s5EeVi4jhrDvrAQ5p3OXG3bRefrqkPeOUwHZha9
	SHH8zVgUXfz1rZ3oXO1byZoz5zWmxk/5NfKG4JA5jC8+Fn3PzAi1oTD/qnOhK7zJNzgE7y63PBZ
	Z55Ddaoao52Dy3VvryZO6hIQXuOLil1FbfaLJ4Zrq6dlJt+yafDou4uTc3hCiLRr52xVLSqmELn
	1wMyzkeHk7lBgLNS0GoNQ2KNDa2xGdOvj+z463f+Qgc2wsbcnSqdZnXsqb6rV0641G1nTboLCRI
	MCPsnQ+HiyoihQF1xnn+3DQZhjjLdE1gWO91Pne59rLymHz+vjKKMzIH8uDXhXO63v92YyCqI9d
	jbvKQTZ/0Ibl4QHvkQghzZ5IQtPjsgWxbFmf8kelBa/ZM5SaXAVa6WYqnFQ5PMcCNxxCtmhMvxW
	6E+NL/Pz43Yzyc9hmo5oCidgFyZgc0pbD7irX3uNCFhXSb2U/qOHdkG1OmGwCZ/oQV5W8L+YL/b
	9m2O0V4tEkwt9Ojj8qKhW+FcdmJyPDcSty9kVWRWlMJXazzO50EUR16/XsuzULkfU5TFNjI+Z5M
	8VNv1FgZwBgqrUuLd/My3Pjj64+OnntIyRf3Pu7GcMjTHtZx6bUes=
X-Received: by 2002:a05:620a:1995:b0:93f:34c9:925a with SMTP id af79cd13be357-944218278c0mr586373685a.67.1793388012742;
        Fri, 30 Oct 2026 12:20:12 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca805be18sm22501076d6.31.2026.10.30.12.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 12:20:12 -0700 (PDT)
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
Subject: [PATCH 09/10] libselinux: select readable file-context configuration inputs
Date: Fri, 30 Oct 2026 15:19:23 -0400
Message-ID: <20261030191924.150495-9-stephen.smalley.work@gmail.com>
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

The configuration-root resolver uses F_OK, so an existing unreadable admin
file masks a readable vendor fallback. Use effective-credential readability
checks for the base and its optional compiled sibling. Retain the first
refused base path when no root is readable, allowing callers to report the
denial instead of treating a missing primary optional file as success.

Select text and compiled siblings by mtime only among readable candidates.
Otherwise an unreadable newer compiled file still masks readable text after
the resolver has selected that root. Preserve EACCES from metadata checks
when no candidate can be opened.

Add 32 real-DAC regression cases, including compiler-generated binary
inputs, root precedence, sibling selection and unreadable-only fallbacks.

Fixes: 27280a14f26e ("libselinux: search file_contexts files across configuration roots")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/label_file.c               |  14 ++-
 libselinux/src/selinux_config.c           |  21 +++-
 libselinux/src/selinux_internal.h         |   8 +-
 libselinux/tests/.gitignore               |   1 +
 libselinux/tests/Makefile                 |   8 +-
 libselinux/tests/test_readable_fallback.c | 146 ++++++++++++++++++++++
 6 files changed, 188 insertions(+), 10 deletions(-)
 create mode 100644 libselinux/tests/test_readable_fallback.c

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 9b93b198..99c188a6 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -1193,6 +1193,7 @@ static FILE *open_file(const char *path, const char *suffix, char *save_path,
 	int rc;
 	char stack_path[len];
 	struct file_details *found = NULL;
+	bool unreadable = false;
 
 	/*
 	 * Rolling append of suffix. Try to open with path.suffix then the
@@ -1217,8 +1218,17 @@ static FILE *open_file(const char *path, const char *suffix, char *save_path,
 		}
 
 		rc = stat(path, &fdetails[i].sb);
-		if (rc)
+		if (rc) {
+			unreadable |= errno == EACCES;
+			continue;
+		}
+
+		/* Choose by mtime only among siblings this caller can read. */
+		if (faccessat(AT_FDCWD, path, R_OK, AT_EACCESS) < 0 &&
+		    errno == EACCES) {
+			unreadable = true;
 			continue;
+		}
 
 		/* first file thing found, just take it */
 		if (!found) {
@@ -1247,7 +1257,7 @@ static FILE *open_file(const char *path, const char *suffix, char *save_path,
 	}
 
 	if (!found) {
-		errno = ENOENT;
+		errno = unreadable ? EACCES : ENOENT;
 		return NULL;
 	}
 
diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index 297a33b0..17dd4085 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -4,6 +4,7 @@
 #include <ctype.h>
 #include <stddef.h>
 #include <stdint.h>
+#include <stdbool.h>
 #include <stdlib.h>
 #include <limits.h>
 #include <unistd.h>
@@ -620,19 +621,29 @@ int selinux_policy_resolve(const char *path, const char *sibling, char *out,
 			   size_t outlen)
 {
 	char probe[PATH_MAX];
+	char refused[PATH_MAX];
 	unsigned int i;
+	bool unreadable = false;
 
 	__selinux_once(once, init_selinux_config);
 
 	if (strlcpy(out, path, outlen) >= outlen)
 		goto noent;
 	for (i = 0;; i++) {
-		if (access(out, F_OK) == 0)
+		if (faccessat(AT_FDCWD, out, R_OK, AT_EACCESS) == 0)
 			return 0;
+		if (errno == EACCES && !unreadable) {
+			strlcpy(refused, out, sizeof(refused));
+			unreadable = true;
+		}
 		if (sibling) {
 			snprintf(probe, sizeof(probe), "%s%s", out, sibling);
-			if (access(probe, F_OK) == 0)
+			if (faccessat(AT_FDCWD, probe, R_OK, AT_EACCESS) == 0)
 				return 0;
+			if (errno == EACCES && !unreadable) {
+				strlcpy(refused, out, sizeof(refused));
+				unreadable = true;
+			}
 		}
 		if (!selinux_policyroots[i + 1] ||
 		    selinux_policy_remap(path, selinux_policyroots[i + 1], out,
@@ -640,6 +651,12 @@ int selinux_policy_resolve(const char *path, const char *sibling, char *out,
 			break;
 	}
 
+	/* Let callers report a read denial even if only a fallback refused. */
+	if (unreadable) {
+		strlcpy(out, refused, outlen);
+		errno = EACCES;
+		return -1;
+	}
 	/* Nothing found: leave primary path in @out for diagnostics. */
 	strlcpy(out, path, outlen);
 noent:
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 9df6eadd..8592c80c 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -127,10 +127,10 @@ FILE *selinux_policy_fopen(const char *path, const char *mode);
  * Resolve @path against the configuration-root list: write into @out
  * the first remapping under which @out (or @out concatenated with
  * @sibling, when the base file is optional but a sibling such as .bin
- * may exist alone) is present. If no root has the file, @out receives
- * @path unchanged and -1 is returned with errno ENOENT, or if a root
- * contains the file but it is un-readable and there is no readable
- * fallback, @out receives @path unchanged and -1 is returned with errno
+ * may exist alone) is readable with effective credentials. If no root has
+ * the file, @out receives @path unchanged and -1 is returned with errno
+ * ENOENT. If there is no readable fallback for an unreadable file, @out
+ * receives the first refused base path and -1 is returned with errno
  * EACCES. Internal only.
  */
 int selinux_policy_resolve(const char *path, const char *sibling, char *out,
diff --git a/libselinux/tests/.gitignore b/libselinux/tests/.gitignore
index 563eccce..1cf58a45 100644
--- a/libselinux/tests/.gitignore
+++ b/libselinux/tests/.gitignore
@@ -7,3 +7,4 @@ test-restorecon-digest
 /test-label-merge
 /test-substitution-hash
 /test-substitution-restorecon
+/test-readable-fallback
\ No newline at end of file
diff --git a/libselinux/tests/Makefile b/libselinux/tests/Makefile
index 3e9092cf..1f010c4f 100644
--- a/libselinux/tests/Makefile
+++ b/libselinux/tests/Makefile
@@ -20,7 +20,7 @@ test-restorecon-errno: test_restorecon_errno.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(ERRNO_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
 
 .PHONY: test clean
-test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon
+test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback
 	./test-restorecon-digest
 	./test-restorecon-errors
 	./test-restorecon-errno
@@ -30,9 +30,10 @@ test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-r
 	./test-label-merge ../utils/sefcontext_compile
 	./test-substitution-hash
 	./test-substitution-restorecon
+	LD_LIBRARY_PATH=../src ./test-readable-fallback ../utils/sefcontext_compile
 
 clean:
-	rm -f test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon
+	rm -f test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback
 
 test-restorecon-exclude: test_restorecon_exclude.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(EXCLUDE_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
@@ -47,3 +48,6 @@ test-substitution-hash: test_substitution_hash.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(PCRE_LDLIBS) -pthread
 test-substitution-restorecon: test_substitution_restorecon.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ -Wl,--wrap=getfilecon_raw,--wrap=setfilecon_raw,--wrap=getxattr,--wrap=fsetxattr,--wrap=fstatfs,--wrap=fstatfs64 $(PCRE_LDLIBS) -pthread
+
+test-readable-fallback: test_readable_fallback.c ../src/selinux_config.c ../src/libselinux.a
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ test_readable_fallback.c ../src/libselinux.a $(PCRE_LDLIBS) -pthread
diff --git a/libselinux/tests/test_readable_fallback.c b/libselinux/tests/test_readable_fallback.c
new file mode 100644
index 00000000..753806fb
--- /dev/null
+++ b/libselinux/tests/test_readable_fallback.c
@@ -0,0 +1,146 @@
+/* SPDX-License-Identifier: CC0-1.0 */
+#define _GNU_SOURCE
+#undef NDEBUG
+#include <assert.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <selinux/label.h>
+/* Use private configuration roots without modifying host configuration. */
+#include "../src/selinux_config.c"
+
+static const char *suffixes[] = { "",	   ".local",	 ".homedirs",
+				  ".subs", ".subs_dist", ".bin" };
+static const char *compiler;
+
+static void put(const char *path, const char *text, bool readable)
+{
+	bool binary = strlen(path) >= 4 &&
+		      !strcmp(path + strlen(path) - 4, ".bin");
+	char source[] = "/tmp/selinux-readable-source-XXXXXX";
+	int fd = binary ? mkstemp(source) : -1;
+	assert(!binary || fd >= 0);
+	FILE *fp = binary ? fdopen(fd, "w") : fopen(path, "we");
+	assert(fp);
+	assert(fputs(text, fp) >= 0);
+	assert(fclose(fp) == 0);
+	if (binary) {
+		pid_t pid = fork();
+		assert(pid >= 0);
+		if (!pid) {
+			execl(compiler, compiler, "-o", path, source,
+			      (char *)NULL);
+			_exit(127);
+		}
+		int status;
+		assert(waitpid(pid, &status, 0) == pid);
+		assert(WIFEXITED(status) && WEXITSTATUS(status) == 0);
+		assert(unlink(source) == 0);
+	}
+	assert(chmod(path, readable ? 0600 : 0000) == 0);
+}
+
+static void root_dir(const char *root, bool create)
+{
+	char path[PATH_MAX];
+	if (create) {
+		assert(mkdir(root, 0700) == 0);
+		snprintf(path, sizeof(path), "%s/contexts", root);
+		assert(mkdir(path, 0700) == 0);
+		snprintf(path, sizeof(path), "%s/contexts/files", root);
+		assert(mkdir(path, 0700) == 0);
+	} else {
+		for (size_t i = 0; i < sizeof(suffixes) / sizeof(suffixes[0]);
+		     i++) {
+			snprintf(path, sizeof(path),
+				 "%s/contexts/files/file_contexts%s", root,
+				 suffixes[i]);
+			assert(unlink(path) == 0 || errno == ENOENT);
+		}
+		snprintf(path, sizeof(path), "%s/contexts/files", root);
+		assert(rmdir(path) == 0);
+		snprintf(path, sizeof(path), "%s/contexts", root);
+		assert(rmdir(path) == 0);
+		assert(rmdir(root) == 0);
+	}
+}
+
+/* mode: missing admin, readable admin, unreadable admin, vendor-only denial,
+ * both denied; sibling modes add readable/unreadable text next to .bin. */
+static void run(unsigned input, unsigned mode)
+{
+	char tmp[] = "/tmp/selinux-readable-XXXXXX";
+	char admin[256], vendor[256], path[PATH_MAX], alt[PATH_MAX];
+	const char *admin_text = "/probe system_u:object_r:admin_t:s0\n";
+	const char *vendor_text = "/probe system_u:object_r:vendor_t:s0\n"
+				  "/admin system_u:object_r:admin_t:s0\n"
+				  "/vendor system_u:object_r:vendor_t:s0\n";
+	assert(mkdtemp(tmp));
+	snprintf(admin, sizeof(admin), "%s/admin", tmp);
+	snprintf(vendor, sizeof(vendor), "%s/vendor", tmp);
+	root_dir(admin, true);
+	root_dir(vendor, true);
+	assert(selinux_set_policy_root(admin) == 0);
+	selinux_policyroots[1] = strdup(vendor);
+	assert(selinux_policyroots[1]);
+	if (input != 0 && input != 5) {
+		snprintf(path, sizeof(path), "%s/contexts/files/file_contexts",
+			 admin);
+		put(path, vendor_text, true);
+	}
+	snprintf(path, sizeof(path), "%s/contexts/files/file_contexts%s", admin,
+		 suffixes[input]);
+	snprintf(alt, sizeof(alt), "%s/contexts/files/file_contexts%s", vendor,
+		 suffixes[input]);
+	put(alt, input == 3 || input == 4 ? "/probe /vendor\n" : vendor_text,
+	    mode < 3 || mode > 4);
+	if (mode != 0 && mode != 3)
+		put(path,
+		    input == 3 || input == 4 ? "/probe /admin\n" : admin_text,
+		    mode == 1 || mode == 6);
+	if (input == 5 && mode >= 5) {
+		snprintf(path, sizeof(path), "%s/contexts/files/file_contexts",
+			 admin);
+		put(path, vendor_text, mode == 5);
+		/* Make .bin newer: an unreadable newer sibling must not mask text. */
+		struct timespec times[2] = { { 2000000000, 0 },
+					     { 2000000000, 0 } };
+		snprintf(path, sizeof(path),
+			 "%s/contexts/files/file_contexts.bin", admin);
+		assert(utimensat(AT_FDCWD, path, times, 0) == 0);
+	}
+	errno = 0;
+	struct selabel_handle *h = selabel_open(SELABEL_CTX_FILE, NULL, 0);
+	if (mode == 3 || mode == 4) {
+		assert(h == NULL && errno == EACCES);
+	} else {
+		char *context = NULL;
+		assert(h);
+		assert(selabel_lookup_raw(h, &context, "/probe", S_IFREG) == 0);
+		assert(strstr(context, mode == 1 || mode == 6 ? ":admin_t:" :
+								":vendor_t:"));
+		freecon(context);
+		selabel_close(h);
+	}
+	root_dir(admin, false);
+	root_dir(vendor, false);
+	assert(rmdir(tmp) == 0);
+}
+
+int main(int argc, char **argv)
+{
+	assert(argc == 2);
+	compiler = argv[1];
+	/* faccessat must observe ordinary DAC permissions, not root override. */
+	if (geteuid() == 0)
+		assert(setuid(65534) == 0);
+	(void)selinux_policy_root();
+	unsigned cases = 0;
+	for (unsigned input = 0; input < 6; input++) {
+		for (unsigned mode = 0; mode < (input == 5 ? 7U : 5U); mode++) {
+			run(input, mode);
+			cases++;
+		}
+	}
+	printf("Readable configuration fallback: %u cases passed.\n", cases);
+	return 0;
+}
-- 
2.56.0

