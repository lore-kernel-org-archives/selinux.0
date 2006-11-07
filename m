From: James Antill <jantill@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: redhat-lspp <redhat-lspp@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-UMmgEtK0/nX4kAsN3N8e"
Date: Tue, 07 Nov 2006 16:57:56 -0500
Message-Id: <1162936676.26574.15.camel@code.and.org>
Mime-Version: 1.0
Subject: [PATCH] libselinux MLS range context contains for PAM/cron
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-UMmgEtK0/nX4kAsN3N8e
Content-Type: multipart/mixed; boundary="=-nvlvwZu8KGPw3rJxVmFI"


--=-nvlvwZu8KGPw3rJxVmFI
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


 Here is the libselinux changes needed to do the security context
contains checks for PAM and cron.

--=20
James Antill <jantill@redhat.com>

--=-nvlvwZu8KGPw3rJxVmFI
Content-Description: libselinux MLS range checking bits, for cron and PAM
Content-Disposition: inline; filename=selinux-range-checking.patch
Content-Type: text/x-patch; charset=UTF-8
Content-Transfer-Encoding: base64

SW5kZXg6IGxpYnNlbGludXgvaW5jbHVkZS9zZWxpbnV4L2F2X3Blcm1pc3Npb25zLmgNCj09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0NCi0tLSBsaWJzZWxpbnV4L2luY2x1ZGUvc2VsaW51eC9hdl9wZXJtaXNzaW9ucy5oCShy
ZXZpc2lvbiAyMDc2KQ0KKysrIGxpYnNlbGludXgvaW5jbHVkZS9zZWxpbnV4L2F2X3Blcm1pc3Np
b25zLmgJKHdvcmtpbmcgY29weSkNCkBAIC04OTYsMyArODk2LDQgQEANCiAjZGVmaW5lIEtFWV9f
U0VUQVRUUiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4MDAwMDAwMjBVTA0KICNkZWZp
bmUgS0VZX19DUkVBVEUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgwMDAwMDA0MFVM
DQogI2RlZmluZSBDT05URVhUX19UUkFOU0xBVEUgICAgICAgICAgICAgICAgICAgICAgICAweDAw
MDAwMDAxVUwNCisjZGVmaW5lIENPTlRFWFRfX0NPTlRBSU5TICAgICAgICAgICAgICAgICAgICAg
ICAgIDB4MDAwMDAwMDJVTA0KSW5kZXg6IGxpYnNlbGludXgvc3JjL2F2X3Blcm1fdG9fc3RyaW5n
LmgNCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT0NCi0tLSBsaWJzZWxpbnV4L3NyYy9hdl9wZXJtX3RvX3N0cmluZy5oCShy
ZXZpc2lvbiAyMDc2KQ0KKysrIGxpYnNlbGludXgvc3JjL2F2X3Blcm1fdG9fc3RyaW5nLmgJKHdv
cmtpbmcgY29weSkNCkBAIC0yNjYsMyArMjY2LDQgQEANCiAgICAgU18oU0VDQ0xBU1NfS0VZLCBL
RVlfX1NFVEFUVFIsICJzZXRhdHRyIikNCiAgICAgU18oU0VDQ0xBU1NfS0VZLCBLRVlfX0NSRUFU
RSwgImNyZWF0ZSIpDQogICAgIFNfKFNFQ0NMQVNTX0NPTlRFWFQsIENPTlRFWFRfX1RSQU5TTEFU
RSwgInRyYW5zbGF0ZSIpDQorICAgIFNfKFNFQ0NMQVNTX0NPTlRFWFQsIENPTlRFWFRfX0NPTlRB
SU5TLCAiY29udGFpbnMiKQ0K


--=-nvlvwZu8KGPw3rJxVmFI--

--=-UMmgEtK0/nX4kAsN3N8e
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFUQFk11eXTEMrxtQRArwjAKC5EPUmiI2A7K4NVOCWTMczEPsxXwCglsCh
a2gedG3f6cHeOMCfhAdhuNY=
=FV5q
-----END PGP SIGNATURE-----

--=-UMmgEtK0/nX4kAsN3N8e--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
