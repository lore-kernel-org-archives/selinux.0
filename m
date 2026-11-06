Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968530;
	b=YaZ64ybX+j/AsZHs43TMXb7RhJGzND35nmOrPm1w8N8rG0unR0utZP7a/21j6tNM5I3t
	 RN+cR2RO647a5sLiC15OhdJiA5n/8Q5jsq5M+RimBhSHxgrdNfrarg1T1QxgkDNVw0hlo
	 4t7Itu0lCiGdq7AbspfpaX8XLHC1So+iRv2LudTJGaepRw7D7lSWLCtknQ5aKPzXonHkn
	 S/yJUE0FcurtJ7hQ8xX7hl+rdAJN7aS4pgaoiXPVR9HuGLhzk7XQCY8rTLZbgJUdFMswI
	 7BFIqVs/zQvgOacet4AqM9Y9gYwSpNW4Sh2KVH2rvdD3DWUaYdTTy7hFYLqxpI3f2kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968530;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=c1jUBzAEj2Wa6yKwv5fxgLMja5u6bqEn2+KJlhekvvA=;
	b=EXqdtfOPV+06vPmvBCaxUHXYAlcyO6k5W+XEwFeQL3ZoKKxB2qNsg79UdDBo19DW9Kwh
	 iQ7nMmMD8QD8LKq4P5wFNljAxyf4O21gTS7/T1XRqKtQ4iBMY5DS+AplWxc4jTkMQ6fjZ
	 Mkz+A0pBkPvqJ4Gty5h/P+MuTT2/8NLEIvFvYmDxNGHgu5484YJS6SIiPfMFADYAzmbdQ
	 2E4Upzs1JA7y1kI5PZyCiPiJ2MzuTCMi/iJ1QTTEG3UUA3UJj5hUJ1ySuF8TSi4ih0P55
	 +Iyyc5W2Nj5KWrO0ex1JT1bWmTSd5jXE/WpUMkFzfV57AWEB4llixZBPAM6hZmk/bgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b="cA/+Sg2p";
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069DB606A337
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 12:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 069DB606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=cA/+Sg2p
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1793968525;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c1jUBzAEj2Wa6yKwv5fxgLMja5u6bqEn2+KJlhekvvA=;
	b=cA/+Sg2p996uBVZ9p5w5cYHxfM0WNaz/Aq76cN4qpAjNaGDMbq7i+KwLGzD8feg00e3tc7
	Wu4va+OGHUkflSsQz68X9t4BEN6MDYDu1kGndHOyB2jFERkzTantXGALCk1/oVffmLy4Uw
	aP+qACPXJccJeth4hZQJ/Q+PO3qempF/p5zKTH+8N16MiiGnMhSM4lglCLNBnb1LixfwMj
	ZXDpa5Nx5KK9BWnHnkMYwWJCfT2XIL96NyS1ZtX/hBC6Nt/v8zHNPWiplNiQqYW9O1mQf7
	FFl2NiW49CscrPgyrxeLLXoIfPzGmzjsat75HTd3+BjwWUbodUrOWzvrnYNkAA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 10/16] libsepol/cil: verify the contexts of sidcontext statements
Date: Fri,  6 Nov 2026 13:35:03 +0100
Message-ID: <20261106123510.76727-9-cgoettsche@seltendoof.de>
In-Reply-To: <20261106123510.76727-1-cgoettsche@seltendoof.de>
References: <20261106123510.76727-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

__cil_verify_helper() checks the anonymous contexts of every labeling
statement against the user's roles, the role's types and the user's
range, except those of sidcontext. An initial SID context whose range
exceeds the user's range, e.g.

    (userrange USER ((s0) (s0)))
    (sidcontext SID (USER ROLE TYPE ((s0) (s1))))

compiles without error, while checkpolicy rejects the equivalent
"sid kernel USER:ROLE:TYPE:s0 - s1" as an invalid security context and
the kernel refuses to load the policy. The same context given as a
named context is already rejected.

Verify anonymous sidcontext contexts like the other labeling
statements.

Assisted-by: Claude:claude-5.5-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_verify.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 699cdccf..7e0ddf74 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -1435,6 +1435,27 @@ exit:
 	return rc;
 }
 
+static int __cil_verify_sidcontext(struct cil_db *db,
+				   struct cil_tree_node *node)
+{
+	int rc = SEPOL_ERR;
+	struct cil_sidcontext *sidcon = node->data;
+	struct cil_context *ctx = sidcon->context;
+
+	/* Verify only when anonymous */
+	if (!ctx->datum.name) {
+		rc = __cil_verify_context(db, ctx);
+		if (rc != SEPOL_OK)
+			goto exit;
+	}
+
+	return SEPOL_OK;
+
+exit:
+	cil_tree_log(node, CIL_ERR, "Invalid sidcontext");
+	return rc;
+}
+
 static int __cil_verify_genfscon(struct cil_db *db, struct cil_tree_node *node)
 {
 	int rc = SEPOL_ERR;
@@ -1918,6 +1939,9 @@ int __cil_verify_helper(struct cil_tree_node *node, uint32_t *finished,
 		case CIL_IBENDPORTCON:
 			rc = __cil_verify_ibendportcon(db, node);
 			break;
+		case CIL_SIDCONTEXT:
+			rc = __cil_verify_sidcontext(db, node);
+			break;
 		case CIL_PORTCON:
 			rc = __cil_verify_portcon(db, node);
 			break;
-- 
2.55.0

