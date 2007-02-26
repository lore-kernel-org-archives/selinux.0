Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1Q1qfTY002292
	for <selinux@tycho.nsa.gov>; Sun, 25 Feb 2007 20:52:41 -0500
Received: from msp1.hitachi-sk.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1Q1s1Fa026422
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 01:54:01 GMT
Received: from vs1.hitachi-sk.co.jp ([133.108.252.215])
	by msp1.hitachi-sk.co.jp (unknown) with ESMTP id l1Q1s0fF016896
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 10:54:00 +0900
Date: Mon, 26 Feb 2007 10:54:09 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: Denis Vlasenko <vda.linux@googlemail.com>
Cc: ynakam@hitachisoft.jp, busybox@busybox.net, busybox@kaigai.gr.jp,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 5/8] busybox -- SELinux option support for coreutils:
 ver3
Message-Id: <20070226105409.3a228ff6.ynakam@hitachisoft.jp>
In-Reply-To: <200702241601.11806.vda.linux@googlemail.com>
References: <20070223174807.ef262eb5.ynakam@hitachisoft.jp>
	<200702241601.11806.vda.linux@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Mon__26_Feb_2007_10_54_09_+0900_wL6cf=TD+czuTiMo"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

--Multipart=_Mon__26_Feb_2007_10_54_09_+0900_wL6cf=TD+czuTiMo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Feb 2007 16:01:11 +0100
Denis Vlasenko  wrote:
> On Friday 23 February 2007 09:48, Yuichi Nakamura wrote:
> > [5/8]  busybox-coreutils-05-ls.v3.patch
> >  - -Z option support for ls. Security context of file is shown by -Z option.
> >    In current busybox, -k/-K shows security context. However, they are replaced by -Z option in recent coreutils, so -Z have to be added by this patch.
> > 
> > Signed-off-by:  Yuichi Nakamura <ynakam@hitachisoft.jp>
> 
> +       USE_FEATURE_AUTOWIDTH("T:w:")
> +    USE_SELINUX("Z");
> 
> Use tab here instead of four spaces.
Fixed.

> --
> vda

Attached is revised patch(v4).

-- 
Yuichi Nakamura
Hitachi Software Engineering Co., Ltd.
SELinux Policy Editor: http://seedit.sourceforge.net/


--Multipart=_Mon__26_Feb_2007_10_54_09_+0900_wL6cf=TD+czuTiMo
Content-Type: application/octet-stream;
 name="busybox-coreutils-ls-05.v4.patch"
Content-Disposition: attachment;
 filename="busybox-coreutils-ls-05.v4.patch"
Content-Transfer-Encoding: base64

SW5kZXg6IGNvcmV1dGlscy9scy5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGNvcmV1dGlscy9scy5jCShyZXZp
c2lvbiAxNzk2MSkKKysrIGNvcmV1dGlscy9scy5jCSh3b3JraW5nIGNvcHkpCkBAIC03MTYsNyAr
NzE2LDggQEAKIAlVU0VfRkVBVFVSRV9MU19SRUNVUlNJVkUoIlIiKQogCVVTRV9GRUFUVVJFX0hV
TUFOX1JFQURBQkxFKCJoIikKIAlVU0VfU0VMSU5VWCgiSyIpCi0JVVNFX0ZFQVRVUkVfQVVUT1dJ
RFRIKCJUOnc6Iik7CisJVVNFX0ZFQVRVUkVfQVVUT1dJRFRIKCJUOnc6IikKKwlVU0VfU0VMSU5V
WCgiWiIpOwogCiBlbnVtIHsKIAlMSVNUX01BU0tfVFJJR0dFUgk9IDAsCkBAIC03NjksNiArNzcw
LDkgQEAKICNpZiBFTkFCTEVfRkVBVFVSRV9BVVRPV0lEVEgKIAkwLCAwLCAgICAgICAgICAgICAg
ICAgICAgICAgLyogVCwgdyAtIGlnbm9yZWQgKi8KICNlbmRpZgorI2lmIEVOQUJMRV9TRUxJTlVY
CQorCUxJU1RfTU9ERUJJVFN8TElTVF9JRF9OQU1FfExJU1RfQ09OVEVYVCwgLypaKi8KKyNlbmRp
ZgogCSgxVTw8MzEpCiB9OwogCg==

--Multipart=_Mon__26_Feb_2007_10_54_09_+0900_wL6cf=TD+czuTiMo--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
