Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8QJfbZN021254
	for <selinux@tycho.nsa.gov>; Fri, 26 Sep 2008 15:41:37 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m8QJfb33018797
	for <selinux@tycho.nsa.gov>; Fri, 26 Sep 2008 19:41:37 GMT
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C9200F.E3AA7A5F"
Subject: [autotools][patch] libsepol build system comments
Date: Fri, 26 Sep 2008 15:41:37 -0400
Message-ID: <06A6610D4F464D4EBEAFBF2C5F86911E669853@exchange2.columbia.tresys.com>
From: "Jason Tang" <jtang@tresys.com>
To: <selinux@tycho.nsa.gov>
Cc: <noel.ambrose@gmail.com>, "Joshua Brindle" <jbrindle@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9200F.E3AA7A5F
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Josh asked me to look through the autotools work.  Here are the issues I =
have found with the libsepol package:

1. In configure.ac, the AC_INIT macro is not filled out;

2. Within libsepol/src/Makefile.am, the internal header files are not =
assigned to COMMONSRC;

3. Within utils/Makefile.am, the builddir for utils is not necessarily =
sibling to src;

4. libsepol is being installed to $(LIBDIR).  In this case, it should =
default to the system library.

5. Most importantly, the unit tests are not built nor run.


I resolved the first three issues with the patch below.  After applying =
the changes, 'make distcheck' succeeded for me.  For the fourth issue, =
consider adding to configure.ac an AC_ARG_WITH, "--with-libsepol-dir", =
that sets the location to install libsepol.so.  This would default to =
/lib or /lib64, depending upon the target architecture.  For the fifth =
issue, the enable_tests variable ought to default to yes, and then =
conditional compiliation be used to actually compile and run those =
tests.

--=20
Jason Tang / jtang@tresys.com






------_=_NextPart_001_01C9200F.E3AA7A5F
Content-Type: text/x-patch;
	name="libsepol-autotools.patch"
Content-Transfer-Encoding: base64
Content-Description: libsepol-autotools.patch
Content-Disposition: attachment;
	filename="libsepol-autotools.patch"

ZGlmZiAtLWdpdCBhL2xpYnNlcG9sL2NvbmZpZ3VyZS5hYyBiL2xpYnNlcG9sL2NvbmZpZ3VyZS5h
YwppbmRleCA2Njc4Zjc3Li4wYTBhN2Y4IDEwMDY0NAotLS0gYS9saWJzZXBvbC9jb25maWd1cmUu
YWMKKysrIGIvbGlic2Vwb2wvY29uZmlndXJlLmFjCkBAIC0yLDcgKzIsNyBAQAogIyBQcm9jZXNz
IHRoaXMgZmlsZSB3aXRoIGF1dG9jb25mIHRvIHByb2R1Y2UgYSBjb25maWd1cmUgc2NyaXB0Lgog
CiBBQ19QUkVSRVEoMi42MSkKLUFDX0lOSVQoW2xpYnNlcG9sXSwgWzFdIEJVRy1SRVBPUlQtQURE
UkVTUykKK0FDX0lOSVQoW2xpYnNlcG9sXSwgMi4wLjMyLCBzZWxpbnV4QHR5Y2hvLm5zYS5nb3Yp
CiBBTV9JTklUX0FVVE9NQUtFCiBBQ19DT05GSUdfU1JDRElSKFt1dGlscy9jaGtjb24uY10pCiBB
Q19DT05GSUdfSEVBREVSKFtjb25maWcuaF0pCmRpZmYgLS1naXQgYS9saWJzZXBvbC9zcmMvTWFr
ZWZpbGUuYW0gYi9saWJzZXBvbC9zcmMvTWFrZWZpbGUuYW0KaW5kZXggMzQ4YTQ2NS4uNTVjOGQ4
ZSAxMDA2NDQKLS0tIGEvbGlic2Vwb2wvc3JjL01ha2VmaWxlLmFtCisrKyBiL2xpYnNlcG9sL3Ny
Yy9NYWtlZmlsZS5hbQpAQCAtNiw3ICs2LDIyIEBAIENPTU1PTlNSQwkJPSBhc3NlcnRpb24uYyBj
b25kaXRpb25hbC5jIGViaXRtYXAuYyBoYXNodGFiLmMgXAogCQkJbm9kZV9yZWNvcmQuYyAgcG9s
aWN5ZGJfcHVibGljLmMgc2lkdGFiLmMgd3JpdGUuYyBcCiAJCQlib29sZWFuX3JlY29yZC5jIGNv
bnRleHRfcmVjb3JkLmMgZ2VudXNlcnMuYyBpbnRlcmZhY2VzLmMgXAogCQkJbm9kZXMuYyBwb3J0
X3JlY29yZC5jIHN5bXRhYi5jIGJvb2xlYW5zLmMgXAotCQkJZGVidWcuYyBoYW5kbGUuYyBsaW5r
LmMgcG9sY2Fwcy5jIHBvcnRzLmMgdXNlcl9yZWNvcmQuYworCQkJZGVidWcuYyBoYW5kbGUuYyBs
aW5rLmMgcG9sY2Fwcy5jIHBvcnRzLmMgdXNlcl9yZWNvcmQuYyBcCisJYXZfcGVybWlzc2lvbnMu
aCBcCisJYm9vbGVhbl9pbnRlcm5hbC5oIFwKKwljb250ZXh0LmggXAorCWNvbnRleHRfaW50ZXJu
YWwuaCBcCisJZGVidWcuaCBcCisJZHNvLmggXAorCWhhbmRsZS5oIFwKKwlpZmFjZV9pbnRlcm5h
bC5oIFwKKwltbHMuaCBcCisJbW9kdWxlX2ludGVybmFsLmggXAorCW5vZGVfaW50ZXJuYWwuaCBc
CisJcG9saWN5ZGJfaW50ZXJuYWwuaCBcCisJcG9ydF9pbnRlcm5hbC5oIFwKKwlwcml2YXRlLmgg
XAorCXVzZXJfaW50ZXJuYWwuaAogbGliX0xUTElCUkFSSUVTCQk9IGxpYnNlcG9sLmxhCiBsaWJz
ZXBvbF9sYV9TT1VSQ0VTCT0gJChDT01NT05TUkMpCiBsaWJzZXBvbF9sYV9DUFBGTEFHUwk9IFwK
ZGlmZiAtLWdpdCBhL2xpYnNlcG9sL3V0aWxzL01ha2VmaWxlLmFtIGIvbGlic2Vwb2wvdXRpbHMv
TWFrZWZpbGUuYW0KaW5kZXggMGM0MWFlYy4uZmU4ODdkYSAxMDA2NDQKLS0tIGEvbGlic2Vwb2wv
dXRpbHMvTWFrZWZpbGUuYW0KKysrIGIvbGlic2Vwb2wvdXRpbHMvTWFrZWZpbGUuYW0KQEAgLTIs
NSArMiw1IEBAIGJpbl9QUk9HUkFNUwk9IGNoa2NvbgogQU1fTERGTEFHUwk9IC1XbCwtLWFzLW5l
ZWRlZAogQU1fQ1BQRkxBR1MJPSAtSSQoYWJzX3RvcF9zcmNkaXIpL2luY2x1ZGUKIGNoa2Nvbl9T
T1VSQ0VTCT0gY2hrY29uLmMKLWNoa2Nvbl9ERVBFTkRFTkNJRVMJPSAkKGJ1aWxkZGlyKS8uLi9z
cmMvbGlic2Vwb2wubGEKLWNoa2Nvbl9MREZMQUdTCT0gLWxzZXBvbCAtTCQoYnVpbGRkaXIpLy4u
L3NyYworY2hrY29uX0RFUEVOREVOQ0lFUwk9ICQodG9wX2J1aWxkZGlyKS9zcmMvbGlic2Vwb2wu
bGEKK2Noa2Nvbl9MREZMQUdTCT0gLWxzZXBvbCAtTCQodG9wX2J1aWxkZGlyKS9zcmMK

------_=_NextPart_001_01C9200F.E3AA7A5F--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
