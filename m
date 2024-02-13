Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B8460878
	for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707848743; cv=none; b=aqXzU6D0QEGY/yDRX7d1CIdAx1kQPRL8I1yL2TDX5+uOievB3/bS2Tw8Kt4xtOg+5/nlcAlboibRbelCckAEawg6OeSP72u2Gdt9sQP0acdiifTSx6sf6PjdW3s+zZTMrANBoKnPcp8ZJQyEK1PebayMFqIklScRhREvyBROOl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707848743; c=relaxed/simple;
	bh=hXifl7jh2X5sBOfSgmT8CE6ZtI1Jxw0At59d/7DJ06A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shR03Cklb0DkuKsscXFHY4zfgeqxYmNgA8VIrzGbPob/gmdtIbb5+pQplOks97lBG5LNlux5lU3tYSbZslPo6olVcBDSjdeHYPrK2uLv+glFH4misp1/XaqaOh0Le/0A7ofclfJSpoojr48knPz19aMdm9ed7jTvDd+8O7bMKWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4fyKHwCt; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4fyKHwCt"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so1093562276.2
        for <selinux@vger.kernel.org>; Tue, 13 Feb 2024 10:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707848740; x=1708453540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zAYeUGx8AxWS5HRIkW2e+QEILi32w1ZSQIfACi9TajU=;
        b=4fyKHwCtLskQ03IhzTRiYYiXpwDMYrh8xBhEQBTh8vLcZGzdntwtRIMOdDK3wrVYVO
         BGWyX6Ik/ldVw7hb2QGnJWIYEulLUbM2Cty5coOygDToPtN7EV+IEDqiGfANO5b6GWE+
         p4mn8gLVlexdTb519m+2Z5GbmiX6QmFVWHKsbtCxVTLP5Bm1Hr6VCxAql23aJmwgy1c5
         HwJ+HHAnQE9AyuOQtvnVCjp/1eoA7ToOaEEK5iqp30A2gNoYj+Q4+l/9xVMY/10rAoaP
         vVWVsS4khq1O4fl5O0IFNRGiPYyryV9uV1U0hahjVt42PXXvHB6K3++KtcHNhBlkt3Ml
         DMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707848740; x=1708453540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zAYeUGx8AxWS5HRIkW2e+QEILi32w1ZSQIfACi9TajU=;
        b=RtdtiTPr3yAVo8/2KZpQ1rWScF7OhkSGNfL17sHGhLJkRuzvieBIV89MdICy1D4fVw
         WaMQp4XRl4lPd4bEBl5+oejZcTZnkKUA635V1clrOxXbIv7Nl3sp4JWgqL+xMk5/175O
         fSmr5WTyOUl0swBjfVTciCLzk2NrL4rpSwuFTyZTgIYunrGTmZObuL5XzvnsaXlxXd4a
         5CqkYvpTpHVDSmN5xI5y/mRkbkakzSSrarNWmd6HWwz/jRe1D/Ccb3BSgq21wsVIu545
         RyJ0dpUSc80KHhwl6cq8VzznD8L4CC8mSDHY02vIhi0RN103pMmZnuXsam6jn51oM5ra
         esRg==
X-Forwarded-Encrypted: i=1; AJvYcCVmMSFm3IGmgFEtBRlqoCLcaIYCZOqZbNFfZpiaZQF3052cTM1UeEagQZpJB7unB1DRUzyvwEuE3KT9hAptOwoQz4aA1VjnEg==
X-Gm-Message-State: AOJu0YzbCF2ahZAz0shaukXvrf+s1tc4UwTro5Bst53n+mt0DOUd/qES
	uwfkxhxGZlyWQqMuxIIcm/E6CR4Ngdpy4ROvmOe1yxhMonOlDVjrMvDvyNveoe9+pgqqViWN/Te
	hXcJe9Wt2OJb/poueVyiGD34j8DuNmnKizqIU
X-Google-Smtp-Source: AGHT+IGdRu8XKjUJKRkKvDcznUTg4skBmOiJkJhaDQ64RKBRaLdu5QQmvMpAyevdDiDk4nn6WgNwUyj1RoTIjp+I6YU=
X-Received: by 2002:a25:5f09:0:b0:dcc:6e60:7024 with SMTP id
 t9-20020a255f09000000b00dcc6e607024mr48458ybb.45.1707848738732; Tue, 13 Feb
 2024 10:25:38 -0800 (PST)
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
In-Reply-To: <CA+EESO5URPpJj35-jQy+Lrp1EtKms8r1ri2ZY3ZOpsSJU+CScw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 13 Feb 2024 10:25:26 -0800
Message-ID: <CAJuCfpFXWJovv6G4ou2nK2W1D2-JGb5Hw8m77-pOq4Rh24-q9A@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] userfaultfd: use per-vma locks in userfaultfd operations
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 10:14=E2=80=AFAM Lokesh Gidra <lokeshgidra@google.c=
om> wrote:
>
> On Tue, Feb 13, 2024 at 9:06=E2=80=AFAM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > * Lokesh Gidra <lokeshgidra@google.com> [240213 06:25]:
> > > On Mon, Feb 12, 2024 at 7:33=E2=80=AFPM Liam R. Howlett <Liam.Howlett=
@oracle.com> wrote:
> > > >
> > > > * Lokesh Gidra <lokeshgidra@google.com> [240212 19:19]:
> > > > > All userfaultfd operations, except write-protect, opportunistical=
ly use
> > > > > per-vma locks to lock vmas. On failure, attempt again inside mmap=
_lock
> > > > > critical section.
> > > > >
> > > > > Write-protect operation requires mmap_lock as it iterates over mu=
ltiple
> > > > > vmas.
> > > > >
> > > > > Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> > > > > ---
> > > > >  fs/userfaultfd.c              |  13 +-
> > > > >  include/linux/userfaultfd_k.h |   5 +-
> > > > >  mm/userfaultfd.c              | 392 ++++++++++++++++++++++++++--=
------
> > > > >  3 files changed, 312 insertions(+), 98 deletions(-)
> > > > >
> > > > ...
> >
> > I just remembered an issue with the mmap tree that exists today that yo=
u
> > needs to be accounted for in this change.
> >
> > If you hit a NULL VMA, you need to fall back to the mmap_lock() scenari=
o
> > today.
>
> Unless I'm missing something, isn't that already handled in the patch?
> We get the VMA outside mmap_lock critical section only via
> lock_vma_under_rcu() (in lock_vma() and find_and_lock_vmas()) and in
> both cases if we get NULL in return, we retry in mmap_lock critical
> section with vma_lookup(). Wouldn't that suffice?

I think that case is handled correctly by lock_vma().

Sorry for coming back a bit late. The overall patch looks quite good
but the all these #ifdef CONFIG_PER_VMA_LOCK seem unnecessary to me.
Why find_and_lock_vmas() and lock_mm_and_find_vmas() be called the
same name (find_and_lock_vmas()) and in one case it would lock only
the VMA and in the other case it takes mmap_lock? Similarly
unlock_vma() would in one case unlock the VMA and in the other drop
the mmap_lock? That would remove all these #ifdefs from the code.
Maybe this was already discussed?

> >
> > This is a necessity to avoid a race of removal/replacement of a VMA in
> > the mmap(MAP_FIXED) case.  In this case, we munmap() prior to mmap()'in=
g
> > an area - which means you could see a NULL when there never should have
> > been a null.
> >
> > Although this would be exceedingly rare, you need to handle this case.
> >
> > Sorry I missed this earlier,
> > Liam
