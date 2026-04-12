Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541CB2D2488;
	Sun, 12 Apr 2026 11:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775992575; cv=none; b=ooFvL1Yluw/VeJCFYqLR8UTgygQl+aqLT82sfT+wEoQH4xLvsKskOCX5SItbG6JqgR61eN0bq7jMFsd0D7IpCGoJzBH9HOaFw9+1+SrlsLF3yn1AKViUtkwOfXgrkp/MMasad19jQnwcC6xVY7MmU0N6oP1IIDMK1pQPgBYltMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775992575; c=relaxed/simple;
	bh=XGbVT5+MgmOrUWyIsLj3C2XbhobYyDSPIakykgdW9fs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ili9UyhUelRPQjlracmThGjh+0/FRnfsjoQwhzF0lP7X524p6K+kJ2l9XQW9hgORRb4oOpFf8y7oEUHWyiCr4GaLDDw1T8z5RAkFDgvOpS6onTT0t3x6ZwIV6TwWOocVVUuaL/ALFpsQ6Kb0H4KagAT/FBdvmWZZGpWoYxDO2qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=TaBgN/to; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="TaBgN/to"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id F0FB720764;
	Sun, 12 Apr 2026 13:16:12 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4t8FCIJZpJ-1; Sun, 12 Apr 2026 13:16:12 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 5BC732074F;
	Sun, 12 Apr 2026 13:16:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 5BC732074F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1775992572;
	bh=acKr4mOZaJTSy0PfL+1ws1QiSPyE3W5VnkJOLxP/49Q=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=TaBgN/toH/LsX6ezYiP2a7mCnVZHsybSTGhxicZ5+YUsAMBK96DKVDDLRkhaITQxk
	 LCEZ+zOc/Kwml7nM0BIGFVeVR4xt0Dq/4RGw3cIYCax1sv4rVo77GiuAixUFQm8n3T
	 ABjYXmsOnNEamcgQgPxAlJgIN0J0zx7vRhKvuh47+2UPiW5t1a2nFmnqgrAGptjjRI
	 m5Z96ZFQR+aQjFT3iZFxjHz20xVc3jEfaHFe1tkq1B7ZYs7mCjLf70RNuAPtkSwexL
	 55lWCK0FelcQUc4z1xpXqpLmiQE9j9S/aYbuFmneeH0WGeGjls3B2wxnw3KR+aFNT9
	 GW2yQVmmiBtbA==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 12 Apr
 2026 13:16:10 +0200
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
Subject: [PATCH ipsec-next v7 11/14] xfrm: refactor XFRMA_MTIMER_THRESH validation into a helper
Date: Sun, 12 Apr 2026 13:15:56 +0200
Message-ID: <migrate-state-v7-11-44eb2440b91c@secunet.com>
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
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-02.secunet.de
 (10.32.0.172)

Extract verify_mtimer_thresh() to consolidate the XFRMA_MTIMER_THRESH
validation logic shared between the add_sa and upcoming patch.

Signed-off-by: Antony Antony <antony.antony@secunet.com>
---
v5->v6: added this patch
---
 net/xfrm/xfrm_user.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 26b82d94acc1..fe0cf824f072 100644
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

