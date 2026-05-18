Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED6E331A41
	for <selinux@vger.kernel.org>; Mon, 18 May 2026 23:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147558; cv=pass; b=pKvOZfKcOPwpWO57+0Y/TziYL5JflVdrhAftKnDdidzWBJDnY3zUQ2nAUoB6ImfW/dyp/RJS5tfrf1xPc8jzQxGKUGZFsA3Kt2lU5BkQdzgeGNYo0eqHdYDcJ9TkdocIz1P2TC0EGcWVotrOJ2UCehu09OROQ6z3hz3Tj/RgYAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147558; c=relaxed/simple;
	bh=Mcq8G65erSH6P+qgAE9z4eUjbK8B0zwTDtFgfrR4hAQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXxUcPm61GXOOUkWA++TCKaQ7JlNVO++tdUBMRGrdAzT39HiEOZnzXEpnqF7TeaLO/evgxPryTvNPGFnBOMeVcPldawHPZxtmTlr7JznxKPWOn5rU8UNvXc1URrFeJIF6cWo/ERTMktlv2mReOQC+j5+VNrgZhjMadTd0kOmD/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dkjI2+F7; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dkjI2+F7"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488940ccfa6so605e9.1
        for <selinux@vger.kernel.org>; Mon, 18 May 2026 16:39:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779147555; cv=none;
        d=google.com; s=arc-20240605;
        b=EIoky4FhUKzil1aAJl7MLUTrthe7FQbXJt5V9aVA4hD/hQ761onHdk+X1Uz3viUUa2
         m1DMSnmPfXeZARkk5lWTJZ/RwmfsA523xu1jeNVSWLCawV0Kvl67Ar5paptpstewwaTr
         QhMU/+e/R6vGlawQS6fsH7zN58fPVPUcFU4GYYoSugbspzV5hsxy4mcB99t2exld7d4/
         +L8JjgfXlXJ+Q+I1oOoqpRRMDdHBdII6ITWeOazUuV97D2MiGGu+z6tBlZTxteMtXVBV
         2dJZzEUX7MKfZK/GJaQzkZotm63hga8boKifA8v1Hu4ACMsbYJjgiqt+7aOivndSgciz
         T/wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mcq8G65erSH6P+qgAE9z4eUjbK8B0zwTDtFgfrR4hAQ=;
        fh=Mvmct01xNntvAWeDibmxHRbiJ7N+s7o9IqoIuL3Wy/w=;
        b=T7u/pq47+wzMDQ0MXhwDrq33sFDVb6VqfEFwWGeXB9D99c/V8XmQrpo9bOu+xO3Cfu
         ZaP28/ViSsqBVkwtHZ3P1CSB/z8sNirdyWfXK0HHAmuPa4PVDylts2oPRbwN4wVknVbK
         6nUliY8rtHnoGPqvLKwacCmpSnMB/B5oCeMU+jvNPNToMs8w4TQQMnET8e1GN0g+ya9G
         O2cJaUCKOk4iawbhzMk7jQwpwuAq0qzU9/dw6x9ZGScs/YT0TQTdkk93kc67KSYMERNK
         50hgl63HffdVS9WDfREReZespDBzmMFMTU99UEla2H2gVj6w7F+5F+HWBnheKnN+k1Ni
         WLBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779147555; x=1779752355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mcq8G65erSH6P+qgAE9z4eUjbK8B0zwTDtFgfrR4hAQ=;
        b=dkjI2+F7xyeNSzdsRkisNqvLDdT+z1hxl9TqH+vTr9fo+IMNw4yxxGDpchnWUChTMr
         yMsT+EFry89MDfnSEnxXSx7sE6owGiucGUvDKOMygt/POfNsImvmtpSE0oxGyFblsp4d
         exXs7zkZnaXIVunKRILF63382NxZrY7yv7/H6C9WS3dTfhBZcOheGfH9wS6KnDtxCBfl
         j/UZZputPk4x0gnpNbY+uRoS2W1bMVEYrMhGdl8h97Prs1A5v4Cx8UEfUSozQChCEUQ+
         KCyvWab1sW6A5ShyoBXx88D5J+60TP8b5gz24B4aybyFPTXTkI56d6Fckz5g3cyUsQAb
         SG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779147555; x=1779752355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mcq8G65erSH6P+qgAE9z4eUjbK8B0zwTDtFgfrR4hAQ=;
        b=C71Nhsuj2FrN/VfWDgJsvsssa8Oad+bFQRFee5XAT7KbWb6PjS+PNWvqX4jccdLxcc
         C4Cj3/WvcW5Wk+7486lS+A/1sH9Kr2+YD1XtBPNRPkcNgk2K1oxpCp2H49TI0QugfF8S
         h4gh1sRF/AoH+lhVr5Xe74noCPPrObOLm59dXSaThvQK9Dgiy7HEkNndpjVepaKLnZM0
         X39/jK3c1bmF8zLd8CbbMvB3f1S0K65UjF36FZgb6yqGgrQgSSzmRVE4b21JyeGqnWFT
         7q500lzGj0qtVJD2rqYxfnRlRM3dGr60I7P9o5E7z8ZYybR7KgjRVpoBlktO7QwlRRTL
         vP0g==
X-Forwarded-Encrypted: i=1; AFNElJ/nQWNjlhurAW4+r32rxzluLqnYavyTmZRTstxSCdslYJ4RDYbU7zQqx2+YoZTtXZDtRQqRtocb@vger.kernel.org
X-Gm-Message-State: AOJu0YzpB0Ik7cv7sbbofQmYEp/pYWDZBCectRbwTF4A9WaotZbFsUk8
	ARqY+YHEHeaenoGRXVIB7SUrdYlPUdZ7SncgT9PK0XeiDB7jCLEWt7prz65MxPWsj7Thpmb0ax0
	jKuoZKuQdsqD9lGT1ZTJtPnlmA8v3cT50yegZ4nON
X-Gm-Gg: Acq92OF58SbCFn3DYcWX7R+BV5CCrISEmZadfYW9GLcD4BtQHjkEIXO6apUf1gKXi37
	PHBstoNqMzS70kM9x349calR6aFsBqnHaBohmAeybKQ7872ZeZFAaYnLDYSr3TyaZXGa5/5TmAL
	Vi2aqs3MLRkWA/Y+LeltLIGgP913ck0tC/LUEyH5phL1bhN1Nms+2PzUmbUQYOLe8tJnZ3MV/fh
	nuoiIyLISGFamwFmiVK5o5eRt3Qf0RM60N6GUViMVZq5ZM8H8NGzfN9HSkKBo449xomCFnJRO4C
	hSBHbY+pFUz9igZUnBZ2ZoMoAYgiltB1kH62oVCZPofWCOtJ
X-Received: by 2002:a05:600c:83c4:b0:48a:56fa:36dd with SMTP id
 5b1f17b1804b1-48ffd85790amr3271995e9.11.1779147554173; Mon, 18 May 2026
 16:39:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-v2_20230123_tjmercier_google_com-v1-0-6326701c3691@redhat.com>
 <20260512-v2_20230123_tjmercier_google_com-v1-2-6326701c3691@redhat.com>
 <20260515-hinschauen-effizient-9e3a05a94f2e@brauner> <CABdmKX0d6Zsg+_TxXjB80UZR23ZvXzxYoWzORgwmx=ZiuE+Nzw@mail.gmail.com>
 <208fb820-d8eb-4832-a343-ef8b360e8120@amd.com> <CADSE00Lh95ygoXGKJGsYvQGEsFV8sVmwEC3uvh8M6r3ERzaJwg@mail.gmail.com>
 <88efe10a-8b93-4a81-8279-4a5559d0f17c@amd.com>
In-Reply-To: <88efe10a-8b93-4a81-8279-4a5559d0f17c@amd.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 18 May 2026 16:39:02 -0700
X-Gm-Features: AVHnY4K5WzHxjnmBKK1J4Ij9G3s1JmujGOC18rtfp3AXYH6mFeA4fkV1W-efX6I
Message-ID: <CABdmKX3yZubjDKbVqwrjHAiKyj_ioHzOoxd0wzFbJK=PAGOqcQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] dma-heap: charge dma-buf memory via explicit memcg
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Albert Esteve <aesteve@redhat.com>, Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, Paul Moore <paul@paul-moore.com>, 
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

On Mon, May 18, 2026 at 7:07=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/18/26 14:50, Albert Esteve wrote:
> > On Mon, May 18, 2026 at 9:20=E2=80=AFAM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >>
> >> On 5/15/26 19:06, T.J. Mercier wrote:
> >>> On Fri, May 15, 2026 at 6:53=E2=80=AFAM Christian Brauner <brauner@ke=
rnel.org> wrote:
> >>>>
> >>>> On Tue, May 12, 2026 at 11:10:44AM +0200, Albert Esteve wrote:
> >>>>> On embedded platforms a central process often allocates dma-buf
> >>>>> memory on behalf of client applications. Without a way to
> >>>>> attribute the charge to the requesting client's cgroup, the
> >>>>> cost lands on the allocator, making per-cgroup memory limits
> >>>>> ineffective for the actual consumers.
> >>>>>
> >>>>> Add charge_pid_fd to struct dma_heap_allocation_data. When set to
> >>>>
> >>>> Please be aware that pidfds come in two flavors:
> >>>>
> >>>> thread-group pidfds and thread-specific pidfds. Make sure that your =
API
> >>>> doesn't implicitly depend on this distinction not existing.
> >>>
> >>> Hi Christian,
> >>>
> >>> Memcg is not a controller that supports "thread mode" so all threads
> >>> in a group should belong to the same memcg.
> >>
> >> BTW: Exactly that is the requirement automotive has with their native =
context use case.
> >>
> >> The use case is that you have a deamon which has multiple threads were=
 each one is acting on behalve of some other process.
> >>
> >> At the moment we basically say they are simply not using cgroups for t=
hat use case, but it would be really nice if we could handle that as well.
> >>
> >> Summarizing the requirement of that use case: You need a different cgr=
oup for each thread of a process.
> >
> > Hi Christian,
> >
> > Thanks for sharing this atuomotive usecase. If I understand correctly,
> > the actual requirement is attributing dma-buf charges to the right
> > client, not putting each daemon thread in a different cgroup?
>
> Nope, exactly that's the difference.
>
> The thread acts as a filtering agent for both memory allocation and comma=
nd submission for somebody else, the process on which behalve the daemon do=
es things can even be in a client VM, completely remote over some network o=
r even something like a microcontroller.
>
> Everything the thread does regarding CPU time, GPU driver memory allocati=
on as well as resources like GPU processing and I/O time etc.. needs to be =
accounted to one client which can be different for each thread of the proce=
ss.
>
> The only thing which is shared with the main process thread is CPU memory=
 resources, e.g. malloc() because that is basically just needed for houseke=
eping and pretty much irrelevant for this kind of use case.
>
> The problem is now you can't do that with cgroups at the moment but unfor=
tunately only the kernel has the information you need to know to do this.
>
> So what you end up with is to define tons of interfaces just to get the n=
ecessary information from the kernel into userspace and then essentially du=
plicate the same infrastructure cgroup provides in the kernel in userspace =
again.
>
> > If so,
> > the `charge_pid_fd` approach achieves this directly by passing the
> > client's `pid_fd`, without needing to add per-thread cgroup
> > infrastructure.
>
> Well it's already a massive improvemt, we could basically stop doing the =
whole duplication part for the GPU driver stack and just use cgroups for th=
is part.
>
> Doing that automatically for CPU and I/O time would just be nice to have =
additionally.
>
> Regards,
> Christian.

Hopefully I'm following correctly here.... So you are duplicating the
GPU driver stack to achieve remote accounting on a per-thread basis?
Does this mean for GPU allocations you currently have some GFP_ACCOUNT
magic in your driver to attribute GPU memory to the correct remote
client? So this series would close the gap for dma-buf allocations,
but what about private GPU driver memory allocated on behalf of a
client?
