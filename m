Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l186rXCk021176
	for <selinux@tycho.nsa.gov>; Thu, 8 Feb 2007 01:53:33 -0500
Received: from msp1.hitachi-sk.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l186seX2023232
	for <selinux@tycho.nsa.gov>; Thu, 8 Feb 2007 06:54:41 GMT
Received: from vs1.hitachi-sk.co.jp ([133.108.252.215])
	by msp1.hitachi-sk.co.jp (unknown) with ESMTP id l186sdpq005565
	for <selinux@tycho.nsa.gov>; Thu, 8 Feb 2007 15:54:39 +0900
Date: Thu, 8 Feb 2007 15:54:48 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: busybox@busybox.net, selinux@tycho.nsa.gov
Cc: russell@coker.com.au, rob@landley.net, busybox@kaigai.gr.jp,
        vda.linux@googlemail.com, ynakam@hitachisoft.jp
Subject: [PATCH 5/6] busybox -- SELinux option support for coreutils
Message-Id: <20070208155448.961743fb.ynakam@hitachisoft.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Thu__8_Feb_2007_15_54_48_+0900_.5wFfmiYWdmDg8mY"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

--Multipart=_Thu__8_Feb_2007_15_54_48_+0900_.5wFfmiYWdmDg8mY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


[5/6]  busybox-coreutils-05-ls.patch
 - -Z option support for ls. Security context of file is shown by -Z option.
   In current busybox, -k/-K shows security context. However, they are replaced by -Z option in recent coreutils, so -Z have to be added by this patch.

Signed-off-by: Yuichi Nakamura <ynakam@hitachisoft.jp>




--Multipart=_Thu__8_Feb_2007_15_54_48_+0900_.5wFfmiYWdmDg8mY
Content-Type: application/octet-stream;
 name="busybox-coreutils-ls-05.patch"
Content-Disposition: attachment;
 filename="busybox-coreutils-ls-05.patch"
Content-Transfer-Encoding: base64

SW5kZXg6IGNvcmV1dGlscy9scy5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGNvcmV1dGlscy9scy5jCShyZXZp
c2lvbiAxNzgwMykKKysrIGNvcmV1dGlscy9scy5jCSh3b3JraW5nIGNvcHkpCkBAIC03MTYsNyAr
NzE2LDggQEAKIAlVU0VfRkVBVFVSRV9MU19SRUNVUlNJVkUoIlIiKQogCVVTRV9GRUFUVVJFX0hV
TUFOX1JFQURBQkxFKCJoIikKIAlVU0VfU0VMSU5VWCgiSyIpCi0JVVNFX0ZFQVRVUkVfQVVUT1dJ
RFRIKCJUOnc6Iik7CisJVVNFX0ZFQVRVUkVfQVVUT1dJRFRIKCJUOnc6IikKKyAgICBVU0VfU0VM
SU5VWCgiWiIpOwogCiBlbnVtIHsKIAlMSVNUX01BU0tfVFJJR0dFUgk9IDAsCkBAIC03NjksNiAr
NzcwLDkgQEAKICNpZiBFTkFCTEVfRkVBVFVSRV9BVVRPV0lEVEgKIAkwLCAwLCAgICAgICAgICAg
ICAgICAgICAgICAgLyogVCwgdyAtIGlnbm9yZWQgKi8KICNlbmRpZgorI2lmIEVOQUJMRV9TRUxJ
TlVYCQorCUxJU1RfTU9ERUJJVFN8TElTVF9JRF9OQU1FfExJU1RfQ09OVEVYVCwgLypaKi8KKyNl
bmRpZgogCSgxVTw8MzEpCiB9OwogCg==

--Multipart=_Thu__8_Feb_2007_15_54_48_+0900_.5wFfmiYWdmDg8mY--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
