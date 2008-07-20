Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6KBhaPQ026129
	for <selinux@tycho.nsa.gov>; Sun, 20 Jul 2008 07:43:36 -0400
Received: from sender-03.it.helsinki.fi (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6KBhYR6003668
	for <selinux@tycho.nsa.gov>; Sun, 20 Jul 2008 11:43:35 GMT
Received: from ruuvi.it.helsinki.fi (ruuvi.it.helsinki.fi [128.214.205.65])
	by sender-03.it.helsinki.fi (8.13.1/8.13.1) with ESMTP id m6KBhXGL000617
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Sun, 20 Jul 2008 14:43:33 +0300
Received: from ruuvi.it.helsinki.fi (localhost.localdomain [127.0.0.1])
	by ruuvi.it.helsinki.fi (8.13.1/8.13.1) with ESMTP id m6KBhXIt031303
	for <selinux@tycho.nsa.gov>; Sun, 20 Jul 2008 14:43:33 +0300
Received: from localhost (vmkari@localhost)
	by ruuvi.it.helsinki.fi (8.13.1/8.13.1/Submit) with ESMTP id m6KBhWBB031300
	for <selinux@tycho.nsa.gov>; Sun, 20 Jul 2008 14:43:33 +0300
Date: Sun, 20 Jul 2008 14:43:32 +0300 (EEST)
From: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>
To: selinux@tycho.nsa.gov
Subject: [patch]: ss/services.c null character style fix
Message-ID: <Pine.LNX.4.64L.0807201434040.31208@ruuvi.it.helsinki.fi>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-696237619-508712486-1216553879=:31208"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---696237619-508712486-1216553879=:31208
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.64L.0807201438181.31208@ruuvi.it.helsinki.fi>


Hello,

Patch against 2.6.26.

ss/services.c null character style fix attached.

In my opinion, it is better C-style to use the escaped version
of null character when we deal with C-strings. So I always prefer:

 c = '\0';

to the

 c = 0;

although both are standards-compliant and correct.

Best regards,
vmk
--
************************************************************************
               Tietotekniikkaosasto / Helsingin yliopisto
                 IT Department / University of Helsinki
************************************************************************
---696237619-508712486-1216553879=:31208
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=services-null-char-style-fix.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64L.0807201437590.31208@ruuvi.it.helsinki.fi>
Content-Description: null char style
Content-Disposition: ATTACHMENT; FILENAME=services-null-char-style-fix.patch

LS0tIGxpbnV4LTIuNi4yNi9zZWN1cml0eS9zZWxpbnV4L3NzL3NlcnZpY2Vz
LmMJMjAwOC0wNy0xNCAwMDo1MToyOS4wMDAwMDAwMDAgKzAzMDANCisrKyBs
aW51eC0yLjYuMjYtdm1rL3NlY3VyaXR5L3NlbGludXgvc3Mvc2VydmljZXMu
YwkyMDA4LTA3LTIwIDE0OjE4OjUxLjAwMDAwMDAwMCArMDMwMA0KQEAgLTc0
NCw3ICs3NDQsNyBAQA0KIAkJZ290byBvdXQ7DQogCX0NCiAJbWVtY3B5KHNj
b250ZXh0Miwgc2NvbnRleHQsIHNjb250ZXh0X2xlbik7DQotCXNjb250ZXh0
MltzY29udGV4dF9sZW5dID0gMDsNCisJc2NvbnRleHQyW3Njb250ZXh0X2xl
bl0gPSAnXDAnOw0KIA0KIAljb250ZXh0X2luaXQoJmNvbnRleHQpOw0KIAkq
c2lkID0gU0VDU0lEX05VTEw7DQpAQCAtNzYxLDEwICs3NjEsMTAgQEANCiAJ
d2hpbGUgKCpwICYmICpwICE9ICc6JykNCiAJCXArKzsNCiANCi0JaWYgKCpw
ID09IDApDQorCWlmICgqcCA9PSAnXDAnKQ0KIAkJZ290byBvdXRfdW5sb2Nr
Ow0KIA0KLQkqcCsrID0gMDsNCisJKnArKyA9ICdcMCc7DQogDQogCXVzcmRh
dHVtID0gaGFzaHRhYl9zZWFyY2gocG9saWN5ZGIucF91c2Vycy50YWJsZSwg
c2NvbnRleHRwKTsNCiAJaWYgKCF1c3JkYXR1bSkNCkBAIC03NzcsMTAgKzc3
NywxMCBAQA0KIAl3aGlsZSAoKnAgJiYgKnAgIT0gJzonKQ0KIAkJcCsrOw0K
IA0KLQlpZiAoKnAgPT0gMCkNCisJaWYgKCpwID09ICdcMCcpDQogCQlnb3Rv
IG91dF91bmxvY2s7DQogDQotCSpwKysgPSAwOw0KKwkqcCsrID0gJ1wwJzsN
CiANCiAJcm9sZSA9IGhhc2h0YWJfc2VhcmNoKHBvbGljeWRiLnBfcm9sZXMu
dGFibGUsIHNjb250ZXh0cCk7DQogCWlmICghcm9sZSkNCkBAIC03OTIsNyAr
NzkyLDcgQEANCiAJd2hpbGUgKCpwICYmICpwICE9ICc6JykNCiAJCXArKzsN
CiAJb2xkYyA9ICpwOw0KLQkqcCsrID0gMDsNCisJKnArKyA9ICdcMCc7DQog
DQogCXR5cGRhdHVtID0gaGFzaHRhYl9zZWFyY2gocG9saWN5ZGIucF90eXBl
cy50YWJsZSwgc2NvbnRleHRwKTsNCiAJaWYgKCF0eXBkYXR1bSkNCg==

---696237619-508712486-1216553879=:31208--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
