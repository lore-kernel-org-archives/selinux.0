Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAD31AC43E
	for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942198; cv=none; b=i6sAKzaJZobY6Xm3GRYoRaqAb1yfVfvCS7xGm8ib/LECqd50uSI58STVSg/MNIZDbDFF90QKxwToGqEBUL1AOZk4F1cDP65Yn2XZsF/BZIcFDYelvz2YYwwezSly2IHii9SBvnPWshC+dkH7rAPwLdGM+F6B6i5Nc0iGo7Zht3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942198; c=relaxed/simple;
	bh=lM+ZScOj5Tjj6XXQIUc4ZJ3GnQ51mrZ/8teTHsk4XEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aNe4duSW4NuNzTs+H+1AHvER7aIB9WV6RUK1zFTftqSwGHBTdo3N3+8t7uCyq7vQPcxAWUJnhGB8EavPXPCuFGFdJ2ofwkIZ8FzLv3/lilGvR/UGFO4WRb0XOiQuR8FYBAOIUGtnbwHQq+CvxwkUvJxGhIfEUioJcs1lBvx5ah4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=K9vfuDPJ; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="K9vfuDPJ"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731942185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5owB1v4vLBgaIEwL/4Wm8J7xWvTQcPJA9UH3H0SyVWQ=;
	b=K9vfuDPJaDvbVsCwdBhUfZrqRdLWWhg8Cs+YRvgYvbFqW//UCdcuvbalbURyQBFqz+mDsj
	dzrE4K7NG7ldoLT30Vam5WZdZAOplWCPWvQeMz2pw/HqvyL1PA7jS5rhjRVTaPyjGNxl4Z
	ljPWYVWNZXqpt/HMhK/ow/VjFa7iNKvy03qFQ1I6753+8uGny6ZyOHZY+pvKyMkNhacbE/
	IAKutIofxrlZhh/IZ7OSGGNXhVSdJhUYW+VylOydwujcXzxYd8PIX/PV0YQ8l1QCDquu6L
	33FeD+UmeLbZpiGoAZe6L+CLTN05had/khB1/buywEXfxCqUIQKEsH0AVZibnw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 14/17] defconfig: enable CONFIG_NETFILTER_NETLINK_LOG
Date: Mon, 18 Nov 2024 16:02:36 +0100
Message-ID: <20241118150256.135432-15-cgoettsche@seltendoof.de>
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

Required for netlink_socket tests.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/defconfig b/defconfig
index b86a1dc..d4100c0 100644
--- a/defconfig
+++ b/defconfig
@@ -20,6 +20,9 @@ CONFIG_INET6_AH=m
 CONFIG_CRYPTO_SHA1=m # used for testing, could be updated if desired
 CONFIG_NETWORK_SECMARK=y
 CONFIG_NF_CONNTRACK_SECMARK=y
+CONFIG_NETFILTER=y
+CONFIG_NETFILTER_NETLINK=m
+CONFIG_NETFILTER_NETLINK_LOG=m
 CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
 CONFIG_NETFILTER_XT_TARGET_SECMARK=m
 CONFIG_NETFILTER_XT_MATCH_STATE=m
-- 
2.45.2

