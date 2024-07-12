Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FF81FAA
	for <selinux@vger.kernel.org>; Fri, 12 Jul 2024 01:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720748746; cv=none; b=CUppKG6gg23rLxIwDHcmq2Va+VQ/IBPCmOBJ1FBYPys8lsIX1vhJ9JbrdB3sIa6FhoQXM9DVj82dELVEzgHbFR8kBvDgor069EvdCNGzSjDYgR06H1d9A8gSwfSB/dVbVChyCi90fhM+BTX6EbvxboXNLKiYw59uCCh1WegvBas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720748746; c=relaxed/simple;
	bh=CSDt4uv9BlvN+3cT/z1hMN9b2vSFhooDX2evZ6UXgos=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WrVDWewICv1l49vN1utw6RGDIyqdekc7LlFeC9mL2Hg32Ot06+vmx8UH1cPWXVYop3kGcOxaMIMHN5nfNinGSTwMnFArg6yUE2KimQ4nyOe7TGYxLe5XU5wIKFCNTw76uh3Vo1bWK7XX8IpxVjmgo32aAmugRocL48aCcp2R8AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WKvSL67T5z1T5jQ;
	Fri, 12 Jul 2024 09:40:50 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id 83ADE18009B;
	Fri, 12 Jul 2024 09:45:35 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 12 Jul 2024 09:45:35 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <paul@paul-moore.com>, <stephen.smalley.work@gmail.com>,
	<omosnace@redhat.com>, <cuigaosheng1@huawei.com>
CC: <selinux@vger.kernel.org>
Subject: [PATCH -next,v2] selinux: refactor code to return ERR_PTR in selinux_netlbl_sock_genattr
Date: Fri, 12 Jul 2024 09:45:34 +0800
Message-ID: <20240712014534.1705340-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200011.china.huawei.com (7.221.188.251)

Refactor the code in selinux_netlbl_sock_genattr to return ERR_PTR
when an error occurs.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
v2: Reomve modifications to netif and netport, and update the commit message.
 security/selinux/netlabel.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 55885634e880..63c481dd71bb 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
@@ -62,7 +62,7 @@ static int selinux_netlbl_sidlookup_cached(struct sk_buff *skb,
  * Description:
  * Generate the NetLabel security attributes for a socket, making full use of
  * the socket's attribute cache.  Returns a pointer to the security attributes
- * on success, NULL on failure.
+ * on success, or an ERR_PTR on failure.
  *
  */
 static struct netlbl_lsm_secattr *selinux_netlbl_sock_genattr(struct sock *sk)
@@ -76,11 +76,12 @@ static struct netlbl_lsm_secattr *selinux_netlbl_sock_genattr(struct sock *sk)
 
 	secattr = netlbl_secattr_alloc(GFP_ATOMIC);
 	if (secattr == NULL)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
+
 	rc = security_netlbl_sid_to_secattr(sksec->sid, secattr);
 	if (rc != 0) {
 		netlbl_secattr_free(secattr);
-		return NULL;
+		return ERR_PTR(rc);
 	}
 	sksec->nlbl_secattr = secattr;
 
@@ -400,8 +401,8 @@ int selinux_netlbl_socket_post_create(struct sock *sk, u16 family)
 		return 0;
 
 	secattr = selinux_netlbl_sock_genattr(sk);
-	if (secattr == NULL)
-		return -ENOMEM;
+	if (IS_ERR(secattr))
+		return PTR_ERR(secattr);
 	/* On socket creation, replacement of IP options is safe even if
 	 * the caller does not hold the socket lock.
 	 */
@@ -561,10 +562,9 @@ static int selinux_netlbl_socket_connect_helper(struct sock *sk,
 		return rc;
 	}
 	secattr = selinux_netlbl_sock_genattr(sk);
-	if (secattr == NULL) {
-		rc = -ENOMEM;
-		return rc;
-	}
+	if (IS_ERR(secattr))
+		return PTR_ERR(secattr);
+
 	rc = netlbl_conn_setattr(sk, addr, secattr);
 	if (rc == 0)
 		sksec->nlbl_state = NLBL_CONNLABELED;
-- 
2.25.1

