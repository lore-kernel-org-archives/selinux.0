Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6CD3ZgA015823
	for <selinux@tycho.nsa.gov>; Tue, 12 Jul 2005 09:03:35 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6CCxlbb004465
	for <selinux@tycho.nsa.gov>; Tue, 12 Jul 2005 12:59:48 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Roger Brunell <rog_brunell@yahoo.com>
Subject: Re: Useradd patchset - seeking comments..
Date: Tue, 12 Jul 2005 23:00:25 +1000
Cc: selinux@tycho.nsa.gov
References: <20050707121927.21316.qmail@web33203.mail.mud.yahoo.com>
In-Reply-To: <20050707121927.21316.qmail@web33203.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200507122300.29249.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 07 July 2005 22:19, Roger Brunell <rog_brunell@yahoo.com> wrote:
>   Please be sure that anything in libselinux is general enough to work in
> ALL the distros. Currently each new Debian user has to figure out what
> /etc/default/useradd is; why it would be there; and what format it needs to
> have. That is a RHism. As a script, at least, each Debian explorer can
> track down the script, and have a chance of figuring it out.

That's because Manoj missed one of my patches when taking over the Debian 
package in question.  It should be fixed now.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
