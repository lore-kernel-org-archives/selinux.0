Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952072248AF
	for <selinux@vger.kernel.org>; Tue, 14 Apr 2026 19:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776193897; cv=none; b=bObblrPAx/MuAELTXe0w9jBwlweLMO1wOhC1/wTVaOu3FANDzitHNyN9pB968mf9Z7EVVb6WrzwrCxUY7mPWAoMw2iDYkF7mqGslJPg6576bsOi8GEgWHE15PYJo8V2z8fv68UkUOkZEmEyKFq01T67nJxhK2hL29XokNyRiuUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776193897; c=relaxed/simple;
	bh=s2+hMSV/84WaJ/M2d3APQAHuCulTVj+ERgB55PbJd1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IHgrA1fC0Ui92rofy9eUMrRpXN/Nek89Lorbic+/poJ8laMIVh1omqKxgobeFGBpuQOFapNfVyIlbetPG+0MNV9dUvL2gOlzze2x2THVnDAn3CPmuG+wmdrkKlkc8+MDO4zOHVVRoILhp+rN8u3RP4sbv5WNA/G4OXCAvaWBRu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sm5SlW1T; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sm5SlW1T"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c70b5594f4so596134385a.1
        for <selinux@vger.kernel.org>; Tue, 14 Apr 2026 12:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776193895; x=1776798695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X+SDM89Y9SCUHb6xAMdNkx3iiJKHYVJDPNGagna+wPg=;
        b=sm5SlW1T6NnrOzrI0yHafrSidqUBpOQ7Lstq4JK0g21CKo6HQUQhAiOR1jm2pgSKJ0
         wmcOFcbFLAC+qxD6j2aLGYspyBsVw9o1v9md4g/T8n59IG/Wr/rXKcK1F5OOUCKZHtfT
         mJPkwGHar6dHAzIJQ2wh1qvCXd+TUkCTjfN+r24Gv2EPh2Y6De19afklt/r6iVuaHNO0
         hzO5RkKfFKoXn7NL17FmEZUaVm5JAKfAJWIaicQuaJ2SwhSDb2Mv9jndckA6shmyy01x
         Llk9x/kZ4dEA8W3Y7eHL2DNcIImuABa9X12OVbXDHfvNXKetxxBbks2OcqzfiLoDH0KP
         UnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776193895; x=1776798695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+SDM89Y9SCUHb6xAMdNkx3iiJKHYVJDPNGagna+wPg=;
        b=RqPM/RnOovBwX+VkIA7FSy4OFGS+vBP417DATJAzxGXhAeRrjhIJ/WEGa9csroDVGu
         q1r5+kOGQy6XApoXUUFoaHAw92n8fpTWvaYW0o79eXktYAm2bOQIGWAQjUDX3WvFlI0t
         5swx9Aye2jP1g1q7miCziR9ImMg7XpD3jF28tKmRllmgNsB4rG0sWBzwRfyoY7rGrtco
         7pjxbUdqWCGNmZexcmRh1A6gSgRO49e4h7/wle8Tng2ao5E3A1XmlLbtx5/n8wyV90S4
         MwGMdcINkQsUgfiL8h4IZgDO83x1YPW810bsHgi8XwrwCnRmPbyHXOFJ+lxJ/2Dp324X
         ovHQ==
X-Gm-Message-State: AOJu0Yw8Sg9/uypsBT7190Po5SQa8UryS+eV6A3ZBIndsuOCIP84hYGx
	AjjVt4C9ie1DsyafbE4oQtHbrTqtc/HP4Xze649zetIyPbIKQ1/Ai2eIzfWalg==
X-Gm-Gg: AeBDievC6ZuSn4jefGahclFNb+1rok7IOJDSAFegQSrB+8qSaKgbux2GVFuXqYJZxGH
	B1zYI/nEoLaPagpLywB5NY0AWWNbnPSK+YKBGJ6/4zzRJSkPX5/WNYMzoBxee6QeqbTLsTyrKEr
	8Bg/eFz9ljWljKph2L6SLEv2Vwc4z4mQmZ66ZL0JByGHHjOWt4OjzIy4I4m/KiL0Jr6+liYPnKJ
	xqngJskm0wHhpcRwfP5D86wMPWc0g2jHG1gsxn7uhbJPAWbVdx934Fm4OCWe5wcwuXoSvZRyHmD
	FVH3TNy3BzxEaaIQSGm5Gvf6JDZwrjFrsPG7uEE2TJBEUdbzbAn0A8/d9ooJqPljFMHH0tZ4SxF
	RdPj5mCAW7Yh8v1ukTKeXVX13isUouFwFzizC2JDX+7jX/ikUNSeDxMsAaCJMfp3vlpgrCA69LB
	VfNOsBRwAyPGzv0z7C3gGTgOscE4Ge0Tfvq/wTCTqt3vfglA==
X-Received: by 2002:a05:620a:44ce:b0:8d8:9434:9379 with SMTP id af79cd13be357-8dc444ad8d1mr3007967285a.18.1776193895300;
        Tue, 14 Apr 2026 12:11:35 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ddb8d6e13fsm1210787685a.23.2026.04.14.12.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 12:11:34 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: James Carter <jwcart2@gmail.com>
Subject: [PATCH 1/3] libsepol: Fix out-of-bounds memory write in discard_tunbables()
Date: Tue, 14 Apr 2026 15:11:18 -0400
Message-ID: <20260414191120.29067-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function discard_tunables() will walk all the avrule blocks
and do one of the following two options.
1) If preserve_tunables == 0, then it will evalutate tunable
expressions and add the appropriate true or false block to the
avrules list of the current enabled block.
2) If preserve_tunables !- 0, then it will remove the tunable flag
from all tunables making them booleans.

The function was allocating an array of pointers to cond_bool_datum_t
with a length of COND_EXPR_MAXDEPTH. The number of tunables was the
index and each tunable found would be pointed to be the array. This
is a potential buffer overflow because COND_EXPR_MAXDEPTH is the
limit on the depth of sub expressions, not the limit on the number
of items in an expression. Having more than COND_EXPR_MAXDEPTH
number of tunables in an expression that had a maximum sub
expression depth of less than COND_EXPR_MAXDEPTH would cause an
out-of-bounds memory write.

There is no need to wait to update a tunable datum's flag, so
just update the flags as tunables are found when preserve_tunables
is true.

This patch is based on a report and patch from the security firm
Trail of Bits.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/expand.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index ed912b57..5b2b7b03 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -3042,22 +3042,21 @@ static void discard_tunables(sepol_handle_t *sh, policydb_t *pol)
 
 		for (cur_node = decl->cond_list; cur_node != NULL;
 		     cur_node = cur_node->next) {
-			int booleans, tunables, i;
+			int booleans = 0, tunables = 0;
 			cond_bool_datum_t *booldatum;
-			cond_bool_datum_t *tmp[COND_EXPR_MAXDEPTH];
-
-			booleans = tunables = 0;
-			memset(tmp, 0, sizeof(cond_bool_datum_t *) * COND_EXPR_MAXDEPTH);
 
 			for (cur_expr = cur_node->expr; cur_expr != NULL;
 			     cur_expr = cur_expr->next) {
 				if (cur_expr->expr_type != COND_BOOL)
 					continue;
 				booldatum = pol->bool_val_to_struct[cur_expr->boolean - 1];
-				if (booldatum->flags & COND_BOOL_FLAGS_TUNABLE)
-					tmp[tunables++] = booldatum;
-				else
+				if (booldatum->flags & COND_BOOL_FLAGS_TUNABLE) {
+					tunables++;
+					if (preserve_tunables)
+						booldatum->flags &= ~COND_BOOL_FLAGS_TUNABLE;
+				} else {
 					booleans++;
+				}
 			}
 
 			/* bool_copy_callback() at link phase has ensured
@@ -3069,10 +3068,6 @@ static void discard_tunables(sepol_handle_t *sh, policydb_t *pol)
 
 			if (booleans || preserve_tunables) {
 				cur_node->flags &= ~COND_NODE_FLAGS_TUNABLE;
-				if (tunables) {
-					for (i = 0; i < tunables; i++)
-						tmp[i]->flags &= ~COND_BOOL_FLAGS_TUNABLE;
-				}
 			} else {
 				cur_node->flags |= COND_NODE_FLAGS_TUNABLE;
 				cur_state = cond_evaluate_expr(pol, cur_node->expr);
-- 
2.53.0

