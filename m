Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t7QEWBbi017304
 for <selinux@tycho.nsa.gov>; Wed, 26 Aug 2015 10:32:12 -0400
Received: by wicja10 with SMTP id ja10so17234027wic.1
 for <selinux@tycho.nsa.gov>; Wed, 26 Aug 2015 07:32:06 -0700 (PDT)
Date: Wed, 26 Aug 2015 16:32:04 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: My notes on the 2015 Linux Security Summit
Message-ID: <20150826143203.GB26572@x250>
References: <9421874.fduThv0mJV@sifl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
In-Reply-To: <9421874.fduThv0mJV@sifl>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2015 at 10:17:29AM -0400, Paul Moore wrote:
> Hello all,
>=20
> In case you are interested, I took some notes this year while at the Linu=
x=20
> Security Summit and posted a quick summary of the talks online:
>=20
>  * http://www.paul-moore.com/blog/d/2015/08/linux_security_summit.html
>=20
> -Paul

Thank you. I wish there were recordings of the various talk. I am
particularly interested in learning more about how googles IOCTL patch
and about how Stephen Smalley envisions the google selinux policy model
on generic GNU/Linux systems. your talk about linux-audit is seems
interesting and timely to me. Especially Since we currently have two audit =
daemons in
Fedora by default, and people who actually use audit in a meaningful way
know how io-intensive it can be. Let alone logging everything twice...

--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=3Dvindex&search=3D0x314883A202DFF788
Dominick Grift

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJV3c3dAAoJENAR6kfG5xmcVJgL/jygvArIAA7ZYCoSTb2smvYg
dBcgXR0pgvmVHRT1i9ze9sRXRvk+PnGNu70aftFP6JZoBnEmXLi4bpHherUx3HWH
H3ZneaOjhOtusf8DgOYBScfLYTAQsX+9zRLdYXc8fccgXYlym2aK4nsHrzvhRBJV
mluLXkp9OH5E6nJ4S7MUUNklWRVWaUsqrHsZ20FEKt4vwV9Wk/oYLYgbOjwr0PmP
WSVmdOxTZIxbmlkWl97YO2pPGhKXp6e5lX7yK6oV1LJMOryU76lhZAfzsZlDk1Lf
CEmnyeMSJ62wbAuuPnnYVCoARvopB/l47UKTVsLpmz/U9W4kFgr2GmEOoVhiFKO4
qlJ5Lkbe94xyjqBF7tzwruxRpRzRxRl2F3fAzT38D2ZIUUAO18ilZhiV95I9kcOw
ZnaP4CPtqleaCngAEq4qy4d4qo3UkJF7D8G686jM1asrccr6fwmXCrvKvvP5WaDT
sAAbytqoq7lHShaOMyQeHjBk6NK3s9xyQF9MwXbnyg==
=5sHJ
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
