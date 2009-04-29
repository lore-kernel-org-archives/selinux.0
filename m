Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3T5Hjiw026178
	for <selinux@tycho.nsa.gov>; Wed, 29 Apr 2009 01:17:45 -0400
Received: from mail-gx0-f159.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3T5HhiT016039
	for <selinux@tycho.nsa.gov>; Wed, 29 Apr 2009 05:17:44 GMT
Received: by gxk3 with SMTP id 3so2012368gxk.18
        for <selinux@tycho.nsa.gov>; Tue, 28 Apr 2009 22:17:42 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 28 Apr 2009 22:17:42 -0700
Message-ID: <dd18b0c30904282217y10fc6c6coe115e83e89ce1536@mail.gmail.com>
Subject: load_policy.c:351:1: error: "MNT_DETACH" redefined
From: Justin Mattock <justinmattock@gmail.com>
To: SE-Linux <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary=001e680f13e8ee12420468aab242
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--001e680f13e8ee12420468aab242
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

I get an error while compiling libselinux
with a simple "make"

load_policy.c:351:1: error: "MNT_DETACH" redefined
In file included from load_policy.c:5:
/usr/include/sys/mount.h:102:1: error: this is the location of the
previous definition
make[1]: *** [load_policy.o] Error 1
make[1]: Leaving directory `/home/name/LFS/SELinux/libselinux-2.0.79/src'
make: *** [all] Error 2

but if I:
make CC="/usr/bin/i686-pc-linux-gnu-gcc-4.4.0" CFLAGS="-march=core2
-mtune=core2 -pipe -O2 -fomit-frame-pointer" CXXFLAGS="${CFLAGS}"
MAKEOPTS="{-j3}"
libselinux will compiled with just a:

load_policy.c:351:1: warning: "MNT_DETACH" redefined
In file included from load_policy.c:5:
/usr/include/sys/mount.h:102:1: warning: this is the location of the
previous definition


if I change load_policy.c(to the best of my knowledge)
with the attached patch
and then run make normally
libselinux will compile

-- 
Justin P. Mattock

--001e680f13e8ee12420468aab242
Content-Type: application/octet-stream; name="MNT_DETACH.patch"
Content-Disposition: attachment; filename="MNT_DETACH.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fu3ks2kx0

bGlic2VsaW51eCBjb21waWxlcyB3aXRoIENDRkxBR1Mgc2V0LCBidXQgYSBub3JtYWwKIm1ha2Ui
IHJlc3VsdHMgaW46Cgpsb2FkX3BvbGljeS5jOjM1MToxOiBlcnJvcjogIk1OVF9ERVRBQ0giIHJl
ZGVmaW5lZApJbiBmaWxlIGluY2x1ZGVkIGZyb20gbG9hZF9wb2xpY3kuYzo1OgovdXNyL2luY2x1
ZGUvc3lzL21vdW50Lmg6MTAyOjE6IGVycm9yOiB0aGlzIGlzIHRoZSBsb2NhdGlvbiBvZiB0aGUg
cHJldmlvdXMgZGVmaW5pdGlvbgptYWtlWzFdOiAqKiogW2xvYWRfcG9saWN5Lm9dIEVycm9yIDEK
bWFrZVsxXTogTGVhdmluZyBkaXJlY3RvcnkgYC9ob21lL25hbWUvTEZTL1NFTGludXgvbGlic2Vs
aW51eC0yLjAuNzkvc3JjJwptYWtlOiAqKiogW2FsbF0gRXJyb3IgMgoKClNpZ25lZC1vZmYtYnk6
IEp1c3RpbiBQLiBNYXR0b2NrIDxqdXN0aW5tYXR0b2NrQGdtYWlsLmNvbT4KICAgIAotLS0gbG9h
ZF9wb2xpY3kuYyAgICAgICAyMDA5LTA0LTI4IDIyOjA0OjQwLjAwMDAwMDAwMCAtMDcwMAorKysg
bG9hZF9wb2xpY3kuYyAgICAgICAyMDA5LTA0LTI4IDIyOjA5OjAyLjAwMDAwMDAwMCAtMDcwMApA
QCAtMzQ4LDcgKzM0OCw3IEBACiAgICAgICAgICAgICAgICBmY2xvc2UoY2ZnKTsKICAgICAgICAg
ICAgICAgIGZyZWUoYnVmKTsKICAgICAgICB9Ci0jZGVmaW5lIE1OVF9ERVRBQ0ggMgorI2RlZmlu
ZSBNTlRfREVUQUNIIE1OVF9ERVRBQ0gKICAgICAgICBpZiAocmMgPT0gMCkKICAgICAgICAgICAg
ICAgIHVtb3VudDIoIi9wcm9jIiwgTU5UX0RFVEFDSCk7CiAKCg==
--001e680f13e8ee12420468aab242--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
