Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i38LMhRb021143
	for <selinux@tycho.nsa.gov>; Thu, 8 Apr 2004 17:22:43 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i38LMdn0012197
	for <selinux@tycho.nsa.gov>; Thu, 8 Apr 2004 21:22:42 GMT
Message-Id: <200404082122.i38LMdWm026103@turing-police.cc.vt.edu>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: selinux@tycho.nsa.gov
Subject: Re: Policy backward compatibility 
In-Reply-To: Your message of "Thu, 08 Apr 2004 13:09:32 EDT."
             <1081444172.6379.174.camel@moss-spartans.epoch.ncsc.mil>
From: Valdis.Kletnieks@vt.edu
References: <1081430495.6379.89.camel@moss-spartans.epoch.ncsc.mil> <200404081704.i38H4ncM017181@turing-police.cc.vt.edu>
            <1081444172.6379.174.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1979546352P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Thu, 08 Apr 2004 17:22:39 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-1979546352P
Content-Type: text/plain; charset=us-ascii

On Thu, 08 Apr 2004 13:09:32 EDT, Stephen Smalley said:

> Yes, I think so.  Might be a front-end wrapper for checkpolicy that
> calls the right checkpolicy-{kernelrelease} binary to generate the
> policy for that kernel release.

OK.. I can live with that, long as the tool can handle a kernel releasename
like 2.6.8-mm3-mobytweaks ;)

> If you include the kernel release in the policy pathname (e.g.
> /etc/security/selinux/`uname -r`/policy), as with kernel modules
> (/lib/modules/`uname -r`), then the old policy should still be there and
> should be used by the older kernel if you reboot it.

That's workable too - and we probably don't need any modversions-style tweaks
to make sure that the policy and kernel aren't affected by a mismatch (I figure
if you live so far on the edge that anything more granular than 2.6.N-mm?
matters, you're on your own. :)

We just need to make sure that a released kernel doesn't create incompatible
policies based on Kconfig changes...


--==_Exmh_-1979546352P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAdcKecC3lWbTT17ARAowWAKChAaGOd7TtACOFYVt59lUAogGN/gCdG4hG
XfxAOET7v+owUQRuYxAx6Pg=
=hDuI
-----END PGP SIGNATURE-----

--==_Exmh_-1979546352P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
