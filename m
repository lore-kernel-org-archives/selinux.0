Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q17HZTUN017827
	for <selinux@tycho.nsa.gov>; Tue, 7 Feb 2012 12:35:29 -0500
Received: from mail-pw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id q17HZR5X021615
	for <selinux@tycho.nsa.gov>; Tue, 7 Feb 2012 17:35:28 GMT
Received: by pbdu6 with SMTP id u6so8055960pbd.12
        for <selinux@tycho.nsa.gov>; Tue, 07 Feb 2012 09:35:27 -0800 (PST)
Message-ID: <1328636118.4224.35.camel@foxtrot.cjac.ntr.f5net.com>
Subject: Re: SELinux on Wheezy
From: "C.J. Adams-Collier KF7BMP" <cjac@colliertech.org>
To: Dominick Grift <dominick.grift@gmail.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>
Date: Tue, 07 Feb 2012 09:35:18 -0800
In-Reply-To: <1328545295.7648.14.camel@foxtrot.cjac.ntr.f5net.com>
References: <1328502407.14110.7074.camel@calcifer>
	 <1328543813.1905.2.camel@x220.mydomain.internal>
	 <1328545295.7648.14.camel@foxtrot.cjac.ntr.f5net.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-8WEaRKiWJtkNJADHMPVW"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-8WEaRKiWJtkNJADHMPVW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-02-06 at 08:21 -0800, C.J. Adams-Collier KF7BMP wrote:
> On Mon, 2012-02-06 at 16:56 +0100, Dominick Grift wrote:
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
> > >=20
> > > Thank you in advance!
> > >=20
> > > C.J.
> > >=20
> > >=20
> >=20
> > Seems to be an XACE issue.
> >=20
> > > > /var/log/Xorg.56.log.old:[    46.050] SELinux: a property label loo=
kup failed!
> > > > /var/log/Xorg.56.log.old:[    46.050] SELinux: Failed to set label =
property on window!
> >=20
> > getsebool -a | xserver_object_manager
> >=20
> > Does it work if you set it to off?
> >=20
> > setsebool -P xserver_object_manager off
> >=20
> > http://selinuxproject.org/page/NB_XWIN
>=20
> Thank you Dominick.  I will give this a try when I re-boot.
>=20
> Russell, do you think this is something we should patch in to the xorg
> debian packaging?
>=20


http://www.colliertech.org/federal/nsa/sebool-20120206T091638.log:
cjac@foxtrot:~$ sudo getsebool -a | grep -i xserver_object_manager | wc -l
0
cjac@foxtrot:~$ sudo setsebool -P xserver_object_manager off
libsemanage.dbase_llist_set: record not found in the database (No such file=
 or directory).
libsemanage.dbase_llist_set: could not set record value (No such file or di=
rectory).
Could not change boolean xserver_object_manager
Could not change policy booleans

How do I fill these in?  Is there a .deb with the correct policy
modification?

Thanks,

C.J.


--=-8WEaRKiWJtkNJADHMPVW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABCAAGBQJPMWDWAAoJEEyimPmPQm2352kH/3di09Chg8l2N5PDB3MEC+vG
hBNmAlbT7nuHzn3J3B54g8Ra611MVxtFmicu/5t1QYZjzZxR+M221XSB2ERKGL+L
y0ecu6/ldb3hBB1/WDNPptYPV9pZkihq68ZeWFUzM7+5bpAJlzYna03kjeksrrGd
9+mV1BbdWw0mly+Wrqv1ojFHaqJFewQJP1B/cjBJ4xDcYgYEfchV5Kppl7BhkgAD
us1+OgNZ5PF213o+8M/o3ejPlDwUjoUIW9ALbuu8o7Ldcdn3BkfKev7tnFvKZr5z
UoYxJXqXfox+P48dMUiS3ofAiBRaQN61zIXTKvE614vOXI4j4LTrrpMuiPLlxHs=
=BFkp
-----END PGP SIGNATURE-----

--=-8WEaRKiWJtkNJADHMPVW--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
