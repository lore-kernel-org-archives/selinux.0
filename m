Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA00071
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2001 11:23:08 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA18684
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2001 16:22:30 GMT
Received: from og.latency.net (og.latency.net [209.123.200.27])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id QAA18680
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2001 16:22:29 GMT
Date: Mon, 15 Jan 2001 11:22:53 -0500
From: Bennett Todd <bet@rahul.net>
To: Jan Petranek <jan@petranek.de>
Cc: selinux@tycho.nsa.gov
Subject: Re: Goal / Danger: Attack by malicious root
Message-ID: <20010115112253.H8565@rahul.net>
References: <01011516091701.13938@linux16>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="2xzXx3ruJf7hsAzo"
In-Reply-To: <01011516091701.13938@linux16>; from jan@petranek.de on Mon, Jan 15, 2001 at 04:08:34PM +0100
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


--2xzXx3ruJf7hsAzo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The problem you describe is right in the heart of the design
principles of trusted computing systems.

Basically, the only way you can trust a computer to use it for
sensitive purposes (like presenting your reusable authentication
credentials to it) is if you _know_ that the code it's running
hasn't been tampered with. If you want to use a system that's out in
a public lab where people can whack on it, your only real hope is to
see if you can force it to boot from some media you take with you
(or, depending on your assumptions and your local network
architecture, possibly do a network boot from a secured server ---
that latter was the Athena approach). Maybe take a CD-ROM with a
known-good OS along with you.

The problem is that if someone has complete control over a system,
no OS feature can possibly save you, since the attacker is in a
position to completely revise or replace the OS.

Now _if_ you had a situation where the machine was sufficiently
thoroughly physically secured, and the software running on it
sufficiently tightly configured, that you were confident that the OS
wasn't tampered with, then the problem would reduce to a real oldie,
the trusted path. The typical fix for that is to have the OS
directly support a special hot-key combo that is absolutely
guaranteed to terminate all processes associated with that console,
and start a new login process, guaranteed to come from the real OS
and not any trojan left running by the last person on that console.
That would be easy to add to selinux. In fact, I thought I'd
remembered seeing something along those lines, but when I just
checked the todo.html I didn't find 'em, maybe my brain is playing
nasty tricks on me.

They do mention integrating the file mandatory access controls with
file encryption, so that part of your question is on the todo list,
but trusted path I do not see. Perhaps it's too trivial. Certainly
it wouldn't be too hard to rig a script around lsof to blow away
anything that has an open file descriptor on the console device, and
let a getty get respawned by init, and wire that to the crtlaltdel
hook in inittab.

-Bennett

--2xzXx3ruJf7hsAzo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6YyPdHZWg9mCTffwRAjTxAKC6EiCqAZ+Lokkv3y7W5UWCLJzdYACfcIh0
lStLuU4YWjTgQlJOczIptpA=
=N+kj
-----END PGP SIGNATURE-----

--2xzXx3ruJf7hsAzo--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
