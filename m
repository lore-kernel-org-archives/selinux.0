Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4LNTxGC001947
	for <selinux@tycho.nsa.gov>; Sun, 21 May 2006 19:30:00 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4LNTvou021662
	for <selinux@tycho.nsa.gov>; Sun, 21 May 2006 23:29:58 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: daemons and MCS categories
Date: Mon, 22 May 2006 09:30:02 +1000
Cc: Shintaro Fujiwara <shin216@xf7.so-net.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200605220930.05483.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It seems to me that there is a benefit to giving some categories to daemons.

For example we may have two different categories for files that should be 
protected from each other but which are to be shared by Apache (note that 
categories in MCS are used for protecting integrity as well as 
confidentiality).

One idea that occurred to me is to give Apache (and other daemons) categories 
c128.c255.  Then there are 128 categories that can be used to restrict access 
of files that should not be accessed by daemons and 128 categories that can 
be used for files that can be accessed by daemons.

Another possibility is to have the ability to configure which categories are 
assigned to a daemon via run_init or some similar program.  It would not be 
difficult to read a config file that maps the domain of a daemon to the range 
that should be granted to it.


What do you think?

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
