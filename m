Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86DE4D98F7
	for <selinux@vger.kernel.org>; Wed, 13 May 2026 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778690368; cv=pass; b=o8EKCY+NFexcUB45QjfY1THALdargzQVXHCmPSw+MctdAOix2ftCUJdpL+5SwpUUr2DxzUWlM8+L16ogQwJFWXmOq80wxbDnOr8rsIBsPZWjdnfCKeHemwPBXx0G8f3fqRU5vy7dad3JYm19NdblcJSDaUee1CmuGDjIwzDAawo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778690368; c=relaxed/simple;
	bh=AbizP6UXRbboqpNTNkCFhXS8zLUX4kpj1t0M3DjuAhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlutiU5rhw6YztRq3pYKrjciqIrMEOfGt30kUf5MlxUtKJf6pystDKB3jdSHclrBAVDfJvzDOVGelJ4+s5Phnyf/pUwviq05Qx/cIAsC1vq1N3S7Vq/xOZC7/csYZwCOtE6GYYAGRvSdhXFCR9ky8YPxr3OPMaWhVnt9oph7RTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HVll0sAx; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HVll0sAx"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48d1c670255so4545e9.0
        for <selinux@vger.kernel.org>; Wed, 13 May 2026 09:39:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778690363; cv=none;
        d=google.com; s=arc-20240605;
        b=TOrciqlmqLUh8+8o487N3IIYPY2g9oMsnnaI1HFUPZKHl8oTKvDJcbD4Za/uiof95I
         1CX+Y2ICuwhj9KoWq837/h4pCV7pniQymnMXX1nmcvajbSLS/h/orh6/JfZBtbNWaVNT
         LyZ0xygwcUZiOMs874IryE5V7yw/ajzXXuKUSlfl80x8FxOoUrENgz9qePlFSrC4ygPw
         278XGYIL1zr03kt/M2EY7ulKD2oaPdChMW3LftFRrdYwfdQzLeqovGqvJH6pTyNGELga
         Td0Td+PfFOzoVfqkG8+qeyr3MYh+cnIW96Dq5CQoOGypnPl7tGTpfo3cPVjPfSVXnJAh
         KnSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hOVJmPkMMtutEBgPE85iBoY/7XAmkTfBx4YFHq1zHJQ=;
        fh=ENNWVzDvF4qVH+mriZl20kj0QPe9C479S9V79Y94V+A=;
        b=CH3DOhl75EIXY7444QkpAurHk43r/ISMYeN9cUjBnzlJ2eob1jLEswHp3vD35th+yJ
         fkT03hqrLy17bl0+KXVUHhKq61pmIHGH5IJQheOpu+C4MmjHSFAU41hY+HAZTOk8jt3G
         C78uVTOFXPNSb/OId+4be45cjjHO+8kNzJwKIEBOEql1/omZ8jWMfNzHQoR/BGAgJfZY
         ZYGzGKmLJDAU5VNWUT0XroFHG0/Ay2SBm+nFNowYTFcZLqE8nOQr6hrYL5z8UZOXT60d
         M+WHnktZDoKTShR7hfhBHyx02RiC8bZnk4nJ3Hit2WYCw4ikPGyxlLgaYFGLpZC0NoFO
         4sYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778690363; x=1779295163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hOVJmPkMMtutEBgPE85iBoY/7XAmkTfBx4YFHq1zHJQ=;
        b=HVll0sAxKJNgA57mG2alJfrid/1eqs9flEP951wsVGIJpq/S94+EQZChY3q3vDolqo
         XYn9ClHcGryhSMozX21U6bdSxVWgejhrm7/xWyccD8kTnrqMMmmdnGl9Z4a8GZ/sFvev
         VStL86i8rLO5bowITRE/CXKuuq20H7Lqd+okEBemmVctr1TNbakgShR9YiiXXQ2alXpO
         oRBuILMAYVwmZW1FiQXx8IDDPkWWspBfUUowV4REHJWBtvW61P6SqmhDsknMOWAuNzWW
         8PwVL5dOpRsj8/ckc/0RQKxKa15kjEjLq+j555KmNwAhBF/sFcQZWKAFyrQab8cqVcG7
         1w4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778690363; x=1779295163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hOVJmPkMMtutEBgPE85iBoY/7XAmkTfBx4YFHq1zHJQ=;
        b=niBsQYq24I3yQN0aWh/Y7TA2qTMmmhJYx9MvnvEAP0s+XDA1eyD2DDXrRDeasXc5Qz
         WbS6WoL2CPZ60//JjR9dchoKDzeGZ7WkkKYEru/MUjp43xAKtsQtQMdlxju8+bZu+WKV
         KSUBvMnFGDmpwAccUCs1mRmjil2w6DCu2LLQDe6js0EY3To3r8e00FsJ5OHXf4O8qcy8
         fuaq1dLvnOVb2LgB7rFUa0qtsZHcVnlkHS1gv17vVSPXwSDZnf0npzQjnioQM+CJKSXm
         HQHea6ekz2VABuCU5hNnN3nWDgMXt0Z6RtPItmWZlbKG9GqFTloa6l6YGsUAbudGGZtt
         p47w==
X-Forwarded-Encrypted: i=1; AFNElJ/phKNJ+vSgo6T6W0+9zAkpN/viMnFfzxFebG7GtnBMa0s5Q5OaMA5v/BxXzJ34geTW/2M9Sth2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1iD6vxsq9ONGYla6lfs7GGthJTeDplT0Rw/WEw7AL47N8vhZb
	0fjdq6JOhUWFtQdAZzF4jem/hCMIIt9GYzbA9bkUo9D7nSzsq+suK1Xq4ghCXUP90ud/aVhmOJE
	ymWi5vJmnC7TGtoZqn7JCVj5PCv6WoKW77abfqVXb
X-Gm-Gg: Acq92OHAHu3gUokJKN3eequr3armaGZTKLvwdt0y3INaLfkc98TWVOnQSFJFxxKd9t7
	l3o58nticfuuMx+naavvJfd9gdr2YlKTzHRv1wS2UFnHhH7Jmsx5TAt9iIZTlptt5HKQxnd5+dB
	0am6WisfdJV9voegNSWuQWPfZ/mJIsFDuVt0Ipmj4hFvEfa9JFKPTIpd7GSQD+C3O+ZtbNDyCAl
	jfu9NSzrbVC8XZNMxN/icqN78pAwKgKLycnSOSliqVe4ek+ieB30Pqtuzr4asg3ppeysA8hV7kq
	OWcfdeZmzzWuLgCC1hFFYu2ie3rqRW8sBGB9d+HfjqNUtwXV6JqQxaSEoKrapNDfM0+mAz92wRG
	4dOJA
X-Received: by 2002:a05:600d:8486:20b0:477:86fd:fb49 with SMTP id
 5b1f17b1804b1-48fc919a43dmr965705e9.10.1778690362738; Wed, 13 May 2026
 09:39:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <8ef38815-6ae9-4359-86d4-042554357639@amd.com> <CADSE00KZMJFYJ92XZa=r9EeJJRGT=SNChwOW-_jTznc7F79xGw@mail.gmail.com>
In-Reply-To: <CADSE00KZMJFYJ92XZa=r9EeJJRGT=SNChwOW-_jTznc7F79xGw@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 13 May 2026 09:39:10 -0700
X-Gm-Features: AVHnY4Le2GUGE4TjoBj6HdQ1GbUQChjLautyZmM4nJTx4rLM4Wl1vLSY-yCAZrQ
Message-ID: <CABdmKX3R5faNgFva-HHVhtTcxJ0_BK9Rei3iTQcA+SRwdKv1Aw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: Albert Esteve <aesteve@redhat.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, Christian Brauner <brauner@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, mripard@kernel.org, echanude@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 5:41=E2=80=AFAM Albert Esteve <aesteve@redhat.com> =
wrote:
>
> On Tue, May 12, 2026 at 12:14=E2=80=AFPM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > On 5/12/26 11:10, Albert Esteve wrote:
> > > On embedded platforms a central process often allocates dma-buf
> > > memory on behalf of client applications. Without a way to
> > > attribute the charge to the requesting client's cgroup, the
> > > cost lands on the allocator, making per-cgroup memory limits
> > > ineffective for the actual consumers.
> > >
> > > Add charge_pid_fd to struct dma_heap_allocation_data. When set to
> > > a valid pidfd, DMA_HEAP_IOCTL_ALLOC resolves the target task's
> > > memcg and charges the buffer there via mem_cgroup_charge_dmabuf()
> > > inside dma_heap_buffer_alloc(). Without charge_pid_fd, and with
> > > the mem_accounting module parameter enabled, the buffer is charged
> > > to the allocator's own cgroup.
> > >
> > > Additionally, commit 3c227be90659 ("dma-buf: system_heap: account for
> > > system heap allocation in memcg") adds __GFP_ACCOUNT to system-heap
> > > page allocations. Keeping __GFP_ACCOUNT would charge the same pages
> > > twice (once to kmem, once to MEMCG_DMABUF), thus remove it and route
> > > all accounting through a single MEMCG_DMABUF path.
> > >
> > > Usage examples:
> > >
> > >   1. Central allocator charging to a client at allocation time.
> > >      The allocator knows the client's PID (e.g., from binder's
> > >      sender_pid) and uses pidfd to attribute the charge:
> > >
> > >        pid_t client_pid =3D txn->sender_pid;
> > >        int pidfd =3D pidfd_open(client_pid, 0);
> > >
> > >        struct dma_heap_allocation_data alloc =3D {
> > >            .len             =3D buffer_size,
> > >            .fd_flags        =3D O_RDWR | O_CLOEXEC,
> > >            .charge_pid_fd   =3D pidfd,
> > >        };
> > >        ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
> > >        close(pidfd);
> > >        /* alloc.fd is now charged to client's cgroup */
> > >
> > >   2. Default allocation (no pidfd, mem_accounting=3D1).
> > >      When charge_pid_fd is not set and the mem_accounting module
> > >      parameter is enabled, the buffer is charged to the allocator's
> > >      own cgroup:
> > >
> > >        struct dma_heap_allocation_data alloc =3D {
> > >            .len      =3D buffer_size,
> > >            .fd_flags =3D O_RDWR | O_CLOEXEC,
> > >        };
> > >        ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
> > >        /* charged to current process's cgroup */
> > >
> > > Current limitations:
> > >
> > >  - Single-owner model: a dma-buf carries one memcg charge regardless =
of
> > >    how many processes share it. Means only the first owner (and expor=
ter)
> > >    of the shared buffer bears the charge.
> > >  - Only memcg accounting supported. While this makes sense for system
> > >    heap buffers, other heaps (e.g., CMA heaps) will require selective=
ly
> > >    charging also for the dmem controller.
> >
> > Well that doesn't looks soo bad, it at least seems to tackle the proble=
m at hand for Android and some of other embedded use cases.
> >
> > I'm just not sure if this is future prove and will work for all use cas=
es, e.g. cloud gaming, native context for automotive etc...
> >
> > Essentially the problem boils down to two limitations:
> > 1) a piece of memory can only be charged to one cgroup, the framework d=
oesn't has a concept of charging shared memory to multiple groups
> > 2) when memory references in the form of file descriptors are passed be=
tween applications we have no way of changing the accounting to a different=
 cgroup
> >
> > The passing of the memory reference already has a well defined uAPI and=
 if we could solve those two limitations we not only solve the problem with=
out introducing new uAPI (with potential new security risks) but also solve=
 it for all other use cases which uses file descriptors as well as. E.g. me=
mfd, accel and GPU drivers etc...
>
> Honestly, adding a hook to fd-passing uAPI to manage charge transfers
> sounds like a promising solution requiring no uAPI changes. However,
> it still does not cover all paths, e.g., dup() or fork(). And shared
> memory sounds like a hard one to tackle, where deciding the best
> policy is more a per-usecase thing and would probably require
> userspace configuration.

I'm curious if anyone knows of a use case where FDs aren't involved at
all? It's possible to fork() or clone() with only a dmabuf mapping and
no FD. That sounds strange, and I'm not sure there's a real usecase
for transferring ownership with that approach, but figured I'd at
least pose the question.

> All in all, charge_pid_fd covers a
> well-defined and immediately practical subset. The UAPI cost is small
> and the mechanism is explicit about what it does and doesn't solve. A
> general solution, if it ever converges, would likely supersede
> charge_pid_fd for most cases, which is a fine outcome if it solves the
> problem more completely.
>
> Either way, if you have a specific approach in mind for solving any of
> the above limitations, I'd be happy to look into it further.
>
> BR,
> Albert.
>
> >
> > On the other hand it is really nice to finally see this tackled for at =
least DMA-buf heaps. On the GPU side I have seen just another try of a driv=
er doing some kind of special driver specific accounting to solve this just=
 a few weeks ago. And to be honest such single driver island approach have =
the tendency to break more often that they are working correctly.
> >
> > Regards,
> > Christian.
> >
> > >
> > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > > ---
> > >  Documentation/admin-guide/cgroup-v2.rst |  5 ++--
> > >  drivers/dma-buf/dma-buf.c               | 16 ++++---------
> > >  drivers/dma-buf/dma-heap.c              | 42 +++++++++++++++++++++++=
+++++++---
> > >  drivers/dma-buf/heaps/system_heap.c     |  2 --
> > >  include/uapi/linux/dma-heap.h           |  6 +++++
> > >  5 files changed, 53 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/=
admin-guide/cgroup-v2.rst
> > > index 8bdbc2e866430..824d269531eb1 100644
> > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > @@ -1636,8 +1636,9 @@ The following nested keys are defined.
> > >               structures.
> > >
> > >         dmabuf (npn)
> > > -             Amount of memory used for exported DMA buffers allocate=
d by the cgroup.
> > > -             Stays with the allocating cgroup regardless of how the =
buffer is shared.
> > > +             Amount of memory used for exported DMA buffers allocate=
d by or on
> > > +             behalf of the cgroup. Stays with the allocating cgroup =
regardless
> > > +             of how the buffer is shared.
> > >
> > >         workingset_refault_anon
> > >               Number of refaults of previously evicted anonymous page=
s.
> > > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > > index ce02377f48908..23fb758b78297 100644
> > > --- a/drivers/dma-buf/dma-buf.c
> > > +++ b/drivers/dma-buf/dma-buf.c
> > > @@ -181,8 +181,11 @@ static void dma_buf_release(struct dentry *dentr=
y)
> > >        */
> > >       BUG_ON(dmabuf->cb_in.active || dmabuf->cb_out.active);
> > >
> > > -     mem_cgroup_uncharge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabuf->si=
ze) / PAGE_SIZE);
> > > -     mem_cgroup_put(dmabuf->memcg);
> > > +     if (dmabuf->memcg) {
> > > +             mem_cgroup_uncharge_dmabuf(dmabuf->memcg,
> > > +                                       PAGE_ALIGN(dmabuf->size) / PA=
GE_SIZE);
> > > +             mem_cgroup_put(dmabuf->memcg);
> > > +     }
> > >
> > >       dmabuf->ops->release(dmabuf);
> > >
> > > @@ -764,13 +767,6 @@ struct dma_buf *dma_buf_export(const struct dma_=
buf_export_info *exp_info)
> > >               dmabuf->resv =3D resv;
> > >       }
> > >
> > > -     dmabuf->memcg =3D get_mem_cgroup_from_mm(current->mm);
> > > -     if (!mem_cgroup_charge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabuf-=
>size) / PAGE_SIZE,
> > > -                                   GFP_KERNEL)) {
> > > -             ret =3D -ENOMEM;
> > > -             goto err_memcg;
> > > -     }
> > > -
> > >       file->private_data =3D dmabuf;
> > >       file->f_path.dentry->d_fsdata =3D dmabuf;
> > >       dmabuf->file =3D file;
> > > @@ -781,8 +777,6 @@ struct dma_buf *dma_buf_export(const struct dma_b=
uf_export_info *exp_info)
> > >
> > >       return dmabuf;
> > >
> > > -err_memcg:
> > > -     mem_cgroup_put(dmabuf->memcg);
> > >  err_file:
> > >       fput(file);
> > >  err_module:
> > > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> > > index ac5f8685a6494..ff6e259afcdc0 100644
> > > --- a/drivers/dma-buf/dma-heap.c
> > > +++ b/drivers/dma-buf/dma-heap.c
> > > @@ -7,13 +7,17 @@
> > >   */
> > >
> > >  #include <linux/cdev.h>
> > > +#include <linux/cgroup.h>
> > >  #include <linux/device.h>
> > >  #include <linux/dma-buf.h>
> > >  #include <linux/dma-heap.h>
> > > +#include <linux/memcontrol.h>
> > > +#include <linux/sched/mm.h>
> > >  #include <linux/err.h>
> > >  #include <linux/export.h>
> > >  #include <linux/list.h>
> > >  #include <linux/nospec.h>
> > > +#include <linux/pidfd.h>
> > >  #include <linux/syscalls.h>
> > >  #include <linux/uaccess.h>
> > >  #include <linux/xarray.h>
> > > @@ -55,10 +59,12 @@ MODULE_PARM_DESC(mem_accounting,
> > >                "Enable cgroup-based memory accounting for dma-buf hea=
p allocations (default=3Dfalse).");
> > >
> > >  static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len,
> > > -                              u32 fd_flags,
> > > -                              u64 heap_flags)
> > > +                              u32 fd_flags, u64 heap_flags,
> > > +                              struct mem_cgroup *charge_to)
> > >  {
> > >       struct dma_buf *dmabuf;
> > > +     unsigned int nr_pages;
> > > +     struct mem_cgroup *memcg =3D charge_to;
> > >       int fd;
> > >
> > >       /*
> > > @@ -73,6 +79,22 @@ static int dma_heap_buffer_alloc(struct dma_heap *=
heap, size_t len,
> > >       if (IS_ERR(dmabuf))
> > >               return PTR_ERR(dmabuf);
> > >
> > > +     nr_pages =3D len / PAGE_SIZE;
> > > +
> > > +     if (memcg)
> > > +             css_get(&memcg->css);
> > > +     else if (mem_accounting)
> > > +             memcg =3D get_mem_cgroup_from_mm(current->mm);
> > > +
> > > +     if (memcg) {
> > > +             if (!mem_cgroup_charge_dmabuf(memcg, nr_pages, GFP_KERN=
EL)) {
> > > +                     mem_cgroup_put(memcg);
> > > +                     dma_buf_put(dmabuf);
> > > +                     return -ENOMEM;
> > > +             }
> > > +             dmabuf->memcg =3D memcg;
> > > +     }
> > > +
> > >       fd =3D dma_buf_fd(dmabuf, fd_flags);
> > >       if (fd < 0) {
> > >               dma_buf_put(dmabuf);
> > > @@ -102,6 +124,9 @@ static long dma_heap_ioctl_allocate(struct file *=
file, void *data)
> > >  {
> > >       struct dma_heap_allocation_data *heap_allocation =3D data;
> > >       struct dma_heap *heap =3D file->private_data;
> > > +     struct mem_cgroup *memcg =3D NULL;
> > > +     struct task_struct *task;
> > > +     unsigned int pidfd_flags;
> > >       int fd;
> > >
> > >       if (heap_allocation->fd)
> > > @@ -113,9 +138,20 @@ static long dma_heap_ioctl_allocate(struct file =
*file, void *data)
> > >       if (heap_allocation->heap_flags & ~DMA_HEAP_VALID_HEAP_FLAGS)
> > >               return -EINVAL;
> > >
> > > +     if (heap_allocation->charge_pid_fd) {
> > > +             task =3D pidfd_get_task(heap_allocation->charge_pid_fd,=
 &pidfd_flags);
> > > +             if (IS_ERR(task))
> > > +                     return PTR_ERR(task);
> > > +
> > > +             memcg =3D get_mem_cgroup_from_mm(task->mm);
> > > +             put_task_struct(task);
> > > +     }
> > > +
> > >       fd =3D dma_heap_buffer_alloc(heap, heap_allocation->len,
> > >                                  heap_allocation->fd_flags,
> > > -                                heap_allocation->heap_flags);
> > > +                                heap_allocation->heap_flags,
> > > +                                memcg);
> > > +     mem_cgroup_put(memcg);
> > >       if (fd < 0)
> > >               return fd;
> > >
> > > diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/he=
aps/system_heap.c
> > > index 03c2b87cb1112..95d7688167b93 100644
> > > --- a/drivers/dma-buf/heaps/system_heap.c
> > > +++ b/drivers/dma-buf/heaps/system_heap.c
> > > @@ -385,8 +385,6 @@ static struct page *alloc_largest_available(unsig=
ned long size,
> > >               if (max_order < orders[i])
> > >                       continue;
> > >               flags =3D order_flags[i];
> > > -             if (mem_accounting)
> > > -                     flags |=3D __GFP_ACCOUNT;
> > >               page =3D alloc_pages(flags, orders[i]);
> > >               if (!page)
> > >                       continue;
> > > diff --git a/include/uapi/linux/dma-heap.h b/include/uapi/linux/dma-h=
eap.h
> > > index a4cf716a49fa6..e02b0f8cbc6a1 100644
> > > --- a/include/uapi/linux/dma-heap.h
> > > +++ b/include/uapi/linux/dma-heap.h
> > > @@ -29,6 +29,10 @@
> > >   *                   handle to the allocated dma-buf
> > >   * @fd_flags:                file descriptor flags used when allocat=
ing
> > >   * @heap_flags:              flags passed to heap
> > > + * @charge_pid_fd:   optional pidfd of the process whose cgroup shou=
ld be
> > > + *                   charged for this allocation; 0 means charge the=
 calling
> > > + *                   process's cgroup
> > > + * @__padding:               reserved, must be zero
> > >   *
> > >   * Provided by userspace as an argument to the ioctl
> > >   */
> > > @@ -37,6 +41,8 @@ struct dma_heap_allocation_data {
> > >       __u32 fd;
> > >       __u32 fd_flags;
> > >       __u64 heap_flags;
> > > +     __u32 charge_pid_fd;
> > > +     __u32 __padding;
> > >  };
> > >
> > >  #define DMA_HEAP_IOC_MAGIC           'H'
> > >
> >
>
