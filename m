Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C334F378D9C;
	Tue,  5 May 2026 04:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777955674; cv=none; b=PFyCWFmWvAv3sUMQh1JwlnuPJXZsXGw5MqQ1hnTmICkOikXpWN0IcD0PTPUS45avzWT6/KngcR+PKnA6e0yXu7xiTqq826LqTBoiny43ZWo+hqBS3agd0lO7Jm07niZSc7lAOyP9MMqg1qNF/mFRPAaVznrd1WocQtU5yFTUUjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777955674; c=relaxed/simple;
	bh=mNC+qFCIm3S+Cqcjrl1alQUoBlH4etYwZGdgmKgRD5k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QyX/VeSki3Y7hfYUhxPjbtxsSRl0VfxYg6CDjDKQ6qIUBRp1PCL3tYVwdZr+S6wKfW0NFdhHIvovV+ADJ3CmtZ6SM0EK6+30Ni1ehhfDKfTUvWErgrGo4SFQFzoTubbyrUHor4KHoDwaWwrGwhUdLOf0CWtWgDukz24LI5RnytU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=uAEjy5R5; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="uAEjy5R5"
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id A623520719;
	Tue,  5 May 2026 06:34:31 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CRuK3EZHryJS; Tue,  5 May 2026 06:34:30 +0200 (CEST)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id ABA23206E9;
	Tue,  5 May 2026 06:34:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com ABA23206E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1777955670;
	bh=OHxEm3OzaP2lf7ce9tWGy8l3TbqkgIeNjP3xVUN5uOQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=uAEjy5R56Ja8ZhLNhmBTxvGZrBbqgphtF6QLWLXg+WD6uEHeuoA1u8Ku0iJeCBB7Y
	 H4cXt+/a4HOy8cyqHE8ydXkEKoQL2z8pW6un8ryRsu5IhOkGsbpemXpjucJR7Eokes
	 1rBu86veikPpO/1jHgZLfhr+Ivi0msHalaQQM480AgS6XZMob2E+KXYtd3+GfFh/UE
	 WP8hFoUmgYiMSJyxdbKK7bwHdZwzdyfvGzVmRkWQVwC5zsqG9EZMMt/iZKa7F+lOJT
	 t4LYTMnD1F9M6FAWE2WwLpai/c53H05zNW7j9mh2e0FaGho51+3fAYxvthjhvVB/0L
	 RiXzJ95nCrf2A==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 5 May
 2026 06:34:28 +0200
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
Subject: [PATCH ipsec-next v8 11/14] xfrm: refactor XFRMA_MTIMER_THRESH validation into a helper
Date: Tue, 5 May 2026 06:34:17 +0200
Message-ID: <migrate-state-v8-11-4578fb016965@secunet.com>
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

Extract verify_mtimer_thresh() to consolidate the XFRMA_MTIMER_THRESH
validation logic shared between the add_sa and upcoming patch.

Signed-off-by: Antony Antony <antony.antony@secunet.com>

---
v5->v6: added this patch
---
 net/xfrm/xfrm_user.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 273ea6fdb8ad..03fa4cabf601 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -248,6 +248,22 @@ static inline int verify_replay(struct xfrm_usersa_info *p,
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
@@ -455,18 +471,9 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
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

