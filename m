Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8Q507Ip028478
	for <selinux@tycho.nsa.gov>; Wed, 26 Sep 2007 01:00:07 -0400
Received: from dmzmta101.na.baesystems.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8Q504Re010107
	for <selinux@tycho.nsa.gov>; Wed, 26 Sep 2007 05:00:04 GMT
Received: from BLUMS0035.bluelnk.net (blums0035.bluelnk.net [10.40.96.56])
	by dmzmta101.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id l8Q4wfdV028347
	for <selinux@tycho.nsa.gov>; Wed, 26 Sep 2007 00:58:41 -0400
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by usdmta001.na.baesystems.com (Switch-3.2.0/Switch-3.2.0) with ESMTP id l8Q4vvwq012064
	for <selinux@tycho.nsa.gov>; Wed, 26 Sep 2007 00:57:57 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: turning on optional_policy
Date: Tue, 25 Sep 2007 22:00:01 -0700
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD49A291@blums0008.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This statement is located in domain.te, allowing all domains to
translate contexts using the mcstrans service. 

optional_policy(`
	setrans_translate_context(domain)
')

How do I turn on optional_policy to make this statement take effect?

Also, when I turn this on, what other side effects will I be getting?

Thanks



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
