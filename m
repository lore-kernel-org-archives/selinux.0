Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9KeoIi016061
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 15:40:50 -0500 (EST)
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9KdCPS024115
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 20:39:12 GMT
Message-Id: <200412092040.iB9KelRx032136@turing-police.cc.vt.edu>
To: Russell Coker <rcoker@redhat.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Daniel J Walsh <dwalsh@redhat.com>,
   SE Linux list <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@snu.edu>,
   Jim Carter <jwcart2@epoch.ncsc.mil>, Colin Walters <walters@redhat.com>,
   Nalin Dahyabhai <nalin@redhat.com>
Subject: Re: Single home directory type for all roles. 
In-Reply-To: Your message of "Fri, 10 Dec 2004 05:12:31 +1100."
             <1102615951.4509.50.camel@aeon>
From: Valdis.Kletnieks@vt.edu
References: <20041207000805.GH3678@jmh.mhn.de> <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil> <41B8826D.30105@redhat.com> <1102612828.32175.159.camel@moss-spartans.epoch.ncsc.mil> <1102614445.4509.25.camel@aeon> <1102614805.32175.176.camel@moss-spartans.epoch.ncsc.mil>
            <1102615951.4509.50.camel@aeon>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1204841214P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Thu, 09 Dec 2004 15:40:47 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1204841214P
Content-Type: text/plain; charset=us-ascii

On Fri, 10 Dec 2004 05:12:31 +1100, Russell Coker said:

> The solution then would be to have a separate domain for the
> administrator to run ls which can read all sym-links while other
> programs the administrator may run (rm, cp, mv, etc) will be denied
> access to read many types of sym-link.  Is this a good idea?

Probably not - then you get into a situation where you try to mv/rm/cp
something, it fails, and when you run ls, it looks like it should work....

--==_Exmh_1204841214P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBuLhOcC3lWbTT17ARApycAJ9xz7at2ZkNn8q+NKJ6vACKv7OPfwCeIRCY
r9rwoULJpvp4Znm+6lzV1YA=
=baj9
-----END PGP SIGNATURE-----

--==_Exmh_1204841214P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
