Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4BF23Rb022358
	for <selinux@tycho.nsa.gov>; Tue, 11 May 2004 11:02:03 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4BF1xYW022600
	for <selinux@tycho.nsa.gov>; Tue, 11 May 2004 15:01:59 GMT
Received: from turing-police.cirt.vt.edu (turing-police.cirt.vt.edu [128.173.54.129])
        by jazzband.ncsc.mil  with ESMTP id i4BF1xBf022597 for <selinux@tycho.nsa.gov>; Tue, 11 May 2004 15:01:59 GMT
Message-Id: <200405111501.i4BF1jfv017860@turing-police.cc.vt.edu>
To: Wade Mr Robert C <WadeRC@hoa.centcom.mil>
Cc: selinux@tycho.nsa.gov
Subject: Re: Japanese Documentation(Re: presentation results) 
In-Reply-To: Your message of "Tue, 11 May 2004 12:27:58 +0300."
             <DA7A114F43B3504CAF05FF66FB5649F06D4997@hoan04ex.hoa.centcom.mil>
From: Valdis.Kletnieks@vt.edu
References: <DA7A114F43B3504CAF05FF66FB5649F06D4997@hoan04ex.hoa.centcom.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-346970112P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 11 May 2004 11:01:45 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-346970112P
Content-Type: text/plain; charset=us-ascii

On Tue, 11 May 2004 12:27:58 +0300, Wade Mr Robert C <WadeRC@hoa.centcom.mil>  said:
> anyone have policy info for installing selinux on secure systems (rated
> catII/III), 
> for example, on a firewall nic server?

This *should* be trivial, if you already have a standard for what should/shouldn't
be on a firewall...

1) Do your normal (very minimal for a firewall) install.
2) Install the policy-sources stuff.
3) cd /etc/security/selinux/src/policy, and go through the
subdirectories and remove the .te and .fc files that correspond
to software you don't have on the box.
4) 'make reload; make relabel' and you *should* be done..

(Note, I'm writing this pre-caffeine this morning, somebody please yell if
I've severely mis-stated something....)

--==_Exmh_-346970112P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAoOrYcC3lWbTT17ARAqQHAKDuBnNaIwgzXnCLisuxBg9UlZIe2QCfUwFv
eKihRIxzj5corf0jroDs4BE=
=dA6P
-----END PGP SIGNATURE-----

--==_Exmh_-346970112P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
