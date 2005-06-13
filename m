Message-Id: <200506130021.j5D0LkII002227@turing-police.cc.vt.edu>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Question about integration of IPsec with SELinux? 
In-Reply-To: Your message of "Sun, 12 Jun 2005 16:32:33 PDT."
             <20050612233233.18232.qmail@web31610.mail.mud.yahoo.com>
From: Valdis.Kletnieks@vt.edu
References: <20050612233233.18232.qmail@web31610.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1118622104_24934P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Sun, 12 Jun 2005 20:21:45 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1118622104_24934P
Content-Type: text/plain; charset=us-ascii

On Sun, 12 Jun 2005 16:32:33 PDT, Casey Schaufler said:

> You will do well to consider the implications
> of allowing anything other than identical policies
> within a cluster or even a grid. Dealing with
> something as simple as the difference between
> DoD Secret and DoE Secret is a real challange.

Exactly.  This is the most sane way to approach it.

The fun starts when you've got two existing systems and need to
modify the policies so they're identical.

We'll also probably be needing to address the memory consumption issues
again - the current system will go totally bonkers if you have a large
(5K-10K and up) number of different FOO_u roles defined (particularly
messy if you have a large diverse cluster and lots of people who have needs
to use only a few nodes of the cluster.  Possibly the loadable-policy stuff
can be used to load/unload a given user's policy at login/out?

(I'm thinking that this has to be able to play in the same arena as
MS's AD for department-scale management, for lots of nodes under one
administrative control, but not a set of cookie-cutter nodes like in the
usual compute cluster - if others are thinking different goals, they
better speak up now before the un-noticed divergence confuses us all.. ;)

--==_Exmh_1118622104_24934P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCrNGYcC3lWbTT17ARArsEAKDOKkADf813EJD4ryOSwSK6V3h0HwCgvDpR
M56oRNUOQxN0/QGTYAZRFXM=
=axVq
-----END PGP SIGNATURE-----

--==_Exmh_1118622104_24934P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
