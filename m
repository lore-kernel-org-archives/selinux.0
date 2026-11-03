Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732012;
	b=bqoA6hl8gupOHA1H+j1tS2M7Uok243F/uT+DW5JZw0dmGg1PsaNXap+3EI2mv6ispozY
	 qKR4zeU2fAueKEa7eOgO2OiO3kQlieEkGDw2apG0YC8MBClDPyCg1ZxP3EaeOLiCnB/qZ
	 ez8ld469hrU+x75zjc1xoqvKAhgeYgGuLWr6o1QS/XlE0ve5dUqEAidiM+6a42/N/oYMO
	 dhUrL3Ua+tq+Z5RKw1yMc9gQUZIIXuhgv0b86+OHgpTi+mm6d/YTG7TOMzPSfy2pR3bxa
	 vp5Q6dCNAkQB0OTU4yWOO9N4sE5AlHLRzEUxOAYAKWfK+avV/FWnCmTvjoDhy+mdHJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8XUYmGnp4EK5Vd4qflrujs0IjxV/dOxlI7eM5qItero=;
	b=kOHayZCVUHwQZpx9uCDvkcoWQvZS20I6sTbCu4joLLeznHjDRjQQ0flE31WLW3CH9b5S
	 UtqaWHSRkDQHq+wJ6wbgzYLS8iMl6w36tCno343xyHsE6R2g6YXpleZWvvVBxaH9+yfOa
	 93uic0w6LRi1C6lOoropQ8nGbJPKx3CeLDFkIzNkTNXKBX3I9t0479UQqGNJ1UWxUD+Dw
	 FPojWQImB+rdyPc5iyYYIber1F/QuUwHgLDBjYXFeZ2e2Q8yXPPnPcLKfSq3BevkiQQ/m
	 DoLTmKIjGbW5zlmSA0/Hu6/5HfLFRCViY/fnlXMQffgsjlbUQ4qj2UNCusKqUi7XIIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=soGhWvZ9;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AAE606D802
	for <selinux@vger.kernel.org>; Tue,  3 Nov 2026 18:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93AAE606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=soGhWvZ9
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5495d549924so17067781cf.1
        for <selinux@vger.kernel.org>; Tue, 03 Nov 2026 10:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793732010; x=1794336810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8XUYmGnp4EK5Vd4qflrujs0IjxV/dOxlI7eM5qItero=;
        b=soGhWvZ9ldDm88GCnaKbW818sKwdfhn8Mp+a1Y0Y3a0psy0P4yEAx+WMYsIavhO++D
         llnBYOI6X9nXsjc1IVJO6neAT20ZP4uMXAi+6lZJkSgKOE4awpiCgKjB4BGHf39n5+Aw
         1a4RDvdtXUizTtomnTCIBACsNdASknZnp2F/wIWF0XHFXK2Avy8zRtGn95JS+pOA/ePn
         VZFfJ1ExRaWHIWPBmBsSX7n398nZbQI7Yf7eDCTNHHxKLBFGuaB0zHlqGssGODMY4fBQ
         fByry17Gj9e1KwVFss+/u/hJqJ/XBSV5l60OPujMC1deBw7HzzlNu+eruQSR+wReVIxd
         7T7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732010; x=1794336810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8XUYmGnp4EK5Vd4qflrujs0IjxV/dOxlI7eM5qItero=;
        b=BnpX1ZuyMSqB5DenBs17H8qqgW8VEuHmLFCOmkdXSMaBnxU+VT7cens6wL+sJWJUdi
         sO9bdac9tJPQAB1xoJZy3dUQesitcbg9KZL9Spgf9qwVY1tV8IC53qTHWSJJ1eL67h5Z
         qa2bXFYW2IocnMgqiO+HBV60zr/2jFmn8nia6mwqD9SbKFPWZHZs2aAfw1ZY5/tSzLXM
         KStAztck7glGyaCEr5llrdnhrNjYBLPNjD09ks7Lwhm+aBGKPDbaUIrjna2/yZeBhEmw
         HVu8D7NTUmyNXzgAMMl46aud6QIRZAquhieg34NIDlCegR5JB2LMxFuFpenxGyYjJfgO
         HVEQ==
X-Gm-Message-State: APuU4Z+vebXEJKoPg/ZYw+Pyuc7szAB+SdCwLeG0OlBfHED52jNtDTMZ
	HHwRT3wmYHJAuk1tAB2xv/uAYdoEOtjgX8qfbPSzgm6MjJIXulmORNx0zRcmEu3b
X-Gm-Gg: AYBFou0k/yk4CtATDKqtYUilN2GS99LbSR46J3XF2glrbVKhaWcIcdgBL/oVhpLjcDO
	U89DHT0j/qGGL6VDqJ11WQEfTvHkA6UMM4UrbKol7zgtvnoZ+0TqAGobl8mml6zfjpmAcrWYiFX
	feXWlIEcTlO27cwVd6vwZ/+ktAl7IcMQO4bGDCR+x/CLdmlzB7risQqV+fQ9+qIZxb/Bdd4PUvZ
	AvVY/XRv68I27eWbLK+BVAScIsuuP38fDk8vb6B14+mj/TbSLmQcLY+xK0gtQk7wjAv9AKo69U2
	daFK9dUzjffV2XklAatTyrnNPQeWSXXwlcahxcmKqidx6j/aQCaiIpxiSo6GWSJ7nm78hSB49QF
	L30qgiVeCLnBG+rvR88t52qnrJx0+WKL9wNkxvW6/tfdB3a0D9t7kPWN1XYKhjV7UQwwIQ7D9OM
	SQmgF1Xm97GMLaFeSfrH+8tvdJ7q/CdX/CRGHz3gWCHuj74JsZI/wzO4ZcCRACtktNRWZHnSbJq
	WnfftB/WJbPdwiEHsvWYrrTlImDk+LYPG+uT0Ji5JjhUws86P6DUpx2IKulSCH4t1w71Wp6izij
	KFmBWUDb9Q8Llk/9UcJgaeSH0Tm/QBStsrpVR3r3PnZsPtI/7w7w0QszWkiczy+uxnXlpW3XD+4
	Lguy4mDdWFmg8I2k7hq4JEJqOcNqEK/lWc7AftSRYM0KyLr+6JoR+hRZRasFU5q8RV2/Hk56Rqk
	ykvw4o9UUaV4+WQm3PfLOq0tU99nbILKWZV7aGAKK+snfnMwYHsnI=
X-Received: by 2002:a05:622a:2b46:b0:532:84f8:369c with SMTP id d75a77b69052e-542b3979c1emr225664051cf.5.1793732010204;
        Tue, 03 Nov 2026 10:53:30 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7c7881desm234016d6.29.2026.11.03.10.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:53:29 -0800 (PST)
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
Subject: [PATCH v2 08/20] libselinux: include substitution dependencies in directory digests
Date: Tue,  3 Nov 2026 13:52:55 -0500
Message-ID: <20261103185307.45924-8-stephen.smalley.work@gmail.com>
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

A trailing-wildcard substitution deliberately leaves its container
directory's exact label unchanged. However, the partial-match digest for
that directory also ignores the destination rules applied to descendants.
A destination label change can therefore leave the directory digest
unchanged and make restorecon skip files that need updating.

Precompute a domain-separated hash of all loaded rules and substitutions.
Use it for paths overlapping substitution source prefixes and their
ancestors, conservatively truncating wildcard sources at their literal
prefix. Also report a possible partial match for those paths so traversal
can reach substituted descendants. Keep exact lookups and unrelated-path
digests unchanged. This covers the related older literal-ancestor case.

The conservative hash may invalidate an affected directory after an
unrelated rule change, but retains cache skipping when inputs do not
change. It works without SELABEL_OPT_DIGEST and does not add lookup I/O.

Add literal, wildcard, multiple-wildcard and chained-substitution tests,
plus native restorecon traversal checks at one, two and eight workers.
Document the invalidation tradeoff.

Fixes: 3340da21a789 ("libselinux: allow a '*' wildcard in file_contexts.subs_dist/.subs")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/man/man5/selabel_file.5            |   8 +
 libselinux/src/label_file.c                   |  88 ++++++++
 libselinux/src/label_file.h                   |   1 +
 libselinux/tests/.gitignore                   |   2 +
 libselinux/tests/Makefile                     |  11 +-
 libselinux/tests/test_substitution_hash.c     |  93 ++++++++
 .../tests/test_substitution_restorecon.c      | 204 ++++++++++++++++++
 7 files changed, 405 insertions(+), 2 deletions(-)
 create mode 100644 libselinux/tests/test_substitution_hash.c
 create mode 100644 libselinux/tests/test_substitution_restorecon.c

diff --git a/libselinux/man/man5/selabel_file.5 b/libselinux/man/man5/selabel_file.5
index a2f61342..976cb930 100644
--- a/libselinux/man/man5/selabel_file.5
+++ b/libselinux/man/man5/selabel_file.5
@@ -228,6 +228,14 @@ up as \fI/usr/lib/foo.so\fR, while \fI/var/lib/extensions/example\fR and
 .RE
 .
 .SH "NOTES"
+.sp
+For paths that may be affected by substitutions, including their ancestor
+directories, partial-match digests cover all loaded labeling rules and
+substitution entries. A change to any of those inputs invalidates the cached
+digest for such a directory. This can cause additional relabeling after an
+unrelated rule change, but ensures that changes to substituted descendants
+are not hidden by an unchanged directory digest. Exact label lookup is
+unchanged. Paths outside substitution prefixes retain per-directory digests.
 .IP "1." 4
 If contexts are to be validated, then the global option \fBSELABEL_OPT_VALIDATE\fR must be set before calling \fBselabel_open\fR(3). If this is not set, then it is possible for an invalid context to be returned.
 .IP "2." 4
diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
index 991cff7d..9b93b198 100644
--- a/libselinux/src/label_file.c
+++ b/libselinux/src/label_file.c
@@ -1578,6 +1578,85 @@ static void closef(struct selabel_handle *rec);
 
 static const char *const opt_suffixes[] = { "homedirs", "local" };
 
+static void hash_spec_tree(Sha1Context *hash, const struct spec_node *node)
+{
+	for (uint32_t i = 0; i < node->literal_specs_num; i++) {
+		const struct literal_spec *s = &node->literal_specs[i];
+		Sha1Update(hash, s->regex_str, strlen(s->regex_str) + 1);
+		Sha1Update(hash, &s->file_kind, sizeof(s->file_kind));
+		Sha1Update(hash, &s->inputno, sizeof(s->inputno));
+		Sha1Update(hash, s->lr.ctx_raw, strlen(s->lr.ctx_raw) + 1);
+	}
+	for (uint32_t i = 0; i < node->regex_specs_num; i++) {
+		const struct regex_spec *s = &node->regex_specs[i];
+		Sha1Update(hash, &s->lineno, sizeof(s->lineno));
+		Sha1Update(hash, s->regex_str, strlen(s->regex_str) + 1);
+		Sha1Update(hash, &s->file_kind, sizeof(s->file_kind));
+		Sha1Update(hash, &s->inputno, sizeof(s->inputno));
+		Sha1Update(hash, s->lr.ctx_raw, strlen(s->lr.ctx_raw) + 1);
+	}
+	for (uint32_t i = 0; i < node->children_num; i++)
+		hash_spec_tree(hash, &node->children[i]);
+}
+
+static void hash_substitutions(Sha1Context *hash,
+			       const struct selabel_sub *subs, uint32_t num)
+{
+	for (uint32_t i = 0; i < num; i++) {
+		Sha1Update(hash, subs[i].src, subs[i].slen + 1);
+		Sha1Update(hash, subs[i].dst, subs[i].dlen + 1);
+	}
+}
+
+static void gen_substitution_digest(struct saved_data *data)
+{
+	Sha1Context hash;
+	SHA1_HASH result;
+	static const char domain[] = "selabel-substitution-inputs-v1";
+	static const char separator[] = "distribution substitutions";
+	Sha1Initialise(&hash);
+	Sha1Update(&hash, domain, sizeof(domain));
+	hash_spec_tree(&hash, data->root);
+	hash_substitutions(&hash, data->subs, data->subs_num);
+	Sha1Update(&hash, separator, sizeof(separator));
+	hash_substitutions(&hash, data->dist_subs, data->dist_subs_num);
+	Sha1Finalise(&hash, &result);
+	memcpy(data->substitution_digest, result.bytes, sizeof(result.bytes));
+}
+
+/* The literal prefix before the first wildcard conservatively covers every
+ * possible source descendant, including ancestors and chained rewrites. */
+static bool overlaps_substitution(const char *key,
+				  const struct selabel_sub *subs, uint32_t num)
+{
+	size_t len = strlen(key);
+	for (uint32_t i = 0; i < num; i++) {
+		size_t plen = subs[i].plen;
+		size_t common = len < plen ? len : plen;
+		if (strncmp(key, subs[i].src, common))
+			continue;
+		if (len == plen || !common ||
+		    (len < plen &&
+		     (key[len - 1] == '/' || subs[i].src[len] == '/')) ||
+		    (len > plen &&
+		     (subs[i].src[plen - 1] == '/' || key[plen] == '/')))
+			return true;
+	}
+	return false;
+}
+
+static bool substitution_affected(const struct saved_data *data,
+				  const char *key)
+{
+	/* lookup_all normalizes these; conservatively include all such inputs. */
+	if (!key || !*key)
+		return false;
+	if (strstr(key, "//"))
+		return data->subs_num || data->dist_subs_num;
+	return overlaps_substitution(key, data->subs, data->subs_num) ||
+	       overlaps_substitution(key, data->dist_subs, data->dist_subs_num);
+}
+
 static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 		unsigned n)
 {
@@ -1774,6 +1853,8 @@ static int init(struct selabel_handle *rec, const struct selinux_opt *opts,
 	}
 
 	digest_gen_hash(rec->digest);
+	if (data->subs_num || data->dist_subs_num)
+		gen_substitution_digest(data);
 
 	status = 0;
 
@@ -2496,6 +2577,11 @@ static bool hash_all_partial_matches(struct selabel_handle *rec,
 				     const char *key, uint8_t *digest)
 {
 	assert(digest);
+	struct saved_data *data = rec->data;
+	if (substitution_affected(data, key)) {
+		memcpy(digest, data->substitution_digest, SHA1_HASH_SIZE);
+		return true;
+	}
 
 	struct lookup_result *matches =
 		lookup_all(rec, key, 0, true, true, NULL);
@@ -2539,6 +2625,8 @@ static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
 static bool partial_match(struct selabel_handle *rec, const char *key)
 {
 	struct lookup_result buf;
+	if (substitution_affected(rec->data, key))
+		return true;
 
 	return !!lookup_common(rec, key, 0, true, &buf);
 }
diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index a4f1d4b5..785c22d3 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -168,6 +168,7 @@ struct saved_data {
 
 	/* Number of file specifications */
 	uint64_t num_specs;
+	uint8_t substitution_digest[SHA1_HASH_SIZE];
 
 	struct mmap_area *mmap_areas;
 
diff --git a/libselinux/tests/.gitignore b/libselinux/tests/.gitignore
index cf084570..563eccce 100644
--- a/libselinux/tests/.gitignore
+++ b/libselinux/tests/.gitignore
@@ -5,3 +5,5 @@ test-restorecon-digest
 /test-restorecon-xdev
 /test-label-init-oom
 /test-label-merge
+/test-substitution-hash
+/test-substitution-restorecon
diff --git a/libselinux/tests/Makefile b/libselinux/tests/Makefile
index 032018a8..3e9092cf 100644
--- a/libselinux/tests/Makefile
+++ b/libselinux/tests/Makefile
@@ -20,7 +20,7 @@ test-restorecon-errno: test_restorecon_errno.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(ERRNO_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
 
 .PHONY: test clean
-test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge
+test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon
 	./test-restorecon-digest
 	./test-restorecon-errors
 	./test-restorecon-errno
@@ -28,9 +28,11 @@ test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-r
 	./test-restorecon-xdev
 	./test-label-init-oom
 	./test-label-merge ../utils/sefcontext_compile
+	./test-substitution-hash
+	./test-substitution-restorecon
 
 clean:
-	rm -f test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge
+	rm -f test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon
 
 test-restorecon-exclude: test_restorecon_exclude.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(EXCLUDE_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
@@ -40,3 +42,8 @@ test-label-init-oom: test_label_init_oom.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(INIT_OOM_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
 test-label-merge: test_label_merge.c ../src/libselinux.a
 	$(CC) $(CFLAGS) -I../src -DUSE_PCRE2 -DPCRE2_CODE_UNIT_WIDTH=8 $(LDFLAGS) -o $@ $^ -Wl,--wrap=reallocarray $(PCRE_LDLIBS) -ldl -pthread
+
+test-substitution-hash: test_substitution_hash.c ../src/libselinux.a
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(PCRE_LDLIBS) -pthread
+test-substitution-restorecon: test_substitution_restorecon.c ../src/libselinux.a
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ -Wl,--wrap=getfilecon_raw,--wrap=setfilecon_raw,--wrap=getxattr,--wrap=fsetxattr,--wrap=fstatfs,--wrap=fstatfs64 $(PCRE_LDLIBS) -pthread
diff --git a/libselinux/tests/test_substitution_hash.c b/libselinux/tests/test_substitution_hash.c
new file mode 100644
index 00000000..393eb139
--- /dev/null
+++ b/libselinux/tests/test_substitution_hash.c
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: CC0-1.0 */
+#define _GNU_SOURCE
+#undef NDEBUG
+#include <assert.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <selinux/label.h>
+
+static void put(const char *path, const char *text)
+{
+	FILE *fp = fopen(path, "w");
+	assert(fp && fputs(text, fp) >= 0 && fclose(fp) == 0);
+}
+
+int main(void)
+{
+	const char *rules[] = { "/stage/demo /\n", "/stage/* /\n",
+				"/stage/*/*/files /\n",
+				"/stage/* /intermediate\n" };
+	const char *children[] = { "/stage/demo/usr/tool",
+				   "/stage/demo/usr/tool",
+				   "/stage/a/b/files/usr/tool",
+				   "/stage/demo/usr/tool" };
+	unsigned cases = 0;
+	for (unsigned r = 0; r < 4; r++) {
+		for (unsigned digest = 0; digest < 2; digest++) {
+			char tmp[] = "/tmp/substitution-hash-XXXXXX", fc[128],
+			     subs[128], dist[128];
+			assert(mkdtemp(tmp));
+			snprintf(fc, sizeof(fc), "%s/fc", tmp);
+			snprintf(subs, sizeof(subs), "%s/fc.subs", tmp);
+			snprintf(dist, sizeof(dist), "%s/fc.subs_dist", tmp);
+			put(subs, rules[r]);
+			if (r == 3)
+				put(dist, "/intermediate /\n");
+			uint8_t hashes[4][3][20];
+			for (unsigned v = 0; v < 4; v++) {
+				if (v == 3) {
+					FILE *fp = fopen(subs, "a");
+					assert(fp &&
+					       fputs("/stage/new /other\n",
+						     fp) >= 0 &&
+					       fclose(fp) == 0);
+				}
+				put(fc,
+				    v ? "/stage(/.*)? system_u:object_r:stage_t:s0\n/usr/tool system_u:object_r:new_t:s0\n/unrelated system_u:object_r:same_t:s0\n" :
+					"/stage(/.*)? system_u:object_r:stage_t:s0\n/usr/tool system_u:object_r:old_t:s0\n/unrelated system_u:object_r:same_t:s0\n");
+				struct selinux_opt opts[] = {
+					{ SELABEL_OPT_PATH, fc },
+					{ SELABEL_OPT_DIGEST,
+					  digest ? "1" : NULL }
+				};
+				struct selabel_handle *h =
+					selabel_open(SELABEL_CTX_FILE, opts, 2);
+				assert(h);
+				char *context = NULL;
+				assert(selabel_lookup_raw(h, &context,
+							  children[r], 0) == 0);
+				assert(strstr(context,
+					      v ? ":new_t:" : ":old_t:"));
+				freecon(context);
+				const char *keys[] = { "/stage", "/stage/demo",
+						       "/unrelated" };
+				for (unsigned k = 0; k < 3; k++) {
+					assert(selabel_partial_match(h,
+								     keys[k]));
+					assert(selabel_hash_all_partial_matches(
+						h, keys[k], hashes[v][k]));
+				}
+				assert(!selabel_partial_match(
+					h, "/stage-sibling"));
+				selabel_close(h);
+			}
+			for (unsigned k = 0; k < 3; k++) {
+				assert((memcmp(hashes[0][k], hashes[1][k],
+					       20) != 0) == (k < 2));
+				assert(!memcmp(hashes[1][k], hashes[2][k], 20));
+				assert((memcmp(hashes[2][k], hashes[3][k],
+					       20) != 0) == (k < 2));
+			}
+			assert(unlink(fc) == 0 && unlink(subs) == 0);
+			if (r == 3)
+				assert(unlink(dist) == 0);
+			assert(rmdir(tmp) == 0);
+			cases++;
+		}
+	}
+	printf("Substitution hashes: %u scenarios passed.\n", cases);
+	return 0;
+}
diff --git a/libselinux/tests/test_substitution_restorecon.c b/libselinux/tests/test_substitution_restorecon.c
new file mode 100644
index 00000000..2f9406db
--- /dev/null
+++ b/libselinux/tests/test_substitution_restorecon.c
@@ -0,0 +1,204 @@
+/* SPDX-License-Identifier: CC0-1.0 */
+#define _GNU_SOURCE
+#undef NDEBUG
+#include <assert.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <pthread.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/vfs.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <selinux/label.h>
+#include <selinux/restorecon.h>
+
+static struct entry {
+	ino_t ino;
+	unsigned char hash[20];
+} entries[16];
+static unsigned nentries, attempts;
+static ino_t target;
+static char last_context[128];
+static pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;
+
+int __wrap_fstatfs(int fd, struct statfs *buf);
+int __wrap_fstatfs64(int fd, struct statfs64 *buf);
+int __wrap_getfilecon_raw(const char *path, char **context);
+int __wrap_setfilecon_raw(const char *path, const char *context);
+ssize_t __wrap_getxattr(const char *path, const char *name, void *value,
+			size_t size);
+int __wrap_fsetxattr(int fd, const char *name, const void *value, size_t size,
+		     int flags);
+
+int __real_fstatfs(int fd, struct statfs *buf);
+int __wrap_fstatfs(int fd, struct statfs *buf)
+{
+	int rc = __real_fstatfs(fd, buf);
+	if (!rc)
+		buf->f_type = 0xef53;
+	return rc;
+}
+int __real_fstatfs64(int fd, struct statfs64 *buf);
+int __wrap_fstatfs64(int fd, struct statfs64 *buf)
+{
+	int rc = __real_fstatfs64(fd, buf);
+	if (!rc)
+		buf->f_type = 0xef53;
+	return rc;
+}
+int __wrap_getfilecon_raw(const char *path, char **context)
+{
+	(void)path;
+	*context = NULL;
+	errno = ENODATA;
+	return -1;
+}
+int __wrap_setfilecon_raw(const char *path, const char *context)
+{
+	struct stat sb;
+	assert(stat(path, &sb) == 0);
+	assert(pthread_mutex_lock(&lock) == 0);
+	if (sb.st_ino == target) {
+		attempts++;
+		assert(strlen(context) < sizeof(last_context));
+		strcpy(last_context, context);
+	}
+	assert(pthread_mutex_unlock(&lock) == 0);
+	return 0;
+}
+ssize_t __wrap_getxattr(const char *path, const char *name, void *value,
+			size_t size)
+{
+	struct stat sb;
+	assert(!strcmp(name, "security.sehash") && size >= 20);
+	assert(stat(path, &sb) == 0);
+	assert(pthread_mutex_lock(&lock) == 0);
+	for (unsigned i = 0; i < nentries; i++) {
+		if (entries[i].ino == sb.st_ino) {
+			memcpy(value, entries[i].hash, 20);
+			assert(pthread_mutex_unlock(&lock) == 0);
+			return 20;
+		}
+	}
+	assert(pthread_mutex_unlock(&lock) == 0);
+	errno = ENODATA;
+	return -1;
+}
+int __wrap_fsetxattr(int fd, const char *name, const void *value, size_t size,
+		     int flags)
+{
+	struct stat sb;
+	(void)flags;
+	assert(!strcmp(name, "security.sehash") && size == 20);
+	assert(fstat(fd, &sb) == 0);
+	assert(pthread_mutex_lock(&lock) == 0);
+	unsigned i;
+	for (i = 0; i < nentries && entries[i].ino != sb.st_ino; i++) {
+	}
+	if (i == nentries) {
+		assert(nentries < 16);
+		entries[nentries++].ino = sb.st_ino;
+	}
+	memcpy(entries[i].hash, value, 20);
+	assert(pthread_mutex_unlock(&lock) == 0);
+	return 0;
+}
+
+static void run(unsigned wildcard, size_t threads)
+{
+	char tmp[] = "/tmp/doex-wild-restore-XXXXXX", root[512], path[512],
+	     fc[512], subs[512];
+	struct stat sb;
+	assert(mkdtemp(tmp));
+	snprintf(root, sizeof(root), "%s/demo", tmp);
+	assert(mkdir(root, 0700) == 0);
+	snprintf(path, sizeof(path), "%s/demo/usr", tmp);
+	assert(mkdir(path, 0700) == 0);
+	snprintf(path, sizeof(path), "%s/demo/usr/bin", tmp);
+	assert(mkdir(path, 0700) == 0);
+	snprintf(path, sizeof(path), "%s/demo/usr/bin/tool", tmp);
+	int fd = open(path, O_CREAT | O_EXCL | O_WRONLY, 0600);
+	assert(fd >= 0 && close(fd) == 0);
+	assert(stat(path, &sb) == 0);
+	target = sb.st_ino;
+	snprintf(fc, sizeof(fc), "%s/file_contexts", tmp);
+	snprintf(subs, sizeof(subs), "%s/file_contexts.subs_dist", tmp);
+	FILE *fp = fopen(subs, "we");
+	assert(fp);
+	fprintf(fp, "%s/%s /\n", tmp, wildcard ? "*" : "demo");
+	assert(fclose(fp) == 0);
+	unsigned flags = SELINUX_RESTORECON_RECURSE |
+			 SELINUX_RESTORECON_IGNORE_MOUNTS |
+			 SELINUX_RESTORECON_SET_SPECFILE_CTX;
+	for (unsigned version = 0; version <= 1; version++) {
+		fp = fopen(fc, "we");
+		assert(fp);
+		fprintf(fp, "%s(/.*)? system_u:object_r:staging_t:s0\n", tmp);
+		fprintf(fp, "/usr/bin/tool system_u:object_r:%s_t:s0\n",
+			version ? "new" : "old");
+		assert(fclose(fp) == 0);
+		struct selinux_opt opts[] = { { SELABEL_OPT_PATH, fc },
+					      { SELABEL_OPT_DIGEST, "1" } };
+		struct selabel_handle *h =
+			selabel_open(SELABEL_CTX_FILE, opts, 2);
+		assert(h);
+		selinux_restorecon_set_sehandle(h);
+		unsigned before = attempts;
+		assert(selinux_restorecon_parallel(root, flags, threads) == 0);
+		printf("wildcard=%u threads=%zu version=%u target-writes=%u stored-dirs=%u last-label=%s\n",
+		       wildcard, threads, version, attempts - before, nentries,
+		       last_context);
+		assert(attempts - before == 1);
+		assert(strstr(last_context, version ? ":new_t:" : ":old_t:"));
+		before = attempts;
+		assert(selinux_restorecon_parallel(root, flags, threads) == 0);
+		assert(attempts == before);
+		if (version) {
+			before = attempts;
+			assert(selinux_restorecon_parallel(
+				       root,
+				       flags | SELINUX_RESTORECON_SKIP_DIGEST,
+				       threads) == 0);
+			printf("wildcard=%u threads=%zu skip-digest target-writes=%u last-label=%s\n",
+			       wildcard, threads, attempts - before,
+			       last_context);
+			assert(attempts - before == 1 &&
+			       strstr(last_context, ":new_t:"));
+		}
+		selinux_restorecon_set_sehandle(NULL);
+	}
+	assert(unlink(path) == 0);
+	snprintf(path, sizeof(path), "%s/demo/usr/bin", tmp);
+	assert(rmdir(path) == 0);
+	snprintf(path, sizeof(path), "%s/demo/usr", tmp);
+	assert(rmdir(path) == 0);
+	assert(rmdir(root) == 0);
+	assert(unlink(fc) == 0 && unlink(subs) == 0);
+	assert(rmdir(tmp) == 0);
+}
+
+int main(void)
+{
+	const size_t threads[] = { 1, 2, 8 };
+	for (unsigned w = 0; w <= 1; w++) {
+		for (unsigned t = 0; t < 3; t++) {
+			fflush(NULL);
+			pid_t pid = fork();
+			assert(pid >= 0);
+			if (!pid) {
+				alarm(20);
+				run(w, threads[t]);
+				fflush(stdout);
+				_exit(0);
+			}
+			int status;
+			assert(waitpid(pid, &status, 0) == pid);
+			assert(WIFEXITED(status) && WEXITSTATUS(status) == 0);
+		}
+	}
+	return 0;
+}
-- 
2.56.0

