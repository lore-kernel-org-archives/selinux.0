Received: from jazzdrum.ncsc.mil ([144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1HNRSdW002620
	for <selinux@tycho.nsa.gov>; Thu, 17 Feb 2005 18:27:28 -0500 (EST)
Received: from vds-320151.amen-pro.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1HNPvF0010783
	for <selinux@tycho.nsa.gov>; Thu, 17 Feb 2005 23:25:57 GMT
Subject: RE: Bell & Lapadula Model
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: Frank Mayer <mayerf@tresys.com>
Cc: NSA Selinux Mailinglist <selinux@tycho.nsa.gov>,
   "'Juan Espino'" <jp_espino@hotmail.com>
In-Reply-To: <20050217222122.HGPG7908.mm-ismta4.bizmailsrvcs.net@FLM800>
References: <20050217222122.HGPG7908.mm-ismta4.bizmailsrvcs.net@FLM800>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SIp+GSGNgtv1xidXRfUI"
Date: Fri, 18 Feb 2005 00:25:26 +0100
Message-Id: <1108682726.4100.14.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-SIp+GSGNgtv1xidXRfUI
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

El jue, 17-02-2005 a las 17:21 -0500, Frank Mayer escribi=F3:
> > > SELinux enforces a Mandatory Access Control (MAC) Policy based on Bel=
l=20
> > > and Lapadula Model.  I understand the read control property (no read=20
> > > up) and the write control (no write down), but in this model there ar=
e=20
> > > another property called tranquility property, I don't know very well=20
> > > how SELinux enforces this property,
> >
> > SELinux includes an experimental MLS implementation based on BLP.  This
> feature is=20
> > not currently enabled in Fedora.
> >
> > Thus, it may be better to discuss the MLS component on the NSA list:
> > http://www.nsa.gov/selinux/info/list.cfm?MenuID=3D41.1.1.9
>=20
> To be clear, SELinux as most people think about it implements type
> enforcement as its MAC, and *not* BLP (i.e., MLS) as you seem to assert. =
As
> James notes the current MLS feature is experimental though there is work =
to
> make it more integral for future release.

Concretely, SELinux arguments the Type Enforcement model with the
addition of the standard Role-Based Access Control.

Instead of doing association between user and types, it lets RBAC to
associate users with at least one role and associates at least one type
with each of those roles.

Permission checks and such are handled by TE, RBAC is more an
user-complaining and policy-enhancing "layer".

"Bell-LaPadula MAC model describes access by active entities, called
subjects, to passive entities, called objects. An entity can, depending
on type of access, be in both roles.
=46rom rom the distinction between read and write access four modes of access
can be distinguished: neither read nor write (execute, e), read only
(read, r), write only (append, a) and read-write (write, w). The set of
all access types is named A."
(http://rsbac.org/documentation/models.php#mac)

The access control matrix is slightly different then :)
Your description is accurate for RSBAC, not for SELinux as I explained
above, among Frank's comments.

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-SIp+GSGNgtv1xidXRfUI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCFSfmDcEopW8rLewRArWqAJ48puwblx+bYMfG/fPJMbCZBMu18QCdFa4L
3s/hgi6DleuW02godU5ny0I=
=AY0j
-----END PGP SIGNATURE-----

--=-SIp+GSGNgtv1xidXRfUI--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
