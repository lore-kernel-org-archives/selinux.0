Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TKv0rT022595
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 16:57:00 -0400 (EDT)
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6TKuTbB019711
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 20:56:29 GMT
Message-Id: <200407292056.i6TKutDm006017@turing-police.cc.vt.edu>
To: James Morris <jmorris@redhat.com>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   Stephen Smalley <sds@epoch.ncsc.mil>, Joshua Brindle <method@gentoo.org>,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: temporary hack to use udev in selinux 
In-Reply-To: Your message of "Thu, 29 Jul 2004 13:04:45 EDT."
             <Xine.LNX.4.44.0407291303140.16390-100000@dhcp83-76.boston.redhat.com>
From: Valdis.Kletnieks@vt.edu
References: <Xine.LNX.4.44.0407291303140.16390-100000@dhcp83-76.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1116499148P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Thu, 29 Jul 2004 16:56:54 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1116499148P
Content-Type: text/plain; charset=us-ascii

On Thu, 29 Jul 2004 13:04:45 EDT, James Morris said:
> On Thu, 29 Jul 2004, Luke Kenneth Casson Leighton wrote:
> 
> >  p.s. has anyone considered doing a macro for these "pseudo" xattrs?
> >       or merging them into one bit of code?
> 
> Yes, I was looking at making a library but it didn't work out.  Macros 
> may do the job, but I'm not sure how acceptable these would be upstream.

How hard would it be to recast them from macros to functions?

There's plenty of places where macro-sized pieces of code are done
with 'static inline foo()' - look in include/linux/fs.h for
plenty of examples.

--==_Exmh_1116499148P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBCWSWcC3lWbTT17ARApThAJ42NDXAXL0UxsG9u3HZKqhRkX2zwQCg2lZ/
11KZUuQodCl5vxym7wPKx6k=
=6UDw
-----END PGP SIGNATURE-----

--==_Exmh_1116499148P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
