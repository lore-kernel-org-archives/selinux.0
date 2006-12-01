Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB1K7tv3017321
	for <selinux@tycho.nsa.gov>; Fri, 1 Dec 2006 15:07:55 -0500
Received: from mail.and.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kB1K6AIW025528
	for <selinux@tycho.nsa.gov>; Fri, 1 Dec 2006 20:06:11 GMT
Received: from localhost ([127.0.0.1])
	by mail.and.org with esmtp (Exim 4.63)
	(envelope-from <jantill@redhat.com>)
	id 1GqEg8-0001T7-Dd
	for selinux@tycho.nsa.gov; Fri, 01 Dec 2006 15:08:12 -0500
Subject: User home directory creation with useradd (rhbz#217441)
From: James Antill <jantill@redhat.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-IxQxzmjVspY7pZSfW2Dx"
Date: Fri, 01 Dec 2006 15:08:11 -0500
Message-Id: <1165003691.18588.103.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-IxQxzmjVspY7pZSfW2Dx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


 As some of you know, there's an open BZ about the fact that in a
strict/MLS environment useradd doesn't create the user's homedir with
the correct context[1].
 The problem is that matchpathcon() needs semanage to have run, so we
know what SELinux user the unix user is associated with, but that runs
separately and after useradd. The four obvious solutions are:

1. Have an option for useradd to call semanage to add the selinux user,
and then do the restorecon.

2. Have semanage do the equivalent of a restorecon when doing an
add/modify (or just add) of SELinux user information.

3. Have some kind of wrapper that does:
	i. useradd
	ii. semanage
	iii. restorecon

4. Document that you need to call the list of programs in #3.

 Does anyone have comments on which of the above they like/hate?


[1] http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=3D217441

--=20
James Antill <jantill@redhat.com>

--=-IxQxzmjVspY7pZSfW2Dx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFcIur11eXTEMrxtQRAt/YAJ9hbXJZ/b/0ZXS4ZbPutbJveCFBKQCfQWja
GMSt95ntdAXnwjpYMOHqtqk=
=aeUf
-----END PGP SIGNATURE-----

--=-IxQxzmjVspY7pZSfW2Dx--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
