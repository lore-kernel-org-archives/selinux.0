Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j03L1PIi019995
	for <selinux@tycho.nsa.gov>; Mon, 3 Jan 2005 16:01:25 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j03KxXFS023861
	for <selinux@tycho.nsa.gov>; Mon, 3 Jan 2005 20:59:33 GMT
Subject: Re: cpuspeed and powernow
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: SELinux <selinux@tycho.nsa.gov>, Thomas Bleher <ThomasBleher@gmx.de>
In-Reply-To: <200412240058.56587.russell@coker.com.au>
References: <200412240058.56587.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1104786196.14157.4.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 03 Jan 2005 16:03:16 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.  I also removed the powernowd policy from CVS.

On Thu, 2004-12-23 at 08:58, Russell Coker wrote:
> I don't believe that we need separate policies for cpuspeed and powernow.  
> They both perform the same function but for different CPUs so there is no 
> possibility of them both running at the same time (AFAIK) and therefore no 
> benefit in having separate domains.
> 
> I have attached a patch that adds the appropriate functionality to cpuspeed.te 
> and cpuspeed.fc.  James please add this patch and remove powernowd.te and 
> powernowd.fc.
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
