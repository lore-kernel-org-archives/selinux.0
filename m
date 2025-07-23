Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C7846BF;
	Wed, 23 Jul 2025 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272104; cv=none; b=Fld+4Abx/+/1osiTcia7KEyQK14JzvP5zUph7u9FA3Ye2tHoOHS7nHTzSeAeJrsZuF0lq3cVK02906dRZdd9znG6qOL9StqiigJI7zR6CMmJxsXCcyoOv3NB8ympdwdGV4L1WTdZ395AZ88SKSOg8aJN4OvdTZOWvijF+PNiTMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272104; c=relaxed/simple;
	bh=ZPs+ox05jwk/MldWb/9/wG4a2T8JJQIyqykuoQpW0LI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ke1Vb+sgxpDptlxk1wzeAdrcbJocp7wk5Bvo4uoaBqmqHqNrBi2geOSK81qRsn6mhr/MV4KJClYQv8KcA+ZR4r4qrdt4dUThBUcUa6hm+vjx0s0fku2ts0MkpfRL4y/ZQWJYI7099ku5WvBsGyuqyIvXo6/0Kmrz2YE6LM4U/Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bnCKm6nT2zSjfl;
	Wed, 23 Jul 2025 19:57:00 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 174C3180B54;
	Wed, 23 Jul 2025 20:01:33 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 23 Jul
 2025 20:01:32 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <paul@paul-moore.com>, <stephen.smalley.work@gmail.com>,
	<omosnace@redhat.com>
CC: <selinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH -next] selinux: Remove unused function selinux_policycap_netif_wildcard()
Date: Wed, 23 Jul 2025 20:23:04 +0800
Message-ID: <20250723122304.911130-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500002.china.huawei.com (7.185.36.57)

This is unused since commit a3d3043ef24a ("selinux: get netif_wildcard
policycap from policy instead of cache").

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 security/selinux/include/security.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 8201e6a3ac0f..7f19972f7922 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -203,12 +203,6 @@ static inline bool selinux_policycap_netlink_xperm(void)
 		selinux_state.policycap[POLICYDB_CAP_NETLINK_XPERM]);
 }
 
-static inline bool selinux_policycap_netif_wildcard(void)
-{
-	return READ_ONCE(
-		selinux_state.policycap[POLICYDB_CAP_NETIF_WILDCARD]);
-}
-
 struct selinux_policy_convert_data;
 
 struct selinux_load_state {
-- 
2.34.1

