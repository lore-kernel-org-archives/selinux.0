Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E027D1624FE
	for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 02:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744251515; cv=none; b=uIaGNSseW54M3ky7G9L38KrYhZPzU2JKOUh2B4sJm1N7OZGBpiwaCxzZo8Z0q1581dh3RW/9vdBt6MJhceBBckVfLnQPHU4EYjqmII4t8W++JcgFV3MLBcaMp5w5Q4vbEhk82HC6j1L/hJHQtfJXkoezcNUL8Dxn/BENfBJpf+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744251515; c=relaxed/simple;
	bh=WY5FcPZv5d4iOnHSby3s9wc01kW5lnu7omIl1oWYtjM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NiY6jWhcl+9VYfHyN8pexQBqc710XyguqGrP87HfXrs3o1vyDOXbGTVre7Pl5ZXO5oJVibZU5xTMbANw7xWYKfn36dNz0hUAG6g7r48WoGDcoze0PEifowV/5vyuU7NVWZiIvzLi5vyI+GPRCAqPxFsOVoXo2Q6J4QSOD2Lgj14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v1I2vtSC; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v1I2vtSC"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ff52e1c56fso399063a91.2
        for <selinux@vger.kernel.org>; Wed, 09 Apr 2025 19:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744251513; x=1744856313; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6mPN11qHNdCMGVlw17EEIUX8ep0ztAfAFd/sSdC2t8U=;
        b=v1I2vtSC7Js40axUOK0qMn532w6GUK+vTg2sB6g2bkAE21NiBIN058ZvYd4Nf+AMDN
         roAaR5YyijKg2Q/OSNkUW0sENE83+0XNEOWJR1v77sVe58oABmWif51AuZoNVmc2F4ZU
         exEbrCeBqv+ss0C3hNgXKBVI+3dfRBsE4jpwi3DawnO/8/G3f3EI/J7Xary4eK9sn2rF
         X+7FG8uL6U5C7Fue3cymqeHQ6Tycqf1aryFbRTi7MAb1EOLT/nq5Kece4EehX8n6SN7L
         yyDwuXfKx1b/sAWKpSa3b9axPpuOsqDmlNIKr2+2efLch813O6KW/1sntdZILr9vzFxa
         ZQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744251513; x=1744856313;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6mPN11qHNdCMGVlw17EEIUX8ep0ztAfAFd/sSdC2t8U=;
        b=UJMmCZlQNUFhPtmq+unthjUhHN0LOQRJ5DjxzIq2dCPsyxxXgiYoP4LdD/cQhV0DiW
         Bug6aYmNfcT6ZcIEqSrO4/cAL1tMZvjSXoceDKq+mJf8ydqE91vqx+9uIhQ/AwfFIqzK
         cqxMPvVv+4sT87oW2N+2jFkUm+WqCDlfpd8uq5P4qbnORvREipS9i9oEjfJp4RDDbzTe
         DGNaYKSuq04c8bkElL+2x7TxtmvHJwxY+bn3WCcKd1aWq0kBoNSyFKeJibJIDePu0xxI
         loE3N7sQlaARWfvEvzGHnBOX3XDbkjCdrsCV6NLVB1Ow2B6LweZICPE6uFzI7BaGhlaG
         JewQ==
X-Gm-Message-State: AOJu0YzpvOHWnt/Q+SXIkPLlOBv7ejrqIO3YUJcBjBpBE9Qn5NRPW7gz
	ruXpWPcGZbi0LeV3Cc3zulTyt2mpFoWNBzQee+44vy2/Y0jrP1oYXcAjEPkgJcfpV66sMh9VWYS
	uHeQGUr+dA0A0P0qPXE49jjJWljVZGU5tHl0EZkWfQjI/gH1gq6Eq3k+ts9pNJCeL6O78/W6Cp4
	hQZI4e4ZRWH+mPzFbRsS9pryU8/0Wl6m3P+Q==
X-Google-Smtp-Source: AGHT+IGL2/BvdsKfxZLCJbR/es/3oFgtji/guMiIwDFAbHOF3wVeaCKRHjy5oTFTU6vTn6OrA6c2rdi/N3s=
X-Received: from plem11.prod.google.com ([2002:a17:902:e40b:b0:223:fab5:e761])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:244d:b0:21f:35fd:1b6c
 with SMTP id d9443c01a7336-22b42c29387mr15303645ad.45.1744251513080; Wed, 09
 Apr 2025 19:18:33 -0700 (PDT)
Date: Thu, 10 Apr 2025 11:18:18 +0900
In-Reply-To: <20250410021820.3874574-1-inseob@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410021820.3874574-1-inseob@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250410021820.3874574-2-inseob@google.com>
Subject: [PATCH v2 2/4] libsepol: Make line markers of rules configurable
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
2.49.0.504.g3bcea36a83-goog

