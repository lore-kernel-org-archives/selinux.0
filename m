Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iACKwwIi013347
	for <selinux@tycho.nsa.gov>; Fri, 12 Nov 2004 15:58:59 -0500 (EST)
Received: from turing-police.cc.vt.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iACKwxs5010968
	for <selinux@tycho.nsa.gov>; Fri, 12 Nov 2004 20:59:01 GMT
Message-Id: <200411122058.iACKwtfX028640@turing-police.cc.vt.edu>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>
Subject: Re: dynamic context transitions 
In-Reply-To: Your message of "Fri, 12 Nov 2004 13:24:18 EST."
             <1100283858.4306.122.camel@moss-spartans.epoch.ncsc.mil>
From: Valdis.Kletnieks@vt.edu
References: <4182959B.4080503@trustedcs.com>
            <1100283858.4306.122.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-2053730671P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 12 Nov 2004 15:58:55 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-2053730671P
Content-Type: text/plain; charset=us-ascii

On Fri, 12 Nov 2004 13:24:18 EST, Stephen Smalley said:
> per-thread security attributes.  SELinux already stores the security
> attributes on a per kernel thread basis (in the task struct) even though
> the current process context can only change via exec presently.  If you

Would it make sense to change the semantics to "only change via exec
or clone" (or does it already do that and I didn't spot it?)

> threads (as they are different tasks in the kernel).  This also raises
> the question again of whether we should do likewise for the other
> libselinux functions that act on /proc/self/attr, e.g. to support
> per-thread fscreate context.

If you want to go down that road, then the functions should be fixed
to all be symmetric regarding per-thread usages.  If some work one way
and some another, that's a security hole-by-misunderstanding just waiting
to happen....

--==_Exmh_-2053730671P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBlSQPcC3lWbTT17ARAjMpAKDyqWzd3/Q649P0cU8UasheMBjmZACffLYL
UEVdWV4HUGnUBUtmH/5d43s=
=c6dX
-----END PGP SIGNATURE-----

--==_Exmh_-2053730671P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
