Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r427VnW5024612
	for <selinux@tycho.nsa.gov>; Thu, 2 May 2013 03:31:49 -0400
Received: by mail-ie0-f175.google.com with SMTP id s9so319815iec.20
        for <selinux@tycho.nsa.gov>; Thu, 02 May 2013 00:31:47 -0700 (PDT)
Received: from  (c-75-71-156-19.hsd1.co.comcast.net. [75.71.156.19])
        by mx.google.com with ESMTPSA id dy5sm8020798igc.1.2013.05.02.00.31.44
        for <selinux@tycho.nsa.gov>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 02 May 2013 00:31:44 -0700 (PDT)
Date: Thu, 2 May 2013 07:31:35 +0000
From: Michael Seyfert <michael@codesand.org>
To: selinux@tycho.nsa.gov
Subject: 'av.data' may be used uninitialized
Message-ID: <51821660.c5b5320a.15e4.ffff898a@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When compiling libsepol with optimizations enabled I get this warning:

gcc -o hierarchy.o -c -Werror -Wall -W -Wundef -Wshadow -Wmissing-noreturn =
-Wmissing-format-attribute -D_GNU_SOURCE -O3 -I. -I/mnt/data/work/selinux/s=
elinux/libsepol/include hierarchy.c
hierarchy.c: In function 'check_avtab_hierarchy_callback':
hierarchy.c:234:2: error: 'av.data' may be used uninitialized in this funct=
ion [-Werror=3Dmaybe-uninitialized]
cc1: all warnings being treated as errors
scons: *** [hierarchy.o] Error 1
scons: building terminated because of errors.

I'm not familiar enough with the internals of selinux to know if this is a =
problem or not. Could someone look at it?

--=20
Michael Seyfert

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRghZWAAoJEFyEplK22pdVmowP/3bNzn07EnR6KR4bVGCnna53
kHQrxtRQPXTaUxY3W9sAmJiRsqzL1jZ3cO/U21vFlA9Av99JDok8XJmrQbKF6QRl
fuXDFzHDWeEcgOl35YY7/HILHSdtvSH44SqWSFAmv4Q+8EWX1cOh6obrJcRDInZU
+xsdH9TXUazkAAQHQ0tDDt6Z5Kx2OZvw6hmNLgiYk46oH7j4k6ptGG2+wbdUYwT9
NL2Uys/7umh+eSmD4AKVZcV1wLsvfMMumdO3jcckOcYPPr41hL8RaBeIGRhlvpeH
U9ONKlnWmKb2AFEt9hyWvoFtXSa1biuEjA1A80kqvZHPfKBmoWuE+mlWC+xSQP66
YehnFXrwyFze/pTidjwLU6dVPGOAndiLMNYO4NkMIcdnLYEUy+Qq7SieIl3KVZul
jHKyANvzboDuJ26QO0cp6QZ33/pAJ1BXI6lUlaI16Al/t3I+0x0bTBK0AuJ2Q7mA
9GOvo63+cuAUWOaTGmZ1nn0i9J5SI5uai+vR7bkCQ3/JgkSP5827qASJdG83WvaM
0nTyRVEjrZeSPXjDIxIzn7Eao4fAfy23oHZDey+s+cIzjMM9i1zErR7I3AKUGXX+
Q3aEZxDR+lQ36cBrfmVGOxQ9MdwYMeK18o2gutNcYB+VlfehSwB3RmlsOj8SIxoW
ioUEl+YUEWpuj3D3uM1t
=OjXE
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
