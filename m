Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3S1jcRb003113
	for <selinux@tycho.nsa.gov>; Tue, 27 Apr 2004 21:45:38 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i3S1hPa1002713
	for <selinux@tycho.nsa.gov>; Wed, 28 Apr 2004 01:43:26 GMT
Subject: Re: preserving user-set contexts
From: Colin Walters <walters@redhat.com>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@epoch.ncsc.mil>
In-Reply-To: <1082989812.22940.43.camel@moss-spartans.epoch.ncsc.mil>
References: <1082752649.12608.111.camel@nexus.verbum.private>
	 <1082989812.22940.43.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RPam8RUC1MV0Q7ZVpNXh"
Message-Id: <1083116682.3390.34.camel@nexus.verbum.private>
Mime-Version: 1.0
Date: Tue, 27 Apr 2004 21:44:42 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-RPam8RUC1MV0Q7ZVpNXh
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-04-26 at 10:30, Stephen Smalley wrote:

> It wouldn't be safe to allow untrusted users to mark files in this
> manner, as it could prevent proper relabeling of the filesystem upon a
> policy update. =20

Well, users should still be stopped by DAC in setting xattrs on files
they didn't own, which covers all the practical cases I can think of
right now.  But it would be nice to have a SELinux solution to this, see
below.

> So you would have to limit it to administrators anyway.=20

A much better example than the /build one I gave originally is
httpd_user_content_t.  Users should be able to use chcon to change the
types of specific files in their home directory to allow the webserver
access.  Right now, an administrator running setfiles will blow away all
of those changes and reset them to user_home_t.  I think this is going
to be pretty undesirable in almost all situations.  Certainly an admin
should be able to reset all these types if they desire, but I don't
think it makes sense as the default.

As more policy is written I'm sure there will be other examples of types
that are useful to users.

> And if they are administrators, they can already mark the files with
> <<none>> in the file contexts configuration. =20

I don't think administrators should generally have to edit
file_contexts.  The whole idea of using xattrs is that it makes
management much easier.  And especially for user-set contexts like
httpd_user_content_t, one can't expect the administrator to track every
user's web content.

> You could also introduce a
> separate type in the policy that setfiles doesn't have permission to
> relabelfrom, and use that type for this purpose.

But that would lose the distinction between all user-changeable types;
it doesn't make sense to me.

> I don't think it is the right approach. =20

Ok.  For the /build problem, we could add an option for setfiles to
simply ignore unknown files instead of using default_t.  For the
httpd_user_content_t problem, we could add an attribute e.g.
"customizable_type".  setfiles would by default not relabel that have
this type.



--=-RPam8RUC1MV0Q7ZVpNXh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAjwyJOIkJWWp2WGURAlNiAJ99yjrlb34o5r4ngSpMMdon3irS9wCeJ2xV
m2NGkvmd1C3qQTWS96nBiik=
=AZQ6
-----END PGP SIGNATURE-----

--=-RPam8RUC1MV0Q7ZVpNXh--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
