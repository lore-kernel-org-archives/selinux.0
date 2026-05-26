Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E142868A7;
	Tue, 26 May 2026 19:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779822595; cv=none; b=RlgpjsWFtioDdHiWfKCk1VSFh4StjQKahzCsyitQVUQiueT650OzqD6uK9TN2p9AiqRibQ0nU6l5DKzVaGf9oVHPkVPl5aFuv1k1yuyJdD9bzghmCNvbgjETUEVC0J3CcQl3kBDFAVt9eFGOxjKonOOCPSuR6A6124SDkDf5Ka8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779822595; c=relaxed/simple;
	bh=SouvUScu2PCbbpV9Hns0wg8JBsGgSXV8hSDzyx9TX2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ha+Q+3dD7bdgoJiMKBLPFnVTKr9HyWtbp+LEGlriOumD4xBmEPujjm0I6Ah6NcLllY01MUN1Epm2fARiKPxpKCGBe1aJWKoANOEbuE0M0Tbjy+NMzSVoPiNAqgcmnr1EjXHOre20Uk33x4ziOHHETlsKF4ZfOtzEXQNBbSVErHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=NzCkMfF7; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="NzCkMfF7"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 8A802201E4;
	Tue, 26 May 2026 21:09:52 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ug9bajcQjoPx; Tue, 26 May 2026 21:09:52 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 02F34201A7;
	Tue, 26 May 2026 21:09:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 02F34201A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779822592;
	bh=MpdTDbyzRfDw9Bco0ldUvXvBd41GjVNe/9C4O6DG+Nc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=NzCkMfF7YkuMiIHzWAQPcGpmq6idG4n8Osmaz1br5CbotHNFPmIncG4vsK40+6Mbs
	 6z46G48wFoZTo9m9Lw2J1ysFvSn0FMST3nSfhWWaSJJBZNNnflazj6zbPx+qm1qxWG
	 jY2Xbdvnxycg5lZv636xx2qbwy1JHuNAtDHyhI804+RGYZTRtSS3Q1jzGgcOBvHeLJ
	 msetf1a8kL1SpYGAHZ4ad53w7HR5iqCEXNUsyrgy98/4V//t2h8OVYlg322RzPEN2s
	 kwVh0uH3AFGg+CSZ+rqrg6d4SEOA1yPTDsBtVYsgBGFOeVBqoWptIQqEujrwZUABk/
	 8yZFLzPNnbVmw==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 26 May
 2026 21:09:46 +0200
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
Subject: [PATCH ipsec-next v9 13/16] xfrm: make xfrm_dev_state_add xuo parameter const
Date: Tue, 26 May 2026 21:09:35 +0200
Message-ID: <migrate-state-v9-13-ad9947e4ae74@secunet.com>
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

The xuo pointer is not modified by xfrm_dev_state_add(); make it const.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v8->v9 : added this patch
---
 include/net/xfrm.h     | 6 ++++--
 net/xfrm/xfrm_device.c | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 4b29ab92c2a7..5515c7b10020 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -2104,7 +2104,7 @@ void xfrm_dev_resume(struct sk_buff *skb);
 void xfrm_dev_backlog(struct softnet_data *sd);
 struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t features, bool *again);
 int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
-		       struct xfrm_user_offload *xuo,
+		       const struct xfrm_user_offload *xuo,
 		       struct netlink_ext_ack *extack);
 int xfrm_dev_policy_add(struct net *net, struct xfrm_policy *xp,
 			struct xfrm_user_offload *xuo, u8 dir,
@@ -2175,7 +2175,9 @@ static inline struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_fea
 	return skb;
 }
 
-static inline int xfrm_dev_state_add(struct net *net, struct xfrm_state *x, struct xfrm_user_offload *xuo, struct netlink_ext_ack *extack)
+static inline int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
+				     const struct xfrm_user_offload *xuo,
+				     struct netlink_ext_ack *extack)
 {
 	return 0;
 }
diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 550457e4c4f0..630f3dd31cc5 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -229,7 +229,7 @@ struct sk_buff *validate_xmit_xfrm(struct sk_buff *skb, netdev_features_t featur
 EXPORT_SYMBOL_GPL(validate_xmit_xfrm);
 
 int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
-		       struct xfrm_user_offload *xuo,
+		       const struct xfrm_user_offload *xuo,
 		       struct netlink_ext_ack *extack)
 {
 	int err;

-- 
2.47.3

