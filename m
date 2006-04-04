Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k34Ec0mV032364
	for <selinux@tycho.nsa.gov>; Tue, 4 Apr 2006 10:38:02 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k34EbxS5010541
	for <selinux@tycho.nsa.gov>; Tue, 4 Apr 2006 14:37:59 GMT
Subject: [patch] userhelper.te typo fix
From: James Leighton Athey <jathey@tresys.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-V8dhzqeZp5nv8WMMXNib"
Date: Tue, 04 Apr 2006 10:41:20 -0400
Message-Id: <1144161680.15137.3.camel@tesla.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-V8dhzqeZp5nv8WMMXNib
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

There's a typo in userhelper.te where it should be adding
userhelper_exec_t to files_type but instead it adds userhelper_conf_t
twice.  I've attached a patch to fix it.


--=-V8dhzqeZp5nv8WMMXNib
Content-Disposition: attachment; filename=userhelper.te.patch
Content-Type: text/x-patch; name=userhelper.te.patch; charset=UTF-8
Content-Transfer-Encoding: base64

SW5kZXg6IHBvbGljeS9tb2R1bGVzL2FwcHMvdXNlcmhlbHBlci50ZQ0KPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KLS0t
IHBvbGljeS9tb2R1bGVzL2FwcHMvdXNlcmhlbHBlci50ZQkocmV2aXNpb24gMTY5MSkNCisrKyBw
b2xpY3kvbW9kdWxlcy9hcHBzL3VzZXJoZWxwZXIudGUJKHdvcmtpbmcgY29weSkNCkBAIC0xMCw0
ICsxMCw0IEBADQogZmlsZXNfdHlwZSh1c2VyaGVscGVyX2NvbmZfdCkNCiANCiB0eXBlIHVzZXJo
ZWxwZXJfZXhlY190Ow0KLWZpbGVzX3R5cGUodXNlcmhlbHBlcl9jb25mX3QpDQorZmlsZXNfdHlw
ZSh1c2VyaGVscGVyX2V4ZWNfdCkNCg==


--=-V8dhzqeZp5nv8WMMXNib--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
