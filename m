Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B19613F43C
	for <selinux@vger.kernel.org>; Mon,  8 Apr 2024 15:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712588892; cv=none; b=JnJrjS4kU4x3TLTpY9IwzujLS7mEQPZPZf36+wLTCJgmhDD+j31p30GifsgXkL+pvUONquT4DpqejEEUy/LOF67/1ZpZHH4G11wndXblgMA3Bu0DxO556kcvMobxpCwC6zhlnf4wJ72aEV3ncD4cn8XzSC+PesY8NcAo2vMdxQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712588892; c=relaxed/simple;
	bh=noGWYRH5yHLmCesg7SRF4cEjrbCtBs5cPClwGC/uark=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T46k44Ae6ZLTXyt0/DOyiiiSOFVs2NzJJi3EEWvmME9tGyzFIAKxEk0Tf0uc0kffP4yEBFNg+3U6PMWYXMZ3vgmsFmfdddynH5cD5pD7dWDtJn/9SRgeslkRIaX1bJn/4QGX6fvX2DIqQ4Kq14hWXHws2Yn8vytmANV9DiDIyF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=coIeJs9Z; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="coIeJs9Z"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1712588888;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CRibdGMLlrMAUqYnRQbm/JB8dJS9+JcGQuUDjZQDGTs=;
	b=coIeJs9ZOpxPLn4l83U3sxa+v5vcbfXZaVibGg6bPhHVfSqlOUluh+EAwqnaINL9YkSZBI
	NmfrYektXDAcrY6fZJAiT0ab9GiqwPUe0vwbJitFcbe09I7svF0BxQZnvhrNzqrMgPLoVK
	pEL6W3U5CQedvsC7znIPFSXSQQ3INCqag6WDMvQb7UyYl9Unq5HPf9NuM0ls2RovIpVHCW
	dCs2ekaP8PdaV09SryYXgA55KCLp6xgNZYNbqb+Msm/nNH63WY7Yb7SzfL6pnIc53KafKs
	m7p6/ifEsGSm36QJAKusmjCMK2luazFI6LkVTxPQImxdfJOD1YASk8j3ldn50A==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 3/4] checkpolicy: declare file local variable static
Date: Mon,  8 Apr 2024 17:08:01 +0200
Message-ID: <20240408150802.63941-3-cgoettsche@seltendoof.de>
In-Reply-To: <20240408150802.63941-1-cgoettsche@seltendoof.de>
References: <20240408150802.63941-1-cgoettsche@seltendoof.de>
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

The variable policy_type used by checkmodule is only used inside of
checkmodule.c.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 checkpolicy/checkmodule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
index 14e6c891..e7869bf1 100644
--- a/checkpolicy/checkmodule.c
+++ b/checkpolicy/checkmodule.c
@@ -43,7 +43,7 @@ static int handle_unknown = SEPOL_DENY_UNKNOWN;
 static const char *txtfile = "policy.conf";
 static const char *binfile = "policy";
 
-unsigned int policy_type = POLICY_BASE;
+static unsigned int policy_type = POLICY_BASE;
 unsigned int policyvers = MOD_POLICYDB_VERSION_MAX;
 
 static int read_binary_policy(policydb_t * p, const char *file, const char *progname)
-- 
2.43.0

