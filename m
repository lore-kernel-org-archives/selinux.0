Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6D1111B2
	for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 18:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707850636; cv=none; b=bZ8HqvhbQdAIv2bf7tBbEw9EaYevPPMyvg5n6RUePkhqdhyrwty94D8PakxpsJg7imH6SqDcAidBDz64WASDYIUvE9LuAfyPm058VcS8j7eYk241RqJzvZI2ptzfoioXTlw+z9D2WozSSujy5McmzhykRMMUJgeFyHA0OovEKSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707850636; c=relaxed/simple;
	bh=Ab6/KRWXKyqviiIVltgPoMU4aIUhh8wKEZMvUQ13lgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=FSyAgQfbOKHA8wdhEmDcPGg5iR0F7FHnkU2vSz4YAAuNCRNOkoykfUMVH0dol05lF6NiBs0QtUHD38kPnJIcL893HrcDa8PJ42Cx/q1orC1vovATNEThUnff2tLC6X5uV59OMHNWhTORWEnT7CnaJTScvLu2m7ZHACMdppgUEjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AAMsDWVY; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AAMsDWVY"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dccb1421bdeso930060276.1
        for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 10:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707850632; x=1708455432; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AizEZRsj9zp0aMtrzGKjLan03hrWjNj+oXUsjIKs8lg=;
        b=AAMsDWVYPE0xeA98BMXq2a5AFPzpFejhEx5lPTQlbgpg/Qjqh5bsmYb7lRrXg7i0sE
         1eSemTKgNIlmDhJwqBToBlOBZyoYT5O8g5t2sw8tBYvZkgxnJTFapmLxZX0dBGEeNVbt
         5+E5GRIMB0ayUv18nxW7e6gD9H6WRbrzbKXrrtbrsrIL1zT7reXvU9EzA2Esyz5AO7op
         O/fbpi5705oybxjHHzBNMGat8N8M73/cXHEFUKKZPX/UdC76m6sQUzFG6n5+KJQ1SPgK
         NdRX4uwoDASIKMk8m9tg4+X+7AlC1iQEKEE/PeO9Sk0+EKSOpQACnbgqf37oVvchxh0O
         nl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707850632; x=1708455432;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AizEZRsj9zp0aMtrzGKjLan03hrWjNj+oXUsjIKs8lg=;
        b=uEhwPrTPIr91UY5FpnAGYwwzvukIkltIqcyAbfLscRcctxx7u9duD2ZHK0+wEEmX5P
         GTSwIyisDVIs2vJfStSW6ej4ViRMh5y0l/mbsQTSYPvKUyXg8IBHXhCHxcYlz1RCI3i2
         1XwvhhMXb+j+AlAjkMmJGvWWWhm5/5Esn7l6jW0AmfMRyq8l4JP2aMO/smxnDrA6NVRR
         e9bQzYOEMJ5sp2zOdSezxTzBKZrGNoBvdBaPJCi9b5TBF/3j0/VQsrme+VYuwLxLknYz
         qtcvIC7rNfDqsttbgK5GU7bbrH7MrWrVcXIxKhvoTlbqzADEaijacklRs3W4GaaMKSgP
         kXbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJLjK4HzBKBHrgkkc3OI3oKXZIn7WuXiUZdR3qAVnXwLHdtU3zVwLwLiMLAcx7Nv578GFgDDY4RpiTeA17g5VfXf6P2LinuA==
X-Gm-Message-State: AOJu0YyzXwdG9jDCq0ToFEd8j8QpvhM2cbAwW4X3xuOLbBwY5XJ65NWH
	+5PuJAesCIoJXWHyaE5UFHgNSPhngqV0iw6+qftXXmCo3BcTFxTnP1YoTlOAyKG/f6Dq7T5QEQ+
	nDMCZjq1PwPBtCvrTOcOsn+dMMrDMyTCWj/2c
X-Google-Smtp-Source: AGHT+IEiR97DUM9oD42STYdu2QJ9SXD6hTNaKKADBvYUD5yfI5r4qhcPBqwPNyK4iEliEjUCka8aTia/tRWqdtwKhAE=
X-Received: by 2002:a25:83d0:0:b0:dcb:38d3:3c6a with SMTP id
 v16-20020a2583d0000000b00dcb38d33c6amr35575ybm.46.1707850631000; Tue, 13 Feb
 2024 10:57:11 -0800 (PST)
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
 <CAJuCfpFXWJovv6G4ou2nK2W1D2-JGb5Hw8m77-pOq4Rh24-q9A@mail.gmail.com> <20240213184905.tp4i2ifbglfzlwi6@revolver>
In-Reply-To: <20240213184905.tp4i2ifbglfzlwi6@revolver>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 13 Feb 2024 10:56:58 -0800
Message-ID: <CAJuCfpG+8uypn3Mw0GNBj0TUM51gaSdAnGZB-RE4HdJs7dKb0A@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] userfaultfd: use per-vma locks in userfaultfd operations
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Suren Baghdasaryan <surenb@google.com>, 
	Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 10:49=E2=80=AFAM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [240213 13:25]:
> > On Tue, Feb 13, 2024 at 10:14=E2=80=AFAM Lokesh Gidra <lokeshgidra@goog=
le.com> wrote:
> > >
> > > On Tue, Feb 13, 2024 at 9:06=E2=80=AFAM Liam R. Howlett <Liam.Howlett=
@oracle.com> wrote:
> > > >
> > > > * Lokesh Gidra <lokeshgidra@google.com> [240213 06:25]:
> > > > > On Mon, Feb 12, 2024 at 7:33=E2=80=AFPM Liam R. Howlett <Liam.How=
lett@oracle.com> wrote:
> > > > > >
> > > > > > * Lokesh Gidra <lokeshgidra@google.com> [240212 19:19]:
> > > > > > > All userfaultfd operations, except write-protect, opportunist=
ically use
> > > > > > > per-vma locks to lock vmas. On failure, attempt again inside =
mmap_lock
> > > > > > > critical section.
> > > > > > >
> > > > > > > Write-protect operation requires mmap_lock as it iterates ove=
r multiple
> > > > > > > vmas.
> > > > > > >
> > > > > > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > > > > > ---
> > > > > > >  fs/userfaultfd.c              |  13 +-
> > > > > > >  include/linux/userfaultfd_k.h |   5 +-
> > > > > > >  mm/userfaultfd.c              | 392 ++++++++++++++++++++++++=
++--------
> > > > > > >  3 files changed, 312 insertions(+), 98 deletions(-)
> > > > > > >
> > > > > > ...
> > > >
> > > > I just remembered an issue with the mmap tree that exists today tha=
t you
> > > > needs to be accounted for in this change.
> > > >
> > > > If you hit a NULL VMA, you need to fall back to the mmap_lock() sce=
nario
> > > > today.
> > >
> > > Unless I'm missing something, isn't that already handled in the patch=
?
> > > We get the VMA outside mmap_lock critical section only via
> > > lock_vma_under_rcu() (in lock_vma() and find_and_lock_vmas()) and in
> > > both cases if we get NULL in return, we retry in mmap_lock critical
> > > section with vma_lookup(). Wouldn't that suffice?
> >
> > I think that case is handled correctly by lock_vma().
>
> Yeah, it looks good.  I had a bit of a panic as I forgot to check that
> and I was thinking of a previous version.  I rechecked and v5 looks
> good.
>
> >
> > Sorry for coming back a bit late. The overall patch looks quite good
> > but the all these #ifdef CONFIG_PER_VMA_LOCK seem unnecessary to me.
> > Why find_and_lock_vmas() and lock_mm_and_find_vmas() be called the
> > same name (find_and_lock_vmas()) and in one case it would lock only
> > the VMA and in the other case it takes mmap_lock? Similarly
> > unlock_vma() would in one case unlock the VMA and in the other drop
> > the mmap_lock? That would remove all these #ifdefs from the code.
> > Maybe this was already discussed?
>
> Yes, I don't think we should be locking the mm in lock_vma(), as it
> makes things hard to follow.
>
> We could use something like uffd_prepare(), uffd_complete() but I
> thought of those names rather late in the cycle, but I've already caused
> many iterations of this patch set and that clean up didn't seem as vital
> as simplicity and clarity of the locking code.

Maybe lock_vma_for_uffd()/unlock_vma_for_uffd()? Whatever name is
better I'm fine with it but all these #ifdef's sprinkled around don't
contribute to the readability.
Anyway, I don't see this as a blocker, just nice to have.

>
> Thanks,
> Liam
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
