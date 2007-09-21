Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8L1psJq016800
	for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2007 21:51:54 -0400
Received: from dmzmta102.na.baesystems.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8L1prau009633
	for <selinux@tycho.nsa.gov>; Fri, 21 Sep 2007 01:51:53 GMT
Received: from BLUMS0033.bluelnk.net (blums0033.bluelnk.net [10.40.96.54])
	by dmzmta102.na.baesystems.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id l8L1oQXA026147
	for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2007 21:50:26 -0400
Received: from blums0008.bluelnk.net (blums0008.sd.gd.com [134.120.81.40])
	by usdmta001.na.baesystems.com (Switch-3.2.0/Switch-3.2.0) with ESMTP id l8L1nmJB029527
	for <selinux@tycho.nsa.gov>; Thu, 20 Sep 2007 21:49:49 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: execmod permission
Date: Thu, 20 Sep 2007 18:51:48 -0700
Message-ID: <FB39F4E77226B448BC1388D3BE4E00CD49A27D@blums0008.bluelnk.net>
From: "Clarkson, Mike R \(US SSA\)" <mike.clarkson@baesystems.com>
To: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Can someone explain to me what this permission provides?

The explanation that I've seen is this: "Make executable a file mapping
that has been modified (implied by a copy-on-write)"

I don't know what that means. The audit log is suggesting that I need to
provide this permission for a shared library file. 

Thanks



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
