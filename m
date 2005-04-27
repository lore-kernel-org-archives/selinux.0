Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3RKL4gA019682
	for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2005 16:21:05 -0400 (EDT)
Received: from vds-320151.amen-pro.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j3RKKqCp024442
	for <selinux@tycho.nsa.gov>; Wed, 27 Apr 2005 20:20:53 GMT
Subject: Re: [RFC][PATCH 1/2] Further SELinux restrictions on mprotect
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, drepper@redhat.com, roland@redhat.com,
   mingo@redhat.com, James Morris <jmorris@redhat.com>
In-Reply-To: <1114619778.4115.127.camel@moss-spartans.epoch.ncsc.mil>
References: <1114017480.8495.93.camel@localhost.localdomain>
	 <1114619778.4115.127.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-V4pLi93Zvu2/yGkDX5O1"
Date: Wed, 27 Apr 2005 22:13:05 +0200
Message-Id: <1114632785.8548.24.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-V4pLi93Zvu2/yGkDX5O1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El mi=E9, 27-04-2005 a las 12:36 -0400, Stephen Smalley escribi=F3:
> Thanks for working on these patches. =20

Thanks to you for the guidance and feedback.

> I built a 2.6.12-rc3 kernel with
> execshield and both of these patches applied, and then performed a
> little experimentation, yielding the following results:
>=20
> The execstack check kills the mprotstack test of the modified paxtest as
> expected even if execmem is allowed.  Likewise, the execheap check kills
> the mprotheap test of the modified paxtest.
>=20
> As expected, X requires execheap permission presently.

Yes.

> Running firefox with the Sun java plugin installed yields an execstack
> denial on firefox-bin, and the plugin doesn't seem to work then.  Hence,
> we don't seem to gain any benefit in that particular case.

Related with the issue regarding OOo.

> Running valgrind does not yield an execstack denial and only appears to
> require execmem permission.

It's a special case as Ulrich notes in the latter reply.
I was wrong about it, I apologize for any inconvenience.

> Running OpenOffice generates audit messages for both execstack and
> execheap denials on soffice.bin, but still appears to function.  Not
> sure what is occurring there.

OOo may use a JVM, that depends slightly on your installation, and it's
not something *imperative* to have, thus, it can cause the denials but
still work, of course without the features relying in the JVM.
It could be good to check (using Ingo's /proc/PID/maps markers patch)
where's located the executable heap segment and where's the executable
stack, for use in a later debugging (indeed, OOo is a big beast in that
terms...).

Cheers and many thanks for testing,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-V4pLi93Zvu2/yGkDX5O1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCb/JRDcEopW8rLewRAs7kAJ4z70Q70agRt3ADou72OzyVA7gB+ACfWiWi
IKsCX0+ghzh8+8Oi0udP72A=
=uMOx
-----END PGP SIGNATURE-----

--=-V4pLi93Zvu2/yGkDX5O1--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
