Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F4A1B4F1A
	for <selinux@vger.kernel.org>; Mon,  4 Nov 2024 14:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730730307; cv=none; b=UFM34r/7zUta/Zi2AeLZPOm/LYOH3E4kMNrew6AZuiqh//A9ZLtRXRriOwSPf241aDBnhvCFQsn5waMbIrYe5XO2E0DvHzSwkYU8kmz8jhfbd/2dw+Ie9N079q+GGVgk6oTmBuqtd6Jij2TXcwSfMMdcq1nwmxlXH4hVDo2ETUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730730307; c=relaxed/simple;
	bh=3e/kLn9bv4xSd3jlSjWiuDcbs9bLPtY64NnEmxx6s6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gk7MOJB/kucAWdwxcjQ/xtTe1zXX7nKgY5wZc4iTW7FfXB9MndFefyELwj6zqDTAppBlDHF+Qdpz3mziHuDejMfLZQ/0JJJg2dVZlVQ0gIW5d2KQ15F3XsSLecKerRa8rXMasUqZ+eQ5pYikj1U0O6Hd135vSr6iPZcxKdqJfUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRn9A5YI; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRn9A5YI"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b1488fde46so353748585a.2
        for <selinux@vger.kernel.org>; Mon, 04 Nov 2024 06:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730730305; x=1731335105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsj+Vgq939eD6mxUAIbpHtc9DB4IiwhNmgTVas/h+T8=;
        b=RRn9A5YIWisHsjFEHNFn4Y9E8GKTVzUmjM52IhcF+rgnfZqFd3pxPxlazyE1uCk2GO
         goPqynAsgmfSMnbHdGdW//CkPsv/s92W79YegmUKKi2NPWPis2OFfk9yHZTp5IO5ztXG
         s5vPOki17qsNXlhHUJf1tJIemS7kOt1EcLqJcJIgiUDlpTSTcARWxWf2tSR+vh3psy9i
         qn5rIf7zm5yZm5U/nsmO+KQAA+fxSa0fggiTfA/97QYG2wf4A0nrutjChfzST6gWImO/
         D03v4E++ehb2TPI/6A8+o+xvJTFj8c2bmCigpfCvjyWQSXv+N0eoO/PgDTzmMAsEnMwy
         fORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730730305; x=1731335105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsj+Vgq939eD6mxUAIbpHtc9DB4IiwhNmgTVas/h+T8=;
        b=VJnUdr7WziMNXcABG36Jr6QGhNY5dxllwZyNTi7/+DFZEDc0R/bZqRi/Hs7VIhZ/lt
         LqxgNkqn0KP1XJ354H3bYz0ocwJy7N09Tto3K+z8OPrrf/KldbufPaa/7lSLO/dZGUxo
         EZfsqQkSyeSieMmK1nSYdafFlAsbt5a0D6fk4A9qOin7dMKURMA6Lv5ybdyfKmZo55xY
         QPkzwt9GVSa5ZpzJGk6IHaBAV2f/aI1d9yPRY1JxKq9ItAHOI9flO9DYJ+ZFGPyB+Ima
         XQCZKmL92hErsxVsfx+VFGUmIWl3s7g2hYn6HuJ1ovs+IPLJfpabT8fENsEHtjMF7NU/
         9NRg==
X-Gm-Message-State: AOJu0YytuA2TDHg00MGu/cGJLGMe5R7u3z57WOj8AfpA7j8tzeE4B8gZ
	7l7QwaGJYw7kfuhL9ze/pXTS5LVHgX6Pt/Y58pqbMnMolx+D07SoEdArjQ==
X-Google-Smtp-Source: AGHT+IGfBL0E4KuccV0xYMaqG2fzPpnYSvKnnIO1NXJOYx0ObVbsl5xc0CYlP8z1rT3mPW9nujlFog==
X-Received: by 2002:a05:6214:3c98:b0:6cb:f79a:cb38 with SMTP id 6a1803df08f44-6d185672abemr533703086d6.5.1730730304860;
        Mon, 04 Nov 2024 06:25:04 -0800 (PST)
Received: from electric.. (c-69-140-100-37.hsd1.md.comcast.net. [69.140.100.37])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d35415a703sm48572386d6.85.2024.11.04.06.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 06:25:04 -0800 (PST)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: cgoettsche@seltendoof.de,
	pebenito@ieee.org,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 3/3] libsepol: Remove special handling of roles in module_to_cil.c
Date: Mon,  4 Nov 2024 09:25:00 -0500
Message-ID: <20241104142500.20055-3-jwcart2@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104142500.20055-1-jwcart2@gmail.com>
References: <20241104142500.20055-1-jwcart2@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Certain roles (user_r, staff_r, sysadm_r, system_r, unconfined_r,
auditadm_r, and secadm_r) have always been handled in a special
way when converting a policy module to CIL to avoid having
duplicate role declarations. By optionally allowing duplicate role
declarations in CIL and by creating an option in libsemanage to
make use of duplicate declaration support, the special handling of
these roles can be removed.

Remove the special handling of certain roles in module_to_cil.c.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/module_to_cil.c | 50 +-----------------------------------
 1 file changed, 1 insertion(+), 49 deletions(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 79636897..0ede0c9b 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -2174,39 +2174,7 @@ static int role_to_cil(int indent, struct policydb *pdb, struct avrule_block *UN
 	switch (role->flavor) {
 	case ROLE_ROLE:
 		if (scope == SCOPE_DECL) {
-			// Only declare certain roles if we are reading a base module.
-			// These roles are defined in the base module and sometimes in
-			// other non-base modules. If we generated the roles regardless of
-			// the policy type, it would result in duplicate declarations,
-			// which isn't allowed in CIL. Patches have been made to refpolicy
-			// to remove these duplicate role declarations, but we need to be
-			// backwards compatible and support older policies. Since we know
-			// these roles are always declared in base, only print them when we
-			// see them in the base module. If the declarations appear in a
-			// non-base module, ignore their declarations.
-			//
-			// Note that this is a hack, and if a policy author does not define
-			// one of these roles in base, the declaration will not appear in
-			// the resulting policy, likely resulting in a compilation error in
-			// CIL.
-			//
-			// To make things more complicated, the auditadm_r and secadm_r
-			// roles could actually be in either the base module or a non-base
-			// module, or both. So we can't rely on this same behavior. So for
-			// these roles, don't declare them here, even if they are in a base
-			// or non-base module. Instead we will just declare them in the
-			// base module elsewhere.
-			int is_base_role = (!strcmp(key, "user_r") ||
-			                    !strcmp(key, "staff_r") ||
-			                    !strcmp(key, "sysadm_r") ||
-			                    !strcmp(key, "system_r") ||
-			                    !strcmp(key, "unconfined_r"));
-			int is_builtin_role = (!strcmp(key, "auditadm_r") ||
-			                       !strcmp(key, "secadm_r"));
-			if ((is_base_role && pdb->policy_type == SEPOL_POLICY_BASE) ||
-			    (!is_base_role && !is_builtin_role)) {
-				cil_println(indent, "(role %s)", key);
-			}
+			cil_println(indent, "(role %s)", key);
 		}
 
 		if (ebitmap_cardinality(&role->dominates) > 1) {
@@ -3992,17 +3960,6 @@ static int generate_default_object(void)
 	return 0;
 }
 
-static int generate_builtin_roles(void)
-{
-	// due to inconsistentencies between policies and CIL not allowing
-	// duplicate roles, some roles are always created, regardless of if they
-	// are declared in modules or not
-	cil_println(0, "(role auditadm_r)");
-	cil_println(0, "(role secadm_r)");
-
-	return 0;
-}
-
 static int generate_gen_require_attribute(void)
 {
 	cil_println(0, "(typeattribute " GEN_REQUIRE_ATTR ")");
@@ -4087,11 +4044,6 @@ int sepol_module_policydb_to_cil(FILE *fp, struct policydb *pdb, int linked)
 			goto exit;
 		}
 
-		rc = generate_builtin_roles();
-		if (rc != 0) {
-			goto exit;
-		}
-
 		// default attribute to be used to mimic gen_require in CIL
 		rc = generate_gen_require_attribute();
 		if (rc != 0) {
-- 
2.47.0

