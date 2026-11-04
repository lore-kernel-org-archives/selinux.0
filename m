Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804983;
	b=qxBPC6e8/h8FulIbT5QdiHj8/11kCOA19ePQHGcWoL8xHG/3Ej1zvTx/3QfLnmN9ANtO
	 1qh0m1yua3GcM15jmqqk78yoUbQMEajHoAFLoBI6WwLn//hW55ZuAWI43wJbhAOqd9BUn
	 k6K1XUBe+NgeHLfrGBtgKJdcZ2Y7Tx7tF+zzzEYCwTeLgp26MqlQzDUU+tNwjbkZNEPKq
	 NFjF8HVdAht6I712N9jYbdTLbGOpjvfsu+jtjrvNy7Q3kUqOEyiMivDNSK9Ihjg1jHiNT
	 szJWS2JXr7mB4U+o2W0MBW77MBUrlP6OGRmllm/0KcPzvmOZ+ofRRjvx6sYFIai6l4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804983;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=F68PICbXOd9OMHuSOs+bfYnCRBKiE3xtBO4+qoXFbG4=;
	b=v0ovNvbr3FSXPgu7xIRE78XXCcUZ14OFbxwBxrhN/Gl308jaX10BwRh/6po9aqwr9XF/
	 4LJEmqEB00lJ1Aab1gVxBdmJ8OjGGDzm1NmkM3t8aT4dYHL5B6AhXj5wSSoenLWKDweQD
	 efxKZvUTHb3VGlTSbkDtQ7PfO3Kguqr1Hmx0fqBBiFHqkzP0vFQHnGZrzNv+NWEobS+q4
	 FIpLFVyo/O/0s16qMr3EP0pj3IizKUg4i9F5DMplq149AHNGUJJ8pDMuUA9qiY5sj7QLx
	 dK8U0u231AZlv05mMHgXWl8A6JoiogNk/hdrQD1EWn1Vl03TMWBn+gEkxPp5TdiBHwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B31Fiu99;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB48606D80B
	for <selinux@vger.kernel.org>; Wed,  4 Nov 2026 15:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DB48606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B31Fiu99
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-53665358476so8475891cf.2
        for <selinux@vger.kernel.org>; Wed, 04 Nov 2026 07:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793804981; x=1794409781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F68PICbXOd9OMHuSOs+bfYnCRBKiE3xtBO4+qoXFbG4=;
        b=B31Fiu99snjVocG157QlQQl95YE7JP1RTfpZvQucWvWaNp3MQE+9RE/yK57nTDpffz
         T6BsNNHMWuPwQocIWWoTxJvcIs44d0jueR38KJ84E1MGJBZY1fnxD7aW4sOpXLHWe4Fv
         nsVcbuiRSe3mSzyINlVRCgwJuxjcgjiJI/0N1eaL5JdodSLDXRz5wu+xD7NyMrs/zhN7
         zGU+DMUgJcOC3y2b/6fcDMMbv4fdzRkdQqN+iormHkFBBI5w9lLrxlD46R/HrNTSoXrJ
         96NwbJQR6H6+42Aq3CSkLqoFu5M9r64RQuGgM71lPOpfkaewEjsMwhByYAy5NKyMsHsP
         /L+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804981; x=1794409781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F68PICbXOd9OMHuSOs+bfYnCRBKiE3xtBO4+qoXFbG4=;
        b=R7x0FOBGplm9bGjXhbg97r5nev9GjN0gRo9v+jMyDaekj08lOpTJ9MrCdSphuFPooF
         DdhPfWYdds9Z1Fr6cf+TpzvVhv6jymSaK4Qh6g6WsFBNq/Q1BqkonaREzNzS6WE2tjSy
         hx8kgOIiBRv0aDk7gFm1W+gIICCwA7CUlzQhmQkYnm4U1IGpVt0zdqK6z8owD/IGYGWE
         H2HF1grxloEXRfLaZ8FMKJACrgMqFNsZNC0egpJnK0jOw5ZSDh+rud1MrfgvAeOjYKtT
         VLdSIEjztwQXLlF+xLYRPqlByTAR+CMIPUVK+bEn4iCUfaszRdP1eCL/bUOg6Vzb7iXD
         Dbxw==
X-Gm-Message-State: APuU4Z/m28SVsKpijCKKlPH0MX2L+7M/jzopBL17hXI2oQGSd7Q4/9Eq
	nPZxqF5WZ5h3w/oKCMqPMhaEhey24Y6zboyzrSUtuNiGSMw7zwVchXHuB9O0aV8E
X-Gm-Gg: AYBFou3CuDwXiaKk2qco4JzNK9Y9p8zvlQYN9IFrHxSC+iq4BLcTJjDwbAowClV0zEq
	9b89PtQi7hk1RscceQsmL62RS7b1inWanOMia9PWDHvl4ai65sSnVTyK//uP2Bc92MMawJg6TEJ
	UeF2nwu4uXPMdjAmm61wjRXr1M02/OBVYRRIfRn6DOgRa7FPLocpYOBWI6y2RaZoVr3kTf3sgUQ
	RJhRe+fE7vuQJHXROrIAxuQBJhxNiQH7z1Ekr/9MkToDfVSqur6CT/VxFxhE9GHBdZRCIgZHmft
	8ykjuziCGK4OjVrru0MJZwToMHpS1l0/nM6JrcrXP8bQJknaT/Vla5pGPjBjy4APaj+8TwdIbSe
	4JvnGmP6EC9+bIO0lWi8Eb1Kp2PMfbDslKRIaUtHvltxoqfw/owKqV8zPlqr3raNPLfrVT+CaPK
	KzGahddqnw064U/y7YnJEhDMZLT2HGiAgtpS7PnsLcmLwxV7ubEVEyTKsVr20Sm1i+2G1cbgKZj
	GWosO7DW/jTApDWemx2tWz1mi3KxlkfgviL1jPjfKrpoxHHKgjH29On5KOpS2uEgJR16PcIhMrT
	iHbiqWkhpTwvA5cDNBikuNT/IREKZ7zQP9air2WZSOUmXXARuOKWF9hJ1rGCF07eyNDl9RzBj7/
	ATxHOwPb4b3Wli8eIzytOiKeWffc2B2ylmACdTaz/fDWzz2rk0KLp3KESrxFmYI1WWS0MbYjoxe
	Ti8ItpRHzG1nxVcn7yIF9QUCcPsKKn4ZMsSrpzexzOxxLZBbjpP+Q=
X-Received: by 2002:a05:622a:250e:b0:536:8843:c2bf with SMTP id d75a77b69052e-542b7ff0786mr266383541cf.67.1793804981333;
        Wed, 04 Nov 2026 07:09:41 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10cdc3d3sm25683041cf.28.2026.11.04.07.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:09:41 -0800 (PST)
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
Subject: [PATCH v3 09/20] libselinux: select readable file-context configuration inputs
Date: Wed,  4 Nov 2026 10:09:04 -0500
Message-ID: <20261104150915.175923-9-stephen.smalley.work@gmail.com>
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
index 563eccce..8fcec282 100644
--- a/libselinux/tests/.gitignore
+++ b/libselinux/tests/.gitignore
@@ -7,3 +7,4 @@ test-restorecon-digest
 /test-label-merge
 /test-substitution-hash
 /test-substitution-restorecon
+/test-readable-fallback
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

