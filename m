Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBLKXEIi023643
	for <selinux@tycho.nsa.gov>; Tue, 21 Dec 2004 15:33:14 -0500 (EST)
Received: from h80ad2542.async.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBLKVRNU005603
	for <selinux@tycho.nsa.gov>; Tue, 21 Dec 2004 20:31:28 GMT
Message-Id: <200412212032.iBLKWDgV025367@turing-police.cc.vt.edu>
To: russell@coker.com.au
Cc: James Morris <jmorris@redhat.com>,
   Casey Schaufler <casey@schaufler-ca.com>,
   Darrel Goeddel <dgoeddel@TrustedCS.com>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: [patch] selinux_capget() 
In-Reply-To: Your message of "Mon, 20 Dec 2004 12:10:20 +1100."
             <200412201210.25544.russell@coker.com.au>
From: Valdis.Kletnieks@vt.edu
References: <Xine.LNX.4.44.0412140104020.30724-100000@thoron.boston.redhat.com>
            <200412201210.25544.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1467194476P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 21 Dec 2004 15:32:13 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1467194476P
Content-Type: text/plain; charset=us-ascii

On Mon, 20 Dec 2004 12:10:20 +1100, Russell Coker said:

> If program A calls capget() and determines that it does not have a certain 
> capability then it does not need to drop that capability before executing 
> program B which should not have it.
> 
> However if executing program B causes a domain transition to a domain that is
> permitted the capability in question then it might suddenly acquire access to
> a capability that program A thought was unavailable.

On the other hand, in that case B would still have access to the capability
in question, even if A *had* dropped the capability.

--==_Exmh_1467194476P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFByIhMcC3lWbTT17ARAtkxAKCsBMF4c+ObtaBo83NfZ5pL2nOLTwCg2k15
pZeAqgFx5feLB8QOjb/d4eM=
=E0tU
-----END PGP SIGNATURE-----

--==_Exmh_1467194476P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
