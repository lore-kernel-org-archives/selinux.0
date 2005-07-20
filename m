Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6KH8kgA018354
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 13:08:46 -0400 (EDT)
Received: from crisium.vnl.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6KH4IDg019407
	for <selinux@tycho.nsa.gov>; Wed, 20 Jul 2005 17:04:19 GMT
Date: Wed, 20 Jul 2005 17:59:37 +0100
From: Dale Amon <amon@vnl.com>
To: Dale Amon <amon@vnl.com>, selinux@tycho.nsa.gov
Subject: Re: Suse selinux policy
Message-ID: <20050720165937.GB18922@vnl.com>
References: <20050718234403.GA30685@vnl.com> <20050720103541.GB8124@thorium.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
In-Reply-To: <20050720103541.GB8124@thorium.jmh.mhn.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 20, 2005 at 12:35:43PM +0200, Thomas Bleher wrote:
> I don't know about SLES9 but afaik most SuSE products don't contain a
> policy package (I once saw one for an older version but it was very
> outdated). From what I've heard SuSE favors AppArmor over SELinux so
> it's unlikely they will support SELinux[1].

It doesn't make sense to me. Why would the kernel in
SLES9 have selinux compiled in (with default boot of
selinux=3D0) and the CD's contain libselinux, policycoreutils,
etc, etc, and no policy? The Novell OES version uses
the same disk set as well, I have been working
with both over the last month.

--=20
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC3oL5ZHES7UL0zXERAgNeAJ4uozRQNJM2uHA5kU7V6F/zCmvh+wCeIYr+
0EEALVOfNnyUSFYl04YX+CA=
=QqIX
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
