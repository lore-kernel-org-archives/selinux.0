Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TJrwrT021930
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 15:53:58 -0400 (EDT)
Received: from smtp812.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i6TJruCb019710
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 19:53:57 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp812.mail.ukl.yahoo.com with SMTP; 29 Jul 2004 19:53:57 -0000
Date: Thu, 29 Jul 2004 21:05:02 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: James Morris <jmorris@redhat.com>, Joshua Brindle <method@gentoo.org>,
   SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: temporary hack to use udev in selinux
Message-ID: <20040729200502.GF9950@lkcl.net>
References: <Xine.LNX.4.44.0407291305360.16390-100000@dhcp83-76.boston.redhat.com> <1091121776.21971.132.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1091121776.21971.132.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jul 29, 2004 at 01:22:56PM -0400, Stephen Smalley wrote:
> On Thu, 2004-07-29 at 13:06, James Morris wrote:
> > This could be done by simply allowing context= to override any other 
> > behavior, right?
> 
> context= only lets you map all inodes in the filesystem to a single
> security context and prohibits getxattr/setxattr/setfscreatecon.  

> For
> tmpfs, we want to allow individual inode labeling and
> getxattr/setxattr/setfscreatecon, 

 patch done that.  for dirs, files, symlinks and "special" inodes, whatever
 _they_ are.
 
 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
