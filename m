Message-ID: <1328570597.4395.36.camel@foxtrot.cjac.ntr.f5net.com>
Subject: Re: SELinux on Wheezy
From: "C.J. Adams-Collier KF7BMP" <cjac@colliertech.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: SE-Linux <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>
Date: Mon, 06 Feb 2012 15:23:17 -0800
In-Reply-To: <1328545024.7648.12.camel@foxtrot.cjac.ntr.f5net.com>
References: <1328502407.14110.7074.camel@calcifer>
	 <1328542762.9705.62.camel@moss-pluto>
	 <1328545024.7648.12.camel@foxtrot.cjac.ntr.f5net.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-cuuqY0Zww+joMaeUG1VY"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-cuuqY0Zww+joMaeUG1VY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-02-06 at 08:17 -0800, C.J. Adams-Collier KF7BMP wrote:
> On Mon, 2012-02-06 at 10:39 -0500, Stephen Smalley wrote:
> > On Sun, 2012-02-05 at 20:26 -0800, C.J. Adams-Collier KF7BMP wrote:
> > > Hey folks,
> > >=20
> > > I brought up a wheezy install on an alternate lvm root a couple of we=
eks
> > > ago.  I turned SELinux on shortly thereafter.  I think I updated my
> > > kernel, and now X won't start.  Could someone look at these logs with=
 me
> > > and help figure out what's going on?  Something showed up during boot
> > > that said something about updating labels, but I didn't capture it.
> > > Where should I look to find these boot logs, do you think?
> > >=20
> > > http://www.colliertech.org/federal/nsa/selinux-20120205T2023PST.log
> >=20
> > Are there any avc denials?  If running auditd, then use ausearch -m AVC=
.
> > Otherwise grep for avc: in your messages file or dmesg output.
> >=20
> > What does sestatus report?
>=20
> Thank you for your quick response, Stephan.
>=20
> I'm using Evolution as my MUA and haven't got mutt set up on the new
> system yet, so email and selinux are currently mutually exclusive.  I've
> saved this email to a text file and will re-start the kernel with
> selinux enabled, run these commands > log and re-boot.  I'm waiting on a
> ferry that leaves in 15 minutes, so I won't have the results until I get
> to my desk in Seattle after noon (-0800).
>=20
> C.J.

Stephen,

Here are the logs you requested:

http://www.colliertech.org/federal/nsa/avc-20120206T090101.log

http://www.colliertech.org/federal/nsa/sestatus-20120206T090618.log

It seems to me that the Debian SELinux docs could use some improvement.
To this end, I have submitted an application to join the SELinux project
on Alioth.  I will probably make some updates to the wiki pages as well.

I am going to install the packages which provide the tools you and
Dominick recommended this morning and dig a little deeper as time
permits.

Thank you again for taking the time to help me through this.

C.J.


--=-cuuqY0Zww+joMaeUG1VY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABCAAGBQJPMGDlAAoJEEyimPmPQm232lAH/39Sum2V/8JEmFhn0zim7VH6
1zNDh4q18uXWh0Z6pxcAsp9FpkK4n6nfJ0zCpmhHA63vFO5q0i0peTks7SaBDJBn
iLd1Yy2QgOqTW+pQ7dRxD5TdoT2b2pisd/uKyZDJWpSdvKecb/+ih4aP2POnybAm
qj4wmbZqc0bxKsYxhciG+eEqKNs2QRd6ceKCwV7XXKKZQ+5eFm1CQYzMr3aaVBQG
43PHWDZcnzUjxbLTg2OLLEdN7NlzGSU/Y0gC62y/DzdotE4YOl04kxvCsbmU11Mf
NNqktS7y3QALhOuJMWwuCX9fFhPrph1CgYpZprQmLlOfMJ4UpbviQs81MDTF8Po=
=eQkH
-----END PGP SIGNATURE-----

--=-cuuqY0Zww+joMaeUG1VY--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
