Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5OMqLgA011379
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 18:52:21 -0400 (EDT)
Received: from web31614.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id j5OMph2B017230
	for <selinux@tycho.nsa.gov>; Fri, 24 Jun 2005 22:51:43 GMT
Message-ID: <20050624225217.97028.qmail@web31614.mail.mud.yahoo.com>
Date: Fri, 24 Jun 2005 15:52:16 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Alternative user management approach 
To: selinux@tycho.nsa.gov
In-Reply-To: <200506242211.j5OMBUA5012667@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



--- Valdis.Kletnieks@vt.edu wrote:


> And for the most part, yes DAC is sufficient - but
> there's a few things I'd
> like to apply at the MAC level using constraints. 
> I'd much rather have one
> user_u with 20-30 locally added ($u1 != $u2)
> constraints than have to drag
> around user1_u..user1000_u with corresponding
> ruleset explosion....

I'm probably missing something, but it looks to
me like the user seperation issue is handled quite
nicely by a well implemented B&L category set.
There are may places using MLS systems in that 
way today.



Casey Schaufler
casey@schaufler-ca.com


		
____________________________________________________ 
Yahoo! Sports 
Rekindle the Rivalries. Sign up for Fantasy Football 
http://football.fantasysports.yahoo.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
