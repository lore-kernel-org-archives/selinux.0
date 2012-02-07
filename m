Date: Tue, 7 Feb 2012 12:02:24 -0800
From: "C.J. Adams-Collier" <cjac@colliertech.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Dominick Grift <dominick.grift@gmail.com>,
        SE-Linux <selinux@tycho.nsa.gov>, Russell Coker <russell@coker.com.au>
Subject: Re: SELinux on Wheezy
Message-ID: <20120207200224.GB18478@colliertech.org>
References: <1328502407.14110.7074.camel@calcifer>
 <1328543813.1905.2.camel@x220.mydomain.internal>
 <1328545295.7648.14.camel@foxtrot.cjac.ntr.f5net.com>
 <1328636118.4224.35.camel@foxtrot.cjac.ntr.f5net.com>
 <1328636826.2162.60.camel@moss-pluto>
 <1328640976.4224.39.camel@foxtrot.cjac.ntr.f5net.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
In-Reply-To: <1328640976.4224.39.camel@foxtrot.cjac.ntr.f5net.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

cjac@foxtrot:~$ scp ~/selinux/*20120207*.log 172.16.12.22:/var/www/colliert=
ech.org/wiki/federal/nsa/

--

~/selinux/semodule_-l_20120207T110759.log:
apache	2.3.0=09
dbus	1.15.0=09
devicekit	1.1.0=09
dmidecode	1.4.0=09
exim	1.5.0=09
ftp	1.13.0=09
git	1.0=09
gpg	2.4.0=09
lda	1.9.0=09
lvm	1.13.0=09
netutils	1.11.0=09
openvpn	1.10.0=09
ptchown	1.1.0=09
pythonsupport	0.0.1=09
remotelogin	1.7.0=09
rpc	1.13.0=09
rpcbind	1.5.0=09
rsync	1.11.0=09
ssh	2.2.0=09
sudo	1.8.0=09
tcpd	1.4.0=09
telnet	1.10.0=09
tzdata	1.4.0=09
unconfined	3.3.0=09

--

~/selinux/sestatus_-v_20120207T110759.log:
SELinux status:                 enabled
SELinuxfs mount:                /selinux
Current mode:                   permissive
Mode from config file:          permissive
Policy version:                 26
Policy from config file:        default

Process contexts:
Current context:                unconfined_u:system_r:insmod_t:SystemLow-Sy=
stemHigh
Init context:                   system_u:system_r:kernel_t:SystemLow
/usr/sbin/sshd                  system_u:system_r:kernel_t:SystemLow

File contexts:
Controlling term:               unconfined_u:object_r:tty_device_t:SystemLow
/etc/passwd                     unconfined_u:object_r:user_home_t:SystemLow
/etc/shadow                     unconfined_u:object_r:user_home_t:SystemLow
/bin/bash                       unconfined_u:object_r:user_home_t:SystemLow
/bin/login                      unconfined_u:object_r:user_home_t:SystemLow
/bin/sh                         unconfined_u:object_r:user_home_t:SystemLow=
 -> unconfined_u:object_r:user_home_t:SystemLow
/sbin/agetty                    unconfined_u:object_r:user_home_t:SystemLow
/sbin/init                      unconfined_u:object_r:user_home_t:SystemLow
/usr/sbin/sshd                  system_u:object_r:sshd_exec_t:SystemLow
/lib/ld-linux.so.2              unconfined_u:object_r:user_home_t:SystemLow=
 -> unconfined_u:object_r:user_home_t:SystemLow

--

~/selinux/ausearch_-m_20120207T110759.log:
Tue Feb  7 11:14:55 PST 2012
<no matches>

--

cjac@foxtrot:~$ klist
Ticket cache: FILE:/tmp/krb5cc_1000
Default principal: cjac@COLLIERTECH.ORG

Valid starting    Expires           Service principal
07/02/2012 12:01  07/02/2012 22:01  krbtgt/COLLIERTECH.ORG@COLLIERTECH.ORG
        renew until 08/02/2012 12:01

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBCAAGBQJPMYNQAAoJEEyimPmPQm23oRYH/2CJ/4FuwgJYfrBkGb9N80T8
zSDPFTOz4anEgIro3bUgBDnr9BJ6oZ/pbhwUL68dQ+b442Ug7FLJbin973DMjh8U
t7feuVdZK9yO/2uBCKDWpv6dFQLvPSNgIrINzito750aQQ8Bp8JCA0rbKbRXXHBh
2r679GAn9OY5Hrf3FUObQz1Y/TNngeS81e0hNqrI5DubVixy9uLXg4xZf4/siysW
A35+rK2bybUXMJnvqHAaZ3QiQC72HdhrHfqMZdT6bGYP/rRWXbT+PMRWIGatUSwb
WadHm/AK0gQIhVXc5p6IoYgaki7WGzyTdsHQ/3h5DSyGzMABd0yEWNutPU0McEU=
=hh3j
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
