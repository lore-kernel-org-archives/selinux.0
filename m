Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804984;
	b=PgBZSGrwrssUgbWuGH89D++6BauDmxiX4z+W/7SyWBW54hWetIoSGTlWCyFTprD6EkAv
	 1JPuG6uJI/Awi43rNuRJRv3UWA41qQZlHdx+oOMv+ts4gVelFJ5n6suMTSag6Jf6Iuexg
	 kI0N1qDIkV8SHGGQ7JQ7YEl6OXBBM80S2VCOLnzxEogTRXiN/YaSecmZsWjOhS6vgSb44
	 DW9bTdWV1bEQUHrNFSu8U3h9ycXNveoenZFcoBpJaCnABFPJL0ldwCTdyluHmGbvPM6f2
	 k9EpLblyqZKPcMWW2Ujb/P8VRnB9n9fWcDlJQvmxhZpyfk6ZDifzMoyx7JvFJB4Zd0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804984;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NyMZGbIVeuMPnkTNws3eg8BLNxUUoX3o+TUH8aPGDN8=;
	b=yNafMEvKmwvWdgdR98HVBwIJLSJQ/4iWubD0iLtDH39OVwU9AtykBEa+Eu2E+MEdjDDL
	 BKu0NlPiDUwIaSEi76krAWpJNwL3iJSqscpBJwwTJgIJOyoj+lDgWkjiR7c/5kj+GEiOK
	 IOS/9yD41eQW+QX1nmqbp/cW2xAH5Y+ZKKMJktS+9C/oKujJZcSmIZu6HEXxfyGeo7nyn
	 Kw7F4+bV9d55UBid+4qq3HO/jVdFF1FyIOj1o6z4n8V2VZydmpqzS3HgtLhP/giYjZl/A
	 Q59GbpEtINL2NafPXxz+BOtWkSgpCrudW2QWZNqu/6+eh/oXbgkEDeSFf8szXSd6NWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iTajE2VX;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89255606A326
	for <selinux@vger.kernel.org>; Wed,  4 Nov 2026 15:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89255606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iTajE2VX
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5363316fa0cso8642751cf.3
        for <selinux@vger.kernel.org>; Wed, 04 Nov 2026 07:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793804983; x=1794409783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NyMZGbIVeuMPnkTNws3eg8BLNxUUoX3o+TUH8aPGDN8=;
        b=iTajE2VXw6ybOcbVZegDrUn1SpCchdTBBkGpd/4YGzgLKjcns4xYGIMnBmwsAAgKvO
         7xCe7X6alQEW9tQdQw/u5b2j9QBBmNdikXqZj2+ObDtk6btQ4fE5QkjjA7A7Qp60YNvJ
         HajS0zWLQobUd6tBLHEHiUw1yEre+jIODGYq+kLGtdY4kZCjwvojBg0KLAcDKdC1h4qW
         KSpQ6FeqGH5cYELlIHIapda9KWTVsvBMl8Gd7vl+z6usVsbNpAYSG3CD06bmQ9b5vq1S
         WdD86bip6akZ36Gg9Wjs1g27ZMeJ+VP6IRIXxie7Y+RFQ9oyKKfKX9wMUqrGJZ0hDYcl
         K2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804983; x=1794409783;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NyMZGbIVeuMPnkTNws3eg8BLNxUUoX3o+TUH8aPGDN8=;
        b=PyHrWeqeobGxGNJfYtcEKzuyg3pRNx6neU4NjrG8g/U0K8jGKLXT6fSY4UiA8+12Dk
         olo1aj7csycXLtEhNFAvlhoN+PqkB4WFPtX2lwVSW3dT8vjznqr18gea8E6/MoCYLDfG
         G+y0eYZ5EP/cQnyHJlK6ajbhMrZE0ANI1dDYaL54DEiZ+A0vpjRQdW73vT75tQNnDVuQ
         YiLgGC5jqb/k5S3SXkommb8MFFq6wqe6eiHX7/ZPDf6V420RdbrSKJXufA1vlK51rCws
         /bzHfKcp7xPc5Wt1oDfYFmO1X+phlJkDT84D3TbMjRf08lC/6uSAsFgi0+g9yBMVVF1M
         zICg==
X-Gm-Message-State: APuU4Z9koWgr+AJ5KKPqj7Cl8QT5ceIypaQdWpGPKd6hiZnQERy4VZD+
	Ku4S58zpYMrf4k07LL43ujlebsSmtkbWiE4xwljDxcanXRW9ZSXZt6L6pG6T9ABF
X-Gm-Gg: AYBFou3X6Wb2e+RiUvf6fE3DjM1DskxveQjtc68csHgA4z4nEeHMpJ0P6K92WjpdWHT
	PLHy1DLjJ/X7itt6WQbhwo7dXkSHlSrUqHhttQxBGh+ZHuZZkbx62vUPmdLJzS1fhz/Dv0ehp+C
	ypgVhqiAKpLjAXQiUGOUcZ7D6A7MfdaPuvz5i4EMu6y/JJEwayAVN2D8ZbWA9xxD3EBlCl+esQY
	A2HWaoror43Lroqprouk91d+/K5WEb+ay562NUiISgBI0C2BcQtfOL+64O4rMNXZdPhMDgKjlVn
	n4W2gxmJ88cACTtQ8DkGfgl0FLoZYpuPPyeUNvtKZavYp34M9zGJOyek8JuFNYi2mufojg1Z0/l
	F30njEovMipOb8zmR5jCiCl57surMArm+u7eDSWPe+RkPC9taDKYpm4/TTjWV3P0A4hV2g/xqDT
	MKIpiivbsKE3HXB7/Ndi4oIa6rJmmVGThbAaKzQX2LKbeOXC9OpEO64RZ3Mj8JoeRCe7uO8pAPl
	C1xATjp85Nh1KZMVSfbLBC55wifnnGA93FuJ3YdeA/Aoz6Z92ntrbLVpvbS4Miaq73Ko3ZLRA5N
	VtnT0KN2jqV9Kfh8TDd/HOYwYp4NjM4FByQXUA92bygZTWa/ZtI9BdyEeBrpSupj1YSUMWRgRb5
	rwQ/uaQwauUNbSgbXAM8mIPWWX6LND8dVBOSKUucWMQ6X4z8nViiBY271O5kLxGMV3x1qTJ3J61
	vrQptNWte7nNZR9VXC0GT3gtgaDgS/Ldh2uoEF+Ex8wEX7AjT/yhZC
X-Received: by 2002:a05:622a:1f90:b0:535:a5fb:645b with SMTP id d75a77b69052e-542b83f7705mr244794951cf.70.1793804983215;
        Wed, 04 Nov 2026 07:09:43 -0800 (PST)
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
Subject: [PATCH v3 12/20] libselinux: preserve auxiliary file-context duplicate handling
Date: Wed,  4 Nov 2026 10:09:07 -0500
Message-ID: <20261104150915.175923-12-stephen.smalley.work@gmail.com>
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

Multiple input support moved duplicate checking after loading the optional
.local and .homedirs files. This rejects previously accepted customization
records, including the same expression with ALL and a specific file kind,
and can prevent setfiles validation during a policy-store commit.

Check for duplicates after loading primary inputs but before loading the
optional customization files. Retain the per-input duplicate checks for
primary files, context validation for all inputs, and the final sort.

Add text and compiled-only regression coverage for primary duplicate
rejection, auxiliary overlap acceptance, cross-input overrides, invalid
contexts and BASEONLY behavior.

Fixes: 1550c8aaf255 ("libselinux: support multiple context files for the file backend")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/label_file.c                  |  17 +-
 libselinux/tests/.gitignore                  |   1 +
 libselinux/tests/Makefile                    |   7 +-
 libselinux/tests/test_auxiliary_duplicates.c | 171 +++++++++++++++++++
 4 files changed, 189 insertions(+), 7 deletions(-)
 create mode 100644 libselinux/tests/test_auxiliary_duplicates.c

diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 99c188a6..1d520517 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -1843,6 +1843,17 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 			goto finish;
 	}
 
+	/*
+	 * Check duplicates within primary inputs only. Historically the
+	 * optional customization files have allowed overlapping entries.
+	 */
+	if (rec->validating) {
+		sort_specs(data);
+		status = nodups_spec_node(rec, data->root);
+		if (status)
+			goto finish;
+	}
+
 	/*
 	 * Process each optional input file.
 	 */
@@ -1856,12 +1867,6 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 
 	sort_specs(data);
 
-	if (rec->validating) {
-		status = nodups_spec_node(rec, data->root);
-		if (status)
-			goto finish;
-	}
-
 	digest_gen_hash(rec->digest);
 	if (data->subs_num || data->dist_subs_num)
 		gen_substitution_digest(data);
diff --git a/libselinux/tests/.gitignore b/libselinux/tests/.gitignore
index 2713a798..09604645 100644
--- a/libselinux/tests/.gitignore
+++ b/libselinux/tests/.gitignore
@@ -10,3 +10,4 @@ test-restorecon-digest
 /test-readable-fallback
 /test-digest-inputs
 /test-load-policy-version
+/test-auxiliary-duplicates
diff --git a/libselinux/tests/Makefile b/libselinux/tests/Makefile
index be03e5d5..1a73a0e6 100644
--- a/libselinux/tests/Makefile
+++ b/libselinux/tests/Makefile
@@ -20,7 +20,7 @@ test-restorecon-errno: test_restorecon_errno.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(ERRNO_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
 
 .PHONY: test clean
-test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs test-load-policy-version
+test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs test-load-policy-version test-auxiliary-duplicates
 	./test-restorecon-digest
 	./test-restorecon-errors
 	./test-restorecon-errno
@@ -33,10 +33,12 @@ test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-r
 	LD_LIBRARY_PATH=../src ./test-readable-fallback ../utils/sefcontext_compile
 	./test-digest-inputs
 	./test-load-policy-version
+	./test-auxiliary-duplicates ../utils/sefcontext_compile
 
 clean:
 	rm -f test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs
 	rm -f test-load-policy-version
+	rm -f test-auxiliary-duplicates
 
 test-restorecon-exclude: test_restorecon_exclude.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(EXCLUDE_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
@@ -60,3 +62,6 @@ test-digest-inputs: test_digest_inputs.c ../src/libselinux.a
 
 test-load-policy-version: test_load_policy_version.c ../src/libselinux.a ../../libsepol/src/libsepol.a
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) -o $@ $^ -Wl,--wrap=security_policyvers,--wrap=write,--wrap=sepol_policydb_to_image,--wrap=selinux_policy_roots,--wrap=selinux_binary_policy_path $(PCRE_LDLIBS) -ldl -pthread
+
+test-auxiliary-duplicates: test_auxiliary_duplicates.c ../src/libselinux.a
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(PCRE_LDLIBS) -ldl -pthread
diff --git a/libselinux/tests/test_auxiliary_duplicates.c b/libselinux/tests/test_auxiliary_duplicates.c
new file mode 100644
index 00000000..bb9e7534
--- /dev/null
+++ b/libselinux/tests/test_auxiliary_duplicates.c
@@ -0,0 +1,171 @@
+#define _GNU_SOURCE
+#include <assert.h>
+#include <errno.h>
+#include <selinux/label.h>
+#include <selinux/selinux.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <unistd.h>
+
+static const char *compiler;
+static char paths[4][256];
+static unsigned cases;
+
+static int validate(char **ctx)
+{
+	assert(ctx && *ctx);
+	if (strstr(*ctx, ":invalid_t:")) {
+		errno = EINVAL;
+		return -1;
+	}
+	return 0;
+}
+
+static void put(unsigned index, const char *text, unsigned binary)
+{
+	FILE *fp = fopen(paths[index], "we");
+	assert(fp && fputs(text, fp) >= 0 && fclose(fp) == 0);
+	if (binary) {
+		pid_t pid = fork();
+		assert(pid >= 0);
+		if (!pid) {
+			execl(compiler, compiler, paths[index], NULL);
+			_exit(127);
+		}
+		int status;
+		assert(waitpid(pid, &status, 0) == pid);
+		assert(WIFEXITED(status) && WEXITSTATUS(status) == 0);
+		/* Force compiled-only loading rather than mtime-based selection. */
+		assert(unlink(paths[index]) == 0);
+	}
+}
+
+static void clear(void)
+{
+	for (unsigned i = 0; i < 4; i++) {
+		char bin[sizeof(paths) + sizeof(".bin")];
+		snprintf(bin, sizeof(bin), "%s.bin", paths[i]);
+		assert(unlink(paths[i]) == 0 || errno == ENOENT);
+		assert(unlink(bin) == 0 || errno == ENOENT);
+	}
+}
+
+static struct selabel_handle *open_handle(unsigned multi, unsigned validating,
+					  unsigned baseonly)
+{
+	struct selinux_opt opts[] = {
+		{ SELABEL_OPT_PATH, paths[0] },
+		{ SELABEL_OPT_PATH, multi ? paths[1] : NULL },
+		{ SELABEL_OPT_VALIDATE, validating ? "1" : NULL },
+		{ SELABEL_OPT_BASEONLY, baseonly ? "1" : NULL },
+		{ SELABEL_OPT_DIGEST, "1" },
+	};
+	return selabel_open(SELABEL_CTX_FILE, opts, 5);
+}
+
+static void lookup(struct selabel_handle *h, int type, const char *expected)
+{
+	char *context = NULL;
+	assert(selabel_lookup_raw(h, &context, "/test", type) == 0);
+	assert(strstr(context, expected));
+	freecon(context);
+}
+
+int main(int argc, char **argv)
+{
+	assert(argc == 2);
+	compiler = argv[1];
+	char dir[] = "/tmp/selinux-aux-dups-XXXXXX";
+	assert(mkdtemp(dir));
+	snprintf(paths[0], sizeof(paths[0]), "%s/contexts", dir);
+	snprintf(paths[1], sizeof(paths[1]), "%s/second", dir);
+	snprintf(paths[2], sizeof(paths[2]), "%s/contexts.local", dir);
+	snprintf(paths[3], sizeof(paths[3]), "%s/contexts.homedirs", dir);
+	union selinux_callback cb = { .func_validate = validate };
+	selinux_set_callback(SELINUX_CB_VALIDATE, cb);
+	for (unsigned binary = 0; binary < 2; binary++) {
+		for (unsigned where = 0; where < 4; where++) {
+			for (unsigned regex = 0; regex < 2; regex++) {
+				for (unsigned pair = 0; pair < 3; pair++) {
+					clear();
+					char rules[512];
+					const char *pattern =
+						regex ? "/test(/.*)?" : "/test";
+					/* ALL+DIR, REG+DIR, and identical REG keys. */
+					snprintf(
+						rules, sizeof(rules),
+						"%s %s system_u:object_r:generic_t:s0\n"
+						"%s %s system_u:object_r:directory_t:s0\n",
+						pattern, pair ? "--" : "",
+						pattern,
+						pair == 2 ? "--" : "-d");
+					put(0,
+					    where ? "/other system_u:object_r:other_t:s0\n" :
+						    rules,
+					    binary);
+					if (where)
+						put(where, rules, binary);
+					for (unsigned validating = 0;
+					     validating < 2; validating++) {
+						errno = 0;
+						struct selabel_handle *h =
+							open_handle(where == 1,
+								    validating,
+								    0);
+						unsigned reject = validating &&
+								  where < 2 &&
+								  pair != 1;
+						assert((h == NULL) == reject);
+						if (h) {
+							if (pair != 2)
+								lookup(h,
+								       S_IFREG,
+								       ":generic_t:");
+							if (pair == 1 ||
+							    (regex &&
+							     pair == 0))
+								lookup(h,
+								       S_IFDIR,
+								       ":directory_t:");
+							selabel_close(h);
+						} else
+							assert(errno == EINVAL);
+						cases++;
+					}
+				}
+			}
+		}
+		/* Identical patterns in separate primary inputs remain valid overrides. */
+		clear();
+		put(0, "/test(/.*)? system_u:object_r:first_t:s0\n", binary);
+		put(1, "/test(/.*)? system_u:object_r:second_t:s0\n", binary);
+		struct selabel_handle *h = open_handle(1, 1, 0);
+		assert(h);
+		lookup(h, S_IFREG, ":second_t:");
+		selabel_close(h);
+		cases++;
+		for (unsigned where = 2; where < 4; where++) {
+			clear();
+			put(0, "/test(/.*)? system_u:object_r:first_t:s0\n",
+			    binary);
+			put(where,
+			    "/test(/.*)? system_u:object_r:invalid_t:s0\n",
+			    binary);
+			h = open_handle(0, 1, 0);
+			assert(!h && errno == EINVAL);
+			cases++;
+			h = open_handle(0, 1, 1);
+			assert(h);
+			lookup(h, S_IFREG, ":first_t:");
+			selabel_close(h);
+			cases++;
+		}
+	}
+	clear();
+	assert(rmdir(dir) == 0);
+	printf("auxiliary-duplicates: %u cases passed\n", cases);
+	return 0;
+}
-- 
2.56.0

