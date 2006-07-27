Message-Id: <200607272116.k6RLGrFC026797@turing-police.cc.vt.edu>
To: Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, jmorris@namei.org,
        jbrindle@tresys.com
Subject: Re: [PATCH] SELinux: new /proc/self/attr/ipccreate for expliciteipc object labeling
In-Reply-To: Your message of "Thu, 27 Jul 2006 12:58:49 EDT."
             <1154019529.5028.19.camel@localhost.localdomain>
From: Valdis.Kletnieks@vt.edu
References: <6FE441CD9F0C0C479F2D88F959B015882989A9@exchange.columbia.tresys.com>
            <1154019529.5028.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1154035012_3017P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Thu, 27 Jul 2006 17:16:53 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1154035012_3017P
Content-Type: text/plain; charset=us-ascii

On Thu, 27 Jul 2006 12:58:49 EDT, Eric Paris said:

> I also decided to leave the name ipccreate even though this does not
> clearly express that the patch does not cover posix message queues.  The
> only name that seemed descriptive enough was sysvipccreate which just
> seemed incredibly long for little to no gain.  I will address the issue
> of controlling posix message queue explicit labeling in a future patch.

Will that require another bit?

> A note of interest, this only leaves 1 bit in the process security
> class.  I don't currently have any plans to use any more, but it is
> something to remember.

Does anybody have a good plan for what to do when we run out?

--==_Exmh_1154035012_3017P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEyS1EcC3lWbTT17ARAqNzAKCkAGyxXAGGILByR/SiNKwdHghKGgCgoEUU
vCJIuOHgkv67jJ0O2JAoLGE=
=gd0M
-----END PGP SIGNATURE-----

--==_Exmh_1154035012_3017P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
