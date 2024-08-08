Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACCF143726
	for <selinux@vger.kernel.org>; Thu,  8 Aug 2024 13:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122574; cv=none; b=AceCb7+i+XLZLwGMTPcPgbZtZ4d7p2oQKzrWOl1/94Xxr62ap0LhmvtcLtyXnaUZcslan8mMqqAgl/N6L6HWPGMpkKrO3Owhi9w4XaCxtBe2JCCQAh242JI8G8pVt0gy2re8kBZh/oqcrbqwxh/KRlQr8yPBQfWWyKWYy0WV7Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122574; c=relaxed/simple;
	bh=FJVkYy9Er93QeuJb8BRHw53la63EtrJ7ueqViMuRjSk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uHZXHBgbq1F4WcjUWBt8E8wYvDcwVONZWKniK85IaA4zb7HuEkYiCeMloyAfJhyE39MhIfApLIs7mB0hw9v9LO7O+7/plWe0ELbo1SkshvlKAfbANGcQxecZPL5bVMqg0c4P8EYL4xB/nbjDbqy29wq9Tw5RByReERhBWHyYHlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WfnQF4kPGzDqbb;
	Thu,  8 Aug 2024 21:07:33 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id 0E4EE1800FF;
	Thu,  8 Aug 2024 21:09:28 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 8 Aug 2024 21:09:27 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Stephen Smalley <stephen.smalley.work@gmail.com>, Paul Moore
	<paul@paul-moore.com>
CC: Ondrej Mosnacek <omosnace@redhat.com>, <selinux@vger.kernel.org>, Marc
 Reisner <reisner.marc@gmail.com>, <david@redhat.com>, Vlastimil Babka
	<vbabka@suse.cz>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, <linux-mm@kvack.org>, Kefeng Wang
	<wangkefeng.wang@huawei.com>
Subject: [PATCH] Revert "selinux: use vma_is_initial_stack() and vma_is_initial_heap()"
Date: Thu, 8 Aug 2024 21:09:09 +0800
Message-ID: <20240808130909.1027860-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf100008.china.huawei.com (7.185.36.138)

This reverts commit 68df1baf158fddc07b6f0333e4c81fe1ccecd6ff.

The selinux only want to check whether the VMA range is within the heap
range or not, but vma_is_initial_heap() helper will check the intersection
between the two ranges, which leads to some issue, let's turn back to the
original validation.

Reported-by: Marc Reisner <reisner.marc@gmail.com>
Closes: https://lore.kernel.org/all/ZrPmoLKJEf1wiFmM@marcreisner.com/
Fixes: 68df1baf158f ("selinux: use vma_is_initial_stack() and vma_is_initial_heap()")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 security/selinux/hooks.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 81fbfa5b80d4..f5805d4b0aec 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3845,10 +3845,13 @@ static int selinux_file_mprotect(struct vm_area_struct *vma,
 	if (default_noexec &&
 	    (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
 		int rc = 0;
-		if (vma_is_initial_heap(vma)) {
+		if (vma->vm_start >= vma->vm_mm->start_brk &&
+		    vma->vm_end <= vma->vm_mm->brk) {
 			rc = avc_has_perm(sid, sid, SECCLASS_PROCESS,
 					  PROCESS__EXECHEAP, NULL);
-		} else if (!vma->vm_file && (vma_is_initial_stack(vma) ||
+		} else if (!vma->vm_file &&
+			   ((vma->vm_start <= vma->vm_mm->start_stack &&
+			     vma->vm_end >= vma->vm_mm->start_stack) ||
 			    vma_is_stack_for_current(vma))) {
 			rc = avc_has_perm(sid, sid, SECCLASS_PROCESS,
 					  PROCESS__EXECSTACK, NULL);
-- 
2.41.0

