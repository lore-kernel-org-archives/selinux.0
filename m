Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t44Fkjgq018239
 for <selinux@tycho.nsa.gov>; Mon, 4 May 2015 11:46:45 -0400
Received: by widdi4 with SMTP id di4so126498466wid.0
 for <selinux@tycho.nsa.gov>; Mon, 04 May 2015 08:46:41 -0700 (PDT)
Received: from x131e (217-19-24-195.dsl.cambrium.nl. [217.19.24.195])
 by mx.google.com with ESMTPSA id ch2sm11747249wib.18.2015.05.04.08.46.40
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 04 May 2015 08:46:40 -0700 (PDT)
Date: Mon, 4 May 2015 17:46:39 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: secilc bug
Message-ID: <20150504154638.GD17043@x131e>
References: <CAHC9VhTGXTRi0=XbeB8b+LQVC+MDdk3PH38hYSafmV5CMrvi8Q@mail.gmail.com>
 <553A6D3D.8020904@schaufler-ca.com>
 <CAHC9VhQkYU990OKAySUnPn-XzoOUN=21AjOB76pbM7uVQX_0xQ@mail.gmail.com>
 <alpine.LRH.2.11.1504271528350.16342@namei.org>
 <1430265211.2218.13.camel@linux.vnet.ibm.com>
 <20150502150259.GA15244@x131e> <20150503105045.GB13244@x131e>
 <55478E17.8040609@tycho.nsa.gov> <55479132.5000809@tresys.com>
 <20150504154444.GC17043@x131e>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JwB53PgKC5A7+0Ej"
In-Reply-To: <20150504154444.GC17043@x131e>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--JwB53PgKC5A7+0Ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2015 at 05:44:44PM +0200, Dominick Grift wrote:
> On Mon, May 04, 2015 at 11:33:06AM -0400, Steve Lawrence wrote:
> >=20
> > I think this might be a reset issue, with classmappings or something
> > related to classmappings not getting reset/re-resolved correctly. I've
> > noticed that with xserver.cil removed, some optional fails and causes a
> > re-resolve. Then when writing to the binary, the allow rule mentioned
> > ends up with all perms being empty, and so the allow rule is never adde=
d.
> >=20
> > Note I also needed to modify EXCLUDE to exclude a handful of files due
> > to dependencies with xserver. I've attached that file.
> >=20
>=20
> Yes, indeed. My policy infrastructure support local changes though
>=20
> One can create an EXCLUDE.local file in the root and in there add the mod=
ules one wishes to exclude
>=20
> This file should not conflict with the "upstream" EXCLUDE file
>=20
> So EXCLUDE is used by upstream and EXCLUDE.local is for local exclusions
>=20
> Similarly seusers and seusers.local
>=20
> Basically the repository has a local and upstream side, so that one can m=
ake local changes without breaking the repository by for example updating i=
t with git pull

Running ./laptop --help  explains the options a bit

--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
Dominick Grift

--JwB53PgKC5A7+0Ej
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVR5RaAAoJENAR6kfG5xmccjsMAMRflynXUDqdSfn0DpP81Yga
pTvnmrRuGcxt8PfTZzh33f5TsfJH/86tls9Qo3uRreF+oVun1C5RB40XVo5cacHe
6g6ZRlay9+5Jqxrk1aSpWoI6UgVD6USkjuc1YgL+Jhd78swGaEqlDI6Pn8znRI/m
Q1qlyLwa+393tt1zSovXRxykH4sGkpX0gKdRT9Iars42eFpJ5tq09j6TQuXODIyK
zzLdH+A4fx/lKoq0pq+6utH0Vl23EBcq5bJgW1HGKdUv73tpSvoETwsKSq1Z4Bbp
+L4opjAqJD/0DBp9hngKQop5EhHsl+thB7PdIbqTiJUd2eCOJI4aJbfkvH6r+SBr
eIlxSnQ1BrUHDPmG19LpZNgM6B4xjO+xtlY0ZHhSgHRzzC+UlaMSN6MVi4XPCJmW
bjkP2dKnZWO/v3enKA06mu0nzkAhrAIxpLf0rytgudargQqfYAol5hLDx9r+Ll65
vVSg7SgzcynXRiCPRdWzxHeS9aWOhaQXgmo7Bswkxw==
=ZNqX
-----END PGP SIGNATURE-----

--JwB53PgKC5A7+0Ej--
