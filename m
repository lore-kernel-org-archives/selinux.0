Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j05GpDIi003239
	for <selinux@tycho.nsa.gov>; Wed, 5 Jan 2005 11:51:13 -0500 (EST)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j05GnKFH009679
	for <selinux@tycho.nsa.gov>; Wed, 5 Jan 2005 16:49:20 GMT
Subject: Re: gentoo diff for arpwatch
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: petre rodan <kaiowas@gentoo.org>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200412251818.54944.russell@coker.com.au>
References: <4198D07B.6070401@gentoo.org>
	 <1100893653.31793.25.camel@moss-lions.epoch.ncsc.mil>
	 <200412251818.54944.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1104944000.1511.19.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 05 Jan 2005 11:53:20 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ok.  Merged.

On Sat, 2004-12-25 at 02:18, Russell Coker wrote:
> On Saturday 20 November 2004 06:47, James Carter <jwcart2@epoch.ncsc.mil> 
> wrote:
> > I moved the following rules and put an "ifdef(`arpwatch.te'" around
> > them:
> > "allow system_mail_t" rules to mta.te
> > "allow qmail_inject_t" rules to qmail.te
> > "allow allow postfix_local_t" rule to postfix.te
> 
> This is not what we want.  Below I have pasted some text from 
> http://www.coker.com.au/selinux/talks/ibmtu-2004/linux21.ppt describing the 
> MTA policy (it's not great but it's the best description of MTA policy).
> 
> I have attached a patch that makes some changes to make it work with the 
> design of the mta policy.  This makes it work with Postfix, Qmail, Sendmail, 
> and any other mta that might be used.  The idea is that you don't have to 
> write policy for every combination of program that sends mail and mta, this 
> doesn't scale well as the number of supported mta's increases.

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
