Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968529;
	b=ujTja8kOyBvZnJxxfE2eYf09UFHKWzD1BGEzEo0EgHaEhTfA4FC4v/cFnxMh2UUDy9BA
	 KHtNzYh1XZYQRkUAjQphvpGJj5NfH+zEjgHdPinQQFRomJMdhDECF4G2sIBRqdlxQM2Ri
	 YDGszl31XDDhFMhZyX+nSXzfqMpAobyMdmUz8t/uBy442Tt/061q2qTW09eMoyVXGX7GF
	 w73ssEiWf4VVztMjHiJjBYGiXW1asoCD3rjJHqRXJFbsD+jm7g4Otq9aQL+Kojaw6STCG
	 fJ0FIHqQ7sS23aCBqnJOvF+ex/jwEHa/bmhDTAhhNTWyuD78+SXa3S86Qt3fKV6rkDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968529;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pKvQ+BtoZOE1BirqJLfF00uPRfwIFQ4457IOfuExb0E=;
	b=dNSv2LNiWmPTb8bBFzl0g4CL/9i1gYUNteI8zXuNpL6D+l6Yy6tsCZ5fzc6W9t072m2i
	 Ed+5kc4h2Hb/jR1MVXzACfQ08NfjmcGM/tCM2cktxQiHECvyJfDNsjtZhkgOft7QxTYLi
	 nRx0vMEQQY4xLRUwoW/irPk0yeFjg1Pt/48JuFIb60us+2d4Xy84oocKBIgN7ghEqSmRD
	 NXLtCS1+JSf/QLA/TyzZJ7pFvxSUiy+fJU/hmMzJWTlxnz9mAPo0DDRFaUMS+YKnwkNTR
	 FUa268e7GBp/SE46uR29Nachh2AomKQHObA4f0658uqoogg/lM4id9CUeUqjm7kvaxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=addqvy2d;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CED606A335
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 12:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5CED606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=addqvy2d
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1793968525;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pKvQ+BtoZOE1BirqJLfF00uPRfwIFQ4457IOfuExb0E=;
	b=addqvy2d11nEfjPRVNfN+1C+LMBEI0nO8mwGlBr1V1oFNSf4UnC+/e79m78jOa25ARfvJc
	OaVhVUFmRGSmTbp5n9Vrdk7fplOJODdd+Sq/WKC+cUTsW8fB1+RVlIEkC8l2GZ+uV0fGi8
	pQwXgN/dCPdX2nNs8mYwvu4yakHVFX2TqR7ykX+Vk37ZYqGWmIW2rL4QMAbf4w0axxcPR0
	SeA0JXjz/QL8VuiZaprmHcjpj6FXphTllVTUW802RVrxOrlyyH7gwyDP9yg7m/EnyMLADh
	+uMdFRaAANQJ6aZDoAcyCNBCrle1tPOnyuU0CX5YkDXg4Ncqx3l5fYCxI4HEhQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 07/16] libsepol/cil: reject over-long ibendportcon device names
Date: Fri,  6 Nov 2026 13:35:00 +0100
Message-ID: <20261106123510.76727-6-cgoettsche@seltendoof.de>
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

The binary policy format limits an InfiniBand device name to
IB_DEVICE_NAME_MAX - 1 (63) bytes; checkpolicy refuses longer names and
policydb_read() refuses to load them. secilc accepts any length and
writes a policy that neither libsepol nor the kernel will read back:

    (ibendportcon <64-byte name> 1 (USER ROLE TYPE ((SENS) (SENS))))

compiles, after which "checkpolicy -M -b" fails on the output.

Apply the same length limit when building the AST.

Assisted-by: Claude:claude-5.5-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_build_ast.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index eb1537d3..6f994d66 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -4824,6 +4824,14 @@ int cil_gen_ibendportcon(__attribute__((unused)) struct cil_db *db,
 	if (rc != SEPOL_OK)
 		goto exit;
 
+	if (strlen(ibendportcon->dev_name_str) > IB_DEVICE_NAME_MAX - 1) {
+		cil_log(CIL_ERR,
+			"ibendportcon device name %s exceeds max length of %d\n",
+			ibendportcon->dev_name_str, IB_DEVICE_NAME_MAX - 1);
+		rc = SEPOL_ERR;
+		goto exit;
+	}
+
 	rc = cil_fill_integer(parse_current->next->next, &ibendportcon->port,
 			      10);
 	if (rc != SEPOL_OK) {
-- 
2.55.0

