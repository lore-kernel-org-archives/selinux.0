Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB231C3033
	for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942198; cv=none; b=GRXEiv0E8v+8Rz3J+mHl+scFZDlEbyZYCYdpAiAGFXKFfBVwm6Vm6Dbud8J3nT1gtcEWB1ZE2zKr4RkCH/hxYAKqxFmQwGF36z5uA1xGIaSvHsbXvAsquitC+3XXVl/L6P8b/VrRXi24U2e9HM10ml0RnbMmCHkogy4cXDT+q8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942198; c=relaxed/simple;
	bh=raoDcVNtzrIvrLDJsiPnjEE+u/CiKjv8xnMHBULvPmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AlwyotJA0oz8oabCO4hmJTk+M6POT4F/dxWV/5OgpW+/MWDN8oehj6+4chp++eu+GebYFXlD9o3dVaQMQAjqWCwMux4gyx5HlnHh2X0dwRpYitj/vhK2AYBo/WwX5cL3BewSULaH9ZyjfY8vOk9+2dzsAM2zlBBRcstHOG9pvXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=LzTUHlrI; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="LzTUHlrI"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731942185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Pq/cAdlDKH+alQicJ/sW3t1bVgLumUnYH1N46P13ZM=;
	b=LzTUHlrIHjpLE+Qcy4sb0Ylb7j4rlDr7mrxvArDT09ujFX673KOHZJolWZb08fPIUuT+aO
	Q3gNNe7XwnVrb3O7CexScLGTs3Lit/sbW5Ch2YEKuGLec9LstODgLa9nIeD88DZvsJTysQ
	GAQCkTMdosohGSlySBC9Ohh7dW9YwFdoKh4ONb5R7cDzR1TQDHiy5fwfGwd0GCCBd9cAu2
	DgtjQff3NdqkaDeuroRj02hJkYpXGuskZwccQEipWm75agGvcnyg7Z0YiFldtXoTyVHv55
	1Nlecx17jBmw9iDT3QqluKI+6kqGunuujnF+wOq+RqsP0+PgumWQXw+sh9uE4A==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 13/17] defconfig: enable CONFIG_XFRM_USER
Date: Mon, 18 Nov 2024 16:02:35 +0100
Message-ID: <20241118150256.135432-14-cgoettsche@seltendoof.de>
In-Reply-To: <20241118150256.135432-1-cgoettsche@seltendoof.de>
References: <20241118150256.135432-1-cgoettsche@seltendoof.de>
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
2.45.2

