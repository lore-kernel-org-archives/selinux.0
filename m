Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBAFMbIi020790
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 10:22:37 -0500 (EST)
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBAFKxwg000838
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 15:20:59 GMT
Message-Id: <200412101522.iBAFMXl7024547@turing-police.cc.vt.edu>
To: Russell Coker <rcoker@redhat.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
   Stephen Smalley <sds@epoch.ncsc.mil>, Daniel J Walsh <dwalsh@redhat.com>,
   SE Linux list <selinux@tycho.nsa.gov>, Joshua Brindle <jbrindle@snu.edu>,
   Jim Carter <jwcart2@epoch.ncsc.mil>, Colin Walters <walters@redhat.com>,
   Nalin Dahyabhai <nalin@redhat.com>
Subject: Re: Single home directory type for all roles. 
In-Reply-To: Your message of "Fri, 10 Dec 2004 23:20:26 +1100."
             <1102681226.4509.139.camel@aeon>
From: Valdis.Kletnieks@vt.edu
References: <20041209200301.59535.qmail@web50204.mail.yahoo.com>
            <1102681226.4509.139.camel@aeon>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1825793568P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 10 Dec 2004 10:22:33 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1825793568P
Content-Type: text/plain; charset=us-ascii

On Fri, 10 Dec 2004 23:20:26 +1100, Russell Coker said:
> On Thu, 2004-12-09 at 12:03 -0800, Casey Schaufler wrote:
> > In the U2X world the issue of /tmp was solved
> 
> What is U2X?

For a moment, I thought it was an i18n-style contraction of unix, except
that the /tmp issue isn't by any means solved in "the unix world".  Or if
it *is* solved there, it's not actually made it into AIX, Irix, Tru64, or Solaris.
So I have no idea what Casey's talking about.  There might be some hooks in
some Unixoids to help assist, but I don't know of anyplace where it's a fully
integrated solution...

I'll note that IBM played with "hidden directories" in the TCF component
of their AIX/370 product - and it didn't make the jump into AIX 3 and later.

--==_Exmh_1825793568P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBub84cC3lWbTT17ARAjblAJ0ZKqWWFAEZHi4kPc9Pa3vD4NqSewCg+r4A
5/Fzjh4XfH9o+FXq1fHv+gc=
=nbgZ
-----END PGP SIGNATURE-----

--==_Exmh_1825793568P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
