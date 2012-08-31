Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q7VD7jSo008938
	for <selinux@tycho.nsa.gov>; Fri, 31 Aug 2012 09:07:45 -0400
Date: Fri, 31 Aug 2012 15:07:27 +0200
From: Ole Kliemann <ole@plastictree.net>
To: Stephen Smalley <stephen.smalley@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
        Daniel Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH] libsepol: fix neverallow checking
Message-ID: <20120831130727.GC8220@telmora.telvanni>
References: <CAB9W1A30Zvtq+pjpcktaTaeXYbCEpQs7Sc-tVwmw9FVqRdKbEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ABTtc+pdwF7KHXCz"
In-Reply-To: <CAB9W1A30Zvtq+pjpcktaTaeXYbCEpQs7Sc-tVwmw9FVqRdKbEg@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--ABTtc+pdwF7KHXCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks! Fixes the problem for me on Ubuntu 12.04 with=20
libsepol 2.1.0-1.2

Ole

--ABTtc+pdwF7KHXCz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlBAtw8ACgkQS1FjE303ERwK8wCeMB99PmQPPrIS11JDJwDCaVLi
6QUAnjR0/er2WMNcqxAk5Q0tEn9t+VTf
=YlvS
-----END PGP SIGNATURE-----

--ABTtc+pdwF7KHXCz--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
