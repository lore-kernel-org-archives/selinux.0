Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473FD1CEAC9;
	Fri, 15 Nov 2024 13:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677821; cv=none; b=aQPTl/zg9vgDdQPnoxXdD3WTyq6tEB6b579kAgcgGPURvuVfeHdSQ2uY7L/OKp9gtH3vg2Xl29w2ZPMMIwdabRvJeySRpkrU1OiKivrkam7AWGVFPQZHxbtFXbysbpDiEItnSCMAlUCiqO4I+lvRB/MSTgp0vlXkdG9pbaVonys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677821; c=relaxed/simple;
	bh=9n70bJPP3MOgRC7WkuNIfl9C1H4ut3X58hIJ0yBJnKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a+UO77M25RYMgl7pH16E/sTuR/JQMIt2lACA33YonEIOD/fo+05DLg3dhAejI7pL4zqxRNDGwhTBv0strVVAlygMLBpkhcDD+MfjMS7CKoHnTKvt4iEStjEac16EkSWoH19gtFE5NHgRhnWk0IWC6g0FGEyM6JCeMbJtYtq1UOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=ltN0Fd6C; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="ltN0Fd6C"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731677811;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ULwXJo7buuhUKIsoYp98ePbuFeAXn2366OdVFKSgj6c=;
	b=ltN0Fd6Cc5ss7iKMIBZ8g6MnROCH7aOci8/hthDlzVs7cDV0G5EoFGiRxGqp6wptwVyOLm
	XsIjXqC0MlaudtUwjElUqX8BNb/MOG+yB3GlxEISaHLk1rkqodEIIedM3PC8rPxveATIWq
	2Fga1PzZIwHsNzCVsCxdftkyIbXN12AtJmKinVT2aLmOFmEkfdXSa4SjDxfEp3J7g41BzD
	mG6z1aEypnQ0FYhvHNWY6uH+NlReYmAdj9pLFMfb2jRWHP68MdMMt4Sh0G+EUv3v2cLlKZ
	NYV5GDQ1W6r56niEAYVmp0ov0XdT55Tmtg22IxjttQoH6ntGBkeh321TWj2tbQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	GUO Zihua <guozihua@huawei.com>,
	Canfeng Guo <guocanfeng@uniontech.com>,
	=?UTF-8?q?Thi=C3=A9baud=20Weksteen?= <tweek@google.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 04/22] selinux: rework match_ipv6_addrmask()
Date: Fri, 15 Nov 2024 14:35:23 +0100
Message-ID: <20241115133619.114393-4-cgoettsche@seltendoof.de>
In-Reply-To: <20241115133619.114393-1-cgoettsche@seltendoof.de>
References: <20241115133619.114393-1-cgoettsche@seltendoof.de>
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

Constify parameters, add size hints, and simplify control flow.

According to godbolt the same assembly is generated.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/ss/services.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index b7ef8ab06185..261a512528d5 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2593,17 +2593,15 @@ int security_netif_sid(char *name, u32 *if_sid)
 	return rc;
 }
 
-static int match_ipv6_addrmask(u32 *input, u32 *addr, u32 *mask)
+static bool match_ipv6_addrmask(const u32 input[4], const u32 addr[4], const u32 mask[4])
 {
-	int i, fail = 0;
+	int i;
 
 	for (i = 0; i < 4; i++)
-		if (addr[i] != (input[i] & mask[i])) {
-			fail = 1;
-			break;
-		}
+		if (addr[i] != (input[i] & mask[i]))
+			return false;
 
-	return !fail;
+	return true;
 }
 
 /**
-- 
2.45.2

