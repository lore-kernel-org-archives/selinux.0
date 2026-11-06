Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793950979;
	b=F5k+mG7fT3Gp6dx4RQHSV5AwNokNCoarPmNCTt/e89EgNorPHldnRGw9YkkYGDT1HLxg
	 ZF9T8buNHoDKQpXWVerygjiDZ1REdKlo86EVkZDCP+fzKExrQ1GoM1guIijCBUpSRRMmg
	 5+uYZVTQJBrzCJkuC0cUtOFR0jiToPU44jF8IW9vzUSb5NVX6gTaPSdbHO947xqVK808J
	 QdTmrTyiq+aYgiQmAcCi3uIHIXr7zkFWmS0if8OxS4gNKIestdm9k975iHV/juDyBQxMJ
	 UfLi4FzofjsWQ7/wNH9PUWGB9do3sJPM/xtsNhLDRJTHuP9BA7fK7LZNGKAUTY3gA5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793950979;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=J6SE0s1+Cmv2tEQyGLs4E7WejNQSVW6EagB3ds9ygbQ=;
	b=JknuQJid1+Edyl+uZyQlPaGh1Gcp+rUlV9afCUgQsM8wtrp8lLlQrkiZtMv87JIJ1a+w
	 Ez4tMAeuTaYijOo+ofoJslxalXIA2FpbuTa9g3MeJzaqG/AJq2lg7tc8V49CG/T2e4XtL
	 z5kmgrPCQ3pzOXGKr8oD6ZM17/TcPeNUhxRJ8MUlUBMcgOeKkvxFexA/on8nP7l9EApS7
	 UiE8GWEh0NzDq2hya8X+/tvkPqs+9JgO4tdPLLeCi2CCErAizfBee9mq10hVfSgo6s+JF
	 zvoWTlJ8BOcKv2dlt3vrW41y0gMJPb6mV5+2J5d7CEq0gsC/ijimivLc5M4NpOuAdyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="GSBj1K/Z";
	arc=none smtp.remote-ip=95.215.58.97
Received: from mta1.migadu.com (out-97.mta1.migadu.com [95.215.58.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1A4606A32E
	for <selinux@vger.kernel.org>; Fri,  6 Nov 2026 07:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A1A4606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GSBj1K/Z
X-Envelope-To: selinux@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=PtWTq6nqlzK8T9nMNNfK0YJy8biQ9MHHy5p7qGOpMUs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793950977; v=1; x=1794555777;
 b=GSBj1K/ZSht0OAprTvq60iTplyYeEa0H9QmH0FB/8FAE8glrfjJQtziQCX7E5qBUQzRV+/Ma
 JKsvfJ2quDxNFQJmOez/kej7NkxOdnIkfsuYtxE7L04n4gmVWmFx53hGn4VK3PeWrcnzuEhzdgv
 e77pz0tsF1McaKNtkZ8lR7Rg=
X-Envelope-To: selinux@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 9c50986a3e384fa4;
	Fri, 06 Nov 2026 07:42:54 +0000
X-Mizu-Trace-ID: 9c50986a3e384fa4
X-Migadu-Flow: FLOW_OUT
Date: Fri, 6 Nov 2026 15:42:19 +0800
From: "Xu Xin (vivo)" <xu.xin@linux.dev>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Rik van Riel <riel@surriel.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>,
	Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>, Usama Arif <usama.arif@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Pedro Falcato <pfalcato@suse.de>, Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>,
	SJ Park <sj@kernel.org>, Rakie Kim <rakie.kim@sk.com>,
	David Rientjes <rientjes@google.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org, damon@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 06/13] mm/ksm: convert VMA flag tests to use vma_flags_t
Message-ID: <au2E2/Q3yQacg5pk@dgvxl46587.localhost.localdomain>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-6-0d3cd15ab75f@kernel.org>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105-late-2026-vma-flags-v1-6-0d3cd15ab75f@kernel.org>

On Thu, Nov 05, 2026 at 09:30:57PM +0000, Lorenzo Stoakes (ARM) wrote:
> Replace use of the legacy vm_flags_t flags with vma_flags_t values where
> KSM tests VMA flags directly.
> 
> The ksm_madvise() interface continues to take legacy flags for the time
> being.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/ksm.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

LGTM! Thanks!

Reviewed-by: Xu Xin (vivo) <xu.xin@linux.dev>

> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index d6f736a1aa2f..61b772bba229 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -779,7 +779,7 @@ static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
>  	if (ksm_test_exit(mm))
>  		return NULL;
>  	vma = vma_lookup(mm, addr);
> -	if (!vma || !(vma->vm_flags & VM_MERGEABLE) || !vma_has_anon_rmap(vma))
> +	if (!vma || !vma_test(vma, VMA_MERGEABLE_BIT) || !vma_has_anon_rmap(vma))
>  		return NULL;
>  	return vma;
>  }
> @@ -1243,7 +1243,8 @@ static int unmerge_and_remove_all_rmap_items(void)
>  			goto mm_exiting;
>  
>  		for_each_vma(vmi, vma) {
> -			if (!(vma->vm_flags & VM_MERGEABLE) || !vma_has_anon_rmap(vma))
> +			if (!vma_test(vma, VMA_MERGEABLE_BIT) ||
> +			    !vma_has_anon_rmap(vma))
>  				continue;
>  			err = break_ksm(vma, vma->vm_start, vma->vm_end, false);
>  			if (err)
> @@ -2698,7 +2699,7 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
>  		goto no_vmas;
>  
>  	for_each_vma(vmi, vma) {
> -		if (!(vma->vm_flags & VM_MERGEABLE))
> +		if (!vma_test(vma, VMA_MERGEABLE_BIT))
>  			continue;
>  		if (ksm_scan.address < vma->vm_start)
>  			ksm_scan.address = vma->vm_start;
> @@ -2890,7 +2891,7 @@ static int __ksm_del_vma(struct vm_area_struct *vma)
>  {
>  	int err;
>  
> -	if (!(vma->vm_flags & VM_MERGEABLE))
> +	if (!vma_test(vma, VMA_MERGEABLE_BIT))
>  		return 0;
>  
>  	if (vma_has_anon_rmap(vma)) {
> @@ -3027,7 +3028,7 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
>  
>  	switch (advice) {
>  	case MADV_MERGEABLE:
> -		if (vma->vm_flags & VM_MERGEABLE)
> +		if (vma_test(vma, VMA_MERGEABLE_BIT))
>  			return 0;
>  		if (!vma_ksm_compatible(vma))
>  			return 0;
> @@ -3484,7 +3485,7 @@ bool ksm_process_mergeable(struct mm_struct *mm)
>  	mmap_assert_locked(mm);
>  	VMA_ITERATOR(vmi, mm, 0);
>  	for_each_vma(vmi, vma)
> -		if (vma->vm_flags & VM_MERGEABLE)
> +		if (vma_test(vma, VMA_MERGEABLE_BIT))
>  			return true;
>  
>  	return false;
> 
> -- 
> 2.56.0
> 
