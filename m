Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r46GGPCg029540
	for <selinux@tycho.nsa.gov>; Mon, 6 May 2013 12:16:25 -0400
Message-ID: <5187D755.2020001@redhat.com>
Date: Mon, 06 May 2013 12:16:21 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Michael Seyfert <michael@codesand.org>
CC: selinux@tycho.nsa.gov
Subject: Re: Current Makefile system is inconvenient/limited
References: <5181072c.4648320a.7ef1.ffff8111@mx.google.com>
In-Reply-To: <5181072c.4648320a.7ef1.ffff8111@mx.google.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/01/2013 08:14 AM, Michael Seyfert wrote:
> The current system for building selinux requires a lot of workarounds like
> C_INCLUDE_PATH and is also interdependent on setools. I was looking at the
> debian packages and they require two build throughs of selinux just to get
> things to compile properly. Am I the only one that thinks this is a
> problem?
> 
Patches Welcomed.

I don't think anyone loves it, but most people do not hate it enough to fix it...

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGH11UACgkQrlYvE4MpobPkHwCfXbAlk6WCJdhXqH0g4jaeCYp9
BSQAnij1i4qDFngpO0zhKxmbKt2X/MG5
=tYfk
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
