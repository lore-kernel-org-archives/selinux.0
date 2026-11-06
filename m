Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988651;
	b=lrswJxV/94uVf+DSHNLix8qJbQsG/fMQA3wFcGA3XZRzUaqNMkchyUBWZmSR0G7SWfOE
	 MCJvl4oC0HglZbNWHGvI16AXrsPmEFS828uHKa3l23PMCKl0UQ8PtGHfj/S+E3V0bgZLS
	 OYwn92BKiMwesUX5ynn4SBuhLstffe/QHkIoIYHoOMqzBlMD3ifIMvYIiCexPWqh1AUK2
	 uJt5KdoBeLbOHWefJCDGdq+pl4GHD7LeGd37VE0iqZ/bLcyfiXvnnv1eS7Ig/bgh8NKO/
	 okgcQ7P+O3HJWavKUgu+2oWYCBvgxHkuVfDsmTMjFLG6pR/DIQ9QfuMjAf3p7qMDDxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988651;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=rtLgMrbVDDuz9hIc98QOlF3ueGemShrfS4SMfhAS8Cc=;
	b=xNHJXP63GJFXRsa4O9Up8Kh1vrCLyIs0cDu2UunL7sXQRyeQQwLeQ1UNxcOL4kkTyzol
	 6G2lM2+aXY3zwnSnDTeQxltiBzMAQl5wRpLoAAOyOL8CApdpdxbplXvn5gtxv7bHIt45P
	 ayoe7mSoABBMDHIjwH8ilcxqMfggEor3n7HzJghfotBXnP2ZusPMWpLOidz0ytHIl6Eru
	 l5Ga7xy/zzzfJz46XrLlq2Y/cnkVF2A3gSk5Fq8Hk7Q8tS7zzmZ3ZcSxEjwsdGZ/c5NW4
	 gsHsrSfW30wLZLygkJ2ktPaA3aECO2Vk4XOm6sp1x8EDLfgHpX6nxKJPa2HlW5rBmRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="UvlqF/yn";
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A275F606A326
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 18:10:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A275F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UvlqF/yn
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5495d549924so8905821cf.1
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 10:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793988650; x=1794593450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rtLgMrbVDDuz9hIc98QOlF3ueGemShrfS4SMfhAS8Cc=;
        b=UvlqF/ynVIaHu4DYy2MNtaxS9ZihP1VJM8g2GoFwJcj+nLijRYbMx53XappdFIpanF
         aUL89dMPjF2cYZ5KDdtt0AhFq4d8Zj0aGMOC0Da5B8FRSkMY1Y6QMHFwmTY7KU9DuKLJ
         c/MpsLQ37yEr3TEf66jrt2tGDogfRkVm19PU7GtItIwakC2LzV6gDk+xH2b/JSDC08Fk
         HCGbSAZNNGsUrHkYq3Ek1lB1Xze5dkZOsnn0V1EYPL3o0Rd+r2eQK6r1qczU5gm9B1BI
         AhiHkXiK7BHNuCbVzjWLark9HO9onpRzc3drMLZWntHp8HxWqTt9XVuqr7fZTvyPTLeT
         crzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988650; x=1794593450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rtLgMrbVDDuz9hIc98QOlF3ueGemShrfS4SMfhAS8Cc=;
        b=yyEVMqzQ5KeEirwR+982cDnp+aorHmNsflaXawH6YWOcDmQqq4muGkV2rEVEJPqODk
         l/VkenpJouWpKAAV2jqCFBnGRguu3v6PDSzEO91YVikj3mWwR2Ka2gDENeFXnoS0Vvre
         hdWuXVcZP7hnKAr+YCZNRsR5+2ULoRnB7atOjsWVM6YG1PiSufwNsSRZyHODJu54yeaQ
         9+6Z2lH0MVLEsyWZNQ2uj1ggzb6OX3UpusfJTJ2XcVRFDWT5BHvzTAt+8gMsuRNYixQk
         +nAA3KpPo7AIbydPbsbT/mddckumyVK6rOQF9A/Y1ZYGxmSUhKIvK4cZTHvpHqDHjFJK
         Yg6A==
X-Gm-Message-State: APuU4Z9MVLKFD+t3V7VVXJbH4D3N9t5IMO1xIdGEw6IZCVPmwXUw9oh+
	HOKwiNGIJGInlyVGp1rnKw3dMWIJkYFRrL78lHaYY6ucQriHd5u/ql/qaUUgUHS1
X-Gm-Gg: AYBFou2j1nxI8he50r8MxJBkcz2wdbsEpIPr8TGi9Br9PmaUGy917AoHRplQxat3drw
	cveJDxj6rbmI9S9zm2IGjJwLVicB2ugSaU6j7BjIujrnB9547l1sroMtKX3wYMJJ2basXhgqIaM
	ALcPerVoWuPNZtp4Gc9ue/hPBx7FCqLsFVUYKaS59lp+1oe+wqpxnxNZf7yQonlDLU68pibXfyh
	z6X2JLNNplMStjnZwZN8+PnSD02l9UhaZS/mcuf1g5GB0gBUNsPxVGMtJVOG6CJKf/Nc2PJjaHr
	xrbKBS0W3QC2e3nmTqnwCpo8q835QkKq0jY0Y4YwNKl5DPaSyvpvvuIt8DsNs+lqQxhxfoCT54s
	v63YboEwNd9lxc/C50rSWO6puWtDu7Od/EKqN6MgwqpjCuv85hHHNYfMt4OM4b7p79CY6wo05Ix
	/dt15nfTEMlAnd3P4+pgfDBEAiuyOCsQ4pWhGeNgCII+G/ev3cXjy5SyT+I3ActXBp94U8K4rj/
	NHjDG9i2u6sd2O5d2A6U0xVQT3brEGsaqAlNKkR3yIZXvjMTevgSJUlnGTBWcV+KngMp5fHP5MS
	F1kesfbb7lk3O20KM4E4nDnghio1rFQG0TvKAJxB4QlStqJaXAseoM1vhShxwCv9OsTEpSOVH8R
	6KL20egg6Yh3cJKSA1yAR/VM6ZCLdaCiTDok/1jcAm8wyYPmJDdDIr1wupzRWWNkPSvGmD67cKa
	NglQJe2PHsM2WXg4U6A5Upn9ml5YkarlfkkeToi4avDedq9EfY4ac=
X-Received: by 2002:a05:622a:4cca:b0:538:68d:2557 with SMTP id d75a77b69052e-54e1566ba5fmr48880671cf.52.1793988648487;
        Fri, 06 Nov 2026 10:10:48 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ea867655esm23528386d6.37.2026.11.06.10.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:10:48 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Filippo Bonazzi <fbonazzi@suse.de>
Subject: [PATCH] libselinux: apply requested level to failsafe contexts
Date: Fri,  6 Nov 2026 13:10:33 -0500
Message-ID: <20261106181033.252493-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
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

The level-aware context lookup APIs replace the range in the starting
context, which get_context_user() then copies into matching
candidates. When no candidate survives, get_failsafe_context() instead
returns the configured failsafe range unchanged. A NULL starting
context also hits this path when the current role and type have no
matching entry.

Carry the explicitly requested level through an internal list lookup
and apply it to the failsafe context before
security_check_context(). Keep the configured range for ordinary
lookups and preserve the existing ENOENT validation exception. Route
role-and-level lookup through the same level-aware list implementation
so it receives the fix too.

Add 309 regression cases covering all three APIs, explicit and current
starting contexts, per-user/global/missing configuration, rejected
candidates, validation of the final range, and failure/retry at the
new allocation steps. The test uses private configuration files and
wraps getcon and kernel validation; no host policy is changed.

Reported-by: Filippo Bonazzi <fbonazzi@suse.de>
Fixes: https://github.com/SELinuxProject/selinux/issues/508
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/get_context_list.c     |  84 +++++-----
 libselinux/tests/.gitignore           |   1 +
 libselinux/tests/Makefile             |   7 +
 libselinux/tests/test_context_level.c | 221 ++++++++++++++++++++++++++
 4 files changed, 273 insertions(+), 40 deletions(-)
 create mode 100644 libselinux/tests/test_context_level.c

diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
index 289ef89e..06cec418 100644
--- a/libselinux/src/get_context_list.c
+++ b/libselinux/src/get_context_list.c
@@ -13,8 +13,15 @@
 #include "context_internal.h"
 #include "get_context_list_internal.h"
 
-int get_default_context_with_role(const char *user, const char *role,
-				  const char *fromcon, char **newcon)
+static int get_ordered_context_list_internal(const char *user,
+					     const char *fromcon,
+					     const char *level, char ***list);
+
+static int get_default_context_with_role_internal(const char *user,
+						  const char *role,
+						  const char *level,
+						  const char *fromcon,
+						  char **newcon)
 {
 	char **conary;
 	char **ptr;
@@ -22,7 +29,7 @@ int get_default_context_with_role(const char *user, const char *role,
 	const char *role2;
 	int rc;
 
-	rc = get_ordered_context_list(user, fromcon, &conary);
+	rc = get_ordered_context_list_with_level(user, level, fromcon, &conary);
 	if (rc <= 0)
 		return -1;
 
@@ -52,44 +59,19 @@ out:
 	return rc;
 }
 
+int get_default_context_with_role(const char *user, const char *role,
+				  const char *fromcon, char **newcon)
+{
+	return get_default_context_with_role_internal(user, role, NULL, fromcon,
+						      newcon);
+}
+
 int get_default_context_with_rolelevel(const char *user, const char *role,
 				       const char *level, const char *fromcon,
 				       char **newcon)
 {
-	int rc;
-	char *backup_fromcon = NULL;
-	context_t con;
-	const char *newfromcon;
-
-	if (!level)
-		return get_default_context_with_role(user, role, fromcon,
-						     newcon);
-
-	if (!fromcon) {
-		rc = getcon(&backup_fromcon);
-		if (rc < 0)
-			return rc;
-		fromcon = backup_fromcon;
-	}
-
-	rc = -1;
-	con = context_new(fromcon);
-	if (!con)
-		goto out;
-
-	if (context_range_set(con, level))
-		goto out;
-
-	newfromcon = context_str(con);
-	if (!newfromcon)
-		goto out;
-
-	rc = get_default_context_with_role(user, role, newfromcon, newcon);
-
-out:
-	context_free(con);
-	freecon(backup_fromcon);
-	return rc;
+	return get_default_context_with_role_internal(user, role, level,
+						      fromcon, newcon);
 }
 
 int get_default_context(const char *user, const char *fromcon, char **newcon)
@@ -290,7 +272,8 @@ out:
 	return rc;
 }
 
-static int get_failsafe_context(const char *user, char **newcon)
+static int get_failsafe_context(const char *user, const char *level,
+				char **newcon)
 {
 	FILE *fp;
 	char buf[255], *ptr;
@@ -321,6 +304,20 @@ static int get_failsafe_context(const char *user, char **newcon)
 		return -1;
 	}
 
+	/* Validate the context we will return, including any requested range. */
+	if (level) {
+		context_t con = context_new(*newcon);
+		char *leveled = NULL;
+
+		if (con && context_range_set(con, level) == 0)
+			leveled = context_to_str(con);
+		context_free(con);
+		free(*newcon);
+		*newcon = leveled;
+		if (!leveled)
+			return -1;
+	}
+
 	/* If possible, check the context to catch
 	   errors early rather than waiting until the
 	   caller tries to use setexeccon on the context.
@@ -365,7 +362,7 @@ int get_ordered_context_list_with_level(const char *user, const char *level,
 	if (!newfromcon)
 		goto out;
 
-	rc = get_ordered_context_list(user, newfromcon, list);
+	rc = get_ordered_context_list_internal(user, newfromcon, level, list);
 
 out:
 	context_free(con);
@@ -392,6 +389,13 @@ int get_default_context_with_level(const char *user, const char *level,
 
 int get_ordered_context_list(const char *user, const char *fromcon,
 			     char ***list)
+{
+	return get_ordered_context_list_internal(user, fromcon, NULL, list);
+}
+
+static int get_ordered_context_list_internal(const char *user,
+					     const char *fromcon,
+					     const char *level, char ***list)
 {
 	char **reachable = NULL;
 	int rc = 0;
@@ -476,7 +480,7 @@ failsafe:
 		rc = -1;
 		goto out;
 	}
-	rc = get_failsafe_context(user, &reachable[0]);
+	rc = get_failsafe_context(user, level, &reachable[0]);
 	if (rc < 0) {
 		freeconary(reachable);
 		reachable = NULL;
diff --git a/libselinux/tests/.gitignore b/libselinux/tests/.gitignore
index 6cc9309b..ce2c26fc 100644
--- a/libselinux/tests/.gitignore
+++ b/libselinux/tests/.gitignore
@@ -19,3 +19,4 @@ test-restorecon-digest
 /test-avc-lock-failure
 /test-descendant-oom
 /test-regex-context-lifetime
+/test-context-level
diff --git a/libselinux/tests/Makefile b/libselinux/tests/Makefile
index c229e540..531c46df 100644
--- a/libselinux/tests/Makefile
+++ b/libselinux/tests/Makefile
@@ -21,6 +21,11 @@ test-restorecon-errno: test_restorecon_errno.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(ERRNO_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
 
 .PHONY: test clean
+test: test-context-level
+
+test-context-level: test_context_level.c ../src/libselinux.a
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ -Wl,--wrap=getcon,--wrap=security_check_context,--wrap=context_new,--wrap=context_range_set,--wrap=context_to_str $(PCRE_LDLIBS) -ldl -pthread
+
 test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs test-load-policy-version test-auxiliary-duplicates test-android-specfiles test-regex-tls test-policy-root-boundary test-match-limit test-avc-lock-failure test-descendant-oom test-regex-context-lifetime
 	./test-restorecon-digest
 	./test-restorecon-errors
@@ -43,8 +48,10 @@ test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-r
 	./test-avc-lock-failure
 	./test-descendant-oom
 	./test-regex-context-lifetime ../src/libselinux.so.1
+	./test-context-level
 
 clean:
+	rm -f test-context-level
 	rm -f test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs
 	rm -f test-load-policy-version
 	rm -f test-auxiliary-duplicates
diff --git a/libselinux/tests/test_context_level.c b/libselinux/tests/test_context_level.c
new file mode 100644
index 00000000..19e6b436
--- /dev/null
+++ b/libselinux/tests/test_context_level.c
@@ -0,0 +1,221 @@
+#define _GNU_SOURCE
+#include <assert.h>
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <selinux/context.h>
+#include <selinux/get_context_list.h>
+#include <selinux/selinux.h>
+
+int __wrap_getcon(char **con);
+int __wrap_security_check_context(const char *con);
+context_t __wrap_context_new(const char *str);
+context_t __real_context_new(const char *str);
+int __wrap_context_range_set(context_t con, const char *range);
+int __real_context_range_set(context_t con, const char *range);
+char *__wrap_context_to_str(context_t con);
+char *__real_context_to_str(context_t con);
+
+static const char *current_context;
+static const char *expected_range;
+static unsigned int getcon_calls, failsafe_checks, cases;
+static int config_mode, validation_mode, fault, fault_hit;
+
+int __wrap_getcon(char **con)
+{
+	getcon_calls++;
+	*con = strdup(current_context);
+	return *con ? 0 : -1;
+}
+
+int __wrap_security_check_context(const char *str)
+{
+	context_t con = __real_context_new(str);
+	int failsafe;
+
+	assert(con);
+	failsafe = !strcmp(context_type_get(con), "failsafe_t");
+	if (failsafe) {
+		failsafe_checks++;
+		assert(!strcmp(context_range_get(con), expected_range));
+	}
+	context_free(con);
+	if (failsafe && validation_mode) {
+		errno = validation_mode == 1 ? EINVAL : ENOENT;
+		return -1;
+	}
+	if (!failsafe && config_mode == 3) {
+		errno = EINVAL;
+		return -1;
+	}
+	return 0;
+}
+
+context_t __wrap_context_new(const char *str)
+{
+	if (fault == 1 && strstr(str, ":failsafe_t:")) {
+		fault_hit++;
+		errno = ENOMEM;
+		return NULL;
+	}
+	return __real_context_new(str);
+}
+
+int __wrap_context_range_set(context_t con, const char *range)
+{
+	if (fault == 2 && !strcmp(context_type_get(con), "failsafe_t")) {
+		fault_hit++;
+		errno = ENOMEM;
+		return -1;
+	}
+	return __real_context_range_set(con, range);
+}
+
+char *__wrap_context_to_str(context_t con)
+{
+	if (fault == 3 && !strcmp(context_type_get(con), "failsafe_t")) {
+		fault_hit++;
+		errno = ENOMEM;
+		return NULL;
+	}
+	return __real_context_to_str(con);
+}
+
+static void put_file(const char *path, const char *text)
+{
+	FILE *fp = fopen(path, "w");
+
+	assert(fp);
+	assert(fputs(text, fp) >= 0);
+	assert(fclose(fp) == 0);
+}
+
+static void check_result(const char *str, int fallback)
+{
+	context_t con = __real_context_new(str);
+
+	assert(con);
+	assert(!strcmp(context_user_get(con), "test_u"));
+	assert(!strcmp(context_role_get(con), "session_r"));
+	assert(!strcmp(context_range_get(con), expected_range));
+	assert((strcmp(context_type_get(con), "failsafe_t") == 0) == fallback);
+	context_free(con);
+}
+
+static void run_case(int api, const char *level, const char *from, int fallback)
+{
+	char *sentinel = (char *)&cases;
+	char *one = sentinel;
+	char **list = (char **)&cases;
+	int rc, failure = fallback && (validation_mode == 1 || fault);
+
+	getcon_calls = failsafe_checks = fault_hit = 0;
+	if (api == 0)
+		rc = get_ordered_context_list_with_level("test_u", level, from,
+							 &list);
+	else if (api == 1)
+		rc = get_default_context_with_level("test_u", level, from,
+						    &one);
+	else
+		rc = get_default_context_with_rolelevel("test_u", "session_r",
+							level, from, &one);
+	assert(getcon_calls == (from == NULL));
+	assert(fault_hit == (fault != 0));
+	assert(failsafe_checks == (unsigned int)(fallback && !fault));
+	if (failure) {
+		assert(rc == -1);
+		assert(one == sentinel && list == (char **)&cases);
+	} else if (api == 0) {
+		assert(rc == (fallback ? 1 : 2));
+		for (int i = 0; i < rc; i++)
+			check_result(list[i], fallback);
+		assert(list[rc] == NULL);
+		freeconary(list);
+	} else {
+		assert(rc == 0);
+		check_result(one, fallback);
+		freecon(one);
+	}
+	cases++;
+}
+
+int main(void)
+{
+	char root[] = "/tmp/selinux-context-level-XXXXXX";
+	char contexts[256], users[256], user[256], defaults[256], failsafe[256];
+	const char *entries =
+		"source_r:source_t:s0 session_r:normal_t:s0 session_r:other_t:s0\n";
+
+	assert(mkdtemp(root));
+	assert(snprintf(contexts, sizeof(contexts), "%s/contexts", root) > 0);
+	assert(snprintf(users, sizeof(users), "%s/contexts/users", root) > 0);
+	assert(snprintf(user, sizeof(user), "%s/contexts/users/test_u", root) >
+	       0);
+	assert(snprintf(defaults, sizeof(defaults),
+			"%s/contexts/default_contexts", root) > 0);
+	assert(snprintf(failsafe, sizeof(failsafe),
+			"%s/contexts/failsafe_context", root) > 0);
+	assert(mkdir(contexts, 0700) == 0);
+	assert(mkdir(users, 0700) == 0);
+	assert(selinux_set_policy_root(root) == 0);
+	put_file(failsafe, "session_r:failsafe_t:s0\n");
+
+	for (config_mode = 0; config_mode < 4; config_mode++) {
+		put_file(user, config_mode == 0 ? entries : "");
+		put_file(defaults,
+			 config_mode == 1 || config_mode == 3 ? entries : "");
+		for (int api = 0; api < 3; api++)
+			for (int source = 0; source < 4; source++)
+				for (int leveled = 0; leveled < 2; leveled++)
+					for (validation_mode = 0;
+					     validation_mode < 3;
+					     validation_mode++) {
+						int fallback = source >= 2 ||
+							       config_mode >= 2;
+						current_context =
+							source < 2 ?
+								"old_u:source_r:source_t:s0:c2" :
+								"old_u:unmatched_r:unmatched_t:s0:c2";
+						expected_range =
+							leveled ?
+								"s0:c7" :
+								(fallback ?
+									 "s0" :
+									 "s0:c2");
+						run_case(
+							api,
+							leveled ? "s0:c7" :
+								  NULL,
+							source % 2 ?
+								NULL :
+								current_context,
+							fallback);
+					}
+	}
+
+	config_mode = 2;
+	validation_mode = 0;
+	current_context = "old_u:unmatched_r:unmatched_t:s0:c2";
+	expected_range = "s0:c7";
+	for (int api = 0; api < 3; api++)
+		for (int failure = 1; failure <= 3; failure++) {
+			fault = failure;
+			run_case(api, "s0:c7", NULL, 1);
+			fault = 0;
+			run_case(api, "s0:c7", NULL, 1);
+		}
+
+	assert(unlink(user) == 0);
+	assert(unlink(defaults) == 0);
+	for (int api = 0; api < 3; api++)
+		run_case(api, "s0:c7", NULL, 1);
+	assert(unlink(failsafe) == 0);
+	assert(rmdir(users) == 0);
+	assert(rmdir(contexts) == 0);
+	assert(rmdir(root) == 0);
+	printf("PASS %u context-level cases\n", cases);
+	return 0;
+}
-- 
2.56.0

