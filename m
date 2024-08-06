Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1D415B147;
	Tue,  6 Aug 2024 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722927116; cv=none; b=RXfiGFqDcX/n3EfWt21ACqBoA3vHlvr7t+XFSfUz+FFivH7/HBnE89rMbo06b7BblY4LE/lJtpdnBvZy24ivSW+YlZrm28KFu1YLYePNYNi2rQSJ0bnV/JyszbVBzMeQxthH813aiQV1Jy6IvlEkrWV6JODIGRqCv9fWuyeIt4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722927116; c=relaxed/simple;
	bh=H6A4LpeNGhQxmd9+oJB3s2uuR0dLR/RABd7vBqdiGFM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eV0Iuozk9sUNlQRn1Ng+CSLi9gabj1X3PEClpnfXFRtlyG6djZkOCzqk9SS3Yofudi1VxXV4e5regqslHfs2SEnY0ukmtA3x7KIS91r+0QcnvwErmfphmUvGLhpr+QbdAU4MGpsAjytLsdZ93f7+RXwe8aJzaM4zMG0U0fhYeEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WdP9H2lS0z4f3jLy;
	Tue,  6 Aug 2024 14:51:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A62841A1127;
	Tue,  6 Aug 2024 14:51:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
	by APP4 (Coremail) with SMTP id gCh0CgBXfoT9x7FmMjilAw--.41083S4;
	Tue, 06 Aug 2024 14:51:44 +0800 (CST)
From: thunder.leizhen@huaweicloud.com
To: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
	Nick Kralevich <nnk@google.com>,
	Jeff Vander Stoep <jeffv@google.com>
Subject: [PATCH 1/1] selinux: Fix potential counting error in avc_add_xperms_decision()
Date: Tue,  6 Aug 2024 14:51:13 +0800
Message-Id: <20240806065113.1317-1-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXfoT9x7FmMjilAw--.41083S4
X-Coremail-Antispam: 1UD129KBjvdXoW7GF4UJry3Zw1UGF4DWFy7GFg_yoWfKFcEkF
	ykurnrWr48ZFs5AanxCF1Fvrn09395uF4rW34rCasrZF43XFn5Jr1fCr1kXry3Ww4rAr9r
	CFnrWa4kGwnrXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267
	AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80
	ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUAVWU
	twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1XdbUUUUUU==
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/

From: Zhen Lei <thunder.leizhen@huawei.com>

The count increases only when a node is successfully added to
the linked list.

Fixes: fa1aa143ac4a ("selinux: extended permissions for ioctls")
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 security/selinux/avc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 32eb67fb3e42c0f..7087cd2b802d8d8 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -330,12 +330,12 @@ static int avc_add_xperms_decision(struct avc_node *node,
 {
 	struct avc_xperms_decision_node *dest_xpd;
 
-	node->ae.xp_node->xp.len++;
 	dest_xpd = avc_xperms_decision_alloc(src->used);
 	if (!dest_xpd)
 		return -ENOMEM;
 	avc_copy_xperms_decision(&dest_xpd->xpd, src);
 	list_add(&dest_xpd->xpd_list, &node->ae.xp_node->xpd_head);
+	node->ae.xp_node->xp.len++;
 	return 0;
 }
 
-- 
2.34.1

