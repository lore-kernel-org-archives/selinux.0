Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8HN5FrT006325
	for <selinux@tycho.nsa.gov>; Fri, 17 Sep 2004 19:05:15 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8HN4HNM020003
	for <selinux@tycho.nsa.gov>; Fri, 17 Sep 2004 23:04:18 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Sat, 18 Sep 2004 01:05:13 +0200
Date: Sat, 18 Sep 2004 01:05:46 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: James Carter <jwcart2@epoch.ncsc.mil>
Cc: SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: policy patch: some misc additions
Message-Id: <20040917230545.GB2517@jmh.mhn.de>
References: <20040911133324.GA2557@jmh.mhn.de> <1095451769.4295.7.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HWvPVVuAAfuRc6SZ"
In-Reply-To: <1095451769.4295.7.camel@moss-lions.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--HWvPVVuAAfuRc6SZ
Content-Type: multipart/mixed; boundary="Izn7cH1Com+I3R9J"
Content-Disposition: inline


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* James Carter <jwcart2@epoch.ncsc.mil> [2004-09-17 23:58]:
> On Sat, 2004-09-11 at 09:33, Thomas Bleher wrote:
> > The following patch against latest CVS adds some misc policy:
> >=20
> > types.fc: added file contexts for some kde and gnome libraries
> >           (filenames are like /opt/kde3/lib/kde3/kcalc.so)
> >           the nVidia libs need some extra file context, too
>=20
> > diff -ur orig/file_contexts/types.fc mod/file_contexts/types.fc
> > --- orig/file_contexts/types.fc 2004-09-11 14:31:47.000000000 +0200
> > +++ mod/file_contexts/types.fc  2004-09-11 14:47:06.000000000 +0200
> > @@ -336,11 +340,14 @@
> >  /usr/lib(64)?/autofs/.*\.so    --      system_u:object_r:shlib_t
> >  /usr/lib(64)?/perl5/man(/.*)?  system_u:object_r:man_t
> >  /usr/lib(64)?/perl.*\.so       --      system_u:object_r:shlib_t
> > +/usr/lib(64)?/(NORM|NVIDIA)_lib.*\.so(\.[^/]*)*        --      system_=
u:object_r:shlib_t
> > +/usr/lib(64)?/tls/NVIDIA/(NORM|NVIDIA)_lib.*\.so(\.[^/]*)*     --     =
 system_u:object_r:shlib_t
> >  /usr/lib(64)?/selinux(/.*)?            system_u:object_r:policy_src_t
> >  /usr/lib(64)?/emacsen-common/.*        system_u:object_r:bin_t
> >  /usr/lib(64)?/.*/bin(/.*)?             system_u:object_r:bin_t
> >  /usr/lib(64)?/gconv/.*\.so     --      system_u:object_r:shlib_t
> >  /usr/share/guile/g-wrapped/.*\.so -- system_u:object_r:shlib_t
> > +/usr/lib/[^/]*\.so     --      system_u:object_r:shlib_t
>=20
> Why add this?  Why not /usr/lib(64)?/[^/]*\.so ?

Because I have no 64bit system and didn't think of it? ;-)

> If this rule is added, some other rules can be deleted.

True. We already have
/usr/lib(64)?/.*/.*\.so --      system_u:object_r:shlib_t
a few lines above, so we can probably just say
/usr/lib(64)?/.*\.so    --      system_u:object_r:shlib_t
and be OK.

Patch which does this attached.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="types.fc.patch"
Content-Transfer-Encoding: quoted-printable

diff -ur orig/file_contexts/types.fc mod/file_contexts/types.fc
--- orig/file_contexts/types.fc	2004-09-15 19:01:06.000000000 +0200
+++ mod/file_contexts/types.fc	2004-09-18 01:03:46.000000000 +0200
@@ -334,16 +334,12 @@
 #
 /usr/lib(64)?(/.*)?			system_u:object_r:lib_t
 /usr/lib(64)?/lib[^/]*\.so(\.[^/]*)*	--	system_u:object_r:shlib_t
-/usr/lib(64)?/python.*\.so	--	system_u:object_r:shlib_t
 /usr/lib(64)?/.*/lib[^/]*\.so(\.[^/]*)* --	system_u:object_r:shlib_t
-/usr/lib(64)?/.*/.*\.so	--	system_u:object_r:shlib_t
-/usr/lib(64)?/autofs/.*\.so	--	system_u:object_r:shlib_t
+/usr/lib(64)?/.*\.so	--	system_u:object_r:shlib_t
 /usr/lib(64)?/perl5/man(/.*)?	system_u:object_r:man_t
-/usr/lib(64)?/perl.*\.so	--	system_u:object_r:shlib_t
 /usr/lib(64)?/selinux(/.*)?		system_u:object_r:policy_src_t
 /usr/lib(64)?/emacsen-common/.*	system_u:object_r:bin_t
 /usr/lib(64)?/.*/bin(/.*)?		system_u:object_r:bin_t
-/usr/lib(64)?/gconv/.*\.so	--	system_u:object_r:shlib_t
 /usr/share/guile/g-wrapped/.*\.so -- system_u:object_r:shlib_t
=20
 #

--Izn7cH1Com+I3R9J--

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBS23JxWIrrrL0q+cRAohAAJ97btC/VqsDaa9oozs/jTqbPkyRzgCdGBIE
J0UJeN2Op/VDxXjAPYCaeqE=
=UMbe
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
