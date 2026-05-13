Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72843AB278
	for <selinux@vger.kernel.org>; Wed, 13 May 2026 18:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697574; cv=pass; b=lu7i5vnV8b5hsKmX/aaLG+xgwjdMoEU3BftT5lcTUtONdoN0KUMgt34dP9akAODF2dpmIY3+EuAjIS6SzkbIk0dCftPLQHcYN4/aHfGKKl3TLu2x3CXkjoYK0c73nzzWBs8hUKKmCh7owhQvKGNtAyp6Y6lQQ5wy9vW6oYAcKbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697574; c=relaxed/simple;
	bh=QEESRfoyXDdi4AN3KpeDBP8YePxV7Zv0W2A2BR+aluM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jTdDZwkmgmkjggIRsusoZjmM1icTpanAAfvMAIyo/GQ7PSykuluKoaHgG6f2lUMnU3BJ+aeBzRa06Ok+X2W1b0HBBEjBo+VRvmEl6iTHHcgQ2DjgP3G83Mjwk9FUuFfe7wyZcdChCAM/75cwY9ez/QvC2nf+PZtFR9eqvbFrxI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DoODkc69; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qlhCKuvE; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DoODkc69";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qlhCKuvE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778697568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ROcBtD9Wr7UD9hLCfUAUnfLLz4HmQcTljHWV4B5LJ+A=;
	b=DoODkc69N/QjV5pHH1gkaev4P6ExGlhu9CaTDXlQbanlinHJ+BPBtehLYHQdKWVPSJMrpz
	+jpCLHoubs2VGScI09Uo3ktJtjb7q9I32b2jdi1sW6apZvcOOjiwBRo3J4d4Kn5fTZLdyJ
	1znGh7lTUdXbcYpD4T+HNuJzvzt1FgE=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-0xBOnTmKPgibkjzsGnj0mQ-1; Wed, 13 May 2026 14:39:27 -0400
X-MC-Unique: 0xBOnTmKPgibkjzsGnj0mQ-1
X-Mimecast-MFC-AGG-ID: 0xBOnTmKPgibkjzsGnj0mQ_1778697567
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-651c0aae418so14202545d50.2
        for <selinux@vger.kernel.org>; Wed, 13 May 2026 11:39:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778697567; cv=none;
        d=google.com; s=arc-20240605;
        b=bUn/ruclJet65lj/2aScGVV1gPiq6sh1yNbnyWQgzk6aNU43k7n6ebhfqI9qh3j9ww
         onWSY5r/ItC37oqRMypVH+ixB/P2cDqidbbxGFxNPrpAYAzD4/iNCrZHcjCdrGNEPtRA
         FOVPKP1K0pogRvoV7BzblLApasL+FxETbudeygPBUZdlLDBcFndOwJSOGUI5cyPk9sm/
         l0lk0zZoNsVSRZEQw1GedUd/GnGCEtf8O49fxbV/cesHTJB7sG2qWlbvJ4fAnfHVZWa7
         9PgOHyKCJYR6tCR8/zVGBXbANi77bLed6t5HbJMdp9kJfFd7OnIBt7TCl3fCozPH2U1R
         G2Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ROcBtD9Wr7UD9hLCfUAUnfLLz4HmQcTljHWV4B5LJ+A=;
        fh=RGYvzcgAVhjSCnKXyk8mxxvNNlKthh2Tm+eL2FtkaFw=;
        b=WAsEoerWrLSflYy5XWn+a4NWN0yjPGK5+QrzgrfBvp+ji5oRcDGl1z5htCjIFJrShf
         LP2Ia3OktGP7FNozNIPhB81eHinIEP2xJ/HfUjBAlz9ZD4K+IKOrjerF1OlqelnT0PzL
         dm56X4nB5CUlFGkkZ+T3UuTDKDmWEdAHKP6S9aml+oQ9datzEkZ0KjGm/gFMOy/1KYqU
         5bhGwR5dg4NH912VuPjvw0YBnlcMoKJjfw+LlEwtCDU6XbF5WNJj20kol2I9qKRN6gkW
         JsNo2jIho1W4xn18RMSR0wWhLzMG8MkxQVdAi+onNJe4QvyWYyjltrbR5Wrfrhh03CF1
         bLPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778697567; x=1779302367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROcBtD9Wr7UD9hLCfUAUnfLLz4HmQcTljHWV4B5LJ+A=;
        b=qlhCKuvE6Tn1b/X+EzNt9DzbvJl4gI9swkK4hHk9yAuyQ0mJB2IP9Cw4xbpb5/waQK
         Zl2SVqC34dQ5nFujzj38cm89F53xyCRx6urwtwAa9hRxBD4PWY2eDJBkIlObXBs0hxdM
         4KKRaQEakHaGpJIW5vLmRov8YoqV/V9h9eDKSnf4BtT4Fpwn226Dzbcka4+cHw69d6ga
         VJSbpmCu6qhCTaZQTjzatQxp15qpLdFaKar1TnOYylnPUnvhd4qTLZdxhNMHoCMkPOZE
         I1lK2Z6FFuaKI/9ymfGBj07G0TirYxheAvwXT9WSF7BRx6SUvDnQN7XPgtKlsbYJPNi3
         HxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778697567; x=1779302367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ROcBtD9Wr7UD9hLCfUAUnfLLz4HmQcTljHWV4B5LJ+A=;
        b=H/MFtVLXg+okYvfp6rxA/caWUBf+Go1Pzvw8ms/L/y3IGNBO1JmAc+v+F6eYDuEFfE
         nnqCUwnOP1wR7hWHD/JZAFRCjPeelGksJSmSgIhOwhXIB9M06q+GYaqz9h8PlAuaghhn
         EBBIz1tfjrqbG/6k1cy/zQXdyqMVfZ+ExY7n3KcLeULB8gnjvF8HNR7W9Aqfg7bgC5h+
         GGIqZ5huUBmZogTIj/Pp/40dRbaXbolAe84MurTDT1COIFPrhCXTzUF88Yp2Ti7vJ02h
         d4aZJm2Lw+WH87p5FKkest4DTlaqPhcYOI0Z97BG7wNzrPLCLf35Gr8e3yb99tPThu4C
         +UtQ==
X-Forwarded-Encrypted: i=1; AFNElJ/FvYs4YeLfHVPy+oe3o5Xs/YmgmylZjYhZ8YzamqzXYcCl7eVSLTOqwTh7Zk4YLEYdukP5eF+v@vger.kernel.org
X-Gm-Message-State: AOJu0YwfQqsVs+Gkw8YSNmiYjW2KtITBekoRtcmNBx+5/+IDddJPJnrS
	wCP4bzYJ5hX6gSgekFUO4hqtxuY1nisHozZpzH8L6cKzkqXj4zOLo5dRBL6ULt/jjJ53dzG/ZBO
	U4lAzPquWx+LhyuehYc4PeFG7FAX1VKFzhcovSpn+FEIzmP51ArV8mwF2cGZIwlfFlTwq0qt++S
	Ghycua8Ead8i3Dm47byZe5eVscJN+wxubAQg==
X-Gm-Gg: Acq92OF+GvuwspV4GmboLBPhiz7s9/aqwmD8mCX2GSQoLz772Bsj/jPzpQNcmsD4n/v
	Lf0n/m+YHNnYjlo/sk2CWwRKz58wm1yELJMSvPCoI250SHClphx/BulgSL39w30De5x5CsduUl6
	XE8Fwepe/kiURH00OFbeacdyb2tSG3xo+RPAVFMXPu9QluZ441yRr/tC1p3cEGWwNpFpDk7zUuU
	ds2cQ==
X-Received: by 2002:a05:690c:c50c:b0:7bd:b048:868 with SMTP id 00721157ae682-7c6a96520e4mr46024327b3.8.1778697566257;
        Wed, 13 May 2026 11:39:26 -0700 (PDT)
X-Received: by 2002:a05:690c:c50c:b0:7bd:b048:868 with SMTP id
 00721157ae682-7c6a96520e4mr46023727b3.8.1778697565577; Wed, 13 May 2026
 11:39:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <8ef38815-6ae9-4359-86d4-042554357639@amd.com> <CADSE00KZMJFYJ92XZa=r9EeJJRGT=SNChwOW-_jTznc7F79xGw@mail.gmail.com>
 <CABdmKX3R5faNgFva-HHVhtTcxJ0_BK9Rei3iTQcA+SRwdKv1Aw@mail.gmail.com>
In-Reply-To: <CABdmKX3R5faNgFva-HHVhtTcxJ0_BK9Rei3iTQcA+SRwdKv1Aw@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 13 May 2026 20:39:13 +0200
X-Gm-Features: AVHnY4J21kmZlUCM-w5PvXODvvzSq2oNDCUeY291YyLwyrvx79YmoPZ2KHgaokM
Message-ID: <CADSE00KO3gKEOEQ6dEwjgjbYGNotZJ-SRNYjhvqp74dJfu-msg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: "T.J. Mercier" <tjmercier@google.com>
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

On Wed, May 13, 2026 at 6:39=E2=80=AFPM T.J. Mercier <tjmercier@google.com>=
 wrote:
>
> On Wed, May 13, 2026 at 5:41=E2=80=AFAM Albert Esteve <aesteve@redhat.com=
> wrote:
> >
> > On Tue, May 12, 2026 at 12:14=E2=80=AFPM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> > >
> > > On 5/12/26 11:10, Albert Esteve wrote:
> > > > On embedded platforms a central process often allocates dma-buf
> > > > memory on behalf of client applications. Without a way to
> > > > attribute the charge to the requesting client's cgroup, the
> > > > cost lands on the allocator, making per-cgroup memory limits
> > > > ineffective for the actual consumers.
> > > >
> > > > Add charge_pid_fd to struct dma_heap_allocation_data. When set to
> > > > a valid pidfd, DMA_HEAP_IOCTL_ALLOC resolves the target task's
> > > > memcg and charges the buffer there via mem_cgroup_charge_dmabuf()
> > > > inside dma_heap_buffer_alloc(). Without charge_pid_fd, and with
> > > > the mem_accounting module parameter enabled, the buffer is charged
> > > > to the allocator's own cgroup.
> > > >
> > > > Additionally, commit 3c227be90659 ("dma-buf: system_heap: account f=
or
> > > > system heap allocation in memcg") adds __GFP_ACCOUNT to system-heap
> > > > page allocations. Keeping __GFP_ACCOUNT would charge the same pages
> > > > twice (once to kmem, once to MEMCG_DMABUF), thus remove it and rout=
e
> > > > all accounting through a single MEMCG_DMABUF path.
> > > >
> > > > Usage examples:
> > > >
> > > >   1. Central allocator charging to a client at allocation time.
> > > >      The allocator knows the client's PID (e.g., from binder's
> > > >      sender_pid) and uses pidfd to attribute the charge:
> > > >
> > > >        pid_t client_pid =3D txn->sender_pid;
> > > >        int pidfd =3D pidfd_open(client_pid, 0);
> > > >
> > > >        struct dma_heap_allocation_data alloc =3D {
> > > >            .len             =3D buffer_size,
> > > >            .fd_flags        =3D O_RDWR | O_CLOEXEC,
> > > >            .charge_pid_fd   =3D pidfd,
> > > >        };
> > > >        ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
> > > >        close(pidfd);
> > > >        /* alloc.fd is now charged to client's cgroup */
> > > >
> > > >   2. Default allocation (no pidfd, mem_accounting=3D1).
> > > >      When charge_pid_fd is not set and the mem_accounting module
> > > >      parameter is enabled, the buffer is charged to the allocator's
> > > >      own cgroup:
> > > >
> > > >        struct dma_heap_allocation_data alloc =3D {
> > > >            .len      =3D buffer_size,
> > > >            .fd_flags =3D O_RDWR | O_CLOEXEC,
> > > >        };
> > > >        ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, &alloc);
> > > >        /* charged to current process's cgroup */
> > > >
> > > > Current limitations:
> > > >
> > > >  - Single-owner model: a dma-buf carries one memcg charge regardles=
s of
> > > >    how many processes share it. Means only the first owner (and exp=
orter)
> > > >    of the shared buffer bears the charge.
> > > >  - Only memcg accounting supported. While this makes sense for syst=
em
> > > >    heap buffers, other heaps (e.g., CMA heaps) will require selecti=
vely
> > > >    charging also for the dmem controller.
> > >
> > > Well that doesn't looks soo bad, it at least seems to tackle the prob=
lem at hand for Android and some of other embedded use cases.
> > >
> > > I'm just not sure if this is future prove and will work for all use c=
ases, e.g. cloud gaming, native context for automotive etc...
> > >
> > > Essentially the problem boils down to two limitations:
> > > 1) a piece of memory can only be charged to one cgroup, the framework=
 doesn't has a concept of charging shared memory to multiple groups
> > > 2) when memory references in the form of file descriptors are passed =
between applications we have no way of changing the accounting to a differe=
nt cgroup
> > >
> > > The passing of the memory reference already has a well defined uAPI a=
nd if we could solve those two limitations we not only solve the problem wi=
thout introducing new uAPI (with potential new security risks) but also sol=
ve it for all other use cases which uses file descriptors as well as. E.g. =
memfd, accel and GPU drivers etc...
> >
> > Honestly, adding a hook to fd-passing uAPI to manage charge transfers
> > sounds like a promising solution requiring no uAPI changes. However,
> > it still does not cover all paths, e.g., dup() or fork(). And shared
> > memory sounds like a hard one to tackle, where deciding the best
> > policy is more a per-usecase thing and would probably require
> > userspace configuration.
>
> I'm curious if anyone knows of a use case where FDs aren't involved at
> all? It's possible to fork() or clone() with only a dmabuf mapping and
> no FD. That sounds strange, and I'm not sure there's a real usecase
> for transferring ownership with that approach, but figured I'd at
> least pose the question.

Yeah, that's a good point. I do not really have a usecase myself for
fork(), just thought of it as a posible gap/uncovered path.

>
> > All in all, charge_pid_fd covers a
> > well-defined and immediately practical subset. The UAPI cost is small
> > and the mechanism is explicit about what it does and doesn't solve. A
> > general solution, if it ever converges, would likely supersede
> > charge_pid_fd for most cases, which is a fine outcome if it solves the
> > problem more completely.
> >
> > Either way, if you have a specific approach in mind for solving any of
> > the above limitations, I'd be happy to look into it further.
> >
> > BR,
> > Albert.
> >
> > >
> > > On the other hand it is really nice to finally see this tackled for a=
t least DMA-buf heaps. On the GPU side I have seen just another try of a dr=
iver doing some kind of special driver specific accounting to solve this ju=
st a few weeks ago. And to be honest such single driver island approach hav=
e the tendency to break more often that they are working correctly.
> > >
> > > Regards,
> > > Christian.
> > >
> > > >
> > > > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > > > ---
> > > >  Documentation/admin-guide/cgroup-v2.rst |  5 ++--
> > > >  drivers/dma-buf/dma-buf.c               | 16 ++++---------
> > > >  drivers/dma-buf/dma-heap.c              | 42 +++++++++++++++++++++=
+++++++++---
> > > >  drivers/dma-buf/heaps/system_heap.c     |  2 --
> > > >  include/uapi/linux/dma-heap.h           |  6 +++++
> > > >  5 files changed, 53 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentatio=
n/admin-guide/cgroup-v2.rst
> > > > index 8bdbc2e866430..824d269531eb1 100644
> > > > --- a/Documentation/admin-guide/cgroup-v2.rst
> > > > +++ b/Documentation/admin-guide/cgroup-v2.rst
> > > > @@ -1636,8 +1636,9 @@ The following nested keys are defined.
> > > >               structures.
> > > >
> > > >         dmabuf (npn)
> > > > -             Amount of memory used for exported DMA buffers alloca=
ted by the cgroup.
> > > > -             Stays with the allocating cgroup regardless of how th=
e buffer is shared.
> > > > +             Amount of memory used for exported DMA buffers alloca=
ted by or on
> > > > +             behalf of the cgroup. Stays with the allocating cgrou=
p regardless
> > > > +             of how the buffer is shared.
> > > >
> > > >         workingset_refault_anon
> > > >               Number of refaults of previously evicted anonymous pa=
ges.
> > > > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > > > index ce02377f48908..23fb758b78297 100644
> > > > --- a/drivers/dma-buf/dma-buf.c
> > > > +++ b/drivers/dma-buf/dma-buf.c
> > > > @@ -181,8 +181,11 @@ static void dma_buf_release(struct dentry *den=
try)
> > > >        */
> > > >       BUG_ON(dmabuf->cb_in.active || dmabuf->cb_out.active);
> > > >
> > > > -     mem_cgroup_uncharge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabuf->=
size) / PAGE_SIZE);
> > > > -     mem_cgroup_put(dmabuf->memcg);
> > > > +     if (dmabuf->memcg) {
> > > > +             mem_cgroup_uncharge_dmabuf(dmabuf->memcg,
> > > > +                                       PAGE_ALIGN(dmabuf->size) / =
PAGE_SIZE);
> > > > +             mem_cgroup_put(dmabuf->memcg);
> > > > +     }
> > > >
> > > >       dmabuf->ops->release(dmabuf);
> > > >
> > > > @@ -764,13 +767,6 @@ struct dma_buf *dma_buf_export(const struct dm=
a_buf_export_info *exp_info)
> > > >               dmabuf->resv =3D resv;
> > > >       }
> > > >
> > > > -     dmabuf->memcg =3D get_mem_cgroup_from_mm(current->mm);
> > > > -     if (!mem_cgroup_charge_dmabuf(dmabuf->memcg, PAGE_ALIGN(dmabu=
f->size) / PAGE_SIZE,
> > > > -                                   GFP_KERNEL)) {
> > > > -             ret =3D -ENOMEM;
> > > > -             goto err_memcg;
> > > > -     }
> > > > -
> > > >       file->private_data =3D dmabuf;
> > > >       file->f_path.dentry->d_fsdata =3D dmabuf;
> > > >       dmabuf->file =3D file;
> > > > @@ -781,8 +777,6 @@ struct dma_buf *dma_buf_export(const struct dma=
_buf_export_info *exp_info)
> > > >
> > > >       return dmabuf;
> > > >
> > > > -err_memcg:
> > > > -     mem_cgroup_put(dmabuf->memcg);
> > > >  err_file:
> > > >       fput(file);
> > > >  err_module:
> > > > diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.=
c
> > > > index ac5f8685a6494..ff6e259afcdc0 100644
> > > > --- a/drivers/dma-buf/dma-heap.c
> > > > +++ b/drivers/dma-buf/dma-heap.c
> > > > @@ -7,13 +7,17 @@
> > > >   */
> > > >
> > > >  #include <linux/cdev.h>
> > > > +#include <linux/cgroup.h>
> > > >  #include <linux/device.h>
> > > >  #include <linux/dma-buf.h>
> > > >  #include <linux/dma-heap.h>
> > > > +#include <linux/memcontrol.h>
> > > > +#include <linux/sched/mm.h>
> > > >  #include <linux/err.h>
> > > >  #include <linux/export.h>
> > > >  #include <linux/list.h>
> > > >  #include <linux/nospec.h>
> > > > +#include <linux/pidfd.h>
> > > >  #include <linux/syscalls.h>
> > > >  #include <linux/uaccess.h>
> > > >  #include <linux/xarray.h>
> > > > @@ -55,10 +59,12 @@ MODULE_PARM_DESC(mem_accounting,
> > > >                "Enable cgroup-based memory accounting for dma-buf h=
eap allocations (default=3Dfalse).");
> > > >
> > > >  static int dma_heap_buffer_alloc(struct dma_heap *heap, size_t len=
,
> > > > -                              u32 fd_flags,
> > > > -                              u64 heap_flags)
> > > > +                              u32 fd_flags, u64 heap_flags,
> > > > +                              struct mem_cgroup *charge_to)
> > > >  {
> > > >       struct dma_buf *dmabuf;
> > > > +     unsigned int nr_pages;
> > > > +     struct mem_cgroup *memcg =3D charge_to;
> > > >       int fd;
> > > >
> > > >       /*
> > > > @@ -73,6 +79,22 @@ static int dma_heap_buffer_alloc(struct dma_heap=
 *heap, size_t len,
> > > >       if (IS_ERR(dmabuf))
> > > >               return PTR_ERR(dmabuf);
> > > >
> > > > +     nr_pages =3D len / PAGE_SIZE;
> > > > +
> > > > +     if (memcg)
> > > > +             css_get(&memcg->css);
> > > > +     else if (mem_accounting)
> > > > +             memcg =3D get_mem_cgroup_from_mm(current->mm);
> > > > +
> > > > +     if (memcg) {
> > > > +             if (!mem_cgroup_charge_dmabuf(memcg, nr_pages, GFP_KE=
RNEL)) {
> > > > +                     mem_cgroup_put(memcg);
> > > > +                     dma_buf_put(dmabuf);
> > > > +                     return -ENOMEM;
> > > > +             }
> > > > +             dmabuf->memcg =3D memcg;
> > > > +     }
> > > > +
> > > >       fd =3D dma_buf_fd(dmabuf, fd_flags);
> > > >       if (fd < 0) {
> > > >               dma_buf_put(dmabuf);
> > > > @@ -102,6 +124,9 @@ static long dma_heap_ioctl_allocate(struct file=
 *file, void *data)
> > > >  {
> > > >       struct dma_heap_allocation_data *heap_allocation =3D data;
> > > >       struct dma_heap *heap =3D file->private_data;
> > > > +     struct mem_cgroup *memcg =3D NULL;
> > > > +     struct task_struct *task;
> > > > +     unsigned int pidfd_flags;
> > > >       int fd;
> > > >
> > > >       if (heap_allocation->fd)
> > > > @@ -113,9 +138,20 @@ static long dma_heap_ioctl_allocate(struct fil=
e *file, void *data)
> > > >       if (heap_allocation->heap_flags & ~DMA_HEAP_VALID_HEAP_FLAGS)
> > > >               return -EINVAL;
> > > >
> > > > +     if (heap_allocation->charge_pid_fd) {
> > > > +             task =3D pidfd_get_task(heap_allocation->charge_pid_f=
d, &pidfd_flags);
> > > > +             if (IS_ERR(task))
> > > > +                     return PTR_ERR(task);
> > > > +
> > > > +             memcg =3D get_mem_cgroup_from_mm(task->mm);
> > > > +             put_task_struct(task);
> > > > +     }
> > > > +
> > > >       fd =3D dma_heap_buffer_alloc(heap, heap_allocation->len,
> > > >                                  heap_allocation->fd_flags,
> > > > -                                heap_allocation->heap_flags);
> > > > +                                heap_allocation->heap_flags,
> > > > +                                memcg);
> > > > +     mem_cgroup_put(memcg);
> > > >       if (fd < 0)
> > > >               return fd;
> > > >
> > > > diff --git a/drivers/dma-buf/heaps/system_heap.c b/drivers/dma-buf/=
heaps/system_heap.c
> > > > index 03c2b87cb1112..95d7688167b93 100644
> > > > --- a/drivers/dma-buf/heaps/system_heap.c
> > > > +++ b/drivers/dma-buf/heaps/system_heap.c
> > > > @@ -385,8 +385,6 @@ static struct page *alloc_largest_available(uns=
igned long size,
> > > >               if (max_order < orders[i])
> > > >                       continue;
> > > >               flags =3D order_flags[i];
> > > > -             if (mem_accounting)
> > > > -                     flags |=3D __GFP_ACCOUNT;
> > > >               page =3D alloc_pages(flags, orders[i]);
> > > >               if (!page)
> > > >                       continue;
> > > > diff --git a/include/uapi/linux/dma-heap.h b/include/uapi/linux/dma=
-heap.h
> > > > index a4cf716a49fa6..e02b0f8cbc6a1 100644
> > > > --- a/include/uapi/linux/dma-heap.h
> > > > +++ b/include/uapi/linux/dma-heap.h
> > > > @@ -29,6 +29,10 @@
> > > >   *                   handle to the allocated dma-buf
> > > >   * @fd_flags:                file descriptor flags used when alloc=
ating
> > > >   * @heap_flags:              flags passed to heap
> > > > + * @charge_pid_fd:   optional pidfd of the process whose cgroup sh=
ould be
> > > > + *                   charged for this allocation; 0 means charge t=
he calling
> > > > + *                   process's cgroup
> > > > + * @__padding:               reserved, must be zero
> > > >   *
> > > >   * Provided by userspace as an argument to the ioctl
> > > >   */
> > > > @@ -37,6 +41,8 @@ struct dma_heap_allocation_data {
> > > >       __u32 fd;
> > > >       __u32 fd_flags;
> > > >       __u64 heap_flags;
> > > > +     __u32 charge_pid_fd;
> > > > +     __u32 __padding;
> > > >  };
> > > >
> > > >  #define DMA_HEAP_IOC_MAGIC           'H'
> > > >
> > >
> >
>

