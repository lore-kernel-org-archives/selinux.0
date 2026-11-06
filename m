Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965999;
	b=ydghxDzr9AdKePQbi0fl8CqNYC74Ec44z4iSDwcAciIw4vaE1gzlpKsRkbfNlw+ti47H
	 FwZ5ITcp283L1sXECMjV5TmhcixpY0P8l+ro8/Jrrfe0sRpCU9fh/2yKaGZCw6cBvv4BT
	 lleejAT2NnLEjg2Nk7JKuWcj2fyuXGFgAt9ue7j53bimENwKiTHCfzjeia8Umf/Mc6BGk
	 bC6YZiZH34wk+q7G0KHFOHk2VbgxkycO/cy1GeusyPonapb0Nx0GlPreUtbuARIv4SyCq
	 BKV8e+Og2jMer+Y3ebZn4N1FL7yxUMrxaefMDv//3ZEMuhd1+ITKx17wlhkGnge1+iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965999;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=hqpiqZcrPC9wx5aNBvYP4zckV3Yjf+8M1ASIDcJQ21k=;
	b=Ag7KfFfmEzUJ4pRmnNb8gXJqMT/W4GIa7fiLz2kg7Mpp1I1vXxJCJ3JTzRYyLIQVNDNm
	 s2te0wA03btwLQyyv1kd9H1KsI1eum9Cj8lYG8qxwMPrRdrUn/Wm9pukKMaHFfUsqR6y5
	 diP+eHNqrZId2ayJHgNbyFI0y2AQebz2kozoXW3p5dvYW1+Hl3Gl0ULYQvmYvAn1mVyUO
	 crIl9k1fCn8X/jDMy6BxMYmyRUHBnOFdtTYmUTxj9uX7tHXzIIbau3KajNahL0pepOb0Q
	 FEPOl4ojvj5/MBCH9qHwwOaIAUofGPcvy3Gw3PF8WarZP1M8a5UkcHoa4/Oeik7WOjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZASBbMWP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E39606A32D;
	Fri,  6 Nov 2026 11:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZASBbMWP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67501F008A2;
	Fri,  6 Nov 2026 11:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793965998;
	bh=hqpiqZcrPC9wx5aNBvYP4zckV3Yjf+8M1ASIDcJQ21k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZASBbMWPNza7o7x9E3ufbm4LKePl9d45ui5EyEQj0c6nFYmEnKRqRSm6yN2TUJnIG
	 x84xkieBm9T900liY371Whv+vlEgtVoIoe8ljwbZ4lwWbM8KpyGnDW53gpM4hXJBWS
	 OVFW5f4RKVdmXU/CRk9MtOYLRTOVEPMg4cMbwOjQw3CDtAgUhShid4U2o80KoWCvXJ
	 7iOsi5mT/kqUbrGf15Pj29AgOI3H4VhdUJhDFAAQhNzZE0VHvIyVtlFvkhJjAua2XU
	 YUPMnsJ4zBwKcR/8IaIsESK7/SOqxLxJHo/P8jZeFAnAF9NyOrBY6sci09ixJJiZ++
	 qRejsB3E6wJmQ==
Date: Fri, 6 Nov 2026 11:53:00 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Rik van Riel <riel@surriel.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
	Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Pedro Falcato <pfalcato@suse.de>, 
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, Baoquan He <baoquan.he@linux.dev>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Leon Romanovsky <leon@kernel.org>, SJ Park <sj@kernel.org>, 
	Rakie Kim <rakie.kim@sk.com>, David Rientjes <rientjes@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	John Johansen <john.johansen@canonical.com>, Georgia Garcia <georgia.garcia@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Fan Wu <wufan@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej =?utf-8?B?TW9zbsOhxI1law==?= <omosnacek@gmail.com>, 
	linux-mm@kvack.org, kvm@vger.kernel.org, damon@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH 02/13] mm/filemap: convert fault and readahead logic to
 use vma_flags_t
Message-ID: <au2_PPpdAMgRJZtX@gremlin>
References: <20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org>
 <20261105-late-2026-vma-flags-v1-2-0d3cd15ab75f@kernel.org>
 <sashiko-outbox-200257@kernel.org>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-200257@kernel.org>

On Thu, Nov 05, 2026 at 09:41:34PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] mm/filemap: use-after-free on vma in do_sync_mmap_readahead()
> - [Low] mm/filemap: inner vma declaration shadows outer vma in do_sync_mmap_readahead()
> --
>
> commit f5f0f8e634a6a2e2b76ad818de67e83f30cb7dea
> Author: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>
> mm/filemap: convert fault and readahead logic to use vma_flags_t
>
> This commit replaces direct checks of vm_flags_t values with vma_flags_t
> helpers in the filemap fault and mmap readahead paths.
>
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index b74bc1e5015c6..d8b538bd14043 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -3351,13 +3351,14 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
> >  	struct address_space *mapping = file->f_mapping;
> >  	DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
> >  	struct file *fpin = NULL;
> > -	vm_flags_t vm_flags = vmf->vma->vm_flags;
> > +	struct vm_area_struct *vma = vmf->vma;
> >  	bool force_thp_readahead = false;
> >  	unsigned int thp_order = 0;
> >  	unsigned short mmap_miss;
>
> [ ... ]
>
> > @@ -3414,7 +3416,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
> >  		 * Fetch two folios so we get the chance to actually
> >  		 * readahead, unless we've been told not to.
> >  		 */
> > -		if (!(vm_flags & VM_RAND_READ))
> > +		if (!vma_test(vma, VMA_RAND_READ_BIT))
> >  			ra->size *= 2;
> >  		ra->async_size = folio_nr_pages;
> >  		ra->order = thp_order;
>
> [Severity: High]
> Can this trigger a use-after-free on vma?
>
> Previously, do_sync_mmap_readahead() cached vmf->vma->vm_flags by value in a
> local variable at entry while the fault lock was held, as introduced by
> commit dcfa24ba6899 ("filemap: Cache the value of vm_flags").
>
> In the force_thp_readahead block, maybe_unlock_mmap_for_io() is called before
> this check:
>
> 	if (force_thp_readahead) {
> 		unsigned long folio_nr_pages = 1UL << thp_order;
>
> 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
> 		ractl._index &= ~(folio_nr_pages - 1);
> 		ra->size = folio_nr_pages;
> 		/*
> 		 * Fetch two folios so we get the chance to actually
> 		 * readahead, unless we've been told not to.
> 		 */
> 		if (!vma_test(vma, VMA_RAND_READ_BIT))
> 			ra->size *= 2;
>
> Since maybe_unlock_mmap_for_io() only pins vmf->vma->vm_file and calls
> release_fault_lock(vmf) to drop mmap_lock or the per-VMA lock, isn't vma
> unprotected against concurrent modification or freeing when vma_test(vma,
> VMA_RAND_READ_BIT) dereferences vma->flags?
>
> > @@ -3422,7 +3424,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
> >  		return fpin;
> >  	}
> >
> > -	if (vm_flags & VM_EXEC) {
> > +	if (vma_test(vma, VMA_EXEC_BIT)) {
> >  		/*
> >  		 * Allow arch to request a preferred minimum folio order for
> >  		 * executable memory. This can often be beneficial to
>
> [Severity: Low]
> Does the newly added outer vma declaration in do_sync_mmap_readahead() cause
> the existing inner declaration in this VMA_EXEC_BIT block to shadow it?
>
> 	if (vma_test(vma, VMA_EXEC_BIT)) {
> 		...
> 		struct vm_area_struct *vma = vmf->vma;
> 		const unsigned long start = vma_start_pgoff(vma);
> 		const unsigned long end = vma_end_pgoff(vma);
>
> Should the inner vma variable be removed now that vma is declared at function
> scope?
>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20261105-late-2026-vma-flags-v1-0-0d3cd15ab75f@kernel.org?part=2

It seems these are valid, oops!

Andrew suggested a fix off-list, and I agreed to this as an in-place fixup to
avoid respin.

I have also updated the series locally to reflect this change:

----8<----
 mm/filemap.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/mm/filemap.c~mm-filemap-convert-fault-and-readahead-logic-to-use-vma_flags_t-fix
+++ a/mm/filemap.c
@@ -3410,6 +3410,7 @@ static struct file *do_sync_mmap_readahe

	if (force_thp_readahead) {
		unsigned long folio_nr_pages = 1UL << thp_order;
+		const bool random_read = vma_test(vma, VMA_RAND_READ_BIT);

		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
		ractl._index &= ~(folio_nr_pages - 1);
@@ -3418,7 +3419,7 @@ static struct file *do_sync_mmap_readahe
		 * Fetch two folios so we get the chance to actually
		 * readahead, unless we've been told not to.
		 */
-		if (!vma_test(vma, VMA_RAND_READ_BIT))
+		if (!random_read)
			ra->size *= 2;
		ra->async_size = folio_nr_pages;
		ra->order = thp_order;
@@ -3438,7 +3439,6 @@ static struct file *do_sync_mmap_readahe
		 * pad that might exist between sections, which would be a waste
		 * of memory.
		 */
-		struct vm_area_struct *vma = vmf->vma;
		const unsigned long start = vma_start_pgoff(vma);
		const unsigned long end = vma_end_pgoff(vma);
		unsigned long ra_end;
_

--
Cheers, Lorenzo
