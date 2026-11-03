Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732014;
	b=TEoHbzbTKc8sH7H3sWqx4Mz8cJKRVnBHSwDtlemxO/6iwvnHMv+40iNViuCN0j+soo36
	 IWJMJhz6ZZxoMeAUJilycduC2LgmgdtkIkcKPmM57tMfRnTgwwr1w/001x/xZIcFzcLiV
	 3rD3TMfZJWLngiB4SnvKBtjUo0Fw6MlyooUusl6mc/8HVPu84WlafEXP0bHiAsqwRtKAC
	 LCecf2T5ewPCInhlHrp0i/yzbeXB9FHnaEZtBY89knTtJo4UQIx6/FbBt8F8gfVG/hOw/
	 9gwbNHoxxDOTHZAfYZ0tKUo+/XN2i185I4CxHHAOB8rFvw9WhdZcuXYfQLGgd2fHSsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cFD2fzjk7IGKjKiTggYvZPsH9QofXFDvw8KTLAdAqDU=;
	b=k1R2g+yCd8krmC3Z1kTkYGmd4WaZ/OhaVBhwbpHo6B2x/FsNlo/Yx2Oh6CpjOkUdhZTM
	 ekw5WoM3XjHX7Hk6fkReDqdpCzttgpfX8lqGaP+3y84NwOafTVgnJP7z3BiVpnnLT18//
	 fFTV7sCqBSkJNcKmhTk4uT5/sOWLQaxHhfVj0mrj35zoyktQe530RtxChwbpLgIrsj1KD
	 th18O875d9SfiW64DlwU2bhtk4aTfnm0kaYDeHri3Z8fzaQMvB5gCvPjG3LPDyPMCx+zv
	 oqS87wnhbcO3pTXNA+FWstuDxY4qCGhqRGthMJ4x4XI3+a9XAbTeLTrS+hLeWz0G11A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="MC9M/hX/";
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B96F606A328
	for <selinux@vger.kernel.org>; Tue,  3 Nov 2026 18:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B96F606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MC9M/hX/
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91c763de878so33336466d6.0
        for <selinux@vger.kernel.org>; Tue, 03 Nov 2026 10:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793732013; x=1794336813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cFD2fzjk7IGKjKiTggYvZPsH9QofXFDvw8KTLAdAqDU=;
        b=MC9M/hX/an+SR6qkCrayzfe4E4Kxqr9Sh8pdFUj0p3V9zFnlXCTK9C1zeAgXSlfVLX
         7ge5RTHg/BhzR7Pu4JYNHvV69f97DdAN7IcVa8nAfitIttz3+M1qmv11ZNFC9xaxL/I7
         gT+Yir+5t06fQRzEJHreRJapg65YHvirPCR7QvqhOaq1WXxUuwlAj0ighy+Me2ozoyvA
         tjHdu1ztUFsd5bWqG3Ajy4B+dc47nbxRYLkDPJNKtb5gdl0j1LfQS17VlZgVvTKiN3T8
         7t6sTIVz/fbUntC9ZK23pHdEx2orEWRL8ysYzouqur0ZGun1R3P7jITBPdz1TOrsRfyx
         +ueA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732013; x=1794336813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cFD2fzjk7IGKjKiTggYvZPsH9QofXFDvw8KTLAdAqDU=;
        b=idHmZ4HBBo3W9FN9ShojFj+dOv+HE/urrhMNoTU1tHJQYhVJflrseYmsUDE07jK2YP
         zDkwWW1w7651R5N97FnO5xiXe/ug/0pcnPWjgLDFT22jOiEzzCBZ1ZSVeGH8t846W/W0
         nbtN25kE+H5qOLppRnkvBNCCU5D18qtrc1ZAVp6IIEnjuzV3bmDdjJW/Nwq+s0o7i4el
         yAgZ821ANO1kiosUyUXg4bZvr4bQEjCWcf6e3y8lCMnxZdOaFvHz4rf5t1twhaq8DT6C
         F34nFUJcwSZWomnDkvUNaAVoMBXVU56tW+BkJ/cNXpE348BG9fqG6JW8FpBjb6+lN2u1
         6gFA==
X-Gm-Message-State: APuU4Z9Lizq0QEzCnQaR6Ofg5DboAZhTsm0mnwQdOL6sxKetgV5wqZQT
	Oey073EPu0mdK08SBI+9MibzFFCMDQfGL0TGrLMP3i06t4hBuXGdu4WS4sebjygn
X-Gm-Gg: AYBFou3j2k97xLiIfsoZkXWDMBz5yxyUKeELo9yYxA9Z6zuT4OhUEZY+/DlzMPCEweT
	08Kk5NwmFGkR5blsQf42LJwcj/dkhB5+HDBcDOTmOUVpVfBFnkS+9IJO1lTPVATJ4sWFvkYWlXL
	A9JmmN1lFPXuXZk25tOWOoaDIo3qf1S4aA4whNnijweFvcxQ8pHd+i0uugNDfOQoNZu/leZ1E+x
	11xgo1ZeVQIweFyfTNJcG2R5hkemdWham4dfSehuQ7/7hhHNqJGlb4fobUg1/OIssN42f6U6sH3
	d/DYnvmFhsr8tSbTBAonH5HEKRc6kqhsypdyKL9W8atSXu6MV9Fdb0kltrNbPituZAr5NPZ8dox
	74MffKbniTjMWg9K6K76/s4rmXqB4G8U4LSUNu9ikQnCFtbSg4qnaOfTYC4byStQLFWhcUIYztI
	NPIRNbUaASUNuPI3PcV4yolkqiLxX2tM40bedmrQCboPzMhOQXr1Es9U6vzV5AC94kWkMdvXSHf
	NMvoFKZM4/cSGocAQvZVwSIuN+AfG7qlLl1axWINBzwc8l8MZXhVrw2IELRnTsSULo9NLmzggLV
	6BBiYox2Ots7tLSOt9FRQ4xaUIofm+WysXsx2bQftLL/gzgQOcGEBUzrhu08lgbxe5HJFMO+J4+
	RYl2DCaDhsfsDlaKwgqBVcUyZskTimkdjAhaaenoNOQVzJ3VVuJ1AmEqD3+eVA2wlzijDcAGkE1
	gMATLvspfm3kTGjvliQG5fOUi+cfgHoVi7aoNDP0YtlIGwyyteARI=
X-Received: by 2002:ad4:4ead:0:b0:912:517b:7bdf with SMTP id 6a1803df08f44-91ca4b92850mr232920356d6.42.1793732012798;
        Tue, 03 Nov 2026 10:53:32 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7c7881desm234016d6.29.2026.11.03.10.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:53:32 -0800 (PST)
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
Subject: [PATCH v2 12/20] libselinux: preserve auxiliary file-context duplicate handling
Date: Tue,  3 Nov 2026 13:52:59 -0500
Message-ID: <20261103185307.45924-12-stephen.smalley.work@gmail.com>
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
 libselinux/tests/.gitignore                  |   3 +-
 libselinux/tests/Makefile                    |   7 +-
 libselinux/tests/test_auxiliary_duplicates.c | 171 +++++++++++++++++++
 4 files changed, 190 insertions(+), 8 deletions(-)
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
index a699b328..dff32587 100644
--- a/libselinux/tests/.gitignore
+++ b/libselinux/tests/.gitignore
@@ -9,4 +9,5 @@ test-restorecon-digest
 /test-substitution-restorecon
 /test-readable-fallback
 /test-digest-inputs
-/test-load-policy-version
\ No newline at end of file
+/test-load-policy-version
+/test-auxiliary-duplicates
\ No newline at end of file
diff --git a/libselinux/tests/Makefile b/libselinux/tests/Makefile
index b112523e..bc3ce5bc 100644
--- a/libselinux/tests/Makefile
+++ b/libselinux/tests/Makefile
@@ -20,7 +20,7 @@ test-restorecon-errno: test_restorecon_errno.c ../src/libselinux.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(addprefix -Wl$(COMMA)--wrap=,$(ERRNO_WRAPS)) $(PCRE_LDLIBS) -ldl -pthread
 
 .PHONY: test clean
-test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs
+test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs test-load-policy-version test-auxiliary-duplicates
 	./test-restorecon-digest
 	./test-restorecon-errors
 	./test-restorecon-errno
@@ -32,6 +32,8 @@ test: test-restorecon-digest test-restorecon-errors test-restorecon-errno test-r
 	./test-substitution-restorecon
 	LD_LIBRARY_PATH=../src ./test-readable-fallback ../utils/sefcontext_compile
 	./test-digest-inputs
+	./test-load-policy-version
+	./test-auxiliary-duplicates ../utils/sefcontext_compile
 
 clean:
 	rm -f test-restorecon-digest test-restorecon-errors test-restorecon-errno test-restorecon-exclude test-restorecon-xdev test-label-init-oom test-label-merge test-substitution-hash test-substitution-restorecon test-readable-fallback test-digest-inputs
@@ -58,3 +60,6 @@ test-digest-inputs: test_digest_inputs.c ../src/libselinux.a
 
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

