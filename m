Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795010139;
	b=hRaLjPkmWbrNINwibaB4CN/UTGZL8eTM/MtTLm40jo2tQMxA3KjYF161jSJXRv8FqC94
	 4pEnLm9aENcn06Tb/VhBkDnum4dluV6L/jO+004KZq6DwVf82x1xsACADgjGKVgC2adx1
	 +Kh1aVAiaTneF5mnKupG07ciBbCvfV/vs6tW10YXP7PeTBAzBEMlvyE7AVVw6n0kTImgV
	 0vAGsxdXbiNCPuk/QBtOxp3Gv+l474E5SIN2jtWL2zVbx5PLcsvBtE3vMRj2qmwze7bb/
	 lf9hwK6kFDhH2iUiVEd6lPmmCzrPIOuVvXP9RdsDvevLZWos78eMBIQTnOWAgosvrjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010139;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=Q93IOK+81L655tUS3XT9KzQ8Uws4KOL15ej2huBrpiw=;
	b=qERBu5k2ry8T9kqTh5nWy4KOwqDrde/Amx9B5s0ffza/K+lseRsFYzWQcoQemzpNHliW
	 xJ8onThjJlYoSs6S4UvSVb96bJoF0hE2Mx2x7aPv+dNdtvZT+wgCVrrGO5LEuYcE4IV42
	 2xu2kNgAYtgSXTkZX+lnKPxSck9l5bex/2j2bgo+82dQwOvQWytiXWNIjBJyEDdTq+lJw
	 4G3U5GdSmnZg+B66kkRumBtfY1nAhfsu41rRvTGjrE9CT+SCGw/3HYlTKC6IJ7lsrkb35
	 rR6eSxOrLBgNZhAiF2C+yqx9TqzbJvlECOhux+g/I5HbXeoxKGQIXntU+JEFzjadRSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QXfsJqiv;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="YdeGXNs/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EB4606A331
	for <selinux@vger.kernel.org>; Wed, 18 Nov 2026 13:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6EB4606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QXfsJqiv;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=YdeGXNs/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795010137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q93IOK+81L655tUS3XT9KzQ8Uws4KOL15ej2huBrpiw=;
	b=QXfsJqivqBNqfL8AggaLxuMEBU7EfXUwQ79yX9mkY0DsyoJKv14Jj/OiqP17IwmtwHUvtm
	hDttkoYGz0xiCc9jOMzkOF5g6m+QAdI/wa8hDJ5BtVIpXff4tFeOjBu8nPrel8lbwUuT3W
	PR8WTtsSxNEPBpbDUz0KfAdFrL/sUoM=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-BfH89V6iMoi2qsKX1lduAA-1; Wed, 18 Nov 2026 08:55:36 -0500
X-MC-Unique: BfH89V6iMoi2qsKX1lduAA-1
X-Mimecast-MFC-AGG-ID: BfH89V6iMoi2qsKX1lduAA_1795010136
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-677c4ca22c5so1264913d50.3
        for <selinux@vger.kernel.org>; Wed, 18 Nov 2026 05:55:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795010136; cv=none;
        d=google.com; s=arc-20260327;
        b=Mx4DwTd/D/3iEoOl9bgLNcX8l1wHq6ZN4MafTo7Sy5HaLSyhdL9SOC73vn1EYQ0WM3
         ISJFDews0OdLz5NFbLpFgISG1UosPxFPIfQ6opNbbRB7bcr0gZjuoBEAnmRE0LRl6lyZ
         5IOn9cUgSUdvxRE0BzOBWCMlAm0C4lnQPx13Pg0+/vUxzUaTCxrLsEDzUE8sjtKk1sPf
         zilPqK7Fx54NEaJlmll1QoxQXUxEGeFysI3hEK0omizuOL7OO6UR3LNekqzQOSYAeu5o
         bz+dEUBSEqnWAI6mv7HI2KRKW7PQ318nTvWbdJ7V8hXuOnKSVc/jqj5tcJuHH8UA1h2b
         1InA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q93IOK+81L655tUS3XT9KzQ8Uws4KOL15ej2huBrpiw=;
        fh=Kokkkb8vIXOSphqjqff3EwTRb866SfMbBp/gvx81WgM=;
        b=aiLQp5W8XQ9G/iccV401dFDYZMSKuK1Nq4elq1Gj1aSmAEqLhIpMxXIy32+7EbTj9J
         geoKZXAlHLCeWLjnXrqSxBc4nfh6U1fpkk7/oxului9YihIv8PLutxMU1VTXbiYtIsuE
         kYbAViQy9qlNREJ53EjxZHU8fl3NXHjv/HdlgwTm/X1ismqi6vre8ec7QaVs6sr5pBNo
         B8LsVNT3H3l6FnJFXOsj3kI471G2czIFk8mPtowRPAZEvp1RCmRZ5iYjMz0tkwe5m4CF
         DDaF40K8a3/r7gRN3KK1z2ejB6ZdxczgZTrDHjXwv3jBIyoW5YYrTini+ujI4oBQeoDe
         Yvrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795010136; x=1795614936; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q93IOK+81L655tUS3XT9KzQ8Uws4KOL15ej2huBrpiw=;
        b=YdeGXNs/g+hxp03HRbQSUUfYwpG+Q463Psgnm5pI6nowFTE0GT/AT+9Eba8UqJXu2F
         Rjm7s6KZtfcTE+jLnJqY9Yha9DiDRbhjBVk9n/zG7Tl/p4QVD4cOVryiVPrvuioWjJ2V
         kC4s94SucOy//FSYm1394CoCF5UK5zXU1gxH2PfPcfRIkd2mTJdDSJhVy7FSL4lT5EZc
         m+HBczANYjijzYP43BM9ZWyF2lkON43QQgIwWQhgllRW+41fvFVuY2rQaXLV1H9y0Dqo
         Sq+5Nt2E0oRySNF5RHc6s28Fs0dEBL+ug6DeSjIEnvBqVwZGg+FdASv6oArpfSCSBBSS
         kWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010136; x=1795614936;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q93IOK+81L655tUS3XT9KzQ8Uws4KOL15ej2huBrpiw=;
        b=UnTbmKIuv4OhfqIxXrX2QVHyvR99JttwKnXaUjovhKiexqVOpk9nQBCNIsKBfk81Nw
         QHR7lY+6dG7NtLYqBJ4ed5jgT2vakCTi5XSeBkOqpd69Vmc/b1IBfjkMf2lxdZA2pN0D
         GO8VT/7yMUI0d9lfVQ/k58w5CgTiUcufseeEfywwlcOKNhzmIofFNfzGvoxP/mXKBFEy
         yMMpoX98TefCGzxwGO4+rDqjNW92D04luEd1bgSwC2FjITCQstUp2CMx2O+c3F0DFktg
         u1ouGb4e/UoUPC3y+aHc61YzbFpnaKMFk/sEGJzx8TywrH5wmORvQ+nj717dUxlFixkC
         B2BA==
X-Forwarded-Encrypted: i=1; AL+hErGZ8udVdi5CldSi/dQU3puX6a8DNDgiZaVm6qef31SAfOif5ffvCxmYNVE+6bv4/6ieIJ11QakK@vger.kernel.org
X-Gm-Message-State: APuU4Z/6eR1rauE363L3hFALWWG6/lhSEW2slHxVJyWMMRX7lVruNsOQ
	DjGAYDArfZVGabCpSz3KVWzlkZIxl8zOimWv7DJwp7QLTJHp6ak1CnZFx6bRRZmCrlsJJRewG0l
	+XFnJEBr6MdgmphOggC7Edm/3QIpfFZ8idHqWipavMn23ZGQ78CqwIagDhed6Zv6K0gaQdT53+j
	LuWOuSXzymm13MubvxfDS4F+IASqJ3oz2U2A==
X-Gm-Gg: AZFdTZd1MC0OoN2CMp5J0NjpuWJuDVKo476OAfM4kjU5f+uU1CJL09cEx2CtATvK/Lz
	Onx2ILBlim8qpGzEjuVagBgUvevTapyB4H61JnHuj5VysQrIpw5FFj3KS5wRjJDyZF14o1LucgU
	RJZxEikfuH60ssh+O1ypnr1ncjV+Noq+mWpAdiKm9QLYcLkR5amr6qeEtv
X-Received: by 2002:a05:690e:1387:b0:67b:f249:5b16 with SMTP id 956f58d0204a3-67dd3fdee8amr1338605d50.55.1795010135882;
        Wed, 18 Nov 2026 05:55:35 -0800 (PST)
X-Received: by 2002:a05:690e:1387:b0:67b:f249:5b16 with SMTP id
 956f58d0204a3-67dd3fdee8amr1338592d50.55.1795010135440; Wed, 18 Nov 2026
 05:55:35 -0800 (PST)
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-v2_20230123_tjmercier_google_com-v5-4-1ce975f2a9ad@redhat.com>
 <44c0c45c0e2f47ed77bc45be47ebb3fb@paul-moore.com>
In-Reply-To: <44c0c45c0e2f47ed77bc45be47ebb3fb@paul-moore.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 18 Nov 2026 14:55:24 +0100
X-Gm-Features: Aa3M54okPSWfJ_g3ixS3iw1yy5owTDFGTKhnOXZ64bND8Gaqu8R-9XYtSNGyOOw
Message-ID: <CADSE00LVsFVOmezzLgPrPWDd+L+SSGzGvqKTiX25waxRnVPh9Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/8] lsm: Add memcg_charge_task LSM hook
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
> > Both DMA_HEAP_IOCTL_ALLOC and the new DMA_BUF_IOCTL_XFER_CHARGE ioctl
> > accept a charge_fd field that, when set, causes the allocation to be
> > charged to an arbitrary process's cgroup rather than the caller's.
> >
> > Charging is currently limited to the caller's own memcg subtree unless
> > the caller holds CAP_SYS_RESOURCE. But the capability is all-or-nothing=
.
> > A process holding it, along with a dma-heap device node or a dma-buf
> > fd can charge unlimited memory to any other process's cgroup, potential=
ly
> > exhausting that cgroup's limit and triggering OOM kills independent of
> > the victim's own activity or privileges.
> >
> > Add security_memcg_charge_task(), called in get_obj_cgroup_from_fd()
> > when charge_fd refers to another process. The hook receives
> > the credentials of the allocating process (from) and the credentials
> > of the process whose cgroup will be charged (to), giving security
> > modules a controlled enforcement point for cross-cgroup objcg
> > attribution policy.
> >
> > When CONFIG_SECURITY is not set the hook compiles to an inline
> > returning 0, adding no overhead to the fast path.
> >
> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
> > ---
> >  include/linux/lsm_hook_defs.h |  1 +
> >  include/linux/security.h      |  7 +++++++
> >  mm/memcontrol.c               | 11 +++++++++++
> >  security/security.c           | 15 +++++++++++++++
> >  4 files changed, 34 insertions(+)
>
> ...
>
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 03cd90d5e623..2e6fcbe14d43 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -60,6 +60,7 @@
> >  #include <linux/lockdep.h>
> >  #include <linux/resume_user_mode.h>
> >  #include <linux/psi.h>
> > +#include <linux/security.h>
> >  #include <linux/seq_buf.h>
> >  #include <linux/sched/isolation.h>
> >  #include <linux/kmemleak.h>
> > @@ -3198,10 +3199,12 @@ static bool mem_cgroup_may_charge(struct mem_cg=
roup *memcg)
> >  struct obj_cgroup *get_obj_cgroup_from_fd(int fd)
> >  {
> >       struct cgroup_subsys_state *css;
> > +     const struct cred *tcred;
> >       struct obj_cgroup *objcg;
> >       struct mem_cgroup *memcg;
> >       struct task_struct *task;
> >       unsigned int pidfd_flags;
> > +     int ret;
> >
> >       if (mem_cgroup_disabled())
> >               return ERR_PTR(-EOPNOTSUPP);
> > @@ -3226,6 +3229,14 @@ struct obj_cgroup *get_obj_cgroup_from_fd(int fd=
)
> >               if (IS_ERR(task))
> >                       return ERR_CAST(task);
> >
> > +             tcred =3D get_task_cred(task);
> > +             ret =3D security_memcg_charge_task(current_cred(), tcred)=
;
>
> Do you ever envision this "from" cred being something other than
> current_cred()?

Good point. No, I do not.

> If the answer is "no", we might want to consider changing
> the LSM hook slightly to help prevent misuse in the future:
>
>   int security_current_memcg_charge_task(const struct cred *tcred);

Agreed. I'll apply the same to the cgroupfd variant for symmetry (its
"from" is also always current_cred()).

BR,
Albert.


>
> > +             put_cred(tcred);
> > +             if (ret) {
> > +                     put_task_struct(task);
> > +                     return ERR_PTR(ret);
> > +             }
> > +
> >               rcu_read_lock();
> >               css =3D task_css(task, memory_cgrp_id);
> >               put_task_struct(task);
>
> --
> paul-moore.com
>

