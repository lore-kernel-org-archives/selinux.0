Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7KDllrT003952
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 09:47:47 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7KDliQ4026483
	for <selinux@tycho.nsa.gov>; Fri, 20 Aug 2004 13:47:45 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: restorecon
Date: Fri, 20 Aug 2004 23:47:39 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <200408201918.40233.russell@coker.com.au> <1093002067.16585.22.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1093002067.16585.22.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200408202347.39311.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 20 Aug 2004 21:41, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> Reasonable.  But still doesn't address the issue of whether the user
> meant to relabel the symlink itself or the referenced file.

I think we have to assume that the user wants to relabel the sym-link not 
follow it.

In enforcing mode with the default policy there will be no option to follow 
the link.  It's desirable to get the equivalent behaviour in enforcing and 
permissive modes, so that means not following the link.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
