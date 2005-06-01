Message-Id: <200506012149.j51LnT6Q018163@turing-police.cc.vt.edu>
To: mike@theptrgroup.com
Cc: SElinux <SELinux@tycho.nsa.gov>
Subject: Re: SELinux on Arm? 
In-Reply-To: Your message of "Wed, 01 Jun 2005 17:22:47 EDT."
             <429E2727.30407@theptrgroup.com>
From: Valdis.Kletnieks@vt.edu
References: <429E2727.30407@theptrgroup.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1117662569_17976P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Wed, 01 Jun 2005 17:49:29 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1117662569_17976P
Content-Type: text/plain; charset=us-ascii

On Wed, 01 Jun 2005 17:22:47 EDT, Mike Anderson said:
> Greetings!
> 
>   All of the traffic I've seen over the past few months has been for the
> X86.  Is anyone working on
> SELinux (2.6.x) on the ARM/XSCALE?  If so, what distro and target board?

Well, that's mostly because most of the boxes people are interested in putting
SELinux on happen to be x86 (with a few sparc and Power boxes here and there).

Barring any endian-ness, memory capacity,  or lack-of-MMU, or similar issues,
it *should* Just Work on an ARM.  The biggest problem you'll hit is that
there's two main policies defined for RedHat (targeted and strict), and *both*
of them are probably overkill for anything that uses an ARM chipset.  As a
result, you'll probably have to define and write your own policy.  But this
would be the place to ask if you need any particlar hints/guidance.

--==_Exmh_1117662569_17976P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCni1pcC3lWbTT17ARAs+fAJ9t0nFEJ0k9S18W1br/eTYsMRzevgCdFnRP
8QxJKDy7u2r1nK1klI4GR7s=
=ADv2
-----END PGP SIGNATURE-----

--==_Exmh_1117662569_17976P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
