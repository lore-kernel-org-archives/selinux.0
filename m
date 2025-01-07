Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA281E3DF2
	for <selinux@vger.kernel.org>; Tue,  7 Jan 2025 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257588; cv=none; b=P2uzAC3IPlshgQX2XFrsJRqZ5lLXj7z6RUT+QgFDDjRPe5LePZatL2oUukdKEOjv1abbGzfALxx3amiVLGm9yVzTJhQFm4dmTNLPX+jf3FWIpdy2F0h4P+t0ejtUbZ80HH3gzCrhf7qeqqXSOEkS4VGF+7LxK2HSP9CF/pKzGNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257588; c=relaxed/simple;
	bh=d+cBR0nPqh3j7UzYfMra9jPKIb/0VilWlb6UfxZjCPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YuzFK3J4+pxDE+aWEbJNyYRRiS6xi1AssGgdq62DSwleIIGt2USQ6l2pg3Mq1Jn3DqUdeJcsHYAL8y4TuYzu5ObDN3PLFHgxWShKKkaOSVHLaHa2e00I2ISz5PNSm9OlGselGstaGTjKJTdHFE8ZmVFJMClsAx3RZlfNP09cKwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Yg6oiKAq; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Yg6oiKAq"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1736257576;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bm7Ijh2LR0L2AVVJLndbgQi8cXwLcclyfgfNHc6pUt4=;
	b=Yg6oiKAqDjJhBG6N+ztoBe3XzUh29GdvJolmMPr3/EFfVqkVMJ6XHfVdNUv7qM7LkHh2Z8
	pLrue9JlymJH29Q9vIgHRDwLqwX/qn6RcZU6WW94xTm13wuowq16OAkxfevbqnI73p9JS2
	VkvQzMO2P2MsrRhzeANLGtfa/RwqqkLOGyYhklO9fsAz8JFl8ojiFDYoEPbOlitxL50XeU
	1oaq+KviVaWimhLqB5T1fJNwtJ699IPhUe20spSVEvBfxgJJ2nS0ERXBeH24a3280vxH+m
	vH8YqkJdK5C88G+ZseQYVA5wL8qag005sBL289fUwSZoOPS9Y8TGWGhsMRz4vg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH v2 14/17] defconfig: enable CONFIG_NETFILTER_NETLINK_LOG
Date: Tue,  7 Jan 2025 14:46:02 +0100
Message-ID: <20250107134606.37260-14-cgoettsche@seltendoof.de>
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
2.47.1

