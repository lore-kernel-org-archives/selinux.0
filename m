Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8UDU0rT022968
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 09:30:00 -0400 (EDT)
Received: from obadja2.jmh.mhn.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8UDSsng006875
	for <selinux@tycho.nsa.gov>; Thu, 30 Sep 2004 13:28:54 GMT
Date: Thu, 30 Sep 2004 15:05:55 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: policy for timidity
Message-ID: <20040930130555.GC2773@cip.ifi.lmu.de>
References: <20040926202033.GB2529@jmh.mhn.de> <200409292144.47950.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
In-Reply-To: <200409292144.47950.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--qcHopEYAB45HaUaB
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Russell Coker <russell@coker.com.au> [2004-09-29 14:52]:
> On Mon, 27 Sep 2004 06:20, Thomas Bleher <bleher@informatik.uni-muenchen.=
de>=20
> wrote:
> > Timidity can be used as alsa sequencer client and run as a daemon (when
> > started as timidity -iA). Attached policy allows this to work on a
> > SELinux system.
>=20
> allow timidity_t tmpfs_t:file { read write };
>=20
> That is wrong.  Should be tmpfs_domain(timidity).
>=20
> Also for the unix_stream_socket access I think that there's no reason not=
 to=20
> use create_stream_socket_perms access.

Thanks for your comments!
A new version of timidity.te is attached.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--VbJkn9YxBvnuCH5J
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
tmpfs_domain(timidity)

allow timidity_t self:shm create_shm_perms;

allow timidity_t self:unix_stream_socket create_stream_socket_perms;

allow timidity_t devpts_t:dir search;
allow timidity_t self:capability { dac_override dac_read_search };
allow timidity_t self:process getsched;

--VbJkn9YxBvnuCH5J--

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBXASzxWIrrrL0q+cRAlMOAJ449tytDyJzgj6SdpkIrZv95WZ0yQCggt/s
Zyaewv5tTe3jBnhNltIh8OI=
=pVea
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
