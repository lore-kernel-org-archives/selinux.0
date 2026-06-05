Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB1E385506
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 16:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676914; cv=pass; b=sihP8CVTzQr2uwtRuBy/Hn/PsA43JlpB//sPh7bF0mlaaTQ2ll8Z+pyWM4Qi8Z+QRDILJsiNcjucYPKPBuv0qgfgmgnnVNWL0gsbBTyBTZ2T9vfy1+vvkgqw6zSTTuPQs6LHmnmC2mlBeHMFwyvX6+VziHbyZPFZguAzc/Y5uBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676914; c=relaxed/simple;
	bh=dEz7KECPSry141MBhugvU/iHyPbtJ/p8YXA9UyzY3dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XdId3DMAdHHOITu5MIGH4xSXoQdpTHsj9uGN6PaDn6U3uwX3rQpRD9H24MVHurj2lHXD9/QQsWWewVDj2p2xDJDYjsXLug/jBomiz7NrBeWkanWR4zNrAqN4tztmdsFr0IQfhDMYcazTqWGXnc+8m7QOuRHg5UM6ETo2+7tRiEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzHNldJE; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzHNldJE"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c857d04cc99so838949a12.0
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 09:28:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780676906; cv=none;
        d=google.com; s=arc-20240605;
        b=YOzcYKD503ivsao302daaVRUJYtuNZ/hwkTxCu1jGEZWGW3w/cueJ18fniPIU65PW6
         98j7SaQjrUcK7O/3Hdtsb2dfQJD3ZLMqi3YgIB6x0V/hpexlyp/AdvKy33cRDIvQO3pR
         jX3FH9B65yzmjqEOjUtygltcsx8hHErdgx3ZwXFk180Ok4ka1OKmRfvmrvwR0yJQa9t9
         5got5/ETCk9VnxPCmc+GJ7M6dzetfXsv54DmQtN3UXhXFB4p+56Tbi44Dg30mGCklm0+
         toj9Jd+Dxf40vkax4Pr693EMGlR//IrLVyneV99ipYpnMMLOKcSW1qawaRSFJNjJm1o7
         el1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R9WEWKZwaUUlP8faCGDPn04gCqBl23+ZeZ2J1RWS82M=;
        fh=8YGphTzKAa7VZdSzKjUkPv6a6PKGmIGpaFBWrYLlOvw=;
        b=EZZjpQb6B6VeB83HjHMe2aUfkMvRp9kiSoDg/KjvFOLQvG4i3i9jo0V/baC7BDfOcE
         l5wHP22PB8c6vgRlbY5RpoQ2qMhm2mYFO9zK1+GFT4H1Y064sTImPAc702HqlAidX2bE
         JlG4pDaXtWvT2RGXwzEj3FJw+gXhKKtQ0WUGdOqT2pzQEktSdzYtHPoDo9nkEWHbosY/
         F0JhnEp0R3lxdeOmmWUigsrTRpbgF/IyqcmlX9kzbGPDna7smeHdGfBc8wmL2VnZXyZa
         B4vFRTPgUMwep0c988C8vKsE6u8xzEvYUwJA4HgJNr53lO2baZX0vn/qtPJEQWOWasz8
         d0tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780676906; x=1781281706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9WEWKZwaUUlP8faCGDPn04gCqBl23+ZeZ2J1RWS82M=;
        b=FzHNldJELog1bm03VWYsuFM8JWxwsCYp/UxzEY4+VYAR0bIlJQMsj6ENRnKjIHqddy
         ictD6iBYr5937tCvbTXXwI7nb8ajozvOa/g8Kkh6yY7K75A/xDFZD0voYtTkFiaiHMlp
         Smo7N75+eCP0KOhXcfeOMFmOvn1LvmTkRM1DxD9Gp4adLmmF1qTKJX+aL8BjCHpa2BuU
         STL6NK0Nx49d8dlZfoqsMn8R2yM6wZVeN9hbGcfCppcpJ3gIWwX8S7rthWglr7qoMjkN
         /XieeWmU5jS3osz30UWhMHvTPiQMWBojwJXPNW2wTsvgJ45vS5xXqjmHMVWw1okir6PO
         IeuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676906; x=1781281706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R9WEWKZwaUUlP8faCGDPn04gCqBl23+ZeZ2J1RWS82M=;
        b=C6l1OK1dBgMb9HsAGt/feqN+d6Pq2JhTtb+tynV1QDaeLbGxMfDCNjRmFApeDFM06v
         aQctaFAR4s6x2tn9/k0hOC7sKBnqccHWAm5xzPlArUApCYyAYp0jePq5NN1mRUBtNMbF
         i9tZp8mpe/ZEIgfIiXQ4Q4s/FGZw4yMsB5ofLenJMAgefoRomddHG+l1gy+PoHDUDCB4
         l7rBrBC0UZ9NS2JIdz7mdjfpSS76LDn1etZ1KRLrv3kQuZtvMQCPNCRRdV7qLB0ONUhH
         nv3J9x2hTdqIMZqZrCwEuxJBlmy4nw3ZilBLhDskM48e2kipnzuw7KqJk/VK/R/C3GAX
         3llw==
X-Gm-Message-State: AOJu0Yw2oaKyQiRGut3k/rSRnnDI70BxqP8gGGiiYBY6YnGD2oAVNNZG
	mdjKtYH9UwsaH3L2QBJyVh03s7YFMvm04N31Qr4IcSNVCPHmTkf2tHD20VblnABD/8BK2xNa8RC
	htrtS44FJK94pq47DGA2Okcvl8EykZgfq4A==
X-Gm-Gg: Acq92OEgA4rppCoKROisg8791BVMqHXOYesLqJjQmfauuOuaeWTcgdAN+1yzrP2aiBT
	sNqX2TxMPDn0FV+pcx+mNJASwihfraIPYlpcZk189H8Om8kDhuYcNBlzHMzexrxGdcaOUfMPhLK
	FVnQCCVxQFUxnhHkkbjeNAjhlrDzBDjyH23rOtXZVYZjdqXSiF+DXKwCQ0komyUZdjGadtk1uX5
	qteI+nAjy6XSi2j5d7LQUzo7wk9f9URwwvuWjvMongxxOxbrLaf8UB48/MbqXnjIUz0rZJ79Zg0
	IeOgQeJXGsJfZ8ou6Q==
X-Received: by 2002:a05:6a20:d529:b0:3a2:ed4a:5d7e with SMTP id
 adf61e73a8af0-3b4d3ce506fmr3621043637.22.1780676906113; Fri, 05 Jun 2026
 09:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603120805.251365-3-cahu@suse.de> <CAEjxPJ7cNgRTRCNfotxiqY=2QsMuW=C82HT=GHjQiuborVrxvA@mail.gmail.com>
 <027a5bfc-6d1a-4d07-9f61-48c8f48e9f63@suse.de> <CAEjxPJ5QbWJ97fL2tbQPL7Sy7r7Se0-YndpZbS5NBvRWqAeg6w@mail.gmail.com>
In-Reply-To: <CAEjxPJ5QbWJ97fL2tbQPL7Sy7r7Se0-YndpZbS5NBvRWqAeg6w@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 12:28:14 -0400
X-Gm-Features: AVHnY4L1fkUhgt46wpIavwe447VPe4eg1KMEUEhlehn3dQ2EUSvJ8EjdhPCGwxw
Message-ID: <CAEjxPJ6cu62wkHQnRKrc4ZJ3VOQavOKWakNbzggevkYjLAuS1A@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: avoid "all" as requirement for
 SWIGSO/SWIGRUBYSO (bsc#1266385)
To: Cathy Hu <cahu@suse.de>
Cc: selinux@vger.kernel.org, fvogt@suse.com, 
	Petr Lautrbach <lautrbach@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 11:25=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Jun 5, 2026 at 9:05=E2=80=AFAM Cathy Hu <cahu@suse.de> wrote:
> >
> > On 6/4/26 3:33 PM, Stephen Smalley wrote:
> > > On Wed, Jun 3, 2026 at 8:30=E2=80=AFAM Cathy Hu <cahu@suse.de> wrote:
> > >>
> > >> Commit 49131e5 "libsemanage: Require LIBSO before SWIGSO and SWIGRUB=
YSO (bsc#1266385)"
> > >> introduced a regression by requiring "all" in SWIGSO and SWIGRUBYSO.
> > >> Listing "all" will cause the targets to rebuild every time because
> > >> of .PHONY =3D all.
> > >>
> > >> Explicitly spell out the requirements depending if DISABLE_SHARED
> > >> is "y" or not.
> > >
> > > I guess I don't understand these patches - make DISABLE_SHARED=3Dy
> > > python-M.N_semanage.so fails for me when it tries to link with
> > > libsemanage.a with or without this patch. Maybe we need to revert you=
r
> > > previous patch.
> > >
> >
> > Sorry for the mess, I will try to explain the whole context in more det=
ail...
> >
> > tldr;
> > Reverting the previous patch will not fix the build problem as it has b=
een there already
> > before my patches.
> > The problem there is that DISABLE_SHARED=3Dy on its own is not compatib=
le with python-M.N_semanage.so, as the static
> > library is built without -fPIC, which is needed for all components of a=
 shared library.
> >
> > My patches are fixing a race condition unrelated to it.
> >
> >
> > long:
> > 1. Problem that I am trying to solve with my patches:
> >
> > So basically, libsemanage builds both a libsemanage.so and libsemanage.=
a and the shared object for python is linked with "-lsemanage".
> > That prefers .so, but falls back to .a if it exists.
> >
> > Due to a race condition when building with -j2 it happened on s390x tha=
t the .a was built, the python .so is linked against it.
> > Then only after that, the libsemanage.so was built (so the python .so d=
id not link against it!).
> > So the python .so was silently linked against .a and there was no built=
 failure visible on s390x.
> >
> > The concrete error can then be seen on the production system:
> >
> > $ semanage port -a -t http_port_t -p tcp 81
> > Traceback (most recent call last):
> >    File "/sbin/semanage", line 29, in <module>
> >      import seobject
> >    File "/usr/lib/python3.13/site-packages/seobject.py", line 31, in <m=
odule>
> >      from semanage import *
> >    File "/usr/lib64/python3.13/site-packages/semanage.py", line 12, in =
<module>
> >      import _semanage
> > ImportError: /usr/lib64/python3.13/site-packages/_semanage.cpython-313-=
s390x-linux-gnu.so: undefined symbol: sepol_ibendport_modify
> >
> >
> > And when my colleague Fabian checked, the built .so lost the necessary =
DT_NEEDED, and also gained TEXTREL. This is really weird.
> >
> > readelf -dW of the working .so:
> >
> >
> > Dynamic section at offset 0x4a090 contains 28 entries:
> >    Tag        Type                         Name/Value
> >   0x0000000000000001 (NEEDED)             Shared library: [libsemanage.=
so.2]
> >   0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]
> >   0x000000000000000c (INIT)               0xfa80
> >   0x000000000000000d (FINI)               0x32a90
> >   0x0000000000000019 (INIT_ARRAY)         0x4a080
> >   0x000000000000001b (INIT_ARRAYSZ)       8 (bytes)
> >   0x000000000000001a (FINI_ARRAY)         0x4a088
> >   0x000000000000001c (FINI_ARRAYSZ)       8 (bytes)
> >   0x0000000000000004 (HASH)               0x1f0
> >   0x000000006ffffef5 (GNU_HASH)           0x1760
> >   0x0000000000000005 (STRTAB)             0x3f00
> >   0x0000000000000006 (SYMTAB)             0x1788
> >   0x000000000000000a (STRSZ)              10147 (bytes)
> >   0x000000000000000b (SYMENT)             24 (bytes)
> >   0x0000000000000003 (PLTGOT)             0x4a290
> >   0x0000000000000002 (PLTRELSZ)           9528 (bytes)
> >   0x0000000000000014 (PLTREL)             RELA
> >   0x0000000000000017 (JMPREL)             0xd548
> >   0x0000000000000007 (RELA)               0x6a80
> >   0x0000000000000008 (RELASZ)             27336 (bytes)
> >   0x0000000000000009 (RELAENT)            24 (bytes)
> >   0x000000000000001e (FLAGS)              BIND_NOW
> >   0x000000006ffffffb (FLAGS_1)            Flags: NOW
> >   0x000000006ffffffe (VERNEED)            0x69f0
> >   0x000000006fffffff (VERNEEDNUM)         2
> >   0x000000006ffffff0 (VERSYM)             0x66a4
> >   0x000000006ffffff9 (RELACOUNT)          1105
> >   0x0000000000000000 (NULL)               0x0
> >
> > readelf -dW of the broken .so (the one that as linked against .a):
> >
> > Dynamic section at offset 0x92d40 contains 28 entries:
> >    Tag        Type                         Name/Value
> >   0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]
> >   0x000000000000000c (INIT)               0x1b810
> >   0x000000000000000d (FINI)               0x6a770
> >   0x0000000000000019 (INIT_ARRAY)         0x924c0
> >   0x000000000000001b (INIT_ARRAYSZ)       8 (bytes)
> >   0x000000000000001a (FINI_ARRAY)         0x924c8
> >   0x000000000000001c (FINI_ARRAYSZ)       8 (bytes)
> >   0x0000000000000004 (HASH)               0x1f0
> >   0x000000006ffffef5 (GNU_HASH)           0x3190
> >   0x0000000000000005 (STRTAB)             0xa2d8
> >   0x0000000000000006 (SYMTAB)             0x4500
> >   0x000000000000000a (STRSZ)              21449 (bytes)
> >   0x000000000000000b (SYMENT)             24 (bytes)
> >   0x0000000000000003 (PLTGOT)             0x92f40
> >   0x0000000000000002 (PLTRELSZ)           12192 (bytes)
> >   0x0000000000000014 (PLTREL)             RELA
> >   0x0000000000000017 (JMPREL)             0x18870
> >   0x0000000000000007 (RELA)               0xff18
> >   0x0000000000000008 (RELASZ)             35160 (bytes)
> >   0x0000000000000009 (RELAENT)            24 (bytes)
> >   0x0000000000000016 (TEXTREL)            0x0
> >   0x000000000000001e (FLAGS)              TEXTREL BIND_NOW
> >   0x000000006ffffffb (FLAGS_1)            Flags: NOW
> >   0x000000006ffffffe (VERNEED)            0xfe78
> >   0x000000006fffffff (VERNEEDNUM)         1
> >   0x000000006ffffff0 (VERSYM)             0xf6a2
> >   0x000000006ffffff9 (RELACOUNT)          1219
> >   0x0000000000000000 (NULL)               0x0
> >
> > IMO the python .so should not silently link against .a when the .so is =
supposed to be built in the same build.
> > Therefor we need to specify in the target that the libsemanage.so is re=
quired by SWIGSO and SWIGRUBYSO, which I tried in 49131e5.
> >
> > 2. What I am doing in this patch:
> >
> > In my previous patch (commit 49131e5) I added "all" as requirement, how=
ever that causes the target to rebuild every time due to "all"
> > being listed in .PHONY, which is not pretty.
> > To stop it from rebuilding again, we drop "all" from previously and lis=
t the dependencies explicitly with this patch and do not depend on the "all=
" mechanism.
> >
> > 3. The linking problem is unrelated
> >
> > The python .so links against .a when DISABLE_SHARED=3Dy. This was alrea=
dy the implicit behaviour before any of my patches.
> > So it already was broken.
> >
> > You can verify that the problem was already there by reverting my patch=
es and running it and seeing it fail as well
> >
> > $ wget https://raw.githubusercontent.com/SELinuxProject/selinux/6fedd3f=
baab440f0657a4d9621741291e7ca96da/libsemanage/src/Makefile -O Makefile     =
(that is the Makefile without my patches)
> > $ make clean
> > $ make DISABLE_SHARED=3Dy install-pywrap
> > ...
> > /usr/bin/ld.bfd: ./libsemanage.a(conf-scan.o): warning: relocation agai=
nst `semanage_lineno' in read-only section `.text'
> > /usr/bin/ld.bfd: ./libsemanage.a(debug.o): relocation R_X86_64_PC32 aga=
inst symbol `stderr@@GLIBC_2.2.5' can not be used when making a shared obje=
ct; recompile with -fPIC
> > /usr/bin/ld.bfd: final link failed: bad value
> > collect2: error: ld returned 1 exit status
> > make: *** [Makefile:86: python-3.13_semanage.so] Error 1
> >
> > This is because .a is not built with -fPIC. Likely because the .o is no=
t built with -fPIC:
> > https://github.com/SELinuxProject/selinux/blob/49131e50ba3a6c16ec5ae41d=
165dadb7183c05b4/libsemanage/src/Makefile#L114
> > Therefor it can not be linked, which was the case before my patches alr=
eady.
> >
> > Unfortunately, I do not use DISABLE_SHARED as feature and do not know w=
hat is intended behavior or not.
> > If that is something that should work, the user either needs to add -fP=
IC in the make command or .o needs to be built with -fPIC:
> > $ make DISABLE_SHARED=3Dy CFLAGS=3D-fPIC python-3.13_semanage.so
> >
> > But since -fPIC was added everywhere else in this commit, but not the .=
o, I assumed it was intended that it shall not be there:
> > https://github.com/SELinuxProject/selinux/commit/6fedd3fbaab440f0657a4d=
9621741291e7ca96da
> >
> > Sidenote: I also not understand if it is even intended that the python =
.so shall be built in a static only system.
> >
> > So I am trying to keep the behaviour as before for the parts I do not r=
eally understand while trying to fix my problem.
> >
> > Hope that makes sense, sorry for the wall of text :)
>
> Thanks for explaining. I think we should just not build any .so files
> if DISABLE_SHARED=3Dy but I'll go ahead and merge this.

This is merged.
