Message-Id: <200410272039.i9RKdeGl004055@turing-police.cc.vt.edu>
To: jayendren@hivsa.com
Cc: "'steven harp'" <steven.harp@adventiumlabs.org>,
   "'SELinux'" <SELinux@tycho.nsa.gov>
Subject: Re: Limiting the power of can_network, improving the security of strict policy. 
In-Reply-To: Your message of "Wed, 27 Oct 2004 19:27:48 +0200."
             <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAqur+5IHVuUGKlxy5XOOGrsKAAAAQAAAAtvBgX3z5LkOux3E0aOx0UAEAAAAA@hivsa.com>
From: Valdis.Kletnieks@vt.edu
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAqur+5IHVuUGKlxy5XOOGrsKAAAAQAAAAtvBgX3z5LkOux3E0aOx0UAEAAAAA@hivsa.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1352188747P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Wed, 27 Oct 2004 16:39:40 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1352188747P
Content-Type: text/plain; charset=us-ascii

On Wed, 27 Oct 2004 19:27:48 +0200, Jayendren Anand Maduray said:

> Are there n e plans to incorporate biometrics as well as VOS (Virtual
> Operating System) architecture to allow a more secure method of
> authentication?

SELinux is about *authorization*, not authentication.  Your best bet for
securing authentication is to look at customize PAM modules - SELinux
basically assumes that "If PAM allowed this user to login this role, they
must be authenticated, so we'll provide authorization appropriate for
the user's role".

Note that biometrics do *not* automagically make it more secure - in
particular, they don't do very much at all for securing network access.
Improperly used, they make things *worse* (how do you revoke credentials
based on an iris scanner, for instance? ;)

--==_Exmh_1352188747P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBgAeLcC3lWbTT17ARAqa0AKDjtuSmWhudXwwmm5LOVXxSV0G1aQCfV2zo
fLjyQPzzQnC6ddaBFlFP0vk=
=pwcM
-----END PGP SIGNATURE-----

--==_Exmh_1352188747P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
