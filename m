Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1K220Uv015062
 for <selinux@tycho.nsa.gov>; Thu, 19 Feb 2015 21:02:00 -0500
Date: Thu, 19 Feb 2015 18:02:13 -0800
From: Tracy Reed <treed@ultraviolet.org>
To: Tracy Reed <treed@ultraviolet.org>
Subject: Re: MCS error
Message-ID: <20150220020213.GG12937@tracyreed.org>
References: <20150219014803.GB12937@tracyreed.org>
 <54E5E3C4.40904@tycho.nsa.gov>
 <20150219154047.GA11807@linksys-wireless-usb.network2>
 <20150219193337.GC12937@tracyreed.org>
 <20150219204841.GA1649@linksys-wireless-usb.network2>
 <20150220003425.GF12937@tracyreed.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="hrQ5MIiBPpJXe8FT"
In-Reply-To: <20150220003425.GF12937@tracyreed.org>
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--hrQ5MIiBPpJXe8FT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2015 at 04:34:25PM PST, Tracy Reed spake thusly:
> # semanage login -l

Ok, part of my confusion here is that I've been confusing semanage login wi=
th
semanage user. It's been a while since I've dealt with SELinux. I understand
that semanage login -l shows what Linux users map to what selinux users:

> Login Name                SELinux User              MLS/MCS Range        =
   =20
>=20
> __default__               unconfined_u              SystemLow-SystemHigh =
   =20
> p16001                    p16001_u                  p16001               =
   =20
> p16002                    appuser_u                 s0:c1.c499-s0:c2     =
   =20
> p16003                    appuser_u                 s0:c1.c499-s0:c3     =
   =20
> p16004                    unconfined_u              s0-s0:c0.c1023,c4    =
   =20
> p16005                    unconfined_u              s0-s0:c0.c1023,c4,c5 =
   =20
> p16006                    unconfined_u              s0-s0:c0.c1023,c6    =
   =20
> p16007                    unconfined_u              s0-s0:c0.c1023,c7    =
   =20
> p16008                    unconfined_u              s0-s0:c0.c1023,c8    =
   =20
> p16009                    unconfined_u              s0-s0:c0.c1023,c9    =
   =20
> root                      unconfined_u              SystemLow-SystemHigh =
   =20
> system_u                  system_u                  SystemLow-SystemHigh =
=20

So we are mapping p16002 to appuser_u but appuser_u doesn't exist at the
moment. But what's with the MLS/MCS range column?  Is this saying p16002 has
categories s0:c1.c499-s0:c2 is it saying appuser_u (selinux user) has
categories s0:c1.c499-s0:c2? Given that the selinux user is the same but the
categories listed are different for Linux login users p16002 and p16003 I w=
ould
think it is saying those categories go with those Linux login users.

How/why is it different from the output of semange user -l ?

# semanage user -l

Labeling   MLS/       MLS/                         =20
SELinux User    Prefix     MCS Level  MCS Range                      SELinu=
x Roles

git_shell_u     user       SystemLow  SystemLow                      git_sh=
ell_r
guest_u         user       SystemLow  SystemLow                      guest_r
p16001_u        user       SystemLow  p16001                         user_r
p16002_u        user       SystemLow  p16002                         user_r
root            user       SystemLow  SystemLow-SystemHigh           staff_=
r sysadm_r system_r unconfined_r
staff_u         user       SystemLow  SystemLow-SystemHigh           staff_=
r sysadm_r system_r unconfined_r
sysadm_u        user       SystemLow  SystemLow-SystemHigh           sysadm=
_r
system_u        user       SystemLow  SystemLow-SystemHigh           system=
_r unconfined_r
unconfined_u    user       SystemLow  SystemLow-SystemHigh           system=
_r unconfined_r
user_u          user       SystemLow  SystemLow-SystemHigh           user_r
xguest_u        user       SystemLow  SystemLow                      xguest=
_r

Here there are no Linux users involved, only selinux users it seems, which =
is
fine. But it shows p16001_u with range  p16001 and p16002_u with p16002.

And that is different yet with respect to the output of the chcat command:

# chcat -L -l p16001 p16002
p16001: s0:c0.c1023
p16002: s0:c0.c1023

This says p16001 and p16002 have access to all categories.

So...who is right?

Also, I'm still trying to figure out how to dig myself out of this hole:

# semanage user -a -R user_r appuser_u
libsemanage.validate_handler: selinux user appuser_u does not exist (No suc=
h file or directory).
libsemanage.validate_handler: seuser mapping [p16002 -> (appuser_u, s0:c1.c=
499-s0:c2)] is invalid (No such file or directory).
libsemanage.dbase_llist_iterate: could not iterate over records (No such fi=
le or directory).
/usr/sbin/semanage: Could not commit semanage transaction

This would seem to be a paradox or chicken and egg problem.

Ideas? Thanks! :)

--=20
Tracy Reed

--hrQ5MIiBPpJXe8FT
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFU5pWlBhSTPg0d/nQRAqMlAJ46ncXLaNYAyUG1/i1Nw2+dB3GNiACgvWri
zJihaEZzdrm5srncef86gck=
=vb1I
-----END PGP SIGNATURE-----

--hrQ5MIiBPpJXe8FT--
