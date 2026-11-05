Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914387;
	b=GujdReefSLSJ8n8T4Ts49sZDOFpNV39nJ/yswRdz3M1zDbW6YBwWBepRiY3pAYVnloVz
	 ghEHmGrVaqBxaQ2CR7QlJTfrUdi9ViYjvLZg2A8etE0Nr5UcX8gJqNjKsMbasAtOvpatf
	 cO5qcaszfvbkeR5eYxZmGRQGhA/TnXnDV9pV+I57rfNNWWOQylZ4YgOCmtcrnI6vhlYFm
	 4lRrMUWPMeAqviOSd7LOGByqlpXVA6z8Pp+krQQ5snIRL7Mj7NZYo2Zq71oKcwYNhrCfy
	 XOA3wo3nYEywJleWUYgWUPQ1QFmcOdWi6N0RmP46LxcIA58R0ztnOjDV8Ijg7K58vqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914387;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=m7GxaMyT1RDDZjvYUJ0P1FPXnvCLADlxook/8V9dsi8=;
	b=tupRzcq1E7atQAy5FqOdfUUoEHWxDai+X5BN3RirOyHdGvVbIbplcA/m70i5LI0msvVo
	 FKZ3oD1vsy2B/aYEFC58cgvcXphqviThXnFizGNUpIdWwJDkrEr0JJnWOpOHBOjiB9Dd8
	 91UMKvGtncn4a8IsbBvBq+7P3Ui3EN9nVMLOi53srgMRbvKDjm+tFlfxICd/NTLDPyeLk
	 yUKzQJiMWbTDVsSy+GBX4y1Wa3htwSwC12kXkmUerApqKC6Ny5DCZT54Nw+5vlDEDCO09
	 P7QD4EkID3vQjBbWVSIUBXieiyu2V7SFsu/N1W6b8xJG57j2tHIhJXm4LgZTCDcCFxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k8hYkPZm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239CF606A326;
	Thu,  5 Nov 2026 21:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k8hYkPZm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8151C1F008A1;
	Thu,  5 Nov 2026 21:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914386;
	bh=m7GxaMyT1RDDZjvYUJ0P1FPXnvCLADlxook/8V9dsi8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=k8hYkPZm2/pNrZ7EGT5yfX1hDqkfbsiN5BZQAc2alxhZN/lO2EIADVG1XZZszS2Mm
	 wPm8qPwfKSjXE8ccdOrrhF/5qV9Ihrlkg6W1gXymeRMxbacxWePAzLTmTTTV7pL/yi
	 fJMX/FMrz82+OboTjaVsB5vXJ64A96eA4XLSV/z914xzmGvQdZIPkJTL6WPxqXmqpL
	 lfF1+qnBw3S5+53BBL+/xcxy+q+sUoZjHkaps5OG2W/QOMJBWiIDxCsBg3pAvKRrJo
	 gUyWzSb/72LF5NGz71qtcXALC/C+7CGw8ijhXRkAUE0qP6azBge/ey+mLe0scRvKMF
	 2v7rVxyxRR19w==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 05 Nov 2026 21:30:56 +0000
Subject: [PATCH 05/13] mm: convert THP VMA flag tests to use vma_flags_t
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
Message-Id: <20261105-late-2026-vma-flags-v1-5-0d3cd15ab75f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6667; i=ljs@kernel.org;
 h=from:subject:message-id; bh=+McSI8JCXbJ4PzexpVY3WU43TmwTyEjeJI5zg9kZGWw=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLefF0Wsdj93LoFi5b56wudeiIyh6nvw08l7tB7nce9M
 iytTp5Q7ChlYRDjYpAVU2R5/kV8f5BI2LzOC/5uMHNYmUCGMHBxCsBElsQw/A+7Gvc3UvOikrbK
 yiMsMYfmH1aP43h5dkfn/AI9EdEb7DcY/gpdm7eOZdH/ewou/jEzt1+M/mz5qILXzdOpX0tL6vy
 99cwA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Replace use of the legacy vm_flags_t flags with vma_flags_t values where
VMA flags are tested directly in the THP and khugepaged logic.

The thp_vma_allowable_orders() family of functions, hugepage_madvise() and
khugepaged_enter_vma() continue to take legacy flags for the time being.

Also update BUG_ON()'s to VM_WARN_ON_ONCE() while here.

No functional change intended.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/huge_memory.c | 32 ++++++++++++++++----------------
 mm/khugepaged.c  |  8 +++++---
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 7e589a2fb02d..764e693b422f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1257,7 +1257,7 @@ __setup("thp_anon=", setup_thp_anon);
 
 pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma)
 {
-	if (likely(vma->vm_flags & VM_WRITE))
+	if (likely(vma_test(vma, VMA_WRITE_BIT)))
 		pmd = pmd_mkwrite(pmd, vma);
 	return pmd;
 }
@@ -1517,7 +1517,7 @@ vm_fault_t do_huge_pmd_device_private(struct vm_fault *vmf)
  */
 gfp_t vma_thp_gfp_mask(struct vm_area_struct *vma)
 {
-	const bool vma_madvised = vma && (vma->vm_flags & VM_HUGEPAGE);
+	const bool vma_madvised = vma && vma_test(vma, VMA_HUGEPAGE_BIT);
 
 	/* Always do synchronous compaction */
 	if (test_bit(TRANSPARENT_HUGEPAGE_DEFRAG_DIRECT_FLAG, &transparent_hugepage_flags))
@@ -1716,10 +1716,9 @@ vm_fault_t vmf_insert_pfn_pmd(struct vm_fault *vmf, unsigned long pfn,
 	 * but we need to be consistent with PTEs and architectures that
 	 * can't support a 'special' bit.
 	 */
-	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)));
-	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
-						(VM_PFNMAP|VM_MIXEDMAP));
-	BUG_ON((vma->vm_flags & VM_PFNMAP) && vma_is_cow_mapping(vma));
+	VM_WARN_ON_ONCE(!vma_test_any(vma, VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT));
+	VM_WARN_ON_ONCE(vma_test_all(vma, VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT));
+	VM_WARN_ON_ONCE(vma_test(vma, VMA_PFNMAP_BIT) && vma_is_cow_mapping(vma));
 
 	if (unlikely(is_huge_zero_pfn(pfn)))
 		return VM_FAULT_SIGBUS;
@@ -1750,7 +1749,7 @@ EXPORT_SYMBOL_GPL(vmf_insert_folio_pmd);
 #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 static pud_t maybe_pud_mkwrite(pud_t pud, struct vm_area_struct *vma)
 {
-	if (likely(vma->vm_flags & VM_WRITE))
+	if (likely(vma_test(vma, VMA_WRITE_BIT)))
 		pud = pud_mkwrite(pud);
 	return pud;
 }
@@ -1827,10 +1826,9 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, unsigned long pfn,
 	 * but we need to be consistent with PTEs and architectures that
 	 * can't support a 'special' bit.
 	 */
-	BUG_ON(!(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)));
-	BUG_ON((vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP)) ==
-						(VM_PFNMAP|VM_MIXEDMAP));
-	BUG_ON((vma->vm_flags & VM_PFNMAP) && vma_is_cow_mapping(vma));
+	VM_WARN_ON_ONCE(!vma_test_any(vma, VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT));
+	VM_WARN_ON_ONCE(vma_test_all(vma, VMA_PFNMAP_BIT, VMA_MIXEDMAP_BIT));
+	VM_WARN_ON_ONCE(vma_test(vma, VMA_PFNMAP_BIT) && vma_is_cow_mapping(vma));
 
 	pfnmap_setup_cachemode_pfn(pfn, &pgprot);
 
@@ -2262,7 +2260,7 @@ static inline bool can_change_pmd_writable(struct vm_area_struct *vma,
 {
 	struct page *page;
 
-	if (WARN_ON_ONCE(!(vma->vm_flags & VM_WRITE)))
+	if (WARN_ON_ONCE(!vma_test(vma, VMA_WRITE_BIT)))
 		return false;
 
 	/* Don't touch entries that are not even readable (NUMA hinting). */
@@ -2277,7 +2275,7 @@ static inline bool can_change_pmd_writable(struct vm_area_struct *vma,
 	if (userfaultfd_huge_pmd_wp(vma, pmd))
 		return false;
 
-	if (!(vma->vm_flags & VM_SHARED)) {
+	if (!vma_test(vma, VMA_SHARED_BIT)) {
 		/* See can_change_pte_writable(). */
 		page = vm_normal_page_pmd(vma, addr, pmd);
 		return page && PageAnon(page) && PageAnonExclusive(page);
@@ -3568,7 +3566,8 @@ static bool __discard_anon_folio_pmd_locked(struct vm_area_struct *vma,
 
 	if (pmd_dirty(orig_pmd))
 		folio_set_dirty(folio);
-	if (folio_test_dirty(folio) && !(vma->vm_flags & VM_DROPPABLE)) {
+	if (folio_test_dirty(folio) &&
+	    !vma_test_single_mask(vma, VMA_DROPPABLE)) {
 		folio_set_swapbacked(folio);
 		return false;
 	}
@@ -3600,7 +3599,8 @@ static bool __discard_anon_folio_pmd_locked(struct vm_area_struct *vma,
 	 */
 	if (pmd_dirty(orig_pmd))
 		folio_set_dirty(folio);
-	if (folio_test_dirty(folio) && !(vma->vm_flags & VM_DROPPABLE)) {
+	if (folio_test_dirty(folio) &&
+	    !vma_test_single_mask(vma, VMA_DROPPABLE)) {
 		folio_set_swapbacked(folio);
 		set_pmd_at(mm, addr, pmdp, orig_pmd);
 		return false;
@@ -3614,7 +3614,7 @@ static bool __discard_anon_folio_pmd_locked(struct vm_area_struct *vma,
 	folio_remove_rmap_pmd(folio, pmd_page(orig_pmd), vma);
 	zap_deposited_table(mm, pmdp);
 	add_mm_counter(mm, MM_ANONPAGES, -HPAGE_PMD_NR);
-	if (vma->vm_flags & VM_LOCKED)
+	if (vma_test(vma, VMA_LOCKED_BIT))
 		mlock_drain_local();
 	folio_put(folio);
 
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 0d3bd9e23613..a2c7c6a0768d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -640,7 +640,8 @@ static enum scan_result __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		 * If the vma has the VM_DROPPABLE flag, the collapse will
 		 * preserve the lazyfree property without needing to skip.
 		 */
-		if (cc->policy.anon_skip_lazyfree && !(vma->vm_flags & VM_DROPPABLE) &&
+		if (cc->policy.anon_skip_lazyfree &&
+		    !vma_test_single_mask(vma, VMA_DROPPABLE) &&
 		    folio_test_lazyfree(folio) && !pte_dirty(pteval)) {
 			result = SCAN_PAGE_LAZYFREE;
 			goto out;
@@ -1683,7 +1684,8 @@ static enum scan_result collapse_scan_anon(struct vm_area_struct *vma,
 		 * If the vma has the VM_DROPPABLE flag, the collapse will
 		 * preserve the lazyfree property without needing to skip.
 		 */
-		if (cc->policy.anon_skip_lazyfree && !(vma->vm_flags & VM_DROPPABLE) &&
+		if (cc->policy.anon_skip_lazyfree &&
+		    !vma_test_single_mask(vma, VMA_DROPPABLE) &&
 		    folio_test_lazyfree(folio) && !pte_dirty(pteval)) {
 			result = SCAN_PAGE_LAZYFREE;
 			failed_pfn = folio_pfn(folio);
@@ -1948,7 +1950,7 @@ static enum scan_result try_collapse_pte_mapped_thp(struct mm_struct *mm, unsign
 	 * So page lock of folio does not protect from it, so we must not drop
 	 * ptl before pgt_pmd is removed, so uffd private needs pml taken now.
 	 */
-	if (userfaultfd_armed(vma) && !(vma->vm_flags & VM_SHARED))
+	if (userfaultfd_armed(vma) && !vma_test(vma, VMA_SHARED_BIT))
 		pml = pmd_lock(mm, pmd);
 
 	start_pte = pte_offset_map_rw_nolock(mm, pmd, haddr, &pgt_pmd, &ptl);

-- 
2.56.0

