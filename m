Message-Id: <200607310458.k6V4wScX009997@turing-police.cc.vt.edu>
To: Jim Meyering <jim@meyering.net>
Cc: SELinux@tycho.nsa.gov
Subject: Re: infelicity in context_user_set; new syscalls: setfileconat, etc.?
In-Reply-To: Your message of "Sat, 29 Jul 2006 16:50:16 +0200."
             <87zmeslb2v.fsf@rho.meyering.net>
From: Valdis.Kletnieks@vt.edu
References: <87zmeslb2v.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1154321907_2988P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 31 Jul 2006 00:58:27 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1154321907_2988P
Content-Type: text/plain; charset=us-ascii

On Sat, 29 Jul 2006 16:50:16 +0200, Jim Meyering said:

> FYI, as part of merging the coreutils SE Linux changes "upstream",
> I've just rewritten chcon to use fts (and new openat-style functions,
> getfileconat, lgetfileconat, setfileconat, lsetfileconat[*]).

OK...

> [*] With linux and /proc, I can emulate functions like openat and
> setfileconat, but not everyone has linux, and some linux environments
> lack access to /proc, so...

Everybody who cares about SELinux changes for coreutils presumably has Linux. ;)

And I suspect that nobody's running an SELinux system with no /proc mounted
(except on some *really* Martian-logic design for a Really Secure embedded
system or something...)

--==_Exmh_1154321907_2988P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEzY3zcC3lWbTT17ARAl7XAKCyKlu4jV0Br3yy31Vox+4gO3bAjACfWcqA
8zLnsePJrNfakeBvv/Tdb/k=
=UJYz
-----END PGP SIGNATURE-----

--==_Exmh_1154321907_2988P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
