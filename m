Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8QKK0rT028495
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 16:20:00 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8QKIw76019860
	for <selinux@tycho.nsa.gov>; Sun, 26 Sep 2004 20:18:59 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Sun, 26 Sep 2004 22:19:59 +0200
Date: Sun, 26 Sep 2004 22:20:33 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: policy for timidity
Message-Id: <20040926202033.GB2529@jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZJcv+A0YCCLh2VIg"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--ZJcv+A0YCCLh2VIg
Content-Type: multipart/mixed; boundary="5G06lTa6Jq83wMTw"
Content-Disposition: inline


--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Timidity can be used as alsa sequencer client and run as a daemon (when
started as timidity -iA). Attached policy allows this to work on a
SELinux system.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="timidity.te"

# DESC timidity - MIDI to WAV converter and player
#
# Author: Thomas Bleher <ThomasBleher@gmx.de>
#
# Note: You only need this policy if you want to run timidity as a server

daemon_base_domain(timidity)
can_network(timidity_t)

allow timidity_t device_t:lnk_file read;

# read /usr/share/alsa/alsa.conf
allow timidity_t usr_t:file { getattr read };
# read /etc/esd.conf and /proc/cpuinfo
allow timidity_t { etc_t proc_t }:file { getattr read };
# read libartscbackend.la - should these be shlib_t?
allow timidity_t lib_t:file { getattr read };

allow timidity_t sound_device_t:chr_file { read write ioctl };

# stupid timidity won't start if it can't search its current directory.
# allow this so /etc/init.d/alsasound start works from /root
allow timidity_t sysadm_home_dir_t:dir search;

allow timidity_t tmp_t:dir search;
allow timidity_t tmpfs_t:file { read write };

allow timidity_t self:shm create_shm_perms;

allow timidity_t self:unix_stream_socket { connect create };

allow timidity_t devpts_t:dir search;
allow timidity_t self:capability { dac_override dac_read_search };
allow timidity_t self:process getsched;

--5G06lTa6Jq83wMTw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="timidity.fc"

# timidity
/usr/bin/timidity	--	system_u:object_r:timidity_exec_t

--5G06lTa6Jq83wMTw--

--ZJcv+A0YCCLh2VIg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBVySRxWIrrrL0q+cRAk3rAJ9ROGWPni5v+Tm2EnTn8o4QDId/rQCfb+2c
uvHz3Jz/inO756SOxa4Zum4=
=QzfC
-----END PGP SIGNATURE-----

--ZJcv+A0YCCLh2VIg--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
