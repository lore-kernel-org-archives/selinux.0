Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i95HK6rT027920
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 13:20:06 -0400 (EDT)
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i95HIwPe006488
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 17:18:59 GMT
Message-Id: <200410051720.i95HJx2D017969@turing-police.cc.vt.edu>
To: petre rodan <kaiowas@gentoo.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: gentoo diff for mysqld 
In-Reply-To: Your message of "Tue, 05 Oct 2004 11:29:40 +0300."
             <41625B74.2090503@gentoo.org>
From: Valdis.Kletnieks@vt.edu
References: <41625B74.2090503@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-242332346P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 05 Oct 2004 13:19:58 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-242332346P
Content-Type: text/plain; charset=us-ascii

On Tue, 05 Oct 2004 11:29:40 +0300, petre rodan said:

> attached you'll find a diff for the mysql policy.

> -/var/lib/mysql(/.*)?		system_u:object_r:mysqld_db_t
> +/var/lib(64)?/mysql(/.*)?	system_u:object_r:mysqld_db_t

Is the database likely to actually be in /var/lib64/mysql/*?

--==_Exmh_-242332346P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBYte8cC3lWbTT17ARAspKAJ9/O69RiZwSzg2yCKQTGrN+8MOTWwCgyp5c
yPAAryl4V083Zp/M2xCOYP0=
=gCEu
-----END PGP SIGNATURE-----

--==_Exmh_-242332346P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
