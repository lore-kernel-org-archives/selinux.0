Message-Id: <200409172007.i8HK7W3w005709@turing-police.cc.vt.edu>
To: "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>
Cc: "George C. Wilson" <ltcgcw@us.ibm.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Boolean utilities segv's 
In-Reply-To: Your message of "Fri, 17 Sep 2004 15:56:19 EDT."
             <1095450979.17932.317.camel@moss-spartans.epoch.ncsc.mil>
From: Valdis.Kletnieks@vt.edu
References: <20040917193839.GA3020@us.ibm.com>
            <1095450979.17932.317.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-269912029P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 17 Sep 2004 16:07:31 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-269912029P
Content-Type: text/plain; charset=us-ascii

On Fri, 17 Sep 2004 15:56:19 EDT, Stephen Smalley said:

> Ok, we can certainly fix this, but note that these functions are not
> going to work on a non-SELinux system regardless; you shouldn't even be
> calling them (or running those utilities) on a non-SELinux system.

Probably should put in code like this:

	fprintf(stderr,"%0: running on non-SELinux system, aborting", argv[0]);
	exit(1);

in case some script or other doesn't do the check itself. I can imagine a package
that includes some SELinux policies that include a bool or two - and the package
installer software getting this wrong....

--==_Exmh_-269912029P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBS0QDcC3lWbTT17ARAktmAKD7J0pR7SY6Op51tnTvMxX0iwgPSwCg0Mwr
K62FYedEvps9mIvN3tKpFYk=
=3fuy
-----END PGP SIGNATURE-----

--==_Exmh_-269912029P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
