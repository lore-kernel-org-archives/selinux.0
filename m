Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i69HUgrT020858
	for <selinux@tycho.nsa.gov>; Fri, 9 Jul 2004 13:30:42 -0400 (EDT)
Received: from turing-police.cirt.vt.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i69HUbNT013479
	for <selinux@tycho.nsa.gov>; Fri, 9 Jul 2004 17:30:40 GMT
Message-Id: <200407091730.i69HUMZG030402@turing-police.cc.vt.edu>
To: Bradley Chapman <kakadu@gmail.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, selinux@tycho.nsa.gov,
   russell@coker.com.au
Subject: Re: An SELinux policy for Red Hat 9 
In-Reply-To: Your message of "Fri, 09 Jul 2004 15:52:00 BST."
             <e294b46e0407090752b199eeb@mail.gmail.com>
From: Valdis.Kletnieks@vt.edu
References: <e294b46e040708131736c57b6@mail.gmail.com> <200407092111.55045.russell@coker.com.au> <e294b46e0407090443663d55c4@mail.gmail.com> <1089375253.11726.34.camel@moss-spartans.epoch.ncsc.mil>
            <e294b46e0407090752b199eeb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-748311580P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 09 Jul 2004 13:30:21 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-748311580P
Content-Type: text/plain; charset=us-ascii

On Fri, 09 Jul 2004 15:52:00 BST, Bradley Chapman said:

> If I do decide to move to FC2, how difficult will it then become to
> adapt the SELinux policy
> to my needs?

This will of course depend on how divergent your needs are from either
the 'targeted' or 'strict' policies already in the tree.  The biggest issue
is whether you have a custom application that needs policy written (and
there's tools to assist in that).

--==_Exmh_-748311580P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFA7tYtcC3lWbTT17ARAtY8AJ4782spWkflWHhZeRjS2Uh2zZrAhACgoY++
W4R8sRvftypiCfF/IcofybM=
=5Jjy
-----END PGP SIGNATURE-----

--==_Exmh_-748311580P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
