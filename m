Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA2EwmXZ006099
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 09:58:48 -0500 (EST)
Received: from monk.area614.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA2EvR4G011949
	for <selinux@tycho.nsa.gov>; Tue, 2 Nov 2004 14:57:27 GMT
Subject: Re: dynamic context transitions
From: Colin Walters <walters@verbum.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Darrel Goeddel <dgoeddel@TrustedCS.com>,
   Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@TrustedCS.com>, James Morris <jmorris@redhat.com>
In-Reply-To: <1099403997.31739.38.camel@moss-spartans.epoch.ncsc.mil>
References: <4182959B.4080503@trustedcs.com>
	 <20041029211809.GJ8897@lkcl.net> <20041030090603.GK8897@lkcl.net>
	 <1099315214.21386.13.camel@moss-spartans.epoch.ncsc.mil>
	 <20041101141025.GZ8897@lkcl.net>  <418662EE.5090001@trustedcs.com>
	 <1099361880.3998.4.camel@nexus.verbum.private>
	 <1099403997.31739.38.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fXnBWukZH5nLN5KHNPHA"
Date: Tue, 02 Nov 2004 09:59:21 -0500
Message-Id: <1099407561.6234.50.camel@x-infinity>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-fXnBWukZH5nLN5KHNPHA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-11-02 at 08:59 -0500, Stephen Smalley wrote:
> On Mon, 2004-11-01 at 21:18, Colin Walters wrote:
> > I can see some specialized uses for this with e.g. the Samba example,
> > but I'm having trouble seeing how it would be broadly useful, although =
I
> > haven't thought about the MLS case much.  But in your examples above,
> > the policy can already restrict which ports a domain can bind; it
> > doesn't seem useful to drop the privileges to bind to those ports.
> > Also, why would it be useful to drop the privileges to read
> > configuration files?
>=20
> Classic example that shows up often in Fedora is allowing the daemon to
> access the tty during startup for error reporting=20

initlog already sends error messages printed to stdout/stderr
to /var/log/messages.  I don't really see it as a problem that you don't
get them duplicated on the tty; usually most daemons close stderr and
start logging to syslog anyways pretty early, so you always need to look
there for errors.

> and user interaction
> (e.g. ssl), then removing its ability to access the tty subsequently.=20

And this one just seems broken to me, outside of SELinux.  It doesn't
work if your server boots up remotely and you're not physically in front
of it, nor does it work if you're restarting services from a GUI with no
tty.  A better solution would be for Apache to simply run a helper
program, say /usr/sbin/httpd-readpassword, that could read the
passphrase in a configurable way.  In most cases, this would
use /dev/tty, but there's lots of other interesting things one could do.
For example, I've heard of sysadmins having their systems send an IM
when there's a problem; extending this slightly, simply have the httpd-
readpassword program send an IM query for the passphrase and wait for a
response.  Or in the GUI service case, we could do some D-BUS thing back
to the user session.  But hardcoding /dev/tty I think is broken.

--=-fXnBWukZH5nLN5KHNPHA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBh6DJOIkJWWp2WGURAnwTAJ9dzZfw3bWETLImsU2u30GxblfsBwCeOcpC
UlR+wC7icXYyn4Trux7wgv8=
=XIdO
-----END PGP SIGNATURE-----

--=-fXnBWukZH5nLN5KHNPHA--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
