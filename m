Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732016;
	b=I74Yg89f766MUhEeOw/JBQ71suc16y00i2SSgZjmp3nKC/guD+t/+UnI2jpOUqqtddEC
	 nd1mN9P7TPMlnZ+T3ZxMrAb8xkCaijFY8GQ0d43cF7gg/QnyAqKE4XbJsq0vjBHdd8NPo
	 dtnD80uLXWPF+z6+eAoI7uI0AgESjuMBJEVu02xKPbh5GSknWG3MeRt4gAIIvDP/O7L0B
	 pFZFUSFBQvFdE5xGz8e6xwQF2UMBQS8URy2cTpHJS0/hWS5aRYo04lxeeMUkwmeKUFrt7
	 QJCH+AZehdbSrWtqzOoSvMTEL29Lqd+XzALngMG8rzAQGjXhFcTbcwPR/5YNlQ+91ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732016;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ElUMVIollMbe76XGsvOZfIViVgVmmAC5eH2eZIiXv8k=;
	b=TF9GPQJ0cmrMmx7kvnt/SqYyWHa0N4kQU+5IVjYF4gZLe8hzF/6CLLQ5Sr24RoBAzlXl
	 mtcNaC0Dshf0GJTwGi7BmxpD9oSCaOvtl5qDulbSdwC4MpI4qc2mXIprEsJoM2pg9i9Xi
	 /fM51bboMIKDzy3eKWRFOHZszrvIorstb41cZz9yhMinFzfUuMd2H3PAbEYJblXbS13To
	 OdGQ+JUvebUDJ2/QseLi1FewS/beu7rtnL1C+nxQXUlmVAZixZpf1FC4ajHfmDXzKJnJh
	 oF3eo3bHJLk5Lnw3JgCeWoHc5R1yj1fSPxHFtTJuEV+0fiETS4rtwxkaE0buxZ8DG1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YC8MSbtn;
	arc=none smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB8E606A329
	for <selinux@vger.kernel.org>; Tue,  3 Nov 2026 18:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BB8E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YC8MSbtn
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91c847584b8so13070576d6.0
        for <selinux@vger.kernel.org>; Tue, 03 Nov 2026 10:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793732015; x=1794336815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ElUMVIollMbe76XGsvOZfIViVgVmmAC5eH2eZIiXv8k=;
        b=YC8MSbtnA4gaNto4yBRTKCMUeDKXGidw51Ae0Q5fKc4Uaqy2aoyuJRoLToSGNCcEYO
         UMhvZpE9DnZTsLlJHJoUgFp79aB1hyndhbxIe6YLkYzGezQwXGepipYvFxTtEVhgT33T
         60OCErlq/COwo13eJm1rwA5+M8f6Hg8aeH20d2IjeOqaMJwQkoNemtoP0kwIpN95s+zR
         LV4qXEBjeQm6ydfqO1bgPkXn/6/6bUFJFGtc7X9RHyb1PvXKsLQQZM2NmpU2RPX7cClE
         DGGs9jVJeBjRwctWXEtXU2TyteF0Y2Ta+bR2semO3B2R8YLwYq1ttKRkZb2WBlKF4Ia7
         /lmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732015; x=1794336815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ElUMVIollMbe76XGsvOZfIViVgVmmAC5eH2eZIiXv8k=;
        b=IAvqeFV2LZrWiCEKKs0Y+RxsSbMkqo8mJpKNAEWbuljlyWsEVBdy1E7ffzU9IZPuar
         utAp2WL820MUB5MlGSpGCDkyAPGZ0sRIsdx2KElzyzdSclAJn8G9p0Sm/lE3vzlISa8g
         76xJV4RhUyYiydzhIo9vNrjlFkxtityg9R1dDT3Pv5I5MfWicrR0IqYy4MyQiHvNwqGJ
         IwiQJfP/eVgBFytPJYRRuigKh2pOqFK5hLeN4GUlIFkmBMoLkYBpmL7T1r1ulSpjgHS2
         U+eAM5S2MA9F8DWdp2vgyYFiGCTMDURHrLPO4EYYnAvE6snE93TyJOCnEpk0fmm4JCs5
         2bWQ==
X-Gm-Message-State: APuU4Z9p12AmzdBfBG/4LPRwmXz7R6AeHnmO3iw6HDYUvQgvjT/oNv85
	KEZTlJqBnWbbUTJntsYGNxRctVC1AdrPPStpMECILRBuaKD6/0aW7SJkb0J5bK24
X-Gm-Gg: AYBFou0CrgLe7BSzn3FnH6qu3IxDjHSDK3FjbY4pVmUoZ9Lh7QNWDDmoa6s32AnMwwA
	taV9fd2xMVAQGJL2y1JBOR8aGlaawwoq+vweiNE+lhRP7G4B48hovTEQmTaCWx6sKARaoeAmxzz
	EUr3PsPX+iWZNonxeGnZ+QVB+TXChbE7tz1Zx43093nxv8pV2bi+AQNomfFnjPLo3wIic5YEFlc
	++sGAlGg9nGB4pAZ9045Qqei3LWtsZGB7daKoylDvJcOOPQJ0O/aoTQpkp4r/7jIC4JkZO+F3vz
	s8WZxRwVXtihQPhsNdXQNo9rGOZhR1/jBQoLgApkmGydfhmmSURBI3pnPxeMm3BNX/k8Wp139Em
	UIM+cL4KqnnhCAe3d6oLhgYQdJuEnydDX7Uak1gx4HNx7ybekV+aFBq5fFIQZV47yM/GhFGmo4H
	FLPynnXKLzY5kNxQUxB3fsHJ0WPnlfrpE9yDWrRwVvlkgLKyvua5PQUrImPlYT8hI/wgAhN+sh4
	gvgmpafr6GJy7ZPlxdzSCbBHY34Q5wBiBmqJF/WwDcsFeSyhDjRg4qy9RXxSqGLbi1AUSlL2hC5
	/Axtgr/3k8ihjsR2mUWb6HCS/LlWB0LaBzk0vXsF1Rvgw4m95Gfw+ehlCiJf3oMFggX36UKj++Y
	sb3aX8fIoiA36vbe7Ks0avY9lfc9wRg0G0+1SjzKzC/XPb4bevlcgiyXggT2bdkc7s/enuIX3TK
	iBowz8KZN1gEYe+h7I13I/IdRh0FlIc7XM67UnHCYRb7U5MvP6NLs=
X-Received: by 2002:a05:6214:ccd:b0:91e:73eb:1fa8 with SMTP id 6a1803df08f44-91e73eb21e2mr27829166d6.11.1793732015245;
        Tue, 03 Nov 2026 10:53:35 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7c7881desm234016d6.29.2026.11.03.10.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:53:35 -0800 (PST)
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
Subject: [PATCH v2 16/20] libselinux: require a component boundary when remapping policy roots
Date: Tue,  3 Nov 2026 13:53:03 -0500
Message-ID: <20261103185307.45924-16-stephen.smalley.work@gmail.com>
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

A string-prefix match alone treats paths under targeted.backup or targeted2
as descendants of a selected targeted policy root. When the requested file
is missing, fallback helpers can silently open a file in another policy tree,
including explicit paths supplied to labeling backends.

Require a slash or end of string after the matched root. Preserve fallback
for exact roots and proper descendants, and primary-file precedence.
Test open, fopen, resolver and media lookups with private configuration
roots, missing and present primary files, compiled siblings and explicit
root selection.

Fixes: 6522265a4b87 ("libselinux: add a configuration-root search list")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/selinux_config.c              |   2 +
 libselinux/tests/.gitignore                  |   1 +
 libselinux/tests/Makefile                    |   7 +-
 libselinux/tests/test_policy_root_boundary.c | 118 +++++++++++++++++++
 4 files changed, 127 insertions(+), 1 deletion(-)
 create mode 100644 libselinux/tests/test_policy_root_boundary.c

diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index 17dd4085..6c942b6b 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -554,6 +554,8 @@ static int selinux_policy_remap(const char *path, const char *root, char *out,
 	plen = strlen(selinux_policyroot);
 	if (strncmp(path, selinux_policyroot, plen) != 0)
 		return -1;
+	if (path[plen] != '/' && path[plen] != '\0')
+		return -1;
 	if ((size_t)snprintf(out, outlen, "%s%s", root, path + plen) >= outlen)
 		return -1;
 	return 0;
diff --git a/libselinux/tests/.gitignore b/libselinux/tests/.gitignore
index 5361f4f6..3a8f0706 100644
--- a/libselinux/tests/.gitignore
+++ b/libselinux/tests/.gitignore
@@ -14,3 +14,4 @@ test-restorecon-digest
 /test-android-specfiles
 /*.o
 /test-regex-tls
+/test-policy-root-boundary
diff --git a/libselinux/tests/Makefile b/libselinux/tests/Makefile
index 02e9b594..2e6b9823 100644
--- a/libselinux/tests/Makefile
+++ b/libselinux/tests/Makefile
@@ -21,7 +21,7 @@ test-restorecon-errno: test_restorecon_errno.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(ERRNO_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
 
 .PHONY: test clean
-test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs test-load-policy-version test-auxiliary-duplicates test-android-specfiles test-regex-tls
+test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs test-load-policy-version test-auxiliary-duplicates test-android-specfiles test-regex-tls test-policy-root-boundary
 	./test-restorecon-digest
 	./test-restorecon-errors
 	./test-restorecon-errno
@@ -38,6 +38,7 @@ test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-r
 	./test-android-specfiles
 	$(PYTHON) test_policy_open.py
 	./test-regex-tls
+	./test-policy-root-boundary
 
 clean:
 	rm -f test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs
@@ -45,6 +46,7 @@ clean:
 	rm -f test-auxiliary-duplicates
 	rm -f test-android-specfiles android-label.o android-backend.o
 	rm -f test-regex-tls
+	rm -f test-policy-root-boundary
 
 test-restorecon-exclude: test_restorecon_exclude.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(EXCLUDE_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
@@ -83,3 +85,6 @@ test-android-specfiles: test_android_specfiles.c android-label.o android-backend
 
 test-regex-tls: test_regex_tls.c ../src/libselinux.a
 	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ -Wl,--wrap=pthread_setspecific,--wrap=pthread_key_create,--wrap=pcre2_match_data_create_8,--wrap=pcre2_match_data_create_from_pattern_8,--wrap=pcre2_match_data_free_8 $(PCRE_LDLIBS) -ldl -pthread
+
+test-policy-root-boundary: test_policy_root_boundary.c ../src/selinux_config.c ../src/libselinux.a
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $< ../src/libselinux.a $(PCRE_LDLIBS) -ldl -pthread
diff --git a/libselinux/tests/test_policy_root_boundary.c b/libselinux/tests/test_policy_root_boundary.c
new file mode 100644
index 00000000..d0e758e5
--- /dev/null
+++ b/libselinux/tests/test_policy_root_boundary.c
@@ -0,0 +1,118 @@
+#define _GNU_SOURCE
+#include <assert.h>
+#include <sys/stat.h>
+#include <selinux/label.h>
+/* Install isolated roots without changing the host configuration. */
+#include "../src/selinux_config.c"
+
+static void put(const char *path, const char *type)
+{
+	FILE *fp = fopen(path, "we");
+	assert(fp);
+	assert(fprintf(fp, "disk system_u:object_r:%s:s0\n", type) > 0);
+	assert(fclose(fp) == 0);
+}
+
+static void check(const char *path, const char *expected, const char *resolved)
+{
+	char text[128], actual[PATH_MAX];
+	int fd = selinux_policy_open(path, O_RDONLY | O_CLOEXEC);
+	if (expected) {
+		assert(fd >= 0);
+		ssize_t n = read(fd, text, sizeof(text) - 1);
+		assert(n > 0);
+		text[n] = '\0';
+		assert(strstr(text, expected));
+		assert(close(fd) == 0);
+	} else
+		assert(fd == -1 && errno == ENOENT);
+	FILE *fp = selinux_policy_fopen(path, "re");
+	if (expected) {
+		assert(fp && fgets(text, sizeof(text), fp));
+		assert(strstr(text, expected) && fclose(fp) == 0);
+	} else
+		assert(!fp && errno == ENOENT);
+	int rc = selinux_policy_resolve(path, NULL, actual, sizeof(actual));
+	if (expected)
+		assert(rc == 0 && !strcmp(actual, resolved));
+	else
+		assert(rc == -1 && errno == ENOENT && !strcmp(actual, path));
+	struct selinux_opt opt = { SELABEL_OPT_PATH, path };
+	struct selabel_handle *h = selabel_open(SELABEL_CTX_MEDIA, &opt, 1);
+	if (expected) {
+		char *context = NULL;
+		assert(h && selabel_lookup_raw(h, &context, "disk", 0) == 0);
+		assert(strstr(context, expected));
+		freecon(context);
+		selabel_close(h);
+	} else
+		assert(!h && errno == ENOENT);
+}
+
+int main(void)
+{
+	char tmp[] = "/tmp/selinux-root-boundary-XXXXXX";
+	char admin[256], vendor[256], adir[512], vdir[512];
+	char path[600], alt[600], resolved[600];
+	const char *suffixes[] = { "", ".backup", "2", "-other" };
+	unsigned cases = 0;
+	assert(mkdtemp(tmp));
+	snprintf(admin, sizeof(admin), "%s/admin", tmp);
+	snprintf(vendor, sizeof(vendor), "%s/vendor", tmp);
+	assert(selinux_set_policy_root(admin) == 0);
+	selinux_policyroots[1] = strdup(vendor);
+	assert(selinux_policyroots[1]);
+	/* Exact roots and descendants qualify; sibling names and ancestors do not. */
+	assert(selinux_policy_remap(admin, vendor, resolved,
+				    sizeof(resolved)) == 0);
+	assert(!strcmp(resolved, vendor));
+	assert(selinux_policy_remap(tmp, vendor, resolved, sizeof(resolved)) ==
+	       -1);
+	assert(selinux_policy_remap("", vendor, resolved, sizeof(resolved)) ==
+	       -1);
+	cases += 3;
+	for (unsigned i = 0; i < 4; i++) {
+		snprintf(adir, sizeof(adir), "%s%s", admin, suffixes[i]);
+		snprintf(vdir, sizeof(vdir), "%s%s", vendor, suffixes[i]);
+		assert(mkdir(adir, 0700) == 0 && mkdir(vdir, 0700) == 0);
+		snprintf(path, sizeof(path), "%s/media", adir);
+		snprintf(alt, sizeof(alt), "%s/media", vdir);
+		put(alt, "vendor_t");
+		check(path, i ? NULL : "vendor_t", alt);
+		cases++;
+		assert(unlink(alt) == 0);
+		check(path, NULL, NULL);
+		cases++;
+		/* A compiled sibling can only establish existence inside the root. */
+		strcat(alt, ".bin");
+		put(alt, "vendor_t");
+		int rc = selinux_policy_resolve(path, ".bin", resolved,
+						sizeof(resolved));
+		alt[strlen(alt) - 4] = '\0';
+		if (i)
+			assert(rc == -1 && errno == ENOENT &&
+			       !strcmp(resolved, path));
+		else
+			assert(rc == 0 && !strcmp(resolved, alt));
+		cases++;
+		strcat(alt, ".bin");
+		assert(unlink(alt) == 0);
+		alt[strlen(alt) - 4] = '\0';
+		put(alt, "vendor_t");
+		put(path, "admin_t");
+		check(path, "admin_t", path);
+		cases++;
+		assert(unlink(path) == 0 && unlink(alt) == 0);
+		assert(rmdir(adir) == 0 && rmdir(vdir) == 0);
+	}
+	assert(mkdir(vendor, 0700) == 0);
+	snprintf(path, sizeof(path), "%s/media", admin);
+	snprintf(alt, sizeof(alt), "%s/media", vendor);
+	put(alt, "vendor_t");
+	assert(selinux_set_policy_root(admin) == 0);
+	check(path, NULL, NULL);
+	cases++;
+	assert(unlink(alt) == 0 && rmdir(vendor) == 0 && rmdir(tmp) == 0);
+	printf("policy-root-boundary: %u scenarios passed\n", cases);
+	return 0;
+}
-- 
2.56.0

