Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACEF37C91B
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222155; cv=none; b=fcKAf4VNqsf1vu3Zr6dqCHkOkMWTdAcOpRubZm6W+wgFpw01/EwqE51NDYVNFoR6CgYWvERubewJmgOhPwT3oxGW03aVJk/Fp9vr0nXPsZdWTv4X9aTkXfO3XXi3pCztOL67k7LNglF7aqCue3L9FPc/SqIcrScJLifoESKUawI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222155; c=relaxed/simple;
	bh=aOebUDaqPttAHchz8wFYIixukwNNBoFxBa1NaFYTADk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9gT6/gU9COLqIbIhXhoi6NxaG79tVKfBnPCMWxGZjhnELMs1NR/NwScWZUOQ7rrhuPvhiPXiK7hrtFmHQq+h9z3jvgSgh4Sl5fRIaCnyeGhEa3IocVod0UNfa5VIRNUCymBD69hajS1Js7WUv2tTyL7mKEeSes1ZvtlIvn5Lh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=qFOhNwYf; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="qFOhNwYf"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1782222151;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TkhZTBLm5wilIT073Rp4BdkJohrSt8sYGFGNMf7+orc=;
	b=qFOhNwYfBliS4876xiBzIt7aQ90PUyX33GBuDyNM5YjUydAbPxRk+9xYs2/oQ3WEukmduV
	KhW9vce31Cn6+P5uDCkrteKpQKcAw+7uiQTPyz4yE7l5sw4w0lgSIg7l/kHGsJcrkd4Kw/
	I1G5GO8aozoE5Njg6tfa9Oxg9GEOL5b+2Llpsp6txPRYDVYQGcSn+1loXv57qFJZl3r7pA
	2F65/xEXBkS/CIlrCLNdAc26IX56f2aM8OOEfzADeY28f2jom+GcWePY+Pig/b5rrNRZl0
	rjqkUiMIvxxF1+KVYRnHaUKioDW5PI2yw6DbC3X/BQvbFEwQsK5wYzcdiqyeEw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 08/24] libselinux: assert avc_running in avc_compute_create
Date: Tue, 23 Jun 2026 15:41:57 +0200
Message-ID: <20260623134215.98273-7-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-1-cgoettsche@seltendoof.de>
References: <20260623134215.98273-1-cgoettsche@seltendoof.de>
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

Match its siblings (avc_compute_member, avc_compute_av, ...), which all
assert the AVC has been initialized before taking the lock.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/avc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c
index ae988729..779ce8ab 100644
--- a/libselinux/src/avc.c
+++ b/libselinux/src/avc.c
@@ -850,6 +850,9 @@ int avc_compute_create(security_id_t ssid, security_id_t tsid,
 	*newsid = NULL;
 	avc_entry_ref_init(&aeref);
 
+	/* avc_init needs to be called before this function */
+	assert(avc_running);
+
 	avc_get_lock(avc_lock);
 
 	/* check for a cached entry */
-- 
2.53.0

