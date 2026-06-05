Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D408F428822
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780673145; cv=pass; b=Tjklh2/gbHHnxgM8foMA/yCf/nrbD7uwpIjJmWVAKKojF0W8dBUir4a3cq8MdScI1UioKXOFsomWwYUI80ZYi7L1HYseLFzbvLXZ+nD0T5mNZa5lL3qCCJnM+wtDhlT4costFwrIbvghN8PThYibH0qFR2ByswcRmWk2BdCVy0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780673145; c=relaxed/simple;
	bh=m93/qeKf95F/NlDLjr+A45udz9ce6eIC6sUbb9BOxrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/3QRjZfp9EFNeaYRMmKHyw9zBQPYHTOlQpiqxn/iiVPqG+sgjM2TH+JGH9J8YEEBB7oEhzC2REGWIljSlOUcQ+cUNrHJoi+N7CXOUZVmLBMEXX8fUf1xd4hYjD/W95KMcvbqo+xRz37NBfyzhRLyOuoVyRhZAWTBMqkrAH1FxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMmasnaz; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMmasnaz"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8422871b42dso1210435b3a.3
        for <selinux@vger.kernel.org>; Fri, 05 Jun 2026 08:25:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780673143; cv=none;
        d=google.com; s=arc-20240605;
        b=H0HAG0jsbtkx6ViFbqY1YOUEfikjoFGCfvWU1MTziCFAjrSUEXdcmavdMXhcQcjZXR
         6MwlNaUYOaFieXPeFejn7c7mLx/XlCsHsw/tWlgwewwSSQ9G5FBjCwTEsw5xmTtUPXZe
         TWJiQAysZCaFTdUAuXHTt5eVpDb3g4vAskcnOE7rgb3nMMloZHQh22gh5XICRYBEEGGA
         r+30X1e8/kNHQ8ziIATAA37vESoVTJLgSyOjrNxtwt9lyEYXN/wukYkiUOlIo7aVV7EB
         NExPpvqRjdUhD3r7tD7YAuxRQ3wwuJINqCpy2XZtHLb786PbwTSZqhTDXmkC//GZTSHM
         RZfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6BWuqJyyfpCl++ymiDSdjYIKXzPwbBbarC/eUPLLl5E=;
        fh=8YGphTzKAa7VZdSzKjUkPv6a6PKGmIGpaFBWrYLlOvw=;
        b=EXAEKjqlnM14Q8oXe9jSRkJJEbyBghsfIYKo+MvC1UOYpSqRDcn+7Ik1VXyhxe6Ep+
         yCjmmKzUxQN1kRU9Z1iaKDQHK/jTddWuooRVNFxC1XnCZuBxI/HooS2bffgI195la90U
         XsnZkCk3QMrorcqmY4fd14lJWFlUmWqbB5frGniM79oRab2pFmZVYWaNthIrnYOtgmpU
         v+HakrVfYp8ogiTgu+dvCQCOllrzkvLGORKY2LAHmO+fOfTNXcG+OfeX+R7SoxRuR8WK
         aHvbsitSKm2wl2M55RVbMJfKM19DqeickuxXJkmBSmZQa8xbEZj8noVCPJ9bC3cs3XeR
         yxsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780673143; x=1781277943; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6BWuqJyyfpCl++ymiDSdjYIKXzPwbBbarC/eUPLLl5E=;
        b=kMmasnaz6zuTH0a6i3vsD3LHHPhsmOKKmXwLwnP/8vrbm5x84TXsTAON+xgmcZ7U7Q
         qTxe17Hu0Ga5oXXwQr/RKtkynA6YPPj/meOTh+wnsPWK25eseyW1oyc7zkqaapkY00f2
         ZaBiJFdzLYS7Lf7Xzgbioz0SivpplwfW6R6V2w6DbpLE99cmg8VRoKRft7rNflXd/C/0
         MoHK+PGBuOVVYhKvfa/wvmIYzwzv/qxzZzlrJNrJ4LDTBD5tApFrLQNKMSdHFGnV9HX4
         93EAd5xtq0wu1M7X+BXNLlmiZNpi1WIziKRDI9qaVkx9FR5b1rHeL4oCrLBGH1XpC32C
         1xyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780673143; x=1781277943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6BWuqJyyfpCl++ymiDSdjYIKXzPwbBbarC/eUPLLl5E=;
        b=foXVOQx8hEsJRpJr17JJPQt2gdcISr/wqxJY+Z4RwWBroeFJEJ+KxOjHrYBrPQzpuV
         MtNL5BbLBoPl2KKLjor8mw8r6yy2saGp1zTMQUvWVx8GDl7v4fEw1Bav+8172nUhwT06
         pu0BwnhOcW0dMrz0wOMnNROB7jGQkB+u3bnsTkqG9tCgVoM/Tge8AzVJuVnxsvx13EMw
         oqOmJWlpvSNnl36XUmwmYfOZNGPu9tW4RT6BZygOMwOlXV8lwy9Ps8VaXI4O0HgmmqH2
         d29BGDdptBT4OUxrprfV6Hm9pI4agnDE8xCkXmjRVOlVifhkNXWVZZkUNoxnB1hA0AzC
         JESA==
X-Gm-Message-State: AOJu0YyptS99enCAh7WjPlnRCa9Tw9DjHjQhzGT4VLBrKV+vLNOTPSLz
	O/Jg+Y07wF2Xrc7C1Nl0hLGakfSUPhKwNtX/04ah/PPen7r4OvDNQM4ECdsE0gc9pe0Fvh5L518
	kjzqlVLKIw5oEYY3FNf54OTKtL/fe+d4fxQ==
X-Gm-Gg: Acq92OF9LfIlU9/x0DKHncJwKI6OPrAdvCkW7qH/NR5aFfGvAmJIZYFRseQMOnM4i/O
	iYiwiz0hNCRe3VlmQN5UGILW1kPsBFv26riOtCkd4mIUHwMSUp9AoBe6/LdBmZ1RdTpW2ya4ToF
	ZKjyXRvs8jDHDjOhSUJdLf3tDfqF/TD4v4odUbCOskqfHZNuX13jik/4RiibXc0zEGat5Gx97T/
	3r6AQnEbaMAdVYpKbsc6E95qgJ3M3zi69OhyG5Tn3KjTH3zs8cPvRMkwOKLOitMpafqqGGtPt2b
	Qgjul4AQuGuMwOklSQ==
X-Received: by 2002:a05:6a00:2d07:b0:82a:17b6:53ca with SMTP id
 d2e1a72fcca58-842b0e91825mr4079317b3a.38.1780673142982; Fri, 05 Jun 2026
 08:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603120805.251365-3-cahu@suse.de> <CAEjxPJ7cNgRTRCNfotxiqY=2QsMuW=C82HT=GHjQiuborVrxvA@mail.gmail.com>
 <027a5bfc-6d1a-4d07-9f61-48c8f48e9f63@suse.de>
In-Reply-To: <027a5bfc-6d1a-4d07-9f61-48c8f48e9f63@suse.de>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Fri, 5 Jun 2026 11:25:30 -0400
X-Gm-Features: AVHnY4LCqfWa_wsUFIvQjvz2Yw3rSHnUuMobv-4ikyrLABy7T3d9Feov6qza8ws
Message-ID: <CAEjxPJ5QbWJ97fL2tbQPL7Sy7r7Se0-YndpZbS5NBvRWqAeg6w@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: avoid "all" as requirement for
 SWIGSO/SWIGRUBYSO (bsc#1266385)
To: Cathy Hu <cahu@suse.de>
Cc: selinux@vger.kernel.org, fvogt@suse.com, 
	Petr Lautrbach <lautrbach@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 9:05=E2=80=AFAM Cathy Hu <cahu@suse.de> wrote:
>
> On 6/4/26 3:33 PM, Stephen Smalley wrote:
> > On Wed, Jun 3, 2026 at 8:30=E2=80=AFAM Cathy Hu <cahu@suse.de> wrote:
> >>
> >> Commit 49131e5 "libsemanage: Require LIBSO before SWIGSO and SWIGRUBYS=
O (bsc#1266385)"
> >> introduced a regression by requiring "all" in SWIGSO and SWIGRUBYSO.
> >> Listing "all" will cause the targets to rebuild every time because
> >> of .PHONY =3D all.
> >>
> >> Explicitly spell out the requirements depending if DISABLE_SHARED
> >> is "y" or not.
> >
> > I guess I don't understand these patches - make DISABLE_SHARED=3Dy
> > python-M.N_semanage.so fails for me when it tries to link with
> > libsemanage.a with or without this patch. Maybe we need to revert your
> > previous patch.
> >
>
> Sorry for the mess, I will try to explain the whole context in more detai=
l...
>
> tldr;
> Reverting the previous patch will not fix the build problem as it has bee=
n there already
> before my patches.
> The problem there is that DISABLE_SHARED=3Dy on its own is not compatible=
 with python-M.N_semanage.so, as the static
> library is built without -fPIC, which is needed for all components of a s=
hared library.
>
> My patches are fixing a race condition unrelated to it.
>
>
> long:
> 1. Problem that I am trying to solve with my patches:
>
> So basically, libsemanage builds both a libsemanage.so and libsemanage.a =
and the shared object for python is linked with "-lsemanage".
> That prefers .so, but falls back to .a if it exists.
>
> Due to a race condition when building with -j2 it happened on s390x that =
the .a was built, the python .so is linked against it.
> Then only after that, the libsemanage.so was built (so the python .so did=
 not link against it!).
> So the python .so was silently linked against .a and there was no built f=
ailure visible on s390x.
>
> The concrete error can then be seen on the production system:
>
> $ semanage port -a -t http_port_t -p tcp 81
> Traceback (most recent call last):
>    File "/sbin/semanage", line 29, in <module>
>      import seobject
>    File "/usr/lib/python3.13/site-packages/seobject.py", line 31, in <mod=
ule>
>      from semanage import *
>    File "/usr/lib64/python3.13/site-packages/semanage.py", line 12, in <m=
odule>
>      import _semanage
> ImportError: /usr/lib64/python3.13/site-packages/_semanage.cpython-313-s3=
90x-linux-gnu.so: undefined symbol: sepol_ibendport_modify
>
>
> And when my colleague Fabian checked, the built .so lost the necessary DT=
_NEEDED, and also gained TEXTREL. This is really weird.
>
> readelf -dW of the working .so:
>
>
> Dynamic section at offset 0x4a090 contains 28 entries:
>    Tag        Type                         Name/Value
>   0x0000000000000001 (NEEDED)             Shared library: [libsemanage.so=
.2]
>   0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]
>   0x000000000000000c (INIT)               0xfa80
>   0x000000000000000d (FINI)               0x32a90
>   0x0000000000000019 (INIT_ARRAY)         0x4a080
>   0x000000000000001b (INIT_ARRAYSZ)       8 (bytes)
>   0x000000000000001a (FINI_ARRAY)         0x4a088
>   0x000000000000001c (FINI_ARRAYSZ)       8 (bytes)
>   0x0000000000000004 (HASH)               0x1f0
>   0x000000006ffffef5 (GNU_HASH)           0x1760
>   0x0000000000000005 (STRTAB)             0x3f00
>   0x0000000000000006 (SYMTAB)             0x1788
>   0x000000000000000a (STRSZ)              10147 (bytes)
>   0x000000000000000b (SYMENT)             24 (bytes)
>   0x0000000000000003 (PLTGOT)             0x4a290
>   0x0000000000000002 (PLTRELSZ)           9528 (bytes)
>   0x0000000000000014 (PLTREL)             RELA
>   0x0000000000000017 (JMPREL)             0xd548
>   0x0000000000000007 (RELA)               0x6a80
>   0x0000000000000008 (RELASZ)             27336 (bytes)
>   0x0000000000000009 (RELAENT)            24 (bytes)
>   0x000000000000001e (FLAGS)              BIND_NOW
>   0x000000006ffffffb (FLAGS_1)            Flags: NOW
>   0x000000006ffffffe (VERNEED)            0x69f0
>   0x000000006fffffff (VERNEEDNUM)         2
>   0x000000006ffffff0 (VERSYM)             0x66a4
>   0x000000006ffffff9 (RELACOUNT)          1105
>   0x0000000000000000 (NULL)               0x0
>
> readelf -dW of the broken .so (the one that as linked against .a):
>
> Dynamic section at offset 0x92d40 contains 28 entries:
>    Tag        Type                         Name/Value
>   0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]
>   0x000000000000000c (INIT)               0x1b810
>   0x000000000000000d (FINI)               0x6a770
>   0x0000000000000019 (INIT_ARRAY)         0x924c0
>   0x000000000000001b (INIT_ARRAYSZ)       8 (bytes)
>   0x000000000000001a (FINI_ARRAY)         0x924c8
>   0x000000000000001c (FINI_ARRAYSZ)       8 (bytes)
>   0x0000000000000004 (HASH)               0x1f0
>   0x000000006ffffef5 (GNU_HASH)           0x3190
>   0x0000000000000005 (STRTAB)             0xa2d8
>   0x0000000000000006 (SYMTAB)             0x4500
>   0x000000000000000a (STRSZ)              21449 (bytes)
>   0x000000000000000b (SYMENT)             24 (bytes)
>   0x0000000000000003 (PLTGOT)             0x92f40
>   0x0000000000000002 (PLTRELSZ)           12192 (bytes)
>   0x0000000000000014 (PLTREL)             RELA
>   0x0000000000000017 (JMPREL)             0x18870
>   0x0000000000000007 (RELA)               0xff18
>   0x0000000000000008 (RELASZ)             35160 (bytes)
>   0x0000000000000009 (RELAENT)            24 (bytes)
>   0x0000000000000016 (TEXTREL)            0x0
>   0x000000000000001e (FLAGS)              TEXTREL BIND_NOW
>   0x000000006ffffffb (FLAGS_1)            Flags: NOW
>   0x000000006ffffffe (VERNEED)            0xfe78
>   0x000000006fffffff (VERNEEDNUM)         1
>   0x000000006ffffff0 (VERSYM)             0xf6a2
>   0x000000006ffffff9 (RELACOUNT)          1219
>   0x0000000000000000 (NULL)               0x0
>
> IMO the python .so should not silently link against .a when the .so is su=
pposed to be built in the same build.
> Therefor we need to specify in the target that the libsemanage.so is requ=
ired by SWIGSO and SWIGRUBYSO, which I tried in 49131e5.
>
> 2. What I am doing in this patch:
>
> In my previous patch (commit 49131e5) I added "all" as requirement, howev=
er that causes the target to rebuild every time due to "all"
> being listed in .PHONY, which is not pretty.
> To stop it from rebuilding again, we drop "all" from previously and list =
the dependencies explicitly with this patch and do not depend on the "all" =
mechanism.
>
> 3. The linking problem is unrelated
>
> The python .so links against .a when DISABLE_SHARED=3Dy. This was already=
 the implicit behaviour before any of my patches.
> So it already was broken.
>
> You can verify that the problem was already there by reverting my patches=
 and running it and seeing it fail as well
>
> $ wget https://raw.githubusercontent.com/SELinuxProject/selinux/6fedd3fba=
ab440f0657a4d9621741291e7ca96da/libsemanage/src/Makefile -O Makefile     (t=
hat is the Makefile without my patches)
> $ make clean
> $ make DISABLE_SHARED=3Dy install-pywrap
> ...
> /usr/bin/ld.bfd: ./libsemanage.a(conf-scan.o): warning: relocation agains=
t `semanage_lineno' in read-only section `.text'
> /usr/bin/ld.bfd: ./libsemanage.a(debug.o): relocation R_X86_64_PC32 again=
st symbol `stderr@@GLIBC_2.2.5' can not be used when making a shared object=
; recompile with -fPIC
> /usr/bin/ld.bfd: final link failed: bad value
> collect2: error: ld returned 1 exit status
> make: *** [Makefile:86: python-3.13_semanage.so] Error 1
>
> This is because .a is not built with -fPIC. Likely because the .o is not =
built with -fPIC:
> https://github.com/SELinuxProject/selinux/blob/49131e50ba3a6c16ec5ae41d16=
5dadb7183c05b4/libsemanage/src/Makefile#L114
> Therefor it can not be linked, which was the case before my patches alrea=
dy.
>
> Unfortunately, I do not use DISABLE_SHARED as feature and do not know wha=
t is intended behavior or not.
> If that is something that should work, the user either needs to add -fPIC=
 in the make command or .o needs to be built with -fPIC:
> $ make DISABLE_SHARED=3Dy CFLAGS=3D-fPIC python-3.13_semanage.so
>
> But since -fPIC was added everywhere else in this commit, but not the .o,=
 I assumed it was intended that it shall not be there:
> https://github.com/SELinuxProject/selinux/commit/6fedd3fbaab440f0657a4d96=
21741291e7ca96da
>
> Sidenote: I also not understand if it is even intended that the python .s=
o shall be built in a static only system.
>
> So I am trying to keep the behaviour as before for the parts I do not rea=
lly understand while trying to fix my problem.
>
> Hope that makes sense, sorry for the wall of text :)

Thanks for explaining. I think we should just not build any .so files
if DISABLE_SHARED=3Dy but I'll go ahead and merge this.
