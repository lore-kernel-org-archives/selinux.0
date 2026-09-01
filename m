Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24005484226
	for <selinux@vger.kernel.org>; Tue,  1 Sep 2026 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280534; cv=none; b=PPQOOgFG0q9y52ZwO6kOrUr/7Kczgyd44Oms5E1VHRDosWOd4XXOil28mcbWuv0YnLtRDBxfI60NjnZJnhgswtrCQJuObw4iU6DkrZFnqTHo7rcR3mSmxMeuZeQ3mfTtzYH/0U7jNq98oTXgygwSZ3g/KBh0geb2zvCb0B0djqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280534; c=relaxed/simple;
	bh=TuaVMhcZdVSIE/fLIsJ7jYDTola7sb9i2Efszmr+KVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dpW+1srvuHh9qvGGaAb+8lUg/DeKoCY7jPbyHkzOlvHQo26b3eMvBFlXrDXKeMi/3U29w+/AJ4NR9f7Q3wTxcw3TH6uFkRq9VoTOggbmCQka1KUXrxHd5B/Os8gBRvclGZQ08cfj+fITkbkBT4+l0K7oX2NTxe1JfXWH5Gb+KZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQE3p0LM; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQE3p0LM"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-90e828b309eso703706d6.1
        for <selinux@vger.kernel.org>; Tue, 01 Sep 2026 09:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788280531; x=1788885331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bUyU/yJqLNk2oPcHFkYu1qhzlozOgvpQOe8bBwnlWBg=;
        b=IQE3p0LMUX8hsSRralZ2OOMGoyYvTnSYzuQxCQBXzVT9EXPmHXjhLr3tkUwnp7oEl4
         amUF3wiTHM2BIL2Sc/B073IVu6DFZ04ha78QkkJXcZ471KvDJ5db9zrUZ3mqIJcVl/lj
         pvB1grci4eKWg2ZPHcbY5CBcl3+UIHyuS39qSnkxNTlk9kQanuzojrOlMdbrBU42cFfY
         6dYc5kCoEvqMHccl+O02hrN0m8aymKA+4D3HR5q6dWnCRBV0aDOAymzLKv6TjWmcOpaa
         pURn/+r73jR6fZ1nybOG4PvXLoAXXIHFd0bJZToO4YCgxCTLjlXDa7NEmKflA2pRvFik
         f8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788280531; x=1788885331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bUyU/yJqLNk2oPcHFkYu1qhzlozOgvpQOe8bBwnlWBg=;
        b=OoF1SvGt8Mg3R67rjfJQIsYPMPQnZ0geSXA2bIwwQBsJuBJZDAzGGgpxgK11IR1axW
         lvlOtAOtUvYwmkmV1VE8/LZjoq/EjuP5MqlSE/saslxZLoihoDGX3uXYuRiJjGubbnJe
         F1nzjf7JN/gBtFvNmwdFVQpffJ+JzHMfG3bNREe/lgkAs0E0hzW466W+W+iDoGenHjPH
         gxiM1qO4NK4nhzPfo+424DGyT8WaTZt1ziY9Ply5JMwAHCwJMdDy0S1uBUuVR7ZSZ/kq
         h/RX+Ii0t4AZskdZlk/dkKoAZO/rdY8FVOzm9eWnJEOcTkUA+3ZSUSkuY4J2HzJ79R3z
         crmw==
X-Gm-Message-State: AFuF++mXIsU0jPutX1xOMUR5ztfsGbj/O5iGApAzdZzIxcvZ3Yvc64JF
	VKvD0ukdoJgoIvBfM3GfVxQDMjhC+tmxYvvczEVf84/w51PUG7NgBd9KAZ/yDg==
X-Gm-Gg: AR+sD11o6Mz0jHT9XGJSukA4Pi0VhTXGsDYACDItyQ/mz4Bwqa9mnpne9esVT4X6vuv
	tRrD7JEirm32fKWKs6G4It/v3pY1ZAhxGGPFBlpRcTp+6U0Se7grX7OK2oNkc/o1CzAUOeMJqCL
	/JgjugWN+Z5HLFBH05RqJJQJUwyTma56GXKWh6qkxia/qcDGkdzqBFsJYr64LRPx+6CpHM91KtR
	TKG4pfg8/uZF4TFMpEy27GABP0P/owPqWdxymgNPtdjuWbPzVJjtRS6eqsn/wSVw5l99DK+CFrY
	LMCMe+Ew1ELzkERTp1FnhFkjJR6PrTwja+e4skwZopzx6tCF40mqSi6fYJ7C7yzyXDVqdyBbcqc
	2APDfWQAXMNh3kEtxiP3+KO8DacEui3ToVxX4W5JgBvH9tmEiodwIWBdWryvsNR1fNwqveTQI5Q
	OfCDFFDW4rEehYzwqYMQElC4+bMikhS/GcS9daF4gbUzU2dQ1JNTZROjDrxOTJhdoJ9DQNIo74o
	5eOOqS4O+CjaNUaXdyiUNNXEK1hCQ8K+M4renElwPeby1Aa11vCbKqWmiLlx7qj
X-Received: by 2002:a05:6214:29ed:b0:90e:995c:42d2 with SMTP id 6a1803df08f44-90e995c43f5mr48096536d6.12.1788280530676;
        Tue, 01 Sep 2026 09:35:30 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90ce8769b76sm103461946d6.13.2026.09.01.09.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 09:35:30 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 1/4] libselinux: add a configuration-root search list
Date: Tue,  1 Sep 2026 12:35:10 -0400
Message-ID: <20260901163513.43186-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901163513.43186-1-stephen.smalley.work@gmail.com>
References: <20260901163513.43186-1-stephen.smalley.work@gmail.com>
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
 libselinux/src/selinux_config.c   | 123 ++++++++++++++++++++++++++++--
 libselinux/src/selinux_internal.h |  30 ++++++++
 3 files changed, 156 insertions(+), 9 deletions(-)

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
index 8a0b8c1a..199f76e0 100644
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
@@ -84,9 +90,24 @@ static const uint16_t file_path_suffixes_idx[NEL] = {
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
-	FILE *cfg = fopen(SELINUXCONFIG, "re");
+	FILE *cfg = open_selinux_config();
 	if (!cfg)
 		return -1;
 
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
+ * write the result to @out. Returns 0 on success, -1 if @path is not
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
index 5feb5d97..d3b5cfee 100644
--- a/libselinux/src/selinux_internal.h
+++ b/libselinux/src/selinux_internal.h
@@ -92,6 +92,36 @@ extern size_t selinux_page_size;
 #define SELINUXDIR "/etc/selinux/"
 #define SELINUXCONFIG SELINUXDIR "config"
 
+/*
+ * Ordered list of configuration roots, each with a trailing slash.
+ * SELINUXDIR is always first: it is the write target and the value the
+ * existing selinux_*_path() accessors return. The remaining entries are
+ * read-only fallbacks for hermetic-/usr / factory-reset systems where
+ * /etc and /var may be empty at boot. Distributions can override the
+ * fallback list at build time.
+ */
+#ifndef SELINUXFALLBACKDIRS
+#define SELINUXFALLBACKDIRS "/run/selinux/", "/usr/lib/selinux/"
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

