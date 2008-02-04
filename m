Subject: Re: su problems again
From: Jeremiah Jahn <jeremiah@goodinassociates.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1202152318.3070.121.camel@moss-spartans.epoch.ncsc.mil>
References: <1202151733.2801.116.camel@bluejay.goodinassociates.com>
	 <1202152318.3070.121.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-6i2+u7aEvYcUTnncMoZe"
Date: Mon, 04 Feb 2008 13:40:13 -0600
Message-Id: <1202154013.2801.119.camel@bluejay.goodinassociates.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-6i2+u7aEvYcUTnncMoZe
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Apparently I'm not. I'm using 1.33 on a pretty clean RHEL5 box. Any idea
of how difficult it will be to jump to the devel version? Or is there
another way to disable the dontaudits?


On Mon, 2008-02-04 at 14:11 -0500, Stephen Smalley wrote:
> On Mon, 2008-02-04 at 13:02 -0600, Jeremiah Jahn wrote:
> > Is there some way to turn of the dontaudit  w/ the refpolicy and a
> > module policy build. make enableaudit seems to only change the base
> > policy, and not any of the policies that actually do anything.=20
> >=20
> > This is with the refpolicy selinux-refpolicy-sources-20071214-1 running
> > on RHEL5.=20
> >=20
> > For some reason, when the policy is enforced, I can't su  from a staff_=
r
> > user, yet when I try with enforcing=3D0 I don't get any audit messages,
> > and I'm not really comfortable modifying every user oriented admin
> > modules to remove the dontaudit rules. doing so in su.te helped find a
> > few things, but I'm not sure what's blocking it now.=20
>=20
> If using a recent semodule, you can do semodule -DB to strip the entire
> policy of dontaudit rules and load the result, then semodule -B to
> revert to the original policy.
>=20
In 1880 the French captured Detroit but gave it back ... they couldn't
get parts.

--=-6i2+u7aEvYcUTnncMoZe
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHp2od6caZY8jbHDkRAtLoAKCjcogw84UPn5Vdsjv8VXyGO4p6fQCfW6DE
8WmJq3l9zrdxN52F2cN58r8=
=oeWw
-----END PGP SIGNATURE-----

--=-6i2+u7aEvYcUTnncMoZe--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
