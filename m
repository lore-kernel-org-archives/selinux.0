Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A947386440;
	Tue,  5 May 2026 04:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777955580; cv=none; b=Diton7Bm+vg9OJpzy9AXXztBZCg6giKoYvn/pfskBQKXKHTMzsqE9+Wrc/7f5Sg6faG5/2sOic8L07UEyVsUDqBl/uaj72G4PBHMeCrhS9UTlBakHMlgcjCscvq/ICiw8C5syF5wy4jKuvzf1/lz99ch28MZds+hk6L3PLCTW+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777955580; c=relaxed/simple;
	bh=HyDMnLJW2aZ5ZbZEAqFAWkOXF7vivG+s6uuvXwtkhYA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uf8V10nNksoHVitsb5gLMMjrGPZuxRssx0JfragNg3XYYXTJWeiYwH3+2UCSbyw9FLD2HfMeSuAdDkIAXJ945s4EV6zqXQ5E0xLfMIL2gkODY3cgRspub+a7+AxAVOPJ+CsfzCckQ2EPiJpcvxnHMbNcn4D3tR9XwDaDzVA7srw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=flJTHxuZ; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="flJTHxuZ"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 43A15201E4;
	Tue,  5 May 2026 06:32:58 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MbTQ-_t8irt9; Tue,  5 May 2026 06:32:57 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id ADD53201AE;
	Tue,  5 May 2026 06:32:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com ADD53201AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1777955577;
	bh=mqxIfO+ITJwRyS4L4XcGdoeP6l/sa/6MoJ9GkmgCZzM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=flJTHxuZGbmmuM5qkaDiDcurse/ZpEWKfUCmpPkMK3+S2eURxj9wQgsIohqzyxQv4
	 9QCeP2iukOFMDmfYb59Krk8oOPSTi5H8Zs89wVhSKs46DHA0msxTKJ52/l3erxIJsP
	 F79RB7iKmZ9+HZPK8vKVLIPU6DMxlaKqeSH60uz4pMQ0UrN8N24bdi4G7cW54xbKwI
	 GcY/VnS3xL53glJY89JfX5hLF067zbg3wbfnxmV72g2LeHZiVDJSfhCQFeZkXJ3gER
	 gX3xPokmsdWSL6eKk14sUbE+ZDjRh6YdghWN44KT7qJaeGnDDuEM4f+pKUf89JiudC
	 NigJWSITtl2/g==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 06:32:54 +0200
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
Subject: [PATCH ipsec-next v8 04/14] xfrm: fix NAT-related field inheritance in SA migration
Date: Tue, 5 May 2026 06:32:43 +0200
Message-ID: <migrate-state-v8-4-4578fb016965@secunet.com>
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

