Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F4E16F848
	for <selinux@vger.kernel.org>; Fri,  5 Apr 2024 15:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330141; cv=none; b=tvz10BN8vYzvg8NmVPcLUTkHbQ9kZyuDOci4DI0YnU55bzBZkhbv37aReJ5fN5VSgSobu77DoErTO1yWVP7oU9FQbMhLzFI/Hg5vwA5IGZvRng8Ic2494QTYTVN0vtWicJa3Bus/Jwfb9QF6YR93VguuR6wwoCujV4FOq673ucM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330141; c=relaxed/simple;
	bh=Wn6/cO+mM+2tfy/EktQKRjS2Euu0cwRqDhfS0RV37a0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V2D3qJ/0MZ6oExA0EhOe6gQTLZlLLastsWmnC7LL5hoTAuKaAN2r1q39ADdwBYGPE8NuGs57grpOmjxCIND7JK7a4bihkVWBBIpsqRx6Gb2Y8rxYOFukvCwpl+zQ6f9iY7usb9JHJQTVz3uAYWqeSRNtZxivSbJpvjGBs2+eXNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=lQh9N12B; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="lQh9N12B"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1712330129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g5LoGc+T4+//KahY2YPmr6UtB6QrPSQoOyVjkMU54o8=;
	b=lQh9N12BxPbLgcnZpMdpEmVNxAUTtoznsfmOlm/EMeSbYSGJLuIwwviWW8hExHllqI7VoS
	RZiUyGmUcjL9uEkRer15YNB0vDobaIeyx4ZDxepzaNZwXFGCbcc/Kx+b0jw/uqgHz1K/cR
	uulQO4iTtb/9A+CiGfCbuUztcRKe3eJqYWdRXHf1/HAJEwEdaG+0bfQx2XpweV4gtU3Dqg
	tkJbecYApMUc1PcK0mYhwcT0PkVC8LQgP0BN9TB/6ZoIvqEEFiijRxq1G3VFN/vWDF/6Y/
	hnYRs/0A8yZ+GCH4XQjW4zXrHOOC2e5/zriZdLRul13VF2V4oJj6mehhcnQQTg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] selinux: avoid printk_ratelimit()
Date: Fri,  5 Apr 2024 17:15:23 +0200
Message-ID: <20240405151523.92010-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

The usage of printk_ratelimit() is discouraged, see
include/linux/printk.h, thus use pr_warn_ratelimited().

While editing this line address the following checkpatch warning:

    WARNING: Integer promotion: Using 'h' in '%hu' is unnecessary

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/services.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index e88b1b6c4adb..f20e1968b7f7 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -633,8 +633,7 @@ static void context_struct_compute_av(struct policydb *policydb,
 	}
 
 	if (unlikely(!tclass || tclass > policydb->p_classes.nprim)) {
-		if (printk_ratelimit())
-			pr_warn("SELinux:  Invalid class %hu\n", tclass);
+		pr_warn_ratelimited("SELinux:  Invalid class %u\n", tclass);
 		return;
 	}
 
-- 
2.43.0

