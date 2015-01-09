Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t09MJKp0010582
 for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2015 17:19:20 -0500
Received: by mail-we0-f171.google.com with SMTP id u56so10274883wes.2
 for <selinux@tycho.nsa.gov>; Fri, 09 Jan 2015 14:19:14 -0800 (PST)
Received: from bigboy.network2 (84-245-31-108.dsl.cambrium.nl. [84.245.31.108])
 by mx.google.com with ESMTPSA id fx6sm11552802wjc.39.2015.01.09.14.19.12
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Fri, 09 Jan 2015 14:19:13 -0800 (PST)
Date: Fri, 9 Jan 2015 23:19:11 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: Re: RFC: https://bugzilla.redhat.com/show_bug.cgi?id=1174405
Message-ID: <20150109221910.GA11417@bigboy.network2>
References: <1420837553.31986.2.camel@gmail.com>
 <CAB9W1A3Y_+gZv=ZWGTGvuk_z8P_Ys7SVNAUz8wRCS1EDW_dcJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
In-Reply-To: <CAB9W1A3Y_+gZv=ZWGTGvuk_z8P_Ys7SVNAUz8wRCS1EDW_dcJg@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09, 2015 at 04:52:18PM -0500, Stephen Smalley wrote:
> Ports in the local port range can be auto-assigned by the kernel to
> unbound sockets on first use.  So it makes no sense to control them,
> and there isn't even an LSM hook in the place where such auto-port
> selection occurs.  Controlling binding to ports is only useful when
> the port number is a "name" (i.e. a well-defined value that is
> expected to correspond to a specific service), to prevent spoofing of
> security-relevant services like sshd.

Okay for the sake of argument let's say that makes sense to me. Should SELi=
nux not somehow communicate this to the user.

First we had the scenario where selinux denies and not logs denials (user s=
pace object managers) and now we have the scenario where
selinux allows even if there is no rule to allow it

As a policy writer it gave me confidence to know that "if selinux blocks it=
 logs" and that "selinux denies access by default". Now that those things t=
urn out to not be true. Its a black box. voodoo.

>=20
> On Fri, Jan 9, 2015 at 4:05 PM, Dominick Grift <dac.override@gmail.com> w=
rote:
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D1174405
> >
> > This is a inconsistency in SELinux
> >
> >
> >
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to Selinux-request@tycho.n=
sa.gov.

--=20
Dominick Grift

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJUsFPWAAoJENAR6kfG5xmc6U4L/AhFggqmi9bFQj/yog3afUYp
akG2NtzbdT6tW7zvdXYiDeXtBsm3S1C7GmPjCjXffEVxWXnmyQO/UXPfeqMyJk1p
S8Hbc2a2M3x3aMuzlRa3zA2kWJnWXF8kC+zB0J2PNhpv7skRY+qEr8So6TlpclkH
MqzdR0rqLYnN6VvBQE6MKgQwc8lDc8zFROiJDiFWbqaixgkiawvn2zyw41F7yFDW
0EUY6XvVG0NNMTtm4Vyy2aPqv75vcQBgBEq+wjo21CzFUJYosWoU2d1YjmYumwy5
CedNyrLrGAUDl6llpetFqyplSRZuGdRgEk9H6KvlmDbl6MqeiBl9mGR3xclnszco
WqH14pj7TuSUQIdJQgVQM/mNPjzOPmbpTyuThe7xf58V2xOsVcW1QwS+frbiJUFj
IEEKNMuteY27E7uwMJ2PzbNH8Ukf8V/mLDFAocnWjw/2dK1uyhG49XUnQoLHUz0L
oNkKg72ps4DG6jrpCWQel82CHb0S0YyjA3E33bp1qQ==
=UyAs
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
