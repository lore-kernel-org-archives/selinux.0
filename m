Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8CJUnBE021603
	for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2007 15:30:49 -0400
Received: from atlrel7.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8CJUhlJ026986
	for <selinux@tycho.nsa.gov>; Wed, 12 Sep 2007 19:30:43 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [PATCH] Small cleanup for 2.6.24 and a git tree test
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Date: Wed, 12 Sep 2007 15:29:31 -0400
Message-ID: <20070912192305.18318.11911.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The cleanup patch is pretty trivial and is explained in it's own email, but
essentially it is just moving similar code into a new function and then
modifying the original functions to call the newly created function.

The new and exciting thing is that I actually decided I should probably know
how to do more than just clone git trees, which means you can get this patch
by pulling from the brand spankin' new labeled networking git tree.  The tree
looks okay to me but it's possible I munged something, if that is the case let
me know and I'll try to fix it ... I'd like to get this working at some point.

 * git://git.infradead.org/users/pcmoore/lblnet-2.6

Thanks.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
