Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133291EF0B7
	for <selinux@vger.kernel.org>; Tue,  7 Jan 2025 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257587; cv=none; b=uQzbDF+hX9bZU6QhLJkma/L1Mv4nd/mIFKuaAFb4DSqNSHhcMGljPWvn6wDT3MAP4Jpp80kxVbPFo5ZD8qWs7uow9Zexpd0oJNisRoqVdrBF3BLqF/hEpFNv8hDZDgj3THBhktVh265+Efv9N08uWzzPf4NOqJ/yIDyP3qdotp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257587; c=relaxed/simple;
	bh=XN8+VHKCjrLNcUjNZC6WEyqOZSyTuyha/+R/XHtk+9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DF4UOtKIMspLViiCU46mG05dyfyV25hlDYp99Hkp785tSJaQKpu83XZs4/cbI8QKZQ/S/EjMESf1M4RlPteMCkElcDVLZQrcZYdMydZB8PMDC57Q95F8AHk5x/GWXKQonMIiSK7w+d+wy4mqmS4iqJDaAlrwVrd3Kf0xJQcVYAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=P5ofDScy; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="P5ofDScy"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1736257575;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K2buxpvgNvi1xv1xbtyYsi1+3SpnFzu17Ui/rU0vLnA=;
	b=P5ofDScy4BeKUN3whE14Vxf1EzbaEC2zu7HxXmvOtrpQIdUbRZCLk2D1n/etgDOO+RTMTD
	TojdoQ9Qp8yek6V4+dj06gqm8s9z8Xy3Bhu7NMeBihPRJnRiDO9wbRHHVvwGYWvnU2rkex
	F9Wa/XTHIONU+Vy8pt5Bs+3aLX/fHOht7vbHUPFaCxEDYtD8Tg5wnmeVv7iOnh/UbPEkRA
	Bdg2KE/UXPL1Px9+f4XJSRUlARHFxDrNI0GHavGA+Zk4IyHy4QiQ7NYe3zSQKgehiGGTvU
	P47TlIKEmYCE8W9dMuyThMyWak8PJ2Qx699UfHIv9VRvUF+i0NBChzD+0v0BXA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH v2 13/17] defconfig: enable CONFIG_XFRM_USER
Date: Tue,  7 Jan 2025 14:46:01 +0100
Message-ID: <20250107134606.37260-13-cgoettsche@seltendoof.de>
In-Reply-To: <20250107134606.37260-1-cgoettsche@seltendoof.de>
References: <20250107134606.37260-1-cgoettsche@seltendoof.de>
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

Required for inet_socket/tcp checks.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/defconfig b/defconfig
index b2d4a90..b86a1dc 100644
--- a/defconfig
+++ b/defconfig
@@ -10,6 +10,7 @@ CONFIG_SECURITY_SELINUX=y
 # For testing of labeled IPSEC, NetLabel, and SECMARK functionality.
 # Not strictly required for basic SELinux operation.
 CONFIG_SECURITY_NETWORK_XFRM=y
+CONFIG_XFRM_USER=y
 CONFIG_NETLABEL=y
 CONFIG_IP_NF_SECURITY=m
 CONFIG_INET_XFRM_MODE_TRANSPORT=m
-- 
2.47.1

