Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lA5LiEJ6002800
	for <selinux@tycho.nsa.gov>; Mon, 5 Nov 2007 16:44:14 -0500
Received: from atlrel6.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lA5LiDZr017817
	for <selinux@tycho.nsa.gov>; Mon, 5 Nov 2007 21:44:13 GMT
Received: from smtp1.fc.hp.com (smtp.fc.hp.com [15.15.136.127])
	by atlrel6.hp.com (Postfix) with ESMTP id 0586B3543C
	for <selinux@tycho.nsa.gov>; Mon,  5 Nov 2007 16:43:42 -0500 (EST)
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v5 0/8] Updated labeled networking patches
To: selinux@tycho.nsa.gov
Date: Mon, 05 Nov 2007 16:43:31 -0500
Message-ID: <20071105213829.9361.58157.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

An update on the labeled networking patches I'm targeting for 2.6.25.  This
latest spin rebases against Linus' latest and adds in the foundation for the
fallback/static label patches that were posted earlier.  The actual fallback
and flow control patches are still not included in this patch set but all of
the foundation pieces should now be in place.

Just a word of caution, while these all compile without problems I'm
currently having a problem getting the "make modules_install" step to work
correctly so I haven't had a chance to test these patches yet.

For those of you using git, you can find these patches here:

 * git://git.infradead.org/users/pcmoore/lblnet-2.6_testing

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
