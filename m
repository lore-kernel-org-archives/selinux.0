Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9RFGrmR007465
	for <selinux@tycho.nsa.gov>; Fri, 27 Oct 2006 11:16:53 -0400
Subject: Re: User object manager context location
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B015885145F7@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B015885145F7@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 11:16:10 -0400
Message-Id: <1161962170.27616.16.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-10-27 at 10:02 -0400, Joshua Brindle wrote:
> We've brought up the idea of a generic section in policy packages for
> this sort of thing but I'm not sure if this is appropriate, once again
> because there will basically be random files with random formats in an
> selinux directory, these should probably be considered configuration
> files for the object manager and not selinux but I'm not sure, the issue
> feels very fuzzy. Chris disagrees with me adamently and believes the
> files should go into the contexts directory and be included in policy
> packages, I'm very unsure of this though.
> 

D-Bus has its object labeling file in the contexts directory, so there
is precedence for putting the files there.  I think that it is important
that these files be kept with the rest of the policy.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
