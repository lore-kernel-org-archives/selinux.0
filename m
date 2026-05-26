Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EAE3C09F8;
	Tue, 26 May 2026 19:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779822438; cv=none; b=uLp01jY6UvO26H3BZUde2rxtgS+KukghpFWbMac8D3I7uK3t/kPL8GHf2VFcqJ3Evg9ABCZSo7Cflae4bQQkXD2t3PjR0/wjQc339iNDJBQo3rlgle0E9oOyvLviVEV9BEEVwAdJpF35VHP/rZ2fNkYy93JmwLky4nQ8iLht6KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779822438; c=relaxed/simple;
	bh=HUEDUBANWsQgnxamHTD7XJd76K22xU9jWUHuQ4lx9y4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/kTsJAmZ+qqH1t8uaUuMaZJ/BINCSaIarf4d2nMjSnbxB95GlNM2nS9d9MEg0Td2XoboYzbBrUNpS0O+f7OXUYo/tfltA7UQMwwAUrwumQCTJrF76YGetla8raVO6tS6I60D8zKiBqBF04Pcwv9vICkaxAwM2IOgw+UkcPjosM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=RUrihvmN; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="RUrihvmN"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 166E02069C;
	Tue, 26 May 2026 21:07:16 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y6x3WLIoEtBn; Tue, 26 May 2026 21:07:15 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 7E9C9201A7;
	Tue, 26 May 2026 21:07:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 7E9C9201A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779822435;
	bh=DZycWyVpFQvWlj8RA8QGZetQ/3GzCUn8SZ6sDaM9GPI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=RUrihvmN7N4xuZSA0VTf+cee19spN44c3GJjKvS0Crubu/r7tTUqVKGQu/Bx08xzX
	 IKcXDsE1X5FrCid9f4ZSidheEp9Ft5iAdYyZVmEu4Crr6R7qpoMSi4i86S1fTEV/fH
	 wtA0ekQEPp3x50MEW9gQocnEMzN2TrwQJqEP3QBvZrilvxL0FrBQ5ZKqmk+6PB9Z0x
	 qZtrUBCCxyLD10MiEXlAhgzN+R0oBoVnppHaU8CzCxqplgm4fmYk7cIJ6xhs9tNePR
	 DtDdCNP+YR1Ke9lv1CTQWPESF6i/eNOfsUyTnCcJZ85qnRGYRutg2zEqaK/IbwykLe
	 VcoANkOLGCu3g==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 26 May
 2026 21:07:11 +0200
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
Subject: [PATCH ipsec-next v9 04/16] xfrm: fix NAT-related field inheritance in SA migration
Date: Tue, 26 May 2026 21:07:01 +0200
Message-ID: <migrate-state-v9-4-ad9947e4ae74@secunet.com>
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
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-02.secunet.de
 (10.32.0.172)

During SA migration via xfrm_state_clone_and_setup(),
nat_keepalive_interval was silently dropped and never copied to the new
SA. mapping_maxage was unconditionally copied even when migrating to a
non-encapsulated SA.

Both fields are only meaningful when UDP encapsulation (NAT-T) is in
use. Move mapping_maxage and add nat_keepalive_interval inside the
existing if (encap) block, so both are inherited when migrating with
encapsulation and correctly absent when migrating without it.

Fixes: f531d13bdfe3 ("xfrm: support sending NAT keepalives in ESP in UDP states")
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v5->v6: added this patch
---
 net/xfrm/xfrm_state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 933541bc9093..b9de931d84c1 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2012,6 +2012,8 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 		x->encap = kmemdup(encap, sizeof(*x->encap), GFP_KERNEL);
 		if (!x->encap)
 			goto error;
+		x->mapping_maxage = orig->mapping_maxage;
+		x->nat_keepalive_interval = orig->nat_keepalive_interval;
 	}
 
 	if (orig->security)
@@ -2046,7 +2048,6 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 	x->km.seq = orig->km.seq;
 	x->replay = orig->replay;
 	x->preplay = orig->preplay;
-	x->mapping_maxage = orig->mapping_maxage;
 	x->lastused = orig->lastused;
 	x->new_mapping = 0;
 	x->new_mapping_sport = 0;

-- 
2.47.3

