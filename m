Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FE93BFAE2;
	Tue, 26 May 2026 19:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779822370; cv=none; b=FLRwd1LP1ymFv6EiBiC7nc6xu/8qTD0aq/qNGFOK/FiOJuk0dty5eEy5du/jpb0fiCElEznVpt592JCX8NbxUuMNXD394OlKESBT2FkuNXBq8aaHrmQeOQJSjGuInWxGn/h3/sMDHF9xzqHeLTO7DoyVRt/FU4k2xowD93YzOH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779822370; c=relaxed/simple;
	bh=QF7U8fXeHmgiScXMxbtKzxy43UBWjd28mwPF1vniEZY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JgyQKedKchrGtZnsvq1JGtMBHD0TmIdm226BwnyduoF48KBSajxJt4suKJqQ5Q9hiQ+EqIRMmK0dRO4/mzP7BT2ZPQIH/f44Ym3Rjnv+XUwFiQxLCoOr2kNv7kjUJSE2cwQBrgjfcwiMH/VnBZ17EGKCBGyTTR7y47CfNsdiZaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=DPo7ABGI; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="DPo7ABGI"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 681282069C;
	Tue, 26 May 2026 21:06:07 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8jcEFS79Ice4; Tue, 26 May 2026 21:06:06 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id CA946201A7;
	Tue, 26 May 2026 21:06:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com CA946201A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779822366;
	bh=/ZUxSZ9FiVoeisVVxOqMvDayIVH4bsjQQ5nyAqmfoOA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=DPo7ABGIu8bdvSM0azHCqyemv+rPGIBGXe8uSNpAdzZS4QPkHg0M5A0Z2b4gZEhxk
	 iTft+Ya517m90MWknTEuQCeXBSS2wfU6/2LSt/j1ykvhBg2vyJoTxpWXPA6ZLQHU1v
	 A0BpCsiq2cuZO7HSk8VwfxiK2MOwDcOgZI+d+9UPhxNE2AXEEypYkD1VLQnJeORwn5
	 Gzm0mLdzDWMheWFrL+uWfKkQGmMvPgcx/pWAc/vls09cPgutHal3l9VwrIK+peQ/YZ
	 VN5F04ZAA2NsbXxZ+ArrmGO94dTzcvcXlAX3AcahHkIANdjN/MrRuXbfdFYcF4sr5H
	 d6JXM2qrBP0GA==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 26 May
 2026 21:06:03 +0200
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
Subject: [PATCH ipsec-next v9 01/16] xfrm: remove redundant assignments
Date: Tue, 26 May 2026 21:05:54 +0200
Message-ID: <migrate-state-v9-1-ad9947e4ae74@secunet.com>
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

These assignments are overwritten within the same function further down

commit e8961c50ee9cc ("xfrm: Refactor migration setup
during the cloning process")
x->props.family = m->new_family;

Which actually moved it in the
commit e03c3bba351f9 ("xfrm: Fix xfrm migrate issues when address family changes")

And the initial
commit 80c9abaabf428 ("[XFRM]: Extension for dynamic update of endpoint address(es)")

added x->props.saddr = orig->props.saddr; and
memcpy(&xc->props.saddr, &m->new_saddr, sizeof(xc->props.saddr));

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v1->v2: remove extra saddr copy, previous line
---
 net/xfrm/xfrm_state.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 1748d374abca..9417a025270c 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1980,8 +1980,6 @@ static struct xfrm_state *xfrm_state_clone_and_setup(struct xfrm_state *orig,
 	x->props.mode = orig->props.mode;
 	x->props.replay_window = orig->props.replay_window;
 	x->props.reqid = orig->props.reqid;
-	x->props.family = orig->props.family;
-	x->props.saddr = orig->props.saddr;
 
 	if (orig->aalg) {
 		x->aalg = xfrm_algo_auth_clone(orig->aalg);

-- 
2.47.3

