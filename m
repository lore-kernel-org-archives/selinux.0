Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k56MGZfU031893
	for <selinux@tycho.nsa.gov>; Tue, 6 Jun 2006 18:16:35 -0400
Received: from mail.and.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k56MGYvL000823
	for <selinux@tycho.nsa.gov>; Tue, 6 Jun 2006 22:16:34 GMT
Subject: Re: permissions on /proc/self/attrib/current
From: James Antill <james.antill@redhat.com>
To: Chuck Mead <csm@redhat.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4485C100.4030805@redhat.com>
References: <4485C100.4030805@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pSNFU902Ys3h2VTu0iaV"
Date: Tue, 06 Jun 2006 18:16:33 -0400
Message-Id: <1149632193.13928.71.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-pSNFU902Ys3h2VTu0iaV
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-06-06 at 13:53 -0400, Chuck Mead wrote:

> The file /proc/self/attrib/current is world read and write. Is this
> correct? Why does it need world read and write?

 Just my opinion but...

/proc/self/attr/* are only used as part of SELinux policy, so it makes
sense for their access control to be limited by just SELinux policy.

--=20
James Antill <james.antill@redhat.com>
Red Hat

--=-pSNFU902Ys3h2VTu0iaV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEhf7A11eXTEMrxtQRAiwDAKC2M2lcDAJJwonqii5t6P8XyULsVACfb+vF
PF8krjkeG5LdU48fu0FOEXE=
=u0v1
-----END PGP SIGNATURE-----

--=-pSNFU902Ys3h2VTu0iaV--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
