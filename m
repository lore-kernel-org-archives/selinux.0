Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795540835;
	b=vKc4rtl9znFj6j+beCcEyAkCdIjOb0mJCWD4y2tP1JZ2p5x3zz4eu4u0h0rZSruMN6em
	 kUgs1rp/x7BlciJx8b2Crq5k3PBSseYqCwjEyPKnLA2V6jTap1vULXA+foQ/JWDXo+8X3
	 M+8BMvnMUgMN7paDVkI6UUrGhHxCeapXO6HIxfYSiO8EGtUiQT5kdUCdrbmiGRJ+5BaCd
	 NOnA/66cmOgGaL4MBvdA16h71Y35j7i/3SPiZPTnuWJz6msxZ/emDlq0pZm/eKdXSr421
	 FH/THvSUX1sW7ta3HaxcUxVnL4ievHC4cNC+PI0KbsKqis8vV51AyNU8AhQ4v++VXzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540835;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=tN3vYaMnV9NupJt9uj0DyVm98fT46NJCnU18bNrr4wY=;
	b=TJk+dVTYzEizvF1oO7Yg9lc3n5tdchogR/UVfRa3atBsQyQP3HQ8BSB7YCRq/LOYG53X
	 jlwF9tCbaGjVmg66izPCwFMJPHSbbYCc99ZCMK8Q3NbMmdkshpVa0fL8QQwMDGf0Ufhlk
	 DBmsYx8+4zKjE6mxKCf0ylnJnrcYyzrHFIm5gJB9ElX/+XV8kybnX+fCR6Fqp3zBTCRXq
	 i70vU2/ZBRNBBTofNFvtslIgx+2j5IvBnokIOD8dx52Bl+3P8Jrr93qnK/8Jxd5yXkmOB
	 ozOsu479aw5rMsNbWenSyxjM7xoAjXwB57MLUfchnYomQjTgjmtnOFwwxgiQojoYI4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=icpbhZHb;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lVvQ+wMH;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=icpbhZHb;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lVvQ+wMH;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23338606A323;
	Tue, 24 Nov 2026 17:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23338606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=icpbhZHb;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lVvQ+wMH;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=icpbhZHb;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lVvQ+wMH
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3DD351FD06;
	Tue, 24 Nov 2026 17:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795540832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tN3vYaMnV9NupJt9uj0DyVm98fT46NJCnU18bNrr4wY=;
	b=icpbhZHbueFRAPYDZt+Q/evQ4tuuoi4w57XzhnK/NytlNQ2MHfpKxEDK7WpMjGpOp4BK37
	nVqhdhblSE4ztaaMD6fIuZoFaoxqk1o/paUr2O+/AkiiSActBLumd2fOdMx5QMABuPFWUe
	ZSU6FvWbS6M2opLwxF/2fpfxN+GYH7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795540832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tN3vYaMnV9NupJt9uj0DyVm98fT46NJCnU18bNrr4wY=;
	b=lVvQ+wMHtVJ08B6+CsIe0qG2lVsd3epqQRwVhNWoxRlwPkzsE2YdosLdljWTIjE6B0MNs3
	Ef00k5xo5Kn50tBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795540832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tN3vYaMnV9NupJt9uj0DyVm98fT46NJCnU18bNrr4wY=;
	b=icpbhZHbueFRAPYDZt+Q/evQ4tuuoi4w57XzhnK/NytlNQ2MHfpKxEDK7WpMjGpOp4BK37
	nVqhdhblSE4ztaaMD6fIuZoFaoxqk1o/paUr2O+/AkiiSActBLumd2fOdMx5QMABuPFWUe
	ZSU6FvWbS6M2opLwxF/2fpfxN+GYH7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795540832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tN3vYaMnV9NupJt9uj0DyVm98fT46NJCnU18bNrr4wY=;
	b=lVvQ+wMHtVJ08B6+CsIe0qG2lVsd3epqQRwVhNWoxRlwPkzsE2YdosLdljWTIjE6B0MNs3
	Ef00k5xo5Kn50tBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C17A13505;
	Tue, 24 Nov 2026 17:20:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +eKVNl/HBWspYAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 24 Nov 2026 17:20:32 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 7719D27A3D; Tue, 24 Nov 2026 18:20:31 +0100 (CET)
Date: Tue, 24 Nov 2026 18:20:31 +0100
From: Jan Kara <jack@suse.cz>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
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
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, damon@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v2 01/11] mm/filemap: convert fault and readahead logic
 to use vma_flags_t
Message-ID: <zgg3ktbk2spkmpa6u2nwqktnee26yvf3gglg33sgxq2ctkvh6o@7sj5tf2eutf4>
References: <20261124-late-2026-vma-flags-v2-0-bf3fade93064@kernel.org>
 <20261124-late-2026-vma-flags-v2-1-bf3fade93064@kernel.org>
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
In-Reply-To: <20261124-late-2026-vma-flags-v2-1-bf3fade93064@kernel.org>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-11.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLyyn5iujqg1knb55iprn1jsbw)];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,ziepe.ca,nvidia.com,redhat.com,infradead.org,suse.cz,surriel.com,google.com,linux.dev,intel.com,gmail.com,sk.com,gourry.net,linux.alibaba.com,arm.com,linux.ibm.com,ellerman.id.au,suse.de,tencent.com,suse.com,zeniv.linux.org.uk,linux.intel.com,linaro.org,canonical.com,paul-moore.com,namei.org,hallyn.com,huawei.com,oracle.com,kvack.org,vger.kernel.org,lists.ozlabs.org,lists.linux.dev,lists.ubuntu.com];
	RCPT_COUNT_GT_50(0.00)[89];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Score: -11.30

On Tue 24-11-26 17:07:53, Lorenzo Stoakes (ARM) wrote:
> Replace use of the legacy vm_flags_t flags with vma_flags_t values in the
> file fault and mmap readahead logic.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Reviewed-by: Barry Song <baohua@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/filemap.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index acf5e562b732..ce720c4c55f0 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3359,13 +3359,14 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  	struct address_space *mapping = file->f_mapping;
>  	DEFINE_READAHEAD(ractl, file, ra, mapping, vmf->pgoff);
>  	struct file *fpin = NULL;
> -	vm_flags_t vm_flags = vmf->vma->vm_flags;
> +	struct vm_area_struct *vma = vmf->vma;
>  	bool force_thp_readahead = false;
>  	unsigned int thp_order = 0;
>  	unsigned short mmap_miss;
>  
>  	/* Use the readahead code, even if readahead is disabled */
> -	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && (vm_flags & VM_HUGEPAGE)) {
> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> +	    vma_test(vma, VMA_HUGEPAGE_BIT)) {
>  		/*
>  		 * Cap max THP order at 2MB: this is the common PMD-sized
>  		 * hugepage size, and it avoids memory pressure from very
> @@ -3385,20 +3386,21 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  		 * If we don't want any read-ahead, don't bother.
>  		 * VM_EXEC case below is already intended for random access.
>  		 */
> -		if ((vm_flags & (VM_RAND_READ | VM_EXEC)) == VM_RAND_READ)
> +		if (vma_test(vma, VMA_RAND_READ_BIT) &&
> +		    !vma_test(vma, VMA_EXEC_BIT))
>  			return fpin;
>  
>  		if (!ra->ra_pages)
>  			return fpin;
>  
> -		if (vm_flags & VM_SEQ_READ) {
> +		if (vma_test(vma, VMA_SEQ_READ_BIT)) {
>  			fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>  			page_cache_sync_ra(&ractl, ra->ra_pages);
>  			return fpin;
>  		}
>  	}
>  
> -	if (!(vm_flags & (VM_SEQ_READ | VM_EXEC))) {
> +	if (!vma_test_any(vma, VMA_SEQ_READ_BIT, VMA_EXEC_BIT)) {
>  		/* Avoid banging the cache line if not needed */
>  		mmap_miss = READ_ONCE(ra->mmap_miss);
>  		if (mmap_miss < MMAP_LOTSAMISS * 10)
> @@ -3414,6 +3416,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  
>  	if (force_thp_readahead) {
>  		unsigned long folio_nr_pages = 1UL << thp_order;
> +		const bool random_read = vma_test(vma, VMA_RAND_READ_BIT);
>  
>  		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>  		ractl._index &= ~(folio_nr_pages - 1);
> @@ -3422,7 +3425,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  		 * Fetch two folios so we get the chance to actually
>  		 * readahead, unless we've been told not to.
>  		 */
> -		if (!(vm_flags & VM_RAND_READ))
> +		if (!random_read)
>  			ra->size *= 2;
>  		ra->async_size = folio_nr_pages;
>  		ra->order = thp_order;
> @@ -3430,7 +3433,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  		return fpin;
>  	}
>  
> -	if (vm_flags & VM_EXEC) {
> +	if (vma_test(vma, VMA_EXEC_BIT)) {
>  		/*
>  		 * Allow arch to request a preferred minimum folio order for
>  		 * executable memory. This can often be beneficial to
> @@ -3442,7 +3445,6 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  		 * pad that might exist between sections, which would be a waste
>  		 * of memory.
>  		 */
> -		struct vm_area_struct *vma = vmf->vma;
>  		const unsigned long start = vma_start_pgoff(vma);
>  		const unsigned long end = vma_end_pgoff(vma);
>  		unsigned long ra_end;
> @@ -3485,7 +3487,7 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
>  	unsigned short mmap_miss;
>  
>  	/* If we don't want any read-ahead, don't bother */
> -	if (vmf->vma->vm_flags & VM_RAND_READ || !ra->ra_pages)
> +	if (vma_test(vmf->vma, VMA_RAND_READ_BIT) || !ra->ra_pages)
>  		return fpin;
>  
>  	/*
> @@ -3499,7 +3501,7 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
>  	 * keep the counter symmetric.
>  	 */
>  	if (likely(!folio_test_locked(folio)) &&
> -	    !(vmf->vma->vm_flags & (VM_SEQ_READ | VM_EXEC))) {
> +	    !vma_test_any(vmf->vma, VMA_SEQ_READ_BIT, VMA_EXEC_BIT)) {
>  		mmap_miss = READ_ONCE(ra->mmap_miss);
>  		if (mmap_miss)
>  			WRITE_ONCE(ra->mmap_miss, --mmap_miss);
> @@ -3532,7 +3534,7 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
>  	 * scenarios. Recheck the PTE without PT lock firstly, thereby reducing
>  	 * the number of times we hold PT lock.
>  	 */
> -	if (!(vma->vm_flags & VM_LOCKED))
> +	if (!vma_test(vma, VMA_LOCKED_BIT))
>  		return 0;
>  
>  	if (!(vmf->flags & FAULT_FLAG_ORIG_PTE_VALID))
> @@ -4018,7 +4020,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>  		if ((map_ret & VM_FAULT_NOPAGE) &&
>  		    !(vmf->flags & FAULT_FLAG_TRIED) &&
>  		    !folio_test_workingset(folio) &&
> -		    !(vma->vm_flags & (VM_SEQ_READ | VM_EXEC))) {
> +		    !vma_test_any(vma, VMA_SEQ_READ_BIT, VMA_EXEC_BIT)) {
>  			unsigned short mmap_miss;
>  
>  			mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
> 
> -- 
> 2.56.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
