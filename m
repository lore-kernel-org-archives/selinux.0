Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793968530;
	b=icmY9XX5I5LGCMv8pu2US3JCWp69/sK7NO3Ny1Ehu1LpV1uN9a/LGAXcwt01zPq9EP9n
	 nEDJoYGYRk6LdcR84+j/nlKOyZdoWsfqUJ+80/YHFDSF9aS6Mt7XLZBZGVlkDwRXu5C/d
	 hjRFbMqkj1L890pT0Zf5ITlabAEY+UkW94At5C1Y5UL2IhxRHzgPsFLncJns0gk8+EDpy
	 K6UDgzGOmHHiedtIid8awa5qL34IOT6GXV75WBboFEgMoApSiANdmkoGX0BXyzFC7bdKI
	 tTMCycO8J9ZdvLWo0pXNVudzUFlHKPlvFdyCyWDHyOrFyH66KqFxzvQCDGRvQFuQ4Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793968530;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=B/uTxW2S2yteci3FkbAp5BGh0O6INzoy6yOPxw+ALsw=;
	b=eI48UG7npt6RtrpdseZ/YJEP0jqBFSp41+/YcvF1wu9nQ+ZIBH9xZt1qf7ZzYlFDyjgi
	 i2eaHCaiHgbZI2Ir6kE1YD6+Sx4a4QagMeM3nDH62iTIuO85TJ8nxPtykCylwUbm3ZgPX
	 YNLjSCBsIf814wzMS+WGbQLFajiIlSILTbidc/B8slEj6RFcG+soKzBK7FAe1zusFMpwk
	 9I9Zp+cyM2ZotL59GcV8bfpzls3bMS1eldk+th/F2QRAi9amh/3ZBhM0VBB9g4VWrvNCf
	 lgcpxRqwxWVGXbJ9juYXbxqhB5mnDAqsrF8sX77SYuMYj/dbm79SWgnQxbhj4WqlhPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=FwRi9Ohm;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6E6606A332
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 12:35:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C6E6606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=FwRi9Ohm
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1793968526;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B/uTxW2S2yteci3FkbAp5BGh0O6INzoy6yOPxw+ALsw=;
	b=FwRi9OhmkMsxuEmnvnK17w5Z2BPgAmDJMZssvjiy0pxkxKMQxAvC4UVZuWTqjsEbCBLJ0r
	QrW2tlBIFwUuR1Q7mVqtRwemkRUVjl4sgBYKZLEdS2jSXVcr3f4rbW6/EuuccZ3IrfBWNX
	0NTY2FQ9Bi9wqbMDcAceI4Xru+zyHwyAZsUw60rBb/RDSVrXOlG7UGh5+vHZJouelvDQK3
	rUgJb4OizT3QWh459Vg34NlIQbahfiSLfM6t75J+YC84gTeQkf2FaaXntTuBKDXmhbSQOO
	Q0lZ7ZKUFi3ZbkF2/9rNF7IIy4ORkhEovySV8br0AIfrSk+wm8fza/Bh8etQRQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 11/16] libsepol/cil: name anonymous ranges in context verification errors
Date: Fri,  6 Nov 2026 13:35:04 +0100
Message-ID: <20261106123510.76727-10-cgoettsche@seltendoof.de>
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

__cil_verify_context() reports a range outside the user's range as
"Range %s is invalid for user %s" with ctx->range_str, which is NULL
for an anonymous range such as (USER ROLE TYPE ((s0) (s1))). Passing
NULL for %s is undefined behavior; glibc happens to print "(null)".

Print "<anonymous>" for ranges without a name.

Assisted-by: Claude:claude-5.5-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsepol/cil/src/cil_verify.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/libsepol/cil/src/cil_verify.c b/libsepol/cil/src/cil_verify.c
index 7e0ddf74..f8536eba 100644
--- a/libsepol/cil/src/cil_verify.c
+++ b/libsepol/cil/src/cil_verify.c
@@ -1096,6 +1096,8 @@ static int __cil_verify_context(struct cil_db *db, struct cil_context *ctx)
 	struct cil_level *ctx_high = ctx->range->high;
 	struct cil_list *sensitivityorder = db->sensitivityorder;
 	struct cil_list_item *curr;
+	const char *range_name =
+		ctx->range_str ? ctx->range_str : "<anonymous>";
 	int found = CIL_FALSE;
 
 	if (user->roles != NULL) {
@@ -1143,7 +1145,7 @@ static int __cil_verify_context(struct cil_db *db, struct cil_context *ctx)
 			} else if (sens == ctx_low->sens) {
 				cil_log(CIL_ERR,
 					"Range %s is invalid for user %s\n",
-					ctx->range_str, ctx->user_str);
+					range_name, ctx->user_str);
 				rc = SEPOL_ERR;
 				goto exit;
 			}
@@ -1155,7 +1157,7 @@ static int __cil_verify_context(struct cil_db *db, struct cil_context *ctx)
 			} else if (sens == user_high->sens) {
 				cil_log(CIL_ERR,
 					"Range %s is invalid for user %s\n",
-					ctx->range_str, ctx->user_str);
+					range_name, ctx->user_str);
 				rc = SEPOL_ERR;
 				goto exit;
 			}
-- 
2.55.0

