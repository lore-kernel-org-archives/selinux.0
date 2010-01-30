Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o0ULWace012913
	for <selinux@tycho.nsa.gov>; Sat, 30 Jan 2010 16:32:40 -0500
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o0ULWUou025730
	for <selinux@tycho.nsa.gov>; Sat, 30 Jan 2010 21:32:31 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id o0ULWN0Z037167
	for <selinux@tycho.nsa.gov>; Sat, 30 Jan 2010 22:32:23 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] (mas16.felk.cvut.cz [147.32.84.166])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id o0ULWMIF006136
	for <selinux@tycho.nsa.gov>; Sat, 30 Jan 2010 22:32:23 +0100 (CET)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Sat, 30 Jan 2010 22:32:22 +0100
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: selinux <selinux@tycho.nsa.gov>
Subject: Re: how to trace an avc denial
Message-ID: <20100130213222.GO1639@myhost.felk.cvut.cz>
References: <1264873435.12042.15.camel@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e2bLSPRkEYxxSNev"
In-Reply-To: <1264873435.12042.15.camel@localhost>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--e2bLSPRkEYxxSNev
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Stefan Schulze Frielinghaus wrote:
> What I would like to do is find out if pidgin itself is
> accessing /proc/1/exe or if it is a library. A simple
> "grep -R '/proc/' ./pidgin-source" does not provide any helpful output.
> My guess is that it is a leaked file descriptor because if I start
> pidgin from a shell, then I do not have this problem (I have a rule for
> user terminals and so on).

Maybe when not started from shell '1' is the PPID of the process and for
some wicked reason it wants to interact with its parent.

Also, grepping for 'proc' might not yield the desired result. It's
likely that the app calls a library which in turn does the heavy lifting.

> Sometimes I use strace, e.g. to find out that a library is doing a call
> I'm interested in but this time strace does not help me. So any
> comments/suggestions are very welcomed.

strace/ltrace should almost universally help, though sometimes you need
extra privileges to maintain a ptrace() over process tree. When you're
not starting from shell, strace the 'launcher' program, ie. the one that
acts on the menu entry and/or hotkey you use to run it.

If the trace itself does not make the cause evident, it should at least
help you narrow down the relevant parts of source code.


Michal Svoboda


--e2bLSPRkEYxxSNev
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAktkpWYACgkQg/fU9pp1uX5rZQCdGT7kAPV/1UYnsP+e1/8fYE58
dH8An2iYzjdAZWwMdm1+d7fi+goDa4bP
=MJeK
-----END PGP SIGNATURE-----

--e2bLSPRkEYxxSNev--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
