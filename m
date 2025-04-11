Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D33A94F
	for <selinux@vger.kernel.org>; Fri, 11 Apr 2025 01:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744333558; cv=none; b=j5HB7sOs2pgr2mhMd1g18O3R3YiCa8vLpMLq03fuAnNw+mowvvXbxEsGOkoL7lvkmYkQaxSM6oa+627uuFx3N/uQb0bSFFZQILlr5XfjbB5P0rabSZJ5glpS6OY5gvGvw+GZUcr/pgf4zubeZrMSYffgw4hPOaQ78ZpSRwnDZFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744333558; c=relaxed/simple;
	bh=eMQ42uaCVgoQW6UEJex7zBUEe/rqSGyq/LDG4aLsMcg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=AG3MjUuj7wfHkIbXeRPvhKWSLOfjH71mWxr83g66SeFYEmWVGmAOUlTgMGbGTL7Qwr54W0H5R3Trtjc7aH5DjvllbX9sQ9C/RmFqOGwN8JOYR4WSf00+CcTHvyTD1IUz7RjAHVKrIwe2b7VPW4wHcFSo2f+u3Cyc6qNw6hhVz3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3fYnMnVt; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3fYnMnVt"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff7cf599beso1437327a91.0
        for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 18:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744333556; x=1744938356; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/tEtayjpNpg7l3rJrur7NWi3vgxYjam8ErRGY57K79A=;
        b=3fYnMnVtTZm0ObbC6fO+WGwGUtYIC/Pq7sR346ZIIYpgYqv1OR/xSM7aQrK0ZZaeq/
         jmEqapYXJ2NBiE8yHdwVwRjsyg8KkN7OhbH5sBcB0TTiiPVzVeI9kgX0ZCmSZxlTSiaW
         0DxZrBOlLfrGM6Xzh+m96t99mUPlMuEW/fg4fRO/ODD8H8OAMJWY8VabmyJAWcQMBPGU
         OLxR2m6/pNJ4LS3yPVOViTQaYZewgNNKIIKCdC5rPqHty1z+9XRJj96g5CTuAOioKYkJ
         h3nKuKQnJSzkQRhqpM2/s+4Y9l9rvS0EAnKaYkT2snetbucTORfEsEz+sS9An4pvsngx
         0Bag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744333556; x=1744938356;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/tEtayjpNpg7l3rJrur7NWi3vgxYjam8ErRGY57K79A=;
        b=BSko2z/QQ+MlqCDQ8h2c1+mh2DW11F0SljseBNfA4bOT8ibiqKGfc0fSWIHm6zAQ1W
         nYdHFCZxKFwdZUgUrqFKZg9LD9TfbVuyru9tdhggUlcxUtoCvzzW78CHpXRHoRvNUhPz
         oibt4JANwHVca+c19F3iX0U5s/6ebqLcZAaAYfWfe2FfCz1XydK1a/T+tzkjDcGECdv4
         dZPHhYV70NFuxpIOrxa00QrZgRgLhwvl7kPsWTkWbr0Ioq62iIsux4nkx0qB/42SZ3OB
         B1jYg6FFs9DFL5Zbb7SanuuGnKmHWT5E/ZKfMXTZgwpqDslwO8iPxk6RWa04KtOeb8vv
         AvBg==
X-Gm-Message-State: AOJu0YzPn4pl1xJnxrI5lW1cqUk6jtEzRs7+oL1aN7YNa7sSjW23Kare
	kJfofXe5X54BFVtGSmOv8llwet69x4iJ4GVZbKH4p7y0qF3ZnK+PsBP++QRFaXVtnj32mkbHaxT
	3wYMNBbGrc0mZGnu8xdj1MxBu2LBGXsxRFiIoUH7vtDsDQuoIrR3bYA3eJBI91LUeBvdkc0xko4
	oBFaWfIvgnfnxDj6ad9yzMPrQZTD6uwh7wdQ==
X-Google-Smtp-Source: AGHT+IHShWJPsmzggxzVWjEe0vwkK/ITNLNfOwjk0G2XY3oPZuf/booo69dozfXgeNIVegjOl22rXvepg3o=
X-Received: from pjbsh5.prod.google.com ([2002:a17:90b:5245:b0:2ea:5613:4d5d])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2804:b0:2fc:a3b7:108e
 with SMTP id 98e67ed59e1d1-30823675ea4mr1567037a91.4.1744333555962; Thu, 10
 Apr 2025 18:05:55 -0700 (PDT)
Date: Fri, 11 Apr 2025 10:05:46 +0900
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250411010549.1688614-1-inseob@google.com>
Subject: [PATCH v3 1/4] libsepol: Allow booleanif to have info nodes
From: Inseob Kim <inseob@google.com>
To: selinux@vger.kernel.org
Cc: tweek@google.com, jeffv@google.com, Inseob Kim <inseob@google.com>
Content-Type: text/plain; charset="UTF-8"

Allowing more info nodes helps debuggability, especially neverallow
failure reports.

Signed-off-by: Inseob Kim <inseob@google.com>
---
 libsepol/cil/src/cil_binary.c      | 1 +
 libsepol/cil/src/cil_build_ast.c   | 1 +
 libsepol/cil/src/cil_resolve_ast.c | 1 +
 libsepol/cil/src/cil_verify.c      | 3 +++
 4 files changed, 6 insertions(+)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index e84188a0..b0befda3 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -2153,6 +2153,7 @@ static int __cil_cond_to_policydb_helper(struct cil_tree_node *node, __attribute
 
 	case CIL_CALL:
 	case CIL_TUNABLEIF:
+	case CIL_SRC_INFO:
 		break;
 	default:
 		cil_tree_log(node, CIL_ERR, "Invalid statement within booleanif");
diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 072d2622..fc11758d 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -6164,6 +6164,7 @@ static int check_for_illegal_statement(struct cil_tree_node *parse_current, stru
 			parse_current->data != CIL_KEY_AUDITALLOW &&
 			parse_current->data != CIL_KEY_TYPETRANSITION &&
 			parse_current->data != CIL_KEY_TYPECHANGE &&
+			parse_current->data != CIL_KEY_SRC_INFO &&
 			parse_current->data != CIL_KEY_TYPEMEMBER &&
 			((args->db->policy_version < POLICYDB_VERSION_COND_XPERMS) ||
 			  (parse_current->data != CIL_KEY_ALLOWX &&
diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index a8fa89df..392f03c7 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -3849,6 +3849,7 @@ static int __cil_resolve_ast_node_helper(struct cil_tree_node *node, uint32_t *f
 			node->flavor != CIL_AVRULE &&
 			node->flavor != CIL_TYPE_RULE &&
 			node->flavor != CIL_NAMETYPETRANSITION &&
+			node->flavor != CIL_SRC_INFO &&
 			((args->db->policy_version < POLICYDB_VERSION_COND_XPERMS) ||
 			 (node->flavor != CIL_AVRULEX))) {
 			rc = SEPOL_ERR;
diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 550b4542..cde9dd41 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -1176,6 +1176,9 @@ static int __cil_verify_booleanif_helper(struct cil_tree_node *node, __attribute
 		   booleanif statements if they don't have "*" as the file. We
 		   can't check that here. Or at least we won't right now. */
 		break;
+	case CIL_SRC_INFO:
+		//Fall through
+		break;
 	default: {
 		const char * flavor = cil_node_to_string(node);
 		if (bif->preserved_tunable) {
-- 
2.49.0.604.gff1f9ca942-goog

