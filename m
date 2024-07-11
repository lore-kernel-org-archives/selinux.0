Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013428F72
	for <selinux@vger.kernel.org>; Thu, 11 Jul 2024 02:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720666746; cv=none; b=eZGCh2YWFRB9TTldy7L/ItVBT30UO3I1O8hyIZ8XIFdvydg4PKHiW6i1ttQAwHM14mXRbtccRN0Iftji74IVUR9Ld89Auy7EWajilMfZzSle7P+6q4njG4A4eAVAKDo4hgkXqn0NnVXKQr+bD9SOYshn/h07row8xYcUi+aVIMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720666746; c=relaxed/simple;
	bh=IUVNdPHsQ9fvxuZoSgQHnH77K16/uheGc3Q/3uLsmh4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tOcq6bs4DVjlrVVKbDzCpA4Q5UF8yX7X3CQqEAkWN6honO+duua8nilioPTJiMq/r00UqlShu4+vESBKDL24PC6cRKWScXp/Qp7acWV6UF0iBmgMvRGCxHnrQB+8vTLixDyJMUC0ZHMyrfzqP9DfKxsNasf9VtUFZy2HuNjKKL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WKKB31shrz1HF9j;
	Thu, 11 Jul 2024 10:56:27 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id C2447140157;
	Thu, 11 Jul 2024 10:58:53 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 11 Jul 2024 10:58:53 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <paul@paul-moore.com>, <stephen.smalley.work@gmail.com>,
	<omosnace@redhat.com>, <cuigaosheng1@huawei.com>
CC: <selinux@vger.kernel.org>
Subject: [PATCH -next] selinux: refactor code to return the correct errno
Date: Thu, 11 Jul 2024 10:58:52 +0800
Message-ID: <20240711025852.916781-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200011.china.huawei.com (7.221.188.251)

Refactor the code in sel_netif_sid_slow to get the correct errno
when an error occurs.

Add some similar modifications to selinux_netlbl_sock_genattr and
sel_netport_sid_slow.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 security/selinux/netif.c    | 16 ++++++++++------
 security/selinux/netlabel.c | 16 ++++++++--------
 security/selinux/netport.c  | 12 +++++++-----
 3 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/security/selinux/netif.c b/security/selinux/netif.c
index 43a0d3594b72..6d8544d8c63c 100644
--- a/security/selinux/netif.c
+++ b/security/selinux/netif.c
@@ -156,14 +156,18 @@ static int sel_netif_sid_slow(struct net *ns, int ifindex, u32 *sid)
 	ret = security_netif_sid(dev->name, sid);
 	if (ret != 0)
 		goto out;
+
 	new = kzalloc(sizeof(*new), GFP_ATOMIC);
-	if (new) {
-		new->nsec.ns = ns;
-		new->nsec.ifindex = ifindex;
-		new->nsec.sid = *sid;
-		if (sel_netif_insert(new))
-			kfree(new);
+	if (!new) {
+		ret = -ENOMEM;
+		goto out;
 	}
+	new->nsec.ns = ns;
+	new->nsec.ifindex = ifindex;
+	new->nsec.sid = *sid;
+	ret = sel_netif_insert(new);
+	if (ret)
+		kfree(new);
 
 out:
 	spin_unlock_bh(&sel_netif_lock);
diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
index 55885634e880..40b5dcbd97d4 100644
--- a/security/selinux/netlabel.c
+++ b/security/selinux/netlabel.c
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
diff --git a/security/selinux/netport.c b/security/selinux/netport.c
index 2e22ad9c2bd0..a75a479515fb 100644
--- a/security/selinux/netport.c
+++ b/security/selinux/netport.c
@@ -152,12 +152,14 @@ static int sel_netport_sid_slow(u8 protocol, u16 pnum, u32 *sid)
 	if (ret != 0)
 		goto out;
 	new = kzalloc(sizeof(*new), GFP_ATOMIC);
-	if (new) {
-		new->psec.port = pnum;
-		new->psec.protocol = protocol;
-		new->psec.sid = *sid;
-		sel_netport_insert(new);
+	if (!new) {
+		ret = -ENOMEM;
+		goto out;
 	}
+	new->psec.port = pnum;
+	new->psec.protocol = protocol;
+	new->psec.sid = *sid;
+	sel_netport_insert(new);
 
 out:
 	spin_unlock_bh(&sel_netport_lock);
-- 
2.25.1

