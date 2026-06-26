Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C942C3768;
	Fri, 26 Jun 2026 01:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782437656; cv=none; b=W+rqE60AeceJ3ToaCaSbCb8AGhWTFgPKYaC/ETJdn0k2qPggTVCpoLm14QSVnK6zwUbNyzWFmi/LklbTsaQf/3Od6i1GNRbXQifRGK7h0jSk1Q6LaI+JGXBaPhzZs9Ia5C6etX/uknvrQOGRIkBdZN2YFQXzkX7ke4y+7we2jQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782437656; c=relaxed/simple;
	bh=+sKQV/hSXCJalGh3VZuSm8AwMOEs1CjTyUkUw90zHNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L2nxEAKGgUprfnPX40vdV6iOGnsrrczypSl0QpAotAONg9hpxYVssR2gzRRnYMclYnbu3qF7Q8medggpZwvKVypvEd0pENammuokANVVsOtvTvWxg1xa8v1P9/1vRW90gmrL+0u5wrWINsX8S3ZwR0n8TRhw2t569A7k9OjBGT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=VPKfbQVT; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="VPKfbQVT"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CXPyZDg94M8Ealqt6QHbsHU8janQt77Ei/rsIGiLBaE=;
	b=VPKfbQVT5Sb2hexQvT77izIG+2Z1sPg/zn8ZR0Xsnab/Rwk+QuYVtjxSAQhPbtLbft62dOMWI
	5vZbTgqDRdzmh9yCJCYXZaMU5ahg+SVWq2DzvIlD8d/gs/iGkLxneSfnkq639OWh9laFoLKRmWT
	aqLYDDOyOPuGyqf1opWKluM=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gmdK71sCXzcbNN;
	Fri, 26 Jun 2026 09:25:31 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id DC1D740537;
	Fri, 26 Jun 2026 09:34:11 +0800 (CST)
Received: from kwepemq200017.china.huawei.com (7.202.195.228) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 26 Jun 2026 09:34:11 +0800
Received: from hulk-vt.huawei.com (10.67.174.72) by
 kwepemq200017.china.huawei.com (7.202.195.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 26 Jun 2026 09:34:11 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<stephen.smalley.work@gmail.com>, <omosnace@redhat.com>,
	<amir73il@gmail.com>, <brauner@kernel.org>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<selinux@vger.kernel.org>, <caixinchen1@huawei.com>, <lujialin4@huawei.com>
Subject: [PATCH -next 1/2] security: Some cleanup code
Date: Fri, 26 Jun 2026 01:17:19 +0000
Message-ID: <20260626011720.1144213-2-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626011720.1144213-1-caixinchen1@huawei.com>
References: <20260626011720.1144213-1-caixinchen1@huawei.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq200017.china.huawei.com (7.202.195.228)

Delete an unnecessary blank line and a blobs variable with
duplicate assignment.

Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 security/lsm_init.c      | 1 -
 security/selinux/hooks.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 7c0fd17f1601..d7384866e3a5 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -290,7 +290,6 @@ static void __init lsm_prepare(struct lsm_info *lsm)
 		return;
 
 	/* Register the LSM blob sizes. */
-	blobs = lsm->blobs;
 	lsm_blob_size_update(&blobs->lbs_cred, &blob_sizes.lbs_cred);
 	lsm_blob_size_update(&blobs->lbs_file, &blob_sizes.lbs_file);
 	lsm_blob_size_update(&blobs->lbs_backing_file,
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1a713d96206f..e5930ebc9e37 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1748,7 +1748,6 @@ static int bpf_fd_pass(const struct file *file, u32 sid);
 
 static int __file_has_perm(const struct cred *cred, const struct file *file,
 			   u32 av, bool bf_user_file)
-
 {
 	struct common_audit_data ad;
 	struct inode *inode;
-- 
2.34.1

