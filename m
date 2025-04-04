Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1723C191F98
	for <selinux@vger.kernel.org>; Fri,  4 Apr 2025 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743768514; cv=none; b=arCKzYCSlB31OeF3y55TQk+vhR63C0CWE4tkXEAQmv4DWnIQiTWL0ReZ/et0flo4SplUcSqnZmqGNL04fu58GuQBSaLz24VXl9a6N9lx1Jhrq9wqWVUWCXxDD7hR1xjWm1WUm/h3JTGEAdWgPqNM3WYt7JTioAKM1EwvxwijgMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743768514; c=relaxed/simple;
	bh=QUAkvd9W3lcORoAlYDSPZUH7qjA/t+wVsYinYRtwv3g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LxKiVpb+PGFPAIP8+muiSeUn6VLSJYMjzucUHSBiwstQlrREWjkEYxoefSViNU3tn2RPcUohdkasR4GNpQo0XHNMWP5vZqm4kNzk4lcsYJwDzO/96BcHCiy/CukFUs61DMibQxIXj3y2R9h2QhXfD3lt+byg8CO/kJBbE+CSXJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jjx7xs/B; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jjx7xs/B"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff78bd3026so1903313a91.1
        for <selinux@vger.kernel.org>; Fri, 04 Apr 2025 05:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743768512; x=1744373312; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YcVvdaoG+OB/0gRx93hrRCae0u3LGMiZjgNnt0p993I=;
        b=Jjx7xs/BbK/rbnkxYeJ5S/cdI541N5+EpoMRSzVUH9bAXKGPLDO13IDA/XY/j9dWr3
         l1H+llyY+EMqZSUWJmums4L3LJ9/14lz2+vkKufTKHUGeJuWj9ZrwEUEgEwLLv8PIV/i
         V2iPT+fQipLB2nhMVOia0GxNXaYmHpMSIRoOiK9G835WkDjGy5PN+651t74vT6FSE7aN
         ePeihdbJbgfYVzmXreTeQBJWnPEfyHKl4R85FJfe63H+SuQQ6UrzR95gRZXtFLi1MvMY
         PECTuRARV1t/pjkHgCklB9tMNycYoTjwdud3++pQ97o74QyE4TeYKqKZiGuYY18CxE99
         Lf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743768512; x=1744373312;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YcVvdaoG+OB/0gRx93hrRCae0u3LGMiZjgNnt0p993I=;
        b=hujy40NtJqyP9gQFPMEejelLcTBTZiJiGWHS33qBvNOdVckGRDVYv/Wjou5V/GeG17
         g+QDI6FLvZ7R9WckodVGtmVDKurdx+jeWMyk+BelIx+bYf/RldSo7JNC3rp6ziQJu6k2
         kTelMDuHl9q0vdx1hR4aFcPSpWU89YtuAuEt1ZBE6etS4MZ/d5UPdnZl8W3fcaXNqafL
         2JOd4SnojjXyDsZOn5hM+b/JS8uvzi5eKE1ZHpRGPtaqoBFOp/JszJs9n3zyjNkNNctp
         mD/HhGZ2xnjqt4dxdgC0s164Ok94nh9idBZOie9LnTG5n2olqm9oIzRX5WDuxn+suQam
         pSEw==
X-Gm-Message-State: AOJu0YyYY8TJhme9tv2ZArR5c/F4a5wHckku0ublVOsNqLL6N/cpwrrS
	GEJ71+FqNog9H1cnsUOubuqxVBiGXjQoGFCIht7ud2VIHtVInduFUvzNoJXzJeJMepaaBu+iPr0
	mdjipEERAtELuF/Y4PNQfK1zQ3Oxr4LZpjSEK/NbjhQ/8Nu53RvZUdSSQtbF1hgoDAjcAn9xNmk
	Rw60ZxN4H1UOfRJgaKgtmNmzyJzpgz9496eA==
X-Google-Smtp-Source: AGHT+IGevrTip20SsS8ozHkhaEAwGbMfe8/8YXeBw7OwQTuWP/WTolqL/zGcYEWyfw2A7VyKIZAFsxCbcT0=
X-Received: from pjyr12.prod.google.com ([2002:a17:90a:e18c:b0:301:2a0f:b03d])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:254e:b0:2fa:157e:c790
 with SMTP id 98e67ed59e1d1-306a47ff040mr4383794a91.5.1743768512223; Fri, 04
 Apr 2025 05:08:32 -0700 (PDT)
Date: Fri,  4 Apr 2025 21:08:22 +0900
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404120824.4146584-1-inseob@google.com>
Subject: [PATCH 1/3] libsepol: Allow booleanif to have info nodes
From: Inseob Kim <inseob@google.com>
To: selinux@vger.kernel.org
Cc: tweek@google.com, jeffv@google.com, nnk@google.com, 
	Inseob Kim <inseob@google.com>
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
2.49.0.504.g3bcea36a83-goog

