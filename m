Message-Id: <200302151600.QAA01090@jazzswing.ncsc.mil>
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: SELinux <SELinux@tycho.nsa.gov>
Subject: patch makefiles
Date: Sat, 15 Feb 2003 16:32:34 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_AIWCAH4TPFR92WIFG3VT"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_AIWCAH4TPFR92WIFG3VT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,=20

I start to build new rpms for SuSE this days. Thru this, I found two litt=
le=20
"problems" with non existent man page directories, if anybody don't use t=
he
install sequence from the readme file. The attached patch fix the problem=
=2E

Carsten


--------------Boundary-00=_AIWCAH4TPFR92WIFG3VT
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="makefiles.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="makefiles.diff"

SW5kZXg6IHNldGZpbGVzL01ha2VmaWxlCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNTIGZpbGU6IC9jdnNyb290L3Nl
bGludXgvbnNhL3NlbGludXgvc2V0ZmlsZXMvTWFrZWZpbGUsdgpyZXRyaWV2aW5nIHJldmlzaW9u
IDEuMgpkaWZmIC11IC1yMS4yIE1ha2VmaWxlCi0tLSBzZXRmaWxlcy9NYWtlZmlsZQkxNiBBdWcg
MjAwMiAxNDoyNzozNSAtMDAwMAkxLjIKKysrIHNldGZpbGVzL01ha2VmaWxlCTE0IEZlYiAyMDAz
IDE4OjIxOjE3IC0wMDAwCkBAIC05LDYgKzksNyBAQAogCSQoQ0MpICQoTERGTEFHUykgLW8gJEAg
JF4gJChMRExJQlMpCiAKIGluc3RhbGw6IHNldGZpbGVzCisJWyAtZCAkKE1BTkRJUikvbWFuOCBd
IHx8IG1rZGlyIC1wICQoTUFORElSKS9tYW44CiAJaW5zdGFsbCAtbSA3NTUgc2V0ZmlsZXMgJChC
SU5ESVIpCiAJaW5zdGFsbCAtbSA2NDQgLW8gcm9vdCAtZyByb290IHNldGZpbGVzLjggJChNQU5E
SVIpL21hbjgKIApJbmRleDogdXRpbHMvcnVuX2luaXQvTWFrZWZpbGUKPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1Mg
ZmlsZTogL2N2c3Jvb3Qvc2VsaW51eC9uc2Evc2VsaW51eC91dGlscy9ydW5faW5pdC9NYWtlZmls
ZSx2CnJldHJpZXZpbmcgcmV2aXNpb24gMS4zCmRpZmYgLXUgLXIxLjMgTWFrZWZpbGUKLS0tIHV0
aWxzL3J1bl9pbml0L01ha2VmaWxlCTMgRGVjIDIwMDIgMTQ6Mzk6MDYgLTAwMDAJMS4zCisrKyB1
dGlscy9ydW5faW5pdC9NYWtlZmlsZQkxNCBGZWIgMjAwMyAxODoyMToxNyAtMDAwMApAQCAtNDIs
NiArNDIsOCBAQAogCSQoQ0MpICQoTERGTEFHUykgJChDRkxBR1MpIC1vIHJ1bl9pbml0IHJ1bl9p
bml0LmMgJChMSUJGTEFHUykKIAogaW5zdGFsbCA6IGFsbAorCVsgLWQgJChERVNURElSKSBdIHx8
IG1rZGlyIC1wICQoREVTVERJUikKKwlbIC1kICQoTUFORElSKS9tYW44IF0gfHwgbWtkaXIgLXAg
JChNQU5ESVIpL21hbjgKIAlpbnN0YWxsIC1tIDU1NSAtbyByb290IC1nIHJvb3QgJChQUk9HUykg
JChERVNURElSKQogCWluc3RhbGwgLW0gNjQ0IC1vIHJvb3QgLWcgcm9vdCBydW5faW5pdC44ICQo
TUFORElSKS9tYW44LwogCWlmIFsgLWQgL2V0Yy9wYW0uZCBdOyB0aGVuIFwK

--------------Boundary-00=_AIWCAH4TPFR92WIFG3VT--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
