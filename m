Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6D6P9Ha009341
	for <selinux@tycho.nsa.gov>; Sun, 13 Jul 2003 02:25:10 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h6D6P8H5020573
	for <selinux@tycho.nsa.gov>; Sun, 13 Jul 2003 06:25:08 GMT
Received: from monk.verbum.org (monk.debian.net [216.226.142.128])
        by jazzband.ncsc.mil  with ESMTP id h6D6P8RX020570 for <selinux@tycho.nsa.gov>; Sun, 13 Jul 2003 06:25:08 GMT
Received: from columbia (dhcp024-208-189-249.columbus.rr.com [24.208.189.249])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "columbia.verbum.org", Issuer "verbum.org CA" (verified OK))
	by monk.verbum.org (Postfix (Debian/GNU)) with ESMTP id E9C3532A6BB
	for <selinux@tycho.nsa.gov>; Sun, 13 Jul 2003 14:29:41 -0400 (EDT)
Subject: [patch] uninitialized values in setfiles/psid.c
From: Colin Walters <walters@verbum.org>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-XnN8owYX0ViwBbqep93S"
Message-Id: <1058077234.10673.68.camel@columbia>
Mime-Version: 1.0
Date: 13 Jul 2003 02:20:34 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-XnN8owYX0ViwBbqep93S
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

While updating to the newer policycoreutils release, I noticed the
following gcc warnings:

psid.c: In function `chpsid':
psid.c:609: warning: `off' might be used uninitialized in this function
psid.c:610: warning: `len' might be used uninitialized in this function

I believe the patch below should fix the problem.

--=-XnN8owYX0ViwBbqep93S
Content-Disposition: attachment; filename=setfiles-uninit-value.patch
Content-Type: text/plain; name=setfiles-uninit-value.patch; charset=UTF-8
Content-Transfer-Encoding: base64

LS0tIHNldGZpbGVzL3BzaWQuY34JMjAwMy0wNi0wMiAxNjoyMzowNy4wMDAwMDAwMDAgLTA0MDAN
CisrKyBzZXRmaWxlcy9wc2lkLmMJMjAwMy0wNy0xMyAwMjoxMDozOC4wMDAwMDAwMDAgLTA0MDAN
CkBAIC02NTgsMTAgKzY1OCwxMiBAQA0KIAkJICovDQogCQlEUFJJTlRGKCJjaHBzaWQ6ICBhZGRp
bmcgbmV3IGVudHJ5IHRvIGNvbnRleHRzXG4iKTsNCiANCi0JCXJjID0gbHNlZWsodC0+Y29udGV4
dHNfZnAsIDAsIFNFRUtfRU5EKTsNCi0JCWlmIChyYyA8IDApIHsNCisJCWxlbiA9IHN0cmxlbihj
b250ZXh0KSsxOw0KKw0KKwkJb2ZmID0gbHNlZWsodC0+Y29udGV4dHNfZnAsIDAsIFNFRUtfRU5E
KTsNCisJCWlmIChvZmYgPCAwKSB7DQogCQkJcGVycm9yKCJsc2VlayIpOw0KLQkJCXJldHVybiBy
YzsNCisJCQlyZXR1cm4gb2ZmOw0KIAkJfQ0KIAkJcmMgPSB3cml0ZSh0LT5jb250ZXh0c19mcCwg
Y29udGV4dCwgbGVuKTsNCiAJCWlmIChyYyA8IDApIHsNCg==

--=-XnN8owYX0ViwBbqep93S--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
