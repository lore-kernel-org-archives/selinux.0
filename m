Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4I0kcRb028263
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 20:46:39 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4I0kaAR022761
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 00:46:36 GMT
Received: from turing-police.cc.vt.edu (turing-police.cc.vt.edu [128.173.14.107])
        by jazzband.ncsc.mil  with ESMTP id i4I0kZHn022758 for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 00:46:36 GMT
Message-Id: <200405180045.i4I0jHqF029457@turing-police.cc.vt.edu>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov
Subject: Re: suggestion to help transition to selinux: dynamic loading of libselinux 
In-Reply-To: Your message of "Mon, 17 May 2004 21:56:01 -0000."
             <20040517215601.GW9378@lkcl.net>
From: Valdis.Kletnieks@vt.edu
References: <20040515232606.GA9378@lkcl.net> <200405180510.40047.russell@coker.com.au>
            <20040517215601.GW9378@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-838198214P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 17 May 2004 20:45:17 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-838198214P
Content-Type: text/plain; charset=us-ascii

On Mon, 17 May 2004 21:56:01 -0000, Luke Kenneth Casson Leighton said:

>  oh.  eek!  of course :)  cause libselinux.so to be corrupted and you're
>  in.

Equally important - the sequence has to be able to DTRT if the fsck of the root
filesystem fails. Remember - for dynamic linking to work, you need a *lot* more
uncorrupted inodes.  If the library you need is in /lost+found, you have some
issues to work out.. ;)

(Note - DTRT doesn't necessarily mean "recover" - although a statically linked
/sbin/fsck.ext3 helps a bunch there.  Being able to drop the system to a known
fail-safe state and then yell for help is probably sufficient).


--==_Exmh_-838198214P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAqVydcC3lWbTT17ARAkKAAKC+4OkpHXpiVPuGGTlIWTy9SZXvMgCfVMKc
Pdh0O84YC59pqNW7EFElZUo=
=PQnP
-----END PGP SIGNATURE-----

--==_Exmh_-838198214P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
