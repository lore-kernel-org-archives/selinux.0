Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1PEeJDv017637
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 09:40:19 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1PEeIa4009347
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 14:40:18 GMT
Message-ID: <47C2D302.1060109@redhat.com>
Date: Mon, 25 Feb 2008 09:38:58 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>, selinux@tycho.nsa.gov,
        selinux-devel@lists.alioth.debian.org
Subject: Re: refpolicy: patch for ldconfig from glibc 2.7
References: <20080222152703.GA4163@bobek.pm.i.cz> <1203703539.32061.22.camel@gorn> <20080225124131.GB31035@bobek.pm.i.cz>
In-Reply-To: <20080225124131.GB31035@bobek.pm.i.cz>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Václav Ovsík wrote:
> On Fri, Feb 22, 2008 at 01:05:39PM -0500, Christopher J. PeBenito wrote:
>> This is the right fix, and basically the same fix is queued up for
>> merging as part of Dan's patch set.
> 
> Ok. Should I stop to send patches based on the Dan's Fedora policy?
No if more people report it, it gives a better indication that the
Fedora policy is correct.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfC0wEACgkQrlYvE4MpobPqvwCfTSDwtfvtgxx22/efWEkoHNl3
0AoAoKNOvowl7D40y0p+3kqlahWuWe9/
=VhCD
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
