Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176413FF8BF
	for <selinux@vger.kernel.org>; Mon, 18 May 2026 12:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106617; cv=pass; b=e0cakmv7pJlMMwKw7UP6X0Elhec0zSDq6auommgKXBsgngv1eFITvErZiCWbxWxQXG3t8q+9E66lEZxvDYiV1WN5UUQxK4bLcl/5fDed3Eub6gqhpdNtx3rbtHLmzeVedRWQmePBX7pueYEeNrTwGvv1TO9vE+PcyZvWUvoRNU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106617; c=relaxed/simple;
	bh=GxTu0NfteCWY6YUdX16wT/N4BvT3hXjpZN7hbF/PIrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UVSOG1Sy1dx3kdSBGz9I45dtVdC3bIKhfOhIfna8mfAUsCIL7mW6ZnmYN3EkbSOcTK9DdwbqbwNCyU8JzJjSu0bRyzAMFBCNmvmtzGuKdfnQyEVvZXVG9I321foTpHLQ0+YTY+n1cQCsmF8WIKvyhi84RcTlUErxox7D43LuGaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WhDsoxB7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pJBVJPui; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WhDsoxB7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pJBVJPui"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779106614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nTNxjctaqLUFv9CjPVEgJLujFyB864ku/zdpEqnLvsc=;
	b=WhDsoxB7L47W8xbX7MDJn5xFkPS7vFUBxSLsjTkdQHpCUvfrZ2macQHMWB5Me9Oz4xFfRy
	rU83cKpB8CWTcAbKWSg8hKQKNCQ8hlhIYhDmkzl2awUlsQhJES36YB3UMNZPoB3GfPhtaw
	3OcK3btvZLxFKGwZt6Fh6qdu7EOZEMI=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-OgmEcGvyNkKYdKboYDQ3wA-1; Mon, 18 May 2026 08:16:52 -0400
X-MC-Unique: OgmEcGvyNkKYdKboYDQ3wA-1
X-Mimecast-MFC-AGG-ID: OgmEcGvyNkKYdKboYDQ3wA_1779106612
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7bd66ec877aso30127327b3.1
        for <selinux@vger.kernel.org>; Mon, 18 May 2026 05:16:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779106612; cv=none;
        d=google.com; s=arc-20240605;
        b=TFE5+pMe0Cml3AuKwedUzd3zvUIIxRttMXZYA+moy3aKXjYgxuJM87N3Lx4MNQs9Kx
         xXHuyHOJIVkgFOC71MKVShBKtgBoOioCjfAqLXwqVCZ7VUL+xVC5PS+jJXpKM2KkMrIN
         njdG9AJUh/c2o5BJUTonsRQ/DlPcAHsQJw+336qRjPR20ah5RgnJZHRukVz81ewKUJy2
         qzb3SugmWMUSDHh82boshq5yqi+tV2AFmdMWIlC7xEj43ol2DfFkXv+whLiu6mEL7dhU
         oDbSS84Kg0hSXUcjCQqnJTqFR5OfIscY44tAR8hyk5EDyixKib4XTNKKCWDJQRgVCp/o
         KZ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nTNxjctaqLUFv9CjPVEgJLujFyB864ku/zdpEqnLvsc=;
        fh=Z8xm4y71OJPXHWckGkF7ekABa9qRZp1HKpG9Ghxr7Rc=;
        b=cgi8MNLIVcoKf4Zm9NPa9l4mzOG9lHSiZxJLyyQbvMA2+b/Hhs+hB+5P+fH8dWMP8/
         dbqBnWsvvCNQq3rgtvI2qOyB/htqk9WIk136R9j0uCt3DlFQM5gLmt59VnEiI7pFH/hX
         ChvOJu2iR+FWfWP3PbJSVZ1u5TJL450R3xGcaMpFkGyyO2ddd0ai+Wt7YM+w9WppOn2h
         x2A4RzbPWTjW1oV6+ImKBZ9LKiWFCwFQ+hhq1y1X3/RBH7MxnI2XDhKr2jDXKr07QqeN
         exaEk4UJHk/bw02nt8rxjZIhE2cke5Kt/PXyfbQEjB91wKGguXPhE68qso66V0GqxCWh
         SNaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779106612; x=1779711412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTNxjctaqLUFv9CjPVEgJLujFyB864ku/zdpEqnLvsc=;
        b=pJBVJPuiJ9TppGffJ7/vAPnD/Z2mIYqgiML0AkBYA1lmD/96RwCBB8DnmO7WT60GyV
         jW3ZI87unkDZDW1xghetk6urrRbI8jcT3MHbs4F036uHvin3DbJvk0wV4UVYhrjx+7OO
         hJpJgv6Kpa+Voxr33d9/uf64uTHm3+FVc7FyztyY/lG1ypsZBNQLT4nlkOXQDotGpVvw
         /O6OQltvdVdc9xB5Yh0uKHN4cq1059lXmi/dghfpxCuqIbhEgXnMAVhwkqPbZCvdhj/0
         K25FscMl+T1/3s0pDQ1A8+NmNuixSyESlMeW/b/5L46HmwbaMFwq3CKrmfq/VEc/wZp2
         D7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779106612; x=1779711412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nTNxjctaqLUFv9CjPVEgJLujFyB864ku/zdpEqnLvsc=;
        b=QqA59d3QsTQstTcFEjkvHq/2tYfDNVxWgwoeSIrY2oIj2EfqgGyCMV76jp0amjHBgS
         oLIOR75e2UsghxUjrVGuKR5xPPjEYJtelXMU4G0JrDPuxQiBckbpCsd8JDeY8Bo/fW6S
         RXu/4zjmB05VeQsmzb1JgZO3cEqcHEFJ3cgDUm/6Nocy/bd+mPPUQpVlNiG51JQWbx2W
         KGlMWFlzAZMIWUQCLhQR843mjstEGEve9R/ASCjh1hpABy/mvezZV5vjT3QZ11VJapss
         dMWHG/NErnXU5A0QCdgjf4YpZCsuTTmppAgONNQ7fjMh5OSGBX2rlimVDEyf8dBY9oaD
         c0jA==
X-Forwarded-Encrypted: i=1; AFNElJ//1tk2gAgkhwoK0fNIROzRgKNcL7oTMhN3k2nm5KocpYrBJoCU5b0w8EnIXilRS7jvc0Z2oy3j@vger.kernel.org
X-Gm-Message-State: AOJu0Yztxd/T8R2AvzQBeZCsUpMVj0TeinDRPs8gYNIIUb71D6jWHZpP
	MYyLJ7Z6GE/lzxeZsg92ZssXQYc0r/g3KIDrx3+UJVFHPoVdFptFkxie/R7fMEEqOF93dHTVw3a
	di+9bI4lBKphGbbszCiODBZVFGCr2n62CcchzqSP8v48z5iIjPh3W3tC+kb790p6ByyEC8GroRi
	uSml1vOBzJnxwW5flvGoNdJQOa9YQxNW5AkA==
X-Gm-Gg: Acq92OGxhBEWJwQeX3b/1G1k4RJjpSqpdg2QctE8CVLc0Nv/B4jzaoR62xkSvFHHxqj
	9YqWF6QFjOOWf/wr50Pj0cWsjXhFEkeKy3JiHPtJxGPThO4/7giZXEPydFonwJQI5KHVWRJkKRw
	4J51ZGhiVIysNa25rQS48B6SsPu6YRFW84I1FRTLJmxQ1UF6+1tCiCOwbO7RN2FRNzEA0Jw4TgG
	jhElQ==
X-Received: by 2002:a05:690c:18:b0:79a:b440:5c8d with SMTP id 00721157ae682-7c94765b6ecmr126200907b3.11.1779106612306;
        Mon, 18 May 2026 05:16:52 -0700 (PDT)
X-Received: by 2002:a05:690c:18:b0:79a:b440:5c8d with SMTP id
 00721157ae682-7c94765b6ecmr126200267b3.11.1779106611396; Mon, 18 May 2026
 05:16:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com> <CAGsJ_4xfznffbjOaNKwnN6oZk_H6pqOzYqd1zx4Q9XrocdzV8A@mail.gmail.com>
In-Reply-To: <CAGsJ_4xfznffbjOaNKwnN6oZk_H6pqOzYqd1zx4Q9XrocdzV8A@mail.gmail.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 18 May 2026 14:16:37 +0200
X-Gm-Features: AVHnY4KtxiMU87dVIS1J63myR0LimTeIXsyDKnE3-mVGrbnQ2cunkdBN5oMYBbg
Message-ID: <CADSE00LjJcL8P5M-UPEpzZijU70uEmUirnin29N8YR5W5D-oFg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: Barry Song <baohua@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, mripard@kernel.org, 
	echanude@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 16, 2026 at 9:37=E2=80=AFAM Barry Song <baohua@kernel.org> wrot=
e:
>
> On Tue, May 12, 2026 at 5:18=E2=80=AFPM Albert Esteve <aesteve@redhat.com=
> wrote:
> >
> > On embedded platforms a central process often allocates dma-buf
> > memory on behalf of client applications. Without a way to
> > attribute the charge to the requesting client's cgroup, the
> > cost lands on the allocator, making per-cgroup memory limits
> > ineffective for the actual consumers.
> >
> > Add charge_pid_fd to struct dma_heap_allocation_data. When set to
> > a valid pidfd, DMA_HEAP_IOCTL_ALLOC resolves the target task's
> > memcg and charges the buffer there via mem_cgroup_charge_dmabuf()
> > inside dma_heap_buffer_alloc(). Without charge_pid_fd, and with
> > the mem_accounting module parameter enabled, the buffer is charged
> > to the allocator's own cgroup.
> >
> > Additionally, commit 3c227be90659 ("dma-buf: system_heap: account for
> > system heap allocation in memcg") adds __GFP_ACCOUNT to system-heap
> > page allocations. Keeping __GFP_ACCOUNT would charge the same pages
> > twice (once to kmem, once to MEMCG_DMABUF), thus remove it and route
> > all accounting through a single MEMCG_DMABUF path.
> >
> [...]
>
> > -               if (mem_accounting)
> > -                       flags |=3D __GFP_ACCOUNT;
>
> Hi Albert,
>
> would it be better to move this and its description to patch 1? It
> looks like patch 1 already introduces the double accounting changes,
> and patch 2 is mainly just supporting remote charging.

Hi Barry,

Thanks for looking into this series! Yes, in my head I was trying to
keep patch 1, which was taken from a previous, different series, and
then diverge from it starting with patch 2. This would clarify the
difference between the two. But I can see it just added some confusion
(for example, patch 1 charges on dma_buf_export() and then it is moved
to dma_heap_buffer_alloc() in patch 2). I will reorganize it better
for the next version, including your suggestion.

>
> Also, mem_accounting is only used by system_heap.c; has this patchset
> also eliminated its need?

No, mem_accounting is still handled in this patch for the general case
where no `charge_pid_fd` is used. See dma_heap_buffer_alloc() code:

+       if (memcg)
+               css_get(&memcg->css);
+       else if (mem_accounting)
+               memcg =3D get_mem_cgroup_from_mm(current->mm);

>
> Thanks
> Barry
>

