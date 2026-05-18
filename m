Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2AE331A41
	for <selinux@vger.kernel.org>; Mon, 18 May 2026 23:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147572; cv=pass; b=WZlc3SqFAb67JTXgwoU3a30MSwoQMMZynljEDgix9RAGrMitdH5PCO2SdlXYxc/46fIpkQ5p9kFoZVHd4lQXIdPtgpjNm9KbPa3Dyp2INSEAKvNfTfgvSbTd2gbbgAS0qVIcwPPHnWvxtcmefhhOHmJ5lldkCApNiPNMuY4ez38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147572; c=relaxed/simple;
	bh=MVyBd8P8ZHPDO43tWlBSuB0zkMXQCxdJ+/go03Ht3bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GRvT457OsUbu8ZYzgBgTwGY9VwHL4vZKNMOyy1xnMRO+oEzc9TShpCI/5fP/I8uzpBHis+8xcxhna4nutnVTuptc2JrE7bTbWml4aP6sxQorpaXIJuFTCmfqmLseEhamn6ClK//AoYokBRz/xVlWXbmvEkV29WE+eZn8Kxvbtmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WHSbLGwp; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WHSbLGwp"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488940ccfa6so935e9.1
        for <selinux@vger.kernel.org>; Mon, 18 May 2026 16:39:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779147569; cv=none;
        d=google.com; s=arc-20240605;
        b=FnDSi9MNdTpf8r/6Q9AvBrWWXAm5TrFjeQ06hM0pHkFH1ao1tfOeILEUShoPntUaxd
         F6yZSCo1ALSTDNYM7mK5DFIyaEO0jB5+h/bd1uYSpT3HeFXEjjlWVXmy5bixkadsNog6
         gj2WvsZXB9yA/WITUXVSE3ptXGH7et4Db+1PIx90NtCXld9hr0PK0RLetNazw2go6FjN
         cWUIolBbwoeqN8bIWlw3PfnGLTgvxAq2BW9KF28QCIXX5i9+JHosqp3oLd646RSW/Pc4
         lrGFghYN27M+b0zY6B4xsTjjYz9Fp8YhLJcYuPnRnclRTHzq3DalXJIzO2sShfWOyWMM
         TqfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=itOYKoJgfjMZD3HtReaYbMSuntrxVom1KXxY5d6gQNg=;
        fh=Iqtu9mB3b+JwGwZLcECdTQWfYuiwnRMglUrCPpSrzmo=;
        b=VE6bTrjnb/p6OX10x625Yqk0QQ7/VQJ7J6OpEo9HcpGku+y6IBHe0QJQ7ZN98AGvFt
         wmuPeziln5hBvMFktANsMBaeEd6UMo558+ue4ExjwlOFVCat3YJ2+Nox8zrc7gOefEFT
         QVkH5i1noB8f9Cpefzhrr0Yx8SL4xuIgXWLucqeucBF5AHfyAuakJole2T7C6T2PzHpO
         +FxG3lijEwyWWa9pjOz6lkRgmY28jPWHzRf3K21+gZWlgA66Bwxr+4muWdp4GPSujWsn
         +yVyi5ZRUAHPd7KkdVyyGm60auO1cvOG1x2wBryPH1rGYMy7ClApJQCLhLL/j7EyWaBG
         Ci9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779147569; x=1779752369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itOYKoJgfjMZD3HtReaYbMSuntrxVom1KXxY5d6gQNg=;
        b=WHSbLGwp9dzHm/Ck5v7yRf5STkpaQFc89CC3BbVSTDlpg14DuO4gO+VVBVOPT5M14h
         KfqufuMH5sVR/bEsVqq6bJ/gUyg+om+Jqv6ikla3l+2RLeFwKCXZ1EJocfxdaXYkNi3I
         6u3OwoSXpMmpQ4ny+ZIRYuq37zpcWUZ2i7uhxq3znLQsukNatjHZgVbjrH8CsnxTah9O
         kFDsCLjtiqeeCX9KzZIrpsVPVTOCcou2lWUDo6i+lnpZxpAofY7TA9U6mJx1TBxSoqck
         P+wHE7LPCr96YN3EQCd4PyXP1lTWx/uxIyX1xZ9du1HCQsLrvscFYe5vUnvAbnbWAGVX
         xNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779147569; x=1779752369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=itOYKoJgfjMZD3HtReaYbMSuntrxVom1KXxY5d6gQNg=;
        b=Xy/NjOw8S+l6lc8QY5lGwxN8MXSOF8uWXbpJu1zP/rYYNygNI8ojGApf6sXkZ9ldn5
         48NmP1oo8fy7A5DS531evdHvKwp3SzvvXJdi4TTDw1UnsYDKcvhNdLzKdQlRiv92NP5e
         PO0twoy0BBhUwKkax5AQOSYaO9W6eoQe7O5314eQLmWyZmSYmIm9Gx8JOTyKyx66G2em
         HO8UxjNxOcC7IKDztHMgHx6DCVYODub2/ot61macDSOB0HfL9jUgXyGFVWDjqUeQx/GF
         Pwb8ExpOe4ru1S6RBIH64ghEcCPyV/Q3BJaP2pcjZlRHXr46NOw9Td2QVOLUwm/J9uo1
         2P+g==
X-Forwarded-Encrypted: i=1; AFNElJ9mmYWMeZoJ5MRqmwLfDtU26lTYoSArUh8+0R8tFriqHtUPRQGQZcA4tPNtEI51FbiDijja2fTh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8MzgKMPaYq1wm8XfFMCvHNdCoxoG58T8+kXuKbnCI50DscT9j
	5DzSyc9XcKbIKYEWrF2bno2yZYhU1TgiUNj4hmLPYdauIdy7EGUAcju1tX21Ys7g0mRB1lNJOuF
	EA2Ns6YVxAqQQmqIlVLBR3bhNpesV643ItF9vX5GY
X-Gm-Gg: Acq92OF/HTVDPJofN6LvDZcGAgblK/aIHVg8eCWe3HFGLqbB09QiwASZjhcaxopQBlN
	GYw/+WQE8ISDUi86pmM8rHD1zz8V9wDXNl1SNlbkEICoLrVsg3YJuBlykMZ7yrht9yhcGu8CMf6
	+ShIYVrz3p/agA9YJYIWDM2FcZ2rtg93wOFDDuYAGH6QyhZexk2YeqZWXVEn41p8eneTuY6dj1P
	OJnsPTJ9IPbKu9w9pswZHQa1giZqmYnqlFoWMGc4oqEgpVPbtUWD6O7SK58i/LH7kPjz4+hOh7o
	FjRk3CLL826bkGNw53mWVvbeJ0YHtl+N7OJTtTWfsrc/Y/Ib
X-Received: by 2002:a05:600c:828f:b0:485:1a54:9407 with SMTP id
 5b1f17b1804b1-48ffa06d607mr3320695e9.0.1779147569161; Mon, 18 May 2026
 16:39:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <CAGsJ_4xfznffbjOaNKwnN6oZk_H6pqOzYqd1zx4Q9XrocdzV8A@mail.gmail.com>
 <CADSE00LjJcL8P5M-UPEpzZijU70uEmUirnin29N8YR5W5D-oFg@mail.gmail.com> <CAGsJ_4xwJ7SAhKPJyRtMTw6psTO7H1EcFFpDw0po1W8PX4FE8g@mail.gmail.com>
In-Reply-To: <CAGsJ_4xwJ7SAhKPJyRtMTw6psTO7H1EcFFpDw0po1W8PX4FE8g@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 18 May 2026 16:39:14 -0700
X-Gm-Features: AVHnY4JenMsTlW8PdrNyXvGhnvZE3E4HsfXXDBDrw2kB1e9N8h1WWqyjOLM9WZU
Message-ID: <CABdmKX2+PqZJc588dL7Yp7hYDnfXw7LRCKfLJ6n5=faKBvWBWg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: Barry Song <baohua@kernel.org>
Cc: Albert Esteve <aesteve@redhat.com>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, 
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

On Mon, May 18, 2026 at 3:43=E2=80=AFPM Barry Song <baohua@kernel.org> wrot=
e:
>
> On Mon, May 18, 2026 at 8:16=E2=80=AFPM Albert Esteve <aesteve@redhat.com=
> wrote:
> >
> > On Sat, May 16, 2026 at 9:37=E2=80=AFAM Barry Song <baohua@kernel.org> =
wrote:
> > >
> > > On Tue, May 12, 2026 at 5:18=E2=80=AFPM Albert Esteve <aesteve@redhat=
.com> wrote:
> > > >
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
> > > [...]
> > >
> > > > -               if (mem_accounting)
> > > > -                       flags |=3D __GFP_ACCOUNT;
> > >
> > > Hi Albert,
> > >
> > > would it be better to move this and its description to patch 1? It
> > > looks like patch 1 already introduces the double accounting changes,
> > > and patch 2 is mainly just supporting remote charging.
> >
> > Hi Barry,
> >
> > Thanks for looking into this series! Yes, in my head I was trying to
> > keep patch 1, which was taken from a previous, different series, and
> > then diverge from it starting with patch 2. This would clarify the
> > difference between the two. But I can see it just added some confusion
> > (for example, patch 1 charges on dma_buf_export() and then it is moved
> > to dma_heap_buffer_alloc() in patch 2). I will reorganize it better
> > for the next version, including your suggestion.
>
> Yep, I understand the situation now. I also understand
> that you were referring to T.J.'s patch, which caused
> some back-and-forth confusion for readers when reading
> patches 1 and 2.

Albert, please don't feel obligated to keep my patch intact if
integrating it into other patches simplifies the series.

> > > Also, mem_accounting is only used by system_heap.c; has this patchset
> > > also eliminated its need?
> >
> > No, mem_accounting is still handled in this patch for the general case
> > where no `charge_pid_fd` is used. See dma_heap_buffer_alloc() code:
> >
> > +       if (memcg)
> > +               css_get(&memcg->css);
> > +       else if (mem_accounting)
> > +               memcg =3D get_mem_cgroup_from_mm(current->mm);
>
> I see. What feels a bit odd to me is that mem_accounting
> could either be dropped (with unconditional charging), or
> it should cover both remote and local charge cases.
>
> I don=E2=80=99t have a strong opinion here=E2=80=94it just feels a bit
> strange, since its description is quite generic for memcg:
>
> "Enable cgroup-based memory accounting for dma-buf heap
> allocations (default=3Dfalse)."
>
> Best Regards
> Barry
