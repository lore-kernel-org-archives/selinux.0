Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F1512D76A
	for <selinux@vger.kernel.org>; Tue,  2 Apr 2024 15:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712071782; cv=none; b=HDi7enwHL4ARG/hHARTmlsDySN19KtgvdrM+xbPLdP+ohb/UpOASKtBHhj/Fk2lLjdlj6WUFlJgQ/qFN8maKxdR+YATW2QJvVCOeBHWigru+k7jVeqHskMEx/jH0YDTmNSB9m5dRf5BSVn2fNoY+V17alvYRJhzGqIxQwsrPi8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712071782; c=relaxed/simple;
	bh=SxBpJdtFCFEzvKOudO6pgFbLf4W/kxZkF21S0DbD530=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qGw/Hu4+T/iS5YiifQFPQIUfWqCxrup0Ni+G+aV1bTMAmI5+JhsgRC6ebcUKc3HaP76J5NlMsi9DsY46oUl9HUnOtP6nx4me0izEojwrlir+B54/f6C1TaIZhw0cE0ipcgJkCc3/qft+jcQ2lq0bnqdhEwigu9RVzAtQf+qOuFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=COfO5+Ct; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="COfO5+Ct"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1712071772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ykRh5F9oZW4xZQLz5wG+Dg/BTp1Xi2IK3m+VKvTx54=;
	b=COfO5+Ctm3uN5kfVuYnvMccEhP7Ws4NxIaJvRhP215c48TX8uR+QqSJEZsCShHEVBX3Yh8
	/py8b5PnPDwHpcAirP8xL8XQXXFx1nMCjmwQBAbiSthhxt+m/oLfXaOZACS2LJoP6eg9Ni
	BFQDRFNnP1uSvc5RZYoTbOtLa0M62TodPGjDj6tYwGoANdFvnhs1lLjXt+2mq0B1MSzkWK
	MdDK15ZMrUIfdznkTeYkWkhV4uJ+MFxBkESdp5BziV33v7c8FfjksIriG9+vWt9i1LUb3t
	YxDF0zsBVNpzCz9qEQTIbqsva0G0yt8quVkv55AcIKMWf0GhfyQOCc7udmRZHw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 4/6] checkpolicy: drop never read member
Date: Tue,  2 Apr 2024 17:29:23 +0200
Message-ID: <20240402152925.99781-4-cgoettsche@seltendoof.de>
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

The struct scope_stack member child is never read, drop it.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/module_compiler.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/checkpolicy/module_compiler.c b/checkpolicy/module_compiler.c
index 6ff91b8f..e25a77b4 100644
--- a/checkpolicy/module_compiler.c
+++ b/checkpolicy/module_compiler.c
@@ -34,7 +34,7 @@ typedef struct scope_stack {
 	avrule_t *last_avrule;
 	int in_else;		/* if in an avrule block, within ELSE branch */
 	int require_given;	/* 1 if this block had at least one require */
-	struct scope_stack *parent, *child;
+	struct scope_stack *parent;
 } scope_stack_t;
 
 extern policydb_t *policydbp;
@@ -1478,7 +1478,6 @@ static int push_stack(int stack_type, ...)
 	}
 	va_end(ap);
 	s->parent = stack_top;
-	s->child = NULL;
 	stack_top = s;
 	return 0;
 }
@@ -1490,9 +1489,6 @@ static void pop_stack(void)
 	scope_stack_t *parent;
 	assert(stack_top != NULL);
 	parent = stack_top->parent;
-	if (parent != NULL) {
-		parent->child = NULL;
-	}
 	free(stack_top);
 	stack_top = parent;
 }
-- 
2.43.0

