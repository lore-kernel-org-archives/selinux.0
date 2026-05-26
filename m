Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1673C3C0A02;
	Tue, 26 May 2026 19:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779822578; cv=none; b=WNxjlhc+z5ZFGCwykv0Gu4qBvIUdANSQWS3/gitbSw3+Q0AgYXwtKlDhAeNrmkWCK2J2K//n1jj3op4prt6JfeeiJUxsWtyCpwIhkYfGPn3Y6rhoRtFNeknK8QArsCNNskbNA5nRuwn0h87GhdT8/dEHkUvjDLmN4K1fu8dYOf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779822578; c=relaxed/simple;
	bh=Vd++UfMYvfaF6t5n1K1xAA3H7hqr8weRMZwjufIPc/o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t1JBmiheUFz79N6D3gTfofdBue6xDDrdrtIadt7UyDu0ts71dD+JuGtVBKSxxXJYBMAc2k9TmYr20SQoDncsVZdw5sL1qMG2x8TaEZ+rOkgPk9echzpvNSPRP0IXDmIpn7959v5cyAGw8cOiaXfUMdHJXj4WemUnukTCRy4rZZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=vRmAqqkG; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="vRmAqqkG"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id E2A2B201E4;
	Tue, 26 May 2026 21:09:35 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g4rNe8x33Rvj; Tue, 26 May 2026 21:09:35 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 41E02201A7;
	Tue, 26 May 2026 21:09:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 41E02201A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779822575;
	bh=7DPq9/2B4vF3MKSp537Hr2VkAQP5UgbFFSDcpUOeuA4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=vRmAqqkGPhT1N1KtLT7quo+XEkfZ6SKrPFE/YG6Nq3KWWet+STT5VOtntGvYmcLwd
	 iFujROPs4eMNKba9UGJeaaBBXKWSha+7Ge8b5eewDxNQ6lEufKvC2Ap2UZV97qV61c
	 Vbs16sTkOre0VP88BUTQUHpnqiRY0XlmpJREHkEQ+1vR/2m+LvCN4hS+Vnr82shRjM
	 XDWm6X0R+FrAujBw0+gBN7OWYtlb3W7AErJBPeVXKnh2cJV6V3Dpn6yMEpISIZkHlf
	 Rlkq41oKQ/QkfZaN7aRIWPrgsaX62iuvlsBqXQ4oz1DDv29TDy6KNR4sQwG0rfM0n7
	 TSiv73/sccTaQ==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 26 May
 2026 21:09:23 +0200
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
Subject: [PATCH ipsec-next v9 12/16] xfrm: extract address family and selector validation helpers
Date: Tue, 26 May 2026 21:09:10 +0200
Message-ID: <migrate-state-v9-12-ad9947e4ae74@secunet.com>
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

Extract verify_xfrm_family() and verify_selector_prefixlen() from
verify_newsa_info() to allow reuse by other netlink handlers.

verify_xfrm_family() validates that a given address family is AF_INET
or AF_INET6 (with CONFIG_IPV6 guard).

verify_selector_prefixlen() validates that the selector prefix lengths
are within the bounds for the given address family.

No functional change.

Signed-off-by: Antony Antony <antony.antony@secunet.com>

---
v8->v9: added this patch
---
 net/xfrm/xfrm_user.c | 80 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 44 insertions(+), 36 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 03fa4cabf601..c7ae670212a9 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -264,66 +264,74 @@ static int verify_mtimer_thresh(bool has_encap, u8 dir,
 	return 0;
 }
 
-static int verify_newsa_info(struct xfrm_usersa_info *p,
-			     struct nlattr **attrs,
-			     struct netlink_ext_ack *extack)
+static int verify_xfrm_family(u16 family, struct netlink_ext_ack *extack)
 {
-	int err;
-	u8 sa_dir = nla_get_u8_default(attrs[XFRMA_SA_DIR], 0);
-	u16 family = p->sel.family;
-
-	err = -EINVAL;
-	switch (p->family) {
+	switch (family) {
 	case AF_INET:
-		break;
-
+		return 0;
 	case AF_INET6:
 #if IS_ENABLED(CONFIG_IPV6)
-		break;
+		return 0;
 #else
-		err = -EAFNOSUPPORT;
 		NL_SET_ERR_MSG(extack, "IPv6 support disabled");
-		goto out;
+		return -EAFNOSUPPORT;
 #endif
-
 	default:
 		NL_SET_ERR_MSG(extack, "Invalid address family");
-		goto out;
+		return -EINVAL;
 	}
+}
 
-	if (!family && !(p->flags & XFRM_STATE_AF_UNSPEC))
-		family = p->family;
-
+static int verify_selector_prefixlen(u16 family,
+				     const struct xfrm_selector *sel,
+				     struct netlink_ext_ack *extack)
+{
 	switch (family) {
 	case AF_UNSPEC:
-		break;
-
+		return 0;
 	case AF_INET:
-		if (p->sel.prefixlen_d > 32 || p->sel.prefixlen_s > 32) {
-			NL_SET_ERR_MSG(extack, "Invalid prefix length in selector (must be <= 32 for IPv4)");
-			goto out;
+		if (sel->prefixlen_d > 32 || sel->prefixlen_s > 32) {
+			NL_SET_ERR_MSG(extack,
+				       "Invalid prefix length in selector (must be <= 32 for IPv4)");
+			return -EINVAL;
 		}
-
-		break;
-
+		return 0;
 	case AF_INET6:
 #if IS_ENABLED(CONFIG_IPV6)
-		if (p->sel.prefixlen_d > 128 || p->sel.prefixlen_s > 128) {
-			NL_SET_ERR_MSG(extack, "Invalid prefix length in selector (must be <= 128 for IPv6)");
-			goto out;
+		if (sel->prefixlen_d > 128 || sel->prefixlen_s > 128) {
+			NL_SET_ERR_MSG(extack,
+				       "Invalid prefix length in selector (must be <= 128 for IPv6)");
+			return -EINVAL;
 		}
-
-		break;
+		return 0;
 #else
 		NL_SET_ERR_MSG(extack, "IPv6 support disabled");
-		err = -EAFNOSUPPORT;
-		goto out;
+		return -EAFNOSUPPORT;
 #endif
-
 	default:
 		NL_SET_ERR_MSG(extack, "Invalid address family in selector");
-		goto out;
+		return -EINVAL;
 	}
+}
+
+static int verify_newsa_info(struct xfrm_usersa_info *p,
+			     struct nlattr **attrs,
+			     struct netlink_ext_ack *extack)
+{
+	int err;
+	u8 sa_dir = nla_get_u8_default(attrs[XFRMA_SA_DIR], 0);
+	u16 family = p->sel.family;
+
+	err = verify_xfrm_family(p->family, extack);
+	if (err)
+		goto out;
+
+	if (!family && !(p->flags & XFRM_STATE_AF_UNSPEC))
+		family = p->family;
+
+	err = verify_selector_prefixlen(family, &p->sel, extack);
+	if (err)
+		goto out;
 
 	err = -EINVAL;
 	switch (p->id.proto) {

-- 
2.47.3

