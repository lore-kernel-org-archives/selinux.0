Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CEA4E50D9
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617624; cv=none; b=PRxF5V/Wd4Fxuh4aE6kbOtZtJh097eb6Uxxvy39gXW9zOhQVSzRwLINepjNmvwfJweSaNeaJaywtvVjYdCtYJrRk5xnVKAe1aIt0DxYo2CDgMhQK1+R7DIo+1cOd9KITgUvJBv9euzYep+rjDtWmNZaPLyQySe+P1anes85bOJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617624; c=relaxed/simple;
	bh=mgMfSKgJcef+8JOeP11TYuPN8n8yIdpAyyLhFbzQVFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5KFEtuFtOm73Df++9I1fM6zGr7LkwflCA82lSH5RNwk+ldBg4QKiGgswy+zuJo7Hf1Fn/7YAWCoP70qtGOYvIZyKrlLY6TxLBbj0CC/rRBBKg52ZMvx1ABCO0e7R3HBQk12sGI708rEW8/MF1qcUzvhfD0nPuND+qLPJsPo/Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=a1pq8VsM; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="a1pq8VsM"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617618;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ucfvG728LzmHwHXCjMdiXbIsYxTIC2ArNuHpVhabRyY=;
	b=a1pq8VsMJQFJ1Kmp14BQPdd4DOvu67WIi95DtQt/X29tnv89r+I9+yirDluaur71wd7diK
	/4OEl+9taOtHzwPwQZW0Oi/qf3EWxRQBHB5uwKGHfhQfpDg9+HeHAHPgElHbO2icOopxxv
	pVxCOxL0oWd91Y9+U3iHg1MCmsq+6QtIjwkrtQmHOh8CgzaMphB4pBeMbfthL+YR31f+gi
	rKuasiqkGz1UTOoJTcZnzAxck7THmC/hMSs7DkT8tnE7DFskA+lFqt5ypGoZ8swaJ0cdFx
	08/43o+0F5L3xpMn3/BEPdO/oOoAs3pnxS704gMqfV9GrRdv09KIoL43tt7G+g==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 08/32] selinux: use rounddown() and roundup() in ebitmap
Date: Mon, 28 Sep 2026 19:46:18 +0200
Message-ID: <20260928174643.2458710-7-cgoettsche@seltendoof.de>
In-Reply-To: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
References: <20260928174643.2458710-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Use the generic rounding helpers instead of open-coding them, as
ebitmap_write() already does.  EBITMAP_SIZE is not necessarily a power
of two, so the non power-of-two variants are required.

This also changes ebitmap_read() near the u32 highbit limit on 64-bit
systems.  EBITMAP_SIZE has type size_t, so the addition is no longer
truncated to u32 before rounding down.  For example, a bitmap with
highbit 0xffffff00 and a nonzero map at startbit 0xfffffec0 is now read
normally instead of being accepted as empty without consuming its node.
Bitmaps whose rounded end exceeds u32 now fail validation instead of
being treated as empty.  The 32-bit arithmetic is unchanged.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/ebitmap.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/security/selinux/ss/ebitmap.c b/security/selinux/ss/ebitmap.c
index fd489d8cfbed..f2e67aa5d9cf 100644
--- a/security/selinux/ss/ebitmap.c
+++ b/security/selinux/ss/ebitmap.c
@@ -185,7 +185,7 @@ int ebitmap_netlbl_import(struct ebitmap *ebmap,
 						   GFP_ATOMIC);
 			if (e_iter == NULL)
 				goto netlbl_import_failure;
-			e_iter->startbit = offset - (offset % EBITMAP_SIZE);
+			e_iter->startbit = rounddown(offset, EBITMAP_SIZE);
 			if (e_prev == NULL)
 				ebmap->node = e_iter;
 			else
@@ -320,7 +320,7 @@ int ebitmap_set_bit(struct ebitmap *e, u32 bit)
 	if (!new)
 		return -ENOMEM;
 
-	new->startbit = bit - (bit % EBITMAP_SIZE);
+	new->startbit = rounddown(bit, EBITMAP_SIZE);
 	ebitmap_node_set_bit(new, bit);
 
 	if (!n)
@@ -383,9 +383,7 @@ int ebitmap_read(struct ebitmap *e, struct policy_file *fp)
 		goto bad;
 	}
 
-	/* round up e->highbit */
-	e->highbit += EBITMAP_SIZE - 1;
-	e->highbit -= (e->highbit % EBITMAP_SIZE);
+	e->highbit = roundup(e->highbit, EBITMAP_SIZE);
 
 	if (!e->highbit) {
 		e->node = NULL;
@@ -426,7 +424,7 @@ int ebitmap_read(struct ebitmap *e, struct policy_file *fp)
 				goto bad;
 			}
 			/* round down */
-			tmp->startbit = startbit - (startbit % EBITMAP_SIZE);
+			tmp->startbit = rounddown(startbit, EBITMAP_SIZE);
 			if (n)
 				n->next = tmp;
 			else
-- 
2.55.0

