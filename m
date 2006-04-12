Message-Id: <200604122022.k3CKMJ6w013405@turing-police.cc.vt.edu>
To: Gaurav Poothia <gpoothia@cs.sunysb.edu>
Cc: sds@tycho.nsa.gov, SELinux@tycho.nsa.gov
Subject: Re: Untrusted applications under SELinux 
In-Reply-To: Your message of "Wed, 12 Apr 2006 15:57:53 EDT."
             <Pine.GSO.4.53.0604121556280.20146@compserv4>
From: Valdis.Kletnieks@vt.edu
References: <Pine.GSO.4.53.0604121556280.20146@compserv4>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1144873339_6731P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Wed, 12 Apr 2006 16:22:19 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1144873339_6731P
Content-Type: text/plain; charset=us-ascii

On Wed, 12 Apr 2006 15:57:53 EDT, Gaurav Poothia said:

> Under this assumption can you please clarify how SELinux :
> 1.Ensures that the untrusted application doesnt compromise integrity of
> data owned by the executing UID.

There is no reasonable way to keep a user from shooting themselves in the foot.

SELinux is designed to contain the damage and protect the *other* user's feet.

> 2.Lets the app access the parts of the filesystem
> and other resources (media related devices/net resources)
> which the domain it defaulted to (user_t in the strict policy?) might not
> have access to.

That's the protection that SELinux is giving you - keeping you out of stuff
you shouldn't be accessing.

If you want to let this app access things the user can't, you're going to
have to create an SELinux policy for the app, and use a transition...

--==_Exmh_1144873339_6731P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEPWF7cC3lWbTT17ARAnu0AJ9duvgSw8biii89yiTVeAB6z2T71ACg3G1v
cpkuPoqnkR/rXCyiY7NlAXc=
=QOUc
-----END PGP SIGNATURE-----

--==_Exmh_1144873339_6731P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
