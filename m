Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF13633B97A;
	Mon,  9 Mar 2026 18:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773082061; cv=none; b=VTOZU277q/g5IDNUd5qFd8uAb6ppuV5KZAY4aLSsI7YpRaWjTqjfSdho37RW0I9wPdAbo1qlLZNV8f/Nhb06d8zghbBXz5cIOIzykJeLewmwS0YpcySQh300JRA4+1YPsTrhht9yR/79TMmhGTQl5tNKXkYZSdw3g+z3qu1lUiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773082061; c=relaxed/simple;
	bh=6wGznRVVRs/zDsW4dN7o6Kltr95kGhEjjgHWmf95Whs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=toEdUZQ71srm+uirmG4UEHiMij+zdB+hrtEybL7fetPDvAuKQU/h9us1uTlZ2gR9JgUsdKpSfj6VHx/B45msuLJwdCCIE/dSTLK4qiqTd9XS7nIbzm7eiZez58909WAWO2ppaMKGnluHdtq8MUHYbOec0ODrZ8hyuKiosqJ8kX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=jCjvL28v; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="jCjvL28v"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A1C8020612;
	Mon,  9 Mar 2026 19:47:39 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lpno3O0VisQz; Mon,  9 Mar 2026 19:47:39 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 1DCC820538;
	Mon,  9 Mar 2026 19:47:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 1DCC820538
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1773082059;
	bh=K+38jThCS053amTdkr0H69rFnkgb4l0/CdunhUm2i+8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=jCjvL28vpso6EnNdop6esNR7Refen3kppti8G5PbQZeA/hcv8Baucn7hPcK30LnR/
	 7VqKBhLTrMnMEYyjE6neor0LUFSLi/t8N5g/ASKRIzi5PV/azGSm0pfkMQ3HxGUTf4
	 enTD6lxjIjZ8GQkGzmPf5YUWvhOfpE5Tz1a3ZixPP/N1Olo/aFaAM74w1tKIRY9srw
	 U+l+V0eQimSkkIB1iE9BL98JxQJzUWVNRroSbJfmYVIFXZ1XtLPj9G1yR50OurPPQC
	 lsPrDdUGLzhNiJuxsQp9eNaZQWJ7dSaLPiRezSnmKKWPij+SROseyf4xUm597xYN3z
	 fLYnQdU2CVh7Q==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 19:47:37 +0100
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
Subject: [PATCH ipsec-next v6 13/14] xfrm: restrict netlink attributes for XFRM_MSG_MIGRATE_STATE
Date: Mon, 9 Mar 2026 19:47:26 +0100
Message-ID: <migrate-state-v6-13-9df9764ddb9e@secunet.com>
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
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-02.secunet.de
 (10.32.0.172)

Only accept XFRMA used in this method, reject the rest.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v5->v6 added this patch
---
 net/xfrm/xfrm_user.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index f3b485c800a3483b1515218805b1c2edcdb0c512..386e2d181c999dd5b558428c3f11b51a6a5d886f 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3687,6 +3687,30 @@ static int xfrm_reject_unused_attr(int type, struct nlattr **attrs,
 		}
 	}
 
+	if (type == XFRM_MSG_MIGRATE_STATE) {
+		int i;
+
+		for (i = 0; i <= XFRMA_MAX; i++) {
+			if (!attrs[i])
+				continue;
+
+			switch (i) {
+			case XFRMA_MARK:
+			case XFRMA_ENCAP:
+			case XFRMA_OFFLOAD_DEV:
+			case XFRMA_SET_MARK:
+			case XFRMA_SET_MARK_MASK:
+			case XFRMA_MTIMER_THRESH:
+			case XFRMA_NAT_KEEPALIVE_INTERVAL:
+				break;
+			default:
+				NL_SET_ERR_MSG_ATTR(extack, attrs[i],
+						    "Unsupported attribute in XFRM_MSG_MIGRATE_STATE");
+				return -EINVAL;
+			}
+		}
+	}
+
 	return 0;
 }
 

-- 
2.47.3

