Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9HZrIi014150
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 12:35:53 -0500 (EST)
Received: from mailrelay1.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9HYFPS008722
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 17:34:15 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Thu, 9 Dec 2004 18:35:54 +0100
Date: Thu, 9 Dec 2004 18:35:55 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: patch: policy for powernowd
Message-Id: <20041209173555.GE5074@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n/aVsWSeQ4JHkrmm"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--n/aVsWSeQ4JHkrmm
Content-Type: multipart/mixed; boundary="H8ygTp4AXg6deix2"
Content-Disposition: inline


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Attached is policy for powernowd.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="powernowd.te"

# DESC powernowd - Daemon to control the speed and voltage of cpus
#
# Author: Thomas Bleher <ThomasBleher@gmx.de>

daemon_base_domain(powernowd)
read_locale(powernowd_t)

# write values under /sys/devices/system/cpu/cpu0/cpufreq/
allow powernowd_t sysfs_t:file write;
# read /proc/cpuinfo
allow powernowd_t proc_t:file { getattr read };
# read /etc/fstab and /etc/mtab
allow powernowd_t { etc_t etc_runtime_t }:file { getattr read };
allow powernowd_t self:process setsched;
allow powernowd_t self:unix_dgram_socket create_socket_perms;

--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="powernowd.fc"

# powernowd
/usr/sbin/powernowd	--	system_u:object_r:powernowd_exec_t

--H8ygTp4AXg6deix2--

--n/aVsWSeQ4JHkrmm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBuIz7xWIrrrL0q+cRAl3QAKCH4gd789DMCs35n0FCYm/J5SCkfgCghszk
77C1F2IOTuZKgqg1forrFig=
=YEic
-----END PGP SIGNATURE-----

--n/aVsWSeQ4JHkrmm--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
