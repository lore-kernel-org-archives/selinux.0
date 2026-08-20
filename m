Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C422847CA60
	for <selinux@vger.kernel.org>; Thu, 20 Aug 2026 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787240517; cv=none; b=PuywpP/6zWZpQQr/mSf++E7KTzJL+4SBR/faubeimR7W+nCNeWygAgxHz562IY6SmWo6a321uVtAYTznfR+0dOgN2kSEDiq+FCX0Sa9onTJiuKR3/lK1lNG6N1pDxgSYgwmDbxcF7scY2rRw3QM0vD/9RRCzrtl3IV1yV7oUgGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787240517; c=relaxed/simple;
	bh=XewndNyO6fP3L8RQTdcIFzZnu2LOnS+7g+ukC/k+oRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rs8o4/TvnwauHzcsQGbGrwPnsz6yO7Jfa1Eag0Ev05c/Gs2BeR5NzKNlc3OjdTe20c30OEl9yXLI4IAu0itOlu7JkJVcOFeujODNpAZKO8jHclxA6yEiAYcQN7XXVbjhRdYp9EhgoOoe+AsIwVA55YgLKhlttCnOD2EmKJxZPUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNngTsCa; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNngTsCa"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c16ac21acso16600751cf.0
        for <selinux@vger.kernel.org>; Thu, 20 Aug 2026 08:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787240513; x=1787845313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fmd7luOuCdRwLH86r7pHD9rZceTyt8GnuyrKPuOmuhQ=;
        b=dNngTsCaqywaHWFuB8ddjX78g35AGFcEwdtX6JJcopBPwJl2xS/BXLQzIiHk8tWNbJ
         L/QqmwHc2mELdag57fAUdv/nnOzhECVGGysCP0vlwi2pIDolRiqhS+l/69vvQrE7ptCg
         BEXGYy8669bMxwMEpkvMbeJS5wwYXSX9dZxxdB26QfZ/1BGv2bHYCTwrGxe2S02MvZA2
         ciNU53GC0zZpiMC85sdQd1RKb5CxaApu3A/CzIE0HMKLhuaxGN6HHSFa72HvMCzoj2d2
         l2yFvWtYVinn3RPvsy9qCDD1mDVYsB8f3FOWb48hmxsIphk+psRB6LxYWAKOH1lxuihP
         AfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787240513; x=1787845313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fmd7luOuCdRwLH86r7pHD9rZceTyt8GnuyrKPuOmuhQ=;
        b=UHY+Z+flsqJbEuvV1MqUrj23Bo+HrPIxKfn4oqBgwgFw0+Lqc6qMJdpEQoSpFcjXi3
         bvUK2ew6UtQFo0pgOtywu+MuzHVC8sYdIs+2OF1MKntRgsAUTZmXjjr31vLygFiZMuoV
         bD052mYcPWYd686Ld4taxCotrBVoOv5wCjXik02dZNG/TpaoSczMpYcaxbQyecW2MjB9
         yAMn3DAAF7DG6tSwxbr8+KOzaegskuSJjfjlRIscZu1RcIfyxsQmq4soO1jVUh7PTN3j
         mrj6kYUlmfKjdVoh27Tt8oDtTVPJuB9G0ubG2oQkru/t5L4FPyYLC0RLTdz9h3zos0mU
         c7Og==
X-Gm-Message-State: AOJu0YxW5NcIH5s18h4us0LiCZkllwTio/ShcxwV4IQ4tKCK1YIJ4pSt
	ak6Tb1NdUoOh0NeC0segKCcxgvWz98bfavV7sBts6yiuYp5wSLFQ1LmIfBctew==
X-Gm-Gg: AR+sD11VgvxFfUEloLWBaENVrp7GqHtuW3d4/2E63Zieuadyo64SgzsODro3jONWJPg
	F/26LOAZspuuTfuzgzq5kz3AwOsbil4vRma+ZHmzX4iBWCWnon1Gbg8txt11nLSIjvQxZfdQpjf
	kzfwMKcTQNI3MOix5DAraeiuKi/IoCjA/09Xd+3gYtoHauG+bT+rKrDAdIHy1I5qZuXALCLQ1LC
	qabL9zFTfkOT0nmM+f8xJEQsQAbB7DbSJryINIdcZGiqED69qOkqsGdCJQdB3VIGTrKSkdwxn+6
	t7FiX/ZrGsbX3JdLwCWp+pLkrKPrAiEEcMqedvnqXOyklNYNJ3AxHUcqHRzt9xbCBRBq4Z1GNnW
	69kwjDtAggU48YKT1qulMasOfTRag9aDZpo98aW/8yMzOoTUFShubN1RBYz9fXzBYtu8bpT4d2l
	qZMotRChlLn6md/irsgwOoAupt4Metp0JWWMHXjh0bdnbrN1gyoLXi4uXslsnZWxEN1jOioFTtm
	ZeZKr9xzX8=
X-Received: by 2002:a05:622a:608f:b0:51c:1e2f:1281 with SMTP id d75a77b69052e-52dd5e1114cmr130712091cf.42.1787240513349;
        Thu, 20 Aug 2026 08:41:53 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52dd857b6b1sm33046471cf.3.2026.08.20.08.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 08:41:52 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/2] libsepol: Validate expressions do not mix tunables and booleans
Date: Thu, 20 Aug 2026 11:41:42 -0400
Message-ID: <20260820154143.12706-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A conditional expression should never have a mixture of both
tunables and booleans. This is not allowed in CIL, checkpolicy,
or checkmodule and could only occur in a maliciously crafted
binary policy.

When validating the policy, validate that conditional expressions
do not contain a mixture of both tunables and booleans and exit
with an error if they do.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/policydb_validate.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_validate.c
index fe8bf1cf..7d9ae3fd 100644
--- a/libsepol/src/policydb_validate.c
+++ b/libsepol/src/policydb_validate.c
@@ -1322,9 +1322,12 @@ bad:
 }
 
 static int validate_cond_expr(sepol_handle_t *handle,
-			      const struct cond_expr *expr,
+			      const struct cond_expr *expr, const policydb_t *p,
 			      const validate_t *boolean)
 {
+	cond_bool_datum_t *booldatum;
+	int booleans = 0;
+	int tunables = 0;
 	int depth = -1;
 
 	if (!expr)
@@ -1338,6 +1341,11 @@ static int validate_cond_expr(sepol_handle_t *handle,
 			if (depth >= (COND_EXPR_MAXDEPTH - 1))
 				goto bad;
 			depth++;
+			booldatum = p->bool_val_to_struct[expr->boolean - 1];
+			if (booldatum->flags & COND_BOOL_FLAGS_TUNABLE)
+				tunables++;
+			else
+				booleans++;
 			break;
 		case COND_NOT:
 			if (depth < 0)
@@ -1364,6 +1372,12 @@ static int validate_cond_expr(sepol_handle_t *handle,
 	if (depth != 0)
 		goto bad;
 
+	if (tunables && booleans) {
+		ERR(handle, "Found both tunables and booleans in the same "
+			    "conditional expression");
+		goto bad;
+	}
+
 	return 0;
 
 bad:
@@ -1375,7 +1389,8 @@ static int validate_cond_list(sepol_handle_t *handle, const cond_list_t *cond,
 			      const policydb_t *p, validate_t flavors[])
 {
 	for (; cond; cond = cond->next) {
-		if (validate_cond_expr(handle, cond->expr, &flavors[SYM_BOOLS]))
+		if (validate_cond_expr(handle, cond->expr, p,
+				       &flavors[SYM_BOOLS]))
 			goto bad;
 		if (validate_cond_av_list(handle, cond->true_list, p, flavors))
 			goto bad;
-- 
2.55.0

