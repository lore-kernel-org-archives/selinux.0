Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8GHaCrT026718
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 13:36:13 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8GHZF8m001415
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 17:35:15 GMT
Subject: Re: SELinux policy discussion.
From: Colin Walters <walters@redhat.com>
To: ivg2@cornell.edu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1095318426.32510.30.camel@localhost.localdomain>
References: <4148A003.6080309@redhat.com>
	 <1095295125.4231.127.camel@nexus.verbum.private>
	 <1095302625.28466.56.camel@localhost.localdomain>
	 <1095307503.4231.152.camel@nexus.verbum.private>
	 <1095318426.32510.30.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-PiiLEtPSST3X4OigQiF1"
Date: Thu, 16 Sep 2004 13:37:34 -0400
Message-Id: <1095356254.4231.188.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-PiiLEtPSST3X4OigQiF1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-09-16 at 03:07 -0400, Ivan Gyurdiev wrote:
> > > > Normal users don't just randomly cat files in /etc.
> > >=20
> > > So what exactly is the definition of a SElinux MAC system?
> > > Is it a system which allows only what "normal users do",
> > > and how exactly do you figure out what that is?=20
> >=20
> > There are no hard and fast rules, but I am quite sure that no one's end
> > goal is "cat random file in /etc".  Instead, you cat a file to achieve
> > something else.  That something else is what is interesting.
>=20
> My point is, I don't think you can determine all the possible ways in
> which a user may take advantage of read access, previously available,
> and now no longer there.=20

Of course we can't.  But what we can do is consider individual requests
for greater access, and add that on a case-by-case basis.

> Perhaps the user has custom scripts or
> applications that are not selinux-aware at this point and now they'll
> stop working.=20

Custom scripts to do *what*?  You need to point out specific things that
would be broken.  Actual examples of real-world code.

> Perhaps the user does want to cat a random file from the
> shell to view its contents (config files?).=20

This is just a more complicated way of saying "cat random file in /etc".
I'm not convinced.

> That worked before and now it no longer works.=20

A lot of things don't work with SELinux that used to work before,
like /tmp races.  It's not a bug.

> While you can establish exactly what the requirements of an application
> are and write a policy for it, I'm not sure you can establish exactly
> what the requirements of user_t are. There's a whole range of things
> user_t could decide to do. That's why it seems to me that the policy to
> adhere to when it comes to user_t should be compatible with Unix
> permissions.

I completely disagree.  The strict policy is always going to be more
restrictive than Unix permissions for users.  That's the point of it.
If you don't want that, use the targeted policy.

> That's exactly what I was arguing for... DAC permissions for user_t,
> strict MAC policy for other domains. DAC permissions for all domains
> would make no sense at all since it defeat the whole purpose of SELinux.

See above.

> > I think you just want the targeted policy.
>=20
> But the strict policy covers more programs.
> It won't let a firefox buffer overflow cause damage to the rest of my
> files (will it?).=20

The strict policy helps there.  But we still have a long ways to go to
lock down X. =20

If you want a restricted mozilla domain, and allow users to read random
files in /etc, use the strict policy and add a bit of custom policy to
your site to allow users to read those files you want.  The latter isn't
something that should be in the default strict policy.  But SELinux is
flexible enough to allow what you want.



--=-PiiLEtPSST3X4OigQiF1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBSc9eOIkJWWp2WGURAkMUAJ4yI7uAXbNZ9lFa4bmEtfMpVzhs9wCfR7MW
dGGe8sFgZ/GNc/o4NHZ5a3s=
=EAuD
-----END PGP SIGNATURE-----

--=-PiiLEtPSST3X4OigQiF1--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
