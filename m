Message-ID: <1328545024.7648.12.camel@foxtrot.cjac.ntr.f5net.com>
Subject: Re: SELinux on Wheezy
From: "C.J. Adams-Collier KF7BMP" <cjac@colliertech.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SE-Linux <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>
Date: Mon, 06 Feb 2012 08:17:04 -0800
In-Reply-To: <1328542762.9705.62.camel@moss-pluto>
References: <1328502407.14110.7074.camel@calcifer>
	 <1328542762.9705.62.camel@moss-pluto>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-yuPFO7AbXhj8AKxjF+vz"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-yuPFO7AbXhj8AKxjF+vz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-02-06 at 10:39 -0500, Stephen Smalley wrote:
> On Sun, 2012-02-05 at 20:26 -0800, C.J. Adams-Collier KF7BMP wrote:
> > Hey folks,
> >=20
> > I brought up a wheezy install on an alternate lvm root a couple of week=
s
> > ago.  I turned SELinux on shortly thereafter.  I think I updated my
> > kernel, and now X won't start.  Could someone look at these logs with m=
e
> > and help figure out what's going on?  Something showed up during boot
> > that said something about updating labels, but I didn't capture it.
> > Where should I look to find these boot logs, do you think?
> >=20
> > http://www.colliertech.org/federal/nsa/selinux-20120205T2023PST.log
>=20
> Are there any avc denials?  If running auditd, then use ausearch -m AVC.
> Otherwise grep for avc: in your messages file or dmesg output.
>=20
> What does sestatus report?

Thank you for your quick response, Stephan.

I'm using Evolution as my MUA and haven't got mutt set up on the new
system yet, so email and selinux are currently mutually exclusive.  I've
saved this email to a text file and will re-start the kernel with
selinux enabled, run these commands > log and re-boot.  I'm waiting on a
ferry that leaves in 15 minutes, so I won't have the results until I get
to my desk in Seattle after noon (-0800).

C.J.


--=-yuPFO7AbXhj8AKxjF+vz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABCAAGBQJPL/0AAAoJEEyimPmPQm23xLEIAJX/skcpPUYcULetyFmhahJL
6FhMeGIlTgHIIGy99DUTYXwa5oPl9NuI3UsO+o6kIKsrjR6baSXhecVLzdi4+lzi
3/y9SvbhMxeqS8t9K4X5P0PJl8yCjkdyGsph4R0FBWZB7hYJcYdfAnRfX6cr8MEw
Y5k2wGj/Nl1ICpI6kydgQb234XSrKPdhKHZ9HBAT57Sn99CvgBxmMnyaW/AxU3LJ
vEg0QsnoSMIRZ+QHyO6S6cvgQ+ii7LSXUrjwudZgc4rwOpdpRnzhQ9ehMRw5aNlQ
+uNEtRF6QiIDQsLbYW48S++ctygCV2Lu0bY3Muc3Yl78tFs1Z0dOKtPn2mt2ics=
=d2cD
-----END PGP SIGNATURE-----

--=-yuPFO7AbXhj8AKxjF+vz--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
