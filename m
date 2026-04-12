Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708F82E541F;
	Sun, 12 Apr 2026 11:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775992598; cv=none; b=WLCaQQEC69YsDkKJLTDBq5aSJQ8xLYeXqkKh9Ek6HkD81PIzaQ4QZ4hMDot/ReBQ4lI1Kjkfpfp95Exs+Kpos6Rd7wnrnM9fo0F//EUShKPJ1Mo41x6d3t5caiwwmAPxxUFi/5slH2w72ivyE3eqQyzEyEAW7iAnqAIGQOoVQ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775992598; c=relaxed/simple;
	bh=9UP0ivJiXVoIUA4UAXZ3wNxBHW41WQJJ8XoG15ng/PA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VwBAtzFYpioFg294UYx4ju//V/pgncJjEaB/P+jkciRjPxqpuKkUnlOOzcufQssYPmKqbKcp0I0Dsq1i6+Ce/wETISXIPBeSnrPqnFUrkb7aUBuf2yZoJCr5To+hodGz9KK1Zozr83q4R+R5xmPyXNbUXxDEsyzvCOs6/U8sr1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ZlbNjtYY; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ZlbNjtYY"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id E0A0B207D8;
	Sun, 12 Apr 2026 13:16:35 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q1YEEGcIWrYR; Sun, 12 Apr 2026 13:16:35 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 57F032074F;
	Sun, 12 Apr 2026 13:16:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 57F032074F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1775992595;
	bh=jjCd3da9hgLQSsx/QglDZN06ukOTwGx0csWrPYcumTI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=ZlbNjtYY0wqVcmx6vAPzhQE6HhOc127EmH1ygmwguxtxx5dNeg3v1mxtxqrf6yPb4
	 Dm7364ruNjWvl3fyTr0ajdZW4OYH/MWoRk+DNQbCWI5PGYbwtpV4P+9B/kRaLGHVYE
	 eyRLR0DhdPjrK7gRKKSf7t7JLZlSiKzLRdomUL/2wobbzu362CJx4rlGbproD0sdAP
	 NHsxsHEG7e5lGNYBUrTeBv9k+j8DFsS8fiqVNUzetzSCwvSmbfI73qmfPWbL6TqymX
	 G6a/Sn6drWINxVX5RZV0A5e3tu8kneGfVeIXCfaFebTcszE2DLiHnOFC3j4Qia4dbm
	 buZPaQ1dUooBg==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 12 Apr
 2026 13:16:34 +0200
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
Subject: [PATCH ipsec-next v7 13/14] xfrm: restrict netlink attributes for XFRM_MSG_MIGRATE_STATE
Date: Sun, 12 Apr 2026 13:16:23 +0200
Message-ID: <migrate-state-v7-13-44eb2440b91c@secunet.com>
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
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-02.secunet.de
 (10.32.0.172)

Only accept XFRMA used in this method, reject the rest.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v5->v6: added this patch
---
 net/xfrm/xfrm_user.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 46e506548122..441e6b1fed10 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3721,6 +3721,30 @@ static int xfrm_reject_unused_attr(int type, struct nlattr **attrs,
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

