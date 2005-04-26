Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j3QKcbgA012356
	for <selinux@tycho.nsa.gov>; Tue, 26 Apr 2005 16:38:37 -0400 (EDT)
Received: from web51507.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j3QKcYrP017131
	for <selinux@tycho.nsa.gov>; Tue, 26 Apr 2005 20:38:34 GMT
Message-ID: <20050426203837.1560.qmail@web51507.mail.yahoo.com>
Date: Tue, 26 Apr 2005 13:38:36 -0700 (PDT)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: Signal problem
To: Chris Wright <chrisw@osdl.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>Upon termination, what's queued to the netlink socket but not yet
>received is going to be lost, right?

I've also tested with nonfatal signals. This bug has been verified by other
people, too.

>Perhaps you need to be able to set pid == 0, and still drain the fd 
>when you recieve a TERM?

There's no way to drain the netlink socket in a race-free way. I've created a
whole new technique as a consequence. I'm just down to placing the hook.

-Steve

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
