Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F9212F39B
	for <selinux@vger.kernel.org>; Tue,  2 Apr 2024 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712071784; cv=none; b=kYdeLzooT5sN9xGEqKsniJEfoNG0nN+BqhuLw6pyjF4olhr0sxEecDEWO2FHYtNa1WP0FU+dny2DJVYVRZUc3/Qg8jVKTPj3lgnlOPvjUg8FMWEjmZwxinzIu3/ZpoLax0dG/gtZ5CFXuDlMmX2GKYX30V1tN5feMywHgyYo/JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712071784; c=relaxed/simple;
	bh=pZ5+temZd6PzjiYP8OD7OYa38fF/HLXZYtmQBOTAGSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDmbVtxoHgFafh7rHpQ5XzSzw17winMRAdYNiPTNJibMJxxPMlIePrzhsovVWVpsq7eJXTMudqGcGKGness3JrduiReoAKX67qd4S+HllSNyb25ZcxN8JGIVN6A/73Hn3Gbb316mZFR4URbLWEfI7dye+WzUVGbIqYmhNWaq6ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=UfZwOn3W; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="UfZwOn3W"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1712071772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wHuxbGwi0qIp9uGC0VAWPMH/KydQ5wdYiML8RwPwrU8=;
	b=UfZwOn3WKnjaBoMsH1RmIajmpPmFOnPlQ8rgZF1rKJJLQM1wgwAb9Fuk3eZ2OjnOMObseD
	gCrS/WyBF3d/Ei/veyKNbQx3RXw3xae1wuv2tzeF/OVlritaCRt5NyF1DYCorUgTil4oxo
	T4UlwjfkA/GOKqKWASLFgHiJF7kI3qhX+qUue44WlbT7dM1j0xK1gJ/x3fVHz/VQzp5Yuc
	P2Cm1onhSaamAYP25BhX34RMds/OMGbbUA/7yRDehB+IwY2SSkJ8Ur+Xl+wCYB4hiYHq4P
	dqu26cFGoyVLTK29/g4na7krJ2TB23Qrct23xzeT5uXbKeUDEA2cTS39wzF67Q==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 5/6] checkpolicy: drop union stack_item_u
Date: Tue,  2 Apr 2024 17:29:24 +0200
Message-ID: <20240402152925.99781-5-cgoettsche@seltendoof.de>
In-Reply-To: <20240402152925.99781-1-cgoettsche@seltendoof.de>
References: <20240402152925.99781-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

The union stack_item_u is only used as a member in struct scope_stack,
but actually never used.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/module_compiler.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index e25a77b4..4efd77bf 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -21,14 +21,8 @@
 #include "queue.h"
 #include "module_compiler.h"
 
-union stack_item_u {
-	avrule_block_t *avrule;
-	cond_list_t *cond_list;
-};
-
 typedef struct scope_stack {
-	union stack_item_u u;
-	int type;		/* for above union: 1 = avrule block, 2 = conditional */
+	int type;		/* 1 = avrule block, 2 = conditional */
 	avrule_decl_t *decl;	/* if in an avrule block, which
 				 * declaration is current */
 	avrule_t *last_avrule;
@@ -1464,12 +1458,12 @@ static int push_stack(int stack_type, ...)
 	va_start(ap, stack_type);
 	switch (s->type = stack_type) {
 	case 1:{
-			s->u.avrule = va_arg(ap, avrule_block_t *);
+			va_arg(ap, avrule_block_t *);
 			s->decl = va_arg(ap, avrule_decl_t *);
 			break;
 		}
 	case 2:{
-			s->u.cond_list = va_arg(ap, cond_list_t *);
+			va_arg(ap, cond_list_t *);
 			break;
 		}
 	default:
-- 
2.43.0

