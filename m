Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589034E1C87
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617621; cv=none; b=oK72A0GfwG5r6lmtT7utHiie1PyxF3J///8BwdbYLyHTxABb6sIFgarUfo/CmgiIUILY8D4ESfk7uy68qylMuRlj6Xr9A8BdoGoSWUYg0VG2VTYoHUF3ARat1gPufzy7iyyFm9ucpdPQa/5lGgx3eVvbOpkDPaxlXvQHaOHJ6eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617621; c=relaxed/simple;
	bh=vGLl7geATzfh6Suaw/RgkUTabcM28tFNiueams8yfp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QBkAa+FWbmJxzPSajYixl4wKdrXKqknO0vnKqgv04COo5Js5TcZ8aZG6wa8dWwlu97IKgxj3fedAaJzDUjsUfV/V3jC0w+31COke+lxO8/YF59cWB75OgysnxZpeVKzbTj5dlEPSBChGrnVqCmc4zm1xJbRPI6AvNPlZyKAUKrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=uqs357xL; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="uqs357xL"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617617;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SmD9MRYoMnl5mZinj8xT22Vgunfr4kZ23D8/qA7agi0=;
	b=uqs357xLB7VmReWF2OLphXS0bMUC7f7wFj+lSeYFkysbNjpDTlUZ1syXFhjwh1FU7DbFUz
	bGGSS7w+8VtlnwZq54vZ2nB4twqZVjYWBJUqanMeRQScgFeFTYvzOIea9KGxeGVzvhnNfM
	rk8lHH1Px9PdcteAnmADG0Cl48aWYO+5BRqoMQ1m94icn+F9nK72DaX5lqhhz4Cmq2R1ZI
	sSoPqGT+E+O6cvvauyC6Ws9EzpRXF7/bULX5uFq8yUoq4B/8Hyq+ATM5a8jdxByTZ91zFO
	36JAII2i1NzG/2alHbs5IpIiBAAsGkEGQWY6dUVZaY9z2wDdfR1U12yHxfrdFA==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 05/32] selinux: use kmemdup_array() for conditional expressions
Date: Mon, 28 Sep 2026 19:46:15 +0200
Message-ID: <20260928174643.2458710-4-cgoettsche@seltendoof.de>
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

Use kmemdup_array() instead of an open-coded, unchecked size
multiplication when duplicating conditional expression nodes.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/conditional.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index 2956dd7edea7..b517e31959f5 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -655,10 +655,10 @@ static int duplicate_policydb_cond_list(struct policydb *newp,
 		newp->cond_list_len++;
 
 		newn->cur_state = orign->cur_state;
-		newn->expr.nodes =
-			kmemdup(orign->expr.nodes,
-				orign->expr.len * sizeof(*orign->expr.nodes),
-				GFP_KERNEL);
+		newn->expr.nodes = kmemdup_array(orign->expr.nodes,
+						 orign->expr.len,
+						 sizeof(*orign->expr.nodes),
+						 GFP_KERNEL);
 		if (!newn->expr.nodes)
 			goto error;
 
-- 
2.55.0

