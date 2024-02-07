Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DABD1272A9
	for <selinux@vger.kernel.org>; Wed,  7 Feb 2024 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331732; cv=none; b=KifAU26KwM+gd9LWSV9D5CpnxFEE+sy4gqg4gEsifnPkulUknwQhoL3pI1ONdxfENE8+NxYO/P6bIkuG9vtA1HuCQWjsbqVwGNoIG34PFqyL3WvlgMosAvblsQuhAvvWeD19/0uizJ4Hbi3WlLPFFTW0VZT5bSksb18UrLr9lk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331732; c=relaxed/simple;
	bh=wvb1mKGslbahYKMQcj6UXLGPIub78UIv66qubREGkwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=dVuI9OHzUcleqD+z1fgYTIep59GtxBmDi7xhiiMnyIpbGFoo2r/ZTOqSzKBy5x5gabwbIw0ciQUoKSNHkAcGShe/A5rlXic2jfE3sDMqxXhOafE812rH+PigEb2xpHoOWQBwkTyTBxO1myHo7BDl0luwdI1btfYHNBJA4IlYF9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bFF8LrBY; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bFF8LrBY"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40fe282b8adso7961965e9.2
        for <selinux@vger.kernel.org>; Wed, 07 Feb 2024 10:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707331728; x=1707936528; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEbS8x6FOBuKd7dbPbw/YK28mMkf7/ZaGGkdJ/zSoBI=;
        b=bFF8LrBYxHJuaDERczj1V68Zkjs3c+wW6C94wAgima/zYNkRhi0IPGjcKfP4byekbg
         H4UBrNyoJWdiPE8FboJPgGactjQhDuQ5leAD/KALW3WU4znYaQnex4AkUUnEQVjkkDEq
         X8Rj31UCR2gC0ArSIPqBhqWSu5p+5Uy2FoWl0dy3enPq0CVSMtPdySjuLYreXb4IuOMG
         RL1l4fdz1Uutsl5P4lnxmERkiJIMygVtWrozTOahNRjWov5esTAJGBYDim+c9L+QFNGK
         N5HoGNTrZuD2NHLawAQQuViRwj2P8MmkJ5lVmnW6mgjIVRPt51QzNJIeU/kp3qN51SFz
         Yleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707331728; x=1707936528;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YEbS8x6FOBuKd7dbPbw/YK28mMkf7/ZaGGkdJ/zSoBI=;
        b=oCTLFkgGaQLl3VshZlZia1+svFGBDRC6b12nhV7Ykf7IMdQMVfVnFYNoDJxe55J/Wi
         PsVRw8zR0Kbg/QzTyjkyO8rr4Hc5DjP88fb4EX1zjQUjPtayDDU7sWFEwfKCQVi2NvsX
         +mjmDZi1jMK5benJCaKtnfNH6PTGvYremJFWtOwT5VsxSGc/u2JxdAeH5sfftU2MQOWf
         1i6SCoQS57L5Sbzie5P0jtgHeKiQNT6Jl5NIIq2jZDgFTlWHOT7iQiV/hmNgUFwGCcuz
         zvcsnTCYelZBjOoBHj5I2PdiJc0Uxnfwn34OfOHO85Z3JnRjXQKnzSW4kaHIKHHREwHF
         IbCg==
X-Forwarded-Encrypted: i=1; AJvYcCWTx2TTOiFXhfqpvIDUjmwmT1xiZY7+MhJPpM1SD9RbgkRtWUTXHgy6iSQUP7TLU14AOwz3toS07dqeoZkPI4L+8n/XMS+OLg==
X-Gm-Message-State: AOJu0Yy24pfg00y5AIes3FByuTHnspqPNn0mAW0kUca2UZjOnfN5YW6F
	tFh8C2Ts1O8UwcDUIVHZgZG3306NmJPOWctklOtnDS/vGVOnxHQLo6J2qZdSaDG8PZwNXFO7pVg
	YIwWQcI7d822qJsjZK1eKk0+NsNEwOMNZIb1v
X-Google-Smtp-Source: AGHT+IGz9sOVYCRyXKULBfQNcdwNAFxBi6ehHuFrlTPaZLS1FHBgo2NLZZk6fRMhF6NzcnxzFzZM+y4zxCp+jZchzJ0=
X-Received: by 2002:a5d:47a2:0:b0:33b:3aa6:a28e with SMTP id
 2-20020a5d47a2000000b0033b3aa6a28emr4478697wrb.55.1707331728007; Wed, 07 Feb
 2024 10:48:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206010919.1109005-1-lokeshgidra@google.com>
 <20240206010919.1109005-4-lokeshgidra@google.com> <20240206170501.3caqeylaogpaemuc@revolver>
In-Reply-To: <20240206170501.3caqeylaogpaemuc@revolver>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Wed, 7 Feb 2024 10:48:35 -0800
Message-ID: <CA+EESO7OExRs8Tz2SRD5EZoVf1DocoTZyG4c0Y89xDzZAVViGw@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] userfaultfd: use per-vma locks in userfaultfd operations
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lokesh Gidra <lokeshgidra@google.com>, 
	akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 9:05=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracle=
.com> wrote:
>
> * Lokesh Gidra <lokeshgidra@google.com> [240205 20:10]:
> > All userfaultfd operations, except write-protect, opportunistically use
> > per-vma locks to lock vmas. On failure, attempt again inside mmap_lock
> > critical section.
> >
> > Write-protect operation requires mmap_lock as it iterates over multiple
> > vmas.
> >
> > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > ---
> >  fs/userfaultfd.c              |  13 +-
> >  include/linux/mm.h            |  16 +++
> >  include/linux/userfaultfd_k.h |   5 +-
> >  mm/memory.c                   |  48 +++++++
> >  mm/userfaultfd.c              | 242 +++++++++++++++++++++-------------
> >  5 files changed, 222 insertions(+), 102 deletions(-)
> >
> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index c00a021bcce4..60dcfafdc11a 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -2005,17 +2005,8 @@ static int userfaultfd_move(struct userfaultfd_c=
tx *ctx,
> >               return -EINVAL;
> >
> >       if (mmget_not_zero(mm)) {
> > -             mmap_read_lock(mm);
> > -
> > -             /* Re-check after taking map_changing_lock */
> > -             down_read(&ctx->map_changing_lock);
> > -             if (likely(!atomic_read(&ctx->mmap_changing)))
> > -                     ret =3D move_pages(ctx, mm, uffdio_move.dst, uffd=
io_move.src,
> > -                                      uffdio_move.len, uffdio_move.mod=
e);
> > -             else
> > -                     ret =3D -EAGAIN;
> > -             up_read(&ctx->map_changing_lock);
> > -             mmap_read_unlock(mm);
> > +             ret =3D move_pages(ctx, uffdio_move.dst, uffdio_move.src,
> > +                              uffdio_move.len, uffdio_move.mode);
> >               mmput(mm);
> >       } else {
> >               return -ESRCH;
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 0d1f98ab0c72..e69dfe2edcce 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -753,6 +753,11 @@ static inline void release_fault_lock(struct vm_fa=
ult *vmf)
> >               mmap_read_unlock(vmf->vma->vm_mm);
> >  }
> >
> > +static inline void unlock_vma(struct mm_struct *mm, struct vm_area_str=
uct *vma)
> > +{
> > +     vma_end_read(vma);
> > +}
> > +
> >  static inline void assert_fault_locked(struct vm_fault *vmf)
> >  {
> >       if (vmf->flags & FAULT_FLAG_VMA_LOCK)
> > @@ -774,6 +779,9 @@ static inline void vma_assert_write_locked(struct v=
m_area_struct *vma)
> >               { mmap_assert_write_locked(vma->vm_mm); }
> >  static inline void vma_mark_detached(struct vm_area_struct *vma,
> >                                    bool detached) {}
> > +static inline void vma_acquire_read_lock(struct vm_area_struct *vma) {
> > +     mmap_assert_locked(vma->vm_mm);
> > +}
> >
> >  static inline struct vm_area_struct *lock_vma_under_rcu(struct mm_stru=
ct *mm,
> >               unsigned long address)
> > @@ -786,6 +794,11 @@ static inline void release_fault_lock(struct vm_fa=
ult *vmf)
> >       mmap_read_unlock(vmf->vma->vm_mm);
> >  }
> >
> > +static inline void unlock_vma(struct mm_struct *mm, struct vm_area_str=
uct *vma)
> > +{
> > +     mmap_read_unlock(mm);
> > +}
> > +
>
> Instead of passing two variables and only using one based on
> configuration of kernel build, why not use vma->vm_mm to
> mmap_read_unlock() and just pass the vma?
>
> It is odd to call unlock_vma() which maps to mmap_read_unlock().  Could
> we have this abstraction depend on CONFIG_PER_VMA_LOCK in uffd so that
> reading the code remains clear?  You seem to have pretty much two
> versions of each function already.  If you do that, then we can leave
> unlock_vma() undefined if !CONFIG_PER_VMA_LOCK.
>
> >  static inline void assert_fault_locked(struct vm_fault *vmf)
> >  {
> >       mmap_assert_locked(vmf->vma->vm_mm);
> > @@ -794,6 +807,9 @@ static inline void assert_fault_locked(struct vm_fa=
ult *vmf)
> >  #endif /* CONFIG_PER_VMA_LOCK */
> >
> >  extern const struct vm_operations_struct vma_dummy_vm_ops;
> > +extern struct vm_area_struct *lock_vma(struct mm_struct *mm,
> > +                                    unsigned long address,
> > +                                    bool prepare_anon);
> >
> >  /*
> >   * WARNING: vma_init does not initialize vma->vm_lock.
> > diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_=
k.h
> > index 3210c3552976..05d59f74fc88 100644
> > --- a/include/linux/userfaultfd_k.h
> > +++ b/include/linux/userfaultfd_k.h
> > @@ -138,9 +138,8 @@ extern long uffd_wp_range(struct vm_area_struct *vm=
a,
> >  /* move_pages */
> >  void double_pt_lock(spinlock_t *ptl1, spinlock_t *ptl2);
> >  void double_pt_unlock(spinlock_t *ptl1, spinlock_t *ptl2);
> > -ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
> > -                unsigned long dst_start, unsigned long src_start,
> > -                unsigned long len, __u64 flags);
> > +ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_star=
t,
> > +                unsigned long src_start, unsigned long len, __u64 flag=
s);
> >  int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *s=
rc_pmd, pmd_t dst_pmdval,
> >                       struct vm_area_struct *dst_vma,
> >                       struct vm_area_struct *src_vma,
> > diff --git a/mm/memory.c b/mm/memory.c
> > index b05fd28dbce1..393ab3b0d6f3 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -5760,8 +5760,56 @@ struct vm_area_struct *lock_vma_under_rcu(struct=
 mm_struct *mm,
> >       count_vm_vma_lock_event(VMA_LOCK_ABORT);
> >       return NULL;
> >  }
> > +
> > +static void vma_acquire_read_lock(struct vm_area_struct *vma)
> > +{
> > +     /*
> > +      * We cannot use vma_start_read() as it may fail due to false loc=
ked
> > +      * (see comment in vma_start_read()). We can avoid that by direct=
ly
> > +      * locking vm_lock under mmap_lock, which guarantees that nobody =
could
> > +      * have locked the vma for write (vma_start_write()).
> > +      */
> > +     mmap_assert_locked(vma->vm_mm);
> > +     down_read(&vma->vm_lock->lock);
> > +}
> >  #endif /* CONFIG_PER_VMA_LOCK */
> >
> > +/*
> > + * lock_vma() - Lookup and lock VMA corresponding to @address.
>
> Missing arguments in the comment
>
> > + * @prepare_anon: If true, then prepare the VMA (if anonymous) with an=
on_vma.
> > + *
> > + * Should be called without holding mmap_lock. VMA should be unlocked =
after use
> > + * with unlock_vma().
> > + *
> > + * Return: A locked VMA containing @address, NULL of no VMA is found, =
or
> > + * -ENOMEM if anon_vma couldn't be allocated.
> > + */
> > +struct vm_area_struct *lock_vma(struct mm_struct *mm,
> > +                             unsigned long address,
> > +                             bool prepare_anon)
> > +{
> > +     struct vm_area_struct *vma;
> > +
> > +     vma =3D lock_vma_under_rcu(mm, address);
> > +
>
> Nit: extra new line
>
> > +     if (vma)
> > +             return vma;
> > +
> > +     mmap_read_lock(mm);
> > +     vma =3D vma_lookup(mm, address);
> > +     if (vma) {
> > +             if (prepare_anon && vma_is_anonymous(vma) &&
> > +                 anon_vma_prepare(vma))
> > +                     vma =3D ERR_PTR(-ENOMEM);
> > +             else
> > +                     vma_acquire_read_lock(vma);
> > +     }
> > +
> > +     if (IS_ENABLED(CONFIG_PER_VMA_LOCK) || !vma || PTR_ERR(vma) =3D=
=3D -ENOMEM)
> > +             mmap_read_unlock(mm);
> > +     return vma;
> > +}
> > +
>
> It is also very odd that lock_vma() may, in fact, be locking the mm.  It
> seems like there is a layer of abstraction missing here, where your code
> would either lock the vma or lock the mm - like you had before, but
> without the confusing semantics of unlocking with a flag.  That is, we
> know what to do to unlock based on CONFIG_PER_VMA_LOCK, but it isn't
> always used.
>
> Maybe my comments were not clear on what I was thinking on the locking
> plan.  I was thinking that, in the CONFIG_PER_VMA_LOCK case, you could
> have a lock_vma() which does the per-vma locking which you can use in
> your code.  You could call lock_vma() in some uffd helper function that
> would do what is required (limit checking, etc) and return a locked vma.
>
> The counterpart of that would be another helper function that would do
> what was required under the mmap_read lock (limit check, etc).  The
> unlocking would be entirely config dependant as you have today.
>
> Just write the few functions you have twice: once for per-vma lock
> support, once without it.  Since we now can ensure the per-vma lock is
> taken in the per-vma lock path (or it failed), then you don't need to
> mmap_locked boolean you had in the previous version.  You solved the
> unlock issue already, but it should be abstracted so uffd calls the
> underlying unlock vs vma_unlock() doing an mmap_read_unlock() - because
> that's very confusing to see.
>
> I'd drop the vma from the function names that lock the mm or the vma as
> well.
>
> Thanks,
> Liam

I got it now. I'll make the changes in the next version.

Would it be ok to make lock_vma()/unlock_vma() (in case of
CONFIG_PER_VMA_LOCK) also be defined in mm/userfaultfd.c? The reason I
say this is because first there are no other users of these functions.
And also due to what Jann pointed out about anon_vma.
lock_vma_under_rcu() (rightly) only checks for private+anonymous case
and not private+file-backed case. So lock_vma() implementation is
getting very userfaultfd specific IMO.
