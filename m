Date: Tue, 7 Feb 2012 13:05:01 -0800
From: "C.J. Adams-Collier" <cjac@colliertech.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Dominick Grift <dominick.grift@gmail.com>,
        SE-Linux <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>
Subject: Re: SELinux on Wheezy
Message-ID: <20120207210501.GE18478@colliertech.org>
References: <1328502407.14110.7074.camel@calcifer>
 <1328543813.1905.2.camel@x220.mydomain.internal>
 <1328545295.7648.14.camel@foxtrot.cjac.ntr.f5net.com>
 <1328636118.4224.35.camel@foxtrot.cjac.ntr.f5net.com>
 <1328636826.2162.60.camel@moss-pluto>
 <1328640976.4224.39.camel@foxtrot.cjac.ntr.f5net.com>
 <20120207200224.GB18478@colliertech.org>
 <1328645305.2162.105.camel@moss-pluto>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qOrJKOH36bD5yhNe"
In-Reply-To: <1328645305.2162.105.camel@moss-pluto>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--qOrJKOH36bD5yhNe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2012 at 03:08:25PM -0500, Stephen Smalley wrote:
> On Tue, 2012-02-07 at 12:02 -0800, C.J. Adams-Collier wrote:
> > ~/selinux/semodule_-l_20120207T110759.log:
> > apache	2.3.0=09
> > dbus	1.15.0=09
> > devicekit	1.1.0=09
> > dmidecode	1.4.0=09
> > exim	1.5.0=09
> > ftp	1.13.0=09
> > git	1.0=09
> > gpg	2.4.0=09
> > lda	1.9.0=09
> > lvm	1.13.0=09
> > netutils	1.11.0=09
> > openvpn	1.10.0=09
> > ptchown	1.1.0=09
> > pythonsupport	0.0.1=09
> > remotelogin	1.7.0=09
> > rpc	1.13.0=09
> > rpcbind	1.5.0=09
> > rsync	1.11.0=09
> > ssh	2.2.0=09
> > sudo	1.8.0=09
> > tcpd	1.4.0=09
> > telnet	1.10.0=09
> > tzdata	1.4.0=09
> > unconfined	3.3.0
>=20
> So no xserver module, unless it happens to be part of your base module.
> seinfo -txserver_t

cjac@foxtrot:~$ sudo which seinfo
cjac@foxtrot:~$ apt-file search seinfo | grep bin | wc -l
0

Any idea where I can get the xserver module?  Russell?
=20
>=20
> > ~/selinux/sestatus_-v_20120207T110759.log:
> > SELinux status:                 enabled
> > SELinuxfs mount:                /selinux
> > Current mode:                   permissive
> > Mode from config file:          permissive
> > Policy version:                 26
> > Policy from config file:        default
> >=20
> > Process contexts:
> > Current context:                unconfined_u:system_r:insmod_t:SystemLo=
w-SystemHigh
> > Init context:                   system_u:system_r:kernel_t:SystemLow
> > /usr/sbin/sshd                  system_u:system_r:kernel_t:SystemLow
> >=20
> > File contexts:
> > Controlling term:               unconfined_u:object_r:tty_device_t:Syst=
emLow
> > /etc/passwd                     unconfined_u:object_r:user_home_t:Syste=
mLow
> > /etc/shadow                     unconfined_u:object_r:user_home_t:Syste=
mLow
> > /bin/bash                       unconfined_u:object_r:user_home_t:Syste=
mLow
> > /bin/login                      unconfined_u:object_r:user_home_t:Syste=
mLow
> > /bin/sh                         unconfined_u:object_r:user_home_t:Syste=
mLow -> unconfined_u:object_r:user_home_t:SystemLow
> > /sbin/agetty                    unconfined_u:object_r:user_home_t:Syste=
mLow
> > /sbin/init                      unconfined_u:object_r:user_home_t:Syste=
mLow
> > /usr/sbin/sshd                  system_u:object_r:sshd_exec_t:SystemLow
> > /lib/ld-linux.so.2              unconfined_u:object_r:user_home_t:Syste=
mLow -> unconfined_u:object_r:user_home_t:SystemLow
>=20
> So everything except for /usr/sbin/sshd has the wrong file context, and
> all of your processes are still running in the kernel's domain.
>=20
> I think you need a new policy, and then you need to relabel your
> filesystems.

Sounds reasonable.  Do I get policy from my distribution, or should I
generate one myself?

cjac@foxtrot:~$ dpkg -l | grep selinux-policy
ii  selinux-policy-default               2:2.20110726-3                 Str=
ict and Targeted variants of the SELinux policy
ii  selinux-policy-dev                   2:2.20110726-3                 Hea=
ders from the SELinux reference policy for building modules
ii  selinux-policy-doc                   2:2.20110726-3                 Doc=
umentation for the SELinux reference policy

cjac@foxtrot:~$ apt-cache search selinux-policy
selinux-policy-default - Strict and Targeted variants of the SELinux policy
selinux-policy-dev - Headers from the SELinux reference policy for building=
 modules
selinux-policy-doc - Documentation for the SELinux reference policy
selinux-policy-mls - MLS (Multi Level Security) variant of the SELinux poli=
cy
selinux-policy-src - Source of the SELinux reference policy for customizati=
on

If I'm going to generate one myself, I need to understand them a bit
better.  I would like anything I generate to be useable by the rest of
the Debian world.  There seem to be some examples I ran review in the
selinux-policy-doc and selinux-policy-mls packages.

Regarding re-labeling, every time I boot without the selinux arguments
to my kernel and then boot with them, the filesystem seems to get
re-labeled.  Is there a better way to do this?

Thanks for helping me cope with my ignorance.

C.J.

--qOrJKOH36bD5yhNe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBCAAGBQJPMZH9AAoJEEyimPmPQm23jxwH/iP43cVEgo348gT4emsQ6nTL
hDVPSz7WkQsBda5lJj3eF5DqtyxB6JVLT6yRWQI3v8kjiX7oeoOX0Cbs1HB6dOcr
ZFBGe+B4jr/9nXrJrcPo1jhRiBTDRUU/XBKuoiF/iBP3H1briPsQmBpbb/TimruD
9favHSX2fCGgVWiRvkYp2D4EOLpjC6Lr+mo1DXgI4PxS+TSHOPU/sA0UudN7okwS
yxuDRH2uVGCSAVvzd9SW9T42eeTT7CbWVyMj7js7wossMHToyIPYvW+iX4gEyGoh
DNgiPHvoDkEVqR2i3wTEln6ZN4Az+L1/uWuWI5IT/KBX3kobhWUaOihgTQeaX54=
=3kEA
-----END PGP SIGNATURE-----

--qOrJKOH36bD5yhNe--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
