Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0308149C54
	for <selinux@vger.kernel.org>; Thu,  8 Aug 2024 11:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723117299; cv=none; b=JUnBsLvoJ+xY7UkhhK7BFTGgC5RDXkz2IzetPZKjd6XPg+n1dOyhFzFgukRdUh9NlakJnzUSqASagLN6hdP7EdkFnvebHDj9LbuWZETtxNDvzbAwASZvBiro5ixJjEiGjonF7FQUTDqeKBhlDzbbXp/WZbKICObrFdGbIK6IJsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723117299; c=relaxed/simple;
	bh=nDWtDLt3jtcmC3aSu6ZKYousHx4WfM/vc7ue5FHkUNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egNPyT5FIdQRAeazkl9+87tNUEN+JMSvf5u7APkEf2gQDw0et14NBaTe82xz2ECGZTEcZqFn+YjVsIELiz+kgwsQXsv0j+1t8KHIw23eIKs4D5mo5LtoVaET180+20ydqwtddIomlloR4Gtr7lpr9ncF9wmjw+e7Vhe/EameS1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ef2Uu/ij; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ef2Uu/ij"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d316f0060so1333897b3a.1
        for <selinux@vger.kernel.org>; Thu, 08 Aug 2024 04:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723117297; x=1723722097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQC5ANAEtAsbeERwnrtqReUBB7a86W2tR5dBZXz1o/c=;
        b=Ef2Uu/ijCNwfxUXrN6R7UwxyrFg6h2AR7Rw46yc/Uy1/5TTXJDe+rysl67q0/P1qFn
         MyliHWfXSknEOR55/JTAa/ddzp7pkflCpcbVGNOMzKkjL5PkIPdhkAS6GCbWmJc1jr4I
         9yNPixfiDF8l8OiCnobKk+cvpzPxekUaHpU6tLaad5dcmbtXc/0jxda0v+wuirz3KDKd
         uE6nW8Ub2JXUi/RoEkC5U6tm0Oia6yoFVi++cQFoOL9/mUck2cRgkOV/180nKknnWWfq
         GvY3IO5t1rB4ROZRPOU9CBenk9AILOKZ/Y+u4lhas0BICpHbjXYSzZSs0uA0gyFQWt8J
         69Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723117297; x=1723722097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQC5ANAEtAsbeERwnrtqReUBB7a86W2tR5dBZXz1o/c=;
        b=qCaOnVULRi+Ds8mqfEBd35NILUhHSJiha7TYrBK9xa6lnu555GvaIG1P7D12IwIkPw
         mY1YgEE7TNpzKl6449OxSCQ4suQOKTcUq9YPRwUDu3UcWgMpuT1nny9Lc9DWJ3Hmy4sl
         thV95o4Vw2tkTzm/a2k4E9MkhT++3T00rTUjU3hg8WN5PRFwNU6p5bwu4YULPEHf43jL
         jQ0gAe6ZsgePCIP+4Pi2Br0G2QI8ly4t7YF3C7FUwDsNwe9+JCm5oWPK5Hq2Dq2iUJmL
         2SggHkf8llLoGcNH90lmcI5JkTDGHtUMCEvM/Q2UpDEsk/JMohxLKZfbdL3Rxi5oMbxJ
         eWMg==
X-Forwarded-Encrypted: i=1; AJvYcCXYQTq6Vu74zHJYpHXu1MbsUlG2BB5apRAfJqxm+KE6sNb50P/pK6dn/wobkDf/caTtHLQNkOiiUfipuEe8a/Jn/73Hg1El0g==
X-Gm-Message-State: AOJu0Yz5UBGdGAnKJT2xUNUd7eWrKwIfqLS6sk8Q38Gs317UFKvQRp5c
	KEQG6M70Cz+k7tjfq07QxOjFi5wzJ+/v3Q5yGUvrWw1KqsPT9Jts0WkhvVK8vdZTTOphe87SflH
	DLpJUk1HJFhl67DBOq4suE1tLQbZJOg==
X-Google-Smtp-Source: AGHT+IEWS6VXtoOwEcI/7FBM9JGbq0+oxUrLumvL2djiY5s09SnbF50lsssVFrwrF+SgOppdmGcLqKulbhCgOu6e/no=
X-Received: by 2002:a05:6a20:6a22:b0:1c4:a4f2:6f77 with SMTP id
 adf61e73a8af0-1c6fd57279amr2724003637.15.1723117296785; Thu, 08 Aug 2024
 04:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ba8477ed-b7a1-4833-a01a-b7d43ddb47b8@huawei.com>
 <ZrPmoLKJEf1wiFmM@marcreisner.com> <CAHC9VhSWVdiuK+VtbjV6yJiCp=2+6Bji_86mSkj1eeRL4g_Jfg@mail.gmail.com>
 <7fb19e0a-118d-46a1-8d1b-ab71c545d7ed@huawei.com> <0806d149-905c-49b2-930f-5d6d0f8890c9@huawei.com>
In-Reply-To: <0806d149-905c-49b2-930f-5d6d0f8890c9@huawei.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 8 Aug 2024 07:41:25 -0400
Message-ID: <CAEjxPJ5S9sz4PaRMVLyP6PWdLCG_bBxj7nw53EhU5+L1TM7kFg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] selinux: use vma_is_initial_stack() and vma_is_initial_heap()
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Paul Moore <paul@paul-moore.com>, Marc Reisner <reisner.marc@gmail.com>, 
	akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org, 
	omosnace@redhat.com, peterz@infradead.org, selinux@vger.kernel.org, 
	Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 7:09=E2=80=AFAM Kefeng Wang <wangkefeng.wang@huawei.=
com> wrote:
>
>
>
> On 2024/8/8 14:43, Kefeng Wang wrote:
> >
> > On 2024/8/8 9:10, Paul Moore wrote:
> >> On Wed, Aug 7, 2024 at 5:26=E2=80=AFPM Marc Reisner <reisner.marc@gmai=
l.com>
> >> wrote:
> >>>
> >>> It looks like this issue is still not fixed. There has been some
> >>> investigation on going in this Bugzilla for Fedora:
> >>>
> >>> https://bugzilla.redhat.com/show_bug.cgi?id=3D2254434
> >>
> >> FWIW, I recently learned there was also a report in the kernel
> >> bugzilla about the same issue:
> >>
> >> https://bugzilla.kernel.org/show_bug.cgi?id=3D218258
> >>
> >>> The behavior we are seeing is that when a process has no heap and
> >>> mmap(2) is called with MAP_PRIVATE | MAP_ANONYMOUS, it allocates memo=
ry
> >>> on the heap.
> >>>
> >>> If the address space returned by mmap(2) is later on made executable
> >>> with mprotect(2), that triggers an execheap avc.
> >>
> >> ...
> >>
> >>> This has been reproduced on kernels >=3D 6.6.
> >
> > I try the reproducer, but fails to reproduce on my 6.6
>
> After enable selinux then trigger the issue.
>
> >>>
> >>> In reviewing the code, my best guess is that this is caused by the
> >>> scenario where brk =3D=3D start_brk not being handled, though I am no=
t
> >
> > Is there vma_start,end and start_brk,brk infos, adding some debug print=
.
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 81fbfa5b80d4..b66c381c558e 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -3848,6 +3848,9 @@ static int selinux_file_mprotect(struct
> > vm_area_struct *vma,
> >                  if (vma_is_initial_heap(vma)) {
> >                          rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS=
,
> >                                            PROCESS__EXECHEAP, NULL);
> > +                       if (rc)
> > +                               pr_err("DEBUG: vma_start,end=3D%lx,%lx,
> > start_brk,brk=3D%lx,%lx\n",
> > +                                       vma->vm_start, vma->vm_end,
> > vma->vm_mm->start_brk, vma->vm_mm->brk);
> >                  } else if (!vma->vm_file && (vma_is_initial_stack(vma)=
 ||
> >                              vma_is_stack_for_current(vma))) {
> >                          rc =3D avc_has_perm(sid, sid, SECCLASS_PROCESS=
,
>
>
> [ 3520.913952] DEBUG: pid=3D769674,comm=3Dtest-vma,
> vma:start,end=3D1e9c000,21e9c000, start_brk,brk=3D2310000,2310000
>
>
> vma_start <  start_brk =3D brk  < vma_end
>
> >
> >>> expert enough in kernel code to know. If the start address allocated
> >>> by mmap is before the starting program break, and the end address is
> >>> after the starting program break, then the avc will trigger. However,
> >>> I don't know how mmap deals with determining an address and if it tak=
es
> >>> into account the program break, or if calling brk(2) later on will ju=
st
> >>> pick a new location.
> >>
> >> I'm not a mm expert, but thankfully we have some on the To/CC line so
> >> I'm hopeful they will be able to take a look and provide some insight.
> >
> > +Cc mmap maintainers too.
> >
> >>
> >> To bring the relevant code into this email, prior to using the
> >> vma_is_initial_heap() helper the SELinux execheap logic looked like
> >> this:
> >>
> >>    /* WORKING */
> >>    if (vma->vm_start >=3D vma->vm_mm->start_brk &&
> >>        vma->vm_end <=3D vma->vm_mm->brk)
> >>      /* execheap denial */
> >>
>
> vma range must be within heap.
>
> >> ... while the current vma_is_initial_heap() helper has logic that
> >> looks like this:
> >>
> >>    /* BUGGY */
> >>    if (vma->vm_start < vma->vm_mm->brk &&
> >>        vma->vm_end > vma->vm_mm->start_brk)
> >>      /* execheap denial */
>
> vma range intersection with brk range will be rejected, and
> there's a cross in above case, so execheap denial, I not sure it
> should be allowed or not, hope maintainers give some comments here.

It's a kernel regression so we need to revert the change to SELinux at
least - can't start denying permission without a new/updated policy
(e.g. making the change in the check conditional on a new policy
capability).
