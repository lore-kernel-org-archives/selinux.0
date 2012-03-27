Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2RKp0Vu017740
	for <selinux@tycho.nsa.gov>; Tue, 27 Mar 2012 16:51:00 -0400
Message-ID: <4F72282F.9090603@redhat.com>
Date: Tue, 27 Mar 2012 16:50:55 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Laurent Bigonville <bigon@debian.org>
CC: selinux@tycho.nsa.gov
Subject: Since we are sending patches for setools upstream.
References: <20120326213921.53660933@fornost.bigon.be>
In-Reply-To: <20120326213921.53660933@fornost.bigon.be>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here is the current patches for Fedora setools.

http://people.fedoraproject.org/~dwalsh/SELinux/setools/0001-add-setools-seinfo-and-sesearch-python-bindings.patch
http://people.fedoraproject.org/~dwalsh/SELinux/setools/0002-setools-should-exit-with-an-error-status-if-it-gets-.patch
http://people.fedoraproject.org/~dwalsh/SELinux/setools/0003-Since-we-do-not-ship-neverallow-rules-all-always-fai.patch
http://people.fedoraproject.org/~dwalsh/SELinux/setools/0004-Fix-man-pages-and-getoptions.patch
http://people.fedoraproject.org/~dwalsh/SELinux/setools/0005-Fix-sepol-calls-to-work-with-latest-libsepol.patch
http://people.fedoraproject.org/~dwalsh/SELinux/setools/0006-Changes-to-support-named-file_trans-rules.patch
http://people.fedoraproject.org/~dwalsh/SELinux/setools/0007-Remove-unused-variables.patch
http://people.fedoraproject.org/~dwalsh/SELinux/setools/0008-Fix-output-to-match-policy-lines.patch
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9yKC8ACgkQrlYvE4MpobON1QCgkfZNJOrsJ7Ji06ty0olRwSgV
7ZoAoMvbXo+cFiJJ4+MpymSDeo6W1kmT
=aCvo
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
