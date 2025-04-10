Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC8E1624FE
	for <selinux@vger.kernel.org>; Thu, 10 Apr 2025 02:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744251509; cv=none; b=d7vnYYNBrZvM1YjQOz7EalO9lp4oHOYI1+xKuZMTnsImIxvdYMQgNmGV7eSQLWAoAYBXQqX1wYCZRYFAFMl4pvs2NuSJJjhL6JP/6t9Egoh3CbRPhVjj7qNxXSdPHkfHP5+4H3emPoDJlAdLmjuHYXJmJcdcpDNShUDR+0fy81M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744251509; c=relaxed/simple;
	bh=QUAkvd9W3lcORoAlYDSPZUH7qjA/t+wVsYinYRtwv3g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=L8hQ0/WggW2EjBDIaXi0q7aUoqBhGAHNVQ/dFhA95n6EAOvSQqOnO2VN2FfMbv/NBbwRcKEs+OBHiCAkJ0+MfDg0gvn0QfWJG9Axca9a4rMAFixW+aZM4QlGYseenCxad52RCybR122cF9ytZx5F41mhdizIrh7c1dV9DMANpeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fqIhxg27; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--inseob.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fqIhxg27"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30566e34290so342587a91.3
        for <selinux@vger.kernel.org>; Wed, 09 Apr 2025 19:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744251507; x=1744856307; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YcVvdaoG+OB/0gRx93hrRCae0u3LGMiZjgNnt0p993I=;
        b=fqIhxg27oPMTICLE2JDN3xyatGbL/wCweN0ZpQcBVi/5fuiRx+Wwv++bi4raNsUKSU
         gGUdyiv0iPOJjzg+wlBZFHJ66AoRYz2vKlGD9HW/GXlaoeDl1k9X+/3pLYn45I/0exeT
         ahFcbcSXgXTL9XDHA69N2z99t/w6tmth6cRjE+BFmMqJr1muUnxIOyw9CfUJaFo+fSAv
         oT7wQMRsD774YJsBHPBchXeCpBga8EqQ0QZzkP89cGXxWiuViMitUyHut8K6PI+Mj4cM
         zWF2faKsZkQPEOPB2MXUQHoJC8XPd7opbBXkYfn07bsIqb6Yg4uUMVP1Nc1gLu5WB67G
         k3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744251507; x=1744856307;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YcVvdaoG+OB/0gRx93hrRCae0u3LGMiZjgNnt0p993I=;
        b=E5kii48d9Yp3R1qGpWlK4PtbreTUvRIFQ9/+OtRks13RoSCgNBQg69KnBIDVSbBa/r
         C9+qGXN664UEPpAVuobX6yX34DRB9GsBqWTClb5CoGYKiz6YCole0nqCEhqiYU7XwPOp
         zrKHeEk8DjRQvBnvGwPqLBV7gCvzX7HnpqsfA+3KNvrYCjjtF+j0bKgTNN3lGfPZMX93
         /x0/nKEYRSNiTKJCIAp+0PU2mKjWz8/EEkQIL8ThYJOBEVceyRu7//ltG/octZ4rSud5
         1tcs1QqtzQOxEvzolk5rtLc5PHQHJFjR1tzq/ixdddcUEdFhLRmFmaiov87BATjBqk6c
         sI9g==
X-Gm-Message-State: AOJu0YxG2JeI8QpoZYbIXiVa8lyxTgmVqhUJkc93kiP8fc0J7IiqDhLG
	DD79DZBp/kdf6N/EjkOAV9KIflUI58Akrd8uD8gafsxVktJOPcG/SU0JLQ+0lhDi8LeMKwXW/QS
	uChs8camcmH7JomgASqYcbsgizG05/+ZD2UWe9KcAl73VwaSoHZ728txlm8XHukq/ulmGt6JvqG
	Vor2qAdO9MLi6iyksvNcmxuCEyJdIQWtIPHQ==
X-Google-Smtp-Source: AGHT+IHzae+IUpTW0KikC+AeMmzAi663gTYU4AdsM1QqNOIUUjA3qVAfEePXtchxGySsDs0tA+zLM3+2l2k=
X-Received: from pjn16.prod.google.com ([2002:a17:90b:5710:b0:2fc:e37d:85dc])
 (user=inseob job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2dd1:b0:303:75a7:26a4
 with SMTP id 98e67ed59e1d1-30718b5376emr1825658a91.7.1744251507007; Wed, 09
 Apr 2025 19:18:27 -0700 (PDT)
Date: Thu, 10 Apr 2025 11:18:17 +0900
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250410021820.3874574-1-inseob@google.com>
Subject: [PATCH v2 1/4] libsepol: Allow booleanif to have info nodes
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
2.49.0.504.g3bcea36a83-goog

