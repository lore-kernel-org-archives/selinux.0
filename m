Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n334w2gG009334
	for <selinux@tycho.nsa.gov>; Fri, 3 Apr 2009 00:58:02 -0400
Received: from qw-out-1920.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n334w2NN009977
	for <selinux@tycho.nsa.gov>; Fri, 3 Apr 2009 04:58:02 GMT
Received: by qw-out-1920.google.com with SMTP id 5so880947qwf.30
        for <selinux@tycho.nsa.gov>; Thu, 02 Apr 2009 21:58:01 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 3 Apr 2009 13:58:01 +0900
Message-ID: <d6a0e5a20904022158w21bdf15eg31d248013c2f1c57@mail.gmail.com>
Subject: Memory leak in libselinux/src/label_file.c
From: Hiroshi Shinji <hiroshi.shinji@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary=00163646d0bea6a9cb04669f64f4
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--00163646d0bea6a9cb04669f64f4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I found memory leak in libselinux/src/label_file.c.
Please fix it.

Regards,

-- 
Hiroshi Shinji

--00163646d0bea6a9cb04669f64f4
Content-Type: text/x-diff; charset=US-ASCII; name="label_file.patch"
Content-Disposition: attachment; filename="label_file.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ft2eh9g40

ZGlmZiAtLWdpdCBhL2xpYnNlbGludXgvc3JjL2xhYmVsX2ZpbGUuYyBiL2xpYnNlbGludXgvc3Jj
L2xhYmVsX2ZpbGUuYwppbmRleCA1MDQzZjA5Li5iNWU5MDRmIDEwMDY0NAotLS0gYS9saWJzZWxp
bnV4L3NyYy9sYWJlbF9maWxlLmMKKysrIGIvbGlic2VsaW51eC9zcmMvbGFiZWxfZmlsZS5jCkBA
IC0yOTksNiArMjk5LDggQEAgc3RhdGljIGludCBwcm9jZXNzX2xpbmUoc3RydWN0IHNlbGFiZWxf
aGFuZGxlICpyZWMsCiAJCUNPTVBBVF9MT0coU0VMSU5VWF9XQVJOSU5HLAogCQkJICAgICIlczog
IGxpbmUgJWQgaXMgbWlzc2luZyBmaWVsZHMsIHNraXBwaW5nXG4iLCBwYXRoLAogCQkJICAgIGxp
bmVubyk7CisJCWlmIChpdGVtcyA9PSAxKQorCQkJZnJlZShyZWdleCk7CiAJCXJldHVybiAwOwog
CX0gZWxzZSBpZiAoaXRlbXMgPT0gMikgewogCQkvKiBUaGUgdHlwZSBmaWVsZCBpcyBvcHRpb25h
bC4gKi8K
--00163646d0bea6a9cb04669f64f4--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
