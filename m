Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6R0aJrT028905
	for <selinux@tycho.nsa.gov>; Mon, 26 Jul 2004 20:36:19 -0400 (EDT)
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6R0Zn7L018035
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2004 00:35:49 GMT
Message-Id: <200407270036.i6R0a2Xj001502@turing-police.cc.vt.edu>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux ML <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>,
   Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: file_contexts patch 
In-Reply-To: Your message of "Mon, 26 Jul 2004 16:25:53 EDT."
             <1090873552.25761.28.camel@moss-spartans.epoch.ncsc.mil>
From: Valdis.Kletnieks@vt.edu
References: <20040716201531.GB4940@obadja.jmh.mhn.de> <200407170802.08072.russell@coker.com.au> <20040716224252.GD4940@obadja.jmh.mhn.de> <200407171159.00489.russell@coker.com.au> <20040717195326.GA16762@bern.cip.ifi.lmu.de>
            <1090873552.25761.28.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_284301058P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Mon, 26 Jul 2004 20:36:02 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_284301058P
Content-Type: text/plain; charset=us-ascii

On Mon, 26 Jul 2004 16:25:53 EDT, Stephen Smalley said:

> Would it be better to make the distro a tunable (e.g.
> policy/tunables/distro.te) and use ifdef's in the individual .te files
> and .fc files for the distro-specific changes to a given domain?  I'd
> particularly like to see all of the RedHat-specific changes moved from
> rpm.{te,fc} into something that is clearly specific to RedHat.

Go for it.  Especially if we start using m4 to handle the case where the files
are the same, but different distros put them elsewhere - so file_contexts would have

$distro_foobar_dir/foobar.conf -- <whatever>

and then the distro.te could set $distro_foobar_dir as needed.

All the distros that use RPM but aren't RedHat (And I'll argue that for this
purpose, RHEL and Fedora have diverged enough to count) will be happy with
rpm.* not being abused....

--==_Exmh_284301058P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBBaNycC3lWbTT17ARAvCHAKDtjdsARa1MnaGnOJN796EQyNvTGACgr1kW
5s7e6zDhp6zFe9MwcXi0S0M=
=nOaF
-----END PGP SIGNATURE-----

--==_Exmh_284301058P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
