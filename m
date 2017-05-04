Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v44HSeZ6031205
 for <selinux@tycho.nsa.gov>; Thu, 4 May 2017 13:28:43 -0400
Received: by mail-wm0-f49.google.com with SMTP id 142so1775880wma.1
 for <selinux@tycho.nsa.gov>; Thu, 04 May 2017 10:28:23 -0700 (PDT)
Received: from julius (84-245-30-81.dsl.cambrium.nl. [84.245.30.81])
 by smtp.gmail.com with ESMTPSA id a56sm1024034edd.48.2017.05.04.10.28.21
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 04 May 2017 10:28:21 -0700 (PDT)
Date: Thu, 4 May 2017 19:28:19 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/6] Revert "policycoreutils: let output of `fixfiles` be
 redirected (as normal)"
Message-ID: <20170504172819.GB29905@julius>
References: <20170504170122.26882-1-alan.christopher.jenkins@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
In-Reply-To: <20170504170122.26882-1-alan.christopher.jenkins@gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2017 at 06:01:17PM +0100, Alan Jenkins wrote:
> This reverts commit ac7899fc3ad6221e195dd13cdf14b346897314ae,
> which is not yet part of an officially tagged release
> (or release candidate).
>=20
> `LOGFILE=3D/proc/self/fd/1` was wrong.
>=20
> `LOGFILE=3D$(tty)` was being relied on in one case (exclude_dirs),
> to log messages from a function run specifically with stdout redirected
> (captured into a variable).
>=20
> Having `logit "message"` break inside redirected functions
> is a nasty leaky abstraction.
>=20
> This caused e.g. `fixfiles restore` to terminate early with the error
>=20
>     skipping: No such file or directory
>=20
> if the user had configured any excluded paths in
> /etc/selinux/fixfiles_exclude_dirs
> ---
>  policycoreutils/scripts/fixfiles | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/f=
ixfiles
> index bc74d69..75d7762 100755
> --- a/policycoreutils/scripts/fixfiles
> +++ b/policycoreutils/scripts/fixfiles
> @@ -119,7 +119,11 @@ VERBOSE=3D"-p"
>  FORCEFLAG=3D""
>  DIRS=3D""
>  RPMILES=3D""
> -LOGFILE=3D/proc/self/fd/1
> +LOGFILE=3D`tty`
> +if [ $? !=3D 0 ]; then
> +    LOGFILE=3D"/dev/null"
> +fi
> +LOGGER=3D/usr/sbin/logger

$ ls /usr/bin/logger
/usr/bin/logger
$ ls /usr/sbin/logger
ls: cannot access '/usr/sbin/logger': No such file or directory

>  SETFILES=3D/sbin/setfiles
>  RESTORECON=3D/sbin/restorecon
>  FILESYSTEMSRW=3D`get_rw_labeled_mounts`
> @@ -134,11 +138,11 @@ else
>  fi
> =20
>  #
> -# Write to LOGFILE
> +# Log to either syslog or a LOGFILE
>  #
>  logit () {
>  if [ -n $LOGFILE ]; then
> -    echo $1 >> "$LOGFILE"
> +    echo $1 >> $LOGFILE
>  fi
>  }
>  #
> --=20
> 2.9.3
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlkLZK8ACgkQJXSOVTf5
R2kzsAwAtp08FMFxDceyN6x1TMMMCx5auc6Ti66BFv8LCWo6krOcyxujRT+0lUcd
cpPCWJYF+AoiZGNzBbE1b7u4Z8sWMbtsVlPuVErVxdKWNl1s+uFJvy9YnvS8KFIX
kHVp4yU7ZvNh6zbcjpLTwVglitb25RxJtrCWW57wx8sf9MnwNaplLy8s4WZpK7QK
NC5AoUaUUqkDRJPMpMYhVZ4MyksRa4qnUSzoxyn3/nWvdoesI2seXXRRwI6upk/e
X/fqy6wQvMvqjg3WkhuONwHaGF6+LTmHqSV/a39ffu2dGwd81VPTVruHrdqFsSrl
PVFx9OjGfsc0btgp/t4W+YfW1XKgGrtiakHx+NFz9sdqlWKl/YZWPs9hPQvlmtS/
27YK2fILqWaLCu1us5qfjGz0U+ACVgT0YAG48Y1vizHrkbijAfjZH1rhy3m9s3T2
ufcQtzKV8YmBmNPXM3jcyLaxUnZkbFL1Z6U15/uqzQRUcNnccOuXRlXhT7lGVKiD
e8h26jG7
=wwhC
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
