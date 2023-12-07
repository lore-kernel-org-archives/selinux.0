Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C086BD5E
	for <selinux@vger.kernel.org>; Thu,  7 Dec 2023 07:25:52 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SmHzq6JSJzShwn;
	Thu,  7 Dec 2023 23:21:27 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 23:25:49 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: <paul@paul-moore.com>, <stephen.smalley.work@gmail.com>,
	<selinux@vger.kernel.org>, <linux-mm@kvack.org>, <david@redhat.com>,
	<peterz@infradead.org>, Kefeng Wang <wangkefeng.wang@huawei.com>, Ondrej
 Mosnacek <omosnace@redhat.com>
Subject: [PATCH] mm: fix VMA heap bounds checking
Date: Thu, 7 Dec 2023 23:25:25 +0800
Message-ID: <20231207152525.2607420-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected

After selinux converting to VMA heap check helper, the gcl triggers
an execheap SELinux denial, which caused by different check logical.

The old from selinux only check VMA range within VMA heap range, and
the new will check the intersects between the two ranges, but the corner
cases(vm_end=start_brk, brk=vm_start) doesn't be handled correctly.

Since commit 11250fd12eb8 ("mm: factor out VMA stack and heap checks")
only a function extraction, it seems that the issue introduced from
commit 0db0c01b53a1 ("procfs: fix /proc/<pid>/maps heap check"), let's
fix above corner cases, meanwhile, corrent the wrong indentation of the
stack and heap check helpers.

Reported-and-tested-by: Ondrej Mosnacek <omosnace@redhat.com>
Closes: https://lore.kernel.org/selinux/CAFqZXNv0SVT0fkOK6neP9AXbj3nxJ61JAY4+zJzvxqJaeuhbFw@mail.gmail.com/
Fixes: 0db0c01b53a1 ("procfs: fix /proc/<pid>/maps heap check")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/linux/mm.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1be544664f92..2bea89dc0bdf 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -886,8 +886,8 @@ static inline bool vma_is_anonymous(struct vm_area_struct *vma)
  */
 static inline bool vma_is_initial_heap(const struct vm_area_struct *vma)
 {
-       return vma->vm_start <= vma->vm_mm->brk &&
-		vma->vm_end >= vma->vm_mm->start_brk;
+	return vma->vm_start < vma->vm_mm->brk &&
+		vma->vm_end > vma->vm_mm->start_brk;
 }
 
 /*
@@ -901,8 +901,8 @@ static inline bool vma_is_initial_stack(const struct vm_area_struct *vma)
 	 * its "stack".  It's not even well-defined for programs written
 	 * languages like Go.
 	 */
-       return vma->vm_start <= vma->vm_mm->start_stack &&
-	       vma->vm_end >= vma->vm_mm->start_stack;
+	return vma->vm_start <= vma->vm_mm->start_stack &&
+		vma->vm_end >= vma->vm_mm->start_stack;
 }
 
 static inline bool vma_is_temporary_stack(struct vm_area_struct *vma)
-- 
2.27.0

