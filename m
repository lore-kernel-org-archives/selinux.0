Subject: Re: su problems again
From: Jeremiah Jahn <jeremiah@goodinassociates.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <1202156860.3070.132.camel@moss-spartans.epoch.ncsc.mil>
References: <1202151733.2801.116.camel@bluejay.goodinassociates.com>
	 <1202152318.3070.121.camel@moss-spartans.epoch.ncsc.mil>
	 <1202154013.2801.119.camel@bluejay.goodinassociates.com>
	 <1202155858.3070.127.camel@moss-spartans.epoch.ncsc.mil>
	 <1202156505.2801.122.camel@bluejay.goodinassociates.com>
	 <1202156860.3070.132.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sQmDWHN5psHfFl52iiOQ"
Date: Mon, 04 Feb 2008 14:41:34 -0600
Message-Id: <1202157694.2801.128.camel@bluejay.goodinassociates.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-sQmDWHN5psHfFl52iiOQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Any idea what this is about?

policy/modules/system/mount.te:18:ERROR 'syntax error' at token
'typeattribute' on line 844559:

This is the third one I've gotten. I got the same error for mono and
monop. This is why I didn't just change the build.conf file. I seem to
be able to move on to the next on if I set this back to module instead
of base, but this seems to not seem right to me.=20

On Mon, 2008-02-04 at 15:27 -0500, Stephen Smalley wrote:
> On Mon, 2008-02-04 at 14:21 -0600, Jeremiah Jahn wrote:
> > that generally resorts to errors like:
> > make: *** No rule to make target `usbbases.if', needed by `tmp/all_inte=
rfaces.conf'.  Stop.
>=20
> Ah, that's just because my sample sed script was a bit too aggressive
> and changed usbmodules =3D module to usbbases =3D base ;)  Just fix that =
by
> hand and you should be fine.  Chris likely knows a cleaner way to do it
> (cc'd).
>=20
> >=20
> > or when I just changed the build.conf to monolithic=3Dy mono.te throws
> > errors. At least the modules actually compile.
> >=20
> > -jj-
> >=20
> >=20
> > On Mon, 2008-02-04 at 15:10 -0500, Stephen Smalley wrote:
> > > On Mon, 2008-02-04 at 13:40 -0600, Jeremiah Jahn wrote:
> > > > Apparently I'm not. I'm using 1.33 on a pretty clean RHEL5 box. Any=
 idea
> > > > of how difficult it will be to jump to the devel version? Or is the=
re
> > > > another way to disable the dontaudits?
> > >=20
> > > Since you said you are building policy from source, you can always ju=
st
> > > sed -i "s/module/base" policy/modules.conf and then make enableaudit =
to
> > > build everything into base with all dontaudits removed.
> > > =20
> > > >=20
> > > >=20
> > > > On Mon, 2008-02-04 at 14:11 -0500, Stephen Smalley wrote:
> > > > > On Mon, 2008-02-04 at 13:02 -0600, Jeremiah Jahn wrote:
> > > > > > Is there some way to turn of the dontaudit  w/ the refpolicy an=
d a
> > > > > > module policy build. make enableaudit seems to only change the =
base
> > > > > > policy, and not any of the policies that actually do anything.=20
> > > > > >=20
> > > > > > This is with the refpolicy selinux-refpolicy-sources-20071214-1=
 running
> > > > > > on RHEL5.=20
> > > > > >=20
> > > > > > For some reason, when the policy is enforced, I can't su  from =
a staff_r
> > > > > > user, yet when I try with enforcing=3D0 I don't get any audit m=
essages,
> > > > > > and I'm not really comfortable modifying every user oriented ad=
min
> > > > > > modules to remove the dontaudit rules. doing so in su.te helped=
 find a
> > > > > > few things, but I'm not sure what's blocking it now.=20
> > > > >=20
> > > > > If using a recent semodule, you can do semodule -DB to strip the =
entire
> > > > > policy of dontaudit rules and load the result, then semodule -B t=
o
> > > > > revert to the original policy.
> > > > >=20
> > > > In 1880 the French captured Detroit but gave it back ... they could=
n't
> > > > get parts.
> > Parkinson's Fifth Law: If there is a way to delay in important decision=
,
> > the good bureaucracy, public or private, will find it.
Earth is a beta site.

--=-sQmDWHN5psHfFl52iiOQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHp3h+6caZY8jbHDkRAuSJAKDApuXFp2sk/j/fnZ0FvMdeoHMm7ACdFcx6
8GxXxjS16Df0yLZJEKokhSo=
=RXYs
-----END PGP SIGNATURE-----

--=-sQmDWHN5psHfFl52iiOQ--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
