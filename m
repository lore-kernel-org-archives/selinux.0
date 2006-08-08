Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k78HWNVp007658
	for <selinux@tycho.nsa.gov>; Tue, 8 Aug 2006 13:32:23 -0400
Received: from mail.and.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k78HW6WX028806
	for <selinux@tycho.nsa.gov>; Tue, 8 Aug 2006 17:32:06 GMT
Subject: Re: id -Z subsumed by secon?
From: James Antill <jantill@redhat.com>
To: Jim Meyering <meyering@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <878xlzcflx.fsf_-_@rho.meyering.net>
References: <87u04ncqqq.fsf@rho.meyering.net>
	 <1155050462.1123.36.camel@moss-spartans.epoch.ncsc.mil>
	 <87ejvrcj9i.fsf@rho.meyering.net> <1155054026.12606.26.camel@code.and.org>
	 <878xlzcflx.fsf_-_@rho.meyering.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-IbsBCjSO74bnrwjlwdz7"
Date: Tue, 08 Aug 2006 13:32:22 -0400
Message-Id: <1155058342.12606.61.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-IbsBCjSO74bnrwjlwdz7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-08-08 at 19:16 +0200, Jim Meyering wrote:

> By the way, doesn't secon make id's -Z option unnecessary?

 Well id -a is useful as a single line of all the current permissions,
IMO. It's also a lot easier to find id -Z and runcon or secon, IMO.

--=20
James Antill <jantill@redhat.com>

--=-IbsBCjSO74bnrwjlwdz7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE2Mqm11eXTEMrxtQRAkhIAKDH/g11AOJ8NtbC3ijQ6DcImzEpkACgm9Uk
uUQJZ6oaCnrTzSgHVGrCYM4=
=Y19Q
-----END PGP SIGNATURE-----

--=-IbsBCjSO74bnrwjlwdz7--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
