Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732013;
	b=wZByUzHOtZ6iv1tHwat7QBga21+qVw2N3ANhDPkNlkY8zvv15NVYK/ky/duRpMX72Yfv
	 u/Zu+UyD8F2/7B14iwbqJTYWS90ZKLpzjKCTrt4tGG8BqD4zJO6ygp0LdjnUuvdmV47wp
	 D5EG5Nm2xUYk1UpaOvSB68SesWBXn0Vra55bbbMOSlxIgq56r6VKgkuypGXwJFAkU9dbI
	 WcR2TWAn6DMRi8gjWB/9H/SPB5TKb4HO/43thvR4CIeb9RQdW9Aa6OV9JOqDHMwMQV9ig
	 5/scO+fHPIYk7CY5lSGpGs4ABk9HZpCWrtzDwabSgLsP7qsfj1Jut1rpuNbZ94W4Wng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732013;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eUGygO3tLpizXV5DB9oVsXgPA4gVLPRcLowUvGemEso=;
	b=gnzMmLffQl4cYDWeNU48FSW07xykF9tEli7GyrJwW8pdMU1ik/f5o6q4Hh37oVnnljcP
	 xUdsMvHScf+XZFKUoeHIutjUX1WH9XIjz+jEipVceTfrFE1xlhvU83zwaNvrXkW5qtAG7
	 vP2Cg33D3oFSyB3bTP/nHWnjAoPCDAy04LW3mxdG3G9xT25SWZ0s5fbutIRTyjrmqhu0R
	 PnuB0365CLxvjVKM9/sJBqBAFaLHNHzQx7TaokqOu3DV6SQXASc/vVCT4eWjAXMpcOxQe
	 s5tI/tWa/+LY/KJtCJ7jkjjKWdMI73pS2fxmaRRusC6gHajWBRRInHAAND83fii0lAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A3LQblQh;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB8B606A32E
	for <selinux@vger.kernel.org>; Tue,  3 Nov 2026 18:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BB8B606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A3LQblQh
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-917aca1aee5so58480626d6.2
        for <selinux@vger.kernel.org>; Tue, 03 Nov 2026 10:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793732012; x=1794336812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eUGygO3tLpizXV5DB9oVsXgPA4gVLPRcLowUvGemEso=;
        b=A3LQblQhm5v7fCi7s97+oz3bEjwbX3K7F6M0Fq5VQDUiGlOlBhhyTYDw+bMikHDlY2
         VLCSshUst1U2sVgvYo4Cp2zbpKaC2fIEymLenW4VTScxQtIIJKqQRwDWfYhhEjlgljmG
         Vi61/FD3VWZNGyOnG4sgXJ7+QNHHmerC9gi7WYjEY+LUmJRrMj7NlYC7SW+8z7Zg0Xul
         pV5imkKeD7Zg1VgHEW1powWr7mmtya2qzDf1OyMkMWThQvwiYs0iSQFd1syhF5B5QEa/
         MCeOY2NGaBb81ekLsBqnmPY2MV4E95GRvMwUcl8lAs46KwWKpsDG7x5blY5H5/N5dW/e
         WEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732012; x=1794336812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eUGygO3tLpizXV5DB9oVsXgPA4gVLPRcLowUvGemEso=;
        b=TCUhjIwMsspm4Vb+wwUh2/F9j6hUt9lmP7YbiHp1tce6CadtAOcAKZ9oGzL60F9W91
         HT7+DzI/fAhtk48l78nEZ2zC8vGkseUEPBLfjuFNbAdwbsR3eYK1bpmtJ+nUi6qrIl4O
         1MkdtSc7Z5tlCK6T4s3RHFmFYeyJQIqbA9e9dtDZ90/uI1Mn0HPv016EcTxWROFXe3Za
         qM8bZD9RuxM3J1/t7d3pjABn1QgJ5nkjf8uWFoMZ8CWlUi/7zmncSnkp80jHxE+aWoet
         zxHYHL6ZUJmSPO/zCE53tptnhmMpTkxybPuJokwl5kxvl5rGkMRqPguEvomLD7V8TxUk
         d+Kg==
X-Gm-Message-State: APuU4Z90zGdDvqOoMOlFLUEkHY2Da84nGO0eq7qrisEG5q6PqinS+GPx
	a85M4iwj2nI+9EpWdpfc3Xk24tkNiVTYh5gjkrqo4aV4gohFzOWQIFufE++eFww5
X-Gm-Gg: AYBFou00gOjRnfR0DMAwIwJ9mseQFKd73iAzr5JWlG4Lox21xGyHrM9I34HpzU0ncXL
	yfo4E6G81WBE/jpFtMCNxdbK4ZmwLc/45I8mvkdmxXYpIwRbmK2mE3swWF5j9MA2VSnGb0+bQrs
	gZbjicCYgEIRmwFx90Xh4xxQeReKYxemlHvyAlPiXXbIZOHZgth0+FL1v6GgjRqKfTjKG5GwzxB
	+X7/C9ji8iAPSHdYRM0I00vz3yJ6gYFhvEfJJx1zDYE4PKkULMkT0BFCRZBUk90JhBeJu6bP36U
	ZhK2TkOgyLZ3Hz1ZJftbCJzRNGGSZ16pQzECvz1eaRbtyPNHKnWS+u38ZfURuZ4vpCcKEfec3rJ
	VSadzUYC7mw/mvhY5dEiu0HG6HSNIevO4k4PHJ0TNxdyjF+QDwp9QYNAp8D8zBiHZ0x0Wi/65Dp
	jOsFfvfnYWX8zlj4EDyzDIY0mjCMVWBejGBL+5QsUU4SrIBGs8egN1RlPDPBjV2Vb2RPmQ8L3Yx
	mXXkakC9GPa1HBVemfoCCGJ46RH3eEdcZYRG22NMfaaU+bkVzZqOwC4A4QY97HL7T2z85hhMDTY
	3ceQyq2ZlWGEXL9+l8oa/DtghxoAUYrWZ7HiIWCxjX0EI9ep8CA5vDBKvxXM8BYU+4n/6U7on30
	0IiF0j3MBve/G/TZKBjHnK2f0nzxgRf8bUKtpDmZ9PKFUwhdFKpzp2MHJtaQp3PK3fyIy/nIn7F
	clfrCbUYmmybVlUqPfQBSpLg8l7RL68zJqoGqgL/iK0cla0Q+L2li16FbptxajX9EWYlJV8D4o
X-Received: by 2002:a05:6214:2f0d:b0:919:5a24:d20d with SMTP id 6a1803df08f44-91ca4ae9e0amr221769006d6.11.1793732012134;
        Tue, 03 Nov 2026 10:53:32 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7c7881desm234016d6.29.2026.11.03.10.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:53:31 -0800 (PST)
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
Subject: [PATCH v2 11/20] libselinux: preserve the opened policy version when loading
Date: Tue,  3 Nov 2026 13:52:58 -0500
Message-ID: <20261103185307.45924-11-stephen.smalley.work@gmail.com>
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
 libselinux/tests/.gitignore                 |   3 +-
 libselinux/tests/Makefile                   |   3 +
 libselinux/tests/test_load_policy_version.c | 219 ++++++++++++++++++++
 4 files changed, 226 insertions(+), 2 deletions(-)
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
index 51d18f6d..a699b328 100644
--- a/libselinux/tests/.gitignore
+++ b/libselinux/tests/.gitignore
@@ -8,4 +8,5 @@ test-restorecon-digest
 /test-substitution-hash
 /test-substitution-restorecon
 /test-readable-fallback
-/test-digest-inputs
\ No newline at end of file
+/test-digest-inputs
+/test-load-policy-version
\ No newline at end of file
diff --git a/libselinux/tests/Makefile b/libselinux/tests/Makefile
index cdc395b7..b112523e 100644
--- a/libselinux/tests/Makefile
+++ b/libselinux/tests/Makefile
@@ -55,3 +55,6 @@ test-readable-fallback: test_readable_fallback.c ../src/selinux_config.c ../src/
 
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

