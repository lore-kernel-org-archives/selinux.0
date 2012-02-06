Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q16GLt7j029996
	for <selinux@tycho.nsa.gov>; Mon, 6 Feb 2012 11:21:55 -0500
Received: from mail-pw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id q16GLs77000491
	for <selinux@tycho.nsa.gov>; Mon, 6 Feb 2012 16:21:54 GMT
Received: by pbdu6 with SMTP id u6so6780796pbd.12
        for <selinux@tycho.nsa.gov>; Mon, 06 Feb 2012 08:21:54 -0800 (PST)
Message-ID: <1328545295.7648.14.camel@foxtrot.cjac.ntr.f5net.com>
Subject: Re: SELinux on Wheezy
From: "C.J. Adams-Collier KF7BMP" <cjac@colliertech.org>
To: Dominick Grift <dominick.grift@gmail.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>
Date: Mon, 06 Feb 2012 08:21:35 -0800
In-Reply-To: <1328543813.1905.2.camel@x220.mydomain.internal>
References: <1328502407.14110.7074.camel@calcifer>
	 <1328543813.1905.2.camel@x220.mydomain.internal>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-sMPA5KV5sd+c7j4GBCq+"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-sMPA5KV5sd+c7j4GBCq+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-02-06 at 16:56 +0100, Dominick Grift wrote:
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
> >=20
> > Thank you in advance!
> >=20
> > C.J.
> >=20
> >=20
>=20
> Seems to be an XACE issue.
>=20
> > > /var/log/Xorg.56.log.old:[    46.050] SELinux: a property label looku=
p failed!
> > > /var/log/Xorg.56.log.old:[    46.050] SELinux: Failed to set label pr=
operty on window!
>=20
> getsebool -a | xserver_object_manager
>=20
> Does it work if you set it to off?
>=20
> setsebool -P xserver_object_manager off
>=20
> http://selinuxproject.org/page/NB_XWIN

Thank you Dominick.  I will give this a try when I re-boot.

Russell, do you think this is something we should patch in to the xorg
debian packaging?


--=-sMPA5KV5sd+c7j4GBCq+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABCAAGBQJPL/4PAAoJEEyimPmPQm23xAMIAIf/kpWYdFS0nZDwIEKpdwox
c0oi39mkYs88aO7hdHZSIt/xuGj2AHdhViHH07+4zu7OvwAN0mekUUwYi2Kr+2gM
Z2yQX8BviRp/u54/dss2lqUCv/yja691Z8OhrosS43OQ7ngQAWMgwcR9N1xWwu5P
peAw6Q5bPlTA7UpyKM1EqpHNIvMznN7I6YK2Ia8i/7hidR+Bi1BKf9BFHs/Vrh1h
hHDsjD5sVoT8ZBsOGHrLHybtAxrD2ccYh873bR8xWdBMuixYOqeDWMqK9AzX2EAO
ntpKQuOUViFhdzUNhhFPYWS8VYEvABUnxVnuNXsP7s7rOITQgP/SQKWPSixSAio=
=9bkg
-----END PGP SIGNATURE-----

--=-sMPA5KV5sd+c7j4GBCq+--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
