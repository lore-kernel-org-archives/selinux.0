Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0792121CC46;
	Tue,  6 May 2025 03:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746502259; cv=none; b=lqC2mUcPAodwuR5s81WDJgHg9Mz/ITNjso0vC2tJG7aLUYB2XUZIZs0x9nn1T/qPS98MkvlbXqf757I4nRWg3SOXDJ2q25ZK06n6L80G+oVuXXmmN8yYynuEJ+TaKHIf5faWNTDcxqq0GolwQ6CC9OvgPMIlHEOgDWMLzPdQOt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746502259; c=relaxed/simple;
	bh=FQeEv8mzsne1Ekkhh4vm4/236JXt/QQUApEcOzWKQHI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TuJp/5WlTbd86bPtbVZyt2Kw9DLl9hP8Aq1yZhn1UUd78FMRZ+wGj1gdQRuQFCy3JjWYJjhWVXMLJPcz2ipLofleDKU4JAFrLABM+me/14ostUeyr1ycp/MRUcMiesI7h8eNJkkmYiLQTgbD/o6qG82+asQW0jtGMCKLEengCqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Zs3n816cFz2TSDR;
	Tue,  6 May 2025 11:30:20 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 01CE81402CA;
	Tue,  6 May 2025 11:30:53 +0800 (CST)
Received: from kwepemq200017.china.huawei.com (7.202.195.228) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 6 May 2025 11:30:52 +0800
Received: from hulk-vt.huawei.com (10.67.174.72) by
 kwepemq200017.china.huawei.com (7.202.195.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 6 May 2025 11:30:52 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>
CC: <paul@paul-moore.com>, <stephen.smalley.work@gmail.com>,
	<omosnace@redhat.com>, <ericsu@linux.microsoft.com>, <caixinchen1@huawei.com>
Subject: [PATCH] SELinux: Add check for the user data passed to kcalloc in hashtab_init
Date: Tue, 6 May 2025 03:18:33 +0000
Message-ID: <20250506031833.6107-1-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemq200017.china.huawei.com (7.202.195.228)

When the user writes some data to the file /sys/fs/selinux/policy,
there is no check for the user buf passed to kcalloc. Syzkaller shows
 this warning:
WARNING: CPU: 1 PID: 6642 at mm/page_alloc.c

__alloc_pages_noprof
___kmalloc_large_node
__kmalloc_large_node_noprof
__kmalloc_noprof
hashtab_init
common_read
policydb_read
security_load_policy
sel_write_load
vfs_write
ksys_write
do_syscall_64

This warning can be reproduced by writing this content to
/sys/fs/selinux/policy
8cff7cf9 08000000 5345204c 696e7578 15000000 e0ff962a 08000000 07000000
4cf523cd 7eec2688 6d70a6b7 c78b496f 1a0a192c ea34ff41 70581a74 3ff0cfb9
7ea0f0d1 70d1fe14 41c2f7c8 ea1c78dd 17a19249 35210081 a83c30ec 4171450b
fc1de12c fe1ff342 a887

Add check to prevent the size passed to kcalloc larger than MAX_PAGE_ORDER
after get_order.

Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 security/selinux/ss/hashtab.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/security/selinux/ss/hashtab.c b/security/selinux/ss/hashtab.c
index 383fd2d70878..18bcf3978c9e 100644
--- a/security/selinux/ss/hashtab.c
+++ b/security/selinux/ss/hashtab.c
@@ -30,6 +30,21 @@ static u32 hashtab_compute_size(u32 nel)
 	return nel == 0 ? 0 : roundup_pow_of_two(nel);
 }
 
+static bool is_order_out_of_range(u32 size, struct hashtab *h)
+{
+	size_t bytes;
+	u32 order;
+
+	if (unlikely(check_mul_overflow(size, sizeof(*h->htable), &bytes)))
+		return true;
+
+	order = get_order(bytes);
+	if (order > MAX_PAGE_ORDER)
+		return true;
+
+	return false;
+}
+
 int hashtab_init(struct hashtab *h, u32 nel_hint)
 {
 	u32 size = hashtab_compute_size(nel_hint);
@@ -40,6 +55,9 @@ int hashtab_init(struct hashtab *h, u32 nel_hint)
 	h->htable = NULL;
 
 	if (size) {
+		if (is_order_out_of_range(size, h))
+			return -ENOMEM;
+
 		h->htable = kcalloc(size, sizeof(*h->htable), GFP_KERNEL);
 		if (!h->htable)
 			return -ENOMEM;
-- 
2.34.1

