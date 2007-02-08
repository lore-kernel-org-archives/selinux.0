Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l186rMAA021148
	for <selinux@tycho.nsa.gov>; Thu, 8 Feb 2007 01:53:22 -0500
Received: from msp1.hitachi-sk.co.jp (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l186sUX2023195
	for <selinux@tycho.nsa.gov>; Thu, 8 Feb 2007 06:54:30 GMT
Received: from vs2.hitachi-sk.co.jp ([133.108.252.215])
	by msp1.hitachi-sk.co.jp (unknown) with ESMTP id l186sTPB005511
	for <selinux@tycho.nsa.gov>; Thu, 8 Feb 2007 15:54:29 +0900
Date: Thu, 8 Feb 2007 15:54:38 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: busybox@busybox.net, selinux@tycho.nsa.gov
Cc: russell@coker.com.au, rob@landley.net, busybox@kaigai.gr.jp,
        vda.linux@googlemail.com, ynakam@hitachisoft.jp
Subject: [PATCH 3/6] busybox -- SELinux option support for coreutils
Message-Id: <20070208155438.6cf3ebf3.ynakam@hitachisoft.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Thu__8_Feb_2007_15_54_38_+0900_1b2ka2e1KicJI4Ip"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

--Multipart=_Thu__8_Feb_2007_15_54_38_+0900_1b2ka2e1KicJI4Ip
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

[3/6] busybox-coreutils-03-mk.patch
 - -Z option support for mkdir, mkfifo, mknod. 
    By -Z, security context for created file can be set.


Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>





--Multipart=_Thu__8_Feb_2007_15_54_38_+0900_1b2ka2e1KicJI4Ip
Content-Type: application/octet-stream;
 name="busybox-coreutils-mk-03.patch"
Content-Disposition: attachment;
 filename="busybox-coreutils-mk-03.patch"
Content-Transfer-Encoding: base64

SW5kZXg6IGNvcmV1dGlscy9ta2Rpci5jCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0tIGNvcmV1dGlscy9ta2Rpci5j
CShyZXZpc2lvbiAxNzgwMykKKysrIGNvcmV1dGlscy9ta2Rpci5jCSh3b3JraW5nIGNvcHkpCkBA
IC0xNiw2ICsxNiwxMSBAQAogICogY29uanVuY3Rpb24gd2l0aCAtbS4KICAqLwogCisvKiBOb3Yg
MjgsIDIwMDYgICAgICBZb3NoaW5vcmkgU2F0byA8eXNhdG9AdXNlcnMuc291cmNlZm9yZ2UuanA+
CisgKiAKKyAqIEFkZCAtWiAoU0VMaW51eCkgc3VwcG9ydC4KKyAqLworCiAjaW5jbHVkZSA8c3Rk
bGliLmg+CiAjaW5jbHVkZSA8dW5pc3RkLmg+CiAjaW5jbHVkZSA8Z2V0b3B0Lmg+IC8qIHN0cnVj
dCBvcHRpb24gKi8KQEAgLTI1LDYgKzMwLDkgQEAKIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb3B0aW9u
IG1rZGlyX2xvbmdfb3B0aW9uc1tdID0gewogCXsgIm1vZGUiLCAxLCBOVUxMLCAnbScgfSwKIAl7
ICJwYXJlbnRzIiwgMCwgTlVMTCwgJ3AnIH0sCisjaWYgRU5BQkxFX1NFTElOVVgKKwl7ICJjb250
ZXh0IiwgMSwgTlVMTCwgJ1onfSwKKyNlbmRpZgogCXsgMCwgMCwgMCwgMCB9CiB9OwogI2VuZGlm
CkBAIC0zNywxMSArNDUsMTQgQEAKIAlpbnQgZmxhZ3MgPSAwOwogCXVuc2lnbmVkIG9wdDsKIAlj
aGFyICpzbW9kZTsKKyNpZiBFTkFCTEVfU0VMSU5VWAorCXNlY3VyaXR5X2NvbnRleHRfdCBzY29u
dGV4dCA9IE5VTEw7CisjZW5kaWYKIAogI2lmIEVOQUJMRV9GRUFUVVJFX01LRElSX0xPTkdfT1BU
SU9OUwogCWFwcGxldF9sb25nX29wdGlvbnMgPSBta2Rpcl9sb25nX29wdGlvbnM7CiAjZW5kaWYK
LQlvcHQgPSBnZXRvcHQzMihhcmdjLCBhcmd2LCAibTpwIiwgJnNtb2RlKTsKKwlvcHQgPSBnZXRv
cHQzMihhcmdjLCBhcmd2LCAibTpwIiBVU0VfU0VMSU5VWCgiWjoiKSwgJnNtb2RlIFVTRV9TRUxJ
TlVYKCwmc2NvbnRleHQpKTsKIAlpZiAob3B0ICYgMSkgewogCQltb2RlID0gMDc3NzsKIAkJaWYg
KCFiYl9wYXJzZV9tb2RlKHNtb2RlLCAmbW9kZSkpIHsKQEAgLTUwLDYgKzYxLDE1IEBACiAJfQog
CWlmIChvcHQgJiAyKQogCQlmbGFncyB8PSBGSUxFVVRJTFNfUkVDVVI7CisjaWYgRU5BQkxFX1NF
TElOVVgKKwlpZihvcHQgJiA0KSB7CisJCXNlbGludXhfb3JfZGllKCk7CisJCWlmIChzZXRmc2Ny
ZWF0ZWNvbihzY29udGV4dCkpIHsKKwkJCWJiX2Vycm9yX21zZ19hbmRfZGllICgiU29ycnksIGNh
bm5vdCBzZXQgZGVmYXVsdCBjb250ZXh0ICIKKwkJCQkJICAgICAgInRvICVzLlxuIiwgc2NvbnRl
eHQpOworCQl9CisJfQorI2VuZGlmCiAKIAlpZiAob3B0aW5kID09IGFyZ2MpIHsKIAkJYmJfc2hv
d191c2FnZSgpOwpJbmRleDogY29yZXV0aWxzL2xpYmNvcmV1dGlscy9nZXRvcHRfbWtfZmlmb19u
b2QuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09Ci0tLSBjb3JldXRpbHMvbGliY29yZXV0aWxzL2dldG9wdF9ta19maWZv
X25vZC5jCShyZXZpc2lvbiAxNzgwMykKKysrIGNvcmV1dGlscy9saWJjb3JldXRpbHMvZ2V0b3B0
X21rX2ZpZm9fbm9kLmMJKHdvcmtpbmcgY29weSkKQEAgLTMwLDExICszMCwyNSBAQAogewogCW1v
ZGVfdCBtb2RlID0gMDY2NjsKIAljaGFyICpzbW9kZSA9IE5VTEw7Ci0KLQlnZXRvcHQzMihhcmdj
LCBhcmd2LCAibToiLCAmc21vZGUpOwotCWlmKHNtb2RlKSB7CisjaWYgRU5BQkxFX1NFTElOVVgK
KwlzZWN1cml0eV9jb250ZXh0X3Qgc2NvbnRleHQgPSBOVUxMOworI2VuZGlmCisJaW50IG9wdCA9
IDA7CisJb3B0ID0gZ2V0b3B0MzIoYXJnYywgYXJndiwgIm06IiBVU0VfU0VMSU5VWCgiWjoiKSwg
JnNtb2RlIFVTRV9TRUxJTlVYKCwmc2NvbnRleHQpKTsKKwlpZihvcHQgJiAxKSB7CiAJCWlmIChi
Yl9wYXJzZV9tb2RlKHNtb2RlLCAmbW9kZSkpCiAJCQl1bWFzaygwKTsKIAl9CisKKyNpZiBFTkFC
TEVfU0VMSU5VWAorCWlmKG9wdCAmIDIpIHsKKwkJc2VsaW51eF9vcl9kaWUoKTsKKwkJaWYgKHNl
dGZzY3JlYXRlY29uKHNjb250ZXh0KSkgeworCQkJYmJfZXJyb3JfbXNnX2FuZF9kaWUgKCJTb3Jy
eSwgY2Fubm90IHNldCBkZWZhdWx0IGNvbnRleHQiCisJCQkJCQkJCSAgInRvICVzLlxuIiwgc2Nv
bnRleHQpOworCQl9CisJfQorI2VuZGlmCisKIAlyZXR1cm4gbW9kZTsKIH0K

--Multipart=_Thu__8_Feb_2007_15_54_38_+0900_1b2ka2e1KicJI4Ip--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
