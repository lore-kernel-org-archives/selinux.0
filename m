Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2QKdHRb025919
	for <selinux@tycho.nsa.gov>; Fri, 26 Mar 2004 15:39:17 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i2QKdGFV021199
	for <selinux@tycho.nsa.gov>; Fri, 26 Mar 2004 20:39:16 GMT
Received: from turing-police.cc.vt.edu (turing-police.cc.vt.edu [128.173.14.107])
        by jazzband.ncsc.mil  with ESMTP id i2QKdF36021192 for <selinux@tycho.nsa.gov>; Fri, 26 Mar 2004 20:39:16 GMT
Message-Id: <200403262039.i2QKdELb020746@turing-police.cc.vt.edu>
To: Koen Vervloesem <koen.vervloesem@student.kuleuven.ac.be>
Cc: selinux@tycho.nsa.gov
Subject: Re: make relabel: invalid context 
In-Reply-To: Your message of "Fri, 26 Mar 2004 18:34:28 +0100."
             <D571AD7F-7F4B-11D8-A7FC-000A95D903E6@student.kuleuven.ac.be>
From: Valdis.Kletnieks@vt.edu
References: <D571AD7F-7F4B-11D8-A7FC-000A95D903E6@student.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1499480008P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 26 Mar 2004 15:39:14 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1499480008P
Content-Type: text/plain; charset=us-ascii

On Fri, 26 Mar 2004 18:34:28 +0100, Koen Vervloesem <koen.vervloesem@student.kuleuven.ac.be>  said:

> /usr/sbin/setfiles:  invalid context system_u:object_r:tetex_data_t on 
> line number 56
> Exiting after 10 errors.
> make: *** [relabel] Fout 1
> root@carnivore:/etc/selinux#
> 
> I can't find an error in the configuration files. Does anyone know 
> what's wrong here?

This often happens if the file_contexts doesn't match the loaded policy.
I've found 'make reload' and then re-'make relabel' fixes it.

--==_Exmh_1499480008P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAZJTycC3lWbTT17ARAij8AKDAvKdTdjfFsLnMnkOl7wlqTGr3QQCglfea
3F51wAWwGYwCEkQtQK6f5Rw=
=W2a0
-----END PGP SIGNATURE-----

--==_Exmh_1499480008P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
