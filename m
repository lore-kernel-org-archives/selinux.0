Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i95HYPrT028033
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 13:34:26 -0400 (EDT)
Received: from sunspire.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i95HYO7h002500
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 17:34:25 GMT
Message-ID: <4162DB6C.9080900@gentoo.org>
Date: Tue, 05 Oct 2004 20:35:40 +0300
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: selinux@tycho.nsa.gov
Subject: Re: gentoo diff for mysqld
References: <41625B74.2090503@gentoo.org> <200410051720.i95HJx2D017969@turing-police.cc.vt.edu>
In-Reply-To: <200410051720.i95HJx2D017969@turing-police.cc.vt.edu>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3399A129A58E03A6F93C8849"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3399A129A58E03A6F93C8849
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi!

Valdis.Kletnieks@vt.edu wrote:
> On Tue, 05 Oct 2004 11:29:40 +0300, petre rodan said:
>>attached you'll find a diff for the mysql policy.
> 
> 
>>-/var/lib/mysql(/.*)?		system_u:object_r:mysqld_db_t
>>+/var/lib(64)?/mysql(/.*)?	system_u:object_r:mysqld_db_t
> 
> 
> Is the database likely to actually be in /var/lib64/mysql/*?

indeed the fc diff is not needed.
after talking with amd64 maintainers, it looks like the '/var/lib(64)?' is not a gentoo requirement.

thanks,
peter

-- 
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------enig3399A129A58E03A6F93C8849
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBYtt2GSBEIeh4AEYRAk2AAJoDRzEg+f40Vx9Gcv+nBLHZu+O0zACfazLm
Jd1+h6yP5OVMvQMpy41hoH8=
=iTiE
-----END PGP SIGNATURE-----

--------------enig3399A129A58E03A6F93C8849--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
