Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECB24B1E5C
	for <selinux@vger.kernel.org>; Tue,  6 May 2025 19:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560030; cv=none; b=dA2C6YFqtdrW/MRh4SxrKoSa07KOnwefeolcnt/Y3hpq7FAA2E78tyODQ9EyIiAcZue/30WLpIxw87FdsA1XAPdpWyi7uLka/QuPbce++FCaSWzdaB9QEfOcMmHp41I8x8m1UDgLNHHSGhIN3TQR85vO7LgwLZqWiFdQsqv29jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560030; c=relaxed/simple;
	bh=qmDYaSaLDiauNBmX8hifsVgEItBCatvxUqtLk7uzoz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lrrr9AtVTNRRhcQlfT4P/G39aZBkx7waoQozDyYj1hJPtvgWvmhDOegsef4kuwDGLhKXquOFKRRYYuTVXehpcUbEg0eL6HuAqx/HP3n+NX7hHGbYUZF+El2hkeP9ehz0GfW+yFfPMGu2M24xNNv/0uqmBnXAtW474VGoGsKvfeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IgItPibb; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IgItPibb"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4c36071916dso1790690137.2
        for <selinux@vger.kernel.org>; Tue, 06 May 2025 12:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746560027; x=1747164827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MzBat54xbZDZ3h9m+VwXYhshLSDMt8bGVoUeHnRaJY=;
        b=IgItPibbTch1qltnPxf7/m343UQGKX3H3mN/YDsUy/JkZbL1CbwfHF29FJSEkCSaIG
         kiqbpYfKYN+uUW5qN4Eqa/0yaBo5dFrhsqzd9HfvnwBthX0CurxpNWO2HLvg5UCd0rXM
         nfU+gvpRuwpfNeXYEYDlfyjQrKJUXNg+u2m+fzfSWNhMuMx8YPh9JB05mGN/Zv+CIgHx
         8nrMeC64dfoCxveOOctRLsRbjAUANeDkwMW/F/QcIYVr/AlOQJuzrzgXGXgt0xE2jWe7
         ry2pun/rQG+GX+e86cMOT+lJ9KYF1HWHDxPtZFH0Y5RAkgAI+Ol+En2JCllrbMrd5ziD
         GxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746560027; x=1747164827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MzBat54xbZDZ3h9m+VwXYhshLSDMt8bGVoUeHnRaJY=;
        b=VYAlVCSw0W7z6URaowPH0wWk0nT65SPZY6rKKUdShrJWuyUiZraqT6atWqtfcpB9Jc
         hQK7QMczWPrt31oJUwyaEoJjOOg/Wo0PUOg4Nuto+rhIPLB0ZAXrSXRSwtx0JA57M9Pl
         HMScKr4RTEHokHGJu+/nr7hGmt+MfUDO/5j4EtI42ag8ajgQJSZ/vIEaBRZik8C2mZZh
         HL/kB++cyOgjsSElosiZARKubWTkB7LiHfTBvqn3qACMLIzrSQeotSGDjViEcmtHj0vc
         sWZJWk85IvlqW270nAKx0bYVUrkzKb0BkJPYYrQpbNCJ4H3d/Xdp/3F3Y/DHR9RebImN
         Dzcg==
X-Gm-Message-State: AOJu0YyFEAOOvrp+uNphNbw5Ik6E+/9rHmzKiC89+KNjgDStbPqp1NRK
	Sh2Gds03GLNNJ1ANFEV5qkPtYIZ/Hv/YqrD92RfKpCpXD35zWgdffJG6FLLnhLWv7RZRg/Zzjfq
	m/nhTgrEB7ikyfjo4ptMaJ0KiinVTmA==
X-Gm-Gg: ASbGncsPN9QrS4KT2j5Epfxc2BOsrPCDn90pz9EGAOJ3CPNbC3hGOi+pRnMH42GB3aG
	0EiHRVNnPVVs/Tl67+JC5WEvei5jlZklzr6Tq65kvGtqsr04W08R7Pd7zK5Qf8qHT4cGm751cxn
	yyEREpXSpYj8MWNHDXIgg=
X-Google-Smtp-Source: AGHT+IF6pY6CRLVk06YK39qTp3FJ0Ksa63H+q2w70sJfsoYjLjW9cXc+rtjhBETsLnYFYetBTHdNlF7zftmeuNkyZvY=
X-Received: by 2002:a05:6102:568d:b0:4c3:221:8f47 with SMTP id
 ada2fe7eead31-4dc737fc793mr711912137.13.1746560027481; Tue, 06 May 2025
 12:33:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250426151356.7116-2-hi@alyssa.is> <CAP+JOzQBaGv=74tNgczpjZVGpzZo93kxnHXO0isL+TzmOc4byg@mail.gmail.com>
In-Reply-To: <CAP+JOzQBaGv=74tNgczpjZVGpzZo93kxnHXO0isL+TzmOc4byg@mail.gmail.com>
From: James Carter <jwcart2@gmail.com>
Date: Tue, 6 May 2025 15:33:36 -0400
X-Gm-Features: ATxdqUEU3Pg9D-NTTdG8JAT4EEirQN_l6cDA2lCNJIjCdhQ0pEDSSXb6RTUU9Tw
Message-ID: <CAP+JOzQA9xgQfS2KUU5kHRTo86iKCNs_6=Mzd5knkiVdr99LjA@mail.gmail.com>
Subject: Re: [PATCH v2] libselinux: be careful with non-portable LFS macro
To: Alyssa Ross <hi@alyssa.is>
Cc: selinux@vger.kernel.org, =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>, 
	Alba Mendez <me@alba.sh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 11:21=E2=80=AFAM James Carter <jwcart2@gmail.com> w=
rote:
>
> On Sat, Apr 26, 2025 at 11:15=E2=80=AFAM Alyssa Ross <hi@alyssa.is> wrote=
:
> >
> > musl does not provide the obsolete LFS64 APIs (like ino64_t) =E2=80=94 =
ino_t
> > has always been 64-bit on all platforms there.  That means there's
> > also no __INO_T_MATCHES_INO64_T macro, meaning the check would pass
> > and reach the static asserts for the shim, which would fail due to
> > there being no ino64_t to check the size of.  Fix this by only
> > assuming the absense of __INO_T_MATCHES_INO64_t is meaningful when
> > another non-portable Glibc macro, __INO64_T_TYPE, is defined.  If both
> > are missing, that probably just means there is no ino64_t.
> >
> > Fixes: 5c3fcbd9 ("Inject matchpathcon_filespec_add64() if !defined(__IN=
O_T_MATCHES_INO64_T) instead of using __BITS_PER_LONG < 64 as proxy")
> > Signed-off-by: Alyssa Ross <hi@alyssa.is>
>
> Acked-by: James Carter <jwcart2@gmail.com>
>

Merged.
Thanks,
Jim

> > ---
> > v2: Made the same change to the condition in the header, as suggested
> >     in a GitHub comment.  The omission didn't seem to break anything,
> >     but it makes sense to change it there too.
> >     https://github.com/NixOS/nixpkgs/pull/391728#issuecomment-283228284=
6
> >
> >  libselinux/include/selinux/selinux.h | 2 +-
> >  libselinux/src/matchpathcon.c        | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/=
selinux/selinux.h
> > index f64896b7..b1431e5d 100644
> > --- a/libselinux/include/selinux/selinux.h
> > +++ b/libselinux/include/selinux/selinux.h
> > @@ -537,7 +537,7 @@ extern int matchpathcon_index(const char *path,
> >     with the same inode (e.g. due to multiple hard links).  If so, then
> >     use the latter of the two specifications based on their order in th=
e
> >     file contexts configuration.  Return the used specification index. =
*/
> > -#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && !defi=
ned(__INO_T_MATCHES_INO64_T)
> > +#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 && defin=
ed(__INO64_T_TYPE) && !defined(__INO_T_MATCHES_INO64_T)
> >  #define matchpathcon_filespec_add matchpathcon_filespec_add64
> >  #endif
> >  extern int matchpathcon_filespec_add(ino_t ino, int specind, const cha=
r *file);
> > diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathco=
n.c
> > index a4f65045..240c9fa7 100644
> > --- a/libselinux/src/matchpathcon.c
> > +++ b/libselinux/src/matchpathcon.c
> > @@ -261,7 +261,7 @@ int matchpathcon_filespec_add(ino_t ino, int specin=
d, const char *file)
> >         return -1;
> >  }
> >
> > -#if (defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64) && !de=
fined(__INO_T_MATCHES_INO64_T)
> > +#if (defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64) && def=
ined(__INO64_T_TYPE) && !defined(__INO_T_MATCHES_INO64_T)
> >  /* alias defined in the public header but we undefine it here */
> >  #undef matchpathcon_filespec_add
> >
> >
> > base-commit: 2647cc0fdca326b81ee3c08718cbe19b7866b53a
> > --
> > 2.47.2
> >
