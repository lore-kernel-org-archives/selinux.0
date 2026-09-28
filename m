Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6159E4E5337
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617625; cv=none; b=O+ZFMjThLmtcFtcG+c/VOoXho+kTvjWKzsueVboPV13iclpkJNq1csqdLTTchI8T90vrHJ2PjzqQGK2dM6E/vdPE7frjLEWe9jNilOA1YiQLBs3sJWzB9/J4sk5EG6O5dCTikt3FKO+yeFp48rFHL6jZnZlXRNKaPnSgYy9hzVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617625; c=relaxed/simple;
	bh=EJPjFwNKqiJqellTk3fybkRTCtDBzK+fyrSkXZ4TUS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oYjvucFVAqxbro9ooHLxIAExzHy7Y9F/1txwp9oCCrWAPcbB1mSfbArRh/84imMy9DeeHSmYoXzzw+8pRqcA5U2c6Gjpokb2pf5gDwdV2T4HBJfmbOZsFVQrX759EpP6Ff0aCjJYRgVLr34gPGkYQS1n+/xupMtCp5n1eOiLfbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Mv95/i0Q; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Mv95/i0Q"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617619;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H/6pUnI2sH2MdjwkEr+17romwxPl+/o8ig9oqUOCgwk=;
	b=Mv95/i0QzAO0NssT52u+A4D5ZLj96/CkjcNuUV6FmsgrIjG6FwDXcPZ7jzAyhsXNdFY5KA
	2UVIBQKAXxYk/m0HU05gBYijsyyo+np+BmCeikxGe41ooi7u7LgHZn4fvCTnQvYWMy8odS
	T2GBOaNjzZLbpZ0hwEv8rWW85GCtgSRTu3d4qKN1HeczlwhJwBoi+WMkro1fH21o6bF9tJ
	e2ANjJtJ/3LNf1MTf6fwdLd7A7+/ZCZgUtej8OcaZmEPWqNLxGkwR1RXXfBhnkeetFA6/l
	yXfOqyYiedVrniw2MHkRVsKMbehuFiL0kLKGAzkHXyo9bCznyYwTHYpPhDq0kQ==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 10/32] selinux: use struct_size() and isdigit()
Date: Mon, 28 Sep 2026 19:46:20 +0200
Message-ID: <20260928174643.2458710-9-cgoettsche@seltendoof.de>
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

Use struct_size() for the size of the flexible xfrm security context
struct, matching its allocation, and isdigit() instead of an open-coded
range check.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/hooks.c | 3 ++-
 security/selinux/xfrm.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 9444c4d0b901..0c4511325ce3 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -31,6 +31,7 @@
 #include <linux/lsm_hooks.h>
 #include <linux/xattr.h>
 #include <linux/capability.h>
+#include <linux/ctype.h>
 #include <linux/unistd.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
@@ -1345,7 +1346,7 @@ static int selinux_genfs_get_sid(struct dentry *dentry,
 			/* each process gets a /proc/PID/ entry. Strip off the
 			 * PID part to get a valid selinux labeling.
 			 * e.g. /proc/1/net/rpc/nfs -> /net/rpc/nfs */
-			while (path[1] >= '0' && path[1] <= '9') {
+			while (isdigit(path[1])) {
 				path[1] = '/';
 				path++;
 			}
diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
index 8e00b3306574..946846edb566 100644
--- a/security/selinux/xfrm.c
+++ b/security/selinux/xfrm.c
@@ -295,7 +295,8 @@ int selinux_xfrm_policy_clone(struct xfrm_sec_ctx *old_ctx,
 	if (!old_ctx)
 		return 0;
 
-	new_ctx = kmemdup(old_ctx, sizeof(*old_ctx) + old_ctx->ctx_len,
+	new_ctx = kmemdup(old_ctx,
+			  struct_size(old_ctx, ctx_str, old_ctx->ctx_len),
 			  GFP_ATOMIC);
 	if (!new_ctx)
 		return -ENOMEM;
-- 
2.55.0

