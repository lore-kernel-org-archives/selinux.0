Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804984;
	b=Yp5lhif5ZQ34dVEONJWxJfo9CO1c994v+sfSjRiyNb7OHmDf/vObSwulYHnT5ew+wkko
	 4nS2V/rnIa8F9xQExdk0phK5R+RDbGKoYn3V/1OlR+DJApumBpKllQxBKYVmtbP3HPNG8
	 8OOh+GbkL9ZzjMi5DRGqvRF5gP4J7DFw6Y+VuqGRw52mHIfmp771WdKInNnSy9KYdRfrl
	 Rjn/nvJMtwIqtHE1RjReBId7WIpt7OSbqCmTUg6QMBY+Mg5a6TFQQWtijDVCS4Hbisorg
	 GREKb/VX2OMGZAJEMPXuE9ozvNamSj+/B+DUlz0gJSb++khjLhHUEJXIhJNrbf2pniA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804984;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7RirvgwUQP8YMjtVGyPlQoedG3oth59XFGM7jTp88DM=;
	b=5ooWTLtT0rcbjwppBAU6weT1FZGzArqrZvugDKRktVWcHZqL/g3KLKl56cJH8QTBs9Rj
	 vNijlwvmvB8CYaMujTtlO1vnCT5ev34P8S87HTKDRJvkKewO3JS43yfflfR+TNS2+nntJ
	 5FZmA3cWdTi1+xxLz11q5nzWl4uGOvXy6Skg+1xVUXAq8FIjW7n4AmVoiG3BymdxJQqKM
	 75Zd0U3lC8L8PwH4bMZWUPVcBT6/H5OrpRiS1EW+h8oB5xG31RIF3ksjmqwnjyOkLX6wX
	 l1pRF3cNMNApS/+1vuEXEqcm0uPYm9RHXgv152SFnAgTH5Qpgmndmxp8cB4fX/nV0Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BZPPFM2I;
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78B8606D80B
	for <selinux@vger.kernel.org>; Wed,  4 Nov 2026 15:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A78B8606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BZPPFM2I
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5364d86f7f0so8765371cf.1
        for <selinux@vger.kernel.org>; Wed, 04 Nov 2026 07:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793804983; x=1794409783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7RirvgwUQP8YMjtVGyPlQoedG3oth59XFGM7jTp88DM=;
        b=BZPPFM2IEHetCnzTlmbYtpfBco6QADk/ntVxxygNP5TYY00rw/a2fMtZdgcWPBeglK
         s8sW+MRRjPRwRB1CYBfwc8LKQaC8N6rW6QreT6uuwUzAHQ96AfOfzGM8lx63mRf2GMKU
         8aBfAq4o5LuUFGsMwjVxKYHCenD7xgonrkRoKsUcQ3lW98f3xL3js6NkVoqaOh9RmTl6
         /VYdpTlg7KN7ek9tfuHFwL532Te0JoL9VyZcUEvk2wsQ0vGrsSAUB6zxlt4IgLLQzkvd
         Meqri6RPPEO4819Ot/31Mw2Io73WJZaEzgwk7y+8l+AnUP7bV8hwo0h9YLxNqUSJoID2
         lTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804983; x=1794409783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7RirvgwUQP8YMjtVGyPlQoedG3oth59XFGM7jTp88DM=;
        b=ijLxwt6InGd7+4F9sElHpvG7xrfzSEZH2hNuRs9uBEG9HvVbCWzRB474QLsItA1cPH
         F1/1Lm4yxHcAfJr5S3i0pLwW/NPJVZucCS4YQHWB5VtIGKjR/YCCWsy3/m4p0MQJ3FJo
         V3AmzniiJw3mVsOivO2Iotnt2sT87yX5+qvTPkANcDokq7T4GwXS8TdkPGY+Jv7oaDZx
         KFBPQ8cq1E+wrlVGAstwMGLjrP6jkxSYgOI0oXFDc7ai4zeecAtvb6L2vEyXFtzuUxDQ
         bDjgJMcSEynh6NjOmex0bYI/zh+y/cXjX7jTbk+kwE8AJmYsVhk/ZsEpGFsMktVLm8nT
         KuBA==
X-Gm-Message-State: APuU4Z/KjfsSquUR7I0tMDjx5lmsLVQ/Dx10gpFMM3JUw7E/DoMWKIFg
	vQFWQNrJtebEc/p72hFya4cIUCWAeWQz94ntKSr1WNW+gZOQt3nhHqxgqEQNfHQ2
X-Gm-Gg: AYBFou0osyut6Y9IMcN9LTo+mkDWNlG8prKODzd0zzLGRgIIfVrFUKgA+YwQyJqPNgw
	wpk6q/Wqos+Nuh7UDpQaCDfmPEd1CAd3c+umkgjJEjuDqXjQATSG3JmzSnGix2lttzsvkj+Nl+N
	zzAUClJWy4EIwxHGGPiGsQn6k7Kz4QruKTLFCTI2Z6TQeblUnc8dlCPp4BSjMO/k7TgPMU9WQa+
	TjuBhUvNEdaKBGg57GLMTwN0SbLzqNXQ3t8F+h7C3oC3ZqLSWkUZYh5bOa6IemUMU24Vylbe/gU
	P16UqKb0hKE3hVA7IywBGGdeGO0ehVYWcxOQHagTtjyP3hixug9QhS3crFlApdFw59DbFmuHZTe
	7syBdgVenlWaGldmdsTkkDOBd2hX/d11vWZFyZM2HivwNqld8PEsxabTca2YcIkanD3pdDP3RKp
	GWfFTIFVLd/9hEge1AwfG0GHcZ1pTfzDzN75mcCU589640/y4UUtO14OTOKs5Ja5/b58ehqG/o6
	8UArDZo7qhEpMEsw0adrAOmzryMC6C16psGo1cowbsiqnSeFXCvPN9uAxhZJW1+2NYAUDIlV+CX
	2g3kTKOxZB9uEDAvLKXu5ysevdPC5Zc+vHC/vs6COlSPEuoq3x9kW6Z2Jtwy5EhDi5w1I307i8A
	Mf92GAEoVw3z7/fJSBuK5gV+HVLhKK+I6d6VwJFdjoQ2dDmI+Q8hTOrttp+zH5qSq83fidnOaRU
	kt9WFMe69EudO2G39D+2wGLNWsczy/j13KKUXJlb75Cb1gaEoINJo=
X-Received: by 2002:a05:622a:4d8f:b0:535:28bf:556a with SMTP id d75a77b69052e-542b6d5f3eemr282759431cf.37.1793804982625;
        Wed, 04 Nov 2026 07:09:42 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10cdc3d3sm25683041cf.28.2026.11.04.07.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:09:42 -0800 (PST)
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
Subject: [PATCH v3 11/20] libselinux: preserve the opened policy version when loading
Date: Wed,  4 Nov 2026 10:09:06 -0500
Message-ID: <20261104150915.175923-11-stephen.smalley.work@gmail.com>
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

The configuration-root search decrements vers after opening a policy,
so the conversion check uses the preceding version instead of the version
of the opened file. A policy exactly one version newer than the kernel
is therefore submitted without conversion and rejected, even if a
compatible older policy is available.

Exit the outer search loop on a successful open, preserving vers for the
conversion check. This also avoids skipping the immediately preceding
version when a failed conversion decrements vers before retrying.

Add native regression coverage using CIL-generated policy images and an
intercepted kernel load. Cover version gaps, older policy files, conversion
failures and retries, missing policies, root fallback, and hard errors.

Fixes: 80b471735966 ("libselinux: search for the binary policy across configuration roots")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/load_policy.c                |   3 +-
 libselinux/tests/.gitignore                 |   1 +
 libselinux/tests/Makefile                   |   7 +-
 libselinux/tests/test_load_policy_version.c | 219 ++++++++++++++++++++
 4 files changed, 228 insertions(+), 2 deletions(-)
 create mode 100644 libselinux/tests/test_load_policy_version.c

diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index ab6743fa..ec353493 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -160,7 +160,8 @@ search:
 			}
 			break;
 		}
-		if (fd < 0 && errno != ENOENT && errno != EACCES)
+		/* Keep vers equal to the version of the opened policy. */
+		if (fd >= 0 || (errno != ENOENT && errno != EACCES))
 			break;
 	}
 	if (fd < 0) {
diff --git a/libselinux/tests/.gitignore b/libselinux/tests/.gitignore
index af40dd3f..2713a798 100644
--- a/libselinux/tests/.gitignore
+++ b/libselinux/tests/.gitignore
@@ -9,3 +9,4 @@ test-restorecon-digest
 /test-substitution-restorecon
 /test-readable-fallback
 /test-digest-inputs
+/test-load-policy-version
diff --git a/libselinux/tests/Makefile b/libselinux/tests/Makefile
index cdc395b7..be03e5d5 100644
--- a/libselinux/tests/Makefile
+++ b/libselinux/tests/Makefile
@@ -20,7 +20,7 @@ test-restorecon-errno: test_restorecon_errno.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(ERRNO_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
 
 .PHONY: test clean
-test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs
+test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs test-load-policy-version
 	./test-restorecon-digest
 	./test-restorecon-errors
 	./test-restorecon-errno
@@ -32,9 +32,11 @@ test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-r
 	./test-substitution-restorecon
 	LD_LIBRARY_PATH=../src ./test-readable-fallback ../utils/sefcontext_compile
 	./test-digest-inputs
+	./test-load-policy-version
 
 clean:
 	rm -f test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs
+	rm -f test-load-policy-version
 
 test-restorecon-exclude: test_restorecon_exclude.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(EXCLUDE_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
@@ -55,3 +57,6 @@ test-readable-fallback: test_readable_fallback.c ../src/selinux_config.c ../src/
 
 test-digest-inputs: test_digest_inputs.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ -Wl,--wrap=realloc,--wrap=strdup $(PCRE_LDLIBS) -pthread
+
+test-load-policy-version: test_load_policy_version.c ../src/libselinux.a ../../libsepol/src/libsepol.a
+	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) -o $@ $^ -Wl,--wrap=security_policyvers,--wrap=write,--wrap=sepol_policydb_to_image,--wrap=selinux_policy_roots,--wrap=selinux_binary_policy_path $(PCRE_LDLIBS) -ldl -pthread
diff --git a/libselinux/tests/test_load_policy_version.c b/libselinux/tests/test_load_policy_version.c
new file mode 100644
index 00000000..61d80cb7
--- /dev/null
+++ b/libselinux/tests/test_load_policy_version.c
@@ -0,0 +1,219 @@
+#define _GNU_SOURCE
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <sepol/cil/cil.h>
+#include <selinux/selinux.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <unistd.h>
+
+static unsigned kernel_version, submitted, conversions, failures;
+static int testing;
+static char root[] = "/tmp/selinux-load-version-XXXXXX";
+static char base[256];
+static const char *roots[] = { root, NULL, NULL };
+
+extern void fini_selinuxmnt(void);
+
+int __wrap_security_policyvers(void);
+const char *const *__wrap_selinux_policy_roots(void);
+const char *__wrap_selinux_binary_policy_path(void);
+int __wrap_sepol_policydb_to_image(sepol_handle_t *handle, sepol_policydb_t *p,
+				   void **data, size_t *len);
+ssize_t __wrap_write(int fd, const void *data, size_t len);
+
+int __wrap_security_policyvers(void)
+{
+	return kernel_version;
+}
+
+const char *const *__wrap_selinux_policy_roots(void)
+{
+	return roots;
+}
+
+const char *__wrap_selinux_binary_policy_path(void)
+{
+	return base;
+}
+
+int __real_sepol_policydb_to_image(sepol_handle_t *, sepol_policydb_t *,
+				   void **, size_t *);
+int __wrap_sepol_policydb_to_image(sepol_handle_t *handle, sepol_policydb_t *p,
+				   void **data, size_t *len)
+{
+	if (testing) {
+		conversions++;
+		if (failures) {
+			failures--;
+			errno = ENOMEM;
+			return -1;
+		}
+	}
+	return __real_sepol_policydb_to_image(handle, p, data, len);
+}
+
+ssize_t __real_write(int, const void *, size_t);
+static uint32_t image_word(const unsigned char *data, size_t len, size_t offset)
+{
+	assert(offset <= len && len - offset >= sizeof(uint32_t));
+	return (uint32_t)data[offset] | ((uint32_t)data[offset + 1] << 8) |
+	       ((uint32_t)data[offset + 2] << 16) |
+	       ((uint32_t)data[offset + 3] << 24);
+}
+
+ssize_t __wrap_write(int fd, const void *data, size_t len)
+{
+	uint32_t target_len;
+
+	if (!testing)
+		return __real_write(fd, data, len);
+	/* The version follows the magic, target length and target string. */
+	assert(image_word(data, len, 0) == UINT32_C(0xf97cff8c));
+	target_len = image_word(data, len, 4);
+	assert(target_len == strlen("SE Linux"));
+	assert(len >= 8 && target_len <= len - 8);
+	assert(memcmp((const unsigned char *)data + 8, "SE Linux",
+		      target_len) == 0);
+	submitted = image_word(data, len, 8 + target_len);
+	if (submitted > kernel_version) {
+		errno = EINVAL;
+		return -1;
+	}
+	return len;
+}
+
+static void policy_file(sepol_policydb_t *p, unsigned version, int remove)
+{
+	char path[512];
+	void *image;
+	size_t size;
+	FILE *fp;
+
+	snprintf(path, sizeof(path), "%s.%u", base, version);
+	if (remove) {
+		assert(unlink(path) == 0);
+		return;
+	}
+	assert(sepol_policydb_set_vers(p, version) == 0);
+	assert(sepol_policydb_to_image(NULL, p, &image, &size) == 0);
+	fp = fopen(path, "we");
+	assert(fp);
+	assert(fwrite(image, 1, size, fp) == size);
+	assert(fclose(fp) == 0);
+	free(image);
+}
+
+static void load(unsigned expected_version, unsigned expected_conversions)
+{
+	int rc;
+
+	submitted = conversions = 0;
+	testing = 1;
+	rc = selinux_mkload_policy(0);
+	testing = 0;
+	assert(rc == (expected_version ? 0 : -1));
+	assert(submitted == expected_version);
+	assert(conversions == expected_conversions);
+}
+
+int main(void)
+{
+	const char cil[] =
+		"(class file (read)) (classorder (file)) (sid kernel) (sidorder (kernel)) "
+		"(user u) (role r) (type t) (category c0) (categoryorder (c0)) "
+		"(sensitivity s0) (sensitivityorder (s0)) (sensitivitycategory s0 (c0)) "
+		"(allow t self (file (read))) (roletype r t) (userrole u r) "
+		"(userlevel u (s0)) (userrange u ((s0)(s0 (c0)))) "
+		"(sidcontext kernel (u r t ((s0)(s0))))";
+	cil_db_t *db;
+	sepol_policydb_t *p;
+	unsigned min = sepol_policy_kern_vers_min();
+	unsigned max = sepol_policy_kern_vers_max();
+	unsigned cases = 0;
+	char path[256];
+	int fd;
+
+	assert(max >= min + 2);
+	cil_db_init(&db);
+	assert(db);
+	cil_set_mls(db, 1);
+	assert(cil_add_file(db, "test.cil", cil, sizeof(cil) - 1) == 0);
+	assert(cil_compile(db) == 0);
+	assert(cil_build_policydb(db, &p) == 0);
+	cil_db_destroy(&db);
+	assert(mkdtemp(root));
+	snprintf(path, sizeof(path), "%s/policy", root);
+	assert(mkdir(path, 0700) == 0);
+	snprintf(base, sizeof(base), "%s/policy/policy", root);
+	snprintf(path, sizeof(path), "%s/load", root);
+	fd = open(path, O_CREAT | O_EXCL | O_WRONLY, 0600);
+	assert(fd >= 0 && close(fd) == 0);
+	fini_selinuxmnt();
+	set_selinuxmnt(root);
+
+	for (unsigned older = 0; older < 2; older++) {
+		for (unsigned source = min; source <= max; source++) {
+			for (unsigned gap = 0; gap <= 2 && gap <= source - min;
+			     gap++) {
+				kernel_version = source - gap;
+				policy_file(p, source, 0);
+				if (older && gap)
+					policy_file(p, kernel_version, 0);
+				load(kernel_version, gap ? 1 : 0);
+				policy_file(p, source, 1);
+				if (older && gap)
+					policy_file(p, kernel_version, 1);
+				cases++;
+			}
+		}
+	}
+
+	/* A failed conversion must try the immediately preceding version. */
+	kernel_version = max - 2;
+	policy_file(p, max, 0);
+	policy_file(p, max - 1, 0);
+	failures = 1;
+	load(kernel_version, 2);
+	cases++;
+	failures = 2;
+	load(0, 2);
+	cases++;
+	/* An already compatible fallback does not need another conversion. */
+	policy_file(p, max - 1, 1);
+	policy_file(p, kernel_version, 0);
+	failures = 1;
+	load(kernel_version, 1);
+	cases++;
+	policy_file(p, max, 1);
+	policy_file(p, kernel_version, 1);
+	load(0, 0);
+	cases++;
+
+	/* Root fallback must preserve the version, too. */
+	policy_file(p, max, 0);
+	roots[0] = base;
+	roots[1] = root;
+	kernel_version = max - 1;
+	load(kernel_version, 1);
+	cases++;
+	/* A non-searchable path component is still a hard error. */
+	roots[0] = path;
+	load(0, 0);
+	cases++;
+	roots[0] = root;
+	roots[1] = NULL;
+	policy_file(p, max, 1);
+
+	fini_selinuxmnt();
+	sepol_policydb_free(p);
+	assert(unlink(path) == 0);
+	snprintf(path, sizeof(path), "%s/policy", root);
+	assert(rmdir(path) == 0 && rmdir(root) == 0);
+	printf("load-policy-version: %u cases passed\n", cases);
+	return 0;
+}
-- 
2.56.0

