Message-Id: <200209291121.LAA25284@jazzband.ncsc.mil>
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: $1_cupsd_spool_t in lpr_macros.te
Date: Sun, 29 Sep 2002 12:29:52 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_ST374DSIL7FVO4E9B5NP"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_ST374DSIL7FVO4E9B5NP
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: 

Hi,

the attached patch add cups support in lpr_domain. You can pipe some data=
=20
to lpr with this additional rules.

Carsten
--------------Boundary-00=_ST374DSIL7FVO4E9B5NP
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch.cups"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch.cups"

SW5kZXg6IGxwcl9tYWNyb3MudGUKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2c3Jvb3Qvc2VsaW51
eC9uc2Evc2VsaW51eC9wb2xpY3kvbWFjcm9zL3Byb2dyYW0vbHByX21hY3Jvcy50ZSx2CnJldHJp
ZXZpbmcgcmV2aXNpb24gMS4xLjEuMwpkaWZmIC11IC1yMS4xLjEuMyBscHJfbWFjcm9zLnRlCi0t
LSBscHJfbWFjcm9zLnRlCTIzIEF1ZyAyMDAyIDE4OjQ0OjIwIC0wMDAwCTEuMS4xLjMKKysrIGxw
cl9tYWNyb3MudGUJMjkgU2VwIDIwMDIgMTA6MjI6MTggLTAwMDAKQEAgLTQ1LDYgKzQ1LDExIEBA
CiAjIFVzZSB0aGlzIHR5cGUgd2hlbiBjcmVhdGluZyBmaWxlcyBpbiAvdmFyL3Nwb29sL2xwZC4K
IGZpbGVfdHlwZV9hdXRvX3RyYW5zKCQxX2xwcl90LCBscGRfc3Bvb2xfdCwgJDFfbHBkX3Nwb29s
X3QpCiAKK2lmZGVmKGBjdXBzLnRlJyxgCit0eXBlICQxX2N1cHNkX3Nwb29sX3QsIGZpbGVfdHlw
ZSwgc3lzYWRtZmlsZTsKK2ZpbGVfdHlwZV9hdXRvX3RyYW5zKCQxX2xwcl90LCBjdXBzZF9zcG9v
bF90LCAkMV9jdXBzZF9zcG9vbF90KQorJykKKwogIyBVc2UgdGhlIG5ldHdvcmsuCiBjYW5fbmV0
d29yaygkMV9scHJfdCkKIAo=

--------------Boundary-00=_ST374DSIL7FVO4E9B5NP--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
