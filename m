Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sARHcstT000804
 for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2014 12:38:57 -0500
Received: by mail-wg0-f48.google.com with SMTP id y19so7001411wgg.35
 for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2014 09:38:55 -0800 (PST)
Received: from e145.network2 ([84.245.1.4])
 by mx.google.com with ESMTPSA id s9sm12517218wiz.12.2014.11.27.09.38.54
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Thu, 27 Nov 2014 09:38:54 -0800 (PST)
Date: Thu, 27 Nov 2014 18:38:52 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: SELinux Userspace Release: 20140826-rc6
Message-ID: <20141127173851.GA16764@e145.network2>
References: <5463658D.7050702@tresys.com>
 <CAPzO=NwooMT-tcgLQOCd7gUdy-8eu67=tTVwuWz0pLOpw8eAnA@mail.gmail.com>
 <20141124112636.GA6200@e145.network2>
 <CAPzO=NyHcEdpQN9iVwEC5LXtYzWjaK0jajz2tFG3pf+-HXqDaA@mail.gmail.com>
 <CAPzO=Nxda_B6u8wX3UmM5DNdOSe568h8tiQmtLTdxHMJEQqMbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
In-Reply-To: <CAPzO=Nxda_B6u8wX3UmM5DNdOSe568h8tiQmtLTdxHMJEQqMbw@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2014 at 01:23:13PM +0100, Sven Vermeulen wrote:
>=20
> So in this case, object_r is assigned (during migration) to system_u,
> unconfined_u and user_u, but not to root, staff_u, sysadm_u and
> testrole_u.
>=20
> Those roles still work though. Is showing object_r in the "SELinux
> Roles" part cosmetic perhaps?
>=20

Strange ... as far as i know object_r needs to be associated with everyone

Is your output of seinfo -xu consistent with that of semanage user (as far =
as roles associated with identities is concerned)?

--=20
Dominick Grift

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJUd2GmAAoJENAR6kfG5xmcGFQL/3pS8UjBcfC2HHLYDB/qzUfH
5ydRJHC8YUKpiiLih27s+5O+w4X2WHkD3vMIsDzZ0hU1pWT5C+3cu5Hwd7Pj3ykq
8bvb8HZcxGgkD1FfM2l4ZMg2pLYPtThSvYyRPdd2VsLdHZXz3/2ss24gPtwX8oCi
9xPAY2TYeEG20emU5giGAP1BeSfAQV6Uh8WWE7BaBcG0CkvQSdkceNGkL2LPzy3X
T+6A38G3q3j39EscziBD07Dl6KjScj8CV+EjtIjBvY7Weuga0X2AinfqaOGu6A+z
YvcGKvndhT1dpDWN8cJJKMNXnObeUpgO2AB1mwf1Ej9MESPapP5u3DYL/RAjIjBj
H9W7gMUeqn02HsLgcktFdgrmdglmaG8C0xZb7pNfTiTPGNRTOuFb0eTNk6z5oOrI
PujczBWdzkhoQTLePchoD0DO5bMBriSN33WgO/qETMwqR/xFjBLyFCN7WeFcebqy
kskjdznRFI3thN9Q/Ez68o9SOu+hYdlBIBLXTcIqsg==
=knhG
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
