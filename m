Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6RHHXrT004015
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2004 13:17:33 -0400 (EDT)
Received: from turing-police.cc.vt.edu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6RHHWup010333
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2004 17:17:32 GMT
Message-Id: <200407271717.i6RHHFdt008474@turing-police.cc.vt.edu>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux ML <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>,
   Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: file_contexts patch 
In-Reply-To: Your message of "Tue, 27 Jul 2004 09:38:03 EDT."
             <1090935483.2448.71.camel@moss-spartans.epoch.ncsc.mil>
From: Valdis.Kletnieks@vt.edu
References: <20040716201531.GB4940@obadja.jmh.mhn.de> <200407170802.08072.russell@coker.com.au> <20040716224252.GD4940@obadja.jmh.mhn.de> <200407171159.00489.russell@coker.com.au> <20040717195326.GA16762@bern.cip.ifi.lmu.de> <1090873552.25761.28.camel@moss-spartans.epoch.ncsc.mil>
            <1090935483.2448.71.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-2085497731P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 27 Jul 2004 13:17:15 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-2085497731P
Content-Type: text/plain; charset=us-ascii

On Tue, 27 Jul 2004 09:38:03 EDT, Stephen Smalley said:

> Note that in addition to reviewing the contents of rpm.te and rpm.fc for
> RedHat-specific customizations, this change would require reviewing all
> uses of ifdef(`rpm.te') throughout the various .te files, as some of
> those conditional blocks are for RedHat-specific customizations while
> others are for rules that should always be included when the rpm domain
> is enabled in the policy (and thus should still be included for other
> rpm-using distros).

But still.. <Insert sound clip of Wilford Brimley "It's the right thing to do"> :)

--==_Exmh_-2085497731P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBBo4bcC3lWbTT17ARAmZiAKCSKoeOXC/7LMbCjAAFxwcrnvjk6wCcCxCg
0Rk0RF03I3kh/exfnS/oRFA=
=9Ace
-----END PGP SIGNATURE-----

--==_Exmh_-2085497731P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
