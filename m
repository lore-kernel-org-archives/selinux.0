Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i57NMJrT008422
	for <selinux@tycho.nsa.gov>; Mon, 7 Jun 2004 19:22:19 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i57NMFcx014070
	for <selinux@tycho.nsa.gov>; Mon, 7 Jun 2004 19:22:16 -0400 (EDT)
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Tue, 8 Jun 2004 01:22:10 +0200
Date: Tue, 8 Jun 2004 01:21:59 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: support for fireflight reading /proc/NNN/fd and /proc/NNN/exe
Message-Id: <20040607232158.GA2073@jmh.mhn.de>
References: <20040607082243.GH4543@lkcl.net> <20040607205957.GA3063@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
In-Reply-To: <20040607205957.GA3063@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Luke Kenneth Casson Leighton <lkcl@lkcl.net> [2004-06-08 00:50]:
> i picked fireflight because it does on-demand popup firewalling,
> which i think is great.
<snip>
> so what it does is look in /proc/NNN/exe and /proc/NNN/fds and
> looks up the executable...
<snip>=20
> .. but it also needs to be able to track the files themselves,
> getattr, and stuff.
>=20
> this is what i'm seeing:
>=20
> 	allow fireflier_t ptmx_t:chr_file { getattr };
> 	allow fireflier_t sound_device_t:chr_file { getattr };
> 	allow fireflier_t sysadm_ssh_t:tcp_socket { getattr };
> 	allow fireflier_t sysadm_tty_device_t:chr_file { getattr };
> 	allow fireflier_t user_devpts_t:chr_file { getattr };
> 	allow fireflier_t user_home_t:file { getattr };
> 	allow fireflier_t user_tmp_t:file { getattr };
> 	allow fireflier_t user_t:fifo_file { getattr };
> 	allow fireflier_t user_t:tcp_socket { getattr };
> 	allow fireflier_t user_t:unix_stream_socket { getattr };
> 	allow fireflier_t xdm_t:fifo_file { getattr };
>=20
>=20
> should i be looking to modify the can_ps macro?

Not the macro directly, otherwise all domains which use can_ps() will be
affected. If you really need that much access, you should probably add a
rule like
        allow fireflier_t file_type:file_class_set getattr;
        allow fireflier_t domain:{ socket_class_set fifo_file } getattr;
But this seems just too broad (see below).

> i mean, basically, everything in /proc/NNN/fds, fireflier is
> going to try to stat it.
>=20
<snip>

> and why, if i have can_ps(fireflier_t, domain), am i still seeing
> denied getattr on user_home_t?

user_home_t doesn't have the "domain"-attribute.

> .. alternatively, has anyone got any better ideas on how fireflier
> should be checking for executable program's names?

How about /proc/<pid>/exe ?
=20
> p.s. if i _don't_ allow it to look up these program names, i can
> expect fireflier to thoroughly lock up the machine as it can't
> tell me what to do with a packet, so it gets blocked.

I still don't get why it needs to look at all fds and stat all the
files. Could you tell us why it needs to stat all open filehandles to
find the program name?

A little bit confused,
Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAxPiWxWIrrrL0q+cRAvnuAJ0cOh4ppQmkKcrYpIzUMJfuLDworwCfRZP/
8ogG8XSnw9Dt7qajhtRIOHo=
=KZwO
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
