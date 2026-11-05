Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793877115;
	b=UnktfHbRCk6cwb/Liuox+2jKMhonjiuvI43YsfIWBvK79uEmXwz/72VXK54L9qy/BYYs
	 OLIM2AEGfh0iRVXShRNVnL9aiUYyTt39N4hBdPPpJiNXXBvub0iGBqMnaw5wKb/5pb9i7
	 1tK9ZeiNNdz/LB4UKNjivRi83yFvjyxtbK5X8AQIJkK7TDh7u9qjFXQLERQBQ3uWpzLYu
	 5U9MopUF6pkYtLu2fQGsCV77RYkIo+ZXipPv8lQjEy+OgLMWDpEh/CPhrZsrWtiT0azbG
	 /RlX9HkMZQIJQOo4zNJi3e92I9r4Ss78dAHQn2591QoRXMsSZfdpfHohjYIsd7aWkwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877115;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=enixJkjvt/NjGzx2vZdqFTkXKPfd4qcXQu8lRjKJNZg=;
	b=j3j+B9rBVLT2lNOzwjCiGt3++qcTtMAUbHXteu++TdbXpvgqd/zPg1KEsRNKicvsB4zH
	 6qNJ9ecZeGIdAg7r9Jv8j/dFfuVj/R5E7Sd34etZz09Zfe6sOKi3/0KH0w6r2aoTRrTmU
	 eRRmbP8EoVjjbVID+qFW/+ePabLqsHAYgFPamslkAdm5vMZ11LRy0XS9Vk+n5LbWpoy5v
	 /lAVNjdVKcbjcIEb23Yg7UTdwTTIMXC0W7lDLV1QkonjIDQr9C9vlRzQhRPqmaRWnWg0y
	 sQCuFDVVrCq72Mv+qj7gW+dbhSpVgBv52Y6J082WrYaHhwDENeTtt1bhaDgH5Ma5RsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LqwrdTgO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8D6606D805;
	Thu,  5 Nov 2026 11:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LqwrdTgO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99511F00919;
	Thu,  5 Nov 2026 11:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793877114;
	bh=enixJkjvt/NjGzx2vZdqFTkXKPfd4qcXQu8lRjKJNZg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LqwrdTgOAHYSfUZcCn0vb7egFoGlnn/N25DberiwXI2r9Nuan10LzGhj9TOTvc4hq
	 aRLKo586J9Jj71jjdo2VlOkAT/orK4gAlgaFE4P6O7VKEi6hdnj25pKLDWL9myPx+U
	 jWZWyOtctKFaf8lmRnasULc7fMQVuW1Wzcl2/EaENoVrDU9TS2O8CPwNdxqIvJFcAy
	 ZQ+MfX6a6r4jgl4wL0Xq+/umegY7ix5rxuuPx9Fhqe0plwgj6xjoQLP1S+mbkJuNoG
	 YcnBsyy9XWslw0oR9Jozyi+3QwJVuOhSFTMdXCQoHhIi3Gn/3uBKejCot25qhdoOJn
	 bqwniPkRTAQfg==
Message-ID: <sashiko-outbox-198916@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/8] memcg: Add MEMCG_DMABUF accounting
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
 =?utf-8?b?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, "Jens Wiklander" <jenswi@kernel.org>, "Sumit
 Garg" <sumit.garg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, selinux@vger.kernel.org, op-tee@lists.trustedfirmware.org, media-ci@linuxtv.org
In-Reply-To: <20261104-v2_20230123_tjmercier_google_com-v4-1-1819a017000b@redhat.com>
References: <20261104-v2_20230123_tjmercier_google_com-v4-0-1819a017000b@redhat.com>
 <20261104-v2_20230123_tjmercier_google_com-v4-1-1819a017000b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 11:11:52 +0000
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
- [Medium] mm: memcontrol: 32-bit nr_pages truncation in dmabuf charge help=
ers
--

commit a5e6165b3e0444a33f57a14736c2174d7c009944
Author: T.J. Mercier <tjmercier@google.com>

memcg: Add MEMCG_DMABUF accounting infrastructure

This commit introduces the MEMCG_DMABUF stat counter and helper functions
to reserve, cancel, and uncharge dma-buf memory against a memory cgroup,
tracking the active charge via a memcg pointer on struct dma_buf.

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 856a7d07586cc..e53dd7eebc3b5 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c

[ ... ]

> @@ -5658,6 +5661,73 @@ void mem_cgroup_flush_workqueue(void)
>  	flush_workqueue(memcg_wq);
>  }
> =20
> +/**
> + * mem_cgroup_reserve_dmabuf - charge a memcg for a dma-buf allocation
> + * @memcg: memcg to charge (may be %NULL)
> + * @gfp_mask: reclaim mode
> + * @nr_pages: number of pages to charge
> + *
> + * Charges @nr_pages against @memcg. Call this before allocating pages so
> + * the cgroup limit is enforced up front. On success the caller must
> + * finalize the charge with the MEMCG_DMABUF stat update, or call
> + * mem_cgroup_cancel_dmabuf() to undo it.
> + *
> + * Returns %true on success, %false if the charge would exceed the limit.
> + */
> +bool mem_cgroup_reserve_dmabuf(struct mem_cgroup *memcg, gfp_t gfp_mask,
> +			       unsigned int nr_pages)
> +{
> +	if (!memcg || mem_cgroup_disabled())
> +		return true;
> +
> +	if (try_charge(memcg, gfp_mask, nr_pages))
> +		return false;
> +
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(mem_cgroup_reserve_dmabuf);
> +
> +/**
> + * mem_cgroup_cancel_dmabuf - undo a dma-buf charge
> + * @memcg: memcg to uncharge (may be %NULL)
> + * @nr_pages: same value passed to mem_cgroup_reserve_dmabuf()
> + *
> + * Returns @nr_pages of charge to @memcg. Use when the allocation fails
> + * after mem_cgroup_reserve_dmabuf().
> + */
> +void mem_cgroup_cancel_dmabuf(struct mem_cgroup *memcg, unsigned int nr_=
pages)
> +{
> +	if (!memcg)
> +		return;
> +
> +	if (!mem_cgroup_is_root(memcg))
> +		refill_stock(memcg, nr_pages);
> +}
> +EXPORT_SYMBOL_GPL(mem_cgroup_cancel_dmabuf);
> +
> +/**
> + * mem_cgroup_uncharge_dmabuf - uncharge a dma-buf from its memcg
> + * @dmabuf: buffer to uncharge
> + *
> + * Reverses a finalized dma-buf charge. Drops the memcg
> + * reference stored in @dmabuf->memcg and clears the pointer.
> + * Safe to call when @dmabuf->memcg is %NULL.
> + */
> +void mem_cgroup_uncharge_dmabuf(struct dma_buf *dmabuf)
> +{
> +	unsigned int nr_pages;
> +	struct mem_cgroup *memcg =3D dmabuf->memcg;
> +
> +	if (!memcg)
> +		return;
> +
> +	nr_pages =3D PAGE_ALIGN(dmabuf->size) >> PAGE_SHIFT;
> +	mod_memcg_state(memcg, MEMCG_DMABUF, -nr_pages);
> +	mem_cgroup_cancel_dmabuf(memcg, nr_pages);
> +	mem_cgroup_put(memcg);
> +	dmabuf->memcg =3D NULL;
> +}

[Severity: Medium]
Can passing a 32-bit unsigned int for nr_pages in
mem_cgroup_reserve_dmabuf(), mem_cgroup_cancel_dmabuf(), and
mem_cgroup_uncharge_dmabuf() in mm/memcontrol.c (and include/linux/memcontr=
ol.h)
truncate 64-bit dma-buf sizes?

struct dma_buf stores size as a 64-bit size_t, and in the following commit
("dma-heap: charge dma-buf memory via explicit memcg"),
dma_heap_ioctl_allocate() -> system_heap_allocate() passes a 64-bit
PAGE_ALIGN(len) >> PAGE_SHIFT to mem_cgroup_reserve_dmabuf() before
entering its while (size_remaining > 0) page allocation loop without
__GFP_ACCOUNT.

If a userspace caller requests an allocation where len >=3D (1ULL << (32 +
PAGE_SHIFT)) (for example, (1ULL << 44) + PAGE_SIZE on a 4 KiB page
system), PAGE_ALIGN(len) >> PAGE_SHIFT wraps to 1 page when converted to
unsigned int nr_pages. try_charge() will then succeed against a small
memory.max limit while system_heap_allocate() proceeds to allocate
unaccounted pages using the full 64-bit size_remaining.

Additionally, in mem_cgroup_uncharge_dmabuf(), passing -nr_pages to
mod_memcg_state(memcg, MEMCG_DMABUF, -nr_pages) (which takes a signed int
val) will overflow when nr_pages exceeds INT_MAX. Should nr_pages use
unsigned long (or size_t) across these helpers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-v2_2023012=
3_tjmercier_google_com-v4-0-1819a017000b@redhat.com?part=3D1
