Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986253ECBEA;
	Mon,  9 Mar 2026 18:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773082001; cv=none; b=qwkSGQjcVMeAKK9IiFbctBvF5yU5o3kGHBuvemY+YLxmdYWR5s+PLtfxV0EfdH3zQ86l6Z72pC/Y/G2dRSTiqq/LAlNYmOLF3jJB8rZqbPE+OOeZp+b0u4G15txFjLPnTiFxeobwU3LkQKKTKHBQUGAKCazkR2NXmRKxmbxewX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773082001; c=relaxed/simple;
	bh=OFlgK5h6EY7YpAeMwGoHGU8sE6eKOW9v5LY+ZhPhVm4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K14BzMDiHGh/R4uFdYvpzf8U6mvTyTK2I2RBVErzXv3SvIo7CbutpBFYzrt1sNXb81mUtwRED3P0BsllIjt9w822jaZbq3BMjviai1iig9ufgRULdihKSMhXr6VUSy1Q1+GfitrOU/itrJMFGge63vVhXzLhc0ptiaeQnoMVu5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=OfSSOooq; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="OfSSOooq"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 56C7F206DF;
	Mon,  9 Mar 2026 19:46:39 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hoF6sJ4LXXX9; Mon,  9 Mar 2026 19:46:38 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id C8C9020538;
	Mon,  9 Mar 2026 19:46:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com C8C9020538
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1773081998;
	bh=b2nBL3YrkxA+dAd0+fj8gYfBhXd63z+fnqjBtqe/7No=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=OfSSOooqVk1J4Khloi8P96YwGfdSizPlYvRXxkdDnIjrw+TiZNoWK2/PIYu3TVSLA
	 E21Hx/eIUFb30zUpZBe8xi2xM2kcoy59vd2xeAWjf/HGzKEN+7zVqWnYuBxr0oj+uk
	 MpHshX8IRJ5JUON+Q02bek0Z3+ryXqLSYiGmQufb1EGXaDqxHoy6UR9c33oZQokM9t
	 g4IRWzjezxAcjx437smhzphM0G0DitRl5kC9JtX3IJGVhdMHSUnEjlmWKQoV97dDuo
	 DY0m42YIMWr+qQxgvzyVuRpgBlAhs64pMz9t599+2vD+HB6LlG5MMyuGodburRBoeu
	 vA14l/gHgpx5g==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 19:46:37 +0100
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
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<selinux@vger.kernel.org>, <linux-doc@vger.kernel.org>, Chiachang Wang
	<chiachangwang@google.com>, Yan Yan <evitayan@google.com>,
	<devel@linux-ipsec.org>
Subject: [PATCH ipsec-next v6 07/14] xfrm: check family before comparing addresses in migrate
Date: Mon, 9 Mar 2026 19:46:27 +0100
Message-ID: <migrate-state-v6-7-9df9764ddb9e@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <migrate-state-v6-0-9df9764ddb9e@secunet.com>
References: <migrate-state-v6-0-9df9764ddb9e@secunet.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-02.secunet.de
 (10.32.0.172)

When migrating between different address families, xfrm_addr_equal()
cannot meaningfully compare addresses, different lengths.
Only call xfrm_addr_equal() when families match, and take
the xfrm_state_insert() path when addresses are equal.

Fixes: 80c9abaabf42 ("[XFRM]: Extension for dynamic update of endpoint address(es)")

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v5->v6 added this patch
---
 net/xfrm/xfrm_state.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 9060a6c399fd2befc09751f106e0f138990c9a2a..f7bcf14223584bd7d779a2521a9d5b0bf7946640 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2159,10 +2159,11 @@ int xfrm_state_migrate_install(const struct xfrm_state *x,
 			       struct xfrm_user_offload *xuo,
 			       struct netlink_ext_ack *extack)
 {
-	if (xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family)) {
+	if (m->new_family == m->old_family &&
+	    xfrm_addr_equal(&x->id.daddr, &m->new_daddr, m->new_family)) {
 		/*
-		 * Care is needed when the destination address
-		 * of the state is to be updated as it is a part of triplet.
+		 * Care is needed when the destination address of the state is
+		 * to be updated as it is a part of triplet.
 		 */
 		xfrm_state_insert(xc);
 	} else {

-- 
2.47.3

