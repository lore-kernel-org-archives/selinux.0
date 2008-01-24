Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0OLPItc027183
	for <selinux@tycho.nsa.gov>; Thu, 24 Jan 2008 16:25:18 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m0OLPIgt004879
	for <selinux@tycho.nsa.gov>; Thu, 24 Jan 2008 21:25:18 GMT
Subject: [patch] fixfiles -C: behave as advertised
From: Marshall Miller <mmiller@tresys.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-YOwt9BRdyO5g0ezXwkSf"
Date: Thu, 24 Jan 2008 16:25:17 -0500
Message-Id: <1201209917.4502.72.camel@hostmachine.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-YOwt9BRdyO5g0ezXwkSf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch makes fixfiles -C <file> (restore|check|verify|relabel) behave as advertised.



Marshall Miller


--=-YOwt9BRdyO5g0ezXwkSf
Content-Disposition: attachment; filename=fixfiles_dash_C2.patch
Content-Type: text/x-patch; name=fixfiles_dash_C2.patch; charset=UTF-8
Content-Transfer-Encoding: base64

SW5kZXg6IHBvbGljeWNvcmV1dGlscy9zY3JpcHRzL2ZpeGZpbGVzDQo9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQotLS0g
cG9saWN5Y29yZXV0aWxzL3NjcmlwdHMvZml4ZmlsZXMJKHJldmlzaW9uIDI3NTcpDQorKysgcG9s
aWN5Y29yZXV0aWxzL3NjcmlwdHMvZml4ZmlsZXMJKHdvcmtpbmcgY29weSkNCkBAIC05Miw3ICs5
Miw3IEBADQogCQkgICAgICAhIFwoIC1mc3R5cGUgZXh0MiAtbyAtZnN0eXBlIGV4dDMgLW8gLWZz
dHlwZSBleHQ0IC1vIC1mc3R5cGUgZXh0NGRldiAgLW8gLWZzdHlwZSBnZnMyIC1vIC1mc3R5cGUg
amZzIC1vIC1mc3R5cGUgeGZzIFwpIC1wcnVuZSAgLW8gXA0KIAkJICAgICAgXCggLXdob2xlbmFt
ZSAvaG9tZSAtbyAtd2hvbGVuYW1lIC9yb290IC1vIC13aG9sZW5hbWUgL3RtcCAtd2hvbGVuYW1l
IC9kZXYgXCkgLXBydW5lIC1vIC1wcmludDAiOyBcDQogCQkgICAgICBkb25lIDI+IC9kZXYvbnVs
bCB8IFwNCi0JICR7UkVTVE9SRUNPTn0gJDIgLTAgLWYgLSANCisJICR7UkVTVE9SRUNPTn0gJCog
LTAgLWYgLSANCiAJcm0gLWYgJHtURU1QRklMRX0gJHtQUkVGQ1RFTVBGSUxFfQ0KIGZpDQogfQ0K
QEAgLTExNyw3ICsxMTcsNyBAQA0KICMNCiByZXN0b3JlICgpIHsNCiBpZiBbICEgLXogIiRQUkVG
QyIgXTsgdGhlbg0KLSAgICBkaWZmX2ZpbGVjb250ZXh0ICQxDQorICAgIGRpZmZfZmlsZWNvbnRl
eHQgJCoNCiAgICAgZXhpdCAkPw0KIGZpDQogaWYgWyAhIC16ICIkUlBNRklMRVMiIF07IHRoZW4N
Cg==


--=-YOwt9BRdyO5g0ezXwkSf--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
