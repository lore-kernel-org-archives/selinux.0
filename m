Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9B9rWrT005080
	for <selinux@tycho.nsa.gov>; Mon, 11 Oct 2004 05:53:32 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9B9qLfG021714
	for <selinux@tycho.nsa.gov>; Mon, 11 Oct 2004 09:52:22 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Mon, 11 Oct 2004 11:53:31 +0200
Date: Mon, 11 Oct 2004 11:54:11 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux <selinux@tycho.nsa.gov>
Subject: Re: Agressive Trimming of types.fc
Message-Id: <20041011095410.GB15844@jmh.mhn.de>
References: <1097177305.8508.49.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
In-Reply-To: <1097177305.8508.49.camel@moss-lions.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* James Carter <jwcart2@epoch.ncsc.mil> [2004-10-07 22:53]:
> Attached is an aggressive trimming of types.fc. =20
>=20
>  types.fc |  104
> ++++++---------------------------------------------------------
>  1 files changed, 11 insertions(+), 93 deletions(-)
>=20
> I am trying to make things a little easier to maintain and a little more
> flexible (to avoid the "it's i686 not i386" issues).  Please let me know
> what you think.
>=20
> This patch uses more generalized rules in labeling the following:
> 	lib_t and shlib_t in /opt
> 	lib_t, shlib_t, and ld_so_t in /lib(64)?
> 	lib_t, shlib_t, ld_so_t, bin_t, and sbin_t in /usr

It looks nice from a SuSE POV, except for two small points:

/usr/sbin/setfiles:  relabeling /usr/include/pgsql/internal/lib from system=
_u:object_r:usr_t to system_u:object_r:lib_t
/usr/sbin/setfiles:  relabeling /usr/include/pgsql/internal/lib/dllist.h fr=
om system_u:object_r:usr_t to system_u:object_r:lib_t
/usr/sbin/setfiles:  relabeling /usr/include/pgsql/server/lib from system_u=
:object_r:usr_t to system_u:object_r:lib_t
/usr/sbin/setfiles:  relabeling /usr/include/pgsql/server/lib/stringinfo.h =
=66rom system_u:object_r:usr_t to system_u:object_r:lib_t
/usr/sbin/setfiles:  relabeling /usr/include/pgsql/server/lib/dllist.h from=
 system_u:object_r:usr_t to system_u:object_r:lib_t
/usr/sbin/setfiles:  relabeling /usr/include/pgsql/server/lib/lispsort.h fr=
om system_u:object_r:usr_t to system_u:object_r:lib_t

I think everything under /usr/include should be labeled usr_t.
I do not really know how to fix this cleanly, but I don't think it's a
very big deal.

/usr/sbin/setfiles:  relabeling /opt/gnome2.8/var/lib from system_u:object_=
r:usr_t to system_u:object_r:lib_t
/usr/sbin/setfiles:  relabeling /opt/gnome2.8/var/lib/scrollkeeper from sys=
tem_u:object_r:usr_t to system_u:object_r:lib_t
/usr/sbin/setfiles:  relabeling /opt/gnome2.8/var/lib/scrollkeeper/C from s=
ystem_u:object_r:usr_t to system_u:object_r:lib_t
/usr/sbin/setfiles:  relabeling /opt/gnome2.8/var/lib/scrollkeeper/C/scroll=
keeper_cl.xml from system_u:object_r:usr_t to system_u:object_r:lib_t
[and so on]

Should these be labeled var_lib_t?

Otherwise the patch looks good and also fixes a few wrong labelings, so
it should definitely be included into cvs.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBalhCxWIrrrL0q+cRAoecAJ4wNCFvJBhVQ8CoBkHcpRTiDIUgbQCghDX/
+rMvkbr+A6zUUMspjHXYTGQ=
=S94i
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
