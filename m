Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3OIwwI4009918
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 14:59:13 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3OIwu7R000009
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 18:58:56 GMT
Received: from hoss.orcus.priv.at (chello080110242202.117.11.tuwien.teleweb.at [80.110.242.202])
        by jazzband.ncsc.mil  with ESMTP id h3OIwtKP000004 for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 18:58:56 GMT
To: selinux@tycho.nsa.gov
Subject: broad domains
From: Robert Bihlmeyer <robbe@orcus.priv.at>
Date: 20 Apr 2003 09:11:46 +0200
Message-ID: <87n0ilej7x.fsf@orcus.priv.at>
MIME-Version: 1.0
content-Type: multipart/signed; boundary="----------=_1051210723-1305-1"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
It has been signed conforming to RFC3156.
You need GPG or PGP to check the signature.

------------=_1051210723-1305-1
Content-Type: text/plain; charset=us-ascii

Hi,

I started work on a generic X client domain, but now I get the feeling
that this may not be the right way to go. As I have to add this
permission for this client, and that permission for that program, the
domain gets quite broad. Maybe these generic domains are a mistake?

A have the same problem with the games domain provided in the default
policy (or at least in Russell's package). As is, it doesn't fit half
the stuff in my /usr/games.

On the other hand, having a domain for every teensy toy out there
seems a bit excessive.

Any advice?



BTW, can't setfiles assume some default user & role if none is given?
Repeating system_u:object_r: a million times is superflous.

-- 
Robbe

------------=_1051210723-1305-1
Content-Type: application/pgp-signature
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+qDPj8g21h7wYWrMRAjhTAJ4kVYHdbJ48b1xKkH5GuAH5W/S90wCaA1vD
WGbc6fJa6uvg7Y8+epkPjwE=
=PyA/
-----END PGP SIGNATURE-----

------------=_1051210723-1305-1--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
