Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C59346E46;
	Tue,  5 May 2026 04:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777955700; cv=none; b=HEmRR8CXZ5MsCjpG1xtUuPfbnD1WsPIhpcytgpKueLilOKCUGTecGy/FHBNiYxbueJE7PIkVfuP+8C3XqroPwz7cQWyPdiXDkHbG0oW7bsLWk4Ipx/KLWw79KM6ohX9iu6MQYSndoGyrwAGYOMNk5Qa4+/dYWGGZElRPukWaRNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777955700; c=relaxed/simple;
	bh=96mtuYIFRTeZX9HF3rTuCTVsf72VznZCp7FaTUFzSVU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pS0BG3p2pEP+23heYqeeGq4/AuDB0sTOu9D9erIdf7dElBeeTgnH/ThzLu5RBkq1EkiH3GC49k9tkkije3BBICmcumBxovealYWCx7phJdgPGaseD/13AV3AVqb3JU01/Absz01SuucqlgzdLMPjKzIgzy/0zmw0GpBNDva0cOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=e/WyhNPJ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="e/WyhNPJ"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id C64E2206E9;
	Tue,  5 May 2026 06:34:57 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mzqxlekOVGTq; Tue,  5 May 2026 06:34:57 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 438B420049;
	Tue,  5 May 2026 06:34:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 438B420049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1777955697;
	bh=g94DFxxa+IyEIpYIttt1VwXxX6GZXpH/cnNFqSxf65w=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=e/WyhNPJ0f4Eouv/XZeXXALsf1/fmChB5T1N3GQVU4qnim7mYYP5MRyJRqWXXqYTs
	 MEohULpjnh6qdVKjJ+Iu2zV2hAkXFnqY11Ucx+WiNIVH7tBg7UvoobR/j1oX7lwPpA
	 M7f6NRe2UNrs8UHIBYqwkLc/FTiGquZxT3snQngQ1Roh/ceFaC6P1Esq8Zd5voHpqX
	 kxRlJFkHh///mCVcjIZ2Sx2qzmohI63E3BkL6snMqEkU89qGkcdSoVtvc9oAiBJnXH
	 tzC3RDj88tOTlUvdpn0qWbZfWS7fhtAdt/d/nvlUJXAfMuC1l/LhnrhamnMc5N/9Ea
	 d2VFosHoAPx6A==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 06:34:54 +0200
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
Subject: [PATCH ipsec-next v8 13/14] xfrm: restrict netlink attributes for XFRM_MSG_MIGRATE_STATE
Date: Tue, 5 May 2026 06:34:42 +0200
Message-ID: <migrate-state-v8-13-4578fb016965@secunet.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <migrate-state-v8-0-4578fb016965@secunet.com>
References: <migrate-state-v8-0-4578fb016965@secunet.com>
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
index a49edf7d6f78..c435b38f25bd 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3732,6 +3732,30 @@ static int xfrm_reject_unused_attr(int type, struct nlattr **attrs,
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

