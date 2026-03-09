Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC25346E7A;
	Mon,  9 Mar 2026 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773082043; cv=none; b=seRGFG171F3ZY5WH1ECvN1dvgNr5aTbcopJO5oEbiKNGEEtfp9jZPEK3N865c+xinNNRxkDPLjSe2wnXj4gCMWYYKL2+otg4v8DAaIL7/XpfMKH8+M9aWQMxkwaHEXsZPjjsSLNK99jYZ80ZVEAOHcfN5POjaHmdYA9EmwKeaXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773082043; c=relaxed/simple;
	bh=4+Lk+mygRDA72A4gn/bx59jnlxL+RPpS94rQUDAzO5k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h5YyBWZUdKX5zMAI/rE51hwzmOVrwnYhXshTHsarSHJf9f+LyyiJ0+TsrDVBNHvLlvxD4eESwii0sxpZoFbISs7HGWKq6ghBf/fx3qqKcEbC0r22AX0adLG8kE92uITsUMfgfP8HxMbRnXLMbR1LTrYocB7qv854TZ3mgbyR8ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=TIXHG1fa; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="TIXHG1fa"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id C0DA5206DF;
	Mon,  9 Mar 2026 19:47:20 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NWItt_d1zmUo; Mon,  9 Mar 2026 19:47:20 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 31D8620538;
	Mon,  9 Mar 2026 19:47:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 31D8620538
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1773082040;
	bh=Ky4kq9TSVWbQRc9ZaidUv0ASid7GRt89U8Qd+Sl2O94=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=TIXHG1fapsAWq8bCVYoR7nuDZDC3Dlvb4VPstoxuq266ksrP0VDeiaRmQffMymkR5
	 vgBBGQh2R4+GFQd1xJIAOHccFfZIOYVAX50bCqgB3/Kfy+alBXpI7bDfTxh/h2vxpY
	 oCqDlsBvA9496Ah3kga3zBHNdQ1LzamNZcFcZgo4L91gHi2X9uUhj6W4Z/LIfiTmlf
	 U+ljjj8W7tXOEoqS2Gp4X9JVUg8GxUDwHmQA30FSPfwIVwZ+bEIif3lRKR5ApmkWzn
	 OM7XDaiHrP6M63n8bKsTDoacBG6nQzRujTngV0vbPov6PVvoP2w/F0+WIrmJ6WKMzj
	 7ZVRjCngm5c3A==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 19:47:19 +0100
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
Subject: [PATCH ipsec-next v6 11/14] xfrm: refactor XFRMA_MTIMER_THRESH validation into a helper
Date: Mon, 9 Mar 2026 19:47:08 +0100
Message-ID: <migrate-state-v6-11-9df9764ddb9e@secunet.com>
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
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-02.secunet.de
 (10.32.0.172)

Extract verify_mtimer_thresh() to consolidate the XFRMA_MTIMER_THRESH
validation logic shared between the add_sa and upcoming patch.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
-
v5->v6: added this patch
---
 net/xfrm/xfrm_user.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 26b82d94acc1519fca1e4ef85b0f2a814e6f5d8c..fe0cf824f072b09e3267dc5b8aab9b5b0d68c968 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -239,6 +239,22 @@ static inline int verify_replay(struct xfrm_usersa_info *p,
 	return 0;
 }
 
+static int verify_mtimer_thresh(bool has_encap, u8 dir,
+				struct netlink_ext_ack *extack)
+{
+	if (!has_encap) {
+		NL_SET_ERR_MSG(extack,
+			       "MTIMER_THRESH requires encapsulation");
+		return -EINVAL;
+	}
+	if (dir == XFRM_SA_DIR_OUT) {
+		NL_SET_ERR_MSG(extack,
+			       "MTIMER_THRESH should not be set on output SA");
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int verify_newsa_info(struct xfrm_usersa_info *p,
 			     struct nlattr **attrs,
 			     struct netlink_ext_ack *extack)
@@ -446,18 +462,9 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 	err = 0;
 
 	if (attrs[XFRMA_MTIMER_THRESH]) {
-		if (!attrs[XFRMA_ENCAP]) {
-			NL_SET_ERR_MSG(extack, "MTIMER_THRESH attribute can only be set on ENCAP states");
-			err = -EINVAL;
-			goto out;
-		}
-
-		if (sa_dir == XFRM_SA_DIR_OUT) {
-			NL_SET_ERR_MSG(extack,
-				       "MTIMER_THRESH attribute should not be set on output SA");
-			err = -EINVAL;
+		err = verify_mtimer_thresh(!!attrs[XFRMA_ENCAP], sa_dir, extack);
+		if (err)
 			goto out;
-		}
 	}
 
 	if (sa_dir == XFRM_SA_DIR_OUT) {

-- 
2.47.3

