Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792683852;
	b=3saPe7B8ieijRZ7OM0xN7GyWvv0NRxAGocWNLdq5iDo5wxVvlyrGPQM9ZcINVSK6vd7l
	 pJemT+ozE8vhdhhwTHLJ7BcvbnKfk+PwluEvheDRtpHEdD+itOvBSrPwKW0vdbxbmjLfN
	 9NyLwpMwBT1Y0aRPLPwR945Eb3PgN+0TvnLIKIkC78m3wmWOxyeowWCVdiIGqCinvNigl
	 Eh4VxCS3BXgR+9uyPLSj5Oqtmh+w3S1Xb6nehNNhBHMf3k+ZgAIe4DkgBrygUp1jWsmOz
	 aYEJRJPfhRf+DUrmgdkIjQPqkOf+vNqki9C4Imv3xWpQgBRv/NWoI5IJk0Y2c8nhArw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792683852;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Z0zqhnWdd2sFyaMi7vkmKkorHXARnmLsjNYTdh0a/5s=;
	b=E1rwScEIDwHP+LLtzbFNxCjl4CQQwJJO5YWvE5BDpvv1e6eJTtkA9C54MADNcvAmXJTd
	 ooHOZzuMgbWnS5iQp4iUGnbwRxHSH84sS1RT9tNx5RQTYf6ecprx6BSr5ki8fmpT/jF2F
	 /Nf7JkvIc0TKyCt5kZ/DAGXE23Q4+k5UXLC2Vv5ch5gY6IijqdWqMhy4pJR67l0W8QbhU
	 uNF+mUrDUhDJ28SNww5+X9KL9Ro/yugojrB11JE72BMZPbmoNRPJZ7ITZbyxJ4YCPoVGZ
	 oReAEyrNOLCjsBaipVvClkI3jvK7h3wXZnDvSVmei8fSwfMM+pssbHf7AgYNU4aezdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O1YezwXQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF7A606A319;
	Thu, 22 Oct 2026 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O1YezwXQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A801A1F031E4;
	Thu, 22 Oct 2026 15:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792683852;
	bh=Z0zqhnWdd2sFyaMi7vkmKkorHXARnmLsjNYTdh0a/5s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O1YezwXQII5U4uFlc8oAWY4iUlGinrbVafW9aoY/4Jmp/fU77oq9HS+6UCRsG2k5p
	 qljmwxzqELpRVt/X5zYvJZ0GVptEsk9mJvFmLhia4jEqlq9BQ8kOrkfxwtoQr7uw3g
	 GGMo7uzzKH77dHd7sNIFENO/zifuiXixP76Cb5Dh4PXnMaHPh4F/DiNQRXLRfz0i54
	 Fie/R8JNBSWflnQugGOsgZ8C5AWR7K+lSwlbGg8L0zvYid0a5U8pKdru8OdzDw3FIo
	 4pOsn1l21GXuKF83QTew03mNZDWLB3LYfhYD8btLScqSM/aTpbya34BDc502o4pTLw
	 XS+CFkNW5XtpA==
Message-ID: <sashiko-outbox-181717@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 1/8] memcg: Add MEMCG_DMABUF accounting
 infrastructure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Albert Esteve" <aesteve@redhat.com>, "Tejun Heo" <tj@kernel.org>, "Johannes
 Weiner" <hannes@cmpxchg.org>, =?utf-8?b?TWljaGFsIEtvdXRuw70=?= <mkoutny@suse.com>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Sumit
 Semwal" <sumit.semwal@linaro.org>, =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, "Michal
 Hocko" <mhocko@kernel.org>, "Roman Gushchin" <roman.gushchin@linux.dev>, "Shakeel
 Butt" <shakeel.butt@linux.dev>, "Muchun Song" <muchun.song@linux.dev>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Benjamin Gaignard" <benjamin.gaignard@collabora.com>, "Brian
 Starkey" <Brian.Starkey@arm.com>, "John Stultz" <jstultz@google.com>, "T.J.
 Mercier" <tjmercier@google.com>, "Christian Brauner" <brauner@kernel.org>, "Paul
 Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Stephen Smalley" <stephen.smalley.work@gmail.com>, "Shuah
 Khan" <shuah@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>,
 =?utf-8?b?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, mripard@kernel.org, echanude@redhat.com, media-ci@linuxtv.org
In-Reply-To: <20261021-v2_20230123_tjmercier_google_com-v2-1-ef6ee2dd8c5c@redhat.com>
References: <20261021-v2_20230123_tjmercier_google_com-v2-0-ef6ee2dd8c5c@redhat.com>
 <20261021-v2_20230123_tjmercier_google_com-v2-1-ef6ee2dd8c5c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 15:44:10 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] dma-buf: system_heap: uncharged page allocation in system_heap_all=
ocate()
--

commit c1f3a1d4f988a0cc1048e5d03e0a2f1959fbf0ee
Author: T.J. Mercier <tjmercier@google.com>

memcg: Add MEMCG_DMABUF accounting infrastructure

This commit introduces a MEMCG_DMABUF stat counter along with
mem_cgroup_charge_dmabuf() and mem_cgroup_uncharge_dmabuf() helpers to
track dma-buf memory charges on struct dma_buf. It also removes
__GFP_ACCOUNT from system-heap page allocations in preparation for wiring
up charging in the dma-heap ioctl.

[ ... ]

> diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/heaps/=
system_heap.c
> index c8959eadc71d1..0a99ac0183a81 100644
> --- a/drivers/dma-buf/heaps/system_heap.c
> +++ b/drivers/dma-buf/heaps/system_heap.c
> @@ -388,8 +388,6 @@ static struct page *alloc_largest_available(unsigned =
long size,
>  		if (max_order < orders[i])
>  			continue;
>  		flags =3D order_flags[i];
> -		if (mem_accounting)
> -			flags |=3D __GFP_ACCOUNT;
>  		page =3D alloc_pages(flags, orders[i]);
>  		if (!page)
>  			continue;

[Severity: High]
Does removing __GFP_ACCOUNT from alloc_largest_available() in
drivers/dma-buf/heaps/system_heap.c introduce a regression in memory
cgroup limit enforcement and bisectability?

First, this commit removes __GFP_ACCOUNT before any caller of
mem_cgroup_charge_dmabuf() exists, which leaves dma_heap.mem_accounting=3D1
non-functional at this commit until the subsequent patch ("dma-heap:
charge dma-buf memory via explicit memcg") wires up the call in
dma_heap_ioctl_allocate().

Second, even after dma_heap_ioctl_allocate() calls
mem_cgroup_charge_dmabuf(), mem_cgroup_charge_dmabuf() in mm/memcontrol.c
operates on an already-exported struct dma_buf:

mm/memcontrol.c:mem_cgroup_charge_dmabuf() {
	unsigned int nr_pages =3D PAGE_ALIGN(dmabuf->size) >> PAGE_SHIFT;

	if (mem_cgroup_disabled())
		return true;

	if (try_charge(memcg, gfp_mask, nr_pages))
		return false;
    ...
}

When userspace invokes ioctl(DMA_HEAP_IOCTL_ALLOC) on /dev/dma_heap/system,
the call chain is:

  dma_heap_ioctl()
    -> dma_heap_ioctl_allocate()
      -> system_heap_allocate()
        -> alloc_largest_available()

Inside drivers/dma-buf/heaps/system_heap.c:system_heap_allocate(), the
allocation loop allocates and zeroes (via GFP_HIGHUSER | __GFP_ZERO) all
backing pages for the entire requested buffer before exporting the
dma_buf:

drivers/dma-buf/heaps/system_heap.c:system_heap_allocate() {
    ...
	while (size_remaining > 0) {
		/*
		 * Avoid trying to allocate memory if the process
		 * has been killed by SIGKILL
		 */
		if (fatal_signal_pending(current)) {
			ret =3D -EINTR;
			goto free_buffer;
		}

		page =3D alloc_largest_available(size_remaining, max_order);
		if (!page)
			goto free_buffer;

		list_add_tail(&page->lru, &pages);
		size_remaining -=3D page_size(page);
		max_order =3D compound_order(page);
		i++;
	}
    ...
}

system_heap_allocate() then allocates the scatter-gather table via
sg_alloc_table(), decrypts pages when cc_shared_buffer(buffer) is true,
and exports the struct dma_buf via dma_buf_export() before returning to
dma_heap_ioctl_allocate() where mem_cgroup_charge_dmabuf() is finally
called.

Previously, passing __GFP_ACCOUNT to alloc_pages() in
alloc_largest_available() charged each page to the calling task's memcg
during allocation, aborting the loop in system_heap_allocate() as soon as
the cgroup's memory.max limit was reached.

With charging deferred until after system_heap_allocate() completes, can a
task inside a memory-limited cgroup request a buffer much larger than its
memory.max limit and force the global page allocator to allocate and zero
arbitrary amounts of physical memory, triggering host-wide memory reclaim
or the global out-of-memory killer before mem_cgroup_charge_dmabuf() ever
checks the cgroup limit?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-v2_2023012=
3_tjmercier_google_com-v2-0-ef6ee2dd8c5c@redhat.com?part=3D1
