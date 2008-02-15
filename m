Subject: Re: secadm question
From: Jeremiah Jahn <jeremiah@goodinassociates.com>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul.moore@hp.com>,
        selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1203091792.13618.56.camel@gorn>
References: <1203030583.3669.197.camel@bluejay.goodinassociates.com>
	 <200802150855.47722.paul.moore@hp.com>
	 <1203088187.3669.241.camel@bluejay.goodinassociates.com>
	 <1203088562.16038.196.camel@moss-spartans.epoch.ncsc.mil>
	 <1203089944.13618.40.camel@gorn>
	 <1203091760.3669.249.camel@bluejay.goodinassociates.com>
	 <1203091792.13618.56.camel@gorn>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hNWt6TWvP/A+ObN3OJCi"
Date: Fri, 15 Feb 2008 10:14:30 -0600
Message-Id: <1203092070.3669.251.camel@bluejay.goodinassociates.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-hNWt6TWvP/A+ObN3OJCi
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

true, but I thought there was a tunable/boolean the disabled all that
for sysadm

On Fri, 2008-02-15 at 11:09 -0500, Christopher J. PeBenito wrote:
> On Fri, 2008-02-15 at 10:09 -0600, Jeremiah Jahn wrote:
> > So for my purposes, to would probably be best to just make a secadm
> > user/role and add follow most of the interface for the original secadm
> > role?
>=20
> You could do that, but it wouldn't stop sysadm from being able to do all
> the secadm things too, defeating the purpose of having a secadm in the
> first place :)
>=20
> > On Fri, 2008-02-15 at 10:39 -0500, Christopher J. PeBenito wrote:
> > > On Fri, 2008-02-15 at 10:16 -0500, Stephen Smalley wrote:
> > > > On Fri, 2008-02-15 at 09:09 -0600, Jeremiah Jahn wrote:
> > > > > So if I change my build.conf to be mls I should be up and running=
. I'm
> > > > > on RHEL5 btw
> > > >=20
> > > > Chris - how hard would it be to make this a separate tunable so tha=
t
> > > > people who want a separate security admin can turn that on without
> > > > enabling MLS?
> > >=20
> > > Problematic.  The security admin pieces are nicely abstracted into an
> > > interface.  However, the problem is that it has some typeattribute
> > > statements, so we can't put that in a conditional.
> > >=20
> > > There are two things that will eventually make this possible.  The pl=
an
> > > is to move roles into their own modules, and at that point you should=
 be
> > > able to just insert the secadm module.
> > >=20
> > > > > On Fri, 2008-02-15 at 08:55 -0500, Paul Moore wrote:
> > > > > > On Thursday 14 February 2008 6:09:43 pm Jeremiah Jahn wrote:
> > > > > > > I see a number of places where the secadm_r role shows up, bu=
t It
> > > > > > > doesn't show up in the list of users and what not, Is there s=
omething
> > > > > > > simple I need to enable it, or 	do I need to build it from sc=
ratch?
> > > > > > > My goal it to have sysadm not able to modify policy enforceme=
nt, and
> > > > > > > my secadm not be able to do anything but. If there is a stand=
ard way
> > > > > > > to do this, I'd love to know.
> > > > > >=20
> > > > > > I believe the secadm_r role is only defined for the "mls" polic=
y builds;=20
> > > > > > if you are running a "mcs" (the Fedora default) policy I don't =
think=20
> > > > > > the secadm_r role is present.
> > > > > >=20
> > > > > Boy, n.: A noise with dirt on it.
> > "Consequences, Schmonsequences, as long as I'm rich." -- "Ali Baba
> > Bunny" [1957, Chuck Jones]
First Law of Bicycling: No matter which way you ride, it's uphill and
against the wind.

--=-hNWt6TWvP/A+ObN3OJCi
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBHtbpm6caZY8jbHDkRAqbdAJ4uem7rXzexMPWAu3TjBfOJWk4Y/QCeKStV
9tyqwUdvPO8VpsR9b7RCXzg=
=g1hx
-----END PGP SIGNATURE-----

--=-hNWt6TWvP/A+ObN3OJCi--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
