Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7421frT025179
	for <selinux@tycho.nsa.gov>; Tue, 3 Aug 2004 22:01:41 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7421dFi006667
	for <selinux@tycho.nsa.gov>; Wed, 4 Aug 2004 02:01:40 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.10/8.12.10) with ESMTP id i7421Ze1006514
	for <selinux@tycho.nsa.gov>; Tue, 3 Aug 2004 22:01:40 -0400
Subject: [patch] fix /var/run/console bits
From: Colin Walters <walters@redhat.com>
To: rcoker@redhat.com, dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-pOh3wNMAeF2e2MWshwgV"
Date: Tue, 03 Aug 2004 22:01:51 -0400
Message-Id: <1091584911.8312.7.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-pOh3wNMAeF2e2MWshwgV
Content-Type: multipart/mixed; boundary="=-CgSPv/hC7Olc9vxH/3De"


--=-CgSPv/hC7Olc9vxH/3De
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Currently /var/run/console is labeled as xdm_var_run_t, which is totally
wrong, since it's actually owned by pam_console.  I noticed this while I
was trying to work on the D-BUS policy, which recently gained console
user authentication.

Attached is a patch which creates a new type for it, grants the
requisite permissions to login and xdm.  I still think we need a nicer
way of mapping the PAM permissions in policy.  The only reason that
login and xdm are granted these permissions is because they happen to
ship with pam_console in their PAM stack on Fedora, presumably.  (IIRC
Debian doesn't use pam_console).

But this patch should work better in the short term at least; if it's
accepted I'll post a little patch to update dbusd.te too.





--=-CgSPv/hC7Olc9vxH/3De
Content-Disposition: attachment; filename=console-policy.patch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name=console-policy.patch; charset=UTF-8

LS0tIHBvbGljeS0xLjE1LjExL2ZpbGVfY29udGV4dHMvcHJvZ3JhbS9wYW0uZmN+CTIwMDQtMDct
MzEgMDY6MjI6MzcuMDAwMDAwMDAwIC0wNDAwDQorKysgcG9saWN5LTEuMTUuMTEvZmlsZV9jb250
ZXh0cy9wcm9ncmFtL3BhbS5mYwkyMDA0LTA4LTAzIDIwOjQ0OjM5LjExNzkwNTQ2NCAtMDQwMA0K
QEAgLTEsMyArMSw0IEBADQogL3Zhci9ydW4vc3VkbygvLiopPwkJCXN5c3RlbV91Om9iamVjdF9y
OnBhbV92YXJfcnVuX3QNCisvdmFyL3J1bi9jb25zb2xlLioJCQlzeXN0ZW1fdTpvYmplY3Rfcjpw
YW1fdmFyX2NvbnNvbGVfdA0KIC9zYmluL3BhbV90aW1lc3RhbXBfY2hlY2sJIC0tCXN5c3RlbV91
Om9iamVjdF9yOnBhbV9leGVjX3QNCiAvbGliKDY0KT8vc2VjdXJpdHkvcGFtX2tyYjUvcGFtX2ty
YjVfc3RvcmV0bXAgLS0gc3lzdGVtX3U6b2JqZWN0X3I6cGFtX2V4ZWNfdA0KLS0tIHBvbGljeS0x
LjE1LjExL2ZpbGVfY29udGV4dHMvcHJvZ3JhbS94ZG0uZmN+CTIwMDQtMDctMzEgMDY6MjI6Mzcu
MDAwMDAwMDAwIC0wNDAwDQorKysgcG9saWN5LTEuMTUuMTEvZmlsZV9jb250ZXh0cy9wcm9ncmFt
L3hkbS5mYwkyMDA0LTA4LTAzIDE4OjIyOjIyLjE4MTcxNzAzMiAtMDQwMA0KQEAgLTE2LDcgKzE2
LDYgQEANCiAvZXRjL1gxMS9bd3hdZG0vWHNlc3Npb24JLS0Jc3lzdGVtX3U6b2JqZWN0X3I6eHNl
c3Npb25fZXhlY190DQogL2V0Yy9rZGUva2RtL1hzZXNzaW9uCS0tCXN5c3RlbV91Om9iamVjdF9y
OnhzZXNzaW9uX2V4ZWNfdA0KIC92YXIvcnVuL3hkbWN0bCgvLiopPwkJc3lzdGVtX3U6b2JqZWN0
X3I6eGRtX3Zhcl9ydW5fdA0KLS92YXIvcnVuL2NvbnNvbGUuKgkJc3lzdGVtX3U6b2JqZWN0X3I6
eGRtX3Zhcl9ydW5fdA0KIC92YXIvbGliL1t4a3ddZG0oLy4qKT8JCXN5c3RlbV91Om9iamVjdF9y
OnhkbV92YXJfbGliX3QNCiAvdXNyL2xpYi9xdC0zLjMvZXRjL3NldHRpbmdzL3F0cmMoLy4qKT8g
c3lzdGVtX3U6b2JqZWN0X3I6eGRtX3Zhcl9saWJfdA0KIA0KLS0tIHBvbGljeS0xLjE1LjExL2Rv
bWFpbnMvcHJvZ3JhbS91bnVzZWQveGRtLnRlfgkyMDA0LTA3LTMxIDA2OjIyOjM3LjAwMDAwMDAw
MCAtMDQwMA0KKysrIHBvbGljeS0xLjE1LjExL2RvbWFpbnMvcHJvZ3JhbS91bnVzZWQveGRtLnRl
CTIwMDQtMDgtMDMgMjE6NTQ6NDIuNjUwODcxMzIwIC0wNDAwDQpAQCAtMjkxLDYgKzI5MSw5IEBA
DQogYWxsb3cgeGRtX3QgcGFtX3Zhcl9ydW5fdDpmaWxlIGNyZWF0ZV9maWxlX3Blcm1zOw0KIGFs
bG93IHBhbV90IHhkbV90OmZpZm9fZmlsZSB7IGdldGF0dHIgaW9jdGwgd3JpdGUgfTsNCiBjYW5f
ZXhlYyh4ZG1fdCwgcGFtX2V4ZWNfdCkNCisjIEZvciBwYW1fY29uc29sZQ0KK3J3X2Rpcl9jcmVh
dGVfZmlsZSh4ZG1fdCwgdmFyX3J1bl90KQ0KK3J3X2Rpcl9jcmVhdGVfZmlsZSh4ZG1fdCwgcGFt
X3Zhcl9jb25zb2xlX3QpDQogJykNCiANCiBhbGxvdyB4ZG1fdCB2YXJfbG9nX3Q6ZmlsZSB7IHJl
YWQgfTsNCi0tLSBwb2xpY3ktMS4xNS4xMS9kb21haW5zL3Byb2dyYW0vdW51c2VkL3BhbS50ZX4J
MjAwNC0wNy0zMSAwNjoyMjozNy4wMDAwMDAwMDAgLTA0MDANCisrKyBwb2xpY3ktMS4xNS4xMS9k
b21haW5zL3Byb2dyYW0vdW51c2VkL3BhbS50ZQkyMDA0LTA4LTAzIDIwOjQ0OjU0LjcwNDUzNTkz
NiAtMDQwMA0KQEAgLTEwLDYgKzEwLDggQEANCiBhbGxvdyBwYW1fdCBwYW1fdmFyX3J1bl90OmRp
ciB7IHNlYXJjaCBnZXRhdHRyIHJlYWQgd3JpdGUgcmVtb3ZlX25hbWUgfTsNCiBhbGxvdyBwYW1f
dCBwYW1fdmFyX3J1bl90OmZpbGUgeyBnZXRhdHRyIHJlYWQgdW5saW5rIH07DQogDQordHlwZSBw
YW1fdmFyX2NvbnNvbGVfdCwgZmlsZV90eXBlLCBzeXNhZG1maWxlOw0KKw0KIHJvbGUgc3lzdGVt
X3IgdHlwZXMgcGFtX3Q7DQogaW5fdXNlcl9yb2xlKHBhbV90KQ0KIGRvbWFpbl9hdXRvX3RyYW5z
KHVzZXJkb21haW4sIHBhbV9leGVjX3QsIHBhbV90KQ0KLS0tIHBvbGljeS0xLjE1LjExL2RvbWFp
bnMvcHJvZ3JhbS9sb2dpbi50ZX4JMjAwNC0wNy0zMSAwNjoyMjozNi4wMDAwMDAwMDAgLTA0MDAN
CisrKyBwb2xpY3ktMS4xNS4xMS9kb21haW5zL3Byb2dyYW0vbG9naW4udGUJMjAwNC0wOC0wMyAy
MTo1NDoyNi40MTkzMzg4ODggLTA0MDANCkBAIC02Miw2ICs2Miw5IEBADQogDQogaWZkZWYoYHBh
bS50ZScsIGANCiBjYW5fZXhlYygkMV9sb2dpbl90LCBwYW1fZXhlY190KQ0KKyMgRm9yIHBhbV9j
b25zb2xlDQorcndfZGlyX2NyZWF0ZV9maWxlKCQxX2xvZ2luX3QsIHZhcl9ydW5fdCkNCityd19k
aXJfY3JlYXRlX2ZpbGUoJDFfbG9naW5fdCwgcGFtX3Zhcl9jb25zb2xlX3QpDQogJykNCiANCiAj
IFVzZSBjYXBhYmlsaXRpZXMNCkBAIC04MSwxMSArODQsOCBAQA0KIHJfZGlyX2ZpbGUoJDFfbG9n
aW5fdCwgbmZzX3QpDQogJylkbmwgZW5kIGlmIG5mc19ob21lX2RpcnMNCiANCi0jDQotIyAvdmFy
L3J1bi9jb25zb2xlIHJlcXVpcmVzIHRoZSBmb2xsb3dpbmcNCi0jDQorIyBGSVhNRTogd2hhdCBp
cyB0aGlzIGZvcj8NCiBpZmRlZihgeGRtLnRlJywgYA0KLWNyZWF0ZV9kaXJfZmlsZSgkMV9sb2dp
bl90LCB4ZG1fdmFyX3J1bl90KQ0KIGFsbG93IHhkbV90ICQxX2xvZ2luX3Q6cHJvY2VzcyB7IHNp
Z251bGwgfTsNCiAnKQ0KIA0KQEAgLTE4NCwxMCArMTg0LDYgQEANCiAjIEFsbG93IHNldHRpbmcg
b2YgYXR0cmlidXRlcyBvbiBzb3VuZCBkZXZpY2VzLg0KIGFsbG93IGxvY2FsX2xvZ2luX3Qgc291
bmRfZGV2aWNlX3Q6Y2hyX2ZpbGUgeyBnZXRhdHRyIHNldGF0dHIgfTsNCiANCi0jIEFsbG93IGFj
Y2VzcyB0byAvdmFyL3J1bi9jb25zb2xlIGFuZCAvdmFyL3J1bi9jb25zb2xlLmxvY2suICBOZWVk
IGEgc2VwYXJhdGUgdHlwZT8NCi1hbGxvdyBsb2NhbF9sb2dpbl90IHZhcl9ydW5fdDpkaXIgcndf
ZGlyX3Blcm1zOw0KLWFsbG93IGxvY2FsX2xvZ2luX3QgdmFyX3J1bl90OmZpbGUgY3JlYXRlX2Zp
bGVfcGVybXM7DQotDQogIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjDQogIw0KICMg
UnVsZXMgZm9yIHRoZSByZW1vdGVfbG9naW5fdCBkb21haW4uDQo=


--=-CgSPv/hC7Olc9vxH/3De--

--=-pOh3wNMAeF2e2MWshwgV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBEEOPOIkJWWp2WGURAvLXAJ9RM9C0GBx9je3b/43ZXeEY9FIz6QCeIMCg
vlMMrI92OkwKEH0wmhqKbg0=
=Omy/
-----END PGP SIGNATURE-----

--=-pOh3wNMAeF2e2MWshwgV--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
