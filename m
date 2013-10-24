Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9OEobgD030459
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:50:37 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r9OEoZE8017772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 24 Oct 2013 10:50:35 -0400
Message-ID: <526933BA.8060409@redhat.com>
Date: Thu, 24 Oct 2013 10:50:34 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: eparis@redhat.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH 40/74] genhomedircon is no longer a script
Content-Type: multipart/mixed;
 boundary="------------000609060900060809090106"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000609060900060809090106
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Move genhomedircon content from scripts directory to semodule directory
   This patch looks good to me. acked.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlJpM7oACgkQrlYvE4MpobO5sACgt0Oo3knTvpNwWUWdigLj2VJa
kCsAoIOB/GlIv9K9Hy7fh/vqy4n9Mb9v
=Wn5f
-----END PGP SIGNATURE-----

--------------000609060900060809090106
Content-Type: text/x-patch;
 name="0040-genhomedircon-is-no-longer-a-script-but-a-link-to-se.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0040-genhomedircon-is-no-longer-a-script-but-a-link-to-se.pa";
 filename*1="tch"


--------------000609060900060809090106--
