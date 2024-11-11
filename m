Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FC11A01C3
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334641; cv=none; b=CUB1dQhhXhoVcNi0avStnOREWTy3/2K5xWlqiBYkG4EkGemxD0YmDKVIGZ6acO7NOsFp8pqW1YuY+L3cFy9AJrUTNixTIbRSUQT/oDdVnmD2YEvbbYpz7EvzD2zAhXsDKM+A1mI8px2eNdqGPlPqZ0yyTPDEE99RkXXuma680u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334641; c=relaxed/simple;
	bh=mNzjuVVYk4ihMJIufHQj/QE5Yr8x/JHlQr3snt2zed0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aohDgr9qEjutlshrQi/pvGAyBwK1meR6+aYWYa97XIEXmpnlr8g3s+tApgUNSm4VkejlGFS+6GfpmG+7LCFbdutyCmPwQPyYjtpl7Op/gABuzQj06Pqz/3T6psN1XSBCNOdGiNVbhM1/irR6gLnvcLYcVzOqFVA/I8NQM8ZoDRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=m1anhFcz; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="m1anhFcz"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334635;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hy6MACwipdsTTMvFPvD2QsfECfdAB67fKKSBlCb3Erk=;
	b=m1anhFcz07qOr3XAgXNO2r6Nn1/7Lg/8mN9oZIpIRoJgZteBas9SZB7HzUqoz8drhKFzwV
	6Wcsh6Tz9156FzgZK4TVwLWpCP03nEIsiPaM9iGG+RJWC9pt5j5cK1liFj5v7vrQ/3cXrU
	su2nmUMylOGgfa7NfTKwkM5NbZYOHJ9y+rp6Ba+08QokfNP387C6RvKOH1FVtaQMyPutSQ
	bfuwa0+Zi2sfF4D3L+VqqnWnQDDgK5RxgOOQbWes+N0bDOREGrg7CAY0fYZqdCIj4oQK2y
	tRXio2+JIT+eoumKX4TG1dtWYDxVKrNRIZWpEnj4qGZYT53ZvhOVh7G0bEjzvQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 12/47] libsemanage: use unlink on non directory
Date: Mon, 11 Nov 2024 15:16:31 +0100
Message-ID: <20241111141706.38039-12-cgoettsche@seltendoof.de>
In-Reply-To: <20241111141706.38039-1-cgoettsche@seltendoof.de>
References: <20241111141706.38039-1-cgoettsche@seltendoof.de>
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

remove(3) just calls unlink(2) for non directories.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/semanage_store.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 7c9f5b2a..29bde24a 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -880,7 +880,7 @@ int semanage_remove_directory(const char *path)
 				return retval;
 			}
 		} else {
-			if (remove(s) == -1) {
+			if (unlink(s) == -1) {
 				return -3;
 			}
 		}
-- 
2.45.2

