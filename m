Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8PM7CrT025092
	for <selinux@tycho.nsa.gov>; Sat, 25 Sep 2004 18:07:13 -0400 (EDT)
Received: from crisium.vnl.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8PM7BAk027346
	for <selinux@tycho.nsa.gov>; Sat, 25 Sep 2004 22:07:11 GMT
Date: Sat, 25 Sep 2004 23:07:08 +0100
From: Dale Amon <amon@vnl.com>
To: Russell Coker <russell@coker.com.au>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Remove unrestricted_admin
Message-ID: <20040925220708.GB15912@vnl.com>
References: <200409211526.37810.russell@coker.com.au> <200409252039.01196.russell@coker.com.au> <1096119005.11665.21.camel@gorn.pebenito.net> <200409260121.10665.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
In-Reply-To: <200409260121.10665.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 26, 2004 at 01:21:10AM +1000, Russell Coker wrote:
> Corner cases that happen to be a regular part of any sys-admin's job.

I massively agree. Lots of people do 'ghosting'; lots
of people back up entire disk images before doing
something dangerous. Now I've got ways around a lot
of the problems anyway because I've a root boot floppy
I use. Boot a machine off an nfs root; mount a Real Big
Disk over nfs, and then dd the whole frigging host
system disk to the destination system where it
can be worked on.=20

Although it is not my primary use for this (mostly I
do R&D), think forensics too. Think of all the various
tools in use for setting up a master image and dupping
it to N other machines.

Also, dd with a decent block speed is an awesomely=20
fast way to back up a disk.

--=20
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBVewLZHES7UL0zXERAoBLAJ4rGFboGobidDL6rSWT9GMGSsqavQCfcbd+
Q63an3+QVzulE5bHHsN3Qes=
=HLHj
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
