Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804988;
	b=h77TrRhyofFx39V/7g8Xajo/sJGM/N144pK4w2dlVIhvn1KVyRTKr+iFzo8fVDchHUsu
	 cO9HI4gF+f924D9PTvK8s/gD4XDGcPN7yF6OSi0h/v5hOQ513kqp8Ll5V9L906ID2iqWL
	 VBorJ1aY9b6rbivMDwwSLfTAWFogswy+OLCLAobM3zg9PC4gI6UaqcbH8mzuEl0Rn4GQT
	 rt76BNt24PKY1vBpCU4FsNqDAVeZo2o3eprJ3ODG5ripqUz0o8lIWF0Te6xSdOC/4EBWT
	 VGJDlhq16HtFBxOVMScpGAeGRTjgL6uh6qk5Bc7Eruq0EgHHjiMD7qDxfps70IIWNJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804988;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ElUMVIollMbe76XGsvOZfIViVgVmmAC5eH2eZIiXv8k=;
	b=x6OiaeKEFU0yPWsG0QJWGeiMbjSJXdHo/qMgpgtETOfjiCk0kfBo/U5Qk5LancnCp8FS
	 kPt3rB9doo+lROwUv9SQfJdK/UvjGLSpOt4r+mk7bxDigjRp/WwCEQtlwB/QINvCjP/KX
	 HMWMzYO9ds+SU3NmBa4fS6b2MoImR78qEFZ+H26UHN7Go1JVQfc0SqddRL/WJQn6q3t1Z
	 vK8p8DtFVS9y2QdRJDLMfXVAPmCHaTdnrwOY+PYcMKQXs4ozqTz2EWuJ23wQ+6M+iHElv
	 qMKLvA9Qs+j0pybZu2TZnMMn+cYn+XoYROr7nqw3tMmtM2sEdU4zfMxH3vkV/LzqiMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zn9JW7C4;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B37D606A332
	for <selinux@vger.kernel.org>; Wed,  4 Nov 2026 15:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B37D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zn9JW7C4
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-536c8f958d7so6004831cf.1
        for <selinux@vger.kernel.org>; Wed, 04 Nov 2026 07:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793804987; x=1794409787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ElUMVIollMbe76XGsvOZfIViVgVmmAC5eH2eZIiXv8k=;
        b=Zn9JW7C4zWl/CGr51WCG948OWgFHhIwzkUmgLx2DjjmmAO0GYJFda7iKLO+FGhhz1g
         v2lNosW3fjG5QAWyMXOZGGQ6idnNAZNEAO+9RtoXqPECjCq1uFTerwwUwriZfz5p6Li4
         I4b2C1CKK+P3Qg/8DUR3FeKUQnN9KLLxlc0K5I3CPiKEjYpqgf+UP1JzMdbTA42t3nn8
         LvfLRkK/GDFPcS28c/Tot30OU7E8bQUHh/Yxfq/yBFRw4kg0TFNav1CsIZm3Qs4NLiZo
         KlabgNZbu0F8h9TeeHal2MvRXvX5JbVWWZ3EoxpGBGf4ZD8TYKUB/rEcLPDLiXssjuXv
         OH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804987; x=1794409787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ElUMVIollMbe76XGsvOZfIViVgVmmAC5eH2eZIiXv8k=;
        b=OjmecOB+q0NKBB5uX+NLg3oj+iU4wcO6XRDtHbdH319GrpIt2nWnA65ObYNjNAY0Ly
         w/ZizzIX7RImiFwMyL9J+YBEU6VWFyvgoMiNL+SXAJg2wHGupAulZgky58y1geZx2e0I
         rFAHKxNbKnB0LPqpe0W/doVwrO6Yduux0Dk7/LuUoD0Xp5/FZgSyx9kroIiWf4yooGLG
         cvcOe0bVG9GbccGyXj1De24bGsUiKG3O4nhEDamlXT0qSBMn7OlqAFOVymvAfaY2H9Pj
         R8OuVZcZ5xjjBxO6ItyfCeh9DjmqkDX4/h1sNEcyn2BJIpfDM8nf1vdpOG8HvN+pNlZA
         YRsQ==
X-Gm-Message-State: APuU4Z+WV957Aww6naF4r2LtduQd1KiGqmG8VtafeD1kqit9wbnzvN6+
	C/CbdiXP24t1xw/BRoqxnaQzdfghe4lXEbsTnvRawJKfkOdXvIghqGWz0r7+9pXX
X-Gm-Gg: AYBFou2ZqXiAtLPFoK68JS3IocOy+C/dGZRskjXFalrFtUiafMEeToVmFAvbE8uWxDZ
	z/Kjtp38mchkPBrVKZwhl0ZuKNsROjP0ge8Y1MoRhpu1Jb2vPvEx5CbyWnLXPd+Y+XR3Ds7fHbU
	2sHsBo3hNBRJ5jxL9AHmPwmk3dEk9qo138x4vsLs77s6sR4miY5tb/ND7idAP+U2cpZb5oGp82X
	kM1R1Sve5b0FEDi0OwItiecOVoQA/rKGQtFjAXN4DH722PnvGqTx6s81J7Pv3XJGCEKdECVc6JL
	3L25JNlak7Qbk/Udk9WBHxazwqDGaj5WJMnXY7CpGeaSN6LueH9cAoHXQhoJqfbx4NKYmB+S7TZ
	HSizo6inJu0Sc1oniywQugSqvzZJ8j1H7wzpc2j610YAIGESeT2cj7FnERP0LdtdAQqUiOV1nEL
	zC+uKiI7j/yo0kwxYBN5CSIJL8cHS4tMnmT3BvRVVFHlMqVJH9Yws8m3GdL9ZG0EIABS0O6nS58
	qct27FAXqWjf/VE6LFNB7nsY41m3qywND37MJ2u/6agumUowHdzE+IxtCZE11SZegvkePggJhRb
	My1/2ZXSH9rXgZg1LwsDPyVNQDBSMyK3Qy/T6/Lr3eA8ekqHFdTPTEcGUiGyV3/bsAZcAL1aFS+
	JVlCrn8NUZcckgElR8RErqKS9tCH1aIIcUq4OSWf3t1dogBFxB6TSNRTAXa4EpXw+T4X6Wwb/G3
	vqy8on0UIHhgmlIwtZm5Yy2EORnG7OLNRH0E/BEH+O3AL6bRsUbXy18AnIxTAfoV0BGte60EX0
X-Received: by 2002:a05:622a:38e:b0:534:e675:4712 with SMTP id d75a77b69052e-542b761bc9fmr272618031cf.52.1793804986564;
        Wed, 04 Nov 2026 07:09:46 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10cdc3d3sm25683041cf.28.2026.11.04.07.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:09:45 -0800 (PST)
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
Subject: [PATCH v3 16/20] libselinux: require a component boundary when remapping policy roots
Date: Wed,  4 Nov 2026 10:09:11 -0500
Message-ID: <20261104150915.175923-16-stephen.smalley.work@gmail.com>
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

