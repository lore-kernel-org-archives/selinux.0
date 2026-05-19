Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB293F1648
	for <selinux@vger.kernel.org>; Tue, 19 May 2026 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182247; cv=pass; b=tZXQHYoXW7cp953r+sUg+HWX5EK8+0Lo9F4Z8KDc4qpVxesY1uNuWUc3JS2epdxoDVG6CyA+qk3dIffybDoXhWPOZrphBuZHNpE3lZfuq8MFgCtRXb4NncCmrjRZnShj34Xro6iOtSstdmL6sMUreXRQpHFzkkYMayE8pzjObCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182247; c=relaxed/simple;
	bh=ahxcxmkOaihabfP2WFI6asNswH1uQirOjdb0LjAlcss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G3vWaxp0FY3WH0dJsXsi2xKzFrEQsM7rnEFlUPV/Cz85c1laM1VV3relZ/fpvpLT5BtxXAI/xsjXdQKvSWl0Dkm7Gi0BgN7GMsz5t8/wz8dlZDhCVm5muUGHkvKTN2YP2Mv7YR+0eLNVVbuJdqpcqZCO67kHPsTjN8P3GaUVavo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AOW9Nv7j; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qvia8Yl1; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOW9Nv7j";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qvia8Yl1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779182244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ahxcxmkOaihabfP2WFI6asNswH1uQirOjdb0LjAlcss=;
	b=AOW9Nv7jZW7A/9LRrVY1xHXznWasUh1Wxqnz8dOcz38erHhs24ZomgdQvO/AV+uAh2hB2s
	B5M7oaaIr6uYO/1lhIGSndNfPYg/JO5sJQJf1WSUOmoNbzAAaDYT1nK/wXOoLZ0XUWEa1/
	CbNFTGjs5deKwgxCNveR9vIw2tp/Nas=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-HJb4_0iWMfmQNJxAMfAuiw-1; Tue, 19 May 2026 05:17:22 -0400
X-MC-Unique: HJb4_0iWMfmQNJxAMfAuiw-1
X-Mimecast-MFC-AGG-ID: HJb4_0iWMfmQNJxAMfAuiw_1779182242
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7c24193e2b8so52549607b3.0
        for <selinux@vger.kernel.org>; Tue, 19 May 2026 02:17:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779182242; cv=none;
        d=google.com; s=arc-20240605;
        b=Y1VP/D+VXHl0kWQLW575pbEgCpMRMOZmDUE6ZgaiiKkUE6mCTMNZltKpO0wOsyP19j
         cl0lFkborxGnXDpvWVRQRqEadRXPHRitIP8bBs0A288ATrK4PAapPm8BpKvAbvWniwyW
         +QXcOu8DP0w0s6vyqHWheNvVxld4hkfX/SvM5LGhC4gDqrqDUQrrN1zTdaNHjo+5jL9A
         JP9LKyV7jBKHjoolgPcb0Y4Uh0Dg5hyyOQV0RmD5zXY5CW437TZzaCrvkh1//AF9ASmI
         uXK1WkfMARSALAuVLhxJF2mLtCZsnLgnIM9N6UHp7B9n/ZNM4tp75uh3dXz5SB0C8pZj
         9sIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ahxcxmkOaihabfP2WFI6asNswH1uQirOjdb0LjAlcss=;
        fh=do1Qtx+NYWG0Qa+dt03BCNBQbhjHcDUD25yVANIk/2E=;
        b=Grjuxj0JYft8Wudyu7E60rLidO+g7ep23sZdnB4jKC6PcywfY5500O+LAcgeqm1H8l
         rVEFwwn739NZNt5e/XRUEcvLBx+S7C/m5XCTo2C937uTqyxjteO/o88z809eXk6kdoo/
         O1FIO+3xP3C1UxS4FFue3qVtgndDJOw0HvSCEyn+mn75kFPoninSxciSc7coOYJ+By6F
         fFoRq4svSYFfQ4pPboYHlNXJvmS4WAH57MbCR4W72ASvfWVTrgLRlFuVUMR1nKi+u1xK
         2Vtdhx/eRpjvlofXT9qbRDuNEL7a3PEZge3OJts3gk0d5JUDB0+6mU6uE1uLZdw2C1L9
         A0aQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779182242; x=1779787042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahxcxmkOaihabfP2WFI6asNswH1uQirOjdb0LjAlcss=;
        b=qvia8Yl1VZBOEkQ86mS3aIVG1q8FX6h42hqISIixHt0A1lAeoANof82medLl6SbTC3
         cUO8xorSlCTK++u+4yVlN0vmpI8HJ367/nIuxoWC1isBD27Wig/2OMKkYMO38QPaiLIX
         vXL5233zvsFfIobVXoaiflR4ahGM0uUXaZFM8gb3vtRkcENHgWy8JLu56GHAp9WuK8qy
         v4KusyLi37P5MnD3/N3p8quc3k1QMk9WyTAwaNRn+P5JqRuWuiDjZzDJPH/7S7zXpi7Z
         big8Jox/ATLs3U9uyxFzDG25wvmOFvvSWmELbArKwjVnBP2nVsHzL391vCVlnPbTlkMe
         u3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779182242; x=1779787042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ahxcxmkOaihabfP2WFI6asNswH1uQirOjdb0LjAlcss=;
        b=EzAJ8txrpMGjaffoXFgwIc5gz1xapH7i+yNrIH6V+leBfP4awjocY/GlI5tSKoYcnH
         HENdOeiGWcEZU3zS59/Wof+CboJmSbEZulb2L+4iJfwQ67/vuMLkFbwNHLy6W5liaNL6
         0v2SsRfswHtMIK11S4XYWSXgI4INpq2YIoEMc/kl5aqSpQc3ez1mbNXhgo95KBBKY0a9
         zmjXHwIqlpvGRp85M8MGU75zVdy7sTJh9g2wmNyp+5otr3HSjujvRILqo2T7ww131VJz
         ku86/5clshnX7BPzfYjhqtxgCMoczbH8zwbVDypt0hkkUJQxaOf17mwKAeFPCDWj41bl
         W/QQ==
X-Forwarded-Encrypted: i=1; AFNElJ/QrgCWTy4A1RFZ7O18n89Zo3DFOEJZG9mxjwpeXhK3NnHiBRgIUMcAnNv6zxZBqDy18dfV1sPL@vger.kernel.org
X-Gm-Message-State: AOJu0YxqetK57umywZJmAo3i+ky3x5Vcj7l/BUOxhq39Ul51MV3OjxsF
	kk8K4zpi0G8hXcwtqEGCBuNi1N9uCoJahqImvT6oIc1+pUD5nG2/gQtst9rRhpOQ3WgAtXRp9dq
	3CjMA0vxX41R12D4OHYs3C5+7C3Q0X7iGDqqPJuC1olMDS/3nuLPFgIadGryKsu+/Roco+cYnT/
	zoA/CEoPEkId36+bNsJLi/xpYIBoYxJaIFoA==
X-Gm-Gg: Acq92OFkzknEN4rXOEF6YPLSGMPuJmLQmUpNmpqgKZpnt2h/tr3KEraxtM9gfbzNiBD
	TbDL8A6AJzD8PO7kOfUr0xjbXWeLkVfFThgwVrZyRvz2G2oBBoJDzzBB654/6RivruugfZJ2Mwd
	n/lAy2AAUqlu+hmFqea12bFxXGqM1V+VzkTQzZN1AnF9v7qeuZT/lmdNKR/gpO2VGV9ic2X1P62
	oeCkQ==
X-Received: by 2002:a05:690c:c513:b0:7b4:f43f:1a23 with SMTP id 00721157ae682-7c95d1d5de1mr201682897b3.34.1779182241752;
        Tue, 19 May 2026 02:17:21 -0700 (PDT)
X-Received: by 2002:a05:690c:c513:b0:7b4:f43f:1a23 with SMTP id
 00721157ae682-7c95d1d5de1mr201682637b3.34.1779182241263; Tue, 19 May 2026
 02:17:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <8ef38815-6ae9-4359-86d4-042554357639@amd.com> <CABdmKX2uwZ12kYJYPJGfWxuMBOJS=64b1GRj72tfB5D=NKM22w@mail.gmail.com>
 <CADSE00Jq_uvNgvxgPze0mEdUd+hF4-DPZkHy0KroWHZzygf4WA@mail.gmail.com>
 <CABdmKX3DhejYBis9htLDnzPrG7vuF3R3URLVNEbnyd61SSsx=g@mail.gmail.com>
 <CAGsJ_4zyecY6E-=Tm4_couT7uoM9LMcFdTMUPkZAjj4zUKE-dQ@mail.gmail.com>
 <cb84c2ee-9de1-4565-b2e0-60984721228f@amd.com> <CADSE00Lc42s2bzXzV5D7t1Enf56u4BVj-yXLp3Yxhm0=qMPvuw@mail.gmail.com>
 <9cc79977-9a42-40eb-bfa7-460881c1e10f@amd.com>
In-Reply-To: <9cc79977-9a42-40eb-bfa7-460881c1e10f@amd.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 19 May 2026 11:17:09 +0200
X-Gm-Features: AVHnY4IPueDokk-vXqsRnZz3u8JK7NQGe3IxviX_AiFOJ3NwW-K39W0igYKchDQ
Message-ID: <CADSE00Lxti-MabrZq9KWijRxTHX49NOAV=hMdfLdqKrj-C=Jug@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] Re: [PATCH RFC 2/5] dma-heap: charge dma-buf
 memory via explicit memcg
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Barry Song <baohua@kernel.org>, "T.J. Mercier" <tjmercier@google.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
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
	linux-media@vger.kernel.org, dri- <devel@lists.freedesktop.org>, 
	linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, mripard@kernel.org, echanude@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 9:53=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/18/26 14:06, Albert Esteve wrote:
> >>>>> udmabufs are already
> >>>>> memcg-charged, so adding a separate MEMCG_DMABUF would double count=
.
> >>>>> Are there any other exporters you had in mind that would benefit fr=
om
> >>>>> this approach?
> >>
> >> Well apart from DMA-buf memfd_create() is one of the things which as b=
roken our neck in the past a couple of times.
> >>
> >> But thinking more about it what if instead of making this DMA-buf heap=
s specific what if we have a general cgroups function which allows to chang=
e accounting of a buffer referenced by a file descriptor to a different pro=
cess?
> >>
> >> That would cover not only the DMA-buf heaps use case, but also all oth=
er DMA-buf with dmem and whatever we come up in the future as well.
> >
> > I removed a draft adding an ioctl for charge transfer from the series
> > before sending because I wanted to focus on the charge_pid_fd approach
> > and keep things simple, deferring the recharge path to a follow-up
> > depending on feedback.
> >
> > The main difference between my removed draft and what you're
> > describing, iiuc, is scope and layer: my draft was an explicit ioctl
> > on the dma-buf fd that the consumer calls to claim the charge (see
> > below), while you seem to be suggesting a more general kernel-internal
> > function that could work across buffer types and cgroup controllers,
> > so not necessarily userspace-initiated? A kernel-internal function
> > will need a way to identify the target process, which sounds similar
> > to the binder-backed approach from TJ [1]. For everything else, the
> > receiver still needs to declare itself, which the ioctl accomplishes.
> >
> > ```
> > # When an app imports a daemon-allocated buffer, it can transfer the
> > charge to itself:
> > int buf_fd =3D receive_dmabuf_from_daemon();
> > ioctl(buf_fd, DMA_BUF_IOCTL_XFER_CHARGE); /* charge now attributed to
> > apps's cgroup */
>
> Well that thinking goes into the right direction, but the requirements ar=
e still not completely covered as far as I can see.
>
> Let me explain below a bit more.
>
> >
> > [1] https://lore.kernel.org/cgroups/20230109213809.418135-1-tjmercier@g=
oogle.com/
> >
> >>
> >> The only drawback I can see is that DMA-buf heap allocations would be =
temporarily accounted to the memory allocation daemon, but I don't think th=
at this would be a problem.
> >
> > The main reasons we moved away from TJ's transfer-based approach
> > toward `charge_pid_fd` are: avoid the transient charge window on the
> > daemon's cgroup; and to decouple from Binder, allowing any allocator
> > to use it.
>
> Yeah those concerns are completely correct.
>
> The application should not volunteering says 'Charge that buffer to me.',=
 but rather that the daemon says force charge that buffer to this applicati=
on and tell me when the application is over its limit.
>
> >
> > Technically, both approaches could coexist, though. Of the three
> > scenarios TJ described:
> > - Scenario 2 is directly addressed by charge_pid_fd approach without
> > any transient charge on the daemon at the cost of one extra field in
> > the heap ioctl uAPI struct.
>
> Yeah extending the uAPI to pass in the pid on allocation time is not much=
 of a problem, but you also need to modify the whole stack above it and tha=
t is a bit more trickier.
>
> > - Scenario 3 can be handled by the charge transfer function without
> > changes to SurfaceFlinger. The app or dequeueBuffer claims the charge
> > for itself or the app, respectively (depending on whether we include a
> > pid_fd field in the transfer ioctl). It also covers non-heap
> > exporters. The con in both variants is the transient charge window on
> > the daemon.
>
> It should be trivial for the deamon to charge the buffer to an applicatio=
n before handing it out.

Yeah, true.

>
> > Both approaches shift the responsibility for correct charging
> > attribution to userspace: first, 'charge_pid_fd` on the allocator's
> > side, and the transfer charge on the consumer's side.
>
> Yeah that's why I said it would be better if we do that without any uAPI =
change, but with all the uAPI we have to transfer file descriptors (dup(), =
fork(), passing FDs over sockets etc...) it could be really tricky to imple=
ment that.
>
> > Deciding on one, the other or both depends on how much we value
> > avoiding transient attribution, and how much we need a non-heap
> > generic solution. With the XFER_CHARGE we can cover both. Thus, the
> > `charge_pid_fd` approach in this RFC can be seen as a
> > performance/strictness optimisation, eliminating transient charges to
> > the daemon at the cost of a permanent uAPI addition to the heap ioctl
> > struct, but not strictly required for correctness.
>
> Well all we need is a uAPI which says charge this buffer (file descriptor=
) to that cgroup (pidfd).

So you favor having only the XFER_CHARGE variant. That is fine with me.
If that is fine for others also that could be the way forward. If we
extend it to accept either a pidfd or a cgroup fd (as commented
previously), we can cover all dma-buf use cases with a single
primitive:
```
ioctl(buf_fd, DMA_BUF_IOCTL_XFER_CHARGE, charge_fd);
```
With the daemon invoking this ioctl before handing out the buf_fd.

This should cover most usecases? Except for the memfd case, which
requires a separate mechanism. That would be follow-up work.

>
> With this at hand we should be able to handle all use cases at the same t=
ime.
>
> > On the other hand,
> > if we agree on the end goal of migrating other exporters to use
> > dma-buf heaps
>
> That won't work. DMA-buf heaps is actually only a rather small and Anroid=
 specific use case.
>
> We have tons of other interfaces to allocate DMA-bufs which need to stay =
around because of HW restrictions and we do need a solution for them as wel=
l.
>
> Regards,
> Christian.
>
> >, and scenario 3 is addressed by adding the app's pid_fd
> > to SurfaceFlinger, then `charge_pid_fd` alone is a coherent/sufficient
> > approach despite the uAPI change.
> >
> >>
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> Thanks
> >>> Barry
> >>
> >
>

