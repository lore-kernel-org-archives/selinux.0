Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7AC19E7FA
	for <selinux@vger.kernel.org>; Fri, 25 Apr 2025 17:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745601866; cv=none; b=MWu9MZI+Hn4lk0aknUbZFeIMBfL748EC9pjIpCbVfq91/oyyDmRWacp7n+CJxcQus7j2G9fxUy4RUHuMBLTXiKiZ8bJ136FcSFEzDoIxoN4qDdin0cf4j7pUolA1IymWPAatTqZ114JHou1cjSe4Co5iCTYS602GJyuBcD7y8bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745601866; c=relaxed/simple;
	bh=h/G2ZDos76orhTaGgYVhqLoko63afnGC2UUBNcOHYoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jt//BmfvF4rY273wdt36iyRJvk48v8lKAIc5eQa45DkXWBOyprBsl7U44bH7R3llzDIsNSGWtn43C63GoMEX1YefdpksWtkd3DGrvd5PkcM2NDgLXSku6UO2yojtW5Wa2FGYHNgW9cyBxwVg27bLw2/3SUagTozS43cuNDvKs38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Al+jMvOs; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Al+jMvOs"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-875b8e006f8so973576241.0
        for <selinux@vger.kernel.org>; Fri, 25 Apr 2025 10:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745601863; x=1746206663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HInWQhq2MK9fsLHf9EmB6gEoLEFAS7cZs99oqGYQ/WI=;
        b=Al+jMvOs1jiCK+T/XOzKxpXezQALiiodqML/dYzhpu1Rnn+buGqsIIdL90YnEgfFaZ
         JYAeoNKiM12VXb21OYTRakwT0D2IKWkzP50iMFCeYzq0HK9B1TLlcX8dZSXjeCfesm/U
         R29k3dmrCqSbWrn4I1KB4fMwsvvs3aVXd5tWtRcXNU51yXQGu+R04uxCWLftZF2yJFSY
         9mJL4sd7GOw6b+p3gw4jlW8G6jVymy9DyNLaea9S+WBpCDeI2rKWQdUwuixMkp0q3WPf
         NwRHWJSjhzhRl3ux2puPkSl2bJyPFsaQJoYBgQcm/Q/uNrxNML4m6/TFElFik7Dw7xwv
         Lxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745601863; x=1746206663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HInWQhq2MK9fsLHf9EmB6gEoLEFAS7cZs99oqGYQ/WI=;
        b=L7IH7CN/aTtOWYRSVljtflfpqdhRuXi78gR0quasP9BAPoSiRP0HBHX9PuGqr07P3g
         QnLkzCbCqb0qX/0LvVL7PZ4PH70Hzvxs3Pl8Jk/MuLHL5kjG+Z8ebeixsFrGrtD1lcAG
         V2FpFb7+GimnBT9iYn4y5M2PN3IV5b94u9Otwy1SUESCJ87MJjKNbxXVxJvXSQmxJMLo
         81Op8XINQf+8ib0J3I+MAgAV/UVPM5YHLVDjvAOmdf8hQWIHZ1Ptjz/VDrWY1eYVJs+5
         YPOQhHhMCRXqd7v9vcB/Q0yzFp2rqYztDu5yTuVJyFHKGi+lnviosJLVnUUvGq+fYOYM
         ig1g==
X-Gm-Message-State: AOJu0YxiWgwMYNdLvPZJMYZl21XPF1f7RSDkFtukKacAobwPR5zFn6Of
	NKkFakX+STNTqPgjm7eHdqPPcWvDo6d7SNZ8cv4H3lroq+caL9F8hwo2me64T02uiwHQcSCyQy2
	HfKsoAjECC/oOhXrXX+aczX8JLKP4gw==
X-Gm-Gg: ASbGnctpxRu7ukkXoyKd2IMLWfKsypS9bs7omqOIGHD9yhTAxxahc8HgSZT5S3ELS3E
	O8C3OuVSjmCOXkcV+NpKh/ohdpgswYUDJhlU7IvHqg206n+ffzUtKw/e7yiVlsFNe5HPe0Unka4
	tzVqdNOvoOFulFBy8j1CY=
X-Google-Smtp-Source: AGHT+IFEhXByUk9YiLqv6n702Jp+C0bFPCZcg2qiFvkB5//EMkrRXG+JvNXsI+sYZYfpRauO9oEQ2JA830apttvjtJ8=
X-Received: by 2002:a05:6102:3c87:b0:4c1:91da:dac1 with SMTP id
 ada2fe7eead31-4d5439ccaeamr2148195137.6.1745601863222; Fri, 25 Apr 2025
 10:24:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cpbjftpok3lt54s6t7qmhzwbhl47vsz3efrxs45t5os7ztp3zg@tarta.nabijaczleweli.xyz>
 <jxjamggy4xaie53uyfuvriryqj4mtdc7gqr4gmjveyhwoukrxm@tarta.nabijaczleweli.xyz> <CAP+JOzRK1h5haxZCXY5b5X771jyeeM504-m89aPFN2zRCzHkyg@mail.gmail.com>
In-Reply-To: <CAP+JOzRK1h5haxZCXY5b5X771jyeeM504-m89aPFN2zRCzHkyg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Fri, 25 Apr 2025 13:24:12 -0400
X-Gm-Features: ATxdqUHxzplkUJx83gpWM52JX36hqQnlE5UcQo-G6c_J4gFIQyamtbg9Yxq_yHY
Message-ID: <CAP+JOzSmm1DOmggOPygnMqq0BT17eUh=jWMA3pD=xF1ACaEdew@mail.gmail.com>
Subject: Re: [PATCH v3] Inject matchpathcon_filespec_add64() if
 !defined(__INO_T_MATCHES_INO64_T) instead of using __BITS_PER_LONG < 64 as proxy
To: =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc: selinux@vger.kernel.org, Alba Mendez <me@alba.sh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 3:38=E2=80=AFPM James Carter <jwcart2@gmail.com> wr=
ote:
>
> On Thu, Mar 20, 2025 at 11:56=E2=80=AFAM =D0=BD=D0=B0=D0=B1 <nabijaczlewe=
li@nabijaczleweli.xyz> wrote:
> >
> > The __INO_T_MATCHES_INO64_T is defined
> > if ino_t would be the same size as ino64_t
> > if -D_FILE_OFFSET_BITS=3D64 were not defined.
> >
> > This is /exactly/ what
> >   /* ABI backwards-compatible shim for non-LFS 32-bit systems */
> >   #if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && __BI=
TS_PER_LONG < 64
> > is trying to get at, but currently fails because x32/RV32 are "LFS"
> > with 32-bit longs and 64-bit time_ts natively.
> >
> > Thus, the
> >   static_assert(sizeof(unsigned long) =3D=3D sizeof(__ino_t), "inode si=
ze mismatch");
> > assertion fails (__ino_t is the "kernel ino_t" type,
> > which generally corresponds to the kernel's ulong, which is u64 on x32)=
.
> >
> > glibc headers allow us to check the condition we care about directly.
> >
> > Fixes: commit 9395cc0322 ("Always build for LFS mode on 32-bit archs.")
> > Closes: #463
> > Closes: Debian#1098481
> > Signed-off-by: =D0=BD=D0=B0=D0=B1 <nabijaczleweli@nabijaczleweli.xyz>
> > Cc: Alba Mendez <me@alba.sh>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> > Changes from v2: fix build with USE_LFS=3Dn on non-LFS ILP32 systems (i=
386)
> >
> >  libselinux/include/selinux/selinux.h | 2 +-
> >  libselinux/src/matchpathcon.c        | 8 ++++++--
> >  2 files changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/=
selinux/selinux.h
> > index f3cf5a20..f64896b7 100644
> > --- a/libselinux/include/selinux/selinux.h
> > +++ b/libselinux/include/selinux/selinux.h
> > @@ -537,7 +537,7 @@ extern int matchpathcon_index(const char *path,
> >     with the same inode (e.g. due to multiple hard links).  If so, then
> >     use the latter of the two specifications based on their order in th=
e
> >     file contexts configuration.  Return the used specification index. =
*/
> > -#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && __BIT=
S_PER_LONG < 64
> > +#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && !defi=
ned(__INO_T_MATCHES_INO64_T)
> >  #define matchpathcon_filespec_add matchpathcon_filespec_add64
> >  #endif
> >  extern int matchpathcon_filespec_add(ino_t ino, int specind, const cha=
r *file);
> > diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathco=
n.c
> > index 51f0e4ff..a4f65045 100644
> > --- a/libselinux/src/matchpathcon.c
> > +++ b/libselinux/src/matchpathcon.c
> > @@ -261,7 +261,7 @@ int matchpathcon_filespec_add(ino_t ino, int specin=
d, const char *file)
> >         return -1;
> >  }
> >
> > -#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && __BIT=
S_PER_LONG < 64
> > +#if (defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64) && !de=
fined(__INO_T_MATCHES_INO64_T)
> >  /* alias defined in the public header but we undefine it here */
> >  #undef matchpathcon_filespec_add
> >
> > @@ -280,9 +280,13 @@ int matchpathcon_filespec_add(unsigned long ino, i=
nt specind,
> >  {
> >         return matchpathcon_filespec_add64(ino, specind, file);
> >  }
> > +#elif (defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64) || d=
efined(__INO_T_MATCHES_INO64_T)
> > +
> > +static_assert(sizeof(uint64_t) =3D=3D sizeof(ino_t), "inode size misma=
tch");
> > +
> >  #else
> >
> > -static_assert(sizeof(unsigned long) =3D=3D sizeof(ino_t), "inode size =
mismatch");
> > +static_assert(sizeof(uint32_t) =3D=3D sizeof(ino_t), "inode size misma=
tch");
> >
> >  #endif
> >
> > --
> > 2.42.0
