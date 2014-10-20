Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s9KDYfw4014726
 for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2014 09:34:42 -0400
Received: by mail-wi0-f173.google.com with SMTP id fb4so7173765wid.6
 for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2014 06:34:38 -0700 (PDT)
Received: from e145.network2 ([84.245.1.4])
 by mx.google.com with ESMTPSA id u2sm11932046wjz.11.2014.10.20.06.34.37
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Mon, 20 Oct 2014 06:34:37 -0700 (PDT)
Date: Mon, 20 Oct 2014 15:34:35 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: cilc: name space inconsistency
Message-ID: <20141020133434.GA32063@e145.network2>
References: <20141017131548.GA1524@e145.network2>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NzB8fVQJ5HfG6fxh"
In-Reply-To: <20141017131548.GA1524@e145.network2>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2014 at 03:15:49PM +0200, Dominick Grift wrote:
> I started rewriting my policy using name spaces again. I was assuming the=
 the name space issues were fixed.
>=20
> However I am encountering, what i believe, is an inconsistency.

Never mind, its just a warning. I build with -v and sometimes i forget that=
 and get alarmed by any char it returns

--NzB8fVQJ5HfG6fxh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJURQ9kAAoJENAR6kfG5xmcPfcL+waeWqKMGVr+0XJI9YNU018W
H9REnXj1K5O3Rkc/nqiLvUZbM7MgMnTOkUWMRJFXnMKULumSY4fHepKUGvBf/jKc
RWv7Rml7vXeFAqaD02+dZM9OJUfzMXc20pHbTDUWPwFvz0H+qr7GU0lGIOfz6Xzx
6gtg9O44SXlOcFY7XMACizFNlpAozWgGxqK+Ctcg5LupegJLIQg+fMk29DiTCKxb
suR7vR/tTsnxDX7JIDncpMugqi9Op8yI2TqfRMMPEMHrIHcagbbyaRq3LrKx4yv0
kpf0L7cu5x8/ppL6h6gas7Q4kz3SC+FHaE2U1tPDSL8NZhJN6v7q01/+Srbrd3LA
XrSJn95lNtKo40XaM/UN/mZbr9BUD/d7vvGQ/gQx+Ev4onxzmOlQ3Hf525cn0E7J
z1rN1j/5FH9/2UYepRZ2jQWn+fa5nGOof5CO1f88sVbiSu+qK+0b+/ZMHABhXLgc
djxK8Syz6WEjtAgksDwcy4xJCa41rM7Y6sEXaDZkow==
=BBx6
-----END PGP SIGNATURE-----

--NzB8fVQJ5HfG6fxh--
