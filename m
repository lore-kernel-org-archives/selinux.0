Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3RGWSI4020935
	for <selinux@tycho.nsa.gov>; Sun, 27 Apr 2003 12:32:29 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h3RGWS7R023864
	for <selinux@tycho.nsa.gov>; Sun, 27 Apr 2003 16:32:28 GMT
Received: from hoss.orcus.priv.at (chello080110242202.117.11.tuwien.teleweb.at [80.110.242.202])
        by jazzband.ncsc.mil  with ESMTP id h3RGWRKP023861 for <selinux@tycho.nsa.gov>; Sun, 27 Apr 2003 16:32:27 GMT
To: selinux@tycho.nsa.gov
Subject: Re: busybox ls
References: <200304270213.57411.russell@coker.com.au>
From: Robert Bihlmeyer <robbe@orcus.priv.at>
Date: 27 Apr 2003 18:25:35 +0200
In-Reply-To: <200304270213.57411.russell@coker.com.au>
Message-ID: <87k7df9abk.fsf@orcus.priv.at>
MIME-Version: 1.0
content-Type: multipart/signed; boundary="----------=_1051461146-1046-1"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
It has been signed conforming to RFC3156.
You need GPG or PGP to check the signature.

------------=_1051461146-1046-1
Content-Type: text/plain; charset=us-ascii

Russell Coker <russell@coker.com.au> writes:

> Any suggestions on which option switches I should use for equivalent
> of --sid and --context functionality?

Maybe -K for --context (upcase as not to "kollide" with GNU ls's -k
option)? -O is also viable, but I prefer -K as lame as it is.

I think if whatever you use for --context is used together with -n
("numeric ids") the effect of --sid should occur.

-- 
Robbe

------------=_1051461146-1046-1
Content-Type: application/pgp-signature
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+rAYa8g21h7wYWrMRAuK2AKDDyMKXOrC1nquB7Ok2QAOnKKsm3wCgsUfA
jYdsoo13OmT/7mCQd/SMiP4=
=EeWg
-----END PGP SIGNATURE-----

------------=_1051461146-1046-1--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
