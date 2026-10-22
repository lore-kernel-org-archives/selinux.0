Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792683860;
	b=tHPYtDj1qzTBArPsADmiSFnCDjiVJ7fDIETc0ZMitl0xzji/tBXyui3eslR0gZ3IXHXn
	 eLMWUwIrB1qio67mRAzlj5WdZWM/CipTVfbxYvIvdnp9siHFb+bJWHkC2/nFXa5nSdKHM
	 IB24KQFvMzwgRV+M/4VG+4n0+eHDcUCKi9NBpEUt1VniqskA/FQ43HKnmx24K0v2JIjuV
	 MKY6/c3Q27vz6ugvQYROuI23d0QX2H0Bbe7reTsGH+EEIcQgXMYlhUElrr3iJpEO9ZWab
	 mF+UexNyF7LmRdhCO2zqm3/EOE2Tu6wQAru7ZD/3wDQLHlV2DH24iW6HMOKtk/csg+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792683860;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FQNoDGzEIRA1SKlEsB0k8OEtsPm86udTUByyB+9XNMk=;
	b=NF4h3usS6mdLzW3caQOocK6LUnYw4bYSLNfKgpaJX45yzXfFmJrGEj8SPS6fXBHY0YmF
	 3o93FKnQVnjDNjGDAXEEBDNiKBknTy/m1y1P1Uiv8HJNgGuLkZnK94cGkMVsP6xOqg9ZF
	 zuuyP3KatshAomjkh/lQon/WJI0noG/cok+5CSVwidej6eP3sYIP8K/3V865n0eHe1fxg
	 tJwhVhyi1P2VHcN/OM9S8OgtYSJtbBYI0pb36ajvNv9qrXLUUddOfDSrWbu/5aWutEmrk
	 C0LfKQV7sDR86o1SYA8DfachlAvoicX7QKuiVM+jrkd0MtJXUiUkbarAnXEnPbmCtAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3i4qVmA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CB6606A319;
	Thu, 22 Oct 2026 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3i4qVmA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8E31F031E1;
	Thu, 22 Oct 2026 15:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792683859;
	bh=FQNoDGzEIRA1SKlEsB0k8OEtsPm86udTUByyB+9XNMk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D3i4qVmAKJMU1NOTSbYoqzcCWpAmDrHWsUE0/fqlfQIbyHJve9e5H7Qa7wFAr9Ixp
	 seu/Q5PVFm93fPjSZZ3NOUZYEmmLyQEZjOKaBfWl8M3RH4gWw0gxd/EG5QGKuxSyHI
	 NVfsh2ce2tEoFgxZQDPHJufxQLgXbpSo5z/4V4frVQ+aGcVYBoOp0bZU1WkLkHA/Ha
	 LYcZaJg9Hcwmst8WGDnnCniWa9DIOB7cN5QutcAtmJe9PSxllVmVdAPSyRr7V09wax
	 adC2VeJ+ceHt9D/uo0DZb42BKeR7xQxAscUKcC8jicNx2hfSIadNfp9fYiAu6Ibb8U
	 9sjFTcmGonjug==
Message-ID: <sashiko-outbox-181720@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 4/8] security: dma-buf: Add dma_buf_charge_cgroup
 LSM hook
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
In-Reply-To: <20261021-v2_20230123_tjmercier_google_com-v2-4-ef6ee2dd8c5c@redhat.com>
References: <20261021-v2_20230123_tjmercier_google_com-v2-0-ef6ee2dd8c5c@redhat.com>
 <20261021-v2_20230123_tjmercier_google_com-v2-4-ef6ee2dd8c5c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 15:44:17 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] dma-buf: heaps: build failure in dma_heap_ioctl_allocate() when =
CONFIG_MEMCG=3Dn
- [Medium] dma-heap: missing __padding zero check in dma_heap_ioctl_allocat=
e()
--

commit c7d9f1c9769a263b2541e4535f61a1da114ca74b
Author: Albert Esteve <aesteve@redhat.com>

security: dma-buf: Add dma_buf_charge_cgroup LSM hook

This patch adds the security_dma_buf_charge_cgroup() LSM hook and calls it
in dma_heap_ioctl_allocate() when charge_fd refers to a cgroupfd. When
CONFIG_SECURITY is disabled, the hook compiles to a no-op inline returning =
0.

> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> index c315739178867..e06131f4655d8 100644
> --- a/drivers/dma-buf/dma-heap.c
> +++ b/drivers/dma-buf/dma-heap.c
> @@ -115,7 +115,13 @@ static struct dma_buf *dma_heap_ioctl_allocate(struc=
t file *file, void *data)
> =20
>  			memcg =3D mem_cgroup_from_css(css);
>  			rcu_read_unlock();
> +
> +			ret =3D security_dma_buf_charge_cgroup(current_cred(), cgrp);
>  			cgroup_put(cgrp);
> +			if (ret) {
> +				mem_cgroup_put(memcg);
> +				return ERR_PTR(ret);
> +			}

[Severity: Medium]
Will drivers/dma-buf/dma-heap.c fail to build when CONFIG_DMABUF_HEAPS=3Dy =
and
CONFIG_MEMCG=3Dn (or CONFIG_CGROUPS=3Dn)?

In drivers/dma-buf/Kconfig, DMABUF_HEAPS only selects DMA_SHARED_BUFFER and
does not depend on CONFIG_MEMCG or CONFIG_CGROUPS:

    menuconfig DMABUF_HEAPS
    	bool "DMA-BUF Userland Memory Heaps"
    	select DMA_SHARED_BUFFER

In dma_heap_ioctl_allocate(), the cgroupfd path introduced earlier in this
series ("dma-heap: charge dma-buf memory via explicit memcg") and updated
here unconditionally references cgroup_get_from_fd(), cgroup_css(),
memory_cgrp_subsys, css_tryget_online(), and cgroup_put():

		cgrp =3D cgroup_get_from_fd(heap_allocation->charge_fd);
		if (!IS_ERR(cgrp)) {
			/* charge_fd is a cgroupfd */
			rcu_read_lock();
			css =3D cgroup_css(cgrp, &memory_cgrp_subsys);
			if (!css || !css_tryget_online(css)) {
				rcu_read_unlock();
				cgroup_put(cgrp);
				return ERR_PTR(-ENOENT);
			}

In include/linux/cgroup_subsys.h, SUBSYS(memory) (which declares
memory_cgrp_subsys in include/linux/cgroup.h) is only emitted when
CONFIG_MEMCG is enabled:

    #if IS_ENABLED(CONFIG_MEMCG)
    SUBSYS(memory)
    #endif

Additionally, in include/linux/cgroup.h, cgroup_get_from_fd(),
css_tryget_online(), cgroup_css(), and cgroup_put() are only declared inside
#ifdef CONFIG_CGROUPS and have no stubs when CONFIG_CGROUPS=3Dn, unlike the
helpers in include/linux/memcontrol.h.

Should the cgroupfd resolution block in dma_heap_ioctl_allocate() be guarded
with #ifdef CONFIG_MEMCG?

>  		} else {
>  			/* charge_fd is a pidfd  */
>  			task =3D pidfd_get_task(heap_allocation->charge_fd, &pidfd_flags);

[Severity: Medium]
Also in dma_heap_ioctl_allocate(), should non-zero values in
heap_allocation->__padding be rejected with ERR_PTR(-EINVAL)?

Earlier in this series ("dma-heap: charge dma-buf memory via explicit
memcg"), struct dma_heap_allocation_data in include/uapi/linux/dma-heap.h w=
as
extended with charge_fd and __padding:

     * @__padding:		reserved, must be zero
     *
     * Provided by userspace as an argument to the ioctl
     */
    struct dma_heap_allocation_data {
    	__u64 len;
    	__u32 fd;
    	__u32 fd_flags;
    	__u64 heap_flags;
    	__u32 charge_fd;
    	__u32 __padding;
    };

When a userspace process issues ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc)
with a 32-byte struct dma_heap_allocation_data where alloc.__padding !=3D 0,
dma_heap_ioctl() copies all 32 bytes into kdata and calls
dma_heap_ioctl_allocate(file, kdata). However, dma_heap_ioctl_allocate() on=
ly
checks fd, fd_flags, and heap_flags before processing charge_fd:

	if (heap_allocation->fd)
		return ERR_PTR(-EINVAL);

	if (heap_allocation->fd_flags & ~DMA_HEAP_VALID_FD_FLAGS)
		return ERR_PTR(-EINVAL);

	if (heap_allocation->heap_flags & ~DMA_HEAP_VALID_HEAP_FLAGS)
		return ERR_PTR(-EINVAL);

Because dma_heap_ioctl() zeroes trailing bytes when ksize > in_size:

	if (ksize > in_size)
		memset(kdata + in_size, 0, ksize - in_size);

legacy 24-byte ioctl callers already have __padding zeroed, whereas 32-byte
callers can currently pass arbitrary non-zero values in __padding without
receiving -EINVAL, preventing __padding from being safely repurposed in the
future.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-v2_2023012=
3_tjmercier_google_com-v2-0-ef6ee2dd8c5c@redhat.com?part=3D4
