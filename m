Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8FK5rrT020401
	for <selinux@tycho.nsa.gov>; Wed, 15 Sep 2004 16:05:53 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8FK5rhN015705
	for <selinux@tycho.nsa.gov>; Wed, 15 Sep 2004 20:05:53 GMT
Subject: Re: Patch: Kill duplicate permissions
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Cc: SELinux ML <selinux@tycho.nsa.gov>
In-Reply-To: <20040915170909.GA2560@jmh.mhn.de>
References: <20040915170909.GA2560@jmh.mhn.de>
Content-Type: text/plain
Message-Id: <1095278704.13380.10.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 15 Sep 2004 16:05:04 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Thanks.  Merged.

On Wed, 2004-09-15 at 13:09, Thomas Bleher wrote:
> Kill a few duplicate permissions, plus some small cleanup.
> 
> crond.te: already defined in logrotate.te
> xserver_macros.te: already defined in xdm.te
> 
> Others have duplicate permissions in the same file.
> 
> Please apply.
> 
> Thomas
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
