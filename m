Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i74FPlrT029004
	for <selinux@tycho.nsa.gov>; Wed, 4 Aug 2004 11:25:47 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i74FPDVf021892
	for <selinux@tycho.nsa.gov>; Wed, 4 Aug 2004 15:25:14 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i74FPle1022088
	for <selinux@tycho.nsa.gov>; Wed, 4 Aug 2004 11:25:47 -0400
Subject: [patch] allow rpm_t to create/relabel device files too
From: Colin Walters <walters@redhat.com>
To: dwalsh@redhat.com, rcoker@redhat.com
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-aRKuuOnkSzEw9o8g1qgH"
Date: Wed, 04 Aug 2004 11:26:03 -0400
Message-Id: <1091633163.9005.26.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-aRKuuOnkSzEw9o8g1qgH
Content-Type: multipart/mixed; boundary="=-mzLC9mYbfiNEo9e+3z6M"


--=-mzLC9mYbfiNEo9e+3z6M
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

The attached patch allows rpm_t to create/relabel device files - I
needed this when upgrading the "dev" package on my system.  I'm
surprised this hasn't been caught before, maybe I missed something.

Some AVC messages for reference:

Aug  4 11:11:43 decepticon kernel: audit(1091632303.691:0): avc:  denied  {=
 getattr } for  pid=3D31094 exe=3D/usr/bin/python path=3D/dev/dri dev=3Dsda=
2 ino=3D10111422 scontext=3Droot:sysadm_r:rpm_t tcontext=3Dsystem_u:object_=
r:dri_device_t tclass=3Ddir
Aug  4 11:16:50 decepticon kernel: audit(1091632610.920:0): avc:  denied  {=
 relabelfrom } for  pid=3D31149 exe=3D/usr/bin/python name=3Ddri dev=3Dsda2=
 ino=3D10111422 scontext=3Droot:sysadm_r:rpm_t tcontext=3Dsystem_u:object_r=
:dri_device_t tclass=3Ddir


--=-mzLC9mYbfiNEo9e+3z6M
Content-Disposition: attachment; filename=dev.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=dev.patch; charset=UTF-8

LS0tIHBvbGljeS0xLjE1LjExL2RvbWFpbnMvcHJvZ3JhbS91bnVzZWQvcnBtLnRlfgkyMDA0LTA3
LTMxIDA2OjIyOjM3LjAwMDAwMDAwMCAtMDQwMA0KKysrIHBvbGljeS0xLjE1LjExL2RvbWFpbnMv
cHJvZ3JhbS91bnVzZWQvcnBtLnRlCTIwMDQtMDgtMDQgMTE6MjA6NDAuMTY1NDExNjg4IC0wNDAw
DQpAQCAtOTAsOSArOTAsOSBAQA0KIGdlbmVyYWxfZG9tYWluX2FjY2VzcyhycG1fc2NyaXB0X3Qp
DQogDQogIyByZWFkL3dyaXRlL2NyZWF0ZSBhbnkgZmlsZXMgaW4gdGhlIHN5c3RlbQ0KLWFsbG93
IHJwbV90IHsgZmlsZV90eXBlIC0gc2hhZG93X3QgfTp7IGZpbGUgbG5rX2ZpbGUgZGlyIGZpZm9f
ZmlsZSBzb2NrX2ZpbGUgY2hyX2ZpbGUgYmxrX2ZpbGUgfSB7IHJlbGFiZWxmcm9tIHJlbGFiZWx0
byB9Ow0KLWFsbG93IHJwbV90IHsgZmlsZV90eXBlIC0gc2hhZG93X3QgfTpkaXIgY3JlYXRlX2Rp
cl9wZXJtczsNCi1hbGxvdyBycG1fdCB7IGZpbGVfdHlwZSAtIHNoYWRvd190IH06eyBmaWxlIGxu
a19maWxlIGZpZm9fZmlsZSBzb2NrX2ZpbGUgY2hyX2ZpbGUgYmxrX2ZpbGUgfSBjcmVhdGVfZmls
ZV9wZXJtczsNCithbGxvdyBycG1fdCB7IGZpbGVfdHlwZSBkZXZpY2VfdHlwZSAtc2hhZG93X3Qg
fTp7IGZpbGUgbG5rX2ZpbGUgZGlyIGZpZm9fZmlsZSBzb2NrX2ZpbGUgY2hyX2ZpbGUgYmxrX2Zp
bGUgfSB7IHJlbGFiZWxmcm9tIHJlbGFiZWx0byB9Ow0KK2FsbG93IHJwbV90IHsgZmlsZV90eXBl
IGRldmljZV90eXBlIC0gc2hhZG93X3QgfTpkaXIgY3JlYXRlX2Rpcl9wZXJtczsNCithbGxvdyBy
cG1fdCB7IGZpbGVfdHlwZSBkZXZpY2VfdHlwZSAtIHNoYWRvd190IH06eyBmaWxlIGxua19maWxl
IGZpZm9fZmlsZSBzb2NrX2ZpbGUgY2hyX2ZpbGUgYmxrX2ZpbGUgfSBjcmVhdGVfZmlsZV9wZXJt
czsNCiBhbGxvdyBycG1fdCBzeXNmc190OmZpbGVzeXN0ZW0gZ2V0YXR0cjsNCiBhbGxvdyBycG1f
dCB0bXBmc190OmZpbGVzeXN0ZW0gZ2V0YXR0cjsNCiBkb250YXVkaXQgcnBtX3QgZG9tYWluOnsg
c29ja2V0IHVuaXhfZGdyYW1fc29ja2V0IHVkcF9zb2NrZXQgdW5peF9zdHJlYW1fc29ja2V0IHRj
cF9zb2NrZXQgZmlmb19maWxlIHJhd2lwX3NvY2tldCBwYWNrZXRfc29ja2V0IH0gZ2V0YXR0cjsN
Cg==


--=-mzLC9mYbfiNEo9e+3z6M--

--=-aRKuuOnkSzEw9o8g1qgH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBEQALOIkJWWp2WGURArpCAJ43fSQFs8EW+AAkZX5cxFcY2Jf6ZACeM5dN
41XJHp4sz9twhJzask4Q/Ng=
=pRp4
-----END PGP SIGNATURE-----

--=-aRKuuOnkSzEw9o8g1qgH--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
