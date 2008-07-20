Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6KBhoPv026167
	for <selinux@tycho.nsa.gov>; Sun, 20 Jul 2008 07:43:50 -0400
Received: from sender-01.it.helsinki.fi (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6KBhn1T022747
	for <selinux@tycho.nsa.gov>; Sun, 20 Jul 2008 11:43:50 GMT
Received: from ruuvi.it.helsinki.fi (ruuvi.it.helsinki.fi [128.214.205.65])
	by sender-01.it.helsinki.fi (8.13.8/8.13.8) with ESMTP id m6KBhlre016611
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Sun, 20 Jul 2008 14:43:47 +0300
Received: from ruuvi.it.helsinki.fi (localhost.localdomain [127.0.0.1])
	by ruuvi.it.helsinki.fi (8.13.1/8.13.1) with ESMTP id m6KBhl0O031309
	for <selinux@tycho.nsa.gov>; Sun, 20 Jul 2008 14:43:48 +0300
Received: from localhost (vmkari@localhost)
	by ruuvi.it.helsinki.fi (8.13.1/8.13.1/Submit) with ESMTP id m6KBhlt5031306
	for <selinux@tycho.nsa.gov>; Sun, 20 Jul 2008 14:43:47 +0300
Date: Sun, 20 Jul 2008 14:43:47 +0300 (EEST)
From: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>
To: selinux@tycho.nsa.gov
Subject: [patch] ss/services.c services-remove-unneeded-cast.patch
Message-ID: <Pine.LNX.4.64L.0807201438340.31208@ruuvi.it.helsinki.fi>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-696237619-1653819777-1216553968=:31208"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---696237619-1653819777-1216553968=:31208
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.64L.0807201439451.31208@ruuvi.it.helsinki.fi>


Hello,

Patch against 2.6.26.

ss/services.c services-remove-unneeded-cast.patch attached.

Best regards,
vmk
--
************************************************************************
               Tietotekniikkaosasto / Helsingin yliopisto
                 IT Department / University of Helsinki
************************************************************************
---696237619-1653819777-1216553968=:31208
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=services-remove-unneeded-cast.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64L.0807201439280.31208@ruuvi.it.helsinki.fi>
Content-Description: remove unneeded cast
Content-Disposition: ATTACHMENT; FILENAME=services-remove-unneeded-cast.patch

LS0tIGxpbnV4LTIuNi4yNi9zZWN1cml0eS9zZWxpbnV4L3NzL3NlcnZpY2Vz
LmMJMjAwOC0wNy0xNCAwMDo1MToyOS4wMDAwMDAwMDAgKzAzMDANCisrKyBs
aW51eC0yLjYuMjYtdm1rL3NlY3VyaXR5L3NlbGludXgvc3Mvc2VydmljZXMu
YwkyMDA4LTA3LTIwIDE0OjI4OjU3LjAwMDAwMDAwMCArMDMwMA0KQEAgLTc1
NCw3ICs3NTQsNyBAQA0KIAkvKiBQYXJzZSB0aGUgc2VjdXJpdHkgY29udGV4
dC4gKi8NCiANCiAJcmMgPSAtRUlOVkFMOw0KLQlzY29udGV4dHAgPSAoY2hh
ciAqKSBzY29udGV4dDI7DQorCXNjb250ZXh0cCA9IHNjb250ZXh0MjsNCiAN
CiAJLyogRXh0cmFjdCB0aGUgdXNlci4gKi8NCiAJcCA9IHNjb250ZXh0cDsN
Cg==

---696237619-1653819777-1216553968=:31208--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
