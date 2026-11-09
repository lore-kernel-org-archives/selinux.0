Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231907;
	b=H6pJCI7jNlcEpnZ1vPWzyAFaa7gkOBtkTaKLIdE15oTahuB8jmem6NCtrH5iEemCjQb/
	 AJkPi9PwzDoCc6/uNSDvDmBMrnVAqsEDz5lmHjRMpsNHSYbsMa0oyfBxebA3tM8hSnmHU
	 L7WxjEg7xrABwFpQWpmZcUButm+7/HD4CxWPNGEFBmrT5B2476yIEf8vGivYnX39++Msi
	 mTM+P4bomee38acOslTUVRbuCVKIaQLslML4UtAoBAWCXOsKlV9h0paa0D7EwL6Tbm+I8
	 jYQs0tXwQQd8n6vgU1w6rQ6b9QERamUb7S0b/rT27X5wKl9Ovr4IaohkYjJ0AQBOdUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231907;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=SjhNGKAFa/LGrtAPePCfHjw2jptgU6AWjXk819xv4y0=;
	b=fySqSUz65Zfm5mMH+ltjqvVlk+MgNo+Q6rOKqs/ttBoxsF4inkiMXsF5Inay3B8oT81N
	 9RdegqnCzsd4nRd2mfDBafP4i+AvnV0J/zpawKeajXb3rhdbaT1W2TT9w/qE6lQ7BrL5n
	 0TayA4OuutGE4c1yS6VQhnO5Nn7zPXYQYbwLK8z1TR4FX7XfTpJ+gkyh/YEOcTrEOteMg
	 xIjbsqENJiuLBKkXRjYpWKMRUBHMz1e+L8qyMvBGYSnh+R3zGI5rUQUPiXJ4Bu5FNMd5v
	 zFA2ceQrpwoKBXHa77ml+SPL+QJ0hybhf9Ml2sghRaoFDgUDX36R+MCFCZjxMXV1Q+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gz5j+IRt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656FC606A337;
	Mon,  9 Nov 2026 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gz5j+IRt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F641F008A1;
	Mon,  9 Nov 2026 13:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794231906;
	bh=SjhNGKAFa/LGrtAPePCfHjw2jptgU6AWjXk819xv4y0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gz5j+IRt16UMA6Uf8i7EiWjJIBV4vUN9Xy0DKD3/t3wCmxXemR+4mZb4wvMKa+MmX
	 f5HAwCJPOHi3ECi2nnYFk4cj5S/zAPOZ2LN9cK/+ZjkYO2qsnmOqFygzSsugJjLhqm
	 XGRy5hq8F0U4PLasq04Uo0A8njicFtwJd+tVw9S5/oDT+gwbYpzSWYp9+YFgcFxTSP
	 lY7NQStpmvJvsKMIHeFroSHfXp3NwGG0it00SCNdbhEez/eZikwWMazkfHuz+638K3
	 clgUGputwUFM5yxXtCj0F3eWtXusMjSAYPVemwnv/PNJjY3t4VgVd157Fgzi20jQkR
	 WpW6XsNlxhqFw==
Message-ID: <ac29cf71-a1af-4ce7-96c3-aea5a771979a@kernel.org>
Date: Mon, 9 Nov 2026 14:44:40 +0100
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] mm/madvise: convert madvise_vma_behavior() to use
 vma_flags_t
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
 Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
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
 Christian Brauner <brauner@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>, John Johansen
 <john.johansen@canonical.com>, Georgia Garcia
 <georgia.garcia@canonical.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, damon@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-7-0d3cd15ab75f@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261105-late-2026-vma-flags-v1-7-0d3cd15ab75f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/26 22:30, Lorenzo Stoakes (ARM) wrote:
> Replace use of the legacy vm_flags_t flags with vma_flags_t values
> throughout the madvise logic.
> 
> In order to do so, update ksm_madvise() and hugepage_madvise() to take a
> vma_flags_t pointer, and update their other callers in mremap and the
> powerpc KVM ultravisor code accordingly.
> 
> In the latter case we replace vm_flags_reset() with vma_overwrite_flags().
> The VMA is write locked at this point, so the atomic flags preserved by
> vma_overwrite_flags() cannot differ from those copied, and the behaviour
> is unchanged.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  arch/powerpc/kvm/book3s_hv_uvmem.c | 10 ++++----
>  include/linux/huge_mm.h            |  4 ++--
>  include/linux/ksm.h                |  4 ++--
>  mm/khugepaged.c                    | 10 ++++----
>  mm/ksm.c                           | 11 +++++----
>  mm/madvise.c                       | 47 ++++++++++++++++++++------------------
>  mm/mremap.c                        |  2 +-
>  7 files changed, 46 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
> index 463aef870c4e..0fa50bee2ffc 100644
> --- a/arch/powerpc/kvm/book3s_hv_uvmem.c
> +++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
> @@ -393,7 +393,7 @@ static int kvmppc_memslot_page_merge(struct kvm *kvm,
>  {
>  	unsigned long gfn = memslot->base_gfn;
>  	unsigned long end, start = gfn_to_hva(kvm, gfn);
> -	vm_flags_t vm_flags;
> +	vma_flags_t vma_flags;
>  	int ret = 0;
>  	struct vm_area_struct *vma;
>  	int merge_flag = (merge) ? MADV_MERGEABLE : MADV_UNMERGEABLE;
> @@ -411,15 +411,15 @@ static int kvmppc_memslot_page_merge(struct kvm *kvm,
>  			break;
>  		}
>  		vma_start_write(vma);
> -		/* Copy vm_flags to avoid partial modifications in ksm_madvise */
> -		vm_flags = vma->vm_flags;
> +		/* Copy flags to avoid partial modifications in ksm_madvise */
> +		vma_flags = vma->flags;
>  		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
> -			  merge_flag, &vm_flags);
> +			  merge_flag, &vma_flags);

Unusual indentation (before your change).

>  		if (ret) {
>  			ret = H_STATE;
>  			break;
>  		}
> -		vm_flags_reset(vma, vm_flags);
> +		vma_overwrite_flags(vma, vma_flags);
>  		start = vma->vm_end;
>  	} while (end > vma->vm_end);
>  
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index c745f7ad2298..8b6f4101eabf 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -508,7 +508,7 @@ change_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  			__split_huge_pud(__vma, __pud, __address);	\
>  	}  while (0)
>  
> -int hugepage_madvise(struct vm_area_struct *vma, vm_flags_t *vm_flags,
> +int hugepage_madvise(struct vm_area_struct *vma, vma_flags_t *vma_flags,
>  		     int advice);
>  int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>  		     unsigned long end, bool *lock_dropped);
> @@ -710,7 +710,7 @@ static inline bool unmap_huge_pmd_locked(struct vm_area_struct *vma,
>  	do { } while (0)
>  
>  static inline int hugepage_madvise(struct vm_area_struct *vma,
> -				   vm_flags_t *vm_flags, int advice)
> +				   vma_flags_t *vma_flags, int advice)

Could do two tabs while at it.

>  {
>  	return -EINVAL;
>  }
> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
> index d39d0d5483a2..1ffc69a72a1a 100644
> --- a/include/linux/ksm.h
> +++ b/include/linux/ksm.h
> @@ -16,7 +16,7 @@
>  
>  #ifdef CONFIG_KSM
>  int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
> -		unsigned long end, int advice, vm_flags_t *vm_flags);
> +		unsigned long end, int advice, vma_flags_t *vma_flags);
>  vma_flags_t ksm_vma_flags(struct mm_struct *mm, const struct file *file,
>  			  vma_flags_t vma_flags);
>  int ksm_enable_merge_any(struct mm_struct *mm);
> @@ -139,7 +139,7 @@ static inline void collect_procs_ksm(const struct folio *folio,
>  
>  #ifdef CONFIG_MMU
>  static inline int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
> -		unsigned long end, int advice, vm_flags_t *vm_flags)
> +		unsigned long end, int advice, vma_flags_t *vma_flags)
>  {
>  	return 0;
>  }
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index a2c7c6a0768d..be1f779c8da5 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -363,16 +363,16 @@ static unsigned int collapse_max_ptes_swap(struct collapse_control *cc,
>  }
>  
>  int hugepage_madvise(struct vm_area_struct *vma,
> -		     vm_flags_t *vm_flags, int advice)
> +		     vma_flags_t *vma_flags, int advice)
>  {
>  	switch (advice) {
>  	case MADV_HUGEPAGE:
> -		*vm_flags &= ~VM_NOHUGEPAGE;
> -		*vm_flags |= VM_HUGEPAGE;
> +		vma_flags_clear(vma_flags, VMA_NOHUGEPAGE_BIT);
> +		vma_flags_set(vma_flags, VMA_HUGEPAGE_BIT);
>  		break;
>  	case MADV_NOHUGEPAGE:
> -		*vm_flags &= ~VM_HUGEPAGE;
> -		*vm_flags |= VM_NOHUGEPAGE;
> +		vma_flags_clear(vma_flags, VMA_HUGEPAGE_BIT);
> +		vma_flags_set(vma_flags, VMA_NOHUGEPAGE_BIT);
>  		/*
>  		 * Setting VM_NOHUGEPAGE will prevent khugepaged from scanning
>  		 * this vma even if we leave the mm registered in khugepaged if
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 61b772bba229..3eb9c1ec2f87 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -779,7 +779,8 @@ static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
>  	if (ksm_test_exit(mm))
>  		return NULL;
>  	vma = vma_lookup(mm, addr);
> -	if (!vma || !vma_test(vma, VMA_MERGEABLE_BIT) || !vma_has_anon_rmap(vma))
> +	if (!vma || !vma_test(vma, VMA_MERGEABLE_BIT) ||
> +	    !vma_has_anon_rmap(vma))
>  		return NULL;
>  	return vma;
>  }
> @@ -3021,7 +3022,7 @@ int ksm_disable(struct mm_struct *mm)
>  }
>  
>  int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
> -		unsigned long end, int advice, vm_flags_t *vm_flags)
> +		unsigned long end, int advice, vma_flags_t *vma_flags)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
>  	int err;
> @@ -3039,11 +3040,11 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
>  				return err;
>  		}
>  
> -		*vm_flags |= VM_MERGEABLE;
> +		vma_flags_set(vma_flags, VMA_MERGEABLE_BIT);
>  		break;
>  
>  	case MADV_UNMERGEABLE:
> -		if (!(*vm_flags & VM_MERGEABLE))
> +		if (!vma_flags_test(vma_flags, VMA_MERGEABLE_BIT))
>  			return 0;		/* just ignore the advice */
>  
>  		if (vma_has_anon_rmap(vma)) {
> @@ -3052,7 +3053,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
>  				return err;
>  		}
>  
> -		*vm_flags &= ~VM_MERGEABLE;
> +		vma_flags_clear(vma_flags, VMA_MERGEABLE_BIT);
>  		break;
>  	}
>  
> diff --git a/mm/madvise.c b/mm/madvise.c
> index e9fa4f71efea..1b539e67b00d 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -148,11 +148,10 @@ static int replace_anon_vma_name(struct vm_area_struct *vma,
>   * Update the vm_flags or anon_name on region of a vma, splitting it or merging
>   * it as necessary. Must be called with mmap_lock held for writing.
>   */
> -static int madvise_update_vma(vm_flags_t new_flags,
> +static int madvise_update_vma(vma_flags_t new_vma_flags,
>  		struct madvise_behavior *madv_behavior)
>  {
>  	struct vm_area_struct *vma = madv_behavior->vma;
> -	vma_flags_t new_vma_flags = legacy_to_vma_flags(new_flags);
>  	struct madvise_behavior_range *range = &madv_behavior->range;
>  	struct anon_vma_name *anon_name = madv_behavior->anon_name;
>  	bool set_new_anon_name = madv_behavior->behavior == __MADV_SET_ANON_VMA_NAME;
> @@ -601,7 +600,8 @@ static void madvise_cold_page_range(struct mmu_gather *tlb,
>  
>  static inline bool can_madv_lru_vma(struct vm_area_struct *vma)
>  {
> -	return !(vma->vm_flags & (VM_LOCKED|VM_PFNMAP|VM_HUGETLB));
> +	return !vma_test_any(vma, VMA_LOCKED_BIT, VMA_PFNMAP_BIT,
> +			     VMA_HUGETLB_BIT);
>  }
>  
>  static long madvise_cold(struct madvise_behavior *madv_behavior)
> @@ -650,7 +650,7 @@ static long madvise_pageout(struct madvise_behavior *madv_behavior)
>  	 * further to pageout dirty anon pages.
>  	 */
>  	if (!vma_is_anonymous(vma) && (!can_do_file_pageout(vma) &&
> -				(vma->vm_flags & VM_MAYSHARE)))
> +				vma_test(vma, VMA_MAYSHARE_BIT)))

Another weird indentation. Likely because the spare set of () that are not
necessary?


Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
