Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62610481250
	for <selinux@vger.kernel.org>; Mon, 14 Sep 2026 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789401494; cv=none; b=p91NVx10C/VwboLIL6YSSfZUSOhn406S9D4kYYTgc9MIg0AKqKgFsEUXLqW5h4/Mbpeu0BjdUGWrzBGtBOBqwNn5TDFAVbBVvNbImqLlLIvPl6qTyKBx9ayZQZnYjqiqfoLA1sSPSFMKTUE2A4zX622ujMLpQxdRM9uzrtrL4PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789401494; c=relaxed/simple;
	bh=7tTNtVVEUoNRrIQfRzDo3JZ925XC/7nxtpNxYSCtqi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fnDXbnVMNC04Vh5r3zaWwtv3s9FLFVCfnhN6L/JfFmsFbsLlR7zKl264tZygvd3k1yKo7wOt7GhbiyNGtNpHoMh4YGaL83ytRk/n11n0WUjDnlm0s17BFsCU5Lp01r8+NRhq7jekwF//Wg60AgTsZm6k6HT5lQURG4nSYmXYSvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Omm1G//P; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Omm1G//P"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-9106f4c3a4dso45186846d6.1
        for <selinux@vger.kernel.org>; Mon, 14 Sep 2026 08:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789401491; x=1790006291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=grF3J8PfqkumohdNsR8HC5b0lcM05W03etyzlbDrsBY=;
        b=Omm1G//Pt+qofxpd041yAteTttx7dhZDd7k38fynCQWAtDnkbXm7870mg7hRxvkO6w
         4Ss04oJNXve4fVkDT6IqT2nBwFtxrOlLDKVCfFFC9ADurScKrU/KlRyxqhH/yBKVC5sg
         zaPryCxfYOTssBlG8k28pOk2gqM0zy0XJgZrWgNsXAyklO3FWQyjQfI0ndytjsfz25+B
         RObgQtG8lBxKFtkyY+fQGuYMlRWJzZKaCBT+qFughENNaG9PEXAfs+Suji2wcaeDF9Bo
         qQKVdqEMeUZM023plG7d/cLQZDQOHPBvxqpc8XzP2Q+qaPbEwTFbvjFlTAfa2FbHPW+f
         uQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789401491; x=1790006291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=grF3J8PfqkumohdNsR8HC5b0lcM05W03etyzlbDrsBY=;
        b=ZEdkZpJbKWaNGg143Ws1AAcfX4XMM5nQg3iqfUn8mehWYfKssbbnMDUPaXzxW8A9JB
         vnC9lErnuIVOPqNC8cjHkY0iyiravug1T+fzAwNsLq6w7MFccOFAVn+Dg0cFySVGZ19M
         3xI6Szc3TVS4TCYltA1VpJkrQ02QjmDSmAsF9LD1FJVeaPGdvNfEtQwLCm4QBO7jDmGD
         4Qgg7j3KlYWnyDRlt/QqofR/+fRCXaOw9qGrnzO4J7lzrjsIBLFITebFh9CGTAyDwum2
         6bK0ukbgx7DFYHJAoLDrdEB5HqYLpXunljRSYjQ5LRYErikdji/6GsNBwxbqJU2iophH
         rQ5A==
X-Gm-Message-State: AFuF++muZYK8Fxn7GdAP05c/Kb2+qzgnXIluiYkLSBtgJHzPg6lEjLn+
	+NWFN+rt58bwzyuPwKuHneWjuFDqm0AmRJL1WfQDH0/MxkrxCTpl/qB4nGc1EA==
X-Gm-Gg: AYBFou3Y4Hja1nl/25ZOzxtWmXe9GFmNZe2UB88sfMrag83IyNqlPzpGNdmNrE16si5
	k/j+CQHUCFshru57GPn6rGEH28dVC+ZcsWV8JjaMASAcIL8DLJhHVNe8Ne/S26M89fW0Saj9Sl+
	r/FDMixzTni6TE5x59wor1okPFPaWYnriPJJU/AxaK2nDSGBQj+b5DbHxjSbANGwwQo8ST8SE5b
	ex5yD1TrdbzLJVR+HuQdsVcYrxUhBzAWML/UERpIn5tJVg1zx9PfNsio3+DiVHKwSdXlgNv+bGR
	jx7Yqh44YKC33+oh1dIFwgkg2wtUAEOuIKJdROr9SGc7JBhQpdZ2TPJjOQrgdvHeQ1MKRmMAHH4
	3wvMEaoIi799lp4x5YCE2ffX6E8dYbG75dAmW+SQKm6lUYXlCzXTVYWcTFCGLguFXtQ3EwG9CQo
	90ECZln0PIedP4dAhiAfVOL20wQ0Y59yJYFGlDT356nksy/TXY0T7Elgb8CxO6FmMbBANSUhOZa
	5ZVf8p2A65x9OOJrTDsJAQcnXQy8ea1DKXhLpzR0PauA+eXw48FV3+oeBsabydPaKtPQlkVJYJK
	UhT1M+W1Fw==
X-Received: by 2002:a05:6214:319b:b0:910:39f5:3747 with SMTP id 6a1803df08f44-9122e4ce8f4mr45212306d6.2.1789401486375;
        Mon, 14 Sep 2026 08:58:06 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f2020e6sm97962816d6.7.2026.09.14.08.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 08:58:05 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsepol: module_to_cil: warn and drop non-trivial -self neverallows
Date: Mon, 14 Sep 2026 11:57:51 -0400
Message-ID: <20260914155751.27077-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CIL has no target syntax for a neverallow whose target is an arbitrary
type set with self subtracted. The (notself) syntax is the universe
minus self and the (other) syntax is the source set minus
self. module_to_cil emits (notself) for the trivial ~self case but
fails any other notself rule with a target set.

That construct is legal in the source language and checkmodule emits
it into POLICY_BASE/MOD binaries; the assertion checker handles it,
and semodule_link/expand accept and preserve it. So a validated module
carrying

    neverallow SRC { TGT -self } : CLASS PERM;

reads and validates but fails hll/pp, and now also aborts the fuzz
harness that treats a validated module failing module_to_cil() as an
invariant break.

There is no valid CIL translation and refusing the module in the
validator would break the tools that do handle it. Downgrade to a
warning and skip the rule instead of failing. The dropped rule is a
neverallow assertion, not an enforcement rule, so the emitted CIL
produces a policy that is no more permissive than the input; the
assertion is simply not rechecked at CIL compile time.

Hoist the check to the top of the loop so that the lmx/lme line
markers stay paired for the rules that are emitted.

Reported-by: oss-fuzz
Fixes: https://issues.oss-fuzz.com/issues/561210454
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/src/module_to_cil.c | 40 ++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 6876bd76..baf98ab0 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -1257,6 +1257,31 @@ static int avrule_list_to_cil(int indent, struct policydb *pdb,
 	struct type_set *ts;
 
 	for (avrule = avrule_list; avrule != NULL; avrule = avrule->next) {
+		if ((avrule->flags & RULE_NOTSELF) &&
+		    (!ebitmap_is_empty(&avrule->ttypes.types) ||
+		     !ebitmap_is_empty(&avrule->ttypes.negset))) {
+			/*
+			 * CIL has no target syntax for "T minus self":
+			 * (notself) is the universe minus self and (other) is
+			 * the source set minus self. A neverallow with a
+			 * non-trivial target set and -self therefore has no
+			 * representation. Drop it rather than fail the whole
+			 * conversion; the rule is an assertion, not an
+			 * enforcement rule, so the resulting policy is no more
+			 * permissive.
+			 */
+			if (avrule->source_filename) {
+				WARN(NULL,
+				     "%s:%lu: neverallow with a non-trivial -self target is not representable in CIL, dropped",
+				     avrule->source_filename,
+				     avrule->source_line);
+			} else {
+				WARN(NULL,
+				     "neverallow with a non-trivial -self target is not representable in CIL, dropped");
+			}
+			continue;
+		}
+
 		if ((avrule->specified & pdb->line_marker_avrules) &&
 		    avrule->source_filename) {
 			cil_println(0, ";;* lmx %lu %s\n", avrule->source_line,
@@ -1270,21 +1295,6 @@ static int avrule_list_to_cil(int indent, struct policydb *pdb,
 		}
 
 		if (avrule->flags & RULE_NOTSELF) {
-			if (!ebitmap_is_empty(&avrule->ttypes.types) ||
-			    !ebitmap_is_empty(&avrule->ttypes.negset)) {
-				if (avrule->source_filename) {
-					ERR(NULL,
-					    "%s:%lu: Non-trivial neverallow rules with targets containing not or minus self not yet supported",
-					    avrule->source_filename,
-					    avrule->source_line);
-				} else {
-					ERR(NULL,
-					    "Non-trivial neverallow rules with targets containing not or minus self not yet supported");
-				}
-				rc = -1;
-				goto exit;
-			}
-
 			num_tnames = 0;
 		} else {
 			ts = &avrule->ttypes;
-- 
2.55.0

