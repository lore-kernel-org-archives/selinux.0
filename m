Subject: [Fwd: Re: Policy]
From: Gregory Ade <gkade@bigbrother.net>
To: Howard Holm <hdholm@epoch.ncsc.mil>
Cc: Russell Coker <russell@coker.com.au>,
        "Westerman, Mark"
	 <Mark.Westerman@csoconline.com>,
        SeLinux@tycho.nsa.gov, sds@tislabs.com, pal@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-BVtMeWGuiUKYU3SIzwzw"
Date: 03 Apr 2002 17:06:10 -0800
Message-Id: <1017882461.14980.107.camel@pslgregory>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-BVtMeWGuiUKYU3SIzwzw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Whoops, meant to hit "Reply All". =3D)

-----Forwarded Message-----

From: Gregory Ade <gkade@bigbrother.net>
To: Howard Holm <hdholm@epoch.ncsc.mil>
Subject: Re: Policy
Date: 03 Apr 2002 16:50:02 -0800

On Wed, 2002-04-03 at 14:04, Howard Holm wrote:

> The most compelling argument for me, though is that I believe the SELinux
> utilities are being installed to "replace or upgrade software in /usr" as
> described in section 4.9.1.  We have often said that we would like the
> changes in the utilities to be transparent on a non-SELinux system and
> carried by the upstream packages.  From that perspective, the utilties ar=
e
> direct replacements and I would argue that binary packages should replace
> the equivalent non-SELinux packages on an SELinux system.  (I suspect
> several people will strongly disagree with me on that point.)  For people
> building it from source, I think they must have the option to install in
> /usr/local/{bin,sbin,include,lib,share} because I think that makes it far
> more clearly "locally maintained" software.  That may be an inconsistent
> view of the world, but that's the way I see it.

Been lurking for a while, but:

I'd agree with this.  if the goal is to become a seamless part of the
underlying distribution, then stay out of /usr/local or /opt; just go
ahead and replace the existing binaries (optionally, for the more
advanced packagers, you could make backup copies of all the originals,
like 'ls.preselinux' or whatever).  To be really slick, the SELinux
packages would act as upgrades or replacements for whichever packages'
binaries are being replaced, so that the package manager can keep track
of everything sanely.

When building from source, I'd most likely put it /usr/local/selinux,
just to keep it simple.  In my eyes, /usr/local (and, to an extent,
/opt) is the sole domain of the sysadmin to manage at his discretion,
and package managers should keep their grubby fingers out of there. =3D)

> > Standard proceedure for Unix software distribution in my experience...
>=20
> The policy has its own unique complications.  I think it would be great
> to allow packages to modify the default polic(ies) when they are installe=
d
> so that the default polic(ies) include(s) the statements from all install=
ed
> packages.
[snip]
> I think this needs some more discussion.

Or, how's this for an idea (note that i'm very unfamiliar with the
current way policies are managed, so this could well be construed as me
talking out my behind):

Policy is defined, instead of in a single file, by a combination of a
"top" configuration file and a "bottom" directory containing parts.=20
i.e.:

/etc/selinux/policy	- local sysadmin-defined policy rules

/etc/selinux/policy.d/*	- policy fragments installed by the various 			=20
SELinux components

Then, the programs that actually check and apply the policies would
first compile them from the /etc/selinux/policy.d/* files, and then
apply the policies from /etc/selinux/policy, where conflicts result in
/etc/selinux/policy overriding anything else?

I'm going to go do some more reading and tinkering and see how far
off-base what I just said is... =3D)

--=20
Gregory K. Ade <gkade@bigbrother.net>
http://bigbrother.net/~gkade
OpenPGP Key ID: EAF4844B  keyserver: pgpkeys.mit.edu

--=-BVtMeWGuiUKYU3SIzwzw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8q6cBeQUEYOr0hEsRAqc4AJ9uHXRwiyUSk4O9jD2lqVhIGC6s0gCeM8Mp
DvKY2DqX+I+QrkW2Ywe6tM0=
=mhE0
-----END PGP SIGNATURE-----

--=-BVtMeWGuiUKYU3SIzwzw--


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
