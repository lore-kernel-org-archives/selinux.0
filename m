Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1AFIPL9011878
	for <selinux@tycho.nsa.gov>; Thu, 10 Feb 2005 10:18:25 -0500 (EST)
Subject: Re: some policy patches
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200502032350.40924.russell@coker.com.au>
References: <200502032350.40924.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1108048794.10328.14.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 10 Feb 2005 10:19:54 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.  

Except that a chunk in ssh.te and login.te reverted Dan's removal of
ifdef(`automount.te' statements.  Was there a reason for this?

On Thu, 2005-02-03 at 07:50, Russell Coker wrote:
> Nothing really exciting in this patch.  Just some minor fixes and sorting out 
> some of the distro-specific stuff.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
