Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720221A0AE1
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334646; cv=none; b=rNqkWGUPDjZ/Q4HCEuuBNqPxqjcL7qWavoPjuT0zppQQvtU/loji8MRGW8o2682gMgNUJNyckCHz62E+1iYwxxq14o7NbQ/sv4AbXbKFaEsTOGezwa0qcvP8nyLltVLlqWVrq78C8x218EvzCYPQQ4KXNsz6go3tXsU3DkG+7ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334646; c=relaxed/simple;
	bh=jy+4uu56ZBI6LRSQoWPHTUp6FhM0zJqVSnWLUB2nPQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sxkXBBPnWtdBzgd3t5Eo+IQ7fB7abjfFi9D/28mJ7GQxKuRZRemVwQ9dZMCXGGiTO56C/W41HrmQXQJ8OUy/Vgi3NjIad5uUcqZ/LfXukNJyH2104Q6iTDClBOLmThJGor5f2G47TImYxKhDlBHft5p6zcnBQj7yR7pP2Y0TMgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Q4dp2XWo; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Q4dp2XWo"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334639;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rmjhc1yB/zOEuR/UGia49sz1OrD+jjjZCThVRbuDBfo=;
	b=Q4dp2XWoEpDGg7PXiLQwo/sFfeAN909/XEepPHJb4BlbFgVVdp+psnrRotvLk1WZVo3B3W
	7ZWTXZwM15dOqlKoIf7EqhUBDxsUzwc58D4j7Rcb44oQLG0KX81e4OkxAPPCDRopGi16eI
	UXXMW+9JeF8+Ryokq7AAGTBBOKjksjqv7zIWMULAW2c03iG5K9sXH4p8XUcZeQLLXlhvwi
	bFT0OXV00MLRrTnSPG501UualbUzhAQ4ae5Leb/YorEzjDLf0Cn7TYmNmn0ZECIxIcdIdV
	SOvZ8L+7N3DXNGvhq5/pdDej0UWlfV5Dn3H1T7pXThyx8AIbtG34dzwGfydjzw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 36/47] libsemanage: drop dead code
Date: Mon, 11 Nov 2024 15:16:55 +0100
Message-ID: <20241111141706.38039-36-cgoettsche@seltendoof.de>
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

The variable num_modules is already been dereferenced before the NULL
check, and also the code is identical for each condition outcome.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/direct_api.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 3b2ab449..b10e5c8f 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1958,11 +1958,6 @@ static int semanage_direct_list(semanage_handle_t * sh,
 		goto cleanup;
 	}
 
-	if (num_modules == 0) {
-		retval = semanage_direct_get_serial(sh);
-		goto cleanup;
-	}
-
 	retval = semanage_direct_get_serial(sh);
 
       cleanup:
-- 
2.45.2

