Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8EB18FC93
	for <selinux@vger.kernel.org>; Thu,  8 Aug 2024 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132104; cv=none; b=Rs7mHzNUhunqYrQTagKEltldRTSSk/DtdxfARjnD0+xcXKl8xf8fh145BoK2+YvGcHaFC3xFvwYsPrZ91q6SX45B+0S8ZDepqIES/wa0fd2+zkeUD6J+v+BhJ8F63f4HaUYmxLpov7Y9XEE/ohjfPxfaNuWWZU8E+4s5h5wl5EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132104; c=relaxed/simple;
	bh=QXY2B5zOmDT8KUATAmWeO02jmP9KHWTVSxRWFArHvyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMh4OMsxNdB5yKzi02JEXrBZvHiYy8V2P9lDdQ7uU4uhaXvZ3Lo+KM2Y+UBOTVLp1aoatrLR6Pn3APZtV4PlEko50GNcBg1LdB+rSvHnqvwAq9E2PcKO8X78FGg2oSf4ewQb8I4Ulvli9Xd0SvA9Uj+XoGpoZzDXxbYV6UNp14g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Xvqx+Tk7; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Xvqx+Tk7"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e0bfa0b70ceso1046364276.2
        for <selinux@vger.kernel.org>; Thu, 08 Aug 2024 08:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723132102; x=1723736902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22xwefQTm5yCA00hBHdSOjXx4hMeWSAiLR6KMP/J2n0=;
        b=Xvqx+Tk7QmqLmIgGfPqflXxcUdWkdxJuGdbDJv+Qa11kxOn6SUwYhojnKuZKwiRE7q
         146wHj9bowvoaA8gU2RiXo5WRDVKBSCa0IrQatXqPIaxc1MAon0+UuTMSYfg3eugoBcW
         /N9YUnKNQiUBgUoFueVC8IxwgZx24jFskbBbAdh5nTLzPaDQ6yfRJY7hNN1CFqbsvBGf
         9CreRqfRq/8SvyGvhZlLYkJo/D7G2Lnp9UcaTVjFNavuakUVcC+u2ZNG4IcBOB7BKPBf
         dsM3azKfyixo4Rq71PmrD8tm0lBQBoGLoN7ryEnRKLGhvfuGL83o2NUEdrJw/Ojv+xEH
         NnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723132102; x=1723736902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22xwefQTm5yCA00hBHdSOjXx4hMeWSAiLR6KMP/J2n0=;
        b=mas8OScQJAJF0+cnZD+q2OtelzJwHuHuH4M/kmihT3IH0MKvk7xdul2Dm85KUUOBDW
         BYYdJhkMheUCkbHIIZvQI7RuwPuQsIPzDS7GLbmQbLRLdihY260ZdB8y+9Gr67ISlKv/
         FVOxRYkjQ6wgrxtyb92k4cR0hFlLDDPoxEp+od8cGXEQp0RSG2yuh2iVvA8pYbHdu/3P
         c3IivCJgMy563UrsGl72vbGN7rS/ib3UbbXTOrzGVnnG09UpxGI/qhEL3dJqc3FmxPrW
         myOd695Fd9o7KqJuHErM8bkzbw5GYdEPt9TgpVyl+AO27TWFpRC00nWwRhuqIoRYRUcN
         A4LA==
X-Forwarded-Encrypted: i=1; AJvYcCWKHnQVtzCi7wR5kePB2rMoer3hBkpmP2JyduDxtJBroGqdZ5yW1etw7jJ36Z5014247CvszFKX@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj21Txh9958RXdx4f2JuiTiMDvUEFsJsIQfv/fa6czRqYXKZjq
	Tn3XkPyvMbSxCRT75diEwiPYcz5oBZxkQgajB9QCqQJAoyHxvOvKmSlAizxgtNHynEBmNo4N9MO
	d9DW2NtXr/i/sdfOqJhX2M0WjNVb7Vdf9yuWY
X-Google-Smtp-Source: AGHT+IFsntQfurwiu3E1dnmz1AS910G1RH89ZcxrIjyTqHbKfs86gPKiV+MEE8/m33GxcSnhu/X33dNFjoVsD6krZTg=
X-Received: by 2002:a05:6902:250e:b0:e0b:e279:9940 with SMTP id
 3f1490d57ef6-e0e9daaa03cmr2421446276.15.1723132101728; Thu, 08 Aug 2024
 08:48:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808130909.1027860-1-wangkefeng.wang@huawei.com> <CAEjxPJ4b2Xcptmi2cJNyh=N=1ky=yfg_wVB1yDLwr8uuhujxew@mail.gmail.com>
In-Reply-To: <CAEjxPJ4b2Xcptmi2cJNyh=N=1ky=yfg_wVB1yDLwr8uuhujxew@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 8 Aug 2024 11:48:10 -0400
Message-ID: <CAHC9VhRz=drY-=W64VezugemWsBgaQZS_NQ2TZzrS0-fhZgg6A@mail.gmail.com>
Subject: Re: [PATCH] Revert "selinux: use vma_is_initial_stack() and vma_is_initial_heap()"
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	selinux@vger.kernel.org, Marc Reisner <reisner.marc@gmail.com>, david@redhat.com, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 9:40=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Aug 8, 2024 at 9:09=E2=80=AFAM Kefeng Wang <wangkefeng.wang@huawe=
i.com> wrote:
> >
> > This reverts commit 68df1baf158fddc07b6f0333e4c81fe1ccecd6ff.
> >
> > The selinux only want to check whether the VMA range is within the heap
> > range or not, but vma_is_initial_heap() helper will check the intersect=
ion
> > between the two ranges, which leads to some issue, let's turn back to t=
he
> > original validation.
> >
> > Reported-by: Marc Reisner <reisner.marc@gmail.com>
> > Closes: https://lore.kernel.org/all/ZrPmoLKJEf1wiFmM@marcreisner.com/
> > Fixes: 68df1baf158f ("selinux: use vma_is_initial_stack() and vma_is_in=
itial_heap()")
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>
> I was only going to recommend reverting the change to the heap check
> but in case Paul is fine with a straight revert,
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>

I was hoping that the mm folks would put together a quick patch to fix
what looks like a problem with the helper, but I'm not sure when that
is going to happen and with other callers I don't want to change the
helper and break a different part of the kernel.  Unfortunately that
leaves us with needing a revert, but like Stephen said, I think
reverting just the heap helper is the right thing to do right now; I
also want to put a comment in there for the next time someone tries to
re-add the vma_is_initial_heap().  Give me some time, I'll have a
patch out for this later today.

> > ---
> >  security/selinux/hooks.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 81fbfa5b80d4..f5805d4b0aec 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -3845,10 +3845,13 @@ static int selinux_file_mprotect(struct vm_area=
_struct *vma,
> >         if (default_noexec &&
> >             (prot & PROT_EXEC) && !(vma->vm_flags & VM_EXEC)) {
> >                 int rc =3D 0;
> > -               if (vma_is_initial_heap(vma)) {
> > +               if (vma->vm_start >=3D vma->vm_mm->start_brk &&
> > +                   vma->vm_end <=3D vma->vm_mm->brk) {
> >                         rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS,
> >                                           PROCESS__EXECHEAP, NULL);
> > -               } else if (!vma->vm_file && (vma_is_initial_stack(vma) =
||
> > +               } else if (!vma->vm_file &&
> > +                          ((vma->vm_start <=3D vma->vm_mm->start_stack=
 &&
> > +                            vma->vm_end >=3D vma->vm_mm->start_stack) =
||
> >                             vma_is_stack_for_current(vma))) {
> >                         rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS,
> >                                           PROCESS__EXECSTACK, NULL);
> > --
> > 2.41.0

--
paul-moore.com
