Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC6820E02C;
	Thu, 12 Dec 2024 10:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733998818; cv=none; b=Gmv2uU//Yz54X81IjtV4Td8GZSmlJpaesSsIIrqOrAk+bW2qwLhQC5POvQt97XjKpEVbbKt4JMrSAO59p7DU0+jEl6w3XCamdTmbjbCsd+98iV0yfXdMsQjnzvJesN2QRcihNmVlnxuLjikF+jLL/kgzGAfWlVr0V2JCkz/q2ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733998818; c=relaxed/simple;
	bh=0S7iqkxXTn80dfZXFudyVbEy4yIbbBzQzHsWKzGIoc0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sXc0jT+P272phqE73PuIkNJysKbcKgtQZ5XB0eATX/uLIMYmTS5dsAIPLo31rkRsTAyK3G8DCQni1598k+Q2wfCIdDCsHVSLaLVuRmMqWkibgX4JGpNpBnjxxvocyZwEdpbx8Rg7vx2pl5NN1k3X8Yf8VXnwYk+UyUGaVrLaZRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y87g95jfmz6K5V8;
	Thu, 12 Dec 2024 18:16:53 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A280140736;
	Thu, 12 Dec 2024 18:20:12 +0800 (CST)
Received: from mscphis02103.huawei.com (10.123.65.215) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 12 Dec 2024 13:20:11 +0300
From: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
To: <paul@paul-moore.com>
CC: <mic@digikod.net>, <selinux@vger.kernel.org>,
	<stephen.smalley.work@gmail.com>, <omosnace@redhat.com>,
	<linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
	<yusongping@huawei.com>, <artem.kuzin@huawei.com>,
	<konstantin.meskhidze@huawei.com>
Subject: [PATCH] selinux: Read sk->sk_family once in selinux_socket_bind()
Date: Thu, 12 Dec 2024 18:20:00 +0800
Message-ID: <20241212102000.2148788-1-ivanov.mikhail1@huawei-partners.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
 mscpeml500004.china.huawei.com (7.188.26.250)

selinux_socket_bind() is called without holding the socket lock.

Use READ_ONCE() to safely read sk->sk_family for IPv6 socket in case
of lockless transformation to IPv4 socket via IPV6_ADDRFORM [1].

[1] https://lore.kernel.org/all/20240202095404.183274-1-edumazet@google.com/

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
---
 security/selinux/hooks.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 5e5f3398f39d..b7adff2cf5f6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4715,8 +4715,10 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 	if (err)
 		goto out;
 
+	/* IPV6_ADDRFORM can change sk->sk_family under us. */
+	family = READ_ONCE(sk->sk_family);
+
 	/* If PF_INET or PF_INET6, check name_bind permission for the port. */
-	family = sk->sk_family;
 	if (family == PF_INET || family == PF_INET6) {
 		char *addrp;
 		struct common_audit_data ad;

base-commit: 034294fbfdf0ded4f931f9503d2ca5bbf8b9aebd
-- 
2.34.1

