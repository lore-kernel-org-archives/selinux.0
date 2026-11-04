Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804982;
	b=r+eN4aWQUGtLPaf9usRtvkNrhnKfyP8xG1zDkpZxKh1GLpNJyGFUE9y2yAf3rKg6EXQ9
	 VPNS3Xh0V4z4wq5sOwWUKTcE4brURQZzqMC6hbQjQBd6Up9b7dkv/ajhaDhvURiSDKfi2
	 A1f38Jl/Imalrc3rVkbtC8pZD3TRh3wW9xWLygiWOrmqxRKZ3pCa0xPGjBrEGs6XU4/Jn
	 5xlEN6zC8hRb+5jFnqNW2qQeCHkkHr6onlaXjmXwptU3liWeRxgeTZ6NYHR4Ka7uZK+he
	 YP5XIBOXERMW9QKdN73E/b6n2RJrVZ2+Dm95x5YegCUXetfFzn2WcTbjxduTN639jUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804982;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8XUYmGnp4EK5Vd4qflrujs0IjxV/dOxlI7eM5qItero=;
	b=3M+J/HlqT8lUhKV8nzaYw+UAs6+0QGN3JaatLAGxZMM6nNTCf7xnwbkEouMsIa5ahL0q
	 sPu6pgAjPIaYWl38CofORBHteIUxG5Pb7m1ke/GElnkmutBzpT75DSn+aIGe1Q9UkysU1
	 hDhp4fOySaMZIKAG+ZfA53UcF8kExC/tQMjRCKEnH0VrumLd8zURiy30pu5xEWkNEy1pq
	 +eyLzka4rVPo4I3470lW9JAG+5iLOOKuGra9BKzgBELSc/DB2rKEvVKoTYQha6dCJPY7H
	 Eyt2b0tFGxHtgri8NCS/ufsoyRJ1IgMxxLefmegfvy+wy8LyJFhiyOQbStE63frwxmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fiwcHah7;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E074606A336
	for <selinux@vger.kernel.org>; Wed,  4 Nov 2026 15:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E074606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fiwcHah7
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-53644b28706so11358581cf.3
        for <selinux@vger.kernel.org>; Wed, 04 Nov 2026 07:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793804981; x=1794409781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8XUYmGnp4EK5Vd4qflrujs0IjxV/dOxlI7eM5qItero=;
        b=fiwcHah7ERCDeVRk2lKpxIof0PLGUoj2EAEPIQpif93WKNS2OZH82M7nDlx9fPku/V
         w6UtlQrqDC0AGkM9uVaF4EA64oHFY6VaIIpMCzCT0iXjgoL8Lh+UwT74faOzmHWYPEOB
         6Is2lmdP3k4sIbqR7ckDci8nyhh2SQpUsvpBb4p2Ty5C2kNTd3txyKLPApshNhOHFUQy
         6z/GoIAYPkJZ1OZIbsF0FyrMopb5IYywgcOXpjr/bYPyumMskhwQPvGzogCz684mCrum
         seGCkWzF8kdvfAZd9mCOeJBQvRP2vhp508JthQoBDU8TCOHMJdfSpfgcepBVUjB3EViL
         ah9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804981; x=1794409781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8XUYmGnp4EK5Vd4qflrujs0IjxV/dOxlI7eM5qItero=;
        b=dDuIZNl78vVp0+OyU/hLb8W5lI0St41nVvx+6d7IpawN7YuOVZaomurKkV/gLn9OnS
         twHACB/4pw+NIS/9Tm+aKsoODtojtRTIznF5j0lkB/EfmWNZ5MrJPDq7K7sIdaCYE+8V
         sImlX+C1X7eEMtOe+FK/daDIakIjugfaZsTi3yJXT7YJe/PC58e88oxKpgjPQ+IzakUN
         IK11hrBvhU7jE0VVDQtDOfUIq1VNzD8uv+VMXqjNUN0yYSYCDGj5xRQo4gMIgC4gbz7P
         esz6Dvdof+NhkjLMjVskt02CPBvIyAecax3QJbBCcSoxl1vWnJPNTODdKqt0CKtZDLUe
         dYXA==
X-Gm-Message-State: APuU4Z/FnsGf0lWdDE36+qScvbQbHlva8Dt9P/q49h6NtbUNIWRLOyos
	8vhlX9wAHxYkHYAefMXnbZn2T+zDqY4e82RUQCLRW/He3tODU+94p1twIdwwibYI
X-Gm-Gg: AYBFou3+u8l3X+Wsw4TxFCfy0ujwwHnt33V/wtL2uHRaUIWfl5irmzyORRvDBvaeGBJ
	xjTmJ4G2R3J5lpvLb0f2dzdaNw1bEwx8tWkL7D6W6kpNF78g3kRznRzFMJuDvppT7K4VqnJA5yk
	gJS4Gh5XlezkCN1es0vqw5S7EEvLGzNOnTc0cRj7tx3+ISvIy0akRhZOu5GFOXarUThDgM2fEpx
	2aSfYNlFWC/gtBXrdEap34pl5MB/4gwIi5wpKkC3hXB577C5mVm4S5HasU5KXZ1DjTaT2VQIM53
	+xkrxjbEE7gzU1o6NvlA4i27CxndDBwMr6kbeQx6e/k8bf5hyhltSg60SdtnpmeWm/fABYbaHDe
	dPba++nycy3KCFgAcPgLXpP2pZuKEpt+RwfO0a8f4KXrzYJ4n+sV/NIOwLap/gjteUKRe0b7DSl
	g7qqLU4Vd9rwoFml5tz8GyMvhQOpkup+fGrsr1D2PnIwvrmfAl0VgZYzqZfluswPKbsoKem2ilD
	biUXrD0V5PaL//OXcW+EE60DGVXzpyDO4ydjMhAfMwmFqtv65CYULZ1sOjH7M+vl8llHJRdRPTB
	0sCOsA/ZNiU9o8Pf/vOYafTB35A/Py4N6uh6wBcPiKPTNemm/Az5xAGQWOzRURWtS4P1n/qJWxL
	9l/SnowHBrL53TX61edPxj6IXgl1wCVykB/dtW00kTDi49aQ6EQuXYJiIFDZGm7Dd9YYtBfD9en
	vRv2/2qNhfpS57K6AZqG0dgq1swsJuQot7WXPtcDWHJOBakCdeY9lMbYPXEpDn7CMip4cDtnRL
X-Received: by 2002:ac8:5ad5:0:b0:537:83ea:2fc6 with SMTP id d75a77b69052e-542b781d950mr274984761cf.58.1793804980560;
        Wed, 04 Nov 2026 07:09:40 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10cdc3d3sm25683041cf.28.2026.11.04.07.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 07:09:40 -0800 (PST)
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
Subject: [PATCH v3 08/20] libselinux: include substitution dependencies in directory digests
Date: Wed,  4 Nov 2026 10:09:03 -0500
Message-ID: <20261104150915.175923-8-stephen.smalley.work@gmail.com>
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

