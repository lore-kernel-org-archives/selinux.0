Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h71HdKHa009904
	for <selinux@tycho.nsa.gov>; Fri, 1 Aug 2003 13:39:20 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h71Hc7FB027828
	for <selinux@tycho.nsa.gov>; Fri, 1 Aug 2003 17:38:07 GMT
Received: from ryojusen (syr-24-24-5-27.twcny.rr.com [24.24.5.27])
	by jazzswing.ncsc.mil  with ESMTP id h71Hc6GD027819
	for <selinux@tycho.nsa.gov>; Fri, 1 Aug 2003 17:38:06 GMT
Received: from [128.230.14.45] (helo=naritai)
	by ryojusen with esmtp (Exim 3.36 #1 (Debian))
	id 19ids5-0004jD-00
	for <selinux@tycho.nsa.gov>; Fri, 01 Aug 2003 13:39:17 -0400
Received: from david by naritai with local (Exim 3.36 #1 (Debian))
	id 19idrw-0005R4-00
	for <selinux@tycho.nsa.gov>; Fri, 01 Aug 2003 13:39:08 -0400
To: selinux@tycho.nsa.gov
Subject: SELinux Database Admin
From: David Walter<dwalter@syr.edu>
Reply-To: dwalter@syr.edu
Date: Fri, 01 Aug 2003 13:39:08 -0400
Message-ID: <87isph9t1f.fsf@syr.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


The Systems Assurance  Institute @ Syracuse  University is  working on
developing  tools for administering  selinux policy, an selinux policy
database administrator.

The original  goals of  the project  were to  develop an interface for
policy maintenance   and policy querying  with supporting  validations
tools.

The  design  has  grown to   include  features  in support of   policy
maintenance with interactive   validation and type equivalence  / type
unification options.

We are  in the process  of putting together a  web site and public cvs
repository with  the source  for  the  QT  interface, screen  shots of
sample application and postgresql database build procedures.

We are also working  on testing on Debian  unstable and Redhat systems
(8 and  9)  anticipating that this  will approximate  the timing  of a
release of the system.



- -- 
pub  1024D/DC92AE30 2002-02-26 David Walter <dwalter@syr.edu>
fingerprint = 50A0 E513 732D 1D0F BD26  C84E A8DD 9D80 DC92 AE30
sub  2048g/51023582 2002-02-26
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8 <http://mailcrypt.sourceforge.net/>

iD8DBQE/KqC9qN2dgNySrjARAu/YAJ9Eal1XbbFTaxuNCAv8bp+s084gewCgh/51
Q8NYAXb72sGL9c+vqaNloII=
=AYhL
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
