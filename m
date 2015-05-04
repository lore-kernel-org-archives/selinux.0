Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t44FijeU018114
 for <selinux@tycho.nsa.gov>; Mon, 4 May 2015 11:44:49 -0400
Received: by wicmx19 with SMTP id mx19so80335178wic.1
 for <selinux@tycho.nsa.gov>; Mon, 04 May 2015 08:44:47 -0700 (PDT)
Received: from x131e (217-19-24-195.dsl.cambrium.nl. [217.19.24.195])
 by mx.google.com with ESMTPSA id n1sm11775931wix.0.2015.05.04.08.44.46
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 May 2015 08:44:46 -0700 (PDT)
Date: Mon, 4 May 2015 17:44:44 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: secilc bug
Message-ID: <20150504154444.GC17043@x131e>
References: <alpine.LRH.2.11.1504241023280.13918@namei.org>
 <CAHC9VhTGXTRi0=XbeB8b+LQVC+MDdk3PH38hYSafmV5CMrvi8Q@mail.gmail.com>
 <553A6D3D.8020904@schaufler-ca.com>
 <CAHC9VhQkYU990OKAySUnPn-XzoOUN=21AjOB76pbM7uVQX_0xQ@mail.gmail.com>
 <alpine.LRH.2.11.1504271528350.16342@namei.org>
 <1430265211.2218.13.camel@linux.vnet.ibm.com>
 <20150502150259.GA15244@x131e> <20150503105045.GB13244@x131e>
 <55478E17.8040609@tycho.nsa.gov> <55479132.5000809@tresys.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KN5l+BnMqAQyZLvT"
In-Reply-To: <55479132.5000809@tresys.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2015 at 11:33:06AM -0400, Steve Lawrence wrote:
>=20
> I think this might be a reset issue, with classmappings or something
> related to classmappings not getting reset/re-resolved correctly. I've
> noticed that with xserver.cil removed, some optional fails and causes a
> re-resolve. Then when writing to the binary, the allow rule mentioned
> ends up with all perms being empty, and so the allow rule is never added.
>=20
> Note I also needed to modify EXCLUDE to exclude a handful of files due
> to dependencies with xserver. I've attached that file.
>=20

Yes, indeed. My policy infrastructure support local changes though

One can create an EXCLUDE.local file in the root and in there add the modul=
es one wishes to exclude

This file should not conflict with the "upstream" EXCLUDE file

So EXCLUDE is used by upstream and EXCLUDE.local is for local exclusions

Similarly seusers and seusers.local

Basically the repository has a local and upstream side, so that one can mak=
e local changes without breaking the repository by for example updating it =
with git pull

--KN5l+BnMqAQyZLvT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVR5PoAAoJENAR6kfG5xmcGRUMAL0CZrJM8zu5iCvJpjjn1Oyq
gazhDCSqBXebmdphYZTn1/DZRAZxHTeUQa+knHmkh55jgsLX7I0k2a4ylVz4BE+P
D8vE+GHzrWa7IJLPoGte5MG+kc/dyS/VYueikedrRB08ii3D7j0YLXcQ5nnXj8a+
QNQ5pvoFvwGZn8yJqxlAbaI/E7XmCvBWKDJUalVN1/VDUe0GtmDt4aGqRW9jfP9c
l1C2KoIVpTdTHEzryTURubFn4qPoCYIvUIOMHchj8r1vPTHFgFiPV4pMs548kVoM
7GGApEcgbuCtvZ3V1hnazbJPNw6TmIVZUumYPrRMggPAi5twSfNwnjVxacxUVGoJ
BEpKT/+ZQeFM2KnPYngvBTMTkSBxcepATrSMD1kNLM47akzPxfMfXJ3oLvbcW0AO
qaKo0e26yezz9Iyd7+GJfHz2x/aa6RImclseE/KlCtCEJeO7vMWtPA3FCAwx7+P8
zZBxJrPVIhPAALbVjhvHgcW2l1UhhWffG42Qqj9aDw==
=lsU6
-----END PGP SIGNATURE-----

--KN5l+BnMqAQyZLvT--
