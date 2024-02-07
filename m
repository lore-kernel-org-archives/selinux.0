Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFE313A243
	for <selinux@vger.kernel.org>; Wed,  7 Feb 2024 21:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340965; cv=none; b=MA3oMkXIgXyvN7pXDxk0gzrKuVofsCIDNQTBQpjWapE9NTDvhQwryPHcVHsTPtHvll0pKDHlEgmQKk4F4N8TirKNjyyomC6nMvjypQeriP/Z8qMs6M8Ec0S31b6/cSDhfRyaCZuQ/PPBNhgcICYdSnCdfJKgj44r1cwK2SxY1PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340965; c=relaxed/simple;
	bh=ZyZ3Ebl4a/ZrZxa6zZ+a5DGa9m6vvBXjcdd+ZrG51ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hcOqmt/gukcqzi7gfdcfkddj+q3iomU7dxCW6vJwur4Kr3dY1DGNZOghdO7WoKEv534ZC3jMJbcTaPQU7pDWr/j9PnStbuHc5xd5dRly5WueaVjdQTf8T0IC7PnWsch+dR6JGCEOE3xPEDxewATfwTrMVefCtW+TRNlEVxEglFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4j/lklQe; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4j/lklQe"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-560530f4e21so3551a12.1
        for <selinux@vger.kernel.org>; Wed, 07 Feb 2024 13:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707340961; x=1707945761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOqzPRykbp6YnfN+MvcqOmBBzcnuz5hTg+hCiKSQFW4=;
        b=4j/lklQearcxeBiYUi2PgC78h+J+EosM3sNVhSiKbKIkmRR2bIvmtn2WSOGSm2bn/n
         sbw3/voahtz0suO8kDG+s/icIJ6CuOn/J/7FurACtZiGPe3JRzwtyZUTTzTl0kgjtNol
         F5PPlWzxpp/j0gj+Dn8G5dIxZOTXDRi06jrbOq1r2MR1/a69uFTuBl68lav4sx6M9rHn
         32H6zlxWBLhynUPnR2nYoRbnE8KKzSp1+dFyXbl79DBSf+lBdP8YUyl3J3c9uXG8JGjg
         FAf4IE9BcLSk5nZvr8UN72p/KOOV5C8JEotzAab99GrbHH5uCGaJTmFIuyifsQfvgvE4
         I5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707340961; x=1707945761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOqzPRykbp6YnfN+MvcqOmBBzcnuz5hTg+hCiKSQFW4=;
        b=aJaEW54HpAcykDJNFaHCA7jlQza8ULzITN/1SxhEHcxlnZQcG0ex+ZcWKsFOQpLkKt
         3QRNtKX6AhYuAlWPEmm5HxMk+THcUtce0cOtvD0LlpAhjwI9I375vP7P3X2h9+gYYqPu
         RRrmKgMn8y5DwcdQKETYeKXpElygG1Vb+TSYIpRvOdIAJ3BoDKF4x04FkcAzbLAmW3WW
         +0MNaE1Ag44UdQUe5zfnloTY6UhGLnRDGWJqZf8yJzOyLljU/6jxzAYx+kHvMMSI/gp+
         7jRV6TlaS6lD1Ry+cBIUO3MJRYo9ny/wDWOy/1Gie3QsSj85kVvnEkMCz9YCy2PffV/y
         9YoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlmwURbXF0LZy03JjfLfGPLVKywpCFUw45VvqdAimn8VnghNkAIbWGbsrIOgZTvRxUZygQ5qab/hy8MYj4zfP54LQOVBRaMA==
X-Gm-Message-State: AOJu0YxrLq/czmBvPv5LAiGa4g4mEbMJyRVUNoNgA3Byi/01lcp9C0yp
	EgtaovrbpUk3TXOrbLvTbmmIRh02aPhSipaP/2Vtb5dZjM7FaYXK8IzsySKLqK3e5p2d5WMI0eh
	HBVmK0p+NGWCLXSomuiSLt9u98i4r9gUCeYf9
X-Google-Smtp-Source: AGHT+IFZLDOLewby3fPcJ2/xTe7Q7BYva9t0F0dbjHitWJFDydBe0Rgh+gs9IznsVWYrixoO8DjRgm80BJu8J4yc2Tw=
X-Received: by 2002:a50:d64e:0:b0:560:f37e:2d5d with SMTP id
 c14-20020a50d64e000000b00560f37e2d5dmr101860edj.5.1707340961021; Wed, 07 Feb
 2024 13:22:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206010919.1109005-1-lokeshgidra@google.com>
 <20240206010919.1109005-4-lokeshgidra@google.com> <CAG48ez0AdTijvuh0xueg_spwNE9tVcPuvqT9WpvmtiNNudQFMw@mail.gmail.com>
 <CA+EESO4mVVFjx1bSpWwwhsY9V_LTzerKyivvCO=hdPbY1JFsPQ@mail.gmail.com>
In-Reply-To: <CA+EESO4mVVFjx1bSpWwwhsY9V_LTzerKyivvCO=hdPbY1JFsPQ@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 7 Feb 2024 22:22:03 +0100
Message-ID: <CAG48ez1ttahpqz1AT+FQ8fHjOQnh4cvfpo_AeyfBoWOUE=zyrQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] userfaultfd: use per-vma locks in userfaultfd operations
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	surenb@google.com, kernel-team@android.com, aarcange@redhat.com, 
	peterx@redhat.com, david@redhat.com, axelrasmussen@google.com, 
	bgeffon@google.com, willy@infradead.org, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org, 
	Liam.Howlett@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 7:50=E2=80=AFPM Lokesh Gidra <lokeshgidra@google.com=
> wrote:
> On Tue, Feb 6, 2024 at 10:28=E2=80=AFAM Jann Horn <jannh@google.com> wrot=
e:
> > On Tue, Feb 6, 2024 at 2:09=E2=80=AFAM Lokesh Gidra <lokeshgidra@google=
.com> wrote:
> > > All userfaultfd operations, except write-protect, opportunistically u=
se
> > > per-vma locks to lock vmas. On failure, attempt again inside mmap_loc=
k
> > > critical section.
> > >
> > > Write-protect operation requires mmap_lock as it iterates over multip=
le
> > > vmas.
> > >
> > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > [...]
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index b05fd28dbce1..393ab3b0d6f3 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > [...]
> > > +/*
> > > + * lock_vma() - Lookup and lock VMA corresponding to @address.
> > > + * @prepare_anon: If true, then prepare the VMA (if anonymous) with =
anon_vma.
> > > + *
> > > + * Should be called without holding mmap_lock. VMA should be unlocke=
d after use
> > > + * with unlock_vma().
> > > + *
> > > + * Return: A locked VMA containing @address, NULL of no VMA is found=
, or
> > > + * -ENOMEM if anon_vma couldn't be allocated.
> > > + */
> > > +struct vm_area_struct *lock_vma(struct mm_struct *mm,
> > > +                               unsigned long address,
> > > +                               bool prepare_anon)
> > > +{
> > > +       struct vm_area_struct *vma;
> > > +
> > > +       vma =3D lock_vma_under_rcu(mm, address);
> > > +
> > > +       if (vma)
> > > +               return vma;
> > > +
> > > +       mmap_read_lock(mm);
> > > +       vma =3D vma_lookup(mm, address);
> > > +       if (vma) {
> > > +               if (prepare_anon && vma_is_anonymous(vma) &&
> > > +                   anon_vma_prepare(vma))
> > > +                       vma =3D ERR_PTR(-ENOMEM);
> > > +               else
> > > +                       vma_acquire_read_lock(vma);
> >
> > This new code only calls anon_vma_prepare() for VMAs where
> > vma_is_anonymous() is true (meaning they are private anonymous).
> >
> > [...]
> > > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > > index 74aad0831e40..64e22e467e4f 100644
> > > --- a/mm/userfaultfd.c
> > > +++ b/mm/userfaultfd.c
> > > @@ -19,20 +19,25 @@
> > >  #include <asm/tlb.h>
> > >  #include "internal.h"
> > >
> > > -static __always_inline
> > > -struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
> > > -                                   unsigned long dst_start,
> > > -                                   unsigned long len)
> > > +/* Search for VMA and make sure it is valid. */
> > > +static struct vm_area_struct *find_and_lock_dst_vma(struct mm_struct=
 *dst_mm,
> > > +                                                   unsigned long dst=
_start,
> > > +                                                   unsigned long len=
)
> > >  {
> > > -       /*
> > > -        * Make sure that the dst range is both valid and fully withi=
n a
> > > -        * single existing vma.
> > > -        */
> > >         struct vm_area_struct *dst_vma;
> > >
> > > -       dst_vma =3D find_vma(dst_mm, dst_start);
> > > -       if (!range_in_vma(dst_vma, dst_start, dst_start + len))
> > > -               return NULL;
> > > +       /* Ensure anon_vma is assigned for anonymous vma */
> > > +       dst_vma =3D lock_vma(dst_mm, dst_start, true);
> >
> > lock_vma() is now used by find_and_lock_dst_vma(), which is used by
> > mfill_atomic().
> >
> > > +       if (!dst_vma)
> > > +               return ERR_PTR(-ENOENT);
> > > +
> > > +       if (PTR_ERR(dst_vma) =3D=3D -ENOMEM)
> > > +               return dst_vma;
> > > +
> > > +       /* Make sure that the dst range is fully within dst_vma. */
> > > +       if (dst_start + len > dst_vma->vm_end)
> > > +               goto out_unlock;
> > >
> > >         /*
> > >          * Check the vma is registered in uffd, this is required to
> > [...]
> > > @@ -597,7 +599,15 @@ static __always_inline ssize_t mfill_atomic(stru=
ct userfaultfd_ctx *ctx,
> > >         copied =3D 0;
> > >         folio =3D NULL;
> > >  retry:
> > > -       mmap_read_lock(dst_mm);
> > > +       /*
> > > +        * Make sure the vma is not shared, that the dst range is
> > > +        * both valid and fully within a single existing vma.
> > > +        */
> > > +       dst_vma =3D find_and_lock_dst_vma(dst_mm, dst_start, len);
> > > +       if (IS_ERR(dst_vma)) {
> > > +               err =3D PTR_ERR(dst_vma);
> > > +               goto out;
> > > +       }
> > >
> > >         /*
> > >          * If memory mappings are changing because of non-cooperative
> > > @@ -609,15 +619,6 @@ static __always_inline ssize_t mfill_atomic(stru=
ct userfaultfd_ctx *ctx,
> > >         if (atomic_read(&ctx->mmap_changing))
> > >                 goto out_unlock;
> > >
> > > -       /*
> > > -        * Make sure the vma is not shared, that the dst range is
> > > -        * both valid and fully within a single existing vma.
> > > -        */
> > > -       err =3D -ENOENT;
> > > -       dst_vma =3D find_dst_vma(dst_mm, dst_start, len);
> > > -       if (!dst_vma)
> > > -               goto out_unlock;
> > > -
> > >         err =3D -EINVAL;
> > >         /*
> > >          * shmem_zero_setup is invoked in mmap for MAP_ANONYMOUS|MAP_=
SHARED but
> > > @@ -647,16 +648,6 @@ static __always_inline ssize_t mfill_atomic(stru=
ct userfaultfd_ctx *ctx,
> > >             uffd_flags_mode_is(flags, MFILL_ATOMIC_CONTINUE))
> > >                 goto out_unlock;
> > >
> > > -       /*
> > > -        * Ensure the dst_vma has a anon_vma or this page
> > > -        * would get a NULL anon_vma when moved in the
> > > -        * dst_vma.
> > > -        */
> > > -       err =3D -ENOMEM;
> > > -       if (!(dst_vma->vm_flags & VM_SHARED) &&
> > > -           unlikely(anon_vma_prepare(dst_vma)))
> > > -               goto out_unlock;
> >
> > But the check mfill_atomic() used to do was different, it checked for V=
M_SHARED.
>
> Thanks so much for catching this.
> >
> > Each VMA has one of these three types:
> >
> > 1. shared (marked by VM_SHARED; does not have an anon_vma)
> > 2. private file-backed (needs to have anon_vma when storing PTEs)
> > 3. private anonymous (what vma_is_anonymous() detects; needs to have
> > anon_vma when storing PTEs)
>
> As in the case of mfill_atomic(), it seems to me that checking for
> VM_SHARED flag will cover both (2) and (3) right?

Yes, I think that should work.
