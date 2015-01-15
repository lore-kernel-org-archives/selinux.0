Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0FD2acv020558
 for <selinux@tycho.nsa.gov>; Thu, 15 Jan 2015 08:02:36 -0500
Date: Thu, 15 Jan 2015 14:02:28 +0100
From: Johannes Segitz <jsegitz@suse.com>
To: Stephen Smalley <stephen.smalley@gmail.com>
Subject: Re: ebitmap: map size does not match my size on s390x
Message-ID: <20150115130228.GD24984@suse.de>
References: <20150114110334.GA24984@suse.de>
 <CAB9W1A1bN6aBJi9-6RT+23BoH5dmppTv6WSUWtgVrJ21KOAqDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lc9FT7cWel8HagAv"
In-Reply-To: <CAB9W1A1bN6aBJi9-6RT+23BoH5dmppTv6WSUWtgVrJ21KOAqDg@mail.gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--lc9FT7cWel8HagAv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2015 at 09:26:17AM -0500, Stephen Smalley wrote:
> There have been a couple of endianness fixes for
> /sys/fs/selinux/policy, e.g. see:
> 9085a6422 and b138004

Those commits solved the problem. Thank you.

Johannes
--
Johannes Segitz                                        SUSE Security Team
GPG Key E7C81FA0       EE16 6BCE AD56 E034 BFB3  3ADD 7BF7 29D5 E7C8 1FA0
SUSE LINUX GmbH        Maxfeldstra=DFe 5            90409 N=FCrnberg, Germa=
ny
GF: Felix Imend=F6rffer, Jane Smithard, Jennifer Guild, Dilip Upmanyu, Grah=
am Norton, HRB 21284 (AG N=FCrnberg)

--lc9FT7cWel8HagAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJUt7pkAAoJELwn3Z0sxP1m1s4QAJWfFbvVWOlghTJCHSv3K28I
Ecdz4ppWLYChnMnBtD7zp6RskbLgPGgdlHMPjjucYVURkdUlfgJHqpCdwYL+bL/2
ip09Rh6jEkpfn93L8Mp6gBLTRPYSLMYm1YCy2ycyh9sQ6rOJOVsYlR72cw4OsWXk
Vqs+5ajtaEd3Vbj9nUuB6OYiLsSzAmNN3rzaHeIO7bkvfrKDW63A0VxEJwBfyG1I
unOSDxEL6zxIfNXzSHT6txVMQVJI3DS82SLK695KG7r3QpUj9RarKkDeQvGWLb0L
IXEico0mBdNn4s2dkgn+nXX1ccxSVZ9tZ5sCfurgKKMB7nLNppTjdQknjkUnha7Z
tMdnlnnPC0nGkUAo1JTi0hOsfuf4hto8BwJCqnxFHu8hulgh/IxXiyCuXHnU60Jc
4fT3eWX2rv+LccLySkyocH+mZWSskD6QW6rSvITarLEx/N2HcqjGlMFdTg0cPdNW
didrAiFC8jIRC4cZQHL2B0QJ/+pAUhqbbZ0uhbdO17wEsrXnliGNqw6qHanA0evk
KUoOOacdZo2URds5EPAOG/6Ig1qLccBeY+vXBXRB3XqO01XEtkdP/ikOerfLZS/g
/YD1qfPU4RuebCpKftff2ygy8LvoEibFYOn/EWBB9C+HA4dKssvjrHWp0EmASA9G
kQA7qLn0zZTGTGl9aQ1U
=MBTP
-----END PGP SIGNATURE-----

--lc9FT7cWel8HagAv--
