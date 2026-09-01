Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C048843C7C4
	for <selinux@vger.kernel.org>; Tue,  1 Sep 2026 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788277786; cv=none; b=ckaNySJG9A56FBjtrEQSgldl6OKlm2COxF3J1/TaG7Kz3bAH4nT3mcoXTgC7lRR8yHg6tuoeUv2FQbfnNhDTPHgRVGZbtw24NNhtvaa4AkKSuRuvyhMCc6/B5qaU3JT5Aof1a2jnjHNdRM1wsrWksCPWBh97Zo8ffZya6RiK+q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788277786; c=relaxed/simple;
	bh=apv2DUzru931X/7N/OTgXc0gnmThs1Bj2ABwFFndSqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gnKYk8rwm2JqXIOY/y0F2VmkdFb6FSo+hc7Qv/RUrPYuOmtMsGD+JQ96RkXsGMdTIQqWmTo+q6QuFXQEy9El25Fs+oiXyldYDNuStoPFaShLH8cUBknkp3iJhWZADg+DwjMr09kdPMq9IUSDfq63U+Qb1lwuTvX+9HEn7hMjHAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlZgh9gB; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlZgh9gB"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-90cdffe8e3eso11034526d6.2
        for <selinux@vger.kernel.org>; Tue, 01 Sep 2026 08:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788277783; x=1788882583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iRqw0Qk4akgH3ZqEtLCe6Ct+qCS3tehzIAd4GMPEcmA=;
        b=jlZgh9gBmisb0vqwHQE82oUo9JWU1jio0iN6gGZgLqDadcPcf5YgcllMwNgMEkyo1S
         wBO/RQmdQYdAz/WjYvVr4mY67Y8nK9mq8z+B5/jUbwP2hzZhtaUq0Qc67mtvu6/z73Uy
         ms3ZYB48wnFvQlSJw0UIbcDTtQ42epkVSvYJlJwvtot7NV5ek5WyZ+KfpGmPbl7k1e7+
         rqIn60jxiDnfHzmguP+Liq1QmMJVWmwxe68r61PA3f3LwrXvDvdASq1fc4NrCWL92fo2
         HEgeUAGrVCvepWdk7b9dSrGhY1E2v+DXcMbnAPM3D3yNQoAG6ywYISiJHF22hNTwoF2p
         m4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788277783; x=1788882583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iRqw0Qk4akgH3ZqEtLCe6Ct+qCS3tehzIAd4GMPEcmA=;
        b=oRipOZ/JbUqxFAJ6j97CGKGRTCuoIxTS2j9dkjtwNKM9Vm7s71TzGxjOUWxiL2T9HN
         fwQaSwHLEBfn5FEEiS8r4UYG+SbbhbnMBW4CbEDv/E6mh8vhz+1mvwMkZRYM0/BZKP0/
         FiYC5Ka1M8rJNoXbN0//xJgNnAZmjBDAds5y+VdigPKx6sy0INeNmjjcXWAJdnfpQDWR
         Ud98oNV0CtRkWgddWTj1wLS3G/lQy1I7rF57zbDf4APE2t+srXGzF8MeWOS6bs+VRj2D
         0i6GR4FvXd6gqlq4xkYVGP0jiJIiBIwsM+IOeWla0HMd75YJ2jizm4o8E+QyhEofNe9F
         Dzyg==
X-Gm-Message-State: AFuF++kY8ctb4YJQBwT0A75mCZzLiwtbCjAYWSiPpkuCw1aM2uOzMamK
	6/HOANtIYnLHgZtsc9pAye81pD1mWhpbwGYKRz0sSyFwDgnbjwlYxMLW++4DEA==
X-Gm-Gg: AR+sD12j6xMn6yF/sfoySN/1pUBs9gDyJqlDqa016VMcR/iZEooCtuFp7GuVi3CifUC
	2rcyydvubqx5EvoIyYLkHlojTUdgL8epDZi3e0veCSoy6obBdiZPSjnLXPPSfLdfv2RpDrDqb5c
	3ylSvlEmGMkKFEe0Mu4IbmhBZeteT+IbCHte8rErua2nbMOL+PLYp4B3ivsV7UD6F06b21MiG3U
	ICElk8CPrRLyWMrQkUDVzwMyP15vEVcUXFmbR7wgXefMGMUQsnY/o66IsZvtng0vc03NmhHSsrB
	vd4ZWgNThFMvSXLw3CKSlq0OmK9stVp4vKHvem0pTf4tHUN8f4sOaLrTahMxWXqfeJC2S3y9UbF
	SS/h9adFgUsH1b/i+dbyZhm1KExpV6bFos/pltSGVwuQUPP0ndb56+K71JOpE8btcgZIOD/s0rQ
	9rYGy8NVg7vQYVg+ekOEmwoqsLCGC0vH+NsyLU/NGtMyAM9/5OAQRwur2MP4244osYfYYCcXJ4k
	SKEk3KIGSHltJi/3dNaHlT4CH6vfycixnVO4qCuo47iAeJX3eGF7u17IN49eTKt
X-Received: by 2002:a05:620a:1a1f:b0:937:37d4:5dbb with SMTP id af79cd13be357-9391390a280mr4183063185a.27.1788277783367;
        Tue, 01 Sep 2026 08:49:43 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939173db029sm1047209785a.35.2026.09.01.08.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:49:42 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/4] libselinux: add a configuration-root search list
Date: Tue,  1 Sep 2026 11:43:05 -0400
Message-ID: <20260901154307.41844-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901154307.41844-2-stephen.smalley.work@gmail.com>
References: <20260901154307.41844-2-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently every runtime file libselinux consumes -- the config file,
policy.NN, contexts/*, seusers, etc -- is looked up under a single
hard-coded root, SELINUXDIR = "/etc/selinux". On a hermetic-/usr or
factory-reset system where /etc is empty at boot, neither
is_selinux_enabled() nor selinux_mkload_policy() find anything and the
box comes up with SELinux disabled.

Introduce an ordered list of configuration roots:

    /etc/selinux    /run/selinux    /usr/lib/selinux

(where the tail is overriddable at build time via
-DSELINUXFALLBACKDIRS=...)  and the internal helpers to search it:

    selinux_confdirs[] - the raw root list, for constructor use
    selinux_policy_roots() - <root>/<SELINUXTYPE> for each root
    selinux_policy_fopen(), selinux_policy_open() - fopen() the accessor
    			    path, remapping the selinux_policy_root()
			    prefix through the fallback roots on ENOENT.

The existing selinux_*_path() accessors continue to return the primary
(/etc-based) path unconditionally so that callers doing pointer
arithmetic against selinux_policy_root() - notably
semanage_init_final_suffix() - keep working. The search is applied
where the file is actually opened; those call sites are converted in
the following patches.

selinux_getenforcemode(), init_selinux_config() and the constructor
has_selinux_config check now try each root in turn for the config
file. selinux_set_policy_root() populates only [0], disabling the
fallback search when an explicit root is in effect.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/init.c             |  12 ++-
 libselinux/src/selinux_config.c   | 121 ++++++++++++++++++++++++++++--
 libselinux/src/selinux_internal.h |  30 ++++++++
 3 files changed, 155 insertions(+), 8 deletions(-)

diff --git a/libselinux/src/init.c b/libselinux/src/init.c
index 1a377a0f..63b49731 100644
--- a/libselinux/src/init.c
+++ b/libselinux/src/init.c
@@ -103,6 +103,10 @@ static void init_lib(void) __attribute__((constructor));
 static void init_lib(void)
 {
 	long page_size;
+#ifndef ANDROID
+	unsigned int i;
+	char cfg[PATH_MAX];
+#endif
 
 	SELINUX_PROTECT_ERRNO;
 	page_size = sysconf(_SC_PAGE_SIZE);
@@ -112,7 +116,13 @@ static void init_lib(void)
 				    4096;
 	init_selinuxmnt();
 #ifndef ANDROID
-	has_selinux_config = (access(SELINUXCONFIG, F_OK) == 0);
+	for (i = 0; selinux_confdirs[i]; i++) {
+		snprintf(cfg, sizeof(cfg), "%sconfig", selinux_confdirs[i]);
+		if (access(cfg, F_OK) == 0) {
+			has_selinux_config = 1;
+			break;
+		}
+	}
 #endif
 }
 
diff --git a/libselinux/src/selinux_config.c b/libselinux/src/selinux_config.c
index 8a0b8c1a..af1f9bfe 100644
--- a/libselinux/src/selinux_config.c
+++ b/libselinux/src/selinux_config.c
@@ -9,6 +9,7 @@
 #include <unistd.h>
 #include <pthread.h>
 #include <errno.h>
+#include <fcntl.h>
 #include "policy.h"
 #include "selinux_internal.h"
 #include "get_default_type_internal.h"
@@ -59,6 +60,11 @@
 static pthread_once_t once = PTHREAD_ONCE_INIT;
 static void init_selinux_config(void);
 
+/* Ordered configuration-root search list; see selinux_internal.h */
+const char *const selinux_confdirs[] = { SELINUXDIR, SELINUXFALLBACKDIRS,
+					 NULL };
+#define NCONFDIRS (sizeof(selinux_confdirs) / sizeof(selinux_confdirs[0]) - 1)
+
 /* New layout is relative to SELINUXDIR/policytype. */
 static char *file_paths[NEL];
 #define L1(l) L2(l)
@@ -84,6 +90,21 @@ static const uint16_t file_path_suffixes_idx[NEL] = {
 #undef L1
 #undef L2
 
+static FILE *open_selinux_config(void)
+{
+	char path[PATH_MAX];
+	FILE *fp;
+	unsigned int i;
+
+	for (i = 0; selinux_confdirs[i]; i++) {
+		snprintf(path, sizeof(path), "%sconfig", selinux_confdirs[i]);
+		fp = fopen(path, "re");
+		if (fp || errno != ENOENT)
+			return fp;
+	}
+	return NULL;
+}
+
 int selinux_getenforcemode(int *enforce)
 {
 	FILE *cfg = fopen(SELINUXCONFIG, "re");
@@ -149,6 +170,14 @@ static int setpolicytype(const char *type)
 
 static char *selinux_policyroot = NULL;
 
+/*
+ * <confdir><policytype> for each entry in selinux_confdirs[], plus a
+ * trailing NULL. [0] is aliased by selinux_policyroot. When
+ * selinux_set_policy_root() has been called the search is disabled and
+ * only [0] is populated (with the caller-supplied root).
+ */
+static char *selinux_policyroots[NCONFDIRS + 1];
+
 static void init_selinux_config(void)
 {
 	int i, *intptr;
@@ -160,7 +189,7 @@ static void init_selinux_config(void)
 	if (selinux_policyroot)
 		return;
 
-	fp = fopen(SELINUXCONFIG, "re");
+	fp = open_selinux_config();
 	if (fp) {
 		__fsetlocking(fp, FSETLOCKING_BYCALLER);
 		while ((len = getline(&line_buf, &line_len, fp)) > 0) {
@@ -224,9 +253,11 @@ static void init_selinux_config(void)
 	if (!selinux_policytype && setpolicytype(SELINUXDEFAULT) != 0)
 		return;
 
-	if (asprintf(&selinux_policyroot, "%s%s", SELINUXDIR,
-		     selinux_policytype) == -1)
-		return;
+	for (i = 0; selinux_confdirs[i]; i++)
+		if (asprintf(&selinux_policyroots[i], "%s%s",
+			     selinux_confdirs[i], selinux_policytype) == -1)
+			return;
+	selinux_policyroot = selinux_policyroots[0];
 
 	for (i = 0; i < NEL; i++)
 		if (asprintf(&file_paths[i], "%s%s", selinux_policyroot,
@@ -239,8 +270,12 @@ static void fini_selinux_policyroot(void) __attribute__((destructor));
 
 static void fini_selinux_policyroot(void)
 {
-	int i;
-	free(selinux_policyroot);
+	unsigned int i;
+
+	for (i = 0; i < NCONFDIRS; i++) {
+		free(selinux_policyroots[i]);
+		selinux_policyroots[i] = NULL;
+	}
 	selinux_policyroot = NULL;
 	for (i = 0; i < NEL; i++) {
 		free(file_paths[i]);
@@ -285,7 +320,7 @@ int selinux_set_policy_root(const char *path)
 
 	fini_selinux_policyroot();
 
-	selinux_policyroot = strdup(path);
+	selinux_policyroot = selinux_policyroots[0] = strdup(path);
 	if (!selinux_policyroot)
 		return -1;
 
@@ -487,3 +522,75 @@ const char *selinux_sepgsql_context_path(void)
 {
 	return get_path(SEPGSQL_CONTEXTS);
 }
+
+const char *const *selinux_policy_roots(void)
+{
+	__selinux_once(once, init_selinux_config);
+	return (const char *const *)selinux_policyroots;
+}
+
+/*
+ * If @path is under selinux_policy_root(), rebuild it under @root and
+ * write the result to @out. Returns 0 on success, -1 if @path isn ot
+ * under the primary root or the result would truncate.
+ */
+static int selinux_policy_remap(const char *path, const char *root, char *out,
+				size_t outlen)
+{
+	size_t plen;
+
+	if (!selinux_policyroot)
+		return -1;
+	plen = strlen(selinux_policyroot);
+	if (strncmp(path, selinux_policyroot, plen) != 0)
+		return -1;
+	if ((size_t)snprintf(out, outlen, "%s%s", root, path + plen) >= outlen)
+		return -1;
+	return 0;
+}
+
+FILE *selinux_policy_fopen(const char *path, const char *mode)
+{
+	char alt[PATH_MAX];
+	unsigned int i;
+	FILE *fp;
+
+	fp = fopen(path, mode);
+	if (fp || errno != ENOENT)
+		return fp;
+
+	__selinux_once(once, init_selinux_config);
+	for (i = 1; selinux_policyroots[i]; i++) {
+		if (selinux_policy_remap(path, selinux_policyroots[i], alt,
+					 sizeof(alt)))
+			break;
+		fp = fopen(alt, mode);
+		if (fp || errno != ENOENT)
+			return fp;
+	}
+	errno = ENOENT;
+	return NULL;
+}
+
+int selinux_policy_open(const char *path, int flags)
+{
+	char alt[PATH_MAX];
+	unsigned int i;
+	int fd;
+
+	fd = open(path, flags);
+	if (fd >= 0 || errno != ENOENT)
+		return fd;
+
+	__selinux_once(once, init_selinux_config);
+	for (i = 1; selinux_policyroots[i]; i++) {
+		if (selinux_policy_remap(path, selinux_policyroots[i], alt,
+					 sizeof(alt)))
+			break;
+		fd = open(alt, flags);
+		if (fd >= 0 || errno != ENOENT)
+			return fd;
+	}
+	errno = ENOENT;
+	return -1;
+}
diff --git a/libselinux/src/selinux_internal.h b/libselinux/src/selinux_internal.h
index 5feb5d97..ed77cf34 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -92,6 +92,36 @@ extern size_t selinux_page_size;
 #define SELINUXDIR "/etc/selinux/"
 #define SELINUXCONFIG SELINUXDIR "config"
 
+/*
+ * Ordered list of configuraiton roots, each with a trailing slash.
+ * SELINUXDIR is always first: it is the write target and the value the
+ * existing selinux_*_path() accessors return. The remaining entries are
+ * read-only fallbacks for hermetic-/usr / factory-reset systems where
+ * /etc and /var may be empty at boot. Distributions can override the
+ * fallback list at build time.
+ */
+#ifndef SELINUXFALLBACKDIRS
+#define SELINUXFALLBACKDIRS "/run/selinux/", "/usr/lib/selinux"
+#endif
+
+extern const char *const selinux_confdirs[];
+
+/*
+ * NULL-terminated list of <confdir><SELINUXTYPE> roots, populated by
+ * init_selinux_config(); [0] == selinux_policy_root(). Empty (only the
+ * NULL terminator) after selinux_set_policy_root() so that callers fall
+ * back to the single overridden root. Internal only.
+ */
+const char *const *selinux_policy_roots(void);
+
+/*
+ * Open @path (as returned by one of the selinux_*_path() accessors),
+ * falling back through selinux_policy_roots() when the primary path
+ * yields ENOENT. Internal-only.
+ */
+FILE *selinux_policy_fopen(const char *path, const char *mode);
+int selinux_policy_open(const char *path, int flags);
+
 extern int has_selinux_config;
 
 #ifndef HAVE_STRLCPY
-- 
2.55.0

