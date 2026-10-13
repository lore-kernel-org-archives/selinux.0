Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776CE3FDBF7
	for <selinux@vger.kernel.org>; Tue, 13 Oct 2026 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899463; cv=none; b=Eu9nzQDY6c+S93PguK0uepS5s2SvjuMCeyZqFIBBXIXv8JG3P6W9o/NvrY4xXznfmeqzyV0olMXdI16E+Mo5Xpo/hJDrfUP1JOZcWI5K0iZ45zxWqWJUH+xJJRUHFxrj/NtX81V980kXGwWIcg3p+mvB7sOiYhlGlphppoCggjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899463; c=relaxed/simple;
	bh=lTPxVD4FKtGSfc6M/7fQEPAQGvVDGpPcbOgzrDV9S0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VtC/tX+MftxNVTZwBXM8pPqpQAucIQb2Jy133OcqWeYmJKpcCg9Tcd5lcnIqwC/6jW9faD8MF9UTQSbZKj/JQH5vFNdg/9c8zhQbB6x5rgU5YqgK/p3jmuqxBkPChyFe6/hOC6qipciowRTeWx7asVHBrD3wEh6s4gbm7KescDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6RGejQU; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6RGejQU"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91b83459526so21237516d6.2
        for <selinux@vger.kernel.org>; Tue, 13 Oct 2026 06:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791899461; x=1792504261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tq8+Rs7vGqU1gEycC+0Cg0m1KWF6jJ1JE080Kr96dP0=;
        b=D6RGejQUwwI5fPpHc9Gd2uSB+SiQeQuvwYtPTnwB7A0bHN4KhTUW5vmzqYFFIYAXph
         cevRYa6WoAmLqZcJQGUDohBK0CO16ocpFSWFxo5lSB80E0BByADBMM9SLpSh5m3tWJnr
         4xTAhamdi/fuEZNqUjdtbT8hPQqC7Ta8mBKV9qB8TGO/j5EPKlanZxF/wJRY8pcQnJRR
         vQxOtRCDG8pXot8dWuuBBgDy54dAFC/x620ah7gHhIc+HR4A9nC7RZykTSfG1xiLqQXv
         J++v3Rc1uBdo54Txp+JAoIa2kG7JjiR/luJs1sewe0v0H1did0B1NQCN7HLeqVePw/JV
         SiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791899461; x=1792504261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tq8+Rs7vGqU1gEycC+0Cg0m1KWF6jJ1JE080Kr96dP0=;
        b=i3E0i+Mciae3w2zIClJsEEyaRx1Zww/eWpG7fWZG+A8J3eYlmChvjvHnE8MXeFt5eX
         jHJFZ8aVjpzlxbc/QRfg3188y6TbQa6dIpjyLiSyFXh7TUHA9M4BBFM14ESslCCBExFU
         lnyQHdhgVA1iR3BX6bJ4jrT7djlR4krIP+mI/IekM5mu1SNFqPZ/bfhpapUW3tMsSS1h
         fGeiV9krPiVGLnhyPmHnGd7/8O+mZUmTe1BFl/OPmfFI4av4vbjSkzyXSHRdJH06uA4p
         g87BG1qwGnK0aGDrHjDOKmakncBFllLfOvySfTENkOovAqrBV6WjtX/jTFNN2+6qW0pG
         kBgg==
X-Gm-Message-State: AFq9FYI+asiyvmoSHD2PCDwAX+CEvJ3p0LJ/c6ip30SdbMIaVxT2TTgR
	JqjKjhV6kQ+cpN6TO/E3bkZGKtr03DbMw4SgfhzE40EoPBJMQTpQ5wLJCGbYHqxj
X-Gm-Gg: AYBFou379MBv9Ua4EJxWiN4O9wI8tgsDFkWR+cVjFU7eZw6kDfgwsWTIHHIWfnRKFvh
	TT2EoVBi+6dUbV2sJ43c+oWvcO0BqQH/YyqTFk6WlOt0VVHMjaY1Q/kqCLKAPG6aOKc0BkMI5K4
	Kp/k2tDYjWAgZVawQuro35MfGaeQy++KOO9dIBm/W5iE5n/gzBJg+5YU611w0C+0umwXBF1a2PK
	+T/aM5PAqyHiUnRdHrDLrXHJC67eWPmYlTasIC5UH6L0R7XSTb7dk7Q0SfjBvR+KXfEKodQD+/y
	zZay2qiarTks6dTY29YkO+i9i3y9eChy4LBqRU08ySTqpEVtMzgWYCaoWQU/d8x7F9RkM6Xt09C
	7sQmMOcBp6vUtTt5chnpyARB/cKzRNUVQ/xPWa9ErYAlzA3Gk6lwqwFFYXvHczYlxRb2XkYDbV7
	D1JxRmXYuuufOaJkJzmrEVWwku1Phyl1ja4kpxvHXIZLuh1Orw08uY+J0SmL+EbHLG/l4zWTfz/
	BjQGl1bIPKgavkT8JSaq4ayLgQ4PeN756tlKSjweIlRojQgLobndkqR7ET0/gOv2SfmBMYpO1M=
X-Received: by 2002:a05:620a:44d0:b0:939:f978:c1aa with SMTP id af79cd13be357-93ebd0d1425mr1921493885a.11.1791899461175;
        Tue, 13 Oct 2026 06:51:01 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93ef4f4986dsm245505385a.2.2026.10.13.06.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 06:51:00 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libsepol: clear attribute member set after building type_attr_map
Date: Tue, 13 Oct 2026 09:50:42 -0400
Message-ID: <20261013135042.217207-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

expand_module() populates each attribute's type_datum.type via
attr_convert_callback() and then uses that set to build the kernel
policydb's attr_type_map/type_attr_map in type_attr_map(). The ebitmap
is left in place on the datum afterward.

type_write() does not emit type_datum.types for a kernel policy, so a
policydb produced by policydb_read() always has it empty, and
policydb_validate() rejects a kernel-policy attribute whose types set
is non-empty. This makes a freshly expanded policydb fail validation
while the same policy round-tripped through a policy file passes.
Both in-tree fuzzers call policydb_validate() on the output of
expand_module(): the binpolicy fuzzer bails out before exercising the
write and decompile paths on the expanded policy, and the checkpolicy
fuzzer would abort() on any source policy that associates a type with
an attribute.

Destroy the ebitmap once the maps are built so the in-memory kernel
policydb has the same shape as one read back from a binary. This
covers both the kept and the expand-away (TYPE_FLAGS_EXPAND_ATTR_TRUE)
cases.

Adjust the expander CUnit test helper to read attribute membership
from attr_type_map on a kernel policydb, which is where it now lives
(and what is actually written out).

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libsepol/src/expand.c        |  6 ++++++
 libsepol/tests/test-common.c | 12 +++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index f7ff61cd..153b609f 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -2669,6 +2669,12 @@ static int type_attr_map(hashtab_key_t key __attribute__((unused)),
 				goto oom;
 			}
 		}
+		/*
+		 * The member set now lives in attr_type_map; drop it from the
+		 * datum so the kernel policydb matches what policydb_read()
+		 * would produce (type_write() does not emit it for KERN).
+		 */
+		ebitmap_destroy(&type->types);
 	} else {
 		if (ebitmap_set_bit(&p->attr_type_map[value - 1], value - 1,
 				    1)) {
diff --git a/libsepol/tests/test-common.c b/libsepol/tests/test-common.c
index 20449cf3..61a8fb6b 100644
--- a/libsepol/tests/test-common.c
+++ b/libsepol/tests/test-common.c
@@ -246,6 +246,7 @@ void test_attr_types(policydb_t *p, const char *id, avrule_decl_t *decl,
 		     const char **types, int len)
 {
 	ebitmap_node_t *tnode;
+	const ebitmap_t *members;
 	int j, new, found = 0;
 	unsigned int i;
 	type_datum_t *attr;
@@ -265,7 +266,16 @@ void test_attr_types(policydb_t *p, const char *id, avrule_decl_t *decl,
 	CU_ASSERT(attr->flavor == TYPE_ATTRIB);
 	CU_ASSERT(attr->primary == 1);
 
-	ebitmap_for_each_positive_bit(&attr->types, tnode, i) {
+	/*
+	 * On a kernel policydb attribute membership lives in attr_type_map;
+	 * type_datum.types is only populated on BASE/MOD or per-decl.
+	 */
+	if (!decl && p->policy_type == POLICY_KERN)
+		members = &p->attr_type_map[attr->s.value - 1];
+	else
+		members = &attr->types;
+
+	ebitmap_for_each_positive_bit(members, tnode, i) {
 		new = 0;
 		for (j = 0; j < len; j++) {
 			if (strcmp(p->sym_val_to_name[SYM_TYPES][i],
-- 
2.55.0

