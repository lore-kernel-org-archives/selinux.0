Message-ID: <4889CF4C.7090401@ak.jp.nec.com>
Date: Fri, 25 Jul 2008 22:04:12 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: jmorris@namei.org, paul.moore@hp.com, jbrindle@tresys.com,
        selinux@tycho.nsa.gov
Subject: [PATCH 4/3] Thread/Child-Domain Assignment
References: <487C7698.60503@ak.jp.nec.com>	 <1216129084.9348.27.camel@moss-spartans.epoch.ncsc.mil>	 <487D5A3D.6090801@ak.jp.nec.com> <1216210685.17602.98.camel@moss-spartans.epoch.ncsc.mil> <48803685.1000505@ak.jp.nec.com> <4886AC81.9030202@ak.jp.nec.com> <4889CC5F.3030500@ak.jp.nec.com>
In-Reply-To: <4889CC5F.3030500@ak.jp.nec.com>
Content-Type: multipart/mixed;
 boundary="------------040303070300000703040501"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040303070300000703040501
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit

[4/3] sample program and policy
  The attached files are sample program and policy.

  The policy provides definitions of unconfined_XXXX_t as child domains of
  unconfined_t. You can run this sample program on your shell (unconfined_t).

  This sample program makes four threads, and they tries to change its domain.
  The number in leftside shows its thread id. Three of them succeeded to change,
  but rest of them cannot.
  The unconfined_red_t and unconfined_blue_t is a hierarchical child domain of
  unconfined_t and the forth thread (12868) does not change its domain, so they
  are allowed to have its security context different from others.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--------------040303070300000703040501
Content-Type: text/plain;
 name="thread-context.c"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="thread-context.c"

I2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdHJpbmcuaD4KI2luY2x1ZGUgPGVycm5v
Lmg+CiNpbmNsdWRlIDxwdGhyZWFkLmg+CiNpbmNsdWRlIDxzeXMvc3lzY2FsbC5oPgojaW5j
bHVkZSA8c3lzL3R5cGVzLmg+CiNpbmNsdWRlIDxzZWxpbnV4L3NlbGludXguaD4KCnN0YXRp
YyB2b2lkICp3b3JrZXIodm9pZCAqYXJnKQp7CglzZWN1cml0eV9jb250ZXh0X3QgY29udGV4
dAoJCT0gKHNlY3VyaXR5X2NvbnRleHRfdCkgYXJnOwoJaW50IHJjOwoKCXJjID0gc2V0Y29u
KGNvbnRleHQpOwoJcHJpbnRmKCIldTogc2V0Y29uKCVzKSA9ICVkICglcylcbiIsCgkgICAg
ICAgc3lzY2FsbChTWVNfZ2V0dGlkKSwgY29udGV4dCwgcmMsIHN0cmVycm9yKGVycm5vKSk7
CglpZiAocmMpCgkJcmV0dXJuIE5VTEw7CgoJaWYgKGdldGNvbigmY29udGV4dCkpIHsKCSAg
ICBwcmludGYoIiV1OiBnZXRjb24oKSBmYWlsZWQgKCVzKVxuIiwKCQkgICBzeXNjYWxsKFNZ
U19nZXR0aWQpLCBzdHJlcnJvcihlcnJubykpOwoJICAgIHJldHVybiBOVUxMOwoJfQoKCXBy
aW50ZigiJXU6IE5vdyBJJ20gcnVubmluZyBpbiAlc1xuIiwKCSAgICAgICBzeXNjYWxsKFNZ
U19nZXR0aWQpLCBjb250ZXh0KTsKCglmcmVlY29uKGNvbnRleHQpOwoKCXNsZWVwKDEpOwkv
KiB0byBrZWVwIG1tLT5tbV91c2VycyA+IDEgZm9yIGEgd2hpbGUgKi8KCglyZXR1cm4gTlVM
TDsKfQoKc3RhdGljIGNoYXIgKnRlc3RfY29udGV4dHNbXSA9IHsKICAgICJ1bmNvbmZpbmVk
X3U6dW5jb25maW5lZF9yOnVuY29uZmluZWRfcmVkX3Q6czAiLAogICAgInVuY29uZmluZWRf
dTp1bmNvbmZpbmVkX3I6dW5jb25maW5lZF9ibHVlX3Q6czAiLAogICAgInVuY29uZmluZWRf
dTp1bmNvbmZpbmVkX3I6dW5jb25maW5lZF9ncmVlbl90OnMwIiwKICAgICJ1bmNvbmZpbmVk
X3U6dW5jb25maW5lZF9yOnVuY29uZmluZWRfdDpzMCIsCn07CiNkZWZpbmUgTlVNX1RFU1Qg
KHNpemVvZih0ZXN0X2NvbnRleHRzKSAvIHNpemVvZih0ZXN0X2NvbnRleHRzWzBdKSkKCmlu
dCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCnsKCXNlY3VyaXR5X2NvbnRleHRfdCBj
b250ZXh0OwoJcHRocmVhZF90IHRocmVhZFtOVU1fVEVTVF07CglpbnQgaTsKCglpZiAoIWdl
dGNvbigmY29udGV4dCkpCgkJcHJpbnRmKCIldTogTm93IGxlYWRlciBpcyBydW5uaW5nIGF0
ICVzXG4iLAoJCSAgICAgICBzeXNjYWxsKFNZU19nZXR0aWQpLCBjb250ZXh0KTsKCglmb3Ig
KGk9MDsgaSA8IE5VTV9URVNUOyBpKyspCgkJcHRocmVhZF9jcmVhdGUoJnRocmVhZFtpXSwg
TlVMTCwgd29ya2VyLCB0ZXN0X2NvbnRleHRzW2ldKTsKCglmb3IgKGk9MDsgaSA8IE5VTV9U
RVNUOyBpKyspCgkJcHRocmVhZF9qb2luKHRocmVhZFtpXSwgTlVMTCk7CgoJcmV0dXJuIDA7
Cn0K
--------------040303070300000703040501
Content-Type: text/plain;
 name="thread-context.te"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="thread-context.te"

cG9saWN5X21vZHVsZSh0aHJlYWQtY29udGV4dCwgMS4wKQoKZ2VuX3JlcXVpcmUoYAoJdHlw
ZSB1bmNvbmZpbmVkX3Q7Cgl0eXBlIHVuY29uZmluZWRfZGV2cHRzX3Q7CgoJcm9sZSB1bmNv
bmZpbmVkX3I7CicpCgphdHRyaWJ1dGUgdW5jb25maW5lZF9jb2xvcnM7CgojLS0tIHJlZCAt
LS0KdHlwZSB1bmNvbmZpbmVkX3JlZF90LCB1bmNvbmZpbmVkX2NvbG9yczsKZG9tYWluX3R5
cGUodW5jb25maW5lZF9yZWRfdCk7CnJvbGUgdW5jb25maW5lZF9yIHR5cGVzIHVuY29uZmlu
ZWRfcmVkX3Q7CgojLS0tIGJsdWUgLS0tCnR5cGUgdW5jb25maW5lZF9ibHVlX3QsIHVuY29u
ZmluZWRfY29sb3JzOwpkb21haW5fdHlwZSh1bmNvbmZpbmVkX2JsdWVfdCk7CnJvbGUgdW5j
b25maW5lZF9yIHR5cGVzIHVuY29uZmluZWRfYmx1ZV90OwoKIy0tLSBncmVlbiAtLS0KdHlw
ZSB1bmNvbmZpbmVkX2dyZWVuX3QsIHVuY29uZmluZWRfY29sb3JzOwpkb21haW5fdHlwZSh1
bmNvbmZpbmVkX2dyZWVuX3QpOwpyb2xlIHVuY29uZmluZWRfciB0eXBlcyB1bmNvbmZpbmVk
X2dyZWVuX3Q7CgojLS0tIGhpZXJhcmNoeSAtLS0KdHlwZWRvbWluYXRlIHVuY29uZmluZWRf
dCB1bmNvbmZpbmVkX3JlZF90Owp0eXBlZG9taW5hdGUgdW5jb25maW5lZF90IHVuY29uZmlu
ZWRfYmx1ZV90OwojIHR5cGVkb21pbmF0ZSB1bmNvbmZpbmVkX3QgdW5jb25maW5lZF9ncmVl
bl90OwoKIy0tLSBwcm9jZXNzOmR5bnRyYW5zaXRpb24KYWxsb3cgdW5jb25maW5lZF90IHVu
Y29uZmluZWRfY29sb3JzIDogcHJvY2VzcyB7IGR5bnRyYW5zaXRpb24gfTsKYWxsb3cgdW5j
b25maW5lZF9jb2xvcnMgdW5jb25maW5lZF90IDogZmQgeyB1c2UgfTsKYWxsb3cgdW5jb25m
aW5lZF9jb2xvcnMgdW5jb25maW5lZF9kZXZwdHNfdCA6IGNocl9maWxlIHsgd3JpdGUgfTsK
CiMtLS0gL3Byb2MgcGVybWlzc2lvbnMKa2VybmVsX3NlYXJjaF9wcm9jKHVuY29uZmluZWRf
Y29sb3JzKQphbGxvdyB1bmNvbmZpbmVkX2NvbG9ycyB1bmNvbmZpbmVkX3QgOiBkaXIgc2Vh
cmNoX2Rpcl9wZXJtczsKYWxsb3cgdW5jb25maW5lZF9jb2xvcnMgc2VsZiA6IGZpbGUgcmVh
ZF9maWxlX3Blcm1zOwo=
--------------040303070300000703040501--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
