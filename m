Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795623257;
	b=ysaLRMpl54ZQWGnu4ZAFVt4LpIzm99sZiQc38HVHuCckHpS+0nQPdmkCyEph5ZSDrEyb
	 P2RwwUfjQfZ3YZB0zCGfSS35uAEnbk4KJTR1QfihhNhZ1RRk9HmIwrrG+VvzXT0WU9KA2
	 4tbJrUOGC99+hwYrlSS+tkJq25E5c2YLEkRCMKW4fUHh/7zZ4Lco7aCshg2jpq81Ji7dy
	 HNImzWBfGV8B5bBUXEbKoTMX+SDZ+2sdRFvcvk4+fmhBENT/4J/nFsbn3RP8FyqzMqFUX
	 qvB57dm+bpEZ32mX/DOOMBVd5hH3XUk/zRWnInAweK3loELXQ3zra4wqrLxGlJ3ApOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623257;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=LdER2mkFO0wbjr2+rc/aRUmp4/Sc5QyLtaG22Ye9JSE=;
	b=Pzo7PAtxTFaNip47iPzp3II3bp2GwMx7L3I7vB0FhlxDGYgW8Uu6qQIs/ZEQ0L7sDDs5
	 fBy6UeqDGIFXgCAudPVObDTMtggDmEUYpdYKCW6ew5cEngOZznKUfU7+jO/ZdH2qe1X+E
	 /p7YOTB3Kawa3Wgp+MnN+Yy/GbxmBRTaX1qXlS8TbWvJjr8KS8CfI0jpyDNUyBUsNbLVG
	 ipIP4gQogU9KmxIq943LJ7zKauPzYFuN2hsknJCJa/C6oSL4LV8h4ywSTTmBAmyrUg3u4
	 XuXJDlfsnu1RI19Q4t18r29FaPPduibRwMYDJiwvK1fxIicxTOZgTIc7MoXUHJyRwrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UtOFRBsC;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UxmZrKKV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B5F606A327
	for <selinux@vger.kernel.org>; Wed, 25 Nov 2026 16:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60B5F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UtOFRBsC;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=UxmZrKKV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795623256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LdER2mkFO0wbjr2+rc/aRUmp4/Sc5QyLtaG22Ye9JSE=;
	b=UtOFRBsCKAK3E8Bsu3A8rziiu4/aqAhE/qioSN+enl9xu6asu7MYmZxBpWnwgM6JAJ10eH
	GeuaMt0x+rQF7dmkSzy8byorSs4CqhqwSkdzDKJ4NU36OhlMRXg42v6WqTsD7ri9JlJGwU
	zmrSWBx/pnkzJtxscC6RhgstvSiYf98=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-427-ZrcFP-qtMqOcH4pkTfkgbA-1; Wed, 25 Nov 2026 16:14:14 +0000
X-MC-Unique: ZrcFP-qtMqOcH4pkTfkgbA-1
X-Mimecast-MFC-AGG-ID: ZrcFP-qtMqOcH4pkTfkgbA_1795623253
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-466d41a1d9aso4653790fac.0
        for <selinux@vger.kernel.org>; Wed, 25 Nov 2026 08:14:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795623253; cv=none;
        d=google.com; s=arc-20260327;
        b=USbVfHfuoW48XiHNW5fSxm76p64iRYOnSGuL/kG04s/65LkPaA+X1StuGx5VWRAaRE
         anN0oyJMQevMiXQa4kX+m5Y6iFd1IEbySGYyV/12au0J/t8jG7sJtjxFBQwGYDPxHTs9
         EYEJSxTMnITfKf6spZONY16In/0stc5xAb2VTqsXLbj7FV4nKAnksB7tIcGVIAETHcus
         ImlsT2X7cclhAFPCrgL1qN3wBjJ5cY7v9WIx6kz7V66s3sBF45aq9Xz6m4gLVBcvb3sD
         wzKpbeL4c2AzhjT7MQT7J6/LB5+LmFdiKAgc8LCBe2yrSSViPgjKrOgMW5acaKjyrzfA
         79DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LdER2mkFO0wbjr2+rc/aRUmp4/Sc5QyLtaG22Ye9JSE=;
        fh=EWTv21nbt5uYfCQquaG6h6y6mMCiZLg/oxgMTxIWjvg=;
        b=cj0/txR840M99iEGc/3we+FqkWTHg/uckBtWTMOmdp4X45oMmVI//roq6irQAxl9Yl
         l+V8h5jwRuB2wdFPUz8Hy8Vg1hEKm+KgX1cwfyJfgJdNc2ZkcnXAE8e/BHKU8s+JpNWn
         qwUtRy63fBYLiPfAhBJrvaudJj5vY1lxMlDmwj0mNRLwYDYIP/9tGvy58wH2cDFRWBbj
         6aw+exngvYP9jRK1/Fgv0n4lK5JUyteALJGQsBPUOf1ePRULKR68K+VlV30SmUkuCUUi
         tCRffeRlWCKzn5t/32KlboZqOBkihtZYd6h4mFmPcdThKza2BTvq2dPp/7EHCEBme2yf
         dZjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795623253; x=1796228053; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LdER2mkFO0wbjr2+rc/aRUmp4/Sc5QyLtaG22Ye9JSE=;
        b=UxmZrKKVwpc7Ifjhgcwfbnh74jhK+FA6wb827H5B4BYFClrIb6lbtCSfI8ljBfL9xP
         Jfx2oEuiRXCVKfXG5qi7+8tVko8Q0uLSMqzNK57H3+tORohI7SxdmLBl3E/6fp6+AsDh
         OubKdx3VNOQgN5svXB9Rg/A+gS+IHr7PL5sE/V3shAThkfa6L/NUOeFQnh99irSkM7Mu
         0pbtfh5yxX2ahRmdtOOarw28CBOPyHnZBXs+hdyY6rPUGLeguSNMJ6kq6oXS6VDIR4xE
         d3+HFlG6vePkGLUZjBUMjZgx/JpwvxG0GBYP7XSY45OOntUhRBFa8XTpk0fbv35m1x1H
         QrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795623253; x=1796228053;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LdER2mkFO0wbjr2+rc/aRUmp4/Sc5QyLtaG22Ye9JSE=;
        b=atknsISMeSL9vnoKdKMPbsq+VYMY4JaASKzH+E5g6Ii7qrclIPQNg82wlv9uQh7dJ/
         K0dj8r79aQQdEMXsHFozBaFX0KSxS+YV8bLCis688KcmWJ3ZerqYqpQvos6DfCsEI1Mr
         zkjHW8AU5jy4IpxwfS0R94gVviPU6g7w1PxaO7IiOu/i3Vxll3byySdajA3hyJbyrRvl
         X5WpAWEMnsKMozsednfZdJZXyQXPNAR/TkFkSstd0mgda0GPXV0Qz+Hn+STuUAIywsTU
         bmBinWFWQy9Jx6E4aTbxs5JI+J+bu839hpHBDP+++coqte4xAec0Vdx8yOyi6TiYX92R
         5nzQ==
X-Forwarded-Encrypted: i=1; AL+hErEmPggnlaJaaYgXp3+MIcmB+GcehleZtrQlXrAkpdJ/FFm3OeUDsvGapewV2mh0Bo8WXhcvK0XK@vger.kernel.org
X-Gm-Message-State: APuU4Z9uUAgdg6oIr5FiKVVJr7w5zWoEaA3U4ta78zuThhVQDOMPL6uC
	1COBpcn6j6EHM5bXIG5Yrqh2qHkj95FcJTg2EmKImam5dpgwvYwukuikMs4Qbf/WCnslquwbpHx
	AFM9thWCI2jN3SVhdQWKmCkLun9e0Rv7OqoIqxvzubqC32rFzH+F3NTEJOGmybeVMgfEa9Gl4uR
	Z3s9A2jxdvLtaqQp28YX2+BAEKcEECMKt83Q==
X-Gm-Gg: AZFdTZerfDJFIXGv1Rre9aa7IZIJK9X7NxLVWo3oiB1xbkfRLEoGfZIPKrYD7Xe45N/
	v8rD7bZK3Y4Xj1Ap0quB6Nb9vYrDh5YSBAtn5OLb3b0U41O4fjOFRU3pIYYXiaeyBEf0etlq2Tu
	jjIUvacy4Z1uVWhRxQciU070IHMZmXJlv4ld5gxyoH7ZQUDFWMf9+CCMYk
X-Received: by 2002:a05:6808:c3cb:b0:577:2888:47b3 with SMTP id 5614622812f47-57a0ac33d63mr20058847b6e.44.1795623253365;
        Wed, 25 Nov 2026 08:14:13 -0800 (PST)
X-Received: by 2002:a05:6808:c3cb:b0:577:2888:47b3 with SMTP id
 5614622812f47-57a0ac33d63mr20058815b6e.44.1795623252854; Wed, 25 Nov 2026
 08:14:12 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124-v2_20230123_tjmercier_google_com-v6-0-dce12fa03ad6@redhat.com>
 <20261124-v2_20230123_tjmercier_google_com-v6-2-dce12fa03ad6@redhat.com> <sashiko-outbox-233444@kernel.org>
In-Reply-To: <sashiko-outbox-233444@kernel.org>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 25 Nov 2026 17:13:58 +0100
X-Gm-Features: Aa3M54qC4BhV46Zvi5xNNVUyWvQwOqnECHDuj67-iKiUZ4P0AUQ6JhGMrN001Kw
Message-ID: <CADSE00KEAYZ+saAoTY81VNhNyevsWFD_nSDNgsPVfvvLBsE5vQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/7] dma-heap: charge dma-buf memory via explicit memcg
To: sashiko-reviews@lists.linux.dev
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
	Stephen Smalley <stephen.smalley.work@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, 
	Philipp Stanner <phasta@kernel.org>, airlied@gmail.com, dri-devel@lists.freedesktop.org, 
	linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	echanude@redhat.com, mripard@kernel.org, media-ci@linuxtv.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 2:05=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] mm: memcontrol: task_css() race with migration in
>   get_obj_cgroup_from_fd()
> --
>
> commit 62e5304eba9bb9d84f6229eddf1a9273649483b8
> Author: Albert Esteve <aesteve@redhat.com>
>
> dma-heap: charge dma-buf memory via explicit memcg
>
> This commit adds a charge_fd field to struct dma_heap_allocation_data so
> DMA_HEAP_IOCTL_ALLOC can resolve a target cgroupfd or pidfd via
> get_obj_cgroup_from_fd() and charge system heap allocations to that
> cgroup.
>
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index e4a9af2fdaa3b..7826bc21bea9e 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> [ ... ]
> > @@ -3171,6 +3172,88 @@ struct obj_cgroup *get_obj_cgroup_from_folio(con=
st struct folio *folio)
> >       return objcg;
> >  }
> >
> [ ... ]
> > +struct obj_cgroup *get_obj_cgroup_from_fd(int fd)
> > +{
> > +     struct cgroup_subsys_state *css;
> > +     struct obj_cgroup *objcg;
> > +     struct mem_cgroup *memcg;
> > +     struct task_struct *task;
> > +     unsigned int pidfd_flags;
> > +
> > +     if (mem_cgroup_disabled())
> > +             return ERR_PTR(-EOPNOTSUPP);
> > +
> > +     CLASS(fd_raw, f)(fd);
> > +     if (fd_empty(f))
> > +             return ERR_PTR(-EBADF);
> > +
> > +     css =3D css_tryget_online_from_dir(fd_file(f)->f_path.dentry,
> > +                                      &memory_cgrp_subsys);
> > +     if (!IS_ERR(css) && !cgroup_on_dfl(css->cgroup)) {
> > +             css_put(css);
> > +             css =3D ERR_PTR(-EBADF);
> > +     }
> > +
> > +     if (IS_ERR(css)) {
> > +             if (PTR_ERR(css) !=3D -EBADF)
> > +                     return ERR_CAST(css);
> > +
> > +             /* fd is a pidfd */
> > +             task =3D pidfd_get_task(fd, &pidfd_flags);
> > +             if (IS_ERR(task))
> > +                     return ERR_CAST(task);
> > +
> > +             rcu_read_lock();
> > +             css =3D task_css(task, memory_cgrp_id);
> > +             put_task_struct(task);
> > +             if (!css || !css_tryget_online(css)) {
> > +                     rcu_read_unlock();
> > +                     return ERR_PTR(-ENOENT);
> > +             }
> > +             rcu_read_unlock();
> > +     }
>
> [Severity: Low]
> Can the pidfd lookup in get_obj_cgroup_from_fd() spuriously fail with
> -ENOENT when the target task is concurrently migrated or has an exited
> thread-group leader?
>
> Between task_css() and css_tryget_online(), the task can be migrated to
> another cgroup and its previous cgroup offlined, causing the one-shot
> css_tryget_online() on the stale css to fail.  Also, pidfd_get_task() on
> a process pidfd returns the thread-group leader, which in a
> multi-threaded process may already have PF_EXITING set and remain
> attached to an offline css even while its obj_cgroup has been reparented
> to an online ancestor that get_obj_cgroup_from_memcg() walks up to:
>
> include/linux/cgroup.h:task_get_css() {
>         rcu_read_lock();
>         while (true) {
>                 css =3D task_css(task, subsys_id);
>                 /*
>                  * Can't use css_tryget_online() here.  A task which has
>                  * PF_EXITING set may stay associated with an offline css=
.
>                  * If such task calls this function, css_tryget_online()
>                  * will keep failing.
>                  */
>                 if (likely(css_tryget(css)))
>                         break;
>                 cpu_relax();
>         }
>         rcu_read_unlock();
>         return css;
> }

Valid. I will apply this for the next version.

>
> Using task_get_css(task, memory_cgrp_id) before put_task_struct(task)
> would avoid both failure modes.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-v2_20230=
123_tjmercier_google_com-v6-0-dce12fa03ad6@redhat.com?part=3D2
>

