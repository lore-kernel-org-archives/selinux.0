Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0AGqtsH026154
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2007 11:52:55 -0500
Received: from mail.and.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0AGrjoR006342
	for <selinux@tycho.nsa.gov>; Wed, 10 Jan 2007 16:53:45 GMT
Received: from localhost ([127.0.0.1])
	by mail.and.org with esmtp (Exim 4.63)
	(envelope-from <jantill@redhat.com>)
	id 1H4ghs-0004BV-0n
	for selinux@tycho.nsa.gov; Wed, 10 Jan 2007 11:53:44 -0500
Subject: Tar storage of SELinux context, translated or not
From: James Antill <jantill@redhat.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-smYd5tLpqEbCrcVDFLdx"
Date: Wed, 10 Jan 2007 11:53:43 -0500
Message-Id: <1168448023.13080.33.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-smYd5tLpqEbCrcVDFLdx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


 As some of you know, I have done patches to make GNUtar able to
save/restore ACLs, SELinux context and generic user xattrs. I've
recently had to fixup the ACL support for compatibility with star etc.,
and for a couple of reasons that got me thinking about the SELinux
support as well.

 I had originally decided that the SELinux security context should be
stored in translated form, Ie. getfilecon =3D> tar =3D> setfilecon, my
thinking was that if you want to store something over a long period this
is the better format ... but as I think more about it now I'm not 100%
convinced (for instance, AIUI ipsec etc. uses raw format to distribute
context between machines).
 With the current changes, this is a great time to change it (but I
really, really, don't want to have an option either way) ... if we want
to. So should I change it to non-translated?

--=20
James Antill <jantill@redhat.com>

--=-smYd5tLpqEbCrcVDFLdx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBFpRoX11eXTEMrxtQRAnNZAJ9bGLL7/0DBdPMIXgTvxPjRCukbbACfUy86
5JhQjyEtog9mINR0DBxZJ/4=
=hKIx
-----END PGP SIGNATURE-----

--=-smYd5tLpqEbCrcVDFLdx--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
