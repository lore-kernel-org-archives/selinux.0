Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93AC11E1DE7
	for <selinux@vger.kernel.org>; Fri,  4 Apr 2025 12:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743768521; cv=none; b=BZs1oVcTL0FWc2Jzv+zOeSCtqHs7NuAb0S4pkPmBAZsznTtaDchEO3dRbaxE4MPUMZNepQRUh4XZyQekJBOZeq3YPyR+Uc+7YkdFjm/ln4UnSuz0itoSlcid5zKNRKi4bl3I88Ci5IFHz4pgnuUexZxFyci17BGXtwa/8yM69gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743768521; c=relaxed/simple;
	bh=WY5FcPZv5d4iOnHSby3s9wc01kW5lnu7omIl1oWYtjM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XycXBPIMg+I1jbYqxsR+Zgww3o7ubn6MeYEaXULYBz2BzDDIBC6r4PJychhfCVDVlkFJtYnG9RuJM4zvTLmGSYUOK9VkHdJdD61/Ji5a/INgXnBmm/5BD6h+W9c77l4n718nU2KlbYhOD8CQpf9/YGkW2/LbGUeXPnGAFgLCTpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CF3fE6nU; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CF3fE6nU"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-ad50a3a9766so1536355a12.0
        for <selinux@vger.kernel.org>; Fri, 04 Apr 2025 05:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743768519; x=1744373319; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6mPN11qHNdCMGVlw17EEIUX8ep0ztAfAFd/sSdC2t8U=;
        b=CF3fE6nUx4Zn5og98OFVThih8h7tRQ3qLW7p/mT1HFIBb5pA6iskxMEYzmYvMcyjMz
         ceXIhqkp2sw0c+Pw8bnaCA+58Lu3J6HjS3mOuX+6GZryriEcu4cgtsJGZffQkSPh1mcE
         E+Echtdpo+lzUPJ5cY7IBmR1OQqbWfFofGltUzoCu01GijnkPzA/JSo79nLRvv84BKcA
         sNlLWPxwhxZpzmLihFUmNsDX20ShWlrytyHCdkAQs8ri3hGdRuiT427czuAdZAWbt4Uv
         MSHonpeGtMsaX6S1R3lhe7epU6zN8eUmjrBoTXUJYWru1SS+0WeuJ3rXhSKTo63ckg4C
         95nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743768519; x=1744373319;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mPN11qHNdCMGVlw17EEIUX8ep0ztAfAFd/sSdC2t8U=;
        b=aJXdYKC5HpUTmyOp9ZonZhjtbWmJaC1R/vLe1mG/UtED9tY3MasbLGyNGr0O2i/HYq
         5Ojuz29sAx+Q4vH0l+91Zd1lOCQ6HWHz9aRQ/Gk++W3xwuXJ5y1rg01a31/HaBQcdGxO
         PaayPnqS13D6uxRAc09KCvFRIti4f7fRbiZ3rsDcx6RM+fHZNp/xpPTBEaB2TnmYQik0
         P86t4ov7E7uigV7vVIcFOuTQDhfziwV6xqr0Y+5m2/8QUBI5yCZlghpjVpdUMKJ2Orbp
         yWNkyCCZJ2il6UcENif0wpj3GrS1puwvMdGhta72o0MNDi9o55iKKCcsch8ZGOigl4zV
         2FuA==
X-Gm-Message-State: AOJu0YxyKsQRr3iZ+h6kQLIgxYua25UaePGdfGrTh0YXhk9JZhOcUiaw
	RjbHyTnqD0hIQVdxhER1A67WZE1ybDpOzHC3/Wr21oGOH9ZCpZtWsWhKtVRMGz43uzC/ZhTKW/a
	qTvOMOic76JOvZgYBrq3kP2QUL1CdoHBY6XXV4VPj23JWvG/ds91HqOxkGF5RioZzqqNap6c/sx
	wNmDlcAtj2wZqKAbcjIwxdNep2KsADSh3lzQ==
X-Google-Smtp-Source: AGHT+IFDV4vH182AsUtkCgeqtif1V1ibFD1a+mMojAJV5ra+jYG2SsY5skoE66M3Warx5yXZxJ61e+4B1Xo=
X-Received: from pjg15.prod.google.com ([2002:a17:90b:3f4f:b0:2fc:2e92:6cf])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:270e:b0:2f5:88bb:118
 with SMTP id 98e67ed59e1d1-306a48d1a7cmr4037843a91.22.1743768518648; Fri, 04
 Apr 2025 05:08:38 -0700 (PDT)
Date: Fri,  4 Apr 2025 21:08:23 +0900
In-Reply-To: <20250404120824.4146584-1-inseob@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250404120824.4146584-1-inseob@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404120824.4146584-2-inseob@google.com>
Subject: [PATCH 2/3] libsepol: Make line markers of rules configurable
From: Inseob Kim <inseob@google.com>
To: selinux@vger.kernel.org
Cc: tweek@google.com, jeffv@google.com, nnk@google.com, 
	Inseob Kim <inseob@google.com>
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
2.49.0.504.g3bcea36a83-goog

