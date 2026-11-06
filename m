Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988375;
	b=IaFf58TTlOZY60+HJ8jS4juHMEgtCEyHWAeI5T4S9lwQPKuThZ66EOX5XeVdarhp9RnE
	 MEptcZMXoGOoA3mu0c0E+xSQj7r26t0v5BaZKKyiYON3KbbwNptihoo4A1E4Qbs5oXyYy
	 EQmxuUBAQYvadDJWsIAQBXwb+yVNWV4CWJ+2+ya7zb9kLR8RHIkaUI+NUittvg9WLjiM6
	 3YnftPMSQNNueE0WAv9ZKeasImGWxNgyt/LaKsJFYbH6Ix69MgfF3WJXr5eVcAzrRogH4
	 v/JCATXricdez7GKrqN1CdBvnbYWs6hpSgSn7jjhnmxlvxTq48uLKNL+BmdTwNAcaJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988375;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tfuvyZYevfnmOg2ZE5INf1rWkCSZtauqr6FRT5O//xQ=;
	b=vpB1erJrP0s1S0GfH2ksSW6Ot+O+m7at9zoyMMLI6nScT+Ok6aRTmdU5aZiQ0KXnOPkI
	 5LVgf6dCXrh5cUAY37i4mJITvW5HXaZaHPOwKhpTbRtacbBKM0EcJE68quD6stBniBIOw
	 /jQHaLdjyJDtJoM7MfCrICyZjaWbQMS59W5yGknU65eTfrqvalm0lYmgRBOq9JmO4CgiL
	 v3ognmRwfFaMKQAM7aS9ycUM8ZQLt6kUcnfxwynfz8EsNAMpfZVJxDu+KDA3OZKHiQGY0
	 bx6xcL+/JLz4XPJWUKwaRqt6P+F4sLp8e5tLw+mlony/+nHFhjZpWVlsshqO8PvxhMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=diD9U1qh;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823EF606A32E
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 18:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 823EF606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=diD9U1qh
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5430f70c827so10446731cf.2
        for <selinux@vger.kernel.org>; Fri, 06 Nov 2026 10:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793988374; x=1794593174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tfuvyZYevfnmOg2ZE5INf1rWkCSZtauqr6FRT5O//xQ=;
        b=diD9U1qh6vlXXrPrGk1rSXmgIyo70iePlGZ+GU6sfGA2eCOQnKnj7P74McGiXPJwfu
         VlomCLjRl/6RjFixVsQLHl9aSXv3FkMTKpaqIR3xOlcwccUePs/Ah4Q4IkqHUkQqPjtQ
         vWLke3DDCsQfyyhy1noFdeS+8WPQ78PkJyoPt/eclZPlIyVqKULfNqk2Jgh9KNCKtGeA
         AsC24i0E4vbKQXJPX4jjZx2soYBQAkvcf4H6e/8FFYiGR8zZ0TGZXQPSst6nDKRtB/6W
         NJgNzRwRe61V3/l+wwTvHbnhzL4l0EijcmNF+ui6MZJk5sRGoGG7lEKpNPj/u14C0q7M
         5flQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988374; x=1794593174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tfuvyZYevfnmOg2ZE5INf1rWkCSZtauqr6FRT5O//xQ=;
        b=eRD1tVCmiiqrVFZCNUicwblFB6TuvGLcTsy5g/1TC0+CogK86co6UiC6yDDFk3WS6m
         Rtn2THfk92ikgxqze5Y6eH+zD2TGISABiksGvO34D28aFcFG5XtWHubdLkEHRQAp97Po
         xrv3P7KkU09MRinSjm/HqV3z0KzvdT9HRV3Mav/GFz2Z1T+tOvNW27+vz6dOabmEXL7o
         kCKeIcXG8GOnxuQlKhKRQtnQneS5IwWP/7dmOK9SuUVGEE0Whju3uge0dx6mYIPERh0u
         lvgrsuuyQsyWT7WjFkq8ThD2WHnUL7us0NFm8Qp4pstWguVXs4WLIxu41AQYY1UPW3do
         CeTg==
X-Gm-Message-State: APuU4Z/h2wrtydTtDrF/iXwlDTdvtcoUMZR/a5yt5YmsjHoiFSCj+jk2
	9/Gm5RgGP6SIIrfpKXwULVVCfUE0stAxSelUsxhwdD3ilvCIGdCJxKfQsW4xnrg4
X-Gm-Gg: AYBFou0GMr+8ZPsckurn28xkAtBJWKo4FCFsEY17o/djYVTRgjtRiKTb0p1nchfuYGQ
	p6NGsPY0yedzu7o4OV3zW25dCkg/oAEbdMrReAdqtAB3LGtb/jS4ZuUvngAGIYn0rML/7tAjs0t
	F2vuZ6Ex89ty+cLr6HX0xKHmhmB1Ulo6s0ynxuROhM6dSlpIE+rTLSPA7Ehptj4GZRGIZAzx57C
	oE6ddGem0/pqYM+3acfqJDSAfdHYeQEEPVzr9qBC7t1KrfkMpS3XrNheAJ4Ty8Mxo61fo/5Qedt
	R7EK2vaBqDY6YB4h+NQsqV++50QZv3sg8K7frv0osRshhFtCwspKIXoZI0V9ntvJFh4unz4OM61
	l+STiUBfZTqKyKrbxvhMr02yr0a9Hu1534tVUS0smOUQUQ6ODvMqPBU6ZlHuX/ojZzN5HnQylI7
	tyoh5rvGnf704JHJD+q37k0ichOeG9+EoMfZnwgOvCNbIKF07lZqf4vRbXBVm86XcfWvnwt3wLA
	hyNicpltTx7je158afAsDWf+nDx+4CwIBVQWDPtQRmbrUcE5j9K747MY4aDhJLL+0QzfMAUNXie
	B8SRFFOUuseacKQ6BcEO7fLYs1MzLmcU0uuO7UwPt/SUyEYxvSdejFvOgyfss3SVSaHMVQHHwIQ
	IPZwkXHpcSn2H+knl4vFYJhmqByevU+v43d72ZYj1GAIzYlcQPB80acB1qaCFyI3hGurDC5ehn3
	nE5knCSuw+I3X3MgKzF7/6u3+ATtjZUyIHx1FxMFhbDjJrCJiVD24=
X-Received: by 2002:ac8:5f0c:0:b0:536:7dd:16b3 with SMTP id d75a77b69052e-54e1596c274mr48957391cf.75.1793988374449;
        Fri, 06 Nov 2026 10:06:14 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e26259cf0sm25893461cf.15.2026.11.06.10.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:06:14 -0800 (PST)
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
Subject: [PATCH 4/4] libsepol: validate cached boolean IDs without limiting expression size
Date: Fri,  6 Nov 2026 13:05:56 -0500
Message-ID: <20261106180556.243798-4-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106180556.243798-1-stephen.smalley.work@gmail.com>
References: <20261106180556.243798-1-stephen.smalley.work@gmail.com>
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

COND_MAX_BOOLS bounds the boolean ID cache and truth-table precomputation,
not the number of booleans permitted in a conditional expression.
cond_normalize_expr() records the first COND_MAX_BOOLS IDs while allowing
nbools to exceed that value, and cond_expr_equal() handles larger
expressions without using the cache.

validate_bool_id_array() rejects nbools >= COND_MAX_BOOLS. This rejects
valid compiler-produced expressions with five or more booleans, although
the same policy can be serialized and read successfully because the
derived cache is not serialized. The checkpolicy pre-write validation
added by 37344cd06d84 exposes this as a source compilation regression.
The proposed secilc pre-write validation exposes it as well.

Validate only the populated, bounded portion of bool_ids. The complete
expression continues to be checked by validate_cond_expr().

Add a standalone libsepol regression for 1/4/5/6/8 booleans, rebuilding
the cache after a binary round trip to obtain reader-side invariants.
Check expression evaluation and reject invalid cached and expression IDs.
Add checkpolicy source/binary round trips with and without optimization.

Fixes: 0861c659b59c ("libsepol: Validate policydb values when reading binary policy")
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 checkpolicy/Makefile                          |   1 +
 checkpolicy/tests/test_conditional_count.sh   |  34 ++++++
 libsepol/.gitignore                           |   1 +
 libsepol/src/policydb_validate.c              |   6 +-
 libsepol/tests/.gitignore                     |   1 +
 libsepol/tests/Makefile                       |  12 +-
 .../tests/regression/test_conditional_count.c | 114 ++++++++++++++++++
 7 files changed, 162 insertions(+), 7 deletions(-)
 create mode 100644 checkpolicy/tests/test_conditional_count.sh
 create mode 100644 libsepol/tests/regression/test_conditional_count.c

diff --git a/checkpolicy/Makefile b/checkpolicy/Makefile
index 22c32a25..d974d156 100644
--- a/checkpolicy/Makefile
+++ b/checkpolicy/Makefile
@@ -54,6 +54,7 @@ lex.yy.c: policy_scan.l y.tab.c
 test: checkpolicy checkmodule
 	./tests/test_roundtrip.sh
 	./tests/test_checkmodule_negative.sh
+	sh ./tests/test_conditional_count.sh
 
 # helper target for fuzzing
 checkobjects: $(CHECKOBJS)
diff --git a/checkpolicy/tests/test_conditional_count.sh b/checkpolicy/tests/test_conditional_count.sh
new file mode 100644
index 00000000..e0fde192
--- /dev/null
+++ b/checkpolicy/tests/test_conditional_count.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+set -eu
+
+BASEDIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
+CHECKPOLICY=${CHECKPOLICY:-"${BASEDIR}/../checkpolicy"}
+OUTDIR=$(mktemp -d "${TMPDIR:-/tmp}/conditional-count.XXXXXX")
+trap 'rm -rf "$OUTDIR"' EXIT HUP INT TERM
+
+for count in 1 4 5 6 8; do
+    {
+        printf '%s\n' 'class file' 'sid kernel' 'class file { read write }'
+        i=1
+        expr=b1
+        while [ "$i" -le "$count" ]; do
+            printf 'bool b%s false;\n' "$i"
+            if [ "$i" -gt 1 ]; then
+                expr="($expr || b$i)"
+            fi
+            i=$((i + 1))
+        done
+        printf '%s\n' 'type test_t;' 'allow test_t self:file read;'
+        printf 'if (%s) { allow test_t self:file write; }\n' "$expr"
+        printf '%s\n' 'role test_r;' 'role test_r types test_t;' \
+            'user system_u roles test_r;' 'sid kernel system_u:test_r:test_t'
+    } > "$OUTDIR/policy.conf"
+    for optimize in '' '-O'; do
+        # The optional flag is deliberately unquoted when empty.
+        "$CHECKPOLICY" $optimize -o "$OUTDIR/policy.bin" "$OUTDIR/policy.conf"
+        "$CHECKPOLICY" -b -F -o "$OUTDIR/roundtrip.conf" "$OUTDIR/policy.bin"
+        "$CHECKPOLICY" $optimize -o "$OUTDIR/roundtrip.bin" "$OUTDIR/roundtrip.conf"
+        cmp "$OUTDIR/policy.bin" "$OUTDIR/roundtrip.bin"
+    done
+done
+printf '%s\n' 'conditional count: 10 compiler round trips passed'
diff --git a/libsepol/.gitignore b/libsepol/.gitignore
index abfb603b..2e7dc4cb 100644
--- a/libsepol/.gitignore
+++ b/libsepol/.gitignore
@@ -5,3 +5,4 @@ utils/sepol_compute_member
 utils/sepol_compute_relabel
 utils/sepol_validate_transition
 libsepol.map
+tests/regression/test_conditional_count
diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index 7a7c613b..27a6917c 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1341,10 +1341,8 @@ static int validate_bool_id_array(sepol_handle_t *handle,
 {
 	unsigned int i;
 
-	if (nbools >= COND_MAX_BOOLS)
-		goto bad;
-
-	for (i = 0; i < nbools; i++) {
+	/* Larger expressions only cache their first COND_MAX_BOOLS IDs. */
+	for (i = 0; i < nbools && i < COND_MAX_BOOLS; i++) {
 		if (validate_value(bool_ids[i], boolean))
 			goto bad;
 	}
diff --git a/libsepol/tests/.gitignore b/libsepol/tests/.gitignore
index c3f60fd2..e2c3eb78 100644
--- a/libsepol/tests/.gitignore
+++ b/libsepol/tests/.gitignore
@@ -1 +1,2 @@
 libsepol-tests
+/regression/test_conditional_count
diff --git a/libsepol/tests/Makefile b/libsepol/tests/Makefile
index 273373b0..a47b452d 100644
--- a/libsepol/tests/Makefile
+++ b/libsepol/tests/Makefile
@@ -57,7 +57,7 @@ $(EXE): $(objs) $(parserobjs) $(LIBSEPOL)
 	$(M4) $(M4PARAMS) -D enable_mls $^ > $@
 
 clean: 
-	rm -f $(objs) $(EXE)
+	rm -f $(objs) $(EXE) regression/test_conditional_count
 	rm -f $(policies)
 	rm -f policies/test-downgrade/policy.hi policies/test-downgrade/policy.lo
 
@@ -67,9 +67,15 @@ clean:
 #   you should either link runtime to your application or manually preload it with LD_PRELOAD
 #
 # when the source code is built with ASan
-test: $(EXE) $(policies)
+test: $(EXE) $(policies) test-conditional-count
 	$(ENV) -i $(MKDIR) -p policies/test-downgrade
 	../../checkpolicy/checkpolicy -M policies/test-cond/refpolicy-base.conf -o policies/test-downgrade/policy.hi	
 	./$(EXE)
 
-.PHONY: all policies clean test
+regression/test_conditional_count: regression/test_conditional_count.c $(LIBSEPOL)
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBSEPOL)
+
+test-conditional-count: regression/test_conditional_count
+	./regression/test_conditional_count
+
+.PHONY: all policies clean test test-conditional-count
diff --git a/libsepol/tests/regression/test_conditional_count.c b/libsepol/tests/regression/test_conditional_count.c
new file mode 100644
index 00000000..a19dd90d
--- /dev/null
+++ b/libsepol/tests/regression/test_conditional_count.c
@@ -0,0 +1,114 @@
+#include <assert.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include <sepol/cil/cil.h>
+#include <sepol/policydb/conditional.h>
+#include <sepol/policydb/policydb.h>
+
+#include "../../src/policydb_validate.h"
+
+static void check_count(unsigned int count)
+{
+	const char *base =
+		"(handleunknown deny) (mls false) "
+		"(sid kernel) (sidorder (kernel)) "
+		"(sensitivity s0) (sensitivityorder (s0)) "
+		"(user system_u) (role test_r) (type test_t) "
+		"(userrole system_u test_r) (roletype test_r test_t) "
+		"(userlevel system_u (s0)) (userrange system_u ((s0) (s0))) "
+		"(sidcontext kernel (system_u test_r test_t ((s0) (s0)))) "
+		"(class file (read write)) (classorder (file)) "
+		"(allow test_t self (file (read))) ";
+	char text[8192], expr[2048], next[2048];
+	cil_db_t *db;
+	sepol_policydb_t *compiled, *loaded;
+	cond_node_t *cond;
+	cond_expr_t *last_bool = NULL;
+	void *image;
+	size_t image_len, used;
+	unsigned int i, slot;
+	uint32_t saved;
+	int n;
+
+	assert(count > 0);
+	used = strlen(base);
+	memcpy(text, base, used + 1);
+	strcpy(expr, "b1");
+	for (i = 1; i <= count; i++) {
+		n = snprintf(text + used, sizeof(text) - used,
+			     "(boolean b%u false) ", i);
+		assert(n > 0 && (size_t)n < sizeof(text) - used);
+		used += n;
+		if (i > 1) {
+			n = snprintf(next, sizeof(next), "(or %s b%u)", expr,
+				     i);
+			assert(n > 0 && (size_t)n < sizeof(next));
+			memcpy(expr, next, (size_t)n + 1);
+		}
+	}
+	n = snprintf(text + used, sizeof(text) - used,
+		     "(booleanif %s (true (allow test_t self (file (write)))))",
+		     expr);
+	assert(n > 0 && (size_t)n < sizeof(text) - used);
+	used += n;
+	cil_db_init(&db);
+	assert(cil_add_file(db, "conditional-count.cil", text, used) == 0);
+	assert(cil_compile(db) == 0);
+	assert(cil_build_policydb(db, &compiled) == 0);
+	assert(compiled->p.cond_list->nbools == count);
+	assert(sepol_policydb_to_image(NULL, compiled, &image, &image_len) ==
+	       0);
+	assert(sepol_policydb_create(&loaded) == 0);
+	assert(sepol_policydb_from_image(NULL, image, image_len, loaded) == 0);
+	free(image);
+
+	/* Rebuild the derived cache on a reader-shaped policydb. */
+	cond = loaded->p.cond_list;
+	assert(cond && !cond->next && cond->nbools == 0);
+	assert(cond_normalize_expr(&loaded->p, cond) == 0);
+	assert(cond->nbools == count);
+	assert(policydb_validate(NULL, &loaded->p) == 0);
+	for (i = 0; i < count; i++) {
+		assert(cond_evaluate_expr(&loaded->p, cond->expr) == 0);
+		loaded->p.bool_val_to_struct[i]->state = 1;
+		assert(cond_evaluate_expr(&loaded->p, cond->expr) == 1);
+		loaded->p.bool_val_to_struct[i]->state = 0;
+	}
+
+	slot = count < COND_MAX_BOOLS ? count - 1 : COND_MAX_BOOLS - 1;
+	saved = cond->bool_ids[slot];
+	cond->bool_ids[slot] = 0;
+	assert(policydb_validate(NULL, &loaded->p) == -1);
+	cond->bool_ids[slot] = count + 1;
+	assert(policydb_validate(NULL, &loaded->p) == -1);
+	cond->bool_ids[slot] = saved;
+
+	for (cond_expr_t *e = cond->expr; e; e = e->next) {
+		if (e->expr_type == COND_BOOL)
+			last_bool = e;
+	}
+	assert(last_bool);
+	saved = last_bool->boolean;
+	last_bool->boolean = 0;
+	assert(policydb_validate(NULL, &loaded->p) == -1);
+	last_bool->boolean = count + 1;
+	assert(policydb_validate(NULL, &loaded->p) == -1);
+	last_bool->boolean = saved;
+	assert(policydb_validate(NULL, &loaded->p) == 0);
+
+	sepol_policydb_free(loaded);
+	sepol_policydb_free(compiled);
+	cil_db_destroy(&db);
+}
+
+int main(void)
+{
+	const unsigned int counts[] = { 1, 4, 5, 6, 8 };
+
+	for (size_t i = 0; i < sizeof(counts) / sizeof(counts[0]); i++)
+		check_count(counts[i]);
+	puts("conditional count: 5 sizes and 20 invalid-ID controls passed");
+	return 0;
+}
-- 
2.56.0

