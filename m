Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8QLWHgx012349
	for <selinux@tycho.nsa.gov>; Wed, 26 Sep 2007 17:32:17 -0400
Received: from atlrel8.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8QLWGv4010640
	for <selinux@tycho.nsa.gov>; Wed, 26 Sep 2007 21:32:16 GMT
Received: from smtp1.fc.hp.com (smtp.fc.hp.com [15.15.136.127])
	by atlrel8.hp.com (Postfix) with ESMTP id 8971C360E1
	for <selinux@tycho.nsa.gov>; Wed, 26 Sep 2007 17:32:16 -0400 (EDT)
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v2 0/2] Updated patches based on comments
To: selinux@tycho.nsa.gov
Date: Wed, 26 Sep 2007 17:32:12 -0400
Message-ID: <20070926212810.15998.58788.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm resending these patches because I've made some non-trivial changes based on
comments from the list and I'd like to check to make sure I'm moving in the
right direction.  The two big changes are the shift from a policy capability
version number to a policy capability bitmap and the transfer of much of the
logic within selinux_skb_peerlbl_sid() into the new security server function
selinux_skb_peerlbl_sid().

Once again, these patches compile and boot, but use at your own risk.

-- 
paul moore
linux security @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
