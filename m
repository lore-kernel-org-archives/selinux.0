Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655091CD33
	for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 19:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707851911; cv=none; b=gTuQS9EaoVQGPmwg3ywsAf52/enoO3qw7EvnApwKQH7t5ZrLSZd+j2zILx6bAGn+ZvGrUC4+i9FOhCl91zjH8I3X5VTbeJWwuekovPWPzfTVOve/UL6m5FVNi7wKXzFMDCYPcNxvZ2k6VJKvThSaNfgMfM881LEULKDaI320/wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707851911; c=relaxed/simple;
	bh=a5mMRWzTFO8UllGnXCIR+TWz9Xn1DAwcV6AGubTqrF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSbEZP2/SrF/8JT+58ke0JC7ogRQidNLQENh66OXjB9kZrmpaO4qJ22cJ2YGWOA6fPlMx+kTy5GWNfAg+qaeLq2v+uERgjxYTP1XzJFX46+BEjZoK3JtFuMJ8OeAvbxi9cqAk8/cSpM3y/4oX7h9xzDhya8UI4D6iCbxnaHBTEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hZEvGTPT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hZEvGTPT"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-411a6ceada8so13916185e9.3
        for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 11:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707851907; x=1708456707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCX6UoytF2NcZYARqpkHqcF31HoM7Upx7WmM/K8jfRI=;
        b=hZEvGTPTsxHkB4dexv/sIqnOe39nr2IK+1KSjy+5wlC6NXB5D4H/iQBMPMjFm6R6ry
         D4whKsYpLIse8I87XO2rHNZbP3htNbrLCBDgo/SblGeJVFMX6vg+3CKjkfHW++yI+b0M
         evkWPApR2niJA5qnsNlQ5CpmoaOUBd5wUsRZUlC+I8y3pt0pGz/zrfuck2MgqLghf4rn
         ojtiyUer4WDDvRFRnPyJG53g5FT4uqXHN3yfDUZP0nwUOY0GVgWKrefJ3obLVNWmN8Id
         8/kmfHi9NAVoe65+BRuhEDyV0O/II9lTfMOA4gXyhhMJqIEE1QT2M028LuCzj1vQlA9+
         ek2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707851907; x=1708456707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yCX6UoytF2NcZYARqpkHqcF31HoM7Upx7WmM/K8jfRI=;
        b=pGLaHP5w7Z1riUhRwK+uAOgBLV++tZcJAmJMYLsNfbBbfd7vOKCY9fUoNOst6DxeXS
         lAiZA6yaoZn1hMlOGsWjYUGAkcrMY/KwjlpW1wL8BfPym4w4MfcB2PR3Xc5+1SbbzJjJ
         Z5ImVGdbwUP9zo2m+R23ipqxS0OVOU6nNWXijCrbAAhv6WurC7SOMyvvFKdb1XgFz39R
         7wbKN2Sx3E6KGOOD0JiYyeoP5NVw1VckUYHFiYjnC5isdGeNiDIvnoyJ5u8/lVX+1CeD
         Lu+DaATzT7F7NZfrFpaiXlIKUs2rRH7Av8kgcD9tPCVxLLmQtVjn+8hJ7Z3aJdlP+w4Q
         LkMA==
X-Forwarded-Encrypted: i=1; AJvYcCVe6KIy62+WBhqW+6QJx36Ncy3Ndjcs7EYK0K9dlkMmhg35M1Eux2KlMXI28abcXnouDAJDnxsuIRO6s1aNcRqZliFCgTVNZw==
X-Gm-Message-State: AOJu0Yysu/Gg5crryGNJbS90M+mIJNxgu8iH13TqsKUb6+TnkI3TXfR9
	0ceaCc7aVvCkGNbj/KG2/ywnWbXzrhEZ3owXfZad0CROtE0kuPfb7O0wrSapu6uZRR4/6UlWVQu
	jLC2NMT17IMlucNYca25YCv2QBbEpuIKpnnNj
X-Google-Smtp-Source: AGHT+IEMHwkro+xsqN6z9qNfjrhRyFhmvQhXDoENBJPQ6ipKebPJrHzy8YnGUaSmsX5qm/wdi6FYHsoNKdwoTN72x5c=
X-Received: by 2002:a5d:54cc:0:b0:33b:45b6:b589 with SMTP id
 x12-20020a5d54cc000000b0033b45b6b589mr160513wrv.66.1707851907393; Tue, 13 Feb
 2024 11:18:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213001920.3551772-1-lokeshgidra@google.com>
 <20240213001920.3551772-4-lokeshgidra@google.com> <20240213033307.zbhrpjigco7vl56z@revolver>
 <CA+EESO5TNubw4vi08P6BO-4XKTLNVeNfjM92ieZJTd_oJt9Ygw@mail.gmail.com>
 <20240213170609.s3queephdyxzrz7j@revolver> <CA+EESO5URPpJj35-jQy+Lrp1EtKms8r1ri2ZY3ZOpsSJU+CScw@mail.gmail.com>
 <CAJuCfpFXWJovv6G4ou2nK2W1D2-JGb5Hw8m77-pOq4Rh24-q9A@mail.gmail.com>
 <20240213184905.tp4i2ifbglfzlwi6@revolver> <CAJuCfpG+8uypn3Mw0GNBj0TUM51gaSdAnGZB-RE4HdJs7dKb0A@mail.gmail.com>
In-Reply-To: <CAJuCfpG+8uypn3Mw0GNBj0TUM51gaSdAnGZB-RE4HdJs7dKb0A@mail.gmail.com>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Tue, 13 Feb 2024 11:18:15 -0800
Message-ID: <CA+EESO6M5VudYK-CqT2snvs25dnrdTLzzKAjoSe7368X-PcFew@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] userfaultfd: use per-vma locks in userfaultfd operations
To: Suren Baghdasaryan <surenb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 10:57=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> On Tue, Feb 13, 2024 at 10:49=E2=80=AFAM Liam R. Howlett
> <Liam.Howlett@oracle.com> wrote:
> >
> > * Suren Baghdasaryan <surenb@google.com> [240213 13:25]:
> > > On Tue, Feb 13, 2024 at 10:14=E2=80=AFAM Lokesh Gidra <lokeshgidra@go=
ogle.com> wrote:
> > > >
> > > > On Tue, Feb 13, 2024 at 9:06=E2=80=AFAM Liam R. Howlett <Liam.Howle=
tt@oracle.com> wrote:
> > > > >
> > > > > * Lokesh Gidra <lokeshgidra@google.com> [240213 06:25]:
> > > > > > On Mon, Feb 12, 2024 at 7:33=E2=80=AFPM Liam R. Howlett <Liam.H=
owlett@oracle.com> wrote:
> > > > > > >
> > > > > > > * Lokesh Gidra <lokeshgidra@google.com> [240212 19:19]:
> > > > > > > > All userfaultfd operations, except write-protect, opportuni=
stically use
> > > > > > > > per-vma locks to lock vmas. On failure, attempt again insid=
e mmap_lock
> > > > > > > > critical section.
> > > > > > > >
> > > > > > > > Write-protect operation requires mmap_lock as it iterates o=
ver multiple
> > > > > > > > vmas.
> > > > > > > >
> > > > > > > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > > > > > > ---
> > > > > > > >  fs/userfaultfd.c              |  13 +-
> > > > > > > >  include/linux/userfaultfd_k.h |   5 +-
> > > > > > > >  mm/userfaultfd.c              | 392 ++++++++++++++++++++++=
++++--------
> > > > > > > >  3 files changed, 312 insertions(+), 98 deletions(-)
> > > > > > > >
> > > > > > > ...
> > > > >
> > > > > I just remembered an issue with the mmap tree that exists today t=
hat you
> > > > > needs to be accounted for in this change.
> > > > >
> > > > > If you hit a NULL VMA, you need to fall back to the mmap_lock() s=
cenario
> > > > > today.
> > > >
> > > > Unless I'm missing something, isn't that already handled in the pat=
ch?
> > > > We get the VMA outside mmap_lock critical section only via
> > > > lock_vma_under_rcu() (in lock_vma() and find_and_lock_vmas()) and i=
n
> > > > both cases if we get NULL in return, we retry in mmap_lock critical
> > > > section with vma_lookup(). Wouldn't that suffice?
> > >
> > > I think that case is handled correctly by lock_vma().
> >
> > Yeah, it looks good.  I had a bit of a panic as I forgot to check that
> > and I was thinking of a previous version.  I rechecked and v5 looks
> > good.
> >
> > >
> > > Sorry for coming back a bit late. The overall patch looks quite good
> > > but the all these #ifdef CONFIG_PER_VMA_LOCK seem unnecessary to me.
> > > Why find_and_lock_vmas() and lock_mm_and_find_vmas() be called the
> > > same name (find_and_lock_vmas()) and in one case it would lock only
> > > the VMA and in the other case it takes mmap_lock? Similarly
> > > unlock_vma() would in one case unlock the VMA and in the other drop
> > > the mmap_lock? That would remove all these #ifdefs from the code.
> > > Maybe this was already discussed?
> >
> > Yes, I don't think we should be locking the mm in lock_vma(), as it
> > makes things hard to follow.
> >
> > We could use something like uffd_prepare(), uffd_complete() but I
> > thought of those names rather late in the cycle, but I've already cause=
d
> > many iterations of this patch set and that clean up didn't seem as vita=
l
> > as simplicity and clarity of the locking code.

I anyway have to send another version to fix the error handling that
you reported earlier. I can take care of this in that version.

mfill_atomic...() functions (annoyingly) have to sometimes unlock and
relock. Using prepare/complete in that context seems incompatible.

>
> Maybe lock_vma_for_uffd()/unlock_vma_for_uffd()? Whatever name is
> better I'm fine with it but all these #ifdef's sprinkled around don't
> contribute to the readability.

I'll wait for an agreement on this because I too don't like using so
many ifdef's either.

Since these functions are supposed to have prototype depending on
mfill/move, how about the following names:

uffd_lock_mfill_vma()/uffd_unlock_mfill_vma()
uffd_lock_move_vmas()/uffd_unlock_move_vmas()

Of course, I'm open to other suggestions as well.

> Anyway, I don't see this as a blocker, just nice to have.
>
> >
> > Thanks,
> > Liam
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send =
an email to kernel-team+unsubscribe@android.com.
> >
