Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6AA4C954B
	for <selinux@vger.kernel.org>; Tue,  9 Jun 2026 19:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781031937; cv=pass; b=jsWqEDSz98mLxAZbjDbCxTGWozjBXNZ3WQaFIgvpdL//cHdKDg48iFrz6IA3MawAZrg9Q/R/cIbdTUe6RMf8XPIV4eO4Vpj6VxDyWTvhvkNZWtM6ci0/F/EXKXIHZmpHDx9xfPmhUoVCFy5AdqpBUHJq2eBbTcqBi9/l8Hud4wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781031937; c=relaxed/simple;
	bh=o59A+io0BQ8CzcdjLSWja2kOuoolpqyu9ezLyF6Bic4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMorXEXQj260sDOb5/Gdg/mvdSdmxLh/cJzymdiuwIKnUhjcdgc+6Jxqu8gYJxblIOVj9GfW6YnaCdt5AZFqW4XTWDvKPXru7Go7MJ55WmqA+rv00vl2j4J4Y9hu5V9Uz5KIU21+wDQGKX1X+m220t1gSR4myn2KgfuwfQAvDnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpMOYyAR; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpMOYyAR"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c85b73ffb52so2509148a12.3
        for <selinux@vger.kernel.org>; Tue, 09 Jun 2026 12:05:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781031935; cv=none;
        d=google.com; s=arc-20240605;
        b=GPPjXcBfT3Le0o3ZHeMe51iDv717Irs0s3MOqh9yo3SGSursHSeUbPbyk/wOLJqG+m
         GWpz9GhC6xwNJtpxebHLoi+6IW15ph6rSmzFFKssF+ayRGkiqJz7Xmyp+4ie98bmGTLH
         fMXHHljT/IPta6aTsx39otM2yDuDLyI2lllZwel3HNsGLEvhFe6zwESWZq97mh4CGJnS
         WtF1vvDzmTJaHxggBqb4H+X6IYV0CLVhvMeqUi5G4j9xvSDD8aVQy39ZCR3Traskrpi0
         C++/+0xbC9OtbbHW3vY47xOqBFW1I0lUWAbEi3OQ9xmcNy3PkJ0St9MXNzMItQge3qlO
         Emkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Sq4ZtLWpYiQJrggwpCQXRYTq+JfCiG1JyBYIbmkZe7Q=;
        fh=BSYX5pFzsnodderZ6Fagt5SM/AxwelMKdQExzIDWKBo=;
        b=YTGHlkc4NnE/eFx3y8N7xl0JkrzzSxC+a8cGc8Jdqi2UCyOd6nf23NygvGGSY9CiLD
         5kWumpfZGV0kEXoHrQ/EKy2QdubqTiv0LOB+Chg96+iN7v7s2XilI7drfxa6ZQeqY4h8
         eWLZQOlioN4GqSg7XQ3QwiuIEuJ8QpGu4a/z+WFmwCTvfabrGK3urBWkZrPOs98sWI6U
         o0oReUDY07T17CKzn1C/x+c/iWRx15+9y3QLYfGhG10vivsdf6P8itc/Zd6Hq0Wh9+ne
         QSEYmeZ1vfITFzew97+IdfbByG33s2rxRAw3zV1yrKBvqA0H3kwyZvCh69ho31kWxQIk
         FU0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781031935; x=1781636735; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sq4ZtLWpYiQJrggwpCQXRYTq+JfCiG1JyBYIbmkZe7Q=;
        b=YpMOYyARBTjZY6XVqC+Jm/7axcuwpJfzhAXfiFZt/aNgGY3bj9Io9YkI5gSIhh7CxB
         YJC7Zb0GOl3o0zTO2cr0nz9Z+uX8kUxDL9Yh6i/Xch2E6BLHc5QhLs5Es78toA1PMxMi
         nOkIeI5lxnSKGP+9ZR6QPMhDWi6wYoMyC3iFf/xnOvj/oV1G4OOzMuIJ7L89JIPm2LR/
         Eb7ICHgEKjoiUfV7T3B+BftZ96GUqFHetUJKAUfZdTSgQ7yzS3b+/LXc+xYURQx0jPkn
         7YLDEJuEaMi2XI+5zHu71I7nKIaqDZOWLwGD+ejgVyqXfNcxbkcvF6/T5AAr9xmw47jx
         kcPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781031935; x=1781636735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Sq4ZtLWpYiQJrggwpCQXRYTq+JfCiG1JyBYIbmkZe7Q=;
        b=H4rkVc45fMwqegQ59ih/koJm4xWl4im4oBE3Nps1SBL1LZdkvSjprSfIQHc4rwZvRc
         S/IWrjqVDV2D5jvjgFNs22hvQ8sMuoyDcpkYNtpEQis2/bLzwY0vSZSNkg+rshIaJCLY
         Dw7RYpNp2Qh1L+j5wNsXeALbbTaV4hgNtF3Z/OBxd+APO10Gbw5UZeXVZ2OHIM0xGhFD
         bRf3km8zrjrdrEPK0aLbptIhaKAJ05p3f+9OYo0W1yGgW+YAoqiYWmrMzetmwauDANMu
         bInHREHRxUkANezH7gj9G34gO6r91xtqORgRNk6aE483CtkjY0GIv4rusD1W0h8icZkk
         VBsQ==
X-Gm-Message-State: AOJu0Yw1nK1q8cIOLz1SDqwxFqhb2wxdVSdazGtLq8WupvZzXCls3q4v
	f+iHys9Y5UqE22LNDKivxlm/nZksAdAB70B+w0B+SlPSDHv9gaLVLY3kjQwrI1/dp9KmnQi0XLu
	1G+KYwkZjKW3tTkA56yrPtNkg13cct0k=
X-Gm-Gg: Acq92OG5P5a8JirZHtQULoyG/n3mXzJtqB5NOKV2A7SVb/Y4kdEmLeDhmHu1HxnjQbu
	2pSyokIR1V9jyFrjnHdf/Bcq5HqnTgNf/2a73k1iB05f9PAtchc/WRBCANsAWYT4IF4DxEJd7fJ
	fb41eso2VgYz7VIm1G/RMLZ0cr358ybYpDNSw1VL2tePRZffqK2Lui0KqpIDtImhO7hs/lbNGrC
	d81qC+0u+FMlpMq/M1fBwZdZrBWsC68po5LvBkY0Hy8zsccuQTHE9le57MNe+BAUAJMS48gA5Ni
	IwGsmYICPrMOUGvMqSEIQgugIf1G
X-Received: by 2002:a05:6a20:1c8f:b0:398:6ea8:21f7 with SMTP id
 adf61e73a8af0-3b4ccd66679mr24878752637.15.1781031934964; Tue, 09 Jun 2026
 12:05:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHLDejxCCVr1kH7JNFnvQM+ct6_mn89rAc+OdVbLaP=cCNkbeA@mail.gmail.com>
 <CAEjxPJ7f6Qb3Yg9Yx3Yuog5jwsg0bD2OEidDnR0U1o9HOj7QCA@mail.gmail.com>
In-Reply-To: <CAEjxPJ7f6Qb3Yg9Yx3Yuog5jwsg0bD2OEidDnR0U1o9HOj7QCA@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Tue, 9 Jun 2026 15:05:22 -0400
X-Gm-Features: AVVi8CcnDhq0WIiyxDzwRo5VfzUm_Qv26I2_3277UP7eJhA7laasvGBy8Pe6B3A
Message-ID: <CAEjxPJ7pF7f0uXXU50ECRKr2a4qXBipiGM49Tj0CSmkudcYBag@mail.gmail.com>
Subject: Re: [PATCH] define matchpathcon_filespec_add/add64
To: Pepper Gray <hello@peppergray.xyz>, Petr Lautrbach <lautrbach@redhat.com>, 
	James Carter <jwcart2@gmail.com>, "hi@alyssa.is" <hi@alyssa.is>, nabijaczleweli@nabijaczleweli.xyz
Cc: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 10:43=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, May 7, 2026 at 5:53=E2=80=AFAM Pepper Gray <hello@peppergray.xyz>=
 wrote:
> >
> > From ce907fb1daa4d165b29f2d91b3d0958e2eb7f044 Mon Sep 17 00:00:00 2001
> > From: Pepper Gray <hello@peppergray.xyz>
> > Date: Sat, 11 Apr 2026 15:55:17 +0200
> > Subject: [PATCH] define matchpathcon_filespec_add/add64
> >
> > matchpathcon_filespec_add and matchpathcon_filespec_add64 are
> > exported in libselinux.map, so both need to be linker-visible
> > symbols
> >
> > fix: #512
> > Signed-off-by: Pepper Gray <hello@peppergray.xyz>
>
> I've added several people who have touched these definitions/code
> recently in hopes of getting more insight.
> Setting aside the whitespace damage in your patch, I am not clear if
> this is the right fix.
> commit 9395cc03226a0e1a ("Always build for LFS mode on 32-bit archs.")
> introduced matchpathcon_filespec_add64() and the #define to
> transparently remap API (but not ABI) calls from
> matchpathcon_filespec_add().
> Would appreciate clarification from the originator of that commit on
> how/if this change would affect the intent there.

Before your patch, on x86_64:
$ nm src/libselinux.so.1 | grep matchpathcon_filespec_add
00000000000175e8 T matchpathcon_filespec_add

After your patch, on x86_64:
$ nm src/libselinux.a | grep matchpathcon_filespec_add
00000000000006c0 T matchpathcon_filespec_add
000000000000096b T matchpathcon_filespec_add64

commit 9395cc03226a0e1a ("Always build for LFS mode on 32-bit archs.")
says it is maintaining the type signature of
matchpathcon_file_spec_add() on 32-bit but mapping the API to a new
matchpathcon_filespec_add64() entrypoint that takes a 64-bit ino_t
argument instead. But there is no reason to expose the new entrypoint
on 64-bit archs.

>
> > ---
> >  libselinux/include/selinux/selinux.h |  4 +---
> >  libselinux/src/matchpathcon.c        | 17 ++++++-----------
> >  2 files changed, 7 insertions(+), 14 deletions(-)
> >
> > diff --git a/libselinux/include/selinux/selinux.h
> > b/libselinux/include/selinux/selinux.h
> > index b1431e5d0d..241bb54a94 100644
> > --- a/libselinux/include/selinux/selinux.h
> > +++ b/libselinux/include/selinux/selinux.h
> > @@ -537,10 +537,8 @@ extern int matchpathcon_index(const char *path,
> >     with the same inode (e.g. due to multiple hard links).  If so, then
> >     use the latter of the two specifications based on their order in th=
e
> >     file contexts configuration.  Return the used specification index. =
*/
> > -#if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64 &&
> > defined(__INO64_T_TYPE) && !defined(__INO_T_MATCHES_INO64_T)
> > -#define matchpathcon_filespec_add matchpathcon_filespec_add64
> > -#endif
> >  extern int matchpathcon_filespec_add(ino_t ino, int specind, const cha=
r *file);
> > +extern int matchpathcon_filespec_add64(ino_t ino, int specind, const
> > char *file);
> >
> >  /* Destroy any inode associations that have been added, e.g. to restar=
t
> >     for a new filesystem. */
> > diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathco=
n.c
> > index 240c9fa76d..df4cabf597 100644
> > --- a/libselinux/src/matchpathcon.c
> > +++ b/libselinux/src/matchpathcon.c
> > @@ -261,25 +261,20 @@ int matchpathcon_filespec_add(ino_t ino, int
> > specind, const char *file)
> >   return -1;
> >  }
> >
> > +int matchpathcon_filespec_add64(unsigned long ino, int specind,
> > +                              const char *file)
> > +{
> > + return matchpathcon_filespec_add(ino, specind, file);
> > +}
> > +
> >  #if (defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64) &&
> > defined(__INO64_T_TYPE) && !defined(__INO_T_MATCHES_INO64_T)
> > -/* alias defined in the public header but we undefine it here */
> > -#undef matchpathcon_filespec_add
> >
> >  /* ABI backwards-compatible shim for non-LFS 32-bit systems */
> > -
> >  static_assert(sizeof(unsigned long) =3D=3D sizeof(__ino_t), "inode siz=
e mismatch");
> >  static_assert(sizeof(unsigned long) =3D=3D sizeof(uint32_t), "inode si=
ze
> > mismatch");
> >  static_assert(sizeof(ino_t) =3D=3D sizeof(ino64_t), "inode size mismat=
ch");
> >  static_assert(sizeof(ino64_t) =3D=3D sizeof(uint64_t), "inode size mis=
match");
> >
> > -extern int matchpathcon_filespec_add(unsigned long ino, int specind,
> > -                                     const char *file);
> > -
> > -int matchpathcon_filespec_add(unsigned long ino, int specind,
> > -                              const char *file)
> > -{
> > - return matchpathcon_filespec_add64(ino, specind, file);
> > -}
> >  #elif (defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64) ||
> > defined(__INO_T_MATCHES_INO64_T)
> >
> >  static_assert(sizeof(uint64_t) =3D=3D sizeof(ino_t), "inode size misma=
tch");
> >
