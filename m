Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iANKlsIi014957
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 15:47:54 -0500 (EST)
Received: from raq0.openthought.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iANKkOuA010483
	for <selinux@tycho.nsa.gov>; Tue, 23 Nov 2004 20:46:24 GMT
Date: Tue, 23 Nov 2004 20:47:12 +0000
From: Eric Andreychek <eric@openthought.net>
To: selinux@tycho.nsa.gov
Subject: Re: Selinux book: based on 2.4 or 2.6?
Message-ID: <20041123204712.GD13780@openthought.net>
References: <20041123190312.GA18634@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <20041123190312.GA18634@conectiva.com.br>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Howdy,

> Does anybody know if the SELinux book[1] from Oreilly is based on
> the new 2.6 kernel implementation?

Well, it looks like it is based on 2.6.  The sample chapter on O'Reilly's site
shows the following example grub setup:

  kernel /vmlinuz-2.6.4-1.305 ro root=LABEL=/ enforcing=1

Yeah, I'm looking forward to checking that book out myself.

Have a good one,
  -Eric

- -- 
 Eric Andreychek              | Lucy: "What happens if you practice the
 Eric Conspiracy Secret Labs  |  piano for 20 years and then end up not
 eric@openthought.net         |  being rich and famous?"
 http://openthought.net       | Schroeder: "The joy is in the playing."
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBo6HQR5UKaDAjAG4RAunGAJ9WJYVADxSrHH9Z+rYfBeo95fiY3wCeJHp9
45nXid+UY/tNbLD48X24bVw=
=x17B
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
