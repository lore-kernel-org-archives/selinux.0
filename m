Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB36214D71A
	for <selinux@vger.kernel.org>; Thu, 23 Jan 2025 18:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737657952; cv=none; b=eDX/EjCvK1TYbfkcpHM7cUVk5NXh4p7dLkgEJbo5JGjVzCirRj1bJJh6HGv7zMeoCorXth0D6sy6Fe59Tl+EocWy/RJ0rQbNqaL5uvDmGmwBDPQqc8r97Spx573yjz21JMLl0zQWiV1tT8bRfhyhWMHPv5Bza3hcD5byAhDTLwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737657952; c=relaxed/simple;
	bh=eXy3XZPOf4rqphTH/PQRd13MhXg9t6SD8vkgOy35dJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=jZ9fyX3MJ1QGO4o8KGKuR8vYuzizfPRLZAzapjVBo39zVSZb7HTbZoYcE8ELOaFhuhB1mlFbIXfB3zl+scAAjRFe4urQzMndmUjPlWOBj81H5f2XWcHGVMeLKm6lXnsbKFNYfvw/wm+qdWycNbQgPHBiU39IRfL34OTCOgqF3fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3PgfTFo4; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3PgfTFo4"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4679b5c66d0so25671cf.1
        for <selinux@vger.kernel.org>; Thu, 23 Jan 2025 10:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737657950; x=1738262750; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzTal6iWSgRdob0bIKRNXXhtdn3zJnxk/3GyL7XVhOY=;
        b=3PgfTFo4/5a7jnfMihwCmPhELlVA+FsjDLn2oPQUQmIzFWdNrho+QMv0r/HjCdVn4H
         VphFA8YSjKKXIZNbJ26YY79TGCOMN/+z1Kus+e241eFvL+ItQAaZdborpg8bBMoFeS5k
         BE5X2UCOWZ68cv9byncUIQYdBCSJJn+yeha79glmHId6XTdUMlnADfNsnSpYQjfvszns
         6b3ktMyyFVvsLDT8hU/Rq7HQUgzqV1p8u3b1e8Cm0m6arBtHPjep5X40MvYiww+aConq
         9sDsfmqdx7dGjM9zVWF0kh8Dhh3OqyvgJSShnmtWgcxPZSxxCewC85KY/5yO087+4tBo
         vlsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737657950; x=1738262750;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzTal6iWSgRdob0bIKRNXXhtdn3zJnxk/3GyL7XVhOY=;
        b=ts5ts932zLJFcRi8HUJeukO+HEkusB15C/qudv1YYr9s+q20IMv5M/gMBJKGaVVWyY
         EoKAvv0ROspguwP+PArOKafO6p1QDtcq220fjrtyQMJtBuO13WAoKvhdEtZoDV8z/e6Q
         3hiDwYx4+sva6YvmhK2G9AGaEy5PfnpQaLq8f3aSTSD63C9d5ZVY+ivMW52KA4BqLecs
         sVcPoAgvdGd986bsEPETXr+qdGjNcqyIJwt/h+kN4VsjOi/KTvJc72EUtIhxj6s3ZWVJ
         iTGo87eCrlix1M7o1aevQn3E9BAsdhsQ9mIsz5/gQ6QkRSjqBo9kTtT/yNSH3t6qeFvc
         dazg==
X-Forwarded-Encrypted: i=1; AJvYcCXmcfqu7NsNOcQ7QpumaAoXSv3IpXGBXRdIuOuTw7F1hl2viuwnnLElCJt6rHC5yrPUnz1/g++f@vger.kernel.org
X-Gm-Message-State: AOJu0YxoFdUCW4jGc3Xkg/RWST6zVFnA6epIqslNa0svB9ah+NfEK0b2
	yRrEjYZFE9Ni2PT1zoMS+esMK2rzWajrcaJ0542gsBXg/W1StehOVueON7dxG3G9xtJXGC/sPLJ
	Uve4G/oltbOSUb1b9azVzn9ZydV1/ShyisQi6
X-Gm-Gg: ASbGnctcO/o8AyCrDq9LOP4u0mA8tHLzBNmla37R6/mhZYZGAre2d7NxMQsiSIl1fAf
	Y/3b8sli5NPHI68pXJ81LgkFrUFIeXAVMAiJ0Tzkg6ViqKGUysSMWGYGg19QEApZdzVZM+elsHD
	JEDRIm5kRnygClrB59
X-Google-Smtp-Source: AGHT+IG4V8k2kiWVwIIq8NqKoAcpRM90sfY7xSa2fqPnbG4bspmvURYYLtxVVkgmjdUEevT7QXUIGyQvs+SL5p4eq/g=
X-Received: by 2002:a05:622a:10a:b0:467:8416:d99e with SMTP id
 d75a77b69052e-46e5dad8c0amr4346531cf.21.1737657949428; Thu, 23 Jan 2025
 10:45:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215182756.3448972-5-lokeshgidra@google.com>
 <20250123041427.1987-1-21cnbao@gmail.com> <rb7qajtpmmntvvqq2ckzjqs76mflxyuingixx3v7q63jd7xqfm@v7hm5aqhe23z>
In-Reply-To: <rb7qajtpmmntvvqq2ckzjqs76mflxyuingixx3v7q63jd7xqfm@v7hm5aqhe23z>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Thu, 23 Jan 2025 10:45:37 -0800
X-Gm-Features: AWEUYZnxP3hHn1SCq9RZ8V68AJ7A6aXxrkeYLIAPk8QrC-9p9GGZ0p-pls4mfwA
Message-ID: <CA+EESO64boFPfXqZ7c6nQe6U8K4T-4acVC+RKRQWwHP_+0YTQA@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] userfaultfd: use per-vma locks in userfaultfd operations
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Barry Song <21cnbao@gmail.com>, lokeshgidra@google.com, 
	aarcange@redhat.com, akpm@linux-foundation.org, axelrasmussen@google.com, 
	bgeffon@google.com, david@redhat.com, jannh@google.com, 
	kaleshsingh@google.com, kernel-team@android.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, ngeoffray@google.com, peterx@redhat.com, rppt@kernel.org, 
	ryan.roberts@arm.com, selinux@vger.kernel.org, surenb@google.com, 
	timmurray@google.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 8:52=E2=80=AFAM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> * Barry Song <21cnbao@gmail.com> [250122 23:14]:
> > > All userfaultfd operations, except write-protect, opportunistically u=
se
> > > per-vma locks to lock vmas. On failure, attempt again inside mmap_loc=
k
> > > critical section.
> > >
> > > Write-protect operation requires mmap_lock as it iterates over multip=
le
> > > vmas.
> > h
> > Hi Lokesh,
> >
> > Apologies for reviving this old thread. We truly appreciate the excelle=
nt work
> > you=E2=80=99ve done in transitioning many userfaultfd operations to per=
-VMA locks.
> >
> > However, we=E2=80=99ve noticed that userfaultfd still remains one of th=
e largest users
> > of mmap_lock for write operations, with the other=E2=80=94binder=E2=80=
=94having been recently
> > addressed by Carlos Llamas's "binder: faster page installations" series=
:
> >
> > https://lore.kernel.org/lkml/20241203215452.2820071-1-cmllamas@google.c=
om/
> >
> > The HeapTaskDaemon(Java GC) might frequently perform userfaultfd_regist=
er()
> > and userfaultfd_unregister() operations, both of which require the mmap=
_lock
> > in write mode to either split or merge VMAs. Since HeapTaskDaemon is a
> > lower-priority background task, there are cases where, after acquiring =
the
> > mmap_lock, it gets preempted by other tasks. As a result, even high-pri=
ority
> > threads waiting for the mmap_lock =E2=80=94 whether in writer or reader=
 mode=E2=80=94can
> > end up experiencing significant delays=EF=BC=88The delay can reach seve=
ral hundred
> > milliseconds in the worst case.=EF=BC=89

Do you happen to have some trace that I can take a look at?
>
> This needs an RFC or proposal or a discussion - certainly not a reply to
> an old v7 patch set.  I'd want neon lights and stuff directing people to
> this topic.
>
> >
> > We haven=E2=80=99t yet identified an ideal solution for this. However, =
the Java heap
> > appears to behave like a "volatile" vma in its usage. A somewhat simpli=
stic
> > idea would be to designate a specific region of the user address space =
as
> > "volatile" and restrict all "volatile" VMAs to this isolated region.
>
> I'm going to assume the uffd changes are in the volatile area?  But
> really, maybe you mean the opposite..  I'll just assume I guessed
> correct here.  Because, both sides of this are competing for the write
> lock.
>
> >
> > We may have a MAP_VOLATILE flag to mmap. VMA regions with this flag wil=
l be
> > mapped to the volatile space, while those without it will be mapped to =
the
> > non-volatile space.
> >
> >          =E2=94=8C=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=90TASK_SIZE
> >          =E2=94=82            =E2=94=82
> >          =E2=94=82            =E2=94=82
> >          =E2=94=82            =E2=94=82mmap VOLATILE
> >          =E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=A4
> >          =E2=94=82            =E2=94=82
> >          =E2=94=82            =E2=94=82
> >          =E2=94=82            =E2=94=82
> >          =E2=94=82            =E2=94=82
> >          =E2=94=82            =E2=94=82default mmap
> >          =E2=94=82            =E2=94=82
> >          =E2=94=82            =E2=94=82
> >          =E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=98
>
> No, this is way too complicated for what you are trying to work around.
>
> You are proposing a segmented layout of the virtual memory area so that
> an optional (userfaultfd) component can avoid a lock - which already has
> another optional (vma locking) workaround.
>
> I think we need to stand back and look at what we're doing here in
> regards to userfaultfd and how it interacts with everything.  Things
> have gotten complex and we're going in the wrong direction.
>
> I suggest there is an easier way to avoid the contention, and maybe try
> to rectify some of the uffd code to fit better with the evolved use
> cases and vma locking.
>
> >
> > VMAs in the volatile region are assigned their own volatile_mmap_lock,
> > which is independent of the mmap_lock for the non-volatile region.
> > Additionally, we ensure that no single VMA spans the boundary between
> > the volatile and non-volatile regions. This separation prevents the
> > frequent modifications of a small number of volatile VMAs from blocking
> > other operations on a large number of non-volatile VMAs.
> >
> > The implementation itself wouldn=E2=80=99t be overly complex, but the d=
esign
> > might come across as somewhat hacky.

I agree with others. Your proposal sounds too radical and doesn't seem
necessary to me. I'd like to see the traces and understand how
real/frequent the issue is.
> >
> > Lastly, I have two questions:
> >
> > 1. Have you observed similar issues where userfaultfd continues to
> > cause lock contention and priority inversion?

We haven't seen any such cases so far. But due to some other reasons,
we are seriously considering temporarily increasing the GC-thread's
priority when it is running stop-the-world pause.
> >
> > 2. If so, do you have any ideas or suggestions on how to address this
> > problem?

There are userspace solutions possible to reduce/eliminate the number
of times userfaultfd register/unregister are done during a GC. I
didn't do it due to added complexity it would introduce to the GC's
code.
>
> These are good questions.
>
> I have a few of my own about what you described:
>
> - What is causing your application to register/unregister so many uffds?

In every GC invocation, we have two userfaultfd_register() + mremap()
in a stop-the-world pause, and then two userfaultfd_unregister() at
the end of GC. The problematic ones ought to be the one in the pause
as we want to keep it as short as possible. The reason we want to
register/unregister the heap during GC is so that the overhead of
userfaults can be avoided when GC is not active.

>
> - Does the writes to the vmas overlap the register/unregsiter area
>   today?  That is, do you have writes besides register/unregister going
>   into your proposed volatile area or uffd modifications happening in
>   the 'default mmap' area you specify above?

That shouldn't be the case. The access to uffd registered VMAs should
start *after* registration. That's the reason it is done in a pause.
AFAIK, the source of contention is if some native (non-java) thread,
which is not participating in the pause, does a mmap_lock write
operation (mmap/munmap/mprotect/mremap/mlock etc.) elsewhere in the
address space. The heap can't be involved.
>
> Barry, this is a good LSF topic - will you be there?  I hope to attend.
>
> Something along the lines of "Userfualtfd contention, interactions, and
> mitigations".
>
> Thanks,
> Liam
>
