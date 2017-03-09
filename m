Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v29EA1bI016434
 for <selinux@tycho.nsa.gov>; Thu, 9 Mar 2017 09:10:01 -0500
Subject: Re: [PATCH] Python 3.6 invalid escape sequence deprecation fixes
To: =?UTF-8?Q?Ville_Skytt=c3=a4?= <ville.skytta@iki.fi>, selinux@tycho.nsa.gov
References: <20170309090935.22458-1-ville.skytta@iki.fi>
From: Petr Lautrbach <plautrba@redhat.com>
Message-ID: <e58141ef-cc49-917a-5a0b-3186e67e9982@redhat.com>
Date: Thu, 9 Mar 2017 15:09:54 +0100
MIME-Version: 1.0
In-Reply-To: <20170309090935.22458-1-ville.skytta@iki.fi>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="H77kFbp4iQ22C7W3nGN4QgOxSDNHj2gvo"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H77kFbp4iQ22C7W3nGN4QgOxSDNHj2gvo
Content-Type: multipart/mixed; boundary="MsPWhpDiaIxhCq6a5T4mHlL37jaVVNoI0";
 protected-headers="v1"
From: Petr Lautrbach <plautrba@redhat.com>
To: =?UTF-8?Q?Ville_Skytt=c3=a4?= <ville.skytta@iki.fi>, selinux@tycho.nsa.gov
Message-ID: <e58141ef-cc49-917a-5a0b-3186e67e9982@redhat.com>
Subject: Re: [PATCH] Python 3.6 invalid escape sequence deprecation fixes
References: <20170309090935.22458-1-ville.skytta@iki.fi>
In-Reply-To: <20170309090935.22458-1-ville.skytta@iki.fi>

--MsPWhpDiaIxhCq6a5T4mHlL37jaVVNoI0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/09/2017 10:09 AM, Ville Skytt=C3=A4 wrote:
> https://docs.python.org/3/whatsnew/3.6.html#deprecated-python-behavior


I'd suggest to add the text from the page directly to the commit message:=


A backslash-character pair that is not a valid escape sequence now
generates a DeprecationWarning. Although this will eventually become a
SyntaxError, that will not be for several Python releases.


The problem appears when you use '-W error':

$ python3 -W error -c 'import re; re.findall("[^a-zA-Z0-9_\-\.]", " *%$")=
'
  File "<string>", line 1
SyntaxError: invalid escape sequence \-


> Signed-off-by: Ville Skytt=C3=A4 <ville.skytta@iki.fi>
> ---
>  python/semanage/seobject.py            | 4 ++--
>  python/sepolgen/src/sepolgen/module.py | 2 +-
>  python/sepolicy/sepolicy/generate.py   | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index c836cc5..94bd368 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -192,8 +192,8 @@ class nulllogger:
>  def validate_level(raw):
>      sensitivity =3D "s[0-9]*"
>      category =3D "c[0-9]*"
> -    cat_range =3D category + "(\." + category + ")?"
> -    categories =3D cat_range + "(\," + cat_range + ")*"
> +    cat_range =3D category + r"(\." + category + ")?"
> +    categories =3D cat_range + r"(\," + cat_range + ")*"
>      reg =3D sensitivity + "(-" + sensitivity + ")?" + "(:" + categorie=
s + ")?"
>      return re.search("^" + reg + "$", raw)
> =20
> diff --git a/python/sepolgen/src/sepolgen/module.py b/python/sepolgen/s=
rc/sepolgen/module.py
> index c09676a..8766dd9 100644
> --- a/python/sepolgen/src/sepolgen/module.py
> +++ b/python/sepolgen/src/sepolgen/module.py
> @@ -40,7 +40,7 @@ from . import defaults
>  def is_valid_name(modname):
>      """Check that a module name is valid.
>      """
> -    m =3D re.findall("[^a-zA-Z0-9_\-\.]", modname)
> +    m =3D re.findall(r"[^a-zA-Z0-9_\-\.]", modname)
>      if len(m) =3D=3D 0 and modname[0].isalpha():
>          return True
>      else:
> diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sep=
olicy/generate.py
> index 5696110..596891a 100644
> --- a/python/sepolicy/sepolicy/generate.py
> +++ b/python/sepolicy/sepolicy/generate.py
> @@ -1329,7 +1329,7 @@ allow %s_t %s_t:%s_socket name_%s;
>              self.add_dir("/var/lib/%s" % self.name)
> =20
>          if os.path.isfile("/etc/rc.d/init.d/%s" % self.name):
> -            self.set_init_script("/etc/rc\.d/init\.d/%s" % self.name)
> +            self.set_init_script(r"/etc/rc\.d/init\.d/%s" % self.name)=

> =20
>          # we don't want to have subdir in the .fc policy file
>          # if we already specify labeling for parent dir
>=20


--=20
Petr Lautrbach



--MsPWhpDiaIxhCq6a5T4mHlL37jaVVNoI0--

--H77kFbp4iQ22C7W3nGN4QgOxSDNHj2gvo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6FPBhIsBhc9Chk3zY6itS5gsQ3MFAljBYjIACgkQY6itS5gs
Q3Nqtg//aaiulFjAQyX1H7GyyYTs2wAp5tlDK8E+8EICFvuIifvA0RmwnJxK6XA5
skCu1gP+RfRaSWMb/5CBAceHEmjOKHv8Zv9mLsLTlMdhHdl+5FmeWFi2lQmjedxK
5bz1dM7lkm+ND7naEH7D5hhBYOu9aQCkeN6vJ0mt/qXp8xzqFOoWHhPc5CMpRTgo
egZNew/i3eargltaAZykOzE8jMbAXsRsm6OxHyw7kdElwQAFp9RdtzkDaT1fzWM8
A5rNxIaUQDwtoDWpTFRG5fsqfFsOo297zZCfocHxYAKmeJlt3clPZDehHykKuQ7j
bNEx/4jhSDRgqDnzVJLVqnlZ/KQ5/LVRZrhQRol+eygCB4s/sbjzE0Opgif7IPD9
/xseWiSlNsPKvqRvpF1tR3CJKTLmMzf0b4ETaC/IKPi6tvVpFOPO80mKRpGJu68g
BApLWjxjdBvxYQ9uKZ9c9Dt493CdeS1VgXZgUUXurd2X7eYQqffNLe7X6mvI04vE
FMkDBOVnU04HWRU1UK2G16+OsxfeISv4ilEUxupmRHECFZuEJoUAO5P2uZ7UC4f2
JrmD+pUyaGnfi74A1MZokVKfrgKWlMnLttYLcyUkT7Cs62bcoR0Cz4xpBPwBG6uQ
4mkcbxMWvIM2qR2zw6cQVfiYpWMvkacXp+DxlBohSwfCrkZ3aVg=
=NKrP
-----END PGP SIGNATURE-----

--H77kFbp4iQ22C7W3nGN4QgOxSDNHj2gvo--
