Message-Id: <200410050149.i951n1uH010040@turing-police.cc.vt.edu>
To: fedora-selinux-list@redhat.com
Cc: SELinux@tycho.nsa.gov
Subject: 
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_961487124P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 04 Oct 2004 21:49:00 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_961487124P
Content-Type: text/plain; charset=us-ascii

(Not sure if this is a fedora-selinux or upstream issue, posting to both lists)

OK, I see where in recent Fedora-devel RPM's the screensaver is deprecated (as
per comments in domains/misc/screensaver.te) .  All the same, we probably want
the following line in file_contexts to make these binaries be 'bin_t' instead
of 'lib_t'...

/usr/X11R6/lib/xscreensaver/.*      --      system_u:object_r:bin_t

--==_Exmh_961487124P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBYf2McC3lWbTT17ARAlupAJ9fPnHuQGkFybHa1HgET0ieqPoLywCgilTZ
9xxxy24fKok7iDngib1mdxU=
=oM2L
-----END PGP SIGNATURE-----

--==_Exmh_961487124P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
