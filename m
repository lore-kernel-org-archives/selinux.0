Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBTDVTIi027670
	for <selinux@tycho.nsa.gov>; Wed, 29 Dec 2004 08:31:29 -0500 (EST)
Received: from web50605.mail.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id iBTDTe6i022335
	for <selinux@tycho.nsa.gov>; Wed, 29 Dec 2004 13:29:40 GMT
Message-ID: <20041229133132.12663.qmail@web50605.mail.yahoo.com>
Date: Wed, 29 Dec 2004 05:31:32 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: Re: system auditing or event logging facilities
To: selinux@tycho.nsa.gov
In-Reply-To: <1104285346.22401.75.camel@hawaii.grays-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I'm writing a linux audit daemon. Its aiming to meet the requirements you
mentioned. Its currently distributed in Red Hat's rawhide repository and will
eventually be distributed in Red Hat Enterprise Linux 4. 

The current release in rawhide isn't terribly useful as its still a work in
progress. The code I'll be releasing as 0.6 is a big step forward and is good
enough for people to start playing with. You can get it from here:
http://mirrors.kernel.org/fedora/core/development/ Choose your arch and get
audit-0.5.6.

There is another mail list to discuss auditing: linux-audit@redhat.com. You might
want to look at the archives or join depending on your interest level.
http://www.redhat.com/mailman/listinfo/linux-audit

-Steve Grubb

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
