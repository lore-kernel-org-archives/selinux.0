Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914423;
	b=zw+f4eeso7Hz8ZyI0GOanWEm7pXU93NcHaWt9cPVJCJ/Hbpn3ivG1odP2Rzlywr+keKw
	 OZqkfBVi+MHk3/TDFxrubEPG6tN9uqa1Y55vbKS0PooVXtCP7LgtaksEtIpcodAi8RqYg
	 ZlCy4eOk5lxQYzmW2hTvFsCmqGKGzpv3jzqRcQFFxToFvtQPzhp/7xoHgYLbArctdvH6R
	 nRlmO8zEvtyciIolb1Yw6z5HAu/4qPNgJG4A4G3Tew9ZSsGbnwOa38bsLfIRPQgSYQD9e
	 5IDkqHYhBWx/8ZbxXc/ZNsNX4QesbHnkYr6ElrgZ7S6/pM2vScAT6QHx3VI09RGaBfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914423;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=gyrnE3StgLLppWu/w1Zj17hP7uByeqDos0uxgrgtFTA=;
	b=udrAldbrdPXEJmAgIiMzyO1hhtJMxuW9WL9aHBIP+ryJ9nkNkKvrmlnPzqHxS+/avqfx
	 b4pFyNYzmW2PIPS0rGy7he8d7xzZ7U72X5vFAAVHlW4vFo5GnFgG+TeMfnAMqBT9vsxJX
	 LUzChdS6w3F6BquEFW+OoQ2hW0SK/gAnnyK5Dx8RnrrBnoXHJ35Uo1ZjfocaRGBo3e7TD
	 UdyGTjSqmWugL6Y6nlnfHtVI5UuKXV6yW948KDbiJB1ErqU9XdP9yIW6OvO+POGhjQ59Z
	 R7vVw6EgK69LcbXCv/KEe640+uqTpx64yHJfYKYV5kVaXkhOKkc5RYJwQ8WZIDpTlOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KySY8v2i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAF2606A32F;
	Thu,  5 Nov 2026 21:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KySY8v2i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D671F008A1;
	Thu,  5 Nov 2026 21:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914422;
	bh=gyrnE3StgLLppWu/w1Zj17hP7uByeqDos0uxgrgtFTA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KySY8v2iVhfX9XmbTPAjoWpOOoStWED32L7geLQedlTOyfzMD821GXDji/aJCs91g
	 GE8VHZVMMVt/9EWB8gvZ5QAV6M4Z8iZR14JLegw1HBtpVJgLZ5Jpb4hMmqakv1Y8T2
	 J3W5SsZkG/h+7dKRemngAdJ3V/UP7xZB5c7W0tHxe0mFmCt2L1lY6n1FLqMlmr8fjb
	 dlwVMuAoXSETJY8PhQeJD3cLsp2RZPxziTCNm1xbZlA6IW74JIdogIzyyvk4cA3/EF
	 y86X8Znr4mh554QczMFTDr8quuZWaBCF6FnwzkKy6LGfdMFrUxD0Cgb4a06kpFL8tY
	 gDS0kcAmCGaJQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Thu, 05 Nov 2026 21:30:58 +0000
Subject: [PATCH 07/13] mm/madvise: convert madvise_vma_behavior() to use
 vma_flags_t
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
Message-Id: <20261105-late-2026-vma-flags-v1-7-0d3cd15ab75f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12147; i=ljs@kernel.org;
 h=from:subject:message-id; bh=Jdvn0Mgw7BMpf0cKP+Qll9Jkd0pYJBC/PPvElQfebXM=;
 b=kA0DAAoWz53NioHifxQByyZiAGrs9abIgvJwzGlQITkHdubFSSRXaihhRLrSArEFYrZS/HaXj
 oh1BAAWCgAdFiEE5/QXv1IUVp6J0E9Gz53NioHifxQFAmrs9aYACgkQz53NioHifxRgHQEA6api
 67rJLIqE4CJNZkb1wCotipiVVf+Y7cQRsloF324BAJySN92AsF7wdvZU0Uz+sIXE9jnIvs3DoCC
 tXc+5oysF
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Replace use of the legacy vm_flags_t flags with vma_flags_t values
throughout the madvise logic.

In order to do so, update ksm_madvise() and hugepage_madvise() to take a
vma_flags_t pointer, and update their other callers in mremap and the
powerpc KVM ultravisor code accordingly.

In the latter case we replace vm_flags_reset() with vma_overwrite_flags().
The VMA is write locked at this point, so the atomic flags preserved by
vma_overwrite_flags() cannot differ from those copied, and the behaviour
is unchanged.

No functional change intended.

Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 arch/powerpc/kvm/book3s_hv_uvmem.c | 10 ++++----
 include/linux/huge_mm.h            |  4 ++--
 include/linux/ksm.h                |  4 ++--
 mm/khugepaged.c                    | 10 ++++----
 mm/ksm.c                           | 11 +++++----
 mm/madvise.c                       | 47 ++++++++++++++++++++------------------
 mm/mremap.c                        |  2 +-
 7 files changed, 46 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index 463aef870c4e..0fa50bee2ffc 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -393,7 +393,7 @@ static int kvmppc_memslot_page_merge(struct kvm *kvm,
 {
 	unsigned long gfn = memslot->base_gfn;
 	unsigned long end, start = gfn_to_hva(kvm, gfn);
-	vm_flags_t vm_flags;
+	vma_flags_t vma_flags;
 	int ret = 0;
 	struct vm_area_struct *vma;
 	int merge_flag = (merge) ? MADV_MERGEABLE : MADV_UNMERGEABLE;
@@ -411,15 +411,15 @@ static int kvmppc_memslot_page_merge(struct kvm *kvm,
 			break;
 		}
 		vma_start_write(vma);
-		/* Copy vm_flags to avoid partial modifications in ksm_madvise */
-		vm_flags = vma->vm_flags;
+		/* Copy flags to avoid partial modifications in ksm_madvise */
+		vma_flags = vma->flags;
 		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
-			  merge_flag, &vm_flags);
+			  merge_flag, &vma_flags);
 		if (ret) {
 			ret = H_STATE;
 			break;
 		}
-		vm_flags_reset(vma, vm_flags);
+		vma_overwrite_flags(vma, vma_flags);
 		start = vma->vm_end;
 	} while (end > vma->vm_end);
 
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index c745f7ad2298..8b6f4101eabf 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -508,7 +508,7 @@ change_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			__split_huge_pud(__vma, __pud, __address);	\
 	}  while (0)
 
-int hugepage_madvise(struct vm_area_struct *vma, vm_flags_t *vm_flags,
+int hugepage_madvise(struct vm_area_struct *vma, vma_flags_t *vma_flags,
 		     int advice);
 int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end, bool *lock_dropped);
@@ -710,7 +710,7 @@ static inline bool unmap_huge_pmd_locked(struct vm_area_struct *vma,
 	do { } while (0)
 
 static inline int hugepage_madvise(struct vm_area_struct *vma,
-				   vm_flags_t *vm_flags, int advice)
+				   vma_flags_t *vma_flags, int advice)
 {
 	return -EINVAL;
 }
diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index d39d0d5483a2..1ffc69a72a1a 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -16,7 +16,7 @@
 
 #ifdef CONFIG_KSM
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
-		unsigned long end, int advice, vm_flags_t *vm_flags);
+		unsigned long end, int advice, vma_flags_t *vma_flags);
 vma_flags_t ksm_vma_flags(struct mm_struct *mm, const struct file *file,
 			  vma_flags_t vma_flags);
 int ksm_enable_merge_any(struct mm_struct *mm);
@@ -139,7 +139,7 @@ static inline void collect_procs_ksm(const struct folio *folio,
 
 #ifdef CONFIG_MMU
 static inline int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
-		unsigned long end, int advice, vm_flags_t *vm_flags)
+		unsigned long end, int advice, vma_flags_t *vma_flags)
 {
 	return 0;
 }
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a2c7c6a0768d..be1f779c8da5 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -363,16 +363,16 @@ static unsigned int collapse_max_ptes_swap(struct collapse_control *cc,
 }
 
 int hugepage_madvise(struct vm_area_struct *vma,
-		     vm_flags_t *vm_flags, int advice)
+		     vma_flags_t *vma_flags, int advice)
 {
 	switch (advice) {
 	case MADV_HUGEPAGE:
-		*vm_flags &= ~VM_NOHUGEPAGE;
-		*vm_flags |= VM_HUGEPAGE;
+		vma_flags_clear(vma_flags, VMA_NOHUGEPAGE_BIT);
+		vma_flags_set(vma_flags, VMA_HUGEPAGE_BIT);
 		break;
 	case MADV_NOHUGEPAGE:
-		*vm_flags &= ~VM_HUGEPAGE;
-		*vm_flags |= VM_NOHUGEPAGE;
+		vma_flags_clear(vma_flags, VMA_HUGEPAGE_BIT);
+		vma_flags_set(vma_flags, VMA_NOHUGEPAGE_BIT);
 		/*
 		 * Setting VM_NOHUGEPAGE will prevent khugepaged from scanning
 		 * this vma even if we leave the mm registered in khugepaged if
diff --git a/mm/ksm.c b/mm/ksm.c
index 61b772bba229..3eb9c1ec2f87 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -779,7 +779,8 @@ static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
 	if (ksm_test_exit(mm))
 		return NULL;
 	vma = vma_lookup(mm, addr);
-	if (!vma || !vma_test(vma, VMA_MERGEABLE_BIT) || !vma_has_anon_rmap(vma))
+	if (!vma || !vma_test(vma, VMA_MERGEABLE_BIT) ||
+	    !vma_has_anon_rmap(vma))
 		return NULL;
 	return vma;
 }
@@ -3021,7 +3022,7 @@ int ksm_disable(struct mm_struct *mm)
 }
 
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
-		unsigned long end, int advice, vm_flags_t *vm_flags)
+		unsigned long end, int advice, vma_flags_t *vma_flags)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	int err;
@@ -3039,11 +3040,11 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 				return err;
 		}
 
-		*vm_flags |= VM_MERGEABLE;
+		vma_flags_set(vma_flags, VMA_MERGEABLE_BIT);
 		break;
 
 	case MADV_UNMERGEABLE:
-		if (!(*vm_flags & VM_MERGEABLE))
+		if (!vma_flags_test(vma_flags, VMA_MERGEABLE_BIT))
 			return 0;		/* just ignore the advice */
 
 		if (vma_has_anon_rmap(vma)) {
@@ -3052,7 +3053,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 				return err;
 		}
 
-		*vm_flags &= ~VM_MERGEABLE;
+		vma_flags_clear(vma_flags, VMA_MERGEABLE_BIT);
 		break;
 	}
 
diff --git a/mm/madvise.c b/mm/madvise.c
index e9fa4f71efea..1b539e67b00d 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -148,11 +148,10 @@ static int replace_anon_vma_name(struct vm_area_struct *vma,
  * Update the vm_flags or anon_name on region of a vma, splitting it or merging
  * it as necessary. Must be called with mmap_lock held for writing.
  */
-static int madvise_update_vma(vm_flags_t new_flags,
+static int madvise_update_vma(vma_flags_t new_vma_flags,
 		struct madvise_behavior *madv_behavior)
 {
 	struct vm_area_struct *vma = madv_behavior->vma;
-	vma_flags_t new_vma_flags = legacy_to_vma_flags(new_flags);
 	struct madvise_behavior_range *range = &madv_behavior->range;
 	struct anon_vma_name *anon_name = madv_behavior->anon_name;
 	bool set_new_anon_name = madv_behavior->behavior == __MADV_SET_ANON_VMA_NAME;
@@ -601,7 +600,8 @@ static void madvise_cold_page_range(struct mmu_gather *tlb,
 
 static inline bool can_madv_lru_vma(struct vm_area_struct *vma)
 {
-	return !(vma->vm_flags & (VM_LOCKED|VM_PFNMAP|VM_HUGETLB));
+	return !vma_test_any(vma, VMA_LOCKED_BIT, VMA_PFNMAP_BIT,
+			     VMA_HUGETLB_BIT);
 }
 
 static long madvise_cold(struct madvise_behavior *madv_behavior)
@@ -650,7 +650,7 @@ static long madvise_pageout(struct madvise_behavior *madv_behavior)
 	 * further to pageout dirty anon pages.
 	 */
 	if (!vma_is_anonymous(vma) && (!can_do_file_pageout(vma) &&
-				(vma->vm_flags & VM_MAYSHARE)))
+				vma_test(vma, VMA_MAYSHARE_BIT)))
 		return 0;
 
 	lru_add_drain();
@@ -881,12 +881,12 @@ bool madvise_dontneed_free_valid_vma(struct madvise_behavior *madv_behavior)
 	struct madvise_behavior_range *range = &madv_behavior->range;
 
 	if (!vma_is_hugetlb(vma)) {
-		unsigned int forbidden = VM_PFNMAP;
+		vma_flags_t forbidden = mk_vma_flags(VMA_PFNMAP_BIT);
 
 		if (behavior != MADV_DONTNEED_LOCKED)
-			forbidden |= VM_LOCKED;
+			vma_flags_set(&forbidden, VMA_LOCKED_BIT);
 
-		return !(vma->vm_flags & forbidden);
+		return !vma_test_any_mask(vma, forbidden);
 	}
 
 	if (behavior != MADV_DONTNEED && behavior != MADV_DONTNEED_LOCKED)
@@ -1021,7 +1021,7 @@ static long madvise_remove(struct madvise_behavior *madv_behavior)
 
 	mark_mmap_lock_dropped(madv_behavior);
 
-	if (vma->vm_flags & VM_LOCKED)
+	if (vma_test(vma, VMA_LOCKED_BIT))
 		return -EINVAL;
 
 	f = vma->vm_file;
@@ -1333,7 +1333,7 @@ static bool can_madvise_modify(struct madvise_behavior *madv_behavior)
 		return true;
 
 	/* If the user could write to the mapping anyway, then this is fine. */
-	if ((vma->vm_flags & VM_WRITE) &&
+	if (vma_test(vma, VMA_WRITE_BIT) &&
 	    arch_vma_access_permitted(vma, /* write= */ true,
 			/* execute= */ false, /* foreign= */ false))
 		return true;
@@ -1357,7 +1357,7 @@ static int madvise_vma_behavior(struct madvise_behavior *madv_behavior)
 {
 	int behavior = madv_behavior->behavior;
 	struct vm_area_struct *vma = madv_behavior->vma;
-	vm_flags_t new_flags = vma->vm_flags;
+	vma_flags_t new_flags = vma->flags;
 	struct madvise_behavior_range *range = &madv_behavior->range;
 	int error;
 
@@ -1388,44 +1388,47 @@ static int madvise_vma_behavior(struct madvise_behavior *madv_behavior)
 	/* The below behaviours update VMAs via madvise_update_vma(). */
 
 	case MADV_NORMAL:
-		new_flags = new_flags & ~VM_RAND_READ & ~VM_SEQ_READ;
+		vma_flags_clear(&new_flags, VMA_RAND_READ_BIT,
+				VMA_SEQ_READ_BIT);
 		break;
 	case MADV_SEQUENTIAL:
-		new_flags = (new_flags & ~VM_RAND_READ) | VM_SEQ_READ;
+		vma_flags_clear(&new_flags, VMA_RAND_READ_BIT);
+		vma_flags_set(&new_flags, VMA_SEQ_READ_BIT);
 		break;
 	case MADV_RANDOM:
-		new_flags = (new_flags & ~VM_SEQ_READ) | VM_RAND_READ;
+		vma_flags_clear(&new_flags, VMA_SEQ_READ_BIT);
+		vma_flags_set(&new_flags, VMA_RAND_READ_BIT);
 		break;
 	case MADV_DONTFORK:
-		new_flags |= VM_DONTCOPY;
+		vma_flags_set(&new_flags, VMA_DONTCOPY_BIT);
 		break;
 	case MADV_DOFORK:
 		if (!vma_is_mm_backed(vma) || vma_is_hugetlb(vma))
 			return -EINVAL;
-		new_flags &= ~VM_DONTCOPY;
+		vma_flags_clear(&new_flags, VMA_DONTCOPY_BIT);
 		break;
 	case MADV_WIPEONFORK:
 		/* MADV_WIPEONFORK is only supported on anonymous memory. */
-		if (vma->vm_file || new_flags & VM_SHARED)
+		if (vma->vm_file || vma_flags_test(&new_flags, VMA_SHARED_BIT))
 			return -EINVAL;
-		new_flags |= VM_WIPEONFORK;
+		vma_flags_set(&new_flags, VMA_WIPEONFORK_BIT);
 		break;
 	case MADV_KEEPONFORK:
-		if (new_flags & VM_DROPPABLE)
+		if (vma_flags_test_single_mask(&new_flags, VMA_DROPPABLE))
 			return -EINVAL;
-		new_flags &= ~VM_WIPEONFORK;
+		vma_flags_clear(&new_flags, VMA_WIPEONFORK_BIT);
 		break;
 	case MADV_DONTDUMP:
-		new_flags |= VM_DONTDUMP;
+		vma_flags_set(&new_flags, VMA_DONTDUMP_BIT);
 		break;
 	case MADV_DODUMP:
 		/* Only mm-backed memory can be meaningfully dumped. */
 		if (!vma_is_mm_backed(vma))
 			return -EINVAL;
 		/* Core mm may discard droppable memory at any time. */
-		if (new_flags & VM_DROPPABLE)
+		if (vma_flags_test_single_mask(&new_flags, VMA_DROPPABLE))
 			return -EINVAL;
-		new_flags &= ~VM_DONTDUMP;
+		vma_flags_clear(&new_flags, VMA_DONTDUMP_BIT);
 		break;
 	case MADV_MERGEABLE:
 	case MADV_UNMERGEABLE:
diff --git a/mm/mremap.c b/mm/mremap.c
index 0d06d7f37f19..5f4e7d1ce3b7 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1133,7 +1133,7 @@ static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
 	struct vm_area_struct *vma = vrm->vma;
 	unsigned long old_addr = vrm->addr;
 	unsigned long old_len = vrm->old_len;
-	vm_flags_t dummy = vma->vm_flags;
+	vma_flags_t dummy = vma->flags;
 	const bool split_before = vma->vm_start != old_addr;
 	const bool split_after = vma->vm_end != old_addr + old_len;
 

-- 
2.56.0

