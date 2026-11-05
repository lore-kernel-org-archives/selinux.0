Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914316;
	b=MuwnaWxRo2DG0jWxlD5Qf086XJwlRHebz4R7oxLaOajHtggzy7uyO/SDkC9WXHZvkaOb
	 3vEpw89fH9dL+3+/kZuUTfmAFRsk5gbQquXQsV4aRmxObK8/wBhnQIMvt4KqU3YVIRwF3
	 tRRI4gT59G/y5sSlY2fMkN557lI4HpmfdwpJabeUjzb1u6gfPBPRTJHd3ZHvnP07xHrgn
	 oxevnaX8jUqsxeZ3JGGKE4Vv8U/1DnyeT3bjwPb+n5gNFQFTf9hao+0nbidD9OBSZCoNT
	 1RxesECAtjenCikByfTiHJpJF8YCISQtI1WFpVfTEZ/I/yAM2BLn/4W+8gvbQiFdMPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914316;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=HChmTqD3l76D4xTwaDId89Adh4XK1U9R7SwaL6QQSiA=;
	b=BhURqHl8XlNDPyWCUaqpxrKYoSIOJ/SGS6O4QPav50cNxr8kprmXH1kR9InKjBVEDmhV
	 HF3pWAY78UDqNJvYlaH1vwJS3DHcIz1TVuMDOeWSlYaUc2+FSJ564svlXCchFDlQORQfM
	 ENTeApfjDnLSha4XRL4dX+eO32s5quIlm0UCQQ9UX0kPyDIyHUCW2fT89wmkEKBk89Owy
	 s6dwk+x88S4+uTWaIuGDP2JQqnNI5tiiZ1aOZWYVjPFKR8DeY2732rB5bAXl9A8ORjmxL
	 zcoHo2ifiOd7EVg4kqVyjYEHZxcUqUUIiLFlLB7MY09PVwxA3dF/Zm6Ko83Weda0Q6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YlMc4Yav;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BFD606A31B;
	Thu,  5 Nov 2026 21:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YlMc4Yav
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C30E1F008A2;
	Thu,  5 Nov 2026 21:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914316;
	bh=HChmTqD3l76D4xTwaDId89Adh4XK1U9R7SwaL6QQSiA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YlMc4YavmcnzgGqbTg8xy48BhuWYv3UOv9e7rnmekOka0vxC7n1uK3Z1d/ertyht4
	 gCAvHw7gGAQQROPopfRHJgoy8erMLDNpeAUwUkkbW6t0RvoH48kScoLYMbrr7WpxNt
	 HxBkoPoow43LyAF0PNefCHawtW6nY6W2vaF8YTFGm+K0GzQYI3z4CQ4GKTge3YbMig
	 n/jqvmxLm3mfdHdHzkKty6LwIjif+xouTG85uifDRCDzkMDa71N4mrbtT8dOCeT1yr
	 +VCS8ipUCMfQC4Pu2gDJhnDr04M5LDYAZziTDD57o3hVj3oObrutNSWPu8zZA/B6Z1
	 iHElNiOHvDCnA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 05 Nov 2026 21:30:52 +0000
Subject: [PATCH 01/13] mm/gup: convert GUP code to use vma_flags_t
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-late-2026-vma-flags-v1-1-0d3cd15ab75f@kernel.org>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
In-Reply-To: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
 Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro Falcato <pfalcato@suse.de>, 
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, 
 SJ Park <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>, 
 David Rientjes <rientjes@google.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 John Johansen <john.johansen@canonical.com>, 
 Georgia Garcia <georgia.garcia@canonical.com>, 
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 kvm@vger.kernel.org, damon@lists.linux.dev, 
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5850; i=ljs@kernel.org;
 h=from:subject:message-id; bh=bW54hq6rUX5mn84GnflVBnxa46MVVq7so69BlwTkM0U=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLefF16/eGzghS9c2a+/VuKG9T/c/1zfuM/o+P/mkbeg
 LgD/3/e6ihlYRDjYpAVU2R5/kV8f5BI2LzOC/5uMHNYmUCGMHBxCsBEmi8wMpyRDTLtTTnO0LZo
 /YpNb7yb13n0pyWu8LqqtjaoqkWbwZmR4d3GRbvaD8eunFR2tC1T5du5REvjsF4+70n2No+9xV2
 6mAE=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Replace use of the legacy vm_flags_t flags with vma_flags_t values
throughout the GUP logic, both for the MMU and nommu variants.

No functional change intended.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/gup.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 7d43ce717b24..dc232117b1ce 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -590,15 +590,15 @@ static inline bool can_follow_write_common(struct page *page,
 		return false;
 
 	/* But FOLL_FORCE has no effect on shared mappings */
-	if (vma->vm_flags & (VM_MAYSHARE | VM_SHARED))
+	if (vma_test_any(vma, VMA_MAYSHARE_BIT, VMA_SHARED_BIT))
 		return false;
 
 	/* ... or read-only private ones */
-	if (!(vma->vm_flags & VM_MAYWRITE))
+	if (!vma_test(vma, VMA_MAYWRITE_BIT))
 		return false;
 
 	/* ... or already writable ones that just need to take a write fault */
-	if (vma->vm_flags & VM_WRITE)
+	if (vma_test(vma, VMA_WRITE_BIT))
 		return false;
 
 	/*
@@ -1199,12 +1199,11 @@ static bool writable_file_mapping_allowed(struct vm_area_struct *vma,
 
 static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 {
-	vm_flags_t vm_flags = vma->vm_flags;
 	int write = (gup_flags & FOLL_WRITE);
 	int foreign = (gup_flags & FOLL_REMOTE);
 	bool vma_anon = vma_is_anonymous(vma);
 
-	if (vm_flags & (VM_IO | VM_PFNMAP))
+	if (vma_test_any(vma, VMA_IO_BIT, VMA_PFNMAP_BIT))
 		return -EFAULT;
 
 	if ((gup_flags & FOLL_ANON) && !vma_anon)
@@ -1224,7 +1223,8 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 		    !writable_file_mapping_allowed(vma, gup_flags))
 			return -EFAULT;
 
-		if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK)) {
+		if (!vma_test(vma, VMA_WRITE_BIT) ||
+		    vma_test_single_mask(vma, VMA_SHADOW_STACK)) {
 			if (!(gup_flags & FOLL_FORCE))
 				return -EFAULT;
 			/*
@@ -1239,14 +1239,14 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 			if (!vma_is_cow_mapping(vma))
 				return -EFAULT;
 		}
-	} else if (!(vm_flags & VM_READ)) {
+	} else if (!vma_test(vma, VMA_READ_BIT)) {
 		if (!(gup_flags & FOLL_FORCE))
 			return -EFAULT;
 		/*
 		 * Is there actually any vma we can reach here which does not
 		 * have VM_MAYREAD set?
 		 */
-		if (!(vm_flags & VM_MAYREAD))
+		if (!vma_test(vma, VMA_MAYREAD_BIT))
 			return -EFAULT;
 	}
 	/*
@@ -1277,7 +1277,7 @@ static struct vm_area_struct *gup_vma_lookup(struct mm_struct *mm,
 		return vma;
 
 	/* Only warn for half-way relevant accesses */
-	if (!(vma->vm_flags & VM_GROWSDOWN))
+	if (!vma_test(vma, VMA_GROWSDOWN_BIT))
 		return NULL;
 	if (vma->vm_start - addr > 65536)
 		return NULL;
@@ -1514,9 +1514,8 @@ static bool vma_permits_fault(struct vm_area_struct *vma,
 {
 	bool write   = !!(fault_flags & FAULT_FLAG_WRITE);
 	bool foreign = !!(fault_flags & FAULT_FLAG_REMOTE);
-	vm_flags_t vm_flags = write ? VM_WRITE : VM_READ;
 
-	if (!(vm_flags & vma->vm_flags))
+	if (!vma_test(vma, write ? VMA_WRITE_BIT : VMA_READ_BIT))
 		return false;
 
 	/*
@@ -1829,7 +1828,7 @@ long populate_vma_page_range(struct vm_area_struct *vma,
 	 * Rightly or wrongly, the VM_LOCKONFAULT case has never used
 	 * faultin_page() to break COW, so it has no work to do here.
 	 */
-	if (vma->vm_flags & VM_LOCKONFAULT)
+	if (vma_test(vma, VMA_LOCKONFAULT_BIT))
 		return nr_pages;
 
 	/* ... similarly, we've never faulted in PROT_NONE pages */
@@ -1849,7 +1848,7 @@ long populate_vma_page_range(struct vm_area_struct *vma,
 	 * Otherwise, do a read fault, and use FOLL_FORCE in case it's not
 	 * readable (ie write-only or executable).
 	 */
-	if ((vma->vm_flags & (VM_WRITE | VM_SHARED)) == VM_WRITE)
+	if (vma_test(vma, VMA_WRITE_BIT) && !vma_test(vma, VMA_SHARED_BIT))
 		gup_flags |= FOLL_WRITE;
 	else
 		gup_flags |= FOLL_FORCE;
@@ -1955,7 +1954,7 @@ int __mm_populate(unsigned long start, unsigned long len, int ignore_errors)
 		 * range with the first VMA. Also, skip undesirable VMA types.
 		 */
 		nend = min(end, vma->vm_end);
-		if (vma->vm_flags & (VM_IO | VM_PFNMAP))
+		if (vma_test_any(vma, VMA_IO_BIT, VMA_PFNMAP_BIT))
 			continue;
 		if (nstart < vma->vm_start)
 			nstart = vma->vm_start;
@@ -1986,7 +1985,7 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
 {
 	struct vm_area_struct *vma;
 	bool must_unlock = false;
-	vm_flags_t vm_flags;
+	vma_flags_t vma_flags;
 	int ret, err = -EFAULT;
 	long i;
 
@@ -2011,10 +2010,14 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
 	/* calculate required read or write permissions.
 	 * If FOLL_FORCE is set, we only require the "MAY" flags.
 	 */
-	vm_flags  = (foll_flags & FOLL_WRITE) ?
-			(VM_WRITE | VM_MAYWRITE) : (VM_READ | VM_MAYREAD);
-	vm_flags &= (foll_flags & FOLL_FORCE) ?
-			(VM_MAYREAD | VM_MAYWRITE) : (VM_READ | VM_WRITE);
+	if (foll_flags & FOLL_WRITE)
+		vma_flags = mk_vma_flags(VMA_WRITE_BIT, VMA_MAYWRITE_BIT);
+	else
+		vma_flags = mk_vma_flags(VMA_READ_BIT, VMA_MAYREAD_BIT);
+	if (foll_flags & FOLL_FORCE)
+		vma_flags_clear(&vma_flags, VMA_READ_BIT, VMA_WRITE_BIT);
+	else
+		vma_flags_clear(&vma_flags, VMA_MAYREAD_BIT, VMA_MAYWRITE_BIT);
 
 	for (i = 0; i < nr_pages; i++) {
 		vma = find_vma(mm, start);
@@ -2022,8 +2025,8 @@ static long __get_user_pages_locked(struct mm_struct *mm, unsigned long start,
 			break;
 
 		/* protect what we can, including chardevs */
-		if ((vma->vm_flags & (VM_IO | VM_PFNMAP)) ||
-		    !(vm_flags & vma->vm_flags))
+		if (vma_test_any(vma, VMA_IO_BIT, VMA_PFNMAP_BIT) ||
+		    !vma_test_any_mask(vma, vma_flags))
 			break;
 
 		if (pages) {

-- 
2.56.0

