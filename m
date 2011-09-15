Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p8FJjgiJ020485
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 15:45:50 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p8FJjmHA017466
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 19:45:49 GMT
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p8FJjmDh027118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 15 Sep 2011 15:45:48 -0400
Message-ID: <4E7255EB.3000804@redhat.com>
Date: Thu, 15 Sep 2011 15:45:47 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 35/67] policycoreutils: sandbox: FIXME add level based kill
Content-Type: multipart/mixed;
 boundary="------------080306080904000805070502"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080306080904000805070502
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This patch looks good to me. acked.

The comment in your patch says sandbox will default to -K, this is not
true, the patch is fine though.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk5yVesACgkQrlYvE4MpobMfuACgynaP1XdCWq1mk5PgZu6KfDQ5
AwMAnjhvqu8K0NUM4cDXBGIIf8bTbbjT
=XMYr
-----END PGP SIGNATURE-----

--------------080306080904000805070502
Content-Type: text/plain;
 name="0035-policycoreutils-sandbox-FIXME-add-level-based-kill-o.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0035-policycoreutils-sandbox-FIXME-add-level-based-kill-o.pa";
 filename*1="tch"


--------------080306080904000805070502--
