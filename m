Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8AF7YrT019206
	for <selinux@tycho.nsa.gov>; Fri, 10 Sep 2004 11:07:34 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8AF7Xl6008502
	for <selinux@tycho.nsa.gov>; Fri, 10 Sep 2004 15:07:33 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i8AF7X70025791
	for <selinux@tycho.nsa.gov>; Fri, 10 Sep 2004 11:07:33 -0400
Subject: [patch] don't relabel sub-subdirectories of /mnt, /media by default
From: Colin Walters <walters@redhat.com>
To: selinux@tycho.nsa.gov, dwalsh@redhat.com, rcoker@redhat.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-mRYSxUcmbtXEuAwLXp3V"
Date: Fri, 10 Sep 2004 11:08:56 -0400
Message-Id: <1094828936.7061.20.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-mRYSxUcmbtXEuAwLXp3V
Content-Type: multipart/mixed; boundary="=-HsSWxoB9O+9Xs8zMiJoX"


--=-HsSWxoB9O+9Xs8zMiJoX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

The attached patch ensures we don't try to relabel files from arbitrary
mounts, like /media/usbkey/*.  One person pointed out on fedora-devel
that setting extended attributes on ext3 causes older kernels not to be
able to mount them.  It seems safest to have the default behavior be the
least invasive.  People who want to label their mount points can do so
manually. =20

One thing that might be nice is to have a "removable_context" config
file.  Then we modify HAL to automatically mount removable media with -o
context=3D$(cat $SELINUXROOT/contexts/removable_context).  (Really getting
the context via libselinux of course).  People who want to override that
behavior can simply add the device manually to fstab, that will cause
HAL not to create a new entry.




--=-HsSWxoB9O+9Xs8zMiJoX
Content-Disposition: attachment; filename=no-relabel-media.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=no-relabel-media.patch; charset=UTF-8

LS0tIHBvbGljeS0xLjE3LjEzL2ZpbGVfY29udGV4dHMvdHlwZXMuZmN+CTIwMDQtMDktMTAgMTA6
MTg6MDQuMDAwMDAwMDAwIC0wNDAwDQorKysgcG9saWN5LTEuMTcuMTMvZmlsZV9jb250ZXh0cy90
eXBlcy5mYwkyMDA0LTA5LTEwIDEwOjU4OjA5LjAxOTE1Nzc2OCAtMDQwMA0KQEAgLTU1LDEwICs1
NSwxNCBAQA0KIEhPTUVfRElSLy4rCQkJc3lzdGVtX3U6b2JqZWN0X3I6Uk9MRV9ob21lX3QNCiAN
CiAvcm9vdC8uZGVmYXVsdF9jb250ZXh0cwktLSAJc3lzdGVtX3U6b2JqZWN0X3I6ZGVmYXVsdF9j
b250ZXh0X3QNCisNCiAjDQotIyBBIGNvbW1vbiBtb3VudCBwb2ludA0KLS9tbnQoLy4qKT8JCS1k
CXN5c3RlbV91Om9iamVjdF9yOm1udF90DQotL21lZGlhKC8uKik/CQktZAlzeXN0ZW1fdTpvYmpl
Y3RfcjptbnRfdA0KKyMgTW91bnQgcG9pbnRzOyBkbyBub3QgcmVsYWJlbCBzdWJkaXJlY3Rvcmll
cywgc2luY2UNCisjIHdlIGRvbid0IHdhbnQgdG8gY2hhbmdlIGFueSByZW1vdmFibGUgbWVkaWEg
YnkgZGVmYXVsdC4NCisvbW50KC9bXi9dKik/CQktZAlzeXN0ZW1fdTpvYmplY3RfcjptbnRfdA0K
Ky9tbnQvW14vXSovLioJCQk8PG5vbmU+Pg0KKy9tZWRpYSgvW14vXSopPwkJLWQJc3lzdGVtX3U6
b2JqZWN0X3I6bW50X3QNCisvbWVkaWEvW14vXSovLioJCQk8PG5vbmU+Pg0KIA0KICMNCiAjIC92
YXINCg==


--=-HsSWxoB9O+9Xs8zMiJoX--

--=-mRYSxUcmbtXEuAwLXp3V
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBQcOIOIkJWWp2WGURAiF5AJ9CYF2+xc9vX2by7hV7bfeynAciYwCfctzh
wEQIQjG1Y+dwqg8Z/L1FDzI=
=tJb2
-----END PGP SIGNATURE-----

--=-mRYSxUcmbtXEuAwLXp3V--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
