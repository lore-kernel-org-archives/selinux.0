Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9LGHIi016388
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 16:16:17 -0500 (EST)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9LEdPS026630
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 21:14:39 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Thu, 9 Dec 2004 22:16:18 +0100
Date: Thu, 9 Dec 2004 22:16:19 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Russell Coker <rcoker@redhat.com>, Colin Walters <walters@redhat.com>,
   Stephen Smalley <sds@epoch.ncsc.mil>, SE Linux list <selinux@tycho.nsa.gov>,
   Joshua Brindle <jbrindle@snu.edu>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   Nalin Dahyabhai <nalin@redhat.com>
Subject: Re: Single home directory type for all roles.
Message-Id: <20041209211618.GG8179@jmh.mhn.de>
References: <20041207000805.GH3678@jmh.mhn.de> <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil> <41B8826D.30105@redhat.com> <1102613299.10785.21.camel@nexus.verbum.private> <1102615344.4509.39.camel@aeon> <41B8AB69.1060805@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2uG6jHjFLimDtBY"
In-Reply-To: <41B8AB69.1060805@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--J2uG6jHjFLimDtBY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Daniel J Walsh <dwalsh@redhat.com> [2004-12-09 21:49]:
> Russell Coker wrote:
> >On Thu, 2004-12-09 at 12:28 -0500, Colin Walters wrote:
> >>policy for the gnome-user-share Apache daemon.  It does seem wrong to me
> >>for any user_t to have access to my staff_t temporary files, and also
> >>the other way around (remember that user_t/staff_t prevents /tmp race
> >>conditions).  I run a strict server on which I have several users who I
> >>don't *entirely* trust.  The extra assurance the user_t/staff_t
> >>distinction brings is nice.
> >>  =20
> >>
> >
> >Currently the default policy has /root labeled as staff_home_dir_t.
> >This significantly weakens the boundaries between staff_r and sysadm_r.
> >If we were to make changes which then weaken the boundaries between
> >user_r and staff_r then we might as well just have no user_r and staff_r
> >and use sysadm_r for all user logins - IE have the targeted policy.
> >=20
> >
> With this change, I would go back to /root labeled as sysadm_home_t,=20
> which should probably happen
> anyways as we move to stricter policy.

Agreed.

> I am trying to strengthen the difference between them without having to=
=20
> relabel files if I change the role of the user.
> Current policy on Fedora Strict policy basically shows no difference=20
> between staff and user so adding this allows us
> to remove some privs from user_r without causing the user to do a=20
> massive relabel.
> >
> >>>2.  Requirement that selinux-policy-strict-sources be installed and a=
=20
> >>>rebuild of policy in order to change the roles of a user.
> >>>    =20
> >>>
> >>I'm not sure I see what's so bad about this.  I would assume that most
> >>people running strict will have to customize policy anyways.
> >
> >I agree.
> >
> Yes up to now they have had too, but we are trying to expand the number=
=20
> of users of strict policy.=20
> I believe if you have to massively relabel in the course of=20
> administrating the machine, we have a bug.
>=20
> >>Hmm.  But the fact that in the default strict policy user_r and staff_r
> >>are nearly equivalent in terms of functionality is really a special
> >>case, no?
> >
> >A bug IMHO.  If we have two roles that become almost equivalent then the
> >sensible thing to do is remove one.  If we decide that for Fedora strict
> >policy we don't want to have any regular users be denied the ability
> >perform administrative tasks then the correct thing to do is to make
> >staff_r the default user role.
> >
> I want to go back to the separation between user and staff without the=20
> differences in file system.
>=20
> >It's easy enough for anyone to add a new role if they need more roles
> >than the default policy provides.
> >
> Not without relabing the file system.  Currently if I want to add a new=
=20
> role, say student that has less privs
> then user,  I need to massively rewrite the policy.  If we came up with=
=20
> a policy that shared homedir and tmpdir
> file contexts between all types of users, I could begin to create=20
> additional default roles for people.

But then you lose almost all the benefit of having separate roles in the
first place. Because then the separation between roles depends entirely
on DAC permissions. I don't think that's the right way to go.

If someone needs separate roles for security why would he compromise
on this?

And you still have to know policy to add a new role and understand which
permissions it needs. If you know all this, relabeling is no problem for
you.

Maybe we need to build some higher order macros, to make creating new
roles easier, so a full user role looks something like this:

# type for home dir, access to tty
base_permissions(student)
can_mount(student)
# can see all processes
dnl can_ps(student, domain)
can_network_server(student)

# professor can read temporary files of students
read_tmp_files(professor, student)

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--J2uG6jHjFLimDtBY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBuMCixWIrrrL0q+cRAtlNAJ9nrDWZ5l5IRnHgmJu2K1FNqcVUrwCeNo/N
i/gKlFWiF09pKZFSL+ROnZM=
=oC3G
-----END PGP SIGNATURE-----

--J2uG6jHjFLimDtBY--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
