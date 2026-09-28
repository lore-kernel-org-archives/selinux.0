Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A1F4E5340
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617624; cv=none; b=O7PSe0KXDfQZ+sm6611ty5cdSjGw0/z+8ubaKC2Z5KviYPbrYu6JB/EZP6VfkxLnD03281B7LGB4jLfSPjOquq8I0yKbtCNEeWXD0q4KvHS1LVFbOrTZJZ32eGrb9DEvjv0cSZX6LiM9kK/9PBI0NzD+z4TygUHUD+AUxTzx1E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617624; c=relaxed/simple;
	bh=UhQCq6NfTP/0NWz4OExqYEje2R45eB1w9tmEWMvEqI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hyVzvLb5FY6oBqES/cDAUHwH8rMDUBdrrNtKruU9K7OMF8GUmDs5bHXLko8MRpxdtUHQAuoxyE1m3uWQHaD7qAsuNGH10hh3Om9nJEo699LDajObaK/QQSmKPBPAlpCeujvCEkv2FOUNEz9En/YXFEB+VCaYrqFGIKoiUSPuCvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=KzL3MIaA; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="KzL3MIaA"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790617619;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lksGgUyV0YpI8pDIFzz4gay6C3s0Q6ikiF+vcUO0RYg=;
	b=KzL3MIaAyefGA/D/C4WygsyswCKMuLFFT9dBoTU9h+mFpTKMxo1Er9aun5rExla1HoK4Du
	gtAWBhcDlMRNpqjiOCiqAooTOwkFn5C6vdKkr4ewWQapxeaOmPsd4aXhUgQ8ICgtEH79BU
	+qU/20SJWc6pLdXjKAKaWBgWt2ekh8tu1loa+aejpCpu+3QCZSEPh7VLrjwnq2GXbE4V+2
	NC+JqsJE4alvCGzF6iFUoJiRCsbv4iR8Df5KhLW0KHkHTSYSNn8ggrGtwar8fGU9VmpnuF
	K8emiKnaia03NN8ABWIUa/zsHHWY1G4aN2s/oIae4lAabiRO4IzxjgqBYVn31A==
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnacek@gmail.com>,
	=?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 12/32] selinux: avoid context string allocation on getxattr size query
Date: Mon, 28 Sep 2026 19:46:22 +0200
Message-ID: <20260928174643.2458710-11-cgoettsche@seltendoof.de>
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

For a size-only query of the security.selinux xattr the context string
is computed, copied and immediately freed.  Pass a NULL buffer to
security_sid_to_context*() instead, which only computes the length.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/hooks.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0c4511325ce3..67f96fc95492 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3630,21 +3630,18 @@ static int selinux_inode_getsecurity(struct mnt_idmap *idmap,
 	 */
 	isec = inode_security(inode);
 	if (has_cap_mac_admin(false))
-		error = security_sid_to_context_force(isec->sid, &context,
+		error = security_sid_to_context_force(isec->sid,
+						      alloc ? &context : NULL,
 						      &size);
 	else
 		error = security_sid_to_context(isec->sid,
-						&context, &size);
+						alloc ? &context : NULL,
+						&size);
 	if (error)
 		return error;
-	error = size;
-	if (alloc) {
+	if (alloc)
 		*buffer = context;
-		goto out_nofree;
-	}
-	kfree(context);
-out_nofree:
-	return error;
+	return size;
 }
 
 static int selinux_inode_setsecurity(struct inode *inode, const char *name,
-- 
2.55.0

