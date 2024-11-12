Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BF7200B8B;
	Tue, 12 Nov 2024 14:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423151; cv=none; b=UW7ATVZ12KpK8jP/fLjdV3k866VI1VOmUv8MRv4wazjFUt3/zr42yn9DynvFBBBVVAWyFaKw/2UfJeLii3sU8jbEI4XeQPfS/t3aoRi+H3g5K/pV5IW+uAnpQyc6QY3AHTSWX3arMpcNI5d6qJT/irj4V/ETHzZ0Kuym84gbr94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423151; c=relaxed/simple;
	bh=3pCo5OAsNaEj9j0X5SyEEovuDYqC3xwvL4AT1U3A0qk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A7VpkGiVVJJaaCnjFCWOEmUNo+F/IxuZuiaAadUe3ShwWPc5V25KUOTIG82rkcywlSdEQx7SJSL7h0hX84HkIW1+mIG7tFJB6jmVnUr+OJyOsmruaTINa0uxi3GMEBUoz4oDq2hxX+Ic6rLmgeNcoMMpWLDLTduhV/yhgA+jksA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xnq7K69pyz6J6pH;
	Tue, 12 Nov 2024 22:49:17 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 4E6F5140A08;
	Tue, 12 Nov 2024 22:52:24 +0800 (CST)
Received: from mscphis02103.huawei.com (10.123.65.215) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 12 Nov 2024 17:52:23 +0300
From: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
To: <paul@paul-moore.com>
CC: <mic@digikod.net>, <selinux@vger.kernel.org>,
	<stephen.smalley.work@gmail.com>, <omosnace@redhat.com>,
	<linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
	<yusongping@huawei.com>, <artem.kuzin@huawei.com>,
	<konstantin.meskhidze@huawei.com>
Subject: [RFC PATCH] selinux: Fix SCTP error inconsistency in selinux_socket_bind()
Date: Tue, 12 Nov 2024 22:52:03 +0800
Message-ID: <20241112145203.2053193-1-ivanov.mikhail1@huawei-partners.com>
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

Check sk->sk_protocol instead of security class to recognize SCTP socket.
SCTP socket is initialized with SECCLASS_SOCKET class if policy does not
support EXTSOCKCLASS capability. In this case bind(2) hook wrongfully
return EAFNOSUPPORT instead of EINVAL.

The inconsistency was detected with help of Landlock tests:
https://lore.kernel.org/all/b58680ca-81b2-7222-7287-0ac7f4227c3c@huawei-partners.com/

Fixes: 0f8db8cc73df ("selinux: add AF_UNSPEC and INADDR_ANY checks to selinux_socket_bind()")
Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index ad3abd48eed1..15e31299a833 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4828,7 +4828,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
 	return err;
 err_af:
 	/* Note that SCTP services expect -EINVAL, others -EAFNOSUPPORT. */
-	if (sksec->sclass == SECCLASS_SCTP_SOCKET)
+	if (sk->sk_protocol == IPPROTO_SCTP)
 		return -EINVAL;
 	return -EAFNOSUPPORT;
 }

base-commit: d7b6918e22c74f2b354d8dc0ef31ab17ae334b93
-- 
2.34.1

