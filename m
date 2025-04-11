Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBB3A94F
	for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 01:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744333564; cv=none; b=hI5IH++GWhxy4Eg79o8AuMIQ+b4B3ADXDrTUp+xUgQFIVwuIZT7Tn6fxOq/qAQe/tTGKZhHNYWb8n0DqgdQUjlr0gvVqd8elu2Z2OrT2QM/mtlTr9aAc8JEWwUZ+fRroY5mC4ptTqsyjyDBqrXBpkvwmHfUoeha+0etFCwR5L9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744333564; c=relaxed/simple;
	bh=xDZmb+qEQ006Nbc5py6+3jHVng3RQ+sGn+sS6Nwot1I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nS0JwyuD0zvc6Tbb589lChoCWf6IawGgFWD66v1YHEaPfygP5Dp7EhBndIYiBNsihujxIHFY+zHWAvLJiU2zu//3jiZfOpntWxNKqONRu4UedCsOyrKYEz6UbVaRD4fNjQF3covfbhlz4TUU7Ne5HVAvdz9ZhrCYZoJCEmbBslU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lu9cVtm/; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lu9cVtm/"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3032f4ea8cfso1480860a91.3
        for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 18:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744333562; x=1744938362; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MkYmV4EiZp8deO8Ig6kH+/Q1QGEWwmHV3f5WbOie+mA=;
        b=Lu9cVtm/wPlVSl6SZh2jm6FpGDQ6XiWq3bDaYoBmJH+BbxXMu7zkN+fhVfHFWhWZF7
         Sg2YFGmSsfEqh6E2/X3YuicgrOzzPMcsThMf+aKVySdRZinnLRHFsVUQIN4hhxCD/I+p
         QOWRtBOuduTsqai4VKbq1T4TQoaFDQfkdiKyQRwQ8Xw2+JOhFvg+cwT2HfvQeOuVRjqA
         k2yi9lxbUt77iJ6IShxxv1s9qJsdY4hvl5ailPnYWJvclQkVjF600Qa0dScLHsIiP6nC
         lGBV2pb7X72d59Tiuttjr+0Xz+q5ocHBM6BN3mI4z8ivcsvO+cFmANyCKNpvhSVSnefd
         8tkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744333562; x=1744938362;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MkYmV4EiZp8deO8Ig6kH+/Q1QGEWwmHV3f5WbOie+mA=;
        b=eZID9sffz8tJ/LAFJZM6TitO/o6kiqO15zvXOVjK7F8F5XAVURyYcENVd24shJwpip
         Z7fxj85fnOO7204ZnB7upt6w27o14wC0/NRQoiHSfVW8gLfpmVD93wlwoNcKvhjsTwgj
         68k1tJKXcOZd+4Ve2E1aIEm/MfAqRfWxhu0lFsIvfQoz2+4PbWda5JvgkUnGlQkrm1J/
         wu1UOs1ubOMLvgxs6YuTylI8mLGIdjzPgi3kfiYs8aC2bpzlDBffKkTwrsGckkK5P8jD
         X4RtcbabC8jHqJtwL6Y8XFQktR+mepukc9EJ+Ff8OlZX9MisgUnw5aF6rJpG3TWB184v
         dJrg==
X-Gm-Message-State: AOJu0Yyzi/e32lqvYbQjZsh9NZJeEfqENhiWYeF35YIrzMSaToKevwEr
	4hNmVlzPMG4MMkuQrpVDH1uINQcl7KQMC031WbSqHxfBMxvjXnn9gLclzSiLGFLuOpqFWAeR8R/
	ulMtwzMRK+Eqjn6mkpALYsmULaDTnK4M8jtOVhQAOdIQMmivrpGb8kw4a5Y0arTau9D0v03trIl
	4Y5bXWJQnPBFFB57DFbZQ/Q2Zw7FSLn6BWmg==
X-Google-Smtp-Source: AGHT+IEzulcaQ5K/sqBXjzFaO/beH+E1hp28JHtGlq0hpwM8R/XoR1ciG4GdbsS2kwFt33yQTCxJqH+Uj0w=
X-Received: from pjbnc13.prod.google.com ([2002:a17:90b:37cd:b0:301:1bf5:2f07])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:524f:b0:2ee:f80c:6889
 with SMTP id 98e67ed59e1d1-30823680abamr1678262a91.33.1744333562051; Thu, 10
 Apr 2025 18:06:02 -0700 (PDT)
Date: Fri, 11 Apr 2025 10:05:47 +0900
In-Reply-To: <20250411010549.1688614-1-inseob@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250411010549.1688614-1-inseob@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250411010549.1688614-2-inseob@google.com>
Subject: [PATCH v3 2/4] libsepol: Make line markers of rules configurable
From: Inseob Kim <inseob@google.com>
To: selinux@vger.kernel.org
Cc: tweek@google.com, jeffv@google.com, Inseob Kim <inseob@google.com>
Content-Type: text/plain; charset="UTF-8"

This commit introduces a new variable line_marker_avrules in the
policydb structure. It controls which avrules will have their line
markers upon sepol_module_policydb_to_cil.

The default value is AVRULE_NEVERALLOW|AVRULE_XPERMS_NEVERALLOW to keep
existing behavior. One expected usage is that checkpolicy prints line
markers for allow rules, providing better debuggability.

Signed-off-by: Inseob Kim <inseob@google.com>
---
 libsepol/include/sepol/policydb/policydb.h | 4 ++++
 libsepol/src/module_to_cil.c               | 6 ++----
 libsepol/src/policydb.c                    | 2 ++
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index f833354b..ab4b1a12 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -615,6 +615,10 @@ typedef struct policydb {
 	sepol_security_class_t dir_class;
 	sepol_access_vector_t process_trans;
 	sepol_access_vector_t process_trans_dyntrans;
+
+	/* avrules whose line markes will be printed. Defaults to neverallow and
+	   neverallowxperm */
+	uint32_t line_marker_avrules;
 } policydb_t;
 
 struct sepol_policydb {
diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index ae9a2b5d..63c800e9 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -1196,8 +1196,7 @@ static int avrule_list_to_cil(int indent, struct policydb *pdb, struct avrule *a
 	struct type_set *ts;
 
 	for (avrule = avrule_list; avrule != NULL; avrule = avrule->next) {
-		if ((avrule->specified & (AVRULE_NEVERALLOW|AVRULE_XPERMS_NEVERALLOW)) &&
-		    avrule->source_filename) {
+		if ((avrule->specified & pdb->line_marker_avrules) && avrule->source_filename) {
 			cil_println(0, ";;* lmx %lu %s\n",avrule->source_line, avrule->source_filename);
 		}
 
@@ -1264,8 +1263,7 @@ static int avrule_list_to_cil(int indent, struct policydb *pdb, struct avrule *a
 		names_destroy(&snames, &num_snames);
 		names_destroy(&tnames, &num_tnames);
 
-		if ((avrule->specified & (AVRULE_NEVERALLOW|AVRULE_XPERMS_NEVERALLOW)) &&
-		    avrule->source_filename) {
+		if ((avrule->specified & pdb->line_marker_avrules) && avrule->source_filename) {
 			cil_println(0, ";;* lme\n");
 		}
 	}
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 8443380b..53d57d81 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -945,6 +945,8 @@ int policydb_init(policydb_t * p)
 	ebitmap_init(&p->policycaps);
 	ebitmap_init(&p->permissive_map);
 
+	p->line_marker_avrules = AVRULE_NEVERALLOW|AVRULE_XPERMS_NEVERALLOW;
+
 	return 0;
 err:
 	hashtab_destroy(p->filename_trans);
-- 
2.49.0.604.gff1f9ca942-goog

