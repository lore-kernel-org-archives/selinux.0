Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9AFDAWt003956
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 11:13:10 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9AFD50p028151
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 15:13:05 GMT
Received: from smtp.olive.ocn.ne.jp (olive.ocn.ne.jp [211.6.83.149])
	by jazzswing.ncsc.mil  with ESMTP id h9AFD4r7028143
	for <selinux@tycho.nsa.gov>; Fri, 10 Oct 2003 15:13:05 GMT
Received: from 192.168.1.200 (p1066-ipad27souka.saitama.ocn.ne.jp [220.104.71.66])
	by smtp.olive.ocn.ne.jp (Postfix) with SMTP id 8EBE8304C
	for <selinux@tycho.nsa.gov>; Sat, 11 Oct 2003 00:13:05 +0900 (JST)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==_Boundary-1_=="
Date: Sat, 11 Oct 2003 00:13:04 +0900
To: selinux@tycho.nsa.gov
From: watase@olive.ocn.ne.jp (WATASE Jumpei)
Subject: patched vim
Message-Id: <20031010151305.8EBE8304C@m-kg252p.ocn.ne.jp>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--==_Boundary-1_==
Content-Type: text/plain; charset=iso-2022-jp

Attached is a small patch against vim-6.1, 
which enables vim to preserve the original context
when editing and saving an existing file.

I suppose this save the trouble to chcon when you edit
a configuration file but don't want the new context
to be inherited from the parent directory. 

I also put srpm (based on RH9 vim-6.1-29) on
http://selinux.sourceforge.jp/watase/srpms/

I will appreciate your comments or advices,
if I miss some important stuff.

--
watase

--==_Boundary-1_==
Content-Disposition: attachment
Content-Transfer-Encoding: Base64
Content-Type: application/octet-stream; name="vim-6.1-selinux.patch"

LS0tIHZpbTYxL3NyYy9NYWtlZmlsZQkyMDAyLTAzLTI0IDE5OjQxOjMwLjAwMDAwMDAwMCArMDkw
MAorKysgdmltNjEuc2VsaW51eC9zcmMvTWFrZWZpbGUJMjAwMy0xMC0wOSAxMTo1Mzo0OS4wMDAw
MDAwMDAgKzA5MDAKQEAgLTEwOTUsNiArMTA5NSwxMSBAQAogIyBVc2UgdGhpcyBmb3IgY3Byb3Rv
IDMgcGF0Y2hsZXZlbCA3IG9yIGFib3ZlICh1c2UgImNwcm90byAtViIgdG8gY2hlY2spOgogUFJP
VE9fRkxBR1MgPSAtbSAtTV9fQVJHUyAtZCAtRSIkKENQUCkiICQoTk9fQVRUUikKIAorIyBmbGFn
cyBmb3IgU0VMaW51eAorI2lmZXEgKCQoV0lUSF9TRUxJTlVYKSx5ZXMpCitDRkxBR1MgPSAtRFdJ
VEhfU0VMSU5VWAorTERGTEFHUyA9IC1sc2VsaW51eCAtbGF0dHIgCisjZW5kaWYKIAogIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjCiAjIyAgIG5vIGNoYW5n
ZXMgcmVxdWlyZWQgYmVsb3cgdGhpcyBsaW5lICAgICAgIyMKLS0tIHZpbTYxL3NyYy9maWxlaW8u
YwkyMDAyLTAzLTIwIDA2OjM0OjE3LjAwMDAwMDAwMCArMDkwMAorKysgdmltNjEuc2VsaW51eC9z
cmMvZmlsZWlvLmMJMjAwMy0xMC0wOSAxMDoyOTo0Mi4wMDAwMDAwMDAgKzA5MDAKQEAgLTIyNTYs
NiArMjI1NiwxMiBAQAogICAgIHZpbV9hY2xfVAkgICAgYWNsID0gTlVMTDsJCS8qIEFDTCBjb3Bp
ZWQgZnJvbSBvcmlnaW5hbCBmaWxlIHRvCiAJCQkJCSAgIGJhY2t1cCBvciBuZXcgZmlsZSAqLwog
I2VuZGlmCisjaWZkZWYgV0lUSF9TRUxJTlVYCisgICAgY2hhciAqc2NvbnRleHQgPSBOVUxMIDsg
CQkvKiBzZWN1cml0eSBjb250ZXh0IGNvcGllZCBmcm9tCisJCQkJCSAgIG9yaWdpbmFsIGZpbGUg
dG8gYmFja3VwIG9yIAorCQkJCQkgICBuZXcgZmlsZSAqLworICAgIGludCBpc19zZWxpbnV4X2Vu
YWJsZWRfZmxhZyA9IGlzX3NlbGludXhfZW5hYmxlZCgpOworI2VuZGlmCiAKICAgICBpZiAoZm5h
bWUgPT0gTlVMTCB8fCAqZm5hbWUgPT0gTlVMKQkvKiBzYWZldHkgY2hlY2sgKi8KIAlyZXR1cm4g
RkFJTDsKQEAgLTI2MDMsNiArMjYwOSwxNyBAQAogICAgIGlmICghbmV3ZmlsZSkKIAlhY2wgPSBt
Y2hfZ2V0X2FjbChmbmFtZSk7CiAjZW5kaWYKKyNpZmRlZiBXSVRIX1NFTElOVVgKKyAgICAvKgor
ICAgICAqIEZvciBzeXN0ZW1zIHRoYXQgc3VwcG9ydCBTRUxJTlVYOiBnZXQgdGhlIHNlY3VyaXR5
IGNvbnRleHQKKyAgICAgKiBmcm9tIHRoZSBvcmlnaW5hbCBmaWxlLgorICAgICAqLworICAgIGlm
IChpc19zZWxpbnV4X2VuYWJsZWRfZmxhZykKKyAgICB7CisJaWYgKCFuZXdmaWxlKQorCSAgICBn
ZXRmaWxlY29uKGZuYW1lLCAmc2NvbnRleHQpOworICAgIH0KKyNlbmRpZgogCiAgICAgLyoKICAg
ICAgKiBJZiAnYmFja3Vwc2tpcCcgaXMgbm90IGVtcHR5LCBkb24ndCBtYWtlIGEgYmFja3VwIGZv
ciBzb21lIGZpbGVzLgpAQCAtMjkwNCw2ICsyOTIxLDExIEBACiAjaWZkZWYgSEFWRV9BQ0wKIAkJ
CW1jaF9zZXRfYWNsKGJhY2t1cCwgYWNsKTsKICNlbmRpZgorI2lmZGVmIFdJVEhfU0VMSU5VWAor
CQkJaWYgKGlzX3NlbGludXhfZW5hYmxlZF9mbGFnKQorCQkJICAgIGlmIChzY29udGV4dCAhPSBO
VUxMKQorCQkJCXNldGZpbGVjb24oYmFja3VwLCBzY29udGV4dCk7CisjZW5kaWYKIAkJCWJyZWFr
OwogCQkgICAgfQogCQl9CkBAIC0zNDkzLDYgKzM1MTUsMTIgQEAKICAgICBpZiAoIWJhY2t1cF9j
b3B5KQogCW1jaF9zZXRfYWNsKHdmbmFtZSwgYWNsKTsKICNlbmRpZgorI2lmZGVmIFdJVEhfU0VM
SU5VWAorICAgIGlmIChpc19zZWxpbnV4X2VuYWJsZWRfZmxhZykKKwlpZiAoc2NvbnRleHQgIT0g
TlVMTCkKKwkgICAgaWYgKCFiYWNrdXBfY29weSkKKwkJc2V0ZmlsZWNvbih3Zm5hbWUsIHNjb250
ZXh0KTsKKyNlbmRpZgogCiAjaWZkZWYgVU5JWAogICAgIC8qIFdoZW4gY3JlYXRpbmcgYSBuZXcg
ZmlsZSwgc2V0IGl0cyBvd25lci9ncm91cCB0byB0aGF0IG9mIHRoZSBvcmlnaW5hbApAQCAtMzc4
Nyw2ICszODE1LDEwIEBACiAjaWZkZWYgSEFWRV9BQ0wKICAgICBtY2hfZnJlZV9hY2woYWNsKTsK
ICNlbmRpZgorI2lmZGVmIFdJVEhfU0VMSU5VWAorICAgIGlmIChpc19zZWxpbnV4X2VuYWJsZWRf
ZmxhZykKKwlmcmVlY29uKHNjb250ZXh0KTsKKyNlbmRpZgogCiAgICAgaWYgKGVycm1zZyAhPSBO
VUxMKQogICAgIHsKLS0tIHZpbTYxL3NyYy9vc191bml4LmgJMjAwMi0wMi0wNCAyMzowMzoyNy4w
MDAwMDAwMDAgKzA5MDAKKysrIHZpbTYxLnNlbGludXgvc3JjL29zX3VuaXguaAkyMDAzLTEwLTA4
IDE2OjA3OjIwLjAwMDAwMDAwMCArMDkwMApAQCAtNTI1LDMgKzUyNSw3IEBACiAKIC8qIFdlIGhh
dmUgdGhyZWUga2luZHMgb2YgQUNMIHN1cHBvcnQuICovCiAjZGVmaW5lIEhBVkVfQUNMIChIQVZF
X1BPU0lYX0FDTCB8fCBIQVZFX1NPTEFSSVNfQUNMIHx8IEhBVkVfQUlYX0FDTCkKKworI2lmZGVm
IFdJVEhfU0VMSU5VWAorIyBpbmNsdWRlIDxzZWxpbnV4L3NlbGludXguaD4KKyNlbmRpZgo=

--==_Boundary-1_==--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
