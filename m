Received: from og.latency.net (og.latency.net [209.123.200.27])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA25285
	for <selinux@tycho.nsa.gov>; Mon, 30 Sep 2002 13:31:21 -0400 (EDT)
Received: from bet.og.latency.net (localhost [127.0.0.1])
	by og.latency.net (Postfix) with SMTP id A66A713FB35
	for <selinux@tycho.nsa.gov>; Thu, 26 Sep 2002 09:00:24 -0400 (EDT)
Date: Thu, 26 Sep 2002 08:51:03 -0400
From: Bennett Todd <bet@rahul.net>
To: selinux@tycho.nsa.gov
Subject: Re: limiting types on a file system
Message-ID: <20020926125103.GA1592@rahul.net>
References: <200209251622.02323.russell@coker.com.au> <20020925215924.GI26806@snoopy.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
In-Reply-To: <20020925215924.GI26806@snoopy.apana.org.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Re the original problem of allowing end-users to use removable
media, notably a floppy, many years ago I was faced with that one,
and addressed it by making the raw floppy device read/write
accessible to the user, then providing a build of mtools, cmdline
utilities for copying files to and from MS-DOS formatted
filesystems. This worked well enough for them.

It's not always the fix, but where applicable it's a solution with
a nicely simple security model, dodges all the concerns about what
clever funkiness people can pull off if they're permitted to mount
filesystems from media they control.

-Bennett

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9kwK2HZWg9mCTffwRAqIVAKDQZp+PpFRu59V7Pp39mcDnDzIZgQCdFteY
FiDFBkiZ4+qOtUG3J32HmYU=
=ee0A
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
