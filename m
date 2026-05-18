Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FB6396B6F
	for <selinux@vger.kernel.org>; Mon, 18 May 2026 21:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779138795; cv=pass; b=oJ99uC7HqxJyFejwSIKz9gyAveDaonHhMGFSfKKsc6uwB5RqTgk5VIfLuN1U2GfTw4pHmnUb5u+An+FMlwte8fpnwwbnmEregDle+Pz/pW/oMa9rq1tVkaKSdcHdl8SqOMEt1adJIAu1yHHDY73UnRbv+RaT0X3ejwRXnX+rR0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779138795; c=relaxed/simple;
	bh=ccaZOdGzatq1Y9GRrbmh06kJXINJhjC+T++v+WFIsqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7yDKHWvVfnemqZJKkYqa14aFIApDA4hQJWn3WfFKEqaCACeflucHuLap0QNM9cc33VpSC2OQAycPP2hvddhRHryUbvvjERE4KLAEy8xieWRCoPJHTh1NGqgL8hRL6bn3w3DmxUhtsnJRJ0xhqT/Br9GhWDL4IgSo1eAgEvmyZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=orsRSfAg; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="orsRSfAg"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891ca4ce02so1285e9.1
        for <selinux@vger.kernel.org>; Mon, 18 May 2026 14:13:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779138792; cv=none;
        d=google.com; s=arc-20240605;
        b=QwfiBGPdHmZDuyHDKxZfTFQWPLjePPoMVQIcdN8v4xElpN9lZbcyOyhyOBPDsowjWq
         mFT2mdorHQ48PGMbw04cP3CmUOuqdYevjA8QMCT7xPeMDVskbSmj/1c2ae39q76//0/x
         VyyKZZPbrMNYqNiy6ByA/AXYs0fWNeAt6yDUH//a5Z5fgu8RIrHiSu63oFgf6hvYdwBA
         WKijpECD+r5Vit+lmWiSwIQkULP5CAG+q63zGKEr/8euUZqFDYKtj/W0j1oAT8pAJWUr
         HtMbtM+1k+PrVxyO0fPb8t57lwyXjJiMxn6sh4lRa27Sj7t1fDaQfzytH0mC0bLbNYcc
         fXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TdtUTbNXCNhmI+LuqRwGM1avFF2CHCXidccR+1bE1AI=;
        fh=Sni/8QrKOo8bUNIwf21FXjfhaVvoSwkB2MniaFL2U1w=;
        b=LGLhVb+2abC4wwhOGR0MElhDLNAv0oerxoMBb009Io0Iyj2b31wQjJMh7eFFkuZm+r
         11tPC126za8M33dyyL6zKc+5TxNx+0rFSZy3orsqkA4Vqzzvq7+VKsZIpw2/6FkAX7Fz
         EyZB4RJ5P2zaY7ux+Ys/JC41ekTKf2mOmQqK9A6jf/jO6+6UXeuruJ9UuqzGSM8x0bqA
         vPBHXIQzqLjfHRJ15nPDNdbxCegkvs6UN8Iek9WqUCsdh2/U/di7XflDrCzIc4x/P23k
         P3vzsMz32qSooPM6WDBzZXWTXK7Wgy5K/ETVrS9DI5CcqXzNAv0JOUmMp2t77r2ERxTF
         9M5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779138792; x=1779743592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdtUTbNXCNhmI+LuqRwGM1avFF2CHCXidccR+1bE1AI=;
        b=orsRSfAg9qfNqkS3qBn0ZC7nna3jIFgzoW9yfOadQVpaAxeZX5+y7haVzfBO7L5SoD
         d/9rKT1nWNO3Gczb962hk8sqoM4bRSFKFSqAbiGnv9hu4vE3PECVaC/P6bUYgeBlulJW
         PKbvIf3ud3ocFdrLYRC7PgQqGcDHnLssRxZC1knemFcsRZTXeDiDT+HOzfWlYkpG5c5S
         qcwbIDoAoF0pJbdE6d7aPDiWqSzvorwm8uhe+k4wdFGvfMt94wBp7Ph9OCzGFTKGmYZ8
         hBFPj0tteO4XHLo+zGucxfMPeWTHcffHDVpVPwVze56sduwUGJJIn9toyHr8t/x7gnGk
         ZNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779138792; x=1779743592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TdtUTbNXCNhmI+LuqRwGM1avFF2CHCXidccR+1bE1AI=;
        b=NUMu7MVc8gFucp386hK6YWsRGdv4mRLblcUz/DlG5UjjmJemH0TojkYFBLTrsTqHRw
         fCMG9uRiUk+IkaGO3A5a3ck33HUNqEwKlI1ugJL4JwXqgFocYnOHEVfd4H1rhV3cmI6h
         gR0GFE51UI1+pnzSZS5TI2iA08GgvhPZHDBWKfynHTgN3xOylCkDoNXH7X2843GpO3vL
         n4Aytc6gkCCl1rvIkVVYvc7wu5/2W6DIWiOaUeW3a7k6eyoOLxewha1vf+j8WqCZN3S4
         s4hso9dRQV34uJWotn4jSs/m5sshF6R+B0up7gB/uTuiuHePQ0vn1Er+RAljBrOclcI9
         cl1A==
X-Forwarded-Encrypted: i=1; AFNElJ9dbgT+iEmNT/uOeYjQ7ZqqxBAPcRTxxi5qDjqHAqoiT9iuf104fTd4t/WTv6CL5Fxmvk8ocl6Z@vger.kernel.org
X-Gm-Message-State: AOJu0YylwSNy/yuSuQZ+YQHXrn8WHpYS2N8nxXs7r8NqRR0sL7Ax9AQ8
	Mps2UKSzq5L3UC85gI4PaVobAwZB5yr1rkpJfVGLqiopLwBU4N8bpv8jctT9HbzNXuTuGnFitm5
	L/nZMkFdCeIiRX/14GM4yoK+FRXnYL8WOKwjW8bl0
X-Gm-Gg: Acq92OHA7ywLl1bGKpxMqMgkXiLjUtyvcPetmcc+O8RZjmEAZVPWymdPqqoOFjlxJk2
	n6Io3Y5/Js/R7ZKrN7Gl+5mF9bB6fK9D5m0+Uvaqw79q0iY3aUdupbopS/vXswqp7pDdc5WtjBK
	8zcRcoM21jsju5lC7wWwg8A0+1KZ2VpPrWnf4qE2aQp3Zgn4XYQ2YLs3F0+EaJ30STzehnTBAKO
	rFKjwwOuyvdVaWyWOer++6VfMzrW9WesQcrN0B1qrSnpCgbk0xNjvLugtWxs+rX701T5QgfwZLJ
	agDdH3Zkh8l4KxWokS2WhmAfsKG/AEhl+oNjaiPJrfCex4OY
X-Received: by 2002:a05:600c:5650:b0:48a:5aa3:ac1e with SMTP id
 5b1f17b1804b1-48ffd828c95mr2422185e9.3.1779138791895; Mon, 18 May 2026
 14:13:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <8ef38815-6ae9-4359-86d4-042554357639@amd.com> <CABdmKX2uwZ12kYJYPJGfWxuMBOJS=64b1GRj72tfB5D=NKM22w@mail.gmail.com>
 <CAGsJ_4zjrFJYQQsLThTGXR6g+2PXzeAhjyDpLHfDFqVViWvyBQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4zjrFJYQQsLThTGXR6g+2PXzeAhjyDpLHfDFqVViWvyBQ@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 18 May 2026 14:12:59 -0700
X-Gm-Features: AVHnY4L4foI9pbyItEwrt04ziyQl1Xw6iN4loxWK62AYv0ZIBdafhEyOwVCgdmg
Message-ID: <CABdmKX0gqg309hcXcOHSj_yTg0h1zwDL34GDk8mX3wp4YoyfDg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: Barry Song <baohua@kernel.org>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Albert Esteve <aesteve@redhat.com>, Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
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

On Sat, May 16, 2026 at 1:40=E2=80=AFAM Barry Song <baohua@kernel.org> wrot=
e:
>
> On Wed, May 13, 2026 at 2:54=E2=80=AFAM T.J. Mercier <tjmercier@google.co=
m> wrote:
> >
> > On Tue, May 12, 2026 at 3:14=E2=80=AFAM Christian K=C3=B6nig
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
> >
> > Yeah I think this might work. I know of 3 cases, and it trivially
> > solves the first two. The third requires some work on our end to
> > extend our userspace interfaces to include the pidfd but it seems
> > doable. I'm checking with our graphics folks.
> >
> > 1) Direct allocation from user (e.g. app -> allocation ioctl on
> > /dev/dma_heap/foo)
> > No changes required to userspace. mem_accounting=3D1 charges the app.
> >
> > 2) Single hop remote allocation (e.g. app -> AHardwareBuffer_allocate
> > -> gralloc)
> > gralloc has the caller's pid as described in the commit message. Open
> > a pidfd and pass it in the dma_heap_allocation_data.
> >
> > 3) Double hop remote allocation (e.g. app -> dequeueBuffer ->
> > SurfaceFlinger -> gralloc)
> > In this case gralloc knows SurfaceFlinger's pid, but not the app's. So
> > we need to add the app's pidfd to the SurfaceFlinger -> gralloc
> > interface, or transfer the memcg charge from SurfaceFlinger to the app
> > after the allocation.
> > It'd be nice to avoid the charge transfer option entirely, but if we
> > need it that doesn't seem so bad in this case because it's a bulk
> > charge for the entire dmabuf rather than per-page. So the exporter
> > doesn't need to get involved (we wouldn't need a new dma_buf_op) and
> > we wouldn't have to worry about looping and locking for each page.
> >
>
> Hi T.J.,
>
> Your description of the three different cases sounds very interesting.
> It helps me understand how difficult it can be to correctly charge
> dma-buf in the current user scenarios.
>
> I=E2=80=99m wondering where I can find Android userspace code that transf=
ers
> the PID of RPC callers. Do we have any existing sample code in Android
> for this?

Hi Barry,

In Java android.os.Binder.getCallingPid() will provide it. Here


> > > I'm just not sure if this is future prove and will work for all use c=
ases, e.g. cloud gaming, native context for automotive etc...
>
> Thanks
> Barry
