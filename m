Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8G43grT022513
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 00:03:42 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8G42k8m029254
	for <selinux@tycho.nsa.gov>; Thu, 16 Sep 2004 04:02:46 GMT
Subject: Re: SELinux policy discussion.
From: Colin Walters <walters@redhat.com>
To: ivg2@cornell.edu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1095302625.28466.56.camel@localhost.localdomain>
References: <4148A003.6080309@redhat.com>
	 <1095295125.4231.127.camel@nexus.verbum.private>
	 <1095302625.28466.56.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-a0y2cD0NVXXzEEqTEpJf"
Date: Thu, 16 Sep 2004 00:05:03 -0400
Message-Id: <1095307503.4231.152.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-a0y2cD0NVXXzEEqTEpJf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-09-15 at 22:43 -0400, Ivan Gyurdiev wrote:

> What you have right now is not least privilege possible.
> This is the point where my computer is broken and does not work.

You need to point out specific things that are broken.

> > Normal users don't just randomly cat files in /etc.
>=20
> So what exactly is the definition of a SElinux MAC system?
> Is it a system which allows only what "normal users do",
> and how exactly do you figure out what that is?=20

There are no hard and fast rules, but I am quite sure that no one's end
goal is "cat random file in /etc".  Instead, you cat a file to achieve
something else.  That something else is what is interesting.

> If there is a general consensus that a user has no job=20
> reading a particular file in /etc, why is it still created/installed as
> world readable.=20

One reason is because (at least before ACLs) it's complicated to
restrict access to only mildly sensitive files that are shared across
multiple daemon uids that a user doesn't really need read access to.

> Why don't you implement the MAC at the permissions level
> and make SElinux respect that?

That doesn't make any sense, if the MAC system respected DAC permissions
it wouldn't be MAC.

> So if a case can be made you'll change the SElinux context to respect
> the Unix permissions?=20

No.  What we were discussing here is for a user to read a particular
file in /etc.  Even if the file is world readable, that doesn't mean
that access to it would be granted for all SELinux domains.  Someone may
deliberately create a domain that has no access to etc_t.  A good reason
to do this would be for a secured chroot setup. =20

What we would do is grant user_t and staff_t permissions for the file.

> If a case can't be made, why don't you change the
> Unix permissions (in the rpm or whatever creates the file) instead of
> adding restrictions on the SELinux level?=20

Because it may be very annoying to do some of this using Unix
permissions, and generally not worth the trouble.

> If I added the permissions=20
> manually, doesn't that indicate I definitely want to be able to read the
> file? Seems to me like "usercanread" and rwx bits provide duplicate
> functionality, and furthermore contradict each other.

No, not at all.  To make this discussion a bit more concrete, suppose
that in the strict policy your sendmail daemon (which runs as root) is
compromised.  The compromised daemon can set all the bits on files
in /etc it wants with just Unix permissions.  But with SELinux, even if
it had permission to make /etc/shadow a+r, other domains wouldn't have
access to it.

SELinux and Unix permissions are quite separate for good reason.

> Look, I don't really know how to use SELinux. I have a general idea=20
> of how it works, and I've looked at the policy files.=20
> I don't want to drop files anywhere when there's already a mechanism
> that deals with whether I can read or write files - Unix permissions.=20

What you really seem to be saying is that your system doesn't need
mandatory access control for users.  If so, use the targeted policy,
which leaves users in unconfined_t, with no SELinux restrictions
applied.

> You can claim that because I don't know how to use SELinux

I would never said that..  Heck, I'm still learning how to use SELinux
best myself and I've been at it for over a year now.

>  I shouldn't
> be using it and override Unix permissions for my own good... or you=20
> can make this process transparent for me and respect existing
> mechanisms.
>
> Why can't the strict policy be transparent for the end user ?

I think you just want the targeted policy.

> Do you not see value in that? Is the restriction imposed on what user_t
> can do the defining feature of the strict policy?=20

No, but it is a very core feature.

> I wanted to use strict
> policy because it's more comprehensive (more contexts - more
> separation),=20

Do you have a particular daemon you feel should be in the strict policy?




--=-a0y2cD0NVXXzEEqTEpJf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBSRDvOIkJWWp2WGURAvIJAJ9e63Do2imnoMF9W9MbFf1Y2VZNugCfQYeq
TzvS5EnKvCvkkx+8dUU6RZg=
=vH1n
-----END PGP SIGNATURE-----

--=-a0y2cD0NVXXzEEqTEpJf--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
