Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6KBi1Ng026191
	for <selinux@tycho.nsa.gov>; Sun, 20 Jul 2008 07:44:01 -0400
Received: from sender-03.it.helsinki.fi (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6KBhx1T022776
	for <selinux@tycho.nsa.gov>; Sun, 20 Jul 2008 11:44:00 GMT
Received: from ruuvi.it.helsinki.fi (ruuvi.it.helsinki.fi [128.214.205.65])
	by sender-03.it.helsinki.fi (8.13.1/8.13.1) with ESMTP id m6KBhx74000670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Sun, 20 Jul 2008 14:43:59 +0300
Received: from ruuvi.it.helsinki.fi (localhost.localdomain [127.0.0.1])
	by ruuvi.it.helsinki.fi (8.13.1/8.13.1) with ESMTP id m6KBhxAS031315
	for <selinux@tycho.nsa.gov>; Sun, 20 Jul 2008 14:43:59 +0300
Received: from localhost (vmkari@localhost)
	by ruuvi.it.helsinki.fi (8.13.1/8.13.1/Submit) with ESMTP id m6KBhxvM031312
	for <selinux@tycho.nsa.gov>; Sun, 20 Jul 2008 14:43:59 +0300
Date: Sun, 20 Jul 2008 14:43:59 +0300 (EEST)
From: Vesa-Matti J Kari <vmkari@cc.helsinki.fi>
To: selinux@tycho.nsa.gov
Subject: [patch]: ss/services.c remove unneeded assignment
Message-ID: <Pine.LNX.4.64L.0807201439520.31208@ruuvi.it.helsinki.fi>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-696237619-1434066240-1216554141=:31208"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---696237619-1434066240-1216554141=:31208
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.64L.0807201443501.31208@ruuvi.it.helsinki.fi>


Hello,

Patch against 2.6.26.

ss/services.c remove unneeded assignment attached.

The assignment

   *sid = SECSID_NULL;

is already done a few lines above.

Best regards,
vmk
--
************************************************************************
               Tietotekniikkaosasto / Helsingin yliopisto
                 IT Department / University of Helsinki
************************************************************************
---696237619-1434066240-1216554141=:31208
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME=services-remove-unneeded-assignment.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64L.0807201442210.31208@ruuvi.it.helsinki.fi>
Content-Description: remove unneeded assignment
Content-Disposition: ATTACHMENT; FILENAME=services-remove-unneeded-assignment.patch

LS0tIGxpbnV4LTIuNi4yNi9zZWN1cml0eS9zZWxpbnV4L3NzL3NlcnZpY2Vz
LmMJMjAwOC0wNy0xNCAwMDo1MToyOS4wMDAwMDAwMDAgKzAzMDANCisrKyBs
aW51eC0yLjYuMjYtdm1rL3NlY3VyaXR5L3NlbGludXgvc3Mvc2VydmljZXMu
YwkyMDA4LTA3LTIwIDE0OjEzOjI4LjAwMDAwMDAwMCArMDMwMA0KQEAgLTc0
Nyw3ICs3NDcsNiBAQA0KIAlzY29udGV4dDJbc2NvbnRleHRfbGVuXSA9IDA7
DQogDQogCWNvbnRleHRfaW5pdCgmY29udGV4dCk7DQotCSpzaWQgPSBTRUNT
SURfTlVMTDsNCiANCiAJUE9MSUNZX1JETE9DSzsNCiANCg==

---696237619-1434066240-1216554141=:31208--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
