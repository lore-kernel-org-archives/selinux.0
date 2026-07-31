Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2413E6394
	for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785511586; cv=none; b=FLB8qHCegIXR77tWclOgzP5cg1x6wxn/b532O7+4wjU/j6W3UyFhPDzOEe4h4HmMcETVdA+f8dDiWTg/4l3OUeQUw60oy5B2qKGRyi2gepngouFczH/M2peAI1gbWW5gmjVrSvuQemIzXRf41EDLvegVn1H84HnEFz7ELkfemjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785511586; c=relaxed/simple;
	bh=fzpuQgdW3Nf6f6NOABMJ8E8HWOtwqv6uAtK2uT2HCQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kd2LhE1n1DZahmvLqUTdRbeYg8kvJKmSStVk4w5gF864bycVZt/+SS+ssKvJyv0IagjfTReoAheCkcRXPHeNhu4IVfun6/k+RYKaVEHD3eyDunX7ZBgXl61c1VqIP2+mqfubWqLyF2vZuVuI+L8EF6wYWFAFnwp2TWUm6AyttMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgD3V7ol; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgD3V7ol"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e50979c71so99588385a.3
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2026 08:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785511584; x=1786116384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=96bz0WVD1adEhvVgBP821SOmJtuzml0WYaVhDusNXH0=;
        b=KgD3V7olq+DXLT4maBgrWLv72EU6wIC+noB49jbsfwKdZJ9ROfh3nZxE+SL6oiHGWL
         FiuL682LxmDY4s/I44yPuEdxSiemY2nILKr3Mg4f8u3UpWzI7qmUwxr+uoF6qhIWOdk9
         kfZVHsBVKpm2EgI7xW4PLN1TIbXAUK86VzT+qUKRXH9Wz5H3KPGm0TIhldoAdEC9xHZj
         YQumkCzjmWhBDV3rHzMwj9i0WouCvR1tZEOMpms/PPSuIsssWQLGCChCic2fi+eF5u+b
         9yB4P87Peu8y5LoJVzTErVV21xOIhdt08yj17gs3DZ8zszyZWXRbub7rRFhNFCL3T3CY
         mbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785511584; x=1786116384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=96bz0WVD1adEhvVgBP821SOmJtuzml0WYaVhDusNXH0=;
        b=GHPGx5cC8Gm82u2m73+9MjxUVISEr6u28VoeoZt8klMlTCIJdes4dzfJ5DcoZYLPc9
         5S9EahibodkuxY9YXe+Fanc8Bv+2w2dkVcT6mgLzU+tiak1OSWRGAw0UkOEob4mn8rtr
         l8QTPvPLBQockCrMaPG7jmXKNiwRyeu9VHEEHkXSBT9DoSAeGVKwTzEhzzFb+Ef75Pfb
         BIDmO1Kzpf08oOpqKDMGQbqn6kRxBeYbsgpygyoEoh+Cve0UJJ/ArO8hO6KfrX8vZaDq
         jgwokl3rarOgxsmtVrC7+UHmEZv9W2FYdgUIEm7WHXpv4lfThHklXBs1+4mPDxOaDO4N
         gh/g==
X-Gm-Message-State: AOJu0YzT/mECZjUrZIi29R39hnKQNb70iWAc3ICxLdXOc/gLljLv2lT9
	xF0mxp+64hyagnldeWGO7dS8GWpDqg9gE+ut3ZlUXVQBPhJKgIVVQ4XZL709Qg==
X-Gm-Gg: AR+sD11chM1YGlOn55A5LV8OIgeHXLpl9kCRmuPPC1ba3TAfLVrT/b/T7Jk+WcbO0hl
	Ci9fM54GtGwNeE+TtwVA6Bs5JL8Xry6pieDD8FRQ8Fz3kp21fYd7d4Quhq199UISijvXPmp+xUz
	F16jhfoLe5trVoljqfzRD9qUcMOF8x1ce3n3987F4LCQW0MRk6TWwq1bQ2MqnWiX6CYhpvsexjp
	rR8RqCeOqzTFMJ7PygDlN4ZUk/MvcJAnKMrhDyC/wGJfWSGKnn60cfqWR2PqQj74hSS48LMQ7Je
	JZAbndoywVTnYSIGSiCXjC15YBg/8fcCPQ3lGfJmZ3A8w/o4DbHsVgph2rxGQFbe7XmLj8DQQxq
	TnRnb0KeDy2xbRN48d/XNhwdTVXJ9ZhlDlFzXtLkSx6WmWEY1F5Q0xi7ScWry8mAu+2oEwUbHor
	wocXER6vYXaD4pL95OdrvL1a9TXme96jkMYYvC5Sl2gaaBJmtKiZgYD0pbXjisThrwZKsvUcMvp
	9RAoQT2V84vXXON0SvuzMQ=
X-Received: by 2002:a05:620a:170a:b0:930:db8a:c608 with SMTP id af79cd13be357-934a0740e50mr90139285a.7.1785511584081;
        Fri, 31 Jul 2026 08:26:24 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9349c1db03bsm76605785a.39.2026.07.31.08.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 08:26:23 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH v2] libsepol/fuzz: Exercise module to CIL code when fuzzing
Date: Fri, 31 Jul 2026 11:26:09 -0400
Message-ID: <20260731152609.47168-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When fuzzing a kernel policy both sepol_kernel_policydb_to_conf()
and sepol_kernel_policydb_to_cil() are called to test those parts
of the code base. Call sepol_module_policydb_to_cil() for base and
module policies to test that part of the code base.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v2: Add include for module_to_cil.h
    Move the whole if statement for POLICY_BASE into the else block with
      the sepol_module_policydb_to_cil() call to make it clearer what is
      being done for kernel, base, and module policies.

 libsepol/fuzz/binpolicy-fuzzer.c | 39 ++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/libsepol/fuzz/binpolicy-fuzzer.c b/libsepol/fuzz/binpolicy-fuzzer.c
index c0d96d8f..017f996e 100644
--- a/libsepol/fuzz/binpolicy-fuzzer.c
+++ b/libsepol/fuzz/binpolicy-fuzzer.c
@@ -1,6 +1,7 @@
 #include <sepol/debug.h>
 #include <sepol/kernel_to_cil.h>
 #include <sepol/kernel_to_conf.h>
+#include <sepol/module_to_cil.h>
 #include <sepol/policydb/expand.h>
 #include <sepol/policydb/hierarchy.h>
 #include <sepol/policydb/link.h>
@@ -72,30 +73,34 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
 
 		if (sepol_kernel_policydb_to_cil(devnull, &policydb))
 			abort();
+	} else {
+		if (sepol_module_policydb_to_cil(devnull, &policydb, 0))
+			abort();
 
-	} else if (policydb.policy_type == POLICY_BASE) {
-		if (link_modules(NULL, &policydb, NULL, 0, VERBOSE))
-			goto exit;
+		if (policydb.policy_type == POLICY_BASE) {
+			if (link_modules(NULL, &policydb, NULL, 0, VERBOSE))
+				goto exit;
 
-		if (policydb_init(&out))
-			goto exit;
+			if (policydb_init(&out))
+				goto exit;
 
-		if (expand_module(NULL, &policydb, &out, VERBOSE,
-				  /*check_assertions=*/0))
-			goto exit;
+			if (expand_module(NULL, &policydb, &out, VERBOSE,
+					  /*check_assertions=*/0))
+				goto exit;
 
-		(void)check_assertions(NULL, &out,
-				       out.global->branch_list->avrules);
-		(void)hierarchy_check_constraints(NULL, &out);
+			(void)check_assertions(
+				NULL, &out, out.global->branch_list->avrules);
+			(void)hierarchy_check_constraints(NULL, &out);
 
-		if (write_binary_policy(&out, devnull))
-			abort();
+			if (write_binary_policy(&out, devnull))
+				abort();
 
-		if (sepol_kernel_policydb_to_conf(devnull, &out))
-			abort();
+			if (sepol_kernel_policydb_to_conf(devnull, &out))
+				abort();
 
-		if (sepol_kernel_policydb_to_cil(devnull, &out))
-			abort();
+			if (sepol_kernel_policydb_to_cil(devnull, &out))
+				abort();
+		}
 	}
 
 exit:
-- 
2.55.0

