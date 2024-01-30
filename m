Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6725C7EF1C
	for <selinux@vger.kernel.org>; Tue, 30 Jan 2024 23:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706657033; cv=none; b=oRaSxFc8bhUrfcHlu6+rtWNR/D3+wHJiyQn1NXl9yionLVwh86jxGZLo9ltvMG/62nGv//cdyYkEqEEjHNzGWccyd24h2WbdMEP5ZBjyyWw79XU9UUPp9xbKhNVzNMKYig7U/Mu8L8qBLaBoBgkgvDEE63FLYYY1zZdHQ81OMbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706657033; c=relaxed/simple;
	bh=KaH0QUD1q+piteLn/yCiCZ/Wdvk28XLfRi249e4sUFk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=BIi6r8FfbHevwSntWvox02RzG3S9Ud4gYnTKTTirdU4m4CKIIIdGZtaVt0vugXR3ki64nvKAj5gfRnmXaqgutbEi0M4qsog6Zrk+zTEU+dXtXo/mE4XjkFhEy9T9q9tyW1M2j4n0rSa5z1fKt8zsw1aojxqa42BaQJJBGWiUO28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RTAbLIT6; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RTAbLIT6"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-783d4b3ad96so466646385a.3
        for <selinux@vger.kernel.org>; Tue, 30 Jan 2024 15:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706657030; x=1707261830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CBoZs69oMSn/l8E58cvpIZGyzqHES5TzIqLPNloGyuI=;
        b=RTAbLIT6nvIya93HecfNQNKc4va46HWL2xv+8dS+4USb4jkv5wcK9iI3KQgB9AYiy4
         SwgrrIybjCWWtr/ptmCuw09jgq9xvVrxtRs51atFoUouYl/IA3583L0T0v08rnoIFWY8
         +RMQW7+PU9m3CV8AXUCZXAPqGVRIw+K+/bwx5mgKn6PU4wR0736/QcaPXT5TGo2XSUIx
         ZbKQnfloP7G6Q8PqlAHaedjDXBE+v+f3h5O8lyxPL8IO0lTqglIIfRaoB5HFSP+RXrg7
         lBp6BlqynuazyxPrcyGXVdyCUcOZMoNX9O7+w6OI3BqI8IUBG9djnkZ8IGasU0V4Dxr5
         Xi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706657030; x=1707261830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBoZs69oMSn/l8E58cvpIZGyzqHES5TzIqLPNloGyuI=;
        b=XCUmYLYeRWMlRe7BTGme+DVTytBJBU8UtF55P9W46H/Eq0N7DZU5+1kQE9jw6CIio+
         BRqSQhr2374L8QQvfTRM4R50y8Esn+fuVFARrrDsRytwdAb5v4x023PpXzIqgwuphail
         zM4x7StgVzw78pZact/R2lVJz8a128AVeiJ7FRXmkDJPMc0HP2hwozK74y7d+BSHayVa
         2hxcT3Hj9e2qYFkolrp1sNTw6ndLnzXV8thb6rV4Wv8CO7o+kt8ye9P7mP2QPWjkqsq/
         bBvUN/h1NJ+/jXVVP99svGH7bS3/2Qof+iqWDK8acOdtcpmC/YLrROJ++laWi3XitJDs
         4wlQ==
X-Gm-Message-State: AOJu0YzfN7la2jMqUD69FPPyy7kmsVACt+hbnWPcJpZjnSUvrfHz6oiM
	spGb40FQxBYX+JrzUEAEVTVlnVduNyFwofGb99UpOpoDVdaqYnSFMTd8UkZ8mQWSg8e814xS1yo
	=
X-Google-Smtp-Source: AGHT+IFGb7n56hWYasqDVS13B+iRP+jFhqZivZGj22VNNYkUMtokMSZaI+mK6Uq3OzEMckEuYBnGtA==
X-Received: by 2002:a05:620a:319f:b0:784:db3:33fe with SMTP id bi31-20020a05620a319f00b007840db333femr3229462qkb.75.1706657030087;
        Tue, 30 Jan 2024 15:23:50 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 9-20020a05620a04c900b00783fa16e063sm2434745qks.102.2024.01.30.15.23.49
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 15:23:49 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Subject: [PATCH] selinux: correct return values in selinux_socket_getpeersec_dgram()
Date: Tue, 30 Jan 2024 18:23:43 -0500
Message-ID: <20240130232342.378342-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1822; i=paul@paul-moore.com; h=from:subject; bh=KaH0QUD1q+piteLn/yCiCZ/Wdvk28XLfRi249e4sUFk=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBluYT+3EYuvbxzdDoPyDlLTwIIMOt3pgPyvLqQd ZokDQG8h7+JAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZbmE/gAKCRDqIPLalzeJ c5V2D/95z6lgbk4BeaslbS3vpyU4L7nrG+6imw2aaWilCera4/yurkB63bNsfOK+RjoNjvSGTqx qBmqQZeOu2sYtEVtIryuZSQRaN+Y+w8PMYwYE0N7+Rtr2kGL4tywA/o2jMCq4gJaEX7zh0A04fT r8oL2PYMViyrzM0A/UD/cfsF8BjsLDSN8s4cRpct0HgYRNXuYuIW7IUqW1+IkwQWU/GEEQQRxIC RUDjEv9kRkVxqBSzm5nIp0svIMr5N0eImyCr26Dk71nt7BZSJzu6gBTk7aAya0lZ1RQlR1zj+or lxdw3BwkJLez1qGgyTmTcY2SOf+gc2bAaeORc+OFHusLJhFKrzwq9/aNnm+rl14vBXKlKyLvU/G DVVOQJSbvh3vE6rkkuq2scg/bUVkYekDM4gAzkCbzT6iwrIdbzNR2vEDt8QB0wVfAGA3CA+rLA5 QyRbsgYq5+HN93Fkue8t5pf/ESQhP7nZnhsS5ArOAQt7hhGrmYcZXPR9Y78dr/hVQlC0mZo2VB1 sBLxE0Bfp4yGWUV6tD9+fCjskbGW3E7zg30NAAju0Yq2qnlZ/T5WZ1o1IKIK+allu4rKsxLKoq2 iyafccBYiQci/3nfB1EyHExOMscp7PC2JNgBwE7SN3wMud3q0NaA6Aq5p1Qx/H8Ajrn89e6GZlP Kf5rxjlr8gr7xJA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Instead of returning -EINVAL if any type of error occurs, limit
-EINVAL to only those errors caused by passing a bad/invalid socket
or packet/skb.  In other cases where everything is correct but there
isn't a valid peer label we return -ENOPROTOOPT.

This helps make selinux_socket_getpeersec_dgram() more consistent
with selinux_socket_getpeersec_stream().

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/hooks.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 48ae90327fa4..630ada3d208c 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -5193,11 +5193,11 @@ static int selinux_socket_getpeersec_stream(struct socket *sock,
 	return err;
 }
 
-static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *skb, u32 *secid)
+static int selinux_socket_getpeersec_dgram(struct socket *sock,
+					   struct sk_buff *skb, u32 *secid)
 {
 	u32 peer_secid = SECSID_NULL;
 	u16 family;
-	struct inode_security_struct *isec;
 
 	if (skb && skb->protocol == htons(ETH_P_IP))
 		family = PF_INET;
@@ -5205,19 +5205,21 @@ static int selinux_socket_getpeersec_dgram(struct socket *sock, struct sk_buff *
 		family = PF_INET6;
 	else if (sock)
 		family = sock->sk->sk_family;
-	else
-		goto out;
+	else {
+		*secid = SECSID_NULL;
+		return -EINVAL;
+	}
 
 	if (sock && family == PF_UNIX) {
+		struct inode_security_struct *isec;
 		isec = inode_security_novalidate(SOCK_INODE(sock));
 		peer_secid = isec->sid;
 	} else if (skb)
 		selinux_skb_peerlbl_sid(skb, family, &peer_secid);
 
-out:
 	*secid = peer_secid;
 	if (peer_secid == SECSID_NULL)
-		return -EINVAL;
+		return -ENOPROTOOPT;
 	return 0;
 }
 
-- 
2.43.0

