Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1ICDkdW004890
	for <selinux@tycho.nsa.gov>; Fri, 18 Feb 2005 07:13:46 -0500 (EST)
Received: from wproxy.gmail.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1IC9qM6008010
	for <selinux@tycho.nsa.gov>; Fri, 18 Feb 2005 12:09:52 GMT
Received: by wproxy.gmail.com with SMTP id 68so532597wra
        for <selinux@tycho.nsa.gov>; Fri, 18 Feb 2005 04:12:07 -0800 (PST)
Message-ID: <7a182bd9050218041213a2be2f@mail.gmail.com>
Date: Fri, 18 Feb 2005 13:12:06 +0100
From: Laurens Blankers <laurens.blankers@gmail.com>
Reply-To: Laurens Blankers <laurens.blankers@gmail.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] HOME on /var causes incorrect labelling
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_990_11885094.1108728726968"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_990_11885094.1108728726968
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello list,

My users home directory is /var/home. It gets incorrectly labelled as
var_t in stead of home_root_t/user_home_dir_t because of the order of
declarations in types.fc. Moving the declaration of HOME to directly
after /var solves the problem.

This of course may introduce another problem when /var is actually
/home/var, but that is a very unlikely scenario. While home in /var is
more common (in my experience).

I have attached a patch (against policy 1.20) which modifies types.fc
accordingly.

Sincerely,

Laurens Blankers

------=_Part_990_11885094.1108728726968
Content-Type: application/octet-stream; name="policy-varhome.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="policy-varhome.patch"

LS0tIGZpbGVfY29udGV4dHMvdHlwZXMuZmMJMjAwNS0wMS0wNSAxNzozODo0MC4wMDAwMDAwMDAg
KzAxMDAKKysrIC9ldGMvc2VsaW51eC90YXJnZXRlZC9zcmMvcG9saWN5L2ZpbGVfY29udGV4dHMv
dHlwZXMuZmMJMjAwNS0wMi0xOCAxMzowMDo1NS42MDQ4NzUzMTIgKzAxMDAKQEAgLTQ0LDE5ICs0
NCw2IEBACiAvCQkJLWQJc3lzdGVtX3U6b2JqZWN0X3I6cm9vdF90CiAKICMKLSMgT3JkaW5hcnkg
dXNlciBob21lIGRpcmVjdG9yaWVzLgotIyBIT01FX1JPT1QgZXhwYW5kcyB0byBhbGwgdmFsaWQg
aG9tZSBkaXJlY3RvcnkgcHJlZml4ZXMgZm91bmQgaW4gL2V0Yy9wYXNzd2QKLSMgSE9NRV9ESVIg
ZXhwYW5kcyB0byBlYWNoIHVzZXIncyBob21lIGRpcmVjdG9yeSwKLSMgICAgICAgICAgICAgICAg
ICBhbmQgdG8gSE9NRV9ST09UL1teL10rIGZvciBlYWNoIEhPTUVfUk9PVC4KLSMgUk9MRSBleHBh
bmRzIHRvIGVhY2ggdXNlcidzIHJvbGUgd2hlbiByb2xlICE9IHVzZXJfciwgYW5kIHRvICJ1c2Vy
IiBvdGhlcndpc2UuCi0jCi1IT01FX1JPT1QJCS1kCXN5c3RlbV91Om9iamVjdF9yOmhvbWVfcm9v
dF90Ci1IT01FX0RJUgkJLWQJc3lzdGVtX3U6b2JqZWN0X3I6Uk9MRV9ob21lX2Rpcl90Ci1IT01F
X0RJUi8uKwkJCXN5c3RlbV91Om9iamVjdF9yOlJPTEVfaG9tZV90Ci0KLS9yb290L1wuZGVmYXVs
dF9jb250ZXh0cwktLSAJc3lzdGVtX3U6b2JqZWN0X3I6ZGVmYXVsdF9jb250ZXh0X3QKLQotIwog
IyBNb3VudCBwb2ludHM7IGRvIG5vdCByZWxhYmVsIHN1YmRpcmVjdG9yaWVzLCBzaW5jZQogIyB3
ZSBkb24ndCB3YW50IHRvIGNoYW5nZSBhbnkgcmVtb3ZhYmxlIG1lZGlhIGJ5IGRlZmF1bHQuCiAv
bW50KC9bXi9dKik/CQktZAlzeXN0ZW1fdTpvYmplY3RfcjptbnRfdApAQCAtODQsNiArNzEsMTkg
QEAKIC92YXIvbWFpbG1hbi9weXRob25saWIoLy4qKT8vLipcLnNvKFwuLiopPwktLSBzeXN0ZW1f
dTpvYmplY3RfcjpzaGxpYl90CiAKICMKKyMgT3JkaW5hcnkgdXNlciBob21lIGRpcmVjdG9yaWVz
LgorIyBIT01FX1JPT1QgZXhwYW5kcyB0byBhbGwgdmFsaWQgaG9tZSBkaXJlY3RvcnkgcHJlZml4
ZXMgZm91bmQgaW4gL2V0Yy9wYXNzd2QKKyMgSE9NRV9ESVIgZXhwYW5kcyB0byBlYWNoIHVzZXIn
cyBob21lIGRpcmVjdG9yeSwKKyMgICAgICAgICAgICAgICAgICBhbmQgdG8gSE9NRV9ST09UL1te
L10rIGZvciBlYWNoIEhPTUVfUk9PVC4KKyMgUk9MRSBleHBhbmRzIHRvIGVhY2ggdXNlcidzIHJv
bGUgd2hlbiByb2xlICE9IHVzZXJfciwgYW5kIHRvICJ1c2VyIiBvdGhlcndpc2UuCisjCitIT01F
X1JPT1QgICAgICAgLWQgIHN5c3RlbV91Om9iamVjdF9yOmhvbWVfcm9vdF90CitIT01FX0RJUiAg
ICAgICAgLWQgIHN5c3RlbV91Om9iamVjdF9yOlJPTEVfaG9tZV9kaXJfdAorSE9NRV9ESVIvLisg
ICAgICAgICBzeXN0ZW1fdTpvYmplY3RfcjpST0xFX2hvbWVfdAorCisvcm9vdC9cLmRlZmF1bHRf
Y29udGV4dHMgICAgLS0gIHN5c3RlbV91Om9iamVjdF9yOmRlZmF1bHRfY29udGV4dF90CisKKyMK
ICMgL3Zhci9mdHAKICMKIC92YXIvZnRwL2JpbigvLiopPwkJc3lzdGVtX3U6b2JqZWN0X3I6Ymlu
X3QK
------=_Part_990_11885094.1108728726968--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
