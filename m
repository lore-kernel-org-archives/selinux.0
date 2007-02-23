Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1N8kg9w001501
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 03:46:42 -0500
Received: from msp1.hitachi-sk.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1N8m0KK021872
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 08:48:00 GMT
Received: from vs2.hitachi-sk.co.jp ([133.108.252.215])
	by msp1.hitachi-sk.co.jp (unknown) with ESMTP id l1N8lxGM032470
	for <selinux@tycho.nsa.gov>; Fri, 23 Feb 2007 17:47:59 +0900
Date: Fri, 23 Feb 2007 17:48:07 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: busybox@busybox.net
Cc: busybox@kaigai.gr.jp, vda.linux@googlemail.com, selinux@tycho.nsa.gov
Subject: [PATCH 5/8] busybox -- SELinux option support for coreutils: ver3
Message-Id: <20070223174807.ef262eb5.ynakam@hitachisoft.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Fri__23_Feb_2007_17_48_07_+0900_Wvk2==gTmJUSePIq"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

--Multipart=_Fri__23_Feb_2007_17_48_07_+0900_Wvk2==gTmJUSePIq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

[5/8]  busybox-coreutils-05-ls.v3.patch
 - -Z option support for ls. Security context of file is shown by -Z option.
   In current busybox, -k/-K shows security context. However, they are replaced by -Z option in recent coreutils, so -Z have to be added by this patch.

Signed-off-by:  Yuichi Nakamura <ynakam@hitachisoft.jp>





--Multipart=_Fri__23_Feb_2007_17_48_07_+0900_Wvk2==gTmJUSePIq
Content-Type: application/octet-stream;
 name="busybox-coreutils-ls-05.v3.patch"
Content-Disposition: attachment;
 filename="busybox-coreutils-ls-05.v3.patch"
Content-Transfer-Encoding: base64

SW5kZXg6IGNvcmV1dGlscy9scy5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGNvcmV1dGlscy9scy5jCShyZXZp
c2lvbiAxNzk2MSkKKysrIGNvcmV1dGlscy9scy5jCSh3b3JraW5nIGNvcHkpCkBAIC03MTYsNyAr
NzE2LDggQEAKIAlVU0VfRkVBVFVSRV9MU19SRUNVUlNJVkUoIlIiKQogCVVTRV9GRUFUVVJFX0hV
TUFOX1JFQURBQkxFKCJoIikKIAlVU0VfU0VMSU5VWCgiSyIpCi0JVVNFX0ZFQVRVUkVfQVVUT1dJ
RFRIKCJUOnc6Iik7CisJVVNFX0ZFQVRVUkVfQVVUT1dJRFRIKCJUOnc6IikKKyAgICBVU0VfU0VM
SU5VWCgiWiIpOwogCiBlbnVtIHsKIAlMSVNUX01BU0tfVFJJR0dFUgk9IDAsCkBAIC03NjksNiAr
NzcwLDkgQEAKICNpZiBFTkFCTEVfRkVBVFVSRV9BVVRPV0lEVEgKIAkwLCAwLCAgICAgICAgICAg
ICAgICAgICAgICAgLyogVCwgdyAtIGlnbm9yZWQgKi8KICNlbmRpZgorI2lmIEVOQUJMRV9TRUxJ
TlVYCQorCUxJU1RfTU9ERUJJVFN8TElTVF9JRF9OQU1FfExJU1RfQ09OVEVYVCwgLypaKi8KKyNl
bmRpZgogCSgxVTw8MzEpCiB9OwogCg==

--Multipart=_Fri__23_Feb_2007_17_48_07_+0900_Wvk2==gTmJUSePIq--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
