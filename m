Subject: preserving user-set contexts
From: Colin Walters <walters@redhat.com>
To: SELinux@tycho.nsa.gov
Cc: sds@epoch.ncsc.mil
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-SA9DYMPSuCvS6A59v24m"
Message-Id: <1082752649.12608.111.camel@nexus.verbum.private>
Mime-Version: 1.0
Date: Fri, 23 Apr 2004 16:37:29 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-SA9DYMPSuCvS6A59v24m
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Often I manually change file contexts; for example, I create a toplevel
/build directory where I store random binary builds I create.  Right now
I just use staff_home_t so my regular user can access it.  However, if I
was ever to do a 'make relabel', all of those contexts would get blown
away and reset to default_t.

What I think would be nice is if we had chcon set another extended
attribute that marked the file as having its context manually set.  Then
we modify setfiles to ignore files which have this extended attribute by
default.  That way I could use 'make relabel' to fix system contexts,
and leave my customizations intact.

Probably this would involve a libselinux API addition for setfilecon,
perhaps setfilecon_user.

Is this desirable?  Does it seem like the right approahc?  One question
is - which namespace to put it in?  user.?  system.?  If we allow
regular users to relabel (as we already do for files like
httpd_user_script_exec_t) then we can only put it in the user.
namespace.



--=-SA9DYMPSuCvS6A59v24m
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAiX6JOIkJWWp2WGURAtIbAKCBPOH0Ti6MNTxN925AtgzX25ZbbQCdECvq
0pa/uorXX34p2tk6xj9Vh5k=
=PrsF
-----END PGP SIGNATURE-----

--=-SA9DYMPSuCvS6A59v24m--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
