Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8Q9M5rT026682
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 05:22:05 -0400 (EDT)
Received: from crisium.vnl.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8Q9L376011123
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 09:21:03 GMT
Date: Sun, 26 Sep 2004 10:21:51 +0100
From: Dale Amon <amon@vnl.com>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Dale Amon <amon@vnl.com>, Russell Coker <russell@coker.com.au>,
   "Christopher J. PeBenito" <cpebenito@tresys.com>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: Remove unrestricted_admin
Message-ID: <20040926092151.GA8079@vnl.com>
References: <200409211526.37810.russell@coker.com.au> <200409252039.01196.russell@coker.com.au> <1096119005.11665.21.camel@gorn.pebenito.net> <200409260121.10665.russell@coker.com.au> <20040925220708.GB15912@vnl.com> <415609AD.5000808@tresys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
In-Reply-To: <415609AD.5000808@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 25, 2004 at 08:13:33PM -0400, Joshua Brindle wrote:
> I _really_ hope you aren't suggesting that you do a dd from a host disk=
=20
> to something else while a machine is in production. This _will_ lead to=
=20
> an inconsistant image and I don't think I need to explain why.

No, I umount the partition first. For system disks
I do the backup as described, with a root-nfs floppy
boot.

Last year I recovered data off a badly bolloxed Thinkpad
disk after someone knocked my laptop off a sofa while
I was travelling for several months. Lots of work had
to be recovered. I used the ability to seek to pull
all the undamaged blocks off and step around the=20
blocks which locked up the IDE controller; then I
used a program to reassemble the saved blocks in
order with zero blocks where the destroyed areas
were... and then I loopback mounted the result and
recovered about 99.999%. Actually I recoverd 100%
of what matters.

Since I did this with an NFS boot, it doesn't=20
matter to selinux (hell, last spring I was building
selinux into a ghost loopback and then dd'ing it to
the very slow test machines; only the
issue of umount/dd backup/mount of partitions matters
in general usage.

--=20
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBVoouZHES7UL0zXERAqdrAJ9VU9Hdo2g3vsR6ncfmF8bSYHkmcwCfXg2h
SrauxOipUr306tPM2RuQNb4=
=ao+P
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
