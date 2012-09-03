Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q83HxU5u015170
	for <selinux@tycho.nsa.gov>; Mon, 3 Sep 2012 13:59:31 -0400
Date: Mon, 3 Sep 2012 19:59:04 +0200
From: Ole Kliemann <ole@plastictree.net>
To: selinux@tycho.nsa.gov
Subject: An MCS policy
Message-ID: <20120903175904.GA25491@telmora.telvanni>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Part of the project I'm working on is an MCS policy that I want=20
to describe and (hopefully) proof correct in this posting.

I do not expect anyone to read this through, but if maybe someone=20
is interested in stuff like this, I'd really appreciate any quick=20
look over it.



These are the specifications I want my policy to meet:

I want a user to have 100 compartments, each one totally
separated from every other. The user (called main user) has full=20
access over every compartment. For each compartment C there shall=20
be 9 subcompartments of C each one totally separated from every=20
other subcompartment or compartment, but accessible from C.=20

No compartment or subcompartment shall have the possibility to=20
access or leak data "horizontally", i.e. to any other compartment=20
or subcompartment that is not of his own.

Neither shall any compartment or subcompartment be able to access=20
"upwards", i.e. from a subcompartment to its compartment or from=20
a compartment to the main user.

The only allowed data flow is reading, writing and transitioning=20
=66rom the main user to the compartments and from every compartment=20
to its subcompartments. (Set aside practical exceptions like=20
sigchild, fd use, some X11 stuff that needs to be shared among=20
all compartments etc.)


My Implementation:

I have a user user_u with range s0 - s0:c0.c999 starting off as=20
main_t:s0.=20

main_t is not mcs constrained. main_t can transition to sub_t=20
which is mcs constrained and has no access to main_t.

I call a range of s0:c(N*10).c((N*10)+9), 0<=3DN<=3D99, a compartment=20
with id N. E.g. compartment 01 with range s0:c10.c19.=20

I call s0:cI, (N*10) < I <=3D ((N*10)+9), a subcompartment of N=20
with id I. E.g. subcompartment 5 of compartment 01 with range=20
s0:c15.

A process of compartment N is run as:

	sub_t:s0:c(N*10) - s0:c(N*10).c((N*10)+9)

A process of subcompartment I of N as:
=09
	sub_t:s0:c((N*10)+I)

The mlsconstrain (in princip, set aside practical exceptions) is:

01:		( t1 !=3D is_mcsconstrained )
02:	or	( t2 !=3D is_mcsconstrained )
03:	or	(=09
04:				( l1 domby h1 )=20
05:			and	( l2 domby h2 )=20
06:			and	( h1 dom h2 )=20
07:			and ( h1 dom l2 )=20
08:			and ( l1 domby l2 )=20
09:		)
=09

Proof:

It is sufficient to proof this for any compartment, say=20
s0:c10.c19. As there is only one sensitivity, the relation of=20
dominance is that of inclusion of category sets. Set inclusion=20
shall be denoted by < > =3D <=3D >=3D.

04 and 05 are just to prevent any "weird" contexts. (I'm pretty=20
sure the kernel already enforces those and gives 'invalid=20
context' if low range > high range. But definite specifications=20
are hard to find, so I put them in to be sure.)

It needs to be shown that a process running as

	s0:c10 - s0:c10.c19

can not access any categories -- directly or through transition=20
-- other than c10.c19.

For files created or processes transitioned to it holds true that=20
low range as well as high range can only be a subset of c10.c19. =20
This is ensured by 06 and 07. So the process can neither access=20
nor leak data to either the compartments numerically below hin=20
(s0:c0.c9) or above him (s0:c20.c29, ...).=20

But note that the empty set is also subset of c10.c19. So the=20
process would be able to jeopardise his own integrity by=20
transitioning to or leaking data to s0 -- which in turn would=20
then be accessible form any other compartment.

So the source low range must always be a subset of the target low=20
range. This is ensured by 08.

For a subcompartment, say s0:c15, it holds true that the process=20

	s0:c10 - s0:c10.c19

can transition to, give and write files to etc. as c15 > c10 and=20
c15 < c10.c19.

For any subcompartment it is obvious from the above that it=20
cannot access or transition to anything else than itself.

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlBE7+gACgkQS1FjE303ERyT6gCdFwZ2Ifx8wpbyB48wkOYN6YJ+
el0An3jdWIko2B6Uv6UWLgCGvsH9hUjP
=40Fg
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
