Received: from becquer.dodds.net (becquer.dodds.net [207.224.24.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98A7D520
	for <selinux@vger.kernel.org>; Sun, 25 Feb 2024 06:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.224.24.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708843910; cv=none; b=oJjOc9T+1dxKL7DiBxwK8V7TkTBwAoOLwmdgqZYwiPBAO8zjVc/2lwUkGAV1MEElpwGuSqZWqNNgL/Xv4be3B4gHDzNbwpkWWNXZegl5YDV8n/zGp+zrFm86ZTpmHlf1i85Xgijw5mYXMAui5YD6o1TwRr5vlIEAtvZXpp0nRmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708843910; c=relaxed/simple;
	bh=ZwPa+dNR2WzNOOfDgQT9KFcMD5/8wka0vdglaxb65tU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0GpKqHsE3OJiSEyS2aqb4Znk9+xq4jnBacCVpajJI1B9xBQxZbcyHFp9VdRdh2lEV5lIDRDKMET7Gwq7COKaPdaY10O6iqatJoyNWFopNYtWeudJeVkN7GDodcMJdebo+70z4or+hrDjS0kdA4wks/yOtZ7zCsh2LM8HXBeatA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=dOtw+XQP; arc=none smtp.client-ip=207.224.24.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="dOtw+XQP"
Received: from homer.dodds.net (homer.local [192.168.15.41])
	by becquer.dodds.net (Postfix) with ESMTPSA id 7C94724FEF;
	Sat, 24 Feb 2024 22:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=debian.org;
	s=debian1.vorlon.user; t=1708843518;
	bh=ZwPa+dNR2WzNOOfDgQT9KFcMD5/8wka0vdglaxb65tU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dOtw+XQPn/xxYnVkRBBxbdDt9YMX2l6peR2m0PQBtFbBSMBDqnxoNR1apaqu1Gs8Y
	 ZfCN6xY4vSgrzw5GHPhyuCmZyqaX+Ze8cHaJwFAXcRq+weTY9qpj6a8M9FQ8GsViC0
	 sQvqJC8pWlrrzzUcmF5XmknAy3dHAiD+xL10TtrK82VlJLkr0GwxnSatO8gdcvnq9n
	 sK24hIoLSVO3gvELakhx7XkeC4Tndx4+A78DWrfbsgJISl1wp/UbID4A7kuz3KBuPM
	 fGjDG3Sfpnv+W7bgLNiowme/RTy3KOkCR7mUG/5pKZn/p/gvG1aO2VGicU/YJ6M0JK
	 UA21akrng7fkA==
Received: by homer.dodds.net (Postfix, from userid 1000)
	id 81ADDD74; Sat, 24 Feb 2024 22:45:17 -0800 (PST)
Date: Sat, 24 Feb 2024 22:45:17 -0800
From: Steve Langasek <vorlon@debian.org>
To: James Carter <jwcart2@gmail.com>,
	Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
	selinux@vger.kernel.org
Cc: selinux@vger.kernel.org
Subject: Re: [PATCH] Always build for LFS mode on 32-bit archs.
Message-ID: <Zdrh/euXdvdWlVSp@homer.dodds.net>
References: <20240216003252.29057-1-steve.langasek@canonical.com>
 <Zc6tzKPsYZRICHya@homer.dodds.net>
 <202402171351.439742DA@keescook>
 <ZdF0no51QNtKq8Ri@homer.dodds.net>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v2uurtVl/i/kq5hu"
Content-Disposition: inline
In-Reply-To: <ZdF0no51QNtKq8Ri@homer.dodds.net>


--v2uurtVl/i/kq5hu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Adding James and Christian directly to the email, as frequent contributors
to libselinux, for visibility.

Debian and Ubuntu are going to have to do something with libselinux within
the week, and I'd greatly prefer that the "something" not be breaking ABI
compatibility with upstream.

Thanks,
--=20
Steve Langasek                   Give me a lever long enough and a Free OS
Debian Developer                   to set it on, and I can move the world.
Ubuntu Developer                                   https://www.debian.org/
slangasek@ubuntu.com                                     vorlon@debian.org

On Sat, Feb 17, 2024 at 07:08:14PM -0800, Steve Langasek wrote:
> From b23c9044b542b8807f57f4691f4bd1149cbee04c Mon Sep 17 00:00:00 2001
> From: Steve Langasek <steve.langasek@canonical.com>
> Date: Thu, 15 Feb 2024 15:22:45 -0800
> Subject: [PATCH] Always build for LFS mode on 32-bit archs.
>=20
> Maintains the type signature of the existing matchpathcon_filespec_add()
> entry point on 32-bit archs but maps the API to a new
> matchpathcon_filespec_add64() entry point that takes a 64-bit ino_t argum=
ent
> instead.
>=20
> Software on 32-bit Linux ports which historically use a 32-bit time_t (th=
us
> affected by the y2038 problem) have, as a precondition of migrating to
> 64-bit time_t, that they also migrate to large filesystem support because
> glibc does not provide entry points for the cross-product of
> (LFS: yes, LFS: no) x (time_t: 32, time_t: 64).
>=20
> In order to support smooth migration of such operating systems from 32-bit
> time_t to 64-bit time_t, it is useful for libselinux to:
>=20
> - provide entry points on 32-bit systems for both LFS and non-LFS variants
>   of the API (as glibc itself does)
> - use LFS internally for all filesystem calls (just in case)
> - map the API call to the correct implementation based on the build
>   environment of the caller.
>=20
> Signed-off-by: Steve Langasek <steve.langasek@canonical.com>
> ---
>  libselinux/include/selinux/selinux.h | 11 ++++++++++-
>  libselinux/src/Makefile              |  1 +
>  libselinux/src/libselinux.map        |  1 +
>  libselinux/src/matchpathcon.c        | 15 ++++++++++++++-
>  4 files changed, 26 insertions(+), 2 deletions(-)
>=20
> diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/se=
linux/selinux.h
> index a0948853..040629c3 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -1,6 +1,7 @@
>  #ifndef _SELINUX_H_
>  #define _SELINUX_H_
> =20
> +#include <stdint.h>
>  #include <sys/types.h>
>  #include <stdarg.h>
> =20
> @@ -521,7 +522,15 @@ extern int matchpathcon_index(const char *path,
>     with the same inode (e.g. due to multiple hard links).  If so, then
>     use the latter of the two specifications based on their order in the=
=20
>     file contexts configuration.  Return the used specification index. */
> -extern int matchpathcon_filespec_add(ino_t ino, int specind, const char =
*file);
> +#if _FILE_OFFSET_BITS =3D=3D 64
> +typedef uint64_t libselinux_ino_t;
> +#if __BITS_PER_LONG < 64
> +#define matchpathcon_filespec_add matchpathcon_filespec_add64
> +#endif
> +#else
> +typedef uint32_t libselinux_ino_t;
> +#endif
> +extern int matchpathcon_filespec_add(libselinux_ino_t ino, int specind, =
const char *file);
> =20
>  /* Destroy any inode associations that have been added, e.g. to restart
>     for a new filesystem. */
> diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
> index d3b981fc..267291aa 100644
> --- a/libselinux/src/Makefile
> +++ b/libselinux/src/Makefile
> @@ -87,6 +87,7 @@ CFLAGS ?=3D -O -Wall -W -Wundef -Wformat-y2k -Wformat-s=
ecurity -Winit-self -Wmissi
>            -fstack-protector-all --param=3Dssp-buffer-size=3D4 -fexceptio=
ns \
>            -fasynchronous-unwind-tables -fdiagnostics-show-option \
>            -Werror -Wno-aggregate-return \
> +          -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=3D64 \
>            $(EXTRA_CFLAGS)
> =20
>  LD_SONAME_FLAGS=3D-soname,$(LIBSO),--version-script=3Dlibselinux.map,-z,=
defs,-z,relro
> diff --git a/libselinux/src/libselinux.map b/libselinux/src/libselinux.map
> index 5e00f45b..88c9b3e5 100644
> --- a/libselinux/src/libselinux.map
> +++ b/libselinux/src/libselinux.map
> @@ -251,4 +251,5 @@ LIBSELINUX_3.5 {
>    global:
>      getpidprevcon;
>      getpidprevcon_raw;
> +    matchpathcon_filespec_add64;
>  } LIBSELINUX_3.4;
> diff --git a/libselinux/src/matchpathcon.c b/libselinux/src/matchpathcon.c
> index e44734c3..189e00fb 100644
> --- a/libselinux/src/matchpathcon.c
> +++ b/libselinux/src/matchpathcon.c
> @@ -195,7 +195,8 @@ static file_spec_t *fl_head;
>   * then use the specification that occurs later in the
>   * specification array.
>   */
> -int matchpathcon_filespec_add(ino_t ino, int specind, const char *file)
> +int matchpathcon_filespec_add(libselinux_ino_t ino, int specind,
> +                              const char *file)
>  {
>  	file_spec_t *prevfl, *fl;
>  	int h, ret;
> @@ -261,6 +262,18 @@ int matchpathcon_filespec_add(ino_t ino, int specind=
, const char *file)
>  	return -1;
>  }
> =20
> +#if _FILE_OFFSET_BITS =3D=3D 64 && __BITS_PER_LONG < 64
> +/* alias defined in the public header but we undefine it here */
> +#undef matchpathcon_filespec_add
> +
> +/* ABI backwards-compatible shim for non-LFS 32-bit systems */
> +int matchpathcon_filespec_add(unsigned long ino, int specind,
> +                              const char *file)
> +{
> +	return matchpathcon_filespec_add64(ino, specind, file);
> +}
> +#endif
> +
>  /*
>   * Evaluate the association hash table distribution.
>   */
> --=20
> 2.40.1
>=20

--v2uurtVl/i/kq5hu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErEg/aN5yj0PyIC/KVo0w8yGyEz0FAmXa4fYACgkQVo0w8yGy
Ez1Vjw/+PNw2reMw7YoMSzvj5/dGoMWVf83ZU60n0H3p+eEFpNX0QKgqWyJLBToe
czvXwyC0pi1McVeVD9xmlDtBQ/fzJcxDeI0ZouFitlAmjxq6MLEn85hefeLbO4Mz
AsG5weZhyoCNF+TKhpGfsy5nFSANk7ouKgf28GiMKEkQv9Ku3JUqAmQTsMYE1xnW
efH8Aavx7DLeesKtmQL80HiGvPIrI3VWUdf18hs0elnfVmxXtZvbXRndiBTtElHs
ln06IN8J9/PFmLAwovxRc+qk6CmV8UrkNkpufKwyJz3zLb2Kn5Kql7Uy3jdzpgAM
2/ckcG3UKzTnJx1jFPMD+XXoDdYtYW8mS52hYx/om6bcnB0tflsTeG1TCxUkMUC3
be+FJSQ8LqZ67qGxaOmRuIVx1yJGWHG7qrdxbi/rT1X2VaXHYDi2msifJvOjdysC
AAJOATOnGTKiWiT++FVMywn6PkLhCp13npmhsHgLv+qf9EKt+Xn8ntj21AAlDaou
kpjH5kV19mnDn/yNLGMZco3Lk3QUF3GDvewoGDTUWU/0JrGDo2K/IvL8hVvzuFkW
C5fGogP/nXW1+X1AnF7L23mFuzw1/2v+m4T8RjqaaaDUB6lg+n4fkLUkmlcr74cT
BFThjtYy4dEfMxKOR9BEdiKs+UVSUIw2UL9mWvSezfoc+BM7mqw=
=QHAf
-----END PGP SIGNATURE-----

--v2uurtVl/i/kq5hu--
