Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l12GhKJS029519
	for <selinux@tycho.nsa.gov>; Fri, 2 Feb 2007 11:43:20 -0500
Received: from macii.ads-oh.atg.titan.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l12GiNx3006203
	for <selinux@tycho.nsa.gov>; Fri, 2 Feb 2007 16:44:24 GMT
Received: from [192.168.50.32] (macii.ads-oh.atg.titan.com [66.218.141.147])
	by macii.ads-oh.atg.titan.com (Postfix) with ESMTP id C496614729D
	for <selinux@tycho.nsa.gov>; Fri,  2 Feb 2007 16:34:03 +0000 (GMT)
Mime-Version: 1.0
Message-Id: <p0600202dc1e90d941990@[192.168.50.32]>
Date: Fri, 2 Feb 2007 11:25:41 -0500
To: selinux@tycho.nsa.gov
From: Rosalie Hiebel <rosalie.hiebel@L-3Com.com>
Subject: audit2allow and mls
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is there version of audit2allow which is capable of generating rules specific
to the mls policy?  I see that audit2allow's tests for mls  (calling 
get_mls_flag),
but this is after the rules in the .te file have been generated.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
