Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18901D5151;
	Sun, 12 Apr 2026 11:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775992532; cv=none; b=LsQoMKwtoNfJjBHbnjtY7Ed+3DA7CwFsieQOrKWAmTVsuNB0MORmYJPZ2gbf3J+mM5qLLHGHPKmCrQnV1vmyv4LE7AbHfd7IfGAH/GsedkxpT3AYRHUOrn26CQDZ3oqyf2F97bkceH5lKyagj3Ol8/km9zYtGaHh/1wd3zROftM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775992532; c=relaxed/simple;
	bh=ayOW9o7Sw9/oJFVdTZeVaFBLk0PidJHtnJqnf/BI/RI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oEd9HQg+ond8G5gSmTOKv3IbbzgwZM6jEy+ktI91OZycTuPdYbUsOsJn7aX6zjwU5535aMRjqLjFmt324T6qAqs1FXBYina0yjDxPGQG/MHXNESZfvU32YV5cc9ZZ+lLBsQsBWa11/02U7DO/Iy3U8SbGa8PNrF5QrrkhLR2kXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=rbs69uWI; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="rbs69uWI"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 584A0207D1;
	Sun, 12 Apr 2026 13:15:29 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G-CYKc72fSiJ; Sun, 12 Apr 2026 13:15:28 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id BBB422076B;
	Sun, 12 Apr 2026 13:15:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com BBB422076B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1775992528;
	bh=wml5vTZCX+fxsPTD5tWOoFg+ZWQuie8VSpcMlMbE8Lc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=rbs69uWISrH4FW8RnJe2HgvbTPP6de59g4AA3smLMjStl8EqEZcnyocqHAt9xCDQu
	 olaoV1GGHWSN3j3ZbEVqbY1wPQQKFfjmbYULPDtqBFJpYZfyWzCQsGlWEVbLR0qWXg
	 y1GJAknUTGkAvzDL1u/jg3hizNxFAqiNqPAix+UlcZ6WfMIcKy8FPyNidtS5sCqEGi
	 71GVn6LaYrg5Z+OSUQUNh/TRMiEoRkCN9+y2x2/ADIkMe6UHhQreZ5FQUKo48J5/dE
	 +7GAZlbmqhcorCu4Ar/JwIgIhzfzk25RQmJkAXYT4x2aa+dRcasf0XSQHGWgwYvCIF
	 j/cK92rbpRGtQ==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 12 Apr
 2026 13:15:26 +0200
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
Subject: [PATCH ipsec-next v7 07/14] xfrm: check family before comparing addresses in migrate
Date: Sun, 12 Apr 2026 13:15:18 +0200
Message-ID: <migrate-state-v7-7-44eb2440b91c@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <migrate-state-v7-0-44eb2440b91c@secunet.com>
References: <migrate-state-v7-0-44eb2440b91c@secunet.com>
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

When migrating between different address families, xfrm_addr_equal()
cannot meaningfully compare addresses, different lengths.
Only call xfrm_addr_equal() when families match, and take
the xfrm_state_insert() path when addresses are equal.

Fixes: 80c9abaabf42 ("[XFRM]: Extension for dynamic update of endpoint address(es)")

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v5->v6: added this patch
---
 net/xfrm/xfrm_state.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 9060a6c399fd..f7bcf1422358 100644
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

