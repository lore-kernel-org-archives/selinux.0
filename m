Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l95JWvOo008568
	for <selinux@tycho.nsa.gov>; Fri, 5 Oct 2007 15:32:57 -0400
Received: from atlrel8.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l95JWuSq022523
	for <selinux@tycho.nsa.gov>; Fri, 5 Oct 2007 19:32:56 GMT
Received: from smtp2.fc.hp.com (smtp.fc.hp.com [15.11.136.114])
	by atlrel8.hp.com (Postfix) with ESMTP id A008636343
	for <selinux@tycho.nsa.gov>; Fri,  5 Oct 2007 15:32:56 -0400 (EDT)
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v4 0/3] Added new checks for labeled IPsec & SECMARK
	[en|dis]able
To: selinux@tycho.nsa.gov
Date: Fri, 05 Oct 2007 15:32:38 -0400
Message-ID: <20071005192619.28034.62276.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've updated the first two patches in this series based on Eric's comments
(thanks again Eric) and added a new patch which provides a way to determine if
labeled IPsec and SECMARK have been configured.  If they have been actively
configured we assume that they are enabled.  This is similar to the existing
netlbl_enabled() function and should allow us to dynamically enable/disable
the network access controls when using the new flow control checks as well the
local packet receive check when the new controls are active (i.e. new policy).

The SECMARK changes here are a bit on the ugly side, but due to it's ability to
be compiled as a module are options are somewhat limited.  If anyone has some
great ideas on the topic I'd love to hear them.

I've also updated the git tree for those of you who prefer to look at things
that way:

 * git://git.infradead.org/users/pcmoore/lblnet-2.6_testing

-- 
paul moore
linux security @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
