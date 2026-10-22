Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792683858;
	b=I7jJB+V2WnBOLsbbsFTXRtVt20War0BIp7oLteneHrlwLVANeFK/x5TI//JHJ1tzBBDh
	 qVzEJhfsr5vfL0b4Vn28kAx/H9Apq2CX5AEq5uQGnLe/CJkQr/0/1ifELCtdIT/pqfAnl
	 6/k88JiFOnbucJg7YELtPEcw6xJ9nfDxZT7B/CRVOGP/4pI4DF+0wKVcY5cP+5VpZY6cN
	 sHM4/jGX4Dox4unkAk618Kj8qWgOGbHpq6/5GzI0YhLMFoLO6cf5aycyMu8jKbis/P71o
	 CewBIop17neyciwSsFLH2IvU3p2FxkGz3hnA0WAWa3v3zd0nFhRmBgJ6nivrIrJ21Rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792683858;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7djcSuZ+VkivDbF5yVqI2iBloYUAv2eSmgTqsy+UUpo=;
	b=QUWdYjOyDK4N+2hD+JhwFOIskfaWqY45NCbzmevHYJ8GSSqB10JzgcqXsboK+qoyEu90
	 SP7Sw3ldjm0WfRrC3Vv7F0pIaxv8OKO4pWotv7AzbI2GH2jr49ti8+0/LxEq/qJKcF3La
	 jLviILV8k0hyoQCFqmG0cXxV3ns5roZCzctkCmAqO3VyGqD1g3/yjUGJ25ndMZ6g6KF8A
	 C63C9Xc5BVPSqiOtWzdmQCucG5Gq08yyw3lmkENvHeej06EO+PuHexX5cvOqFBRaqQXiR
	 ZYbH/aF+7+7JymaGsuaXC2XB4NyjH3RtOW6XcHgD1b5HVRe4/VoZ8Kr9qpDwjXzI4OA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W06cjuZW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3116606A31D;
	Thu, 22 Oct 2026 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W06cjuZW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966311F01825;
	Thu, 22 Oct 2026 15:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792683857;
	bh=7djcSuZ+VkivDbF5yVqI2iBloYUAv2eSmgTqsy+UUpo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W06cjuZWWPxaajUZFU2Wwg4ejVWMo7Bk69w/xcOgiEB0Y2gVKfSCd5Ql1rpFj3/od
	 Nd0c3Kr4dlmkL1wrd5w2ggFj5zmwDXAr+5ol+TrpBp46qB0G6YAx4RQGBoeDBgDYTC
	 A4NWE8P1hLktCI+RylJeGRUjk25Qo92EW41R7DzPuQMLDayiWRSC8nV3Fc0jY6OJHr
	 Z6vFDxxvGXD2fPFJGh2pqtzXVdpfskCPKStKZ50RCrnRB22CEhRmgp4qidPO9V6ExL
	 igmaN5FbtU8OF+ONrQby7LX/EClvvTrMppuwq2XyZx5Hg7d+ykaouUe2rMAa4slETv
	 BYzmvkcBcX/OQ==
Message-ID: <sashiko-outbox-181719@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 3/8] security: dma-buf: Add dma_buf_charge_task
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
In-Reply-To: <20261021-v2_20230123_tjmercier_google_com-v2-3-ef6ee2dd8c5c@redhat.com>
References: <20261021-v2_20230123_tjmercier_google_com-v2-0-ef6ee2dd8c5c@redhat.com>
 <20261021-v2_20230123_tjmercier_google_com-v2-3-ef6ee2dd8c5c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 15:44:15 +0000
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] dma-buf: heaps: UAF on remote task->mm in dma_heap_ioctl_alloc=
ate()
- [High] dma-buf: allocate() runs before memcg charge in dma_heap_ioctl_all=
ocate()
- [Medium] dma-buf: heaps: unguarded cgroup symbols in dma_heap_ioctl_alloc=
ate()
--

commit 4f97d3e850a29378e70a6ab0cb15c71860e1fcea
Author: Albert Esteve <aesteve@redhat.com>

security: dma-buf: Add dma_buf_charge_task LSM hook

This commit adds the security_dma_buf_charge_task() LSM hook and calls it
in dma_heap_ioctl_allocate() when charge_fd refers to a process via pidfd,
allowing security modules to control cross-cgroup dma-buf charging.

> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> index be77a4c168ab0..c315739178867 100644
> --- a/drivers/dma-buf/dma-heap.c
> +++ b/drivers/dma-buf/dma-heap.c

[ ... ]

> @@ -81,13 +82,14 @@ static struct dma_buf *dma_heap_ioctl_allocate(struct=
 file *file, void *data)
>  {
>  	struct cgroup *cgrp;
>  	struct cgroup_subsys_state *css;
> +	const struct cred *tcred;
>  	struct dma_heap_allocation_data *heap_allocation =3D data;
>  	struct dma_heap *heap =3D file->private_data;
>  	struct dma_buf *dmabuf;
>  	struct mem_cgroup *memcg =3D NULL;
>  	struct task_struct *task;
>  	unsigned int pidfd_flags;
> -	int fd;
> +	int fd, ret;
>  	size_t len;
> =20
>  	if (heap_allocation->fd)

[Severity: Medium]
Will this cause a build regression in dma_heap_ioctl_allocate() when
CONFIG_DMABUF_HEAPS=3Dy is built with CONFIG_MEMCG=3Dn or CONFIG_CGROUPS=3D=
n?

In drivers/dma-buf/dma-heap.c, dma_heap_ioctl_allocate() unconditionally
references cgroup_get_from_fd(), cgroup_css(), memory_cgrp_subsys,
css_tryget_online(), and cgroup_put() in the charge_fd resolution block
(introduced earlier in this series by commit "dma-heap: charge dma-buf
memory via explicit memcg" and updated here):

	if (heap_allocation->charge_fd) {
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

In drivers/dma-buf/Kconfig, DMABUF_HEAPS only selects DMA_SHARED_BUFFER and
does not depend on CONFIG_MEMCG or CONFIG_CGROUPS. However, in
include/linux/cgroup_subsys.h, SUBSYS(memory) (which declares
memory_cgrp_subsys) is guarded by:

#if IS_ENABLED(CONFIG_MEMCG)
SUBSYS(memory)
#endif

Furthermore, in include/linux/cgroup.h, the SUBSYS() declarations along
with cgroup_get_from_fd(), cgroup_css(), css_tryget_online(), and
cgroup_put() are only declared inside #ifdef CONFIG_CGROUPS without stub
definitions when CONFIG_CGROUPS is disabled. Should this path be guarded by
IS_ENABLED(CONFIG_MEMCG), or should Kconfig dependencies/stubs be added?

> @@ -120,6 +122,14 @@ static struct dma_buf *dma_heap_ioctl_allocate(struc=
t file *file, void *data)
>  			if (IS_ERR(task))
>  				return ERR_CAST(task);
> =20
> +			tcred =3D get_task_cred(task);
> +			ret =3D security_dma_buf_charge_task(current_cred(), tcred);
> +			put_cred(tcred);
> +			if (ret) {
> +				put_task_struct(task);
> +				return ERR_PTR(ret);
> +			}
> +
>  			memcg =3D get_mem_cgroup_from_mm(task->mm);

[Severity: Critical]
Can passing task->mm directly to get_mem_cgroup_from_mm(task->mm) in
dma_heap_ioctl_allocate() trigger a use-after-free on struct mm_struct, or
silently charge the wrong memcg when task->mm is NULL?

When resolving heap_allocation->charge_fd via pidfd_get_task(), the caller
only holds a reference on task->usage, which does not pin task->mm. After
security_dma_buf_charge_task() returns 0, dma_heap_ioctl_allocate() reads
task->mm and passes it to get_mem_cgroup_from_mm(task->mm) without holding
task_lock(task) or acquiring an mm reference via get_task_mm(task) (a
pattern introduced in commit "dma-heap: charge dma-buf memory via explicit
memcg", modified here, and duplicated in commit "dma-buf: transfer memcg
charges via DMA_BUF_IOCTL_XFER_CHARGE").

If the target task concurrently exits via do_exit() -> exit_mm() in
kernel/exit.c (or replaces its mm during exec via exec_mmap() ->
exec_mm_put_old() in fs/exec.c), it clears task->mm under task_lock() and
drops the last reference via mmput() -> __mmdrop() -> free_mm():

	local_irq_disable();
	current->mm =3D NULL;
	membarrier_update_current_mm(NULL);
	enter_lazy_tlb(mm, current);
	local_irq_enable();
	task_unlock(current);
	mmap_read_unlock(mm);
	mm_update_next_owner(mm);
	mmput(mm);

Because mm_cachep is not SLAB_TYPESAFE_BY_RCU and __mmdrop() frees the
mm_struct immediately without an RCU grace period, get_mem_cgroup_from_mm()
in mm/memcontrol.c can dereference freed memory at mm->owner:

	rcu_read_lock();
	do {
		memcg =3D mem_cgroup_from_task(rcu_dereference(mm->owner));

In addition, if the target task is already a zombie (having completed
exit_mm() while still reachable via pidfd_get_task()) or a kernel thread,
task->mm is NULL. Even though get_task_cred(task) and
security_dma_buf_charge_task() authorized charging the target task,
get_mem_cgroup_from_mm(NULL) in mm/memcontrol.c takes the !mm fallback:

	if (unlikely(!mm)) {
		memcg =3D active_memcg();
		if (unlikely(memcg)) {
			/* remote memcg must hold a ref */
			css_get(&memcg->css);
			return memcg;
		}
		mm =3D current->mm;
		if (unlikely(!mm))
			return root_mem_cgroup;
	}

which silently charges current->mm (the allocating caller's own memcg) or
root_mem_cgroup instead of charging the target task's cgroup or returning
an error. Should this pin the mm with get_task_mm(task) / mmput(mm) (or
resolve the memcg from the task under rcu_read_lock() via
mem_cgroup_from_task())?

>  			put_task_struct(task);
>  		}

[Severity: High]
Should the memcg charge happen before heap->ops->allocate() allocates the
physical backing pages in dma_heap_ioctl_allocate()?

Immediately following the charge_fd resolution in drivers/dma-buf/dma-heap.=
c,
dma_heap_ioctl_allocate() invokes heap->ops->allocate() for the full
requested len before charging memcg via mem_cgroup_charge_dmabuf():

	dmabuf =3D heap->ops->allocate(heap, len, heap_allocation->fd_flags,
				     heap_allocation->heap_flags);

	if (IS_ERR(dmabuf)) {
		mem_cgroup_put(memcg);
		return dmabuf;
	}

	if (!memcg && mem_accounting)
		memcg =3D get_mem_cgroup_from_mm(current->mm);

	if (memcg) {
		if (!mem_cgroup_charge_dmabuf(dmabuf, memcg, GFP_KERNEL)) {
			mem_cgroup_put(memcg);
			dma_buf_put(dmabuf);
			return ERR_PTR(-ENOMEM);
		}
	}

Because commit "memcg: Add MEMCG_DMABUF accounting infrastructure" removed
__GFP_ACCOUNT from alloc_largest_available() in
drivers/dma-buf/heaps/system_heap.c:

		flags =3D order_flags[i];
		page =3D alloc_pages(flags, orders[i]);

system_heap_allocate() allocates and zeroes the entire buffer of size len
using uncharged alloc_pages() calls before try_charge() is evaluated in
mem_cgroup_charge_dmabuf(). Can a process inside a memory-limited cgroup
(or targeting one via charge_fd in DMA_HEAP_IOCTL_ALLOC) use this window to
exhaust host physical memory and trigger the global OOM killer before the
cgroup limit check runs?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-v2_2023012=
3_tjmercier_google_com-v2-0-ef6ee2dd8c5c@redhat.com?part=3D3
