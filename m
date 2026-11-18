Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795009127;
	b=Bj0ievcjVyNtuOxwnHsHBS4PUdTjn+X4lGMUrIOKyy1FMrOqzjzah7L3R6dSrbmPhaEB
	 wZizPwDule1jcYn7ODrzqdHMZXijvmpJ+gJ/ZJPimK8D8ytkmPvRIPo78RaysT9xG+jdf
	 00g2+FdyPXkigveoo+km894K4GBQ9r/HQW9JopINRkjE+UKFTJtd6yjiwmOE6giWCUfK3
	 BYDpVOALbmpXf8hjka0gMiUoMmDKMXs5+yUbnZZTIh185COkzpq8f8opXndsjCxpfQMGQ
	 uikTJQ8q+grYf/qZZjWh6RegRGMeh7/wAFseBJT8LdwO90Q8go8bVcw6i58l74B3DmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009127;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=h50xYCZDbBstrT/18dKKndyJ3XtJH6sY5/J/QnXGpDQ=;
	b=pNWgBwPA6M3Ko4bRkvsbfUgjMdC+oZ1uE+ev9J+54JKnoALZSGS/y6yOsrZec53JCxp1
	 x41xAfigDbzcMNOzTajKbKsh/YwLKrK74ADG7fTj76uilnWbtI3W4GSuJWZte/tjdJYK/
	 n70IQXNTmiDdPX5m+VmpohUaDisZH0b1jZwrV2dhRsFjk/O1OOQfkUWvOQznIA1dvZFik
	 7zZy7KasWNYlF+RadlHoyeNH3tRSH39wxlSVm9yPLUbSRqbqpXBv3zBBfFG/4ssHZjPwt
	 nz4wqHvs8d2JbEUzxaFfsPqb6OMaZ3cyH+ikKppGQH5AQbpwHDKKjGRLhEG9E3VGPaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V7jLsO7j;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MiHGt89R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD2260A2608
	for <selinux@vger.kernel.org>; Wed, 18 Nov 2026 13:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFD2260A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V7jLsO7j;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MiHGt89R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795009125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h50xYCZDbBstrT/18dKKndyJ3XtJH6sY5/J/QnXGpDQ=;
	b=V7jLsO7jo0wHH8sN8zK7RcmF7NZ5CN/dPSzoGDt8zGqju9Az31BcfCPoqbDBuHpWKRlRyS
	Tfa/ceL/jMEqwnDwpP4mHqm5WiU6KJhG5kjI2NHq/vHYJqGxYPG3wIILZ3dIvqG+bUKiNJ
	xGZyqy/3nMHLoinS7ooK67DrlERPj6U=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-qwiI_cGXPzWNmHI3lhLFEg-1; Wed, 18 Nov 2026 08:38:44 -0500
X-MC-Unique: qwiI_cGXPzWNmHI3lhLFEg-1
X-Mimecast-MFC-AGG-ID: qwiI_cGXPzWNmHI3lhLFEg_1795009124
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-8b4d09fefd7so8992997b3.1
        for <selinux@vger.kernel.org>; Wed, 18 Nov 2026 05:38:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795009124; cv=none;
        d=google.com; s=arc-20260327;
        b=AJTs8SksllijG1ZohglEGMd5zdXA2/rasprkAGn7PsfgfNO7k2L4OvEXvdb25Tot3f
         pnRFvzBCsCvnHR2PXfdmjRYpALK4LwSXBLGL299IsbDKBIVPlsCvz+3jlzdCGNm5HwTY
         kfupbpr/vDNQ2/vp0/bVTjkCgq+jEnTk8/lX+xmZyioTc7V8E/zwYrwZsWDHxBlBiQLh
         Bhg8jc1BNDeQ6DUcW9oD/bcJT7VNn5UCaPmLZ1jRfNMJVCK736T0DjvN9ZcyJWDWb+Dh
         bo8zzgAEBQhyHFN2G2pj0Fso6uYP2GxClM9M3YFDNpN9S8AbhpSDM27MWrX9CJ9Kj0AX
         0iUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h50xYCZDbBstrT/18dKKndyJ3XtJH6sY5/J/QnXGpDQ=;
        fh=n47UPB33gG90D8YWxe7q86Uu0kPj0R0f6JW3wk45Tks=;
        b=HaPdAMQQoEG/MrllXYKq0prhKP6P8EOs+e/XP8Um202MYIwnRAcvFvY975q3QVdB/O
         dnC2eiwKErSo/Xd9MwLBUNG/CYDOSi/cgZcrU5aX10tOrvVnQzZasiireAS24cNnRAWb
         yDsyWQUhCXVOr3cluPZbLNJ6SQaGnaGGGN+ETLeWuTROFREPqRfL09jOlxXwGKZuhn2R
         9TQSx6QJVhus6xbkSVsGumvR10exg93YC7LELwQEOvwaDMMIHoUtD3bvmmlHDJlYah7j
         uSUC5wEwnEBLZkNBx+bPVQ8lE7EqWndwrh34W/jn1Lh6otXTmdJKH5eal8AxzwSeIYkU
         zJig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795009124; x=1795613924; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h50xYCZDbBstrT/18dKKndyJ3XtJH6sY5/J/QnXGpDQ=;
        b=MiHGt89RGmOWwRF6HBuKiQQx1CCrlWNI1Hr3n1UYVhcdLz+4P047hbjYrlp6yHpTPE
         FsLfA4qY1TU+nApiWX+7zvZFahR/TIAC+EWuUFGE5I9UP3bImMt/V3vq6csp0U5nNkL0
         9jaB7lgEgQHKTNbeNYZ6jQu4fKFOkbqyma/PNoT0dpl1aSManfDXteYD/MYkZMX2LdyE
         1bWH5jU7D55SuKphsqvPku41buZGHsV7637AIfVPAdZoNikkmE4+U2F3TsUXwWPw5Pk/
         kc+cfm9qUAZ8KDzTkyLSwoVfeMcxAwqHnYXkHKeFF+deLbRBs4m8EWXD6D4sSfTCMZaQ
         EEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795009124; x=1795613924;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h50xYCZDbBstrT/18dKKndyJ3XtJH6sY5/J/QnXGpDQ=;
        b=QX8cIT3xS/uBVJ1lh65hENn5eK6UBzbK0zqStg/j3L/v8OAHBauEtFzqX+bcBdV89s
         Fdw2VxB2PShrYNOcVE5+zwAy4ig8oK5tFxx90wgWyf/z7/euCufWqwQQg1YygzqduP2Y
         zVo86ZXYmIbitxLNgOXh4NTqV6bQZ/R/AwidcH0LTWm/dhdXvA56vzbyqYOr7Vwe0SnO
         eov8bDmN4M5F6UwGMGcQOVFOToMGq8YyMtbI1EgDlQCwdNec49rIHIySPVDtCnjZMXHw
         Ob+c0BFzZ1zpEbSSKrno390llWhsm1zyQymWCCi4KuBWS2wungAMLBSo4VVmvW4vl//8
         skMQ==
X-Forwarded-Encrypted: i=1; AL+hErEI5j799FWC8X53zP6Mx+NglReq7GgTp811pGFRgPvvimio+ZfGZFg3sgA9ZP0kUw0H8cv1KtKk@vger.kernel.org
X-Gm-Message-State: APuU4Z8wkV+O+MFeSoS4h/ylI30eD7xI/JAhkq8t+8z50pCe5Xopy+G5
	P8EUDDK3AG4Xu1rkYfn/0C6p02Rmuo7YNozrNBQCJbZi6Ft48ruhR9GFlA+uI6cSEde89Yk9N89
	51szJfglHUkFqWdunOJ8tE1e/HhshY4Crug0OxyrvPfN2TRd2BMxqAAjWpbWQuiw4PyAGG40PLt
	tiBUDNv532CNEr+iZ2ev2RLJ9ej8513v5T+Q==
X-Gm-Gg: AZFdTZdy57VsXaxWelOkWNl1VUhAZyqZYfdi6b63ocydlz+XroQytxUh8Oh7Bmh/asQ
	oYUgCZJ1rnrXnFVU6b02b7Gj1M3i+Pp67s8nkV9Djf2Jl8Zdexdy7QMrxm/gjjiQpaxTYR7DOP0
	krpAxYCjio/9cMaXH4UD8Tm07Fs1YtCGbDdm4DBOg3LZzpy+AUmeROZxDe
X-Received: by 2002:a05:690c:368a:b0:873:5bb2:6bfd with SMTP id 00721157ae682-8b4fed83351mr10017967b3.39.1795009120675;
        Wed, 18 Nov 2026 05:38:40 -0800 (PST)
X-Received: by 2002:a05:690c:368a:b0:873:5bb2:6bfd with SMTP id
 00721157ae682-8b4fed83351mr10017817b3.39.1795009119849; Wed, 18 Nov 2026
 05:38:39 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-v2_20230123_tjmercier_google_com-v5-0-1ce975f2a9ad@redhat.com>
 <4356992ac4fb7876fb5759189ba4b492@paul-moore.com>
In-Reply-To: <4356992ac4fb7876fb5759189ba4b492@paul-moore.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 18 Nov 2026 14:38:28 +0100
X-Gm-Features: Aa3M54php6hihR6Ihi3l34Ri9nQdKaLYB3Ss2kJeRmi5f3v9ab0vBjDa0q2nnvI
Message-ID: <CADSE00JyTwrbNh4r8PZWLqOHWpepyHkaL+9fkc+AbVRmCc-f-g@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] memcg: dma-buf cgroup accounting and charge transfer
To: Paul Moore <paul@paul-moore.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Christian Brauner <brauner@kernel.org>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	=?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, 
	Philipp Stanner <phasta@kernel.org>, airlied@gmail.com, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	echanude@redhat.com, mripard@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 11:54=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> On Nov 17, 2026 Albert Esteve <aesteve@redhat.com> wrote:
> >
> > Shared-memory allocator services (e.g., Android's gralloc)
> > allocate dma-bufs on behalf of client processes in different
> > cgroups. Today those allocations are charged to the allocator's
> > own cgroup, leaving client cgroups with no visibility into their
> > actual memory consumption and defeating resource limits.
> >
> > This series adds memory cgroup accounting for dma-buf allocations,
> > building on T.J. Mercier's earlier series [1] and incorporating
> > feedback from previous versions and LPC discussions [2].
> >
> > Patch 1 introduces the MEMCG_DMABUF stat and the
> > obj_cgroup_reserve_dmabuf()/obj_cgroup_cancel_dmabuf() and
> > mem_cgroup_commit_dmabuf()/mem_cgroup_uncharge_dmabuf() helpers
> > in mm/memcontrol.c
> >
> > Patch 2 wires up the charging policy: dma_buf_export() stores
> > exp_info.objcg and updates the stat, a new charge_fd field in
> > DMA_HEAP_IOCTL_ALLOC accepts a pidfd or cgroupfd to identify
> > the target cgroup, and __GFP_ACCOUNT is removed from system-heap
> > allocations to avoid double counting.
> >
> > Patch 3 adds DMA_BUF_IOCTL_XFER_CHARGE, a general ioctl on any
> > dma-buf fd to transfer charges post-allocation. This covers the
> > double-hop allocator case (SurfaceFlinger -> gralloc -> kernel)
> > and works for buffers from any exporter that opts in. Charging
> > is gated by dmabuf->objcg being set at export time, ensuring that
> > transfer is only applied for buffers backed by system memory where
> > size reflects actual bytes. If the receiving cgroup lacks capacity
> > for the charge, the ioctl returns -ENOMEM and the original charge
> > is preserved.
> >
> > Patches 4-7 add access control for cross-cgroup charging. Letting
> > userspace decide who to charge needs to be a privileged operation
> > because it has material impact on OOM decision and resource limits.
> > Charging outside the caller's own memcg subtree requires
> > CAP_SYS_RESOURCE. On top of that, LSM hooks gate the two charge_fd
> > flavours: security_memcg_charge_task() gates the pidfd path (target
> > identified by task credentials) and security_memcg_charge_cgroup()
> > gates the cgroupfd path (target identified by cgroup directory label),
> > with SELinux implementations using process2:charge_to and
> > cgroup:charge_to permissions.
>
> I'm probably misunderstanding the description here, but in both cases
> (the pidfd or cgroupfd case), ultimately the cgroup is charged, yes?  In
> the cgroupfd case it is more direct, but in the pidfd case it is still
> the cgroup associated with the process identified by pidfd, yes?

Your understanding is correct here.

>
> If that's the case - and it very well may not be (!) - it probably makes
> more sense to combine the two SELinux access controls into one.  Yes, the
> LSM hooks and callbacks would likely need to be different due to the
> mechanics of it, but the permission check "cgroup/charge" could be the
> same.

Combining SELinux access controls makes sense to me. I kept them split
because I wanted to preserve granularity between the two flavours, and
process2 seemed like a natural fit for the pidfd path, but I guess it
can still be achieved with a single permission through the target
types.

I'll rework for v6. So, in the pidfd case the check target would
remain the process's domain:

   allow allocator_t client_t:cgroup charge_to;

where allocator_t is the domain requesting the charge (i.e., the
central allocator), and client_t is the domain of the process the
pidfd refers to. The groupfd path would check the cgroup directory
label like so:

  allow allocator_t cgroup_t:cgroup charge_to;

Would that be ok?

>
> > Patch 8 adds selftests. The tests and vmtest script were mostly
> > written by an LLM, closely following the style of the surrounding
> > tests and the virtme-ng setup. All code has been reviewed and tested.
>
> I think we need to have selinux-testsuite tests to go along with
> this, especially as this would be the first patchset to add cgroup
> controls.  Historically I've pushed back on piecemeal cgroup additions,
> pushing for some basic design of how to manage access controls for
> resource management first, but since evidently no one wants to do that,
> we really do need tests.
>
> https://github.com/SELinuxProject/selinux-testsuite

Agreed! I was already playing with it between the last version and
this one. I have some tests drafted, more or less. I was unfamiliar
with the testsuite, so instead of offloading the work to an LLM, I
tried to follow along and proceeded too slowly.

I will link a PR when sending the next version.

>
> > Known limitations:
> >
> > - Single-owner model: a dma-buf carries one memcg charge regardless
> >   of how many processes share it.
>
> Once again, I'm sure I'm misunderstanding things, but are you saying
> that multiple cgroups can end up sharing the same dma-buf despite
> only one of the cgroups taking the accounting hit?

Yes, you are correct. A dma-buf (its fd) can be shared by multiple
processes from multiple cgroups, but only one holds the charge. With
this series it can be transferred, but never shared.

Sharing could be a follow-up series. Perhaps splitting the charge
equally? But sharing is a big problem on its own, so I preferred to
keep it out of this series.

>
> Hopefully the charged cgroup is deterministic?

Yes, the charged cgroup is deterministic: it is set at allocation, and
only moves via an explicit ioctl.

>
> > - Only memcg accounting. CMA heaps would additionally need dmem
> >   controller integration.
>
> Do you have a rough idea of how that would work?  I ask only because I'm
> interested in seeing if that would require an additional LSM hook or if
> there is some way we could leverage the same hook(s) used here.

Rough idea, yes. Today, no dma-buf allocation charges dmem at all, and
of course no target charging either. The first goal for CMA is simply
getting those heaps accounted. In that regard, Eric Chanudet has a
series making CMA allocations memcg-accountable with per-area counter
[1], and is working on extending that approach to dmem. It's a bit on
hold waiting for the feedback on this series.

But afaik the cross-cgroup charging and central allocator problem is
mainly a system-memory one. Whether dmem ever needs the same
cross-cgroup attribution (e.g., DRM central allocator wanting to
charge clients' dmem budgets) is not clear to me.

Nonetheless, if it does, the internals should be mostly the same;
everything, including the permission checks is controller-agnostic.
Only the controller performing the charge changes. I expect no
additional hook is required.

[1] https://lore.kernel.org/all/20260821-cma-memcg-regions-v1-0-d21b165b844=
0@redhat.com/

>
> > - If a transfer of an uncharged buffer fails, the buffer remains
> >   charged to the original cgroup. The allocator (userspace) is
> >   expected to handle this (retry, free, ...).
> > - The LSM hooks are intentionally narrow. Broader cgroup access control=
s
> >   (e.g. for the memfd/kexec handover case [2]) could be a separate effo=
rt
> >   reusing the same pattern.
> > - Only system heap sets exp_info.objcg today. Other exporters
> >   (DRM, V4L2, etc.) can opt in by setting it, but are not
> >   covered by this series.
> > - Related to the above: lazy backing-store allocation is not supported.
> >   This can be extended later, e.g., by adding a flag on the dma-buf
> >   struct for explicitly marking when memory is committed.
>
> Similar to the CMA case, any rough ideas on what this would look like?

Yes, again I have a rough idea. We already separate reserve and commit
operations, so the idea is to delay when a charge is committed. For
that we can use a flag in the dma-buf struct to mark when the memory
is committed. The limit is still enforced up front (so a lazy exporter
cannot overcommit), and the stat reflects the actual allocation.

The permission model is also unchanged for this case. The flag only
affects when the stat will reflect the charge.

Thanks!
Albert.

>
> > Note on TTM/GPU accounting [3]: that effort charges system memory
> > allocated for GPU buffers per page, with its own stats (gpu_active
> > and gpu_reclaim). This series charges at the dma-buf level, for
> > memory with no memory.stat category of its own; exporters whose
> > memory is already charged by their allocator must not opt in, so
> > the two do not overlap.
> >
> > [1] https://lore.kernel.org/cgroups/20230109213809.418135-1-tjmercier@g=
oogle.com/
> > [2] https://lpc.events/event/20/contributions/2416/
> > [3] https://lore.kernel.org/all/20260706052330.1110909-1-airlied@gmail.=
com/
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
>
> --
> paul-moore.com
>

