Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l92Ibai6009310
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2007 14:37:36 -0400
Received: from atlrel7.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l92IbVK6023650
	for <selinux@tycho.nsa.gov>; Tue, 2 Oct 2007 18:37:31 GMT
Received: from smtp2.fc.hp.com (smtp.cnd.hp.com [15.11.136.114])
	by atlrel7.hp.com (Postfix) with ESMTP id 212BD35A91
	for <selinux@tycho.nsa.gov>; Tue,  2 Oct 2007 14:37:30 -0400 (EDT)
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v3 0/2] Small changes, now available in git form
To: selinux@tycho.nsa.gov
Date: Tue, 02 Oct 2007 14:37:24 -0400
Message-ID: <20071002183121.24760.92916.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Not a whole lot of changes in this revision, mostly just the policy version
name change discussed on the list and some small fixes I've noticed while
looking at the code.  I'm also making these patches available in git form
for those of you who want to help out with testing ...

 * git://git.infradead.org/users/pcmoore/lblnet-2.6_testing

You'll note the patches aren't signed off yet, that's because I'm not ready
for them to get pulled anywhere important just yet.

Next on my list is the ability to dynamically enable/disable the packet
access checks for labeled IPsec and SECMARK based on the presence of any
configuration - similar to what we are doing today with NetLabel and the
netlbl_enabled() function.

-- 
paul moore
linux security @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
