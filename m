Message-Id: <200505291716.j4THGA9b009438@turing-police.cc.vt.edu>
To: SELinux@tycho.nsa.gov, fedora-selinux-list@redhat.com
Subject: On building a smaller 'strict' policy.
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1117386968_6734P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Sun, 29 May 2005 13:16:09 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1117386968_6734P
Content-Type: text/plain; charset=us-ascii

OK, so I finally got fed up with having the 'strict' policy take up
4,821 or so *pages* of slab entries for avc_node, and decided to see how
much I could pare it down.  Moving stuff I didn't actually have or use
from domains/program/foo.te into unused/foo.te more or less worked, and
only using up 2,230 pages of slab (a noticable difference on a 256M laptop).

Nits:  In an effort to minimize the size even *more*, I tried nuking the
corresponding macros/program/foo_macros.te files, since much of the bulk of
the policy.conf is created by FOO_macros.te expanding a whole bunch of
USER_FOO_t for all user types (cdrecord chunks out some 100 per role, as
near as I can tell).

The resmgrd, kerberos, and ypbind entries in macros/programs end up getting
referenced in ways that fail gloriously when you try to build policy, so
obviously, wholesale skipping over macros the way the .tc files get skipped
over for unused .te isn't going to work.  Fortunately, the four I had problems
with are defined in such a way that there's little real growth in the policy
because they're wrapped in a "ifdef(`foo.te')"

Would it be a Good Idea to be more agressive in wrapping the other FOO_macros.te
with such an ifdef?  Or does this become a *total* non-issue with the soon-to-arrive
'loadable policy module' stuff?

For what it's worth:

[/etc/selinux/strict/src/policy]3 egrep -v '^#|^$' policy.conf | wc
  28831  218148 1768137

A major savings. ;)

--==_Exmh_1117386968_6734P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCmfjYcC3lWbTT17ARArnRAJ9+IWdBISIZUdKBIB+E34LpvshOUwCfS6xz
CRoRqQL+lzhFrXgzKGr1ouk=
=QrQe
-----END PGP SIGNATURE-----

--==_Exmh_1117386968_6734P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
