Message-ID: <434BDC2E.6050106@diyab.net>
Date: Tue, 11 Oct 2005 11:37:18 -0400
From: Timothy <timothy@diyab.net>
MIME-Version: 1.0
To: SELinux <SELinux@tycho.nsa.gov>
Subject: Makefiles
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: RIPEMD160

What would be the preferred method of maintaining the Makefiles for
building between pam and non-pam builds?  I was thinking of just making
another Makefile named Makefile.nopam that could be specified when
running make.  Suggestions?

Timothy,
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFDS9wuSYq2KfPEK/gRA0T6AJ0eQ15HlRtQqXv/lO6ZX+TOniOYTQCfb0td
BN3FACGwBz/uPN0Ppm4AGqA=
=drBh
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
