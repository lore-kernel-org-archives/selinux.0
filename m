Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794249283;
	b=W+Lu4+5FzDaOeS375Fpit8zkuKyCqCB8S45WyXS1kj6+S5Ot1otZ52KCD92WLonJG7p0
	 zveCanhySCBjRlj4/2VJQbKwulxoQUXglrnRV8ljBOODTKkPG21QR5LfIFqilaWYV7FuD
	 EslMr2XT8+Ou4KFNJwBbiYocDgC0453ph1TmIW2Wq8r8vw3xb5WfsEZrB6gk1cBwlrPR0
	 8bE04JtXhkwyU8rhGLIS+w4XssuWgdzY9fjrjiDSCjJQkkunSJxxRlbqWi1viGhybqoCA
	 AB9/mqvgc/RL3qrg0CGSOOuRNhLAb2w6+kUvmOMRNWEYn5CQzZ6GHWuWqzh8qRPQa6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794249283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ZRfL0BB/fbXHP304qqvkmlF0LckB4JW6UMlCrqqJgAc=;
	b=DLGsjAr1BgbW8VmVrRd4TCaN8yxVZeQZMxVCoE+LHrOHHKm7tM3mRegQsjQAX412p7rI
	 fSb7cNrC9XT2jNfIvSRILWKmVXBcYPwtkIMDyLcq0d9dP+S1+nuZxI5foTYx3dlqDHP7Q
	 KzVLvnwheH5edFBjnHhcKZbI1aefRX/mGeLzd5nWlFrky8Z9intJjasBvw2C3L4lcIM0S
	 K0VuocKTn10C+tZs8xTvIKf0q72iJbP24NvOIfA4qPPg4/9L1uYgNn9tKGQ1K+pphFIPv
	 ZpdoYYibXzicog1ZiuoNBmJZmravzPuRxmwduT4db1hf0knk8GtZleHLUNlfFpfmR3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dhHt1XWn;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23987606A5C3
	for <selinux@vger.kernel.org>; Mon,  9 Nov 2026 18:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23987606A5C3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dhHt1XWn
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5361e313e63so10872051cf.3
        for <selinux@vger.kernel.org>; Mon, 09 Nov 2026 10:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794249282; x=1794854082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZRfL0BB/fbXHP304qqvkmlF0LckB4JW6UMlCrqqJgAc=;
        b=dhHt1XWnbgTwHoe7zBaVl1ouj+sEKQ6tWGueEl5bamwUsRaFA4Z/AFcz8012+knFKa
         yX/wL1o3362kTgdgKTEP2/hEPuoTOa63qT0Q0n79MVS0cwCDtWMu8Uiqv9/YU86utOf5
         rSHd3vxKUvvr85qCoKV6aGE+YK67ObVyAgMhcl7gJuHQt96P9auJk2CDeE1KycEtWJbW
         LKPvLJpbS6uN2226w9rd8ZkCztGluIIq/iZstOj+JppBtbGd5xZJ2vE+WDto0MEjxqzE
         4Z/RJDU44Sgd1HjbtDPEVebZp6GhPk4QsCsvsxsAekPoE37Pq0HWWmjJj2yrE1lZj2Id
         JfeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794249282; x=1794854082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZRfL0BB/fbXHP304qqvkmlF0LckB4JW6UMlCrqqJgAc=;
        b=EoIz3myR23EDK/wiPbDNva7VSzCLsyuAt3/uyqNTMBPlNU8vED7xgxSNk8nydRA6BK
         gZys94UJaWr3GBlGRumMSrPEGhCONpQTpCx9l/zGdphkkeSgoxhxtfoU5aDZMAXE0Mtt
         IKNX9ZHnskWFUmej15lC0p4d7vgAf8OEtLGB0e2ohTuHE1C+AGneHNCGkjvzpBt6HfoK
         eot0yXnROohWWkgoA9Ggtj9qNMDEjBBj4XscfXcrnzI9U/UFfWylDjzj3Z4cZ8J39/bg
         LQnj0zzRiIBKLGID6UP82vfKqWCVniihjmW7HzFmLS1FeerMEtsx3JDRkUcFpg2uwbg4
         TU+A==
X-Gm-Message-State: APuU4Z/LBXYXZ7vvbwTqLyLB0N/enSvyN67gbBQgxnOnGWFkDhw0R+/+
	N0VS9mh8JoKvPRJ6JDcwT0GVd0rEbyoS0xuUx1E9ml0mA5R6GaFHP3c4oQWoFNjY
X-Gm-Gg: AYBFou2gS9Und0mzmHTkgKqC1n7wyOZj2ORpyp37+M5aY7+1eYnkaCiaJGRoqnVnxJ9
	EI56yfy5FaWAE3TBJl2bV6Pomryvp36c0m/aSTqNY3R/tV7hlRL47dTrzdHAV320q+/i3ZYmtgp
	cPvYeLFc7eOT6OhKEdNIeJ8WNr/e7hhvSo4zqY/JKAd4OCBUrYQSJV0XIT/hKDsefPYa4GqcUJf
	pANicUsXyqHDVqN4Aevhm2O7xIXyoCYLokPWxnlF0+REo+8S2e2lip3NNUt7WFxOeGBFsGKAg48
	MGALFOkBStf8M6NGzmLzV97kpq+FlnsOjZDY0F5s6tFOY6d9G0UNOPx6siuJG/xN1qqimLIX5CV
	RqCFuq8wXI7qRzi5RPhuI3GM2kGf0u2Vx55nE8KuBn6Q6fCk8Cy+lCEstfC6l2W7frtky3pngjI
	KyGtyWHqtMnYbBNIRR3rTd3J44T/kK9/z0xRWdkOdzMetPqq3b8xddOBUaZtNJvXtfGQzTiP/Km
	JYAlgGdB2VIoq4YrI4AdGpDAJjDOGLjAUJjF3vl114TzDaOr2QKMohXe/S9x4dl0nTAQOU6QYMM
	FMCEJUJjdvxTmfmtD0okeFzr4zTQZBNuyV0dun2KLQ5ES4f54GfxhTdySBrGTwTSNf6IPiRrzeq
	4+bIq5JpjAfbzocHxYKGiJsTEcOZ3XbWaeNWixa8mhMVFJT1qh2D0PPXpYKEMT/Fh69v1amMN3c
	k25grI67wfDF/wgCCBr0Yr+z5XComnN84L9MIHs5ZxPeF46Q==
X-Received: by 2002:ac8:5dc8:0:b0:535:a5fb:644c with SMTP id d75a77b69052e-55528bcf160mr2408771cf.70.1794249281857;
        Mon, 09 Nov 2026 10:34:41 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5550af612dfsm3705311cf.8.2026.11.09.10.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 10:34:41 -0800 (PST)
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
Subject: [PATCH] libsemanage: canonicalize NSS homes before deriving their parent
Date: Mon,  9 Nov 2026 13:34:26 -0500
Message-ID: <20261109183427.146748-1-stephen.smalley.work@gmail.com>
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

Apply path substitutions to the complete NSS home directory before
removing its final component. Substituting the parent first misses
rules that match the username, trailing wildcards, and per-user
exceptions to broader equivalences.

For example, /srv -> /canonical followed by /srv/alice -> /srv/special
must retain /srv as a generated home root for Alice. The old ordering
generated only /canonical, while runtime lookup used /srv/special and
could no longer match the generated patterns.

Keep the original-home filters and reject rewritten relative,
root-level, or ignored homes before deriving the parent. Preserve
conflict checks on the canonical parent and leave explicit-user
handling unchanged.

Add a standalone regression covering generated-pattern lookup, rule
order, literal and wildcard mappings, two-stage substitutions, ignored
paths, root guards, failure cleanup, and disabled NSS enumeration.

Fixes: ff54a2d3cdca ("libsemanage/genhomedircon: apply path substitution rules to home directories")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsemanage/src/genhomedircon.c               |  12 +-
 libsemanage/tests/.gitignore                  |   1 +
 libsemanage/tests/Makefile                    |   9 +-
 .../regression/test_genhomedircon_parent.c    | 281 ++++++++++++++++++
 4 files changed, 299 insertions(+), 4 deletions(-)
 create mode 100644 libsemanage/tests/regression/test_genhomedircon_parent.c

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 0b7159bd..b0482f0e 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -590,8 +590,6 @@ static int get_home_dirs(genhomedircon_settings_t *s, semanage_list_t **out)
 			break;
 		}
 
-		semanage_rtrim(path, '/');
-
 		{
 			char *canonical = NULL;
 
@@ -603,9 +601,19 @@ static int get_home_dirs(genhomedircon_settings_t *s, semanage_list_t **out)
 			if (canonical) {
 				free(path);
 				path = canonical;
+				if (path[0] != '/' ||
+				    semanage_str_count(path, '/') <= 1 ||
+				    ignore(path)) {
+					free(path);
+					path = NULL;
+					continue;
+				}
 			}
 		}
 
+		/* Substitutions can match the username component of the home. */
+		semanage_rtrim(path, '/');
+
 		if (!semanage_list_find(homedir_list, path)) {
 			/*
 			 * Now check for an existing file context that matches
diff --git a/libsemanage/tests/.gitignore b/libsemanage/tests/.gitignore
index 47f2f45d..ba101a56 100644
--- a/libsemanage/tests/.gitignore
+++ b/libsemanage/tests/.gitignore
@@ -1,3 +1,4 @@
 libsemanage-tests
 *.policy
+test-genhomedircon-parent
 /test-config-empty
diff --git a/libsemanage/tests/Makefile b/libsemanage/tests/Makefile
index 245c124c..72b86cc7 100644
--- a/libsemanage/tests/Makefile
+++ b/libsemanage/tests/Makefile
@@ -22,15 +22,20 @@ $(EXECUTABLE): $(OBJECTS) ../src/libsemanage.a
 
 clean distclean:
 	rm -rf $(OBJECTS) $(POLICIES) $(EXECUTABLE) test-config-empty
+	rm -f test-genhomedircon-parent
 
-test: all
+test: all test-genhomedircon-parent
 	./$(EXECUTABLE)
 	./test-config-empty
-
+	./test-genhomedircon-parent
 
 test-config-empty: regression/test_config_empty.c ../src/libsemanage.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ -Wl,--wrap=strdup $(LDLIBS)
 
+PARENT_WRAPS = semanage_findval sepol_context_check getpwent setpwent endpwent fopen stat semanage_fcontext_iterate asprintf
+COMMA := ,
+test-genhomedircon-parent: regression/test_genhomedircon_parent.c ../src/genhomedircon.c ../src/path_subs.c ../src/libsemanage.a
+	$(CC) $(CPPFLAGS) $(CFLAGS) -D_GNU_SOURCE -ffunction-sections -fdata-sections $(LDFLAGS) -Wl,--gc-sections -o $@ $< ../src/path_subs.c ../src/libsemanage.a $(addprefix -Wl$(COMMA)--wrap=,$(PARENT_WRAPS)) $(LDLIBS)
 
 # Requires SWIG, Python development headers and the built shared library.
 PYTHON ?= python3
diff --git a/libsemanage/tests/regression/test_genhomedircon_parent.c b/libsemanage/tests/regression/test_genhomedircon_parent.c
new file mode 100644
index 00000000..62312109
--- /dev/null
+++ b/libsemanage/tests/regression/test_genhomedircon_parent.c
@@ -0,0 +1,281 @@
+/* SPDX-License-Identifier: CC0-1.0 */
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+#undef NDEBUG
+#include <assert.h>
+#include <stdarg.h>
+#ifndef GENERATOR_SOURCE
+#define GENERATOR_SOURCE "../../src/genhomedircon.c"
+#endif
+#include GENERATOR_SOURCE
+#include <selinux/label.h>
+
+static const char *home;
+static const char *conflict;
+static unsigned calls, failures;
+static unsigned fail_at, rewrite_calls;
+static bool iterator_error;
+
+char *__wrap_semanage_findval(const char *file, const char *key,
+			      const char *sep);
+char *__wrap_semanage_findval(const char *file, const char *key,
+			      const char *sep)
+{
+	(void)file;
+	(void)sep;
+	return !strcmp(key, "HOME") ? strdup("/home") : NULL;
+}
+
+void __wrap_setpwent(void);
+void __wrap_endpwent(void);
+struct passwd *__wrap_getpwent(void);
+void __wrap_setpwent(void)
+{
+	calls = 0;
+}
+void __wrap_endpwent(void)
+{
+}
+struct passwd *__wrap_getpwent(void)
+{
+	static char directory[256], name[] = "alice", shell[] = "/bin/bash";
+	static struct passwd pw = { .pw_name = name,
+				    .pw_uid = 1000,
+				    .pw_gid = 1000,
+				    .pw_shell = shell,
+				    .pw_dir = directory };
+	assert(strlen(home) < sizeof(directory));
+	strcpy(directory, home);
+	return calls++ == 0 ? &pw : NULL;
+}
+
+FILE *__real_fopen(const char *path, const char *mode);
+FILE *__wrap_fopen(const char *path, const char *mode);
+FILE *__wrap_fopen(const char *path, const char *mode)
+{
+	if (!strcmp(path, PATH_SHELLS_FILE) ||
+	    !strcmp(path, PATH_ETC_LOGIN_DEFS) ||
+	    !strcmp(path, PATH_ETC_LIBUSER)) {
+		FILE *fp = tmpfile();
+		assert(fp);
+		assert(fputs(!strcmp(path, PATH_SHELLS_FILE) ?
+				     "/bin/bash\n" :
+				     "UID_MIN 100\nUID_MAX 60000\n",
+			     fp) >= 0);
+		rewind(fp);
+		return fp;
+	}
+	return __real_fopen(path, mode);
+}
+
+int __wrap_stat(const char *path, struct stat *sb);
+int __real_stat(const char *path, struct stat *sb);
+int __wrap_stat(const char *path, struct stat *sb)
+{
+	if (!strcmp(path, PATH_EXPORT_HOME)) {
+		errno = ENOENT;
+		return -1;
+	}
+	return __real_stat(path, sb);
+}
+
+int __wrap_semanage_fcontext_iterate(semanage_handle_t *sh,
+				     int (*fn)(const semanage_fcontext_t *,
+					       void *),
+				     void *arg);
+int __wrap_semanage_fcontext_iterate(semanage_handle_t *sh,
+				     int (*fn)(const semanage_fcontext_t *,
+					       void *),
+				     void *arg)
+{
+	(void)sh;
+	(void)fn;
+	fc_match_handle_t *match = arg;
+	if (iterator_error)
+		return STATUS_ERR;
+	if (conflict) {
+		assert(!strcmp(match->dir, conflict));
+		match->matched = 1;
+	}
+	return 0;
+}
+
+int __wrap_sepol_context_check(sepol_handle_t *sh, const sepol_policydb_t *p,
+			       const sepol_context_t *c);
+int __wrap_sepol_context_check(sepol_handle_t *sh, const sepol_policydb_t *p,
+			       const sepol_context_t *c)
+{
+	(void)sh;
+	(void)p;
+	(void)c;
+	return 0;
+}
+
+int __wrap_asprintf(char **out, const char *fmt, ...)
+	__attribute__((format(printf, 2, 3)));
+int __wrap_asprintf(char **out, const char *fmt, ...)
+{
+	va_list ap;
+	int rc;
+	if (!strcmp(fmt, "%s%s") && ++rewrite_calls == fail_at) {
+		failures++;
+		errno = ENOMEM;
+		return -1;
+	}
+	va_start(ap, fmt);
+	rc = vasprintf(out, fmt, ap);
+	va_end(ap);
+	return rc;
+}
+
+static void put(const char *path, const char *text)
+{
+	FILE *fp = fopen(path, "we");
+	assert(fp && fputs(text, fp) >= 0 && fclose(fp) == 0);
+}
+
+int main(void)
+{
+	const struct {
+		const char *home, *local, *dist, *parent;
+	} scenarios[] = {
+		{ "/srv/alice", "",
+		  "/srv /canonical\n/srv/alice /srv/special\n", "/srv" },
+		{ "/srv/alice", "", "", "/srv" },
+		{ "/srv/alice/", "", "/srv /canonical\n", "/canonical" },
+		{ "/srv/alice", "", "/srv/alice /canonical/alice\n",
+		  "/canonical" },
+		{ "/srv/team/alice", "", "/srv/* /canonical\n", "/canonical" },
+		{ "/srv/team/alice", "", "/srv/*/alice /canonical/alice\n",
+		  "/canonical" },
+		{ "/srv/alice", "/srv /middle\n", "/middle /canonical\n",
+		  "/canonical" },
+		{ "/srv/alice", "/srv /middle\n",
+		  "/middle/alice /canonical/alice\n", "/canonical" },
+		{ "/srv/alice", "",
+		  "/srv /canonical\n/srv/alice /special/alice\n", "/special" },
+		{ "/srv/alice", "",
+		  "/srv/alice /srv/special\n/srv /canonical\n", "/canonical" },
+		{ "/srv/alice", "", "/srv/alice /\n", NULL },
+		{ "/srv/alice", "", "/srv/alice /alice\n", NULL },
+		{ "/srv/alice", "", "/srv/alice relative\n", NULL },
+		{ "/", "", "", NULL },
+		{ "/alice", "", "", NULL },
+	};
+	semanage_handle_t sh = { 0 };
+	sh.sepolh = sepol_handle_create();
+	assert(sh.sepolh);
+	unsigned cases = 0;
+	for (unsigned i = 0; i < sizeof(scenarios) / sizeof(scenarios[0]);
+	     i++) {
+		char tmp[] = "/tmp/genhomedircon-parent-XXXXXX";
+		char fc[256], local[256], dist[256], key[512];
+		assert(mkdtemp(tmp));
+		snprintf(fc, sizeof(fc), "%s/fc", tmp);
+		snprintf(local, sizeof(local), "%s/fc.subs", tmp);
+		snprintf(dist, sizeof(dist), "%s/fc.subs_dist", tmp);
+		put(local, scenarios[i].local);
+		put(dist, scenarios[i].dist);
+		home = scenarios[i].home;
+		genhomedircon_settings_t s = { .usepasswd = 1,
+					       .h_semanage = &sh };
+		assert(semanage_path_subs_load(&sh, local, &s.local_subs) == 0);
+		assert(semanage_path_subs_load(&sh, dist, &s.dist_subs) == 0);
+		for (unsigned mode = 0; mode < 8; mode++) {
+			semanage_list_t *homes = NULL;
+			char ignored[256];
+			s.usepasswd = mode != 7;
+			conflict = mode == 1 ? scenarios[i].parent : NULL;
+			iterator_error = mode == 4;
+			fail_at = mode == 5 ? 1 : mode == 6 ? 2 : 0;
+			rewrite_calls = failures = 0;
+			if (mode == 2 || mode == 3) {
+				char *canonical = NULL;
+				snprintf(ignored, sizeof(ignored), "%s", home);
+				size_t len = strlen(ignored);
+				while (len > 1 && ignored[len - 1] == '/')
+					ignored[--len] = '\0';
+				if (mode == 3) {
+					assert(semanage_path_subs_canonicalize(
+						       s.local_subs,
+						       s.dist_subs, ignored,
+						       &canonical) == 0);
+					if (canonical)
+						snprintf(ignored,
+							 sizeof(ignored), "%s",
+							 canonical);
+					free(canonical);
+				}
+				assert(ignore_setup(ignored) == 0);
+			}
+			int rc = get_home_dirs(&s, &homes);
+			if (failures ||
+			    (iterator_error && scenarios[i].parent)) {
+				assert(rc == STATUS_ERR && !homes);
+			} else {
+				assert(rc == STATUS_SUCCESS && homes);
+				bool skipped = !scenarios[i].parent ||
+					       mode == 1 || mode == 2 ||
+					       mode == 3 || mode == 7;
+				assert(semanage_list_find(homes, "/home"));
+				if (scenarios[i].parent)
+					assert(!!semanage_list_find(
+						       homes,
+						       scenarios[i].parent) ==
+					       !skipped);
+				for (semanage_list_t *h = homes; h; h = h->next)
+					assert(!strcmp(h->data, "/home") ||
+					       (scenarios[i].parent &&
+						!strcmp(h->data,
+							scenarios[i].parent)));
+				if (!skipped && mode == 0) {
+					FILE *fp = fopen(fc, "we");
+					assert(fp);
+					char template[] =
+						"HOME_ROOT/[^/]+/ssh_key system_u:object_r:ssh_home_t:s0";
+					semanage_list_t tpl = {
+						.data = template
+					};
+					for (semanage_list_t *h = homes; h;
+					     h = h->next)
+						assert(write_home_root_context(
+							       &s, fp, &tpl,
+							       h->data) ==
+						       STATUS_SUCCESS);
+					assert(fclose(fp) == 0);
+					struct selinux_opt opt = {
+						SELABEL_OPT_PATH, fc
+					};
+					struct selabel_handle *labels =
+						selabel_open(SELABEL_CTX_FILE,
+							     &opt, 1);
+					assert(labels);
+					snprintf(key, sizeof(key), "%s/ssh_key",
+						 home);
+					char *context = NULL;
+					assert(selabel_lookup_raw(
+						       labels, &context, key,
+						       S_IFREG) == 0);
+					assert(strstr(context, ":ssh_home_t:"));
+					free(context);
+					selabel_close(labels);
+					assert(unlink(fc) == 0);
+				}
+				semanage_list_destroy(&homes);
+			}
+			ignore_free();
+			cases++;
+		}
+		fail_at = 0;
+		iterator_error = false;
+		conflict = NULL;
+		semanage_path_subs_free(&s.local_subs);
+		semanage_path_subs_free(&s.dist_subs);
+		assert(unlink(local) == 0 && unlink(dist) == 0 &&
+		       rmdir(tmp) == 0);
+	}
+	sepol_handle_destroy(sh.sepolh);
+	printf("genhomedircon canonical parent: %u cases passed\n", cases);
+	return 0;
+}
-- 
2.56.0

