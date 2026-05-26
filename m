Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4AA3B7B70;
	Tue, 26 May 2026 19:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779822425; cv=none; b=jFp899y3lozJMnq9yocGFZGJHTE20i4jgaLInuvGndig1Qd+Cg8lADiAnxwJbG86LyTvbxoalMwxehgZ+d8HqJ55fQXAEmfH4WIJSSAwEgm79d2M10lxBrXWOJ3cnXwOOMfPLSXGzUJujXEbeqss5NtPP5iUvEbTVULY1Bx1xj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779822425; c=relaxed/simple;
	bh=eWRnNkxW/dCUz3e6iTLoXkR5WYW+YRRdKZL33V/gPBM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L52+5gUAFJKwzYqwMdjSIItXb0VuVetHP0G5maddf0eBnpYzR+SBniG8Y/I+4KhdHZGnAWbj7LdDzDLbXD0QWq7vvrQnVImdWmhXbOsCDzQH4DFN0tVWYRtGMexE6vzgwvP2IzCvjXu301AAGFbtsCvPyNGxnm/8T5ZYNzXW7bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=J0UWIOkG; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="J0UWIOkG"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 5171F2069C;
	Tue, 26 May 2026 21:07:01 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XIp98e_KFQQc; Tue, 26 May 2026 21:07:00 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id B87C4201A7;
	Tue, 26 May 2026 21:07:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com B87C4201A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779822420;
	bh=Xo+n9FvX/k1iwIGNwXdWnTZZSxwkt2rFyEh985rJuek=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=J0UWIOkGGSCsLlyUgN8zLgSPbMYTPIMU18HDSn6r0xFkSqRZvmU9y0lzDLywDwA/d
	 9AXqzCoenEchsWBzv65NPW2A/tA1SYIWiXy5fX8+phZyd6Yd05LaK7cNq0vuyl7G5D
	 VTylWzBHA2AL7oPjYQg1tiO+IZ60ndRIRp+vI0ADM794cDLFKqsQyH+yhyEKQOqArX
	 qpqMm5X0TBIDJ6+S0ukCFDpNZfFrDXYXLavTQOuJ//UTxkg0btVhvb+iKOxqnRWGgw
	 uNEp2W6+m/sP7tofalp9V6XgSQQpt7yooar2WiXHKrMKm7TJaGVNsTuv1YjT6wjNR7
	 uwz97PtKCDijQ==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 26 May
 2026 21:06:47 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, Masahide
 NAKAMURA <nakam@linux-ipv6.org>, Paul Moore <paul@paul-moore.com>, Stephen
 Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek
	<omosnace@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Chiachang Wang <chiachangwang@google.com>, Yan
 Yan <evitayan@google.com>, <devel@linux-ipsec.org>
Subject: [PATCH ipsec-next v9 03/16] xfrm: allow migration from UDP encapsulated to non-encapsulated ESP
Date: Tue, 26 May 2026 21:06:33 +0200
Message-ID: <migrate-state-v9-3-ad9947e4ae74@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <migrate-state-v9-0-ad9947e4ae74@secunet.com>
References: <migrate-state-v9-0-ad9947e4ae74@secunet.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-02.secunet.de
 (10.32.0.172)

The current code prevents migrating an SA from UDP encapsulation to
plain ESP. This is needed when moving from a NATed path to a non-NATed
one, for example when switching from IPv4+NAT to IPv6.

Only copy the existing encapsulation during migration if the encap
attribute is explicitly provided.

Note: PF_KEY's SADB_X_MIGRATE always passes encap=NULL and never
supported encapsulation in migration. PF_KEY is deprecated and was
in feature freeze when UDP encapsulation was added to xfrm.

Tested-by: Yan Yan <evitayan@google.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
 net/xfrm/xfrm_state.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 53d88b87bdbd..933541bc9093 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2008,14 +2008,8 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 	}
 	x->props.calgo = orig->props.calgo;
 
-	if (encap || orig->encap) {
-		if (encap)
-			x->encap = kmemdup(encap, sizeof(*x->encap),
-					GFP_KERNEL);
-		else
-			x->encap = kmemdup(orig->encap, sizeof(*x->encap),
-					GFP_KERNEL);
-
+	if (encap) {
+		x->encap = kmemdup(encap, sizeof(*x->encap), GFP_KERNEL);
 		if (!x->encap)
 			goto error;
 	}

-- 
2.47.3

