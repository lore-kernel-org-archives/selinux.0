Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i43I3ARb007469
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 14:03:10 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i43I38YW024386
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 18:03:08 GMT
Received: from turing-police.cirt.vt.edu (turing-police.cirt.vt.edu [128.173.54.129])
        by jazzband.ncsc.mil  with ESMTP id i43I37Bf024381 for <selinux@tycho.nsa.gov>; Mon, 3 May 2004 18:03:08 GMT
Message-Id: <200405031802.i43I2sw2001668@turing-police.cc.vt.edu>
To: russell@coker.com.au
Cc: fedora-selinux-list@redhat.com, selinux@tycho.nsa.gov
Subject: Re: Policy file for 'aide' and/or 'tripwire'? 
In-Reply-To: Your message of "Mon, 03 May 2004 02:45:39 +1000."
             <200405030245.39737.russell@coker.com.au>
From: Valdis.Kletnieks@vt.edu
References: <200404271752.i3RHqC8E015562@turing-police.cc.vt.edu>
            <200405030245.39737.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1368706479P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 03 May 2004 14:02:54 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1368706479P
Content-Type: text/plain; charset=us-ascii

On Mon, 03 May 2004 02:45:39 +1000, Russell Coker said:
> On Wed, 28 Apr 2004 03:52, Valdis.Kletnieks@vt.edu wrote:
> > Has anybody already done a policy file for Tripwire or its
> > open-sourced replacement 'aide'?
> 
> Why not run it in the domain backup_t?  Tripwire and backup programs both need 
> read access to all files..

Good hint - I'll have to chase that.  Looks like it's almost but not quite what I
want - looks like a few lines of tweaking should suffice (I'm pretty sure that
can_network can be heaved over the side of the .te file, and I need other directories
labeled with backup_store_t in the .fc file).



--==_Exmh_1368706479P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAlolNcC3lWbTT17ARAtQdAJ0Y7uxaHcgTBLYRkjzM6zFs5G444QCgyFOu
b/1CmpYHReNqQBkk2llZdag=
=Z03U
-----END PGP SIGNATURE-----

--==_Exmh_1368706479P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
