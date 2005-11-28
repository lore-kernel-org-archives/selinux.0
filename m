Subject: Re: Threaded applications and "execmem" privilege
Reply-To: lorenzo@gnu.org
To: Erich Schubert <erich@debian.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
   Manoj Srivastava <manoj.srivastava@stdc.com>,
   Russell Coker <russell@coker.com.au>, SELinux@tycho.nsa.gov
In-Reply-To: <1133191110.5276.17.camel@wintermute.xmldesign.de>
References: <1132504528.12651.21.camel@wintermute.xmldesign.de>
	 <1132672653.28079.10.camel@wintermute.xmldesign.de>
	 <1133188277.348.47.camel@moss-spartans.epoch.ncsc.mil>
	 <1133191110.5276.17.camel@wintermute.xmldesign.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Af92wxkx8z8EWiERO43K"
Date: Mon, 28 Nov 2005 16:04:44 +0000
Message-Id: <1133193884.13305.26.camel@localhost>
Mime-Version: 1.0
From: Lorenzo Hernandez Garcia-Hierro <lorenzohgh@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Af92wxkx8z8EWiERO43K
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

El lun, 28-11-2005 a las 16:18 +0100, Erich Schubert escribi=F3:
> Okay, that probably means that most apps (maybe not java and x.org, but
> I don't have these on my selinux boxes anyway) should work just fine.
> And others probably too, since IIRC i386 doesn't enforce that anyway...
> But I'll switch to the patch you posted.

In IA32 PROT_READ implies PROT_EXEC, but "separation" can be enforced:
 http://pearls.tuxedo-es.org/papers/linuxsec-lsm2005/img61.jpg
 http://pearls.tuxedo-es.org/papers/linuxsec-lsm2005/img50.jpg

> Some more information on the issue:
> http://wiki.debian-hardened.org/SSP/ProPolice_Implementations

Please note that information is obsoleted (Hardened Debian used libssp
for ProPolice implementation, although SSP got merged into gcc-4.1
later). Take it as an experiment, and a reliable way of introducing
changes in the SSP code without recompiling everything but just libssp.

Some people are switching to Gentoo (Hardened) due to the problems
caused by some changes introduced in Debian's libc. Some vserver and
grsec users. What's the status now? Is it going to be worked out?

BTW, I would like to help out with anything regarding SELinux deployment
in Debian. I'm trying to work out stuff for Ubuntu Linux, but if it gets
into Debian first, then Ubuntu guys will sync, avoiding efforts
duplication.

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-Af92wxkx8z8EWiERO43K
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)

iD8DBQBDiyqcDcEopW8rLewRAg4FAJ4xYJRZCooL4jb32NEToYF7Zy+VBACg3EAp
tt/PIYxhoBIqS3em3Z7HSTg=
=y6pr
-----END PGP SIGNATURE-----

--=-Af92wxkx8z8EWiERO43K--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
