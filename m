Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C733C13F1;
	Tue, 26 May 2026 19:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779822621; cv=none; b=NyZRf6T/EecAJR/o8/rIyt8fXNP+JtgJ4c8xUP90jAiSbPUw7ZsQ5NJevOAxjqIJo5XDVOtVRtuA28VSaZVT40FNppTg/uZ0xoPB8zzdj02R9okQ2tVCSR7z/OylyORPaAoIKrFxc30CPN+O3Xo5scVpy0gxynDHmjOq3EysPqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779822621; c=relaxed/simple;
	bh=yzvLdJtP8ixTNLvybz517SR/mIvOgy8t7XebX0qaXaU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iaxt8SatbOH2btZhg2Rx6bXVnO8tiP3H8n9NuwgRHb5Yp9r06Q7QLJUCMRX+0VfbVpmYWnufIjGr+ZHWcXjXkfyasAn9nON0NL88cevpIGZlNQRYF2pGknVxWKZia7nFKWN2/ZyixYtNBMSRkJjL2DliM7CSTclsE1xFXYcVQ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=wt6RDiJb; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="wt6RDiJb"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 6BE74201E4;
	Tue, 26 May 2026 21:10:18 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jp43p2vE8T8E; Tue, 26 May 2026 21:10:18 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id DEB1F201A7;
	Tue, 26 May 2026 21:10:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com DEB1F201A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779822617;
	bh=qV0MpFkkHKluOJAZdMiT+Ag4Qvl53queWFFmEr8y/is=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=wt6RDiJbE5NuqYhpwjT0EaxILZ3Tx2fgI/LTG1kCkDcEsBC5U9xaEr93dOf5I5ZsH
	 RA+dRJ52hhIKM9M0J6vCuAneiJ04qS2tixw13qpUlHZwHcetXz4vFyAMTKTCDLZQ53
	 kypGR0szcALUBnB93FUQjJlEYA1ixhwcvUI7sBSDvjwaXTDPxi+yIJnfeeuNYpXHgu
	 eraMyoTOGin/GgG+Tah8JHs3Iw8H77PONeRnSziMDYKT0L52PRf1NvEQmkSmmP7O3U
	 IUfhaQopR01On/UOqhT+BesDk0hY8I0a77uNusfUNRCQ+GdlXR+YgkSJfEtAmrFVvF
	 dsY3EWmmYV6wA==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 26 May
 2026 21:10:13 +0200
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
Subject: [PATCH ipsec-next v9 15/16] xfrm: restrict netlink attributes for XFRM_MSG_MIGRATE_STATE
Date: Tue, 26 May 2026 21:10:03 +0200
Message-ID: <migrate-state-v9-15-ad9947e4ae74@secunet.com>
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

Only accept XFRMA used in this method, reject the rest.

Signed-off-by: Antony Antony <antony.antony@secunet.com>

---
v5->v6: added this patch
---
 net/xfrm/xfrm_user.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index fca7b02e0e02..caddd23936dc 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3782,6 +3782,30 @@ static int xfrm_reject_unused_attr(int type, struct nlattr **attrs,
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

