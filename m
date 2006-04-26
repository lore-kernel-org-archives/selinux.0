Subject: Re: textrel_shlib_t handling
From: Chris PeBenito <pebenito@gentoo.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1146058994.28745.122.camel@moss-spartans.epoch.ncsc.mil>
References: <1145726058.9106.70.camel@gorn.pebenito.net>
	 <1146058994.28745.122.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-G3KaTEjkXffPooyE6rjI"
Date: Wed, 26 Apr 2006 09:54:54 -0400
Message-Id: <1146059694.8660.10.camel@defiant.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-G3KaTEjkXffPooyE6rjI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-04-26 at 09:43 -0400, Stephen Smalley wrote:
> On Sat, 2006-04-22 at 13:14 -0400, Chris PeBenito wrote:
> > I remember seeing some discussion about RPM being enhanced so that it
> > detects libraries with text relocations, and labels them textrel_shlib_=
t
> > when installing them onto the filesystem.  So I thought that it would b=
e
> > useful for Gentoo's Portage too.  The problem is that if a library isn'=
t
> > already textrel_shlib_t in the file contexts, a relabel will reset them
> > back to shlib_t.  I came up with two possible solutions:
> >=20
> > 1. the package manager adds file contexts using semanage fcontext, then
> > the library will get the right label by default.  The problem with this
> > is that this would need to be recorded somewhere (probably the package
> > manager db) so the package manager removes this fcontext if the package
> > is removed/upgraded.
> >=20
> > 2. textrel_shlib_t is made a customizable type.  The problem is that th=
e
> > libs can still get set back to shlib_t if using -F on
> > restorecon/setfiles.
> >=20
> > While #1 is the best solution, it may require significant changes in th=
e
> > package manager, and may not be acceptable to the upstream because of
> > that.  #2 is a simpler solution, but has the -F problem.  My feeling is
> > that the -F problem is not a significant problem, so we should go with
> > #2.  Thoughts?
>=20
> I had suggested #2 previously, but someone (Dan?) noted that we then
> have the problem that textrel_shlib_t will never get removed if the
> library is later updated to a version that no longer requires text
> relocations.

How is that?  If the library is controlled by the package manager, then
every time it is installed, it will be probed, and labeled
appropriately.  So if the text relocations get fixed, the library
getting installed (shlib_t) will replace the textrel library; thus, the
label should be correct.  This works for Gentoo because Portage deletes
the existing file and installs the new file.  Does RPM just overwrite
the old file?

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
Embedded Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243


--=-G3KaTEjkXffPooyE6rjI
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBET3uuvI7kLeavkkMRAvvJAJ9RHbgrauRnbNSqiy4/yl5SL7Hj8gCeI2cw
XDpNmPHijI84hYHk6qt3M6I=
=vpR0
-----END PGP SIGNATURE-----

--=-G3KaTEjkXffPooyE6rjI--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
