Subject: Re: secadm question
From: Jeremiah Jahn <jeremiah@goodinassociates.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul.moore@hp.com>,
        selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1203089944.13618.40.camel@gorn>
References: <1203030583.3669.197.camel@bluejay.goodinassociates.com>
	 <200802150855.47722.paul.moore@hp.com>
	 <1203088187.3669.241.camel@bluejay.goodinassociates.com>
	 <1203088562.16038.196.camel@moss-spartans.epoch.ncsc.mil>
	 <1203089944.13618.40.camel@gorn>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-+tlij4MjyhCgTOU0BbzZ"
Date: Fri, 15 Feb 2008 10:09:20 -0600
Message-Id: <1203091760.3669.249.camel@bluejay.goodinassociates.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-+tlij4MjyhCgTOU0BbzZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

So for my purposes, to would probably be best to just make a secadm
user/role and add follow most of the interface for the original secadm
role?

On Fri, 2008-02-15 at 10:39 -0500, Christopher J. PeBenito wrote:
> On Fri, 2008-02-15 at 10:16 -0500, Stephen Smalley wrote:
> > On Fri, 2008-02-15 at 09:09 -0600, Jeremiah Jahn wrote:
> > > So if I change my build.conf to be mls I should be up and running. I'=
m
> > > on RHEL5 btw
> >=20
> > Chris - how hard would it be to make this a separate tunable so that
> > people who want a separate security admin can turn that on without
> > enabling MLS?
>=20
> Problematic.  The security admin pieces are nicely abstracted into an
> interface.  However, the problem is that it has some typeattribute
> statements, so we can't put that in a conditional.
>=20
> There are two things that will eventually make this possible.  The plan
> is to move roles into their own modules, and at that point you should be
> able to just insert the secadm module.
>=20
> > > On Fri, 2008-02-15 at 08:55 -0500, Paul Moore wrote:
> > > > On Thursday 14 February 2008 6:09:43 pm Jeremiah Jahn wrote:
> > > > > I see a number of places where the secadm_r role shows up, but It
> > > > > doesn't show up in the list of users and what not, Is there somet=
hing
> > > > > simple I need to enable it, or 	do I need to build it from scratc=
h?
> > > > > My goal it to have sysadm not able to modify policy enforcement, =
and
> > > > > my secadm not be able to do anything but. If there is a standard =
way
> > > > > to do this, I'd love to know.
> > > >=20
> > > > I believe the secadm_r role is only defined for the "mls" policy bu=
ilds;=20
> > > > if you are running a "mcs" (the Fedora default) policy I don't thin=
k=20
> > > > the secadm_r role is present.
> > > >=20
> > > Boy, n.: A noise with dirt on it.
"Consequences, Schmonsequences, as long as I'm rich." -- "Ali Baba
Bunny" [1957, Chuck Jones]

--=-+tlij4MjyhCgTOU0BbzZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHtbkw6caZY8jbHDkRAqGzAJ9bAumfaJG8+HV57AMkOigh98L4lwCcC5N8
GQMg8NbxpXA50YQk0jUDJ0A=
=c7O4
-----END PGP SIGNATURE-----

--=-+tlij4MjyhCgTOU0BbzZ--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
