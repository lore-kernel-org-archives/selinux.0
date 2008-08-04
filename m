Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74KqmRc012304
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 16:52:48 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m74KqlO2020596
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 20:52:47 GMT
Message-ID: <48976BF8.6040301@redhat.com>
Date: Mon, 04 Aug 2008 16:52:08 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: White space consistency patch
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Change all pattern($1,$2,$3) to pattern($1, $2, $3)

http://people.fedoraproject.org/~dwalsh/SELinux/whitespace_diff.gz

Also do we want to use

ifdef(`val',`
val2
',`
val3
')

or

ifdev(`val', `
val2
', `
val3
')

find . -exec sed -i 's/,`/, `/g' {} \; -print
or
find . -exec sed -i 's/, `/,`/g' {} \; -print

Will fix it.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkiXa/gACgkQrlYvE4MpobOmrgCgwQRkkIcG+ZSb8zucSFcQnobN
k+YAoKlD2DTL4Ng6Bd56aWTb8OcHiEbI
=8/nz
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
