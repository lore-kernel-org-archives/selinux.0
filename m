Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6GMhFrT002490
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 18:43:15 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6GMgpbx008523
	for <selinux@tycho.nsa.gov>; Fri, 16 Jul 2004 22:42:52 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Sat, 17 Jul 2004 00:43:12 +0200
Date: Sat, 17 Jul 2004 00:42:52 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Russell Coker <russell@coker.com.au>
Cc: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: file_contexts patch
Message-Id: <20040716224252.GD4940@obadja.jmh.mhn.de>
References: <20040716201531.GB4940@obadja.jmh.mhn.de> <200407170802.08072.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qxfKREH7IwbezJ+T"
In-Reply-To: <200407170802.08072.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--qxfKREH7IwbezJ+T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Russell Coker <russell@coker.com.au> [2004-07-17 00:02]:
> On Sat, 17 Jul 2004 06:15, Thomas Bleher <bleher@informatik.uni-muenchen.=
de>=20
> wrote:
> > The attached patch adds some file_contexts and most importantly labels
> > libs under /opt correctly.
>=20
> Why does kdesktop_lock need to be labelled as screensaver_exec_t?  The pr=
oblem=20
> that caused the creation of the screen saver policy has only been reporte=
d=20
> under GNOME, and kdesktop_lock has been working well for me for years wit=
hout=20
> such policy.

The screensaver policy has auth_chkpwd which is needed when locking the
screen IIRC. The only problem is that kdesktop_lock doesn't use
unix_chkpwd but has its own program (kcheckpass). I have labeled it
chkpwd_exec_t which works fine, but unfortunately kcheckpass needs some
additional permissions (from macros/program/chkpwd_macros.te):

ifelse($1, `system', `', `allow $1_chkpwd_t $1_t:unix_stream_socket { read =
write };')
# read KDesktop
allow system_chkpwd_t $1_home_t:dir read;
# write to .xsession-errors
allow system_chkpwd_t $1_home_t:file write;
(Or something like that. I live on NFS and just converted the rules)

I do not know if this is mergable into mainline.
=20
> What is /dev/usbscanner?  It's not in devices.txt in the kernel source an=
d not=20
> installed by default on any Debian or Fedora system.

Call it a SuSE oddity:
# ls -l /dev/usbscanner /dev/usb/scanner0
crw-rw----    1 root     root     180,  48 Sep  9  2002 /dev/usb/scanner0
crw-r--r--    1 root     root     180,  48 Sep  9  2002 /dev/usbscanner
(why they have different permissions there I can't imagine)

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--qxfKREH7IwbezJ+T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA+FnsxWIrrrL0q+cRApbbAJ9WITH1G60LSgfmtJDwFmenxn6s0ACff3eo
m/aggrgZV6M9T+5oWPKSmiY=
=yRZZ
-----END PGP SIGNATURE-----

--qxfKREH7IwbezJ+T--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
