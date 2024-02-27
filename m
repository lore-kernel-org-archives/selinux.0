Received: from becquer.dodds.net (becquer.dodds.net [207.224.24.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE26753804
	for <selinux@vger.kernel.org>; Tue, 27 Feb 2024 07:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.224.24.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709017219; cv=none; b=ZVgCaf7iuf27O4ft3fnUaMMIBe3shviNN/mGZRTmDIFFeND/P6e0RSoQUKuv0I35p8OMPhUmuaFGj5QEsUJiHD4vweMNTFd8qayWf3FZlsDuKRO1XJSb3bFkVk1Jy+p/WXXSyCBiAGD48h/ARs2h9YoaXTVOWTaZg6XngZYRLBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709017219; c=relaxed/simple;
	bh=U9M+Izi4WOaql667k2MCwFXDfJfDNl74l0rfee2kOB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Coy0TRfBM0UY099qa5x3y1yg+Ti0VerLbSXold7JapF0ryyo0gPf+rDdmJpbAT6TSmuQSAJhnGdmeRvA2NlIlh8zEYgn2uFJlrIKLmau3VdKp7QUY1nfaW4DPJpl9eIlMGI2FWqJW3FCCcwkw27dvEbeKQaGslSZZTrDEqSdZtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=DFWLjH00; arc=none smtp.client-ip=207.224.24.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="DFWLjH00"
Received: from homer.dodds.net (homer.local [192.168.15.41])
	by becquer.dodds.net (Postfix) with ESMTPSA id E92E124FEF;
	Mon, 26 Feb 2024 23:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=debian.org;
	s=debian1.vorlon.user; t=1709017202;
	bh=U9M+Izi4WOaql667k2MCwFXDfJfDNl74l0rfee2kOB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DFWLjH00JBhPM6b0CCEbuuPgZB5AyiircIediUszBsN32vToDzy/V9ARYnGqSbFER
	 wZsS6w5tlD6js1616JUlfJVxF8ErEhWHFjBhA3PMX/UgniXCXahG4d1e3tnioj0bpl
	 cgWS1yU26XwIBTFF5xhx4hrQ1hjfv7OLYgJS+jJYDpozvX/GZtRHT0b2nrhj6fabKz
	 FLNI490EGqHJ5Uhu8cO9C3+iErYw0wCCgLHPhmD8+bQOzplnV+K/DXnoyW0uRFmmGP
	 x9YlIM9H+m10/OG3hyTdNiCIIJmm+7yJD8F6aFrVlnGdqfhtvpBlN3iBiARm/yHTVY
	 CJbzZ7M8GkT9w==
Received: by homer.dodds.net (Postfix, from userid 1000)
	id 3C1D21308; Mon, 26 Feb 2024 23:00:00 -0800 (PST)
Date: Mon, 26 Feb 2024 23:00:00 -0800
From: Steve Langasek <vorlon@debian.org>
To: Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc: James Carter <jwcart2@gmail.com>, selinux@vger.kernel.org
Subject: Re: [PATCH] Always build for LFS mode on 32-bit archs.
Message-ID: <Zd2IcMMLagkTZGJp@homer.dodds.net>
References: <20240216003252.29057-1-steve.langasek@canonical.com>
 <Zc6tzKPsYZRICHya@homer.dodds.net>
 <202402171351.439742DA@keescook>
 <ZdF0no51QNtKq8Ri@homer.dodds.net>
 <Zdrh/euXdvdWlVSp@homer.dodds.net>
 <CAJ2a_DeQFFgo+b6xf3_79bsfsvWeGWOephtgsJTK+RxJ7epG4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u2gNDT5pQb6mGEw1"
Content-Disposition: inline
In-Reply-To: <CAJ2a_DeQFFgo+b6xf3_79bsfsvWeGWOephtgsJTK+RxJ7epG4Q@mail.gmail.com>


--u2gNDT5pQb6mGEw1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback.

On Mon, Feb 26, 2024 at 06:52:10PM +0100, Christian G=F6ttsche wrote:
> > > +#include <stdint.h>

> I needed <asm/bitsperlong.h> aswell for __BITS_PER_LONG

Can you tell me about the platform you were building on?  In my tests, the
code with this patch behaved as intended on Ubuntu 24.04 pre-release with
glibc 2.38, on both armhf and amd64, with no additional includes required.

> > > +#if _FILE_OFFSET_BITS =3D=3D 64

> One should probably check for existence:

> #if defined(_FILE_OFFSET_BITS) && _FILE_OFFSET_BITS =3D=3D 64

Should we not consider it an error if this is not defined?  I can't think of
any reason why _FILE_OFFSET_BITS would legitimately be missing and in my
view it's ambiguous what we should do in this circumstance.  Using the
define without checking for existence first implicitly gives an error if
it's missing.  If preferred, we could be explicit as in:

#if !defined(_FILE_OFFSET_BITS)
#error [...]
#endif
#if _FILE_OFFSET_BITS =3D=3D 64
[...]

> > > +typedef uint64_t libselinux_ino_t;
> > > +#if __BITS_PER_LONG < 64
> > > +#define matchpathcon_filespec_add matchpathcon_filespec_add64
> > > +#endif
> > > +#else
> > > +typedef uint32_t libselinux_ino_t;
> > > +#endif

> Is the typedef libselinux_ino_t really necessary, isn't it always just
> equal to ino_t?

When _FILE_OFFSET_BITS =3D=3D 64, ino_t is a 64-bit type and we need to
explicitly declare a 32-bit type for the compatibility interface.  From
sys/stat.h:

# ifndef __ino_t_defined
#  ifndef __USE_FILE_OFFSET64
typedef __ino_t ino_t;
#  else
typedef __ino64_t ino_t;
#  endif
#  define __ino_t_defined
# endif

> > > +extern int matchpathcon_filespec_add(libselinux_ino_t ino, int speci=
nd, const char *file);
> > >
> > >  /* Destroy any inode associations that have been added, e.g. to rest=
art
> > >     for a new filesystem. */
> > > diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> > > index d3b981fc..267291aa 100644
> > > --- a/libselinux/src/Makefile
> > > +++ b/libselinux/src/Makefile
> > > @@ -87,6 +87,7 @@ CFLAGS ?=3D -O -Wall -W -Wundef -Wformat-y2k -Wform=
at-security -Winit-self -Wmissi
> > >            -fstack-protector-all --param=3Dssp-buffer-size=3D4 -fexce=
ptions \
> > >            -fasynchronous-unwind-tables -fdiagnostics-show-option \
> > >            -Werror -Wno-aggregate-return \
> > > +          -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=3D64 \

> This won't work if CFLAGS are customized during build (e.g. by dpkg).
> Also utils/ is unaffected.
> Maybe use something like:

> libselinux/Makefile:
>=20
> USE_LFS ?=3D y
> export USE_LFS
>=20
> libselinux/{src,utils}/Makefile:
>=20
> ifeq ($(USE_LFS),y)
>        override CFLAGS +=3D -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=3D64
> endif

Thanks, I'm happy to amend the patch to do that (but will wait to converge
on the other points above before I resubmit).

I was largely unconcerned about the case of dpkg overriding it since, going
forward, dpkg would always be overriding it in the direction we wanted.  But
build systems for other distros may do otherwise and in that sense I agree
we should make it resistant to accidental clobbering.

> > > --- a/libselinux/src/libselinux.map
> > > +++ b/libselinux/src/libselinux.map
> > > @@ -251,4 +251,5 @@ LIBSELINUX_3.5 {
> > >    global:
> > >      getpidprevcon;
> > >      getpidprevcon_raw;
> > > +    matchpathcon_filespec_add64;
> > >  } LIBSELINUX_3.4;

> For downstream this seems fine, for upstream this should go into a new
> LIBSELINUX_3.6 section.

For me the ideal outcome is bidirectional ABI compatibility with upstream,
which means agreeing on the symbol version in advance before I upload this.=
=20
For purposes of the upstream submission I'm happy to set this to
LIBSELINUX_3.6 (yes, obviously it wouldn't be LIBSELINUX_3.5 anymore since
that ABI is already fixed).  Barring a committment to land this change as
part of LIBSELINUX_3.6, my inclination for the downstream change this week
would be to leave it as an unversioned symbol so that consumers would be
forwards-compatible with later upstream inclusion regardless of the symbol
version used.

> > > diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpath=
con.c
> > > index e44734c3..189e00fb 100644
> > > --- a/libselinux/src/matchpathcon.c
> > > +++ b/libselinux/src/matchpathcon.c
> > > @@ -195,7 +195,8 @@ static file_spec_t *fl_head;
> > >   * then use the specification that occurs later in the
> > >   * specification array.
> > >   */
> > > -int matchpathcon_filespec_add(ino_t ino, int specind, const char *fi=
le)
> > > +int matchpathcon_filespec_add(libselinux_ino_t ino, int specind,
> > > +                              const char *file)
> > >  {
> > >       file_spec_t *prevfl, *fl;
> > >       int h, ret;
> > > @@ -261,6 +262,18 @@ int matchpathcon_filespec_add(ino_t ino, int spe=
cind, const char *file)
> > >       return -1;
> > >  }
> > >
> > > +#if _FILE_OFFSET_BITS =3D=3D 64 && __BITS_PER_LONG < 64
> > > +/* alias defined in the public header but we undefine it here */
> > > +#undef matchpathcon_filespec_add
> > > +
> > > +/* ABI backwards-compatible shim for non-LFS 32-bit systems */

> Missing extern declaration to avoid a missing-prototype warning.

Ack - will fix.

> > > +int matchpathcon_filespec_add(unsigned long ino, int specind,

> Are there 32-bit architectures we like to support where unsigned long
> is not 4 (but 8) bytes in size?

I am not aware of any.=20
https://en.wikipedia.org/wiki/LP64#64-bit_data_models discusses the various
combinations of 32-bit and 64-bit types that are known to have been used,
and while there are configurations that use a 64-bit pointer with a 32-bit
long there are no examples shown for configurations that do the opposite.

--=20
Steve Langasek                   Give me a lever long enough and a Free OS
Debian Developer                   to set it on, and I can move the world.
Ubuntu Developer                                   https://www.debian.org/
slangasek@ubuntu.com                                     vorlon@debian.org

--u2gNDT5pQb6mGEw1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErEg/aN5yj0PyIC/KVo0w8yGyEz0FAmXdiGkACgkQVo0w8yGy
Ez3ENhAAlFyjtr+wMq+4zkY6ccjuUDlxNMH2IG5spP6Ff/AGjnDEccnyLmi202p5
waKrsxQoQbxFKQP/gvVYWDjLqvDLDy5R/bL1vS2REX6P6VJ0UoLDr4v9kis8VENq
yj0VleTspFjcxJqEbO2NVdOHDnMY7uWi5GW3Aa4dZ8aGBTTNaoKsxALsSb7WHnvP
HJuK+KzwdmnpHcHUbLyhS4VI0kztYgXjx61Xxk2m4qBAAcdNqIruOfDd8lek2dma
U8vrgSOplDteyrCGW6vJuF3jaEgTkrtVJjMdM+tLxsF2VDcSaY1nMfvSRuTuV2cL
1HaKLu+SJ5GnFhEYRMYt9ptOtpSjOeCz840Why4SAjoNERxJyw0nLenamD+Zs8oO
KlV+fLumLbEpmdyKt4+2E2bzuEK9lt6PTvXLhluhHrOWSFxhxZvscyfn2c4El/LE
XxnUDmcYy2yEueMjPbZOT0WNl6R9s3bH8lCDqDl7h406Q5xlWwYXAoPxbccN2dYq
2LObhMWBnrXRXGyiXPow4gJSnbT4ChfxGq5s2ZkBKG3xhzuQDzJM7Emo0HMbkuSW
gznpxkvvdZCuVKdJVjQU4o1+/04gXsZ3BkN7LpQWaCPZesz3vSodiqTlpFGnS8+x
wfWE/SLCySwQEX7tL7JT5GWNjAnhqfNdb8Vxnq5eoAMC4xd3PO8=
=XVrH
-----END PGP SIGNATURE-----

--u2gNDT5pQb6mGEw1--
