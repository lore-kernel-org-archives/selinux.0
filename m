Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9E119D07E
	for <selinux@vger.kernel.org>; Mon, 16 Jun 2025 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750087863; cv=none; b=eFIpwwmtvhQSdHyi6S5tXzD/yndkhuOC6m4A9L3fIy2ScroPt22C4XbejQLUZiyYq8NAHWeVG3HWyiLrG1znzuIAI3ygkbOu48XY/VFolOWWs+3W0MYmEIBhhhb/0zPikeHEMouThnOQySlXEpJlV401gkWUTvFMR6kaL1N+pSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750087863; c=relaxed/simple;
	bh=Rdjk30Sh3hwcm1gRXH00UfABXhEfib3IpB0exnoctUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kq2fw7WLwYeGGkmD0uxpFDegr3L2csZ1ecrjWb9ZlXVjLyNjQZ4kpc8BLv19sfFbWqlAsXdNMH8iU0YorNw63N2N6nheZlG9aXW02aAgswfpJoXnU4yNMSbcFraPTCD7oom6Pjl+iZaSSJS534O+pzNWFGCrJF8Dxuno4oeMyak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=X9D34xS2; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="X9D34xS2"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1750087544;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WED4tP3LF8DEUvNbe1LGe5FfnQGWjUKRkzQ3XsKjc+0=;
	b=X9D34xS2TElW2LThOPy6xRNGgZAUlOy3zxD7V0++Uw3Bzyc3hBpBiIWAddtg3Yupk99/s9
	43f2y88cW8ZAZcW2KqJHWcPvmFLSFRhw2wyhdwU4BVS1g4zL1i/ExPpGklVHoHIt2m2eqw
	QIGska2OQc8X/dWfRf6muGoto9QzJpGDFy25Mb+xHzruDQiHcENL2JKc/MW4S2N4gWVvFi
	7eq7h8/O3lRqMoOErQL50f9bEh/UgoRACDW6ky3wQOT4G/NpLwkOBudicltKCJjpW0Le1h
	6tgbWPKWWjFwtJ4UVKiwDfMQps2/Kbg/VeSnDDjT/ytZRM3AF7PUrOTNvPsJ/Q==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v3 4/5] secilc/test: add test for wildcard netifcon statement
Date: Mon, 16 Jun 2025 17:25:32 +0200
Message-ID: <20250616152534.26053-3-cgoettsche@seltendoof.de>
In-Reply-To: <20250616152534.26053-1-cgoettsche@seltendoof.de>
References: <20250616152534.26053-1-cgoettsche@seltendoof.de>
Reply-To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 secilc/test/policy.cil | 1 +
 1 file changed, 1 insertion(+)

diff --git a/secilc/test/policy.cil b/secilc/test/policy.cil
index d405a0ef..e3b07fc8 100644
--- a/secilc/test/policy.cil
+++ b/secilc/test/policy.cil
@@ -289,6 +289,7 @@
 	(portcon sctp (1024 1035) system_u_bin_t_l2h)
 	(genfscon - "/usr/bin" system_u_bin_t_l2h)
 	(netifcon eth0 system_u_bin_t_l2h system_u_bin_t_l2h) ;different contexts?
+	(netifcon podman* system_u_bin_t_l2h system_u_bin_t_l2h)
 	(fsuse xattr ext3 system_u_bin_t_l2h)
 	
 	; XEN
-- 
2.49.0

