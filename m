Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i98I0TrT024011
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 14:00:29 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i98I0SZ2014251
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 18:00:28 GMT
Subject: Re: gentoo diff for ntpd
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: Russell Coker <russell@coker.com.au>
Cc: petre rodan <kaiowas@gentoo.org>, Joshua Brindle <method@gentoo.org>,
   SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <200410071702.33618.russell@coker.com.au>
References: <41625A62.7080609@gentoo.org> <41629E45.8050107@gentoo.org>
	 <4163CDD3.3@gentoo.org>  <200410071702.33618.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1097258354.13326.7.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 08 Oct 2004 13:59:14 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Thu, 2004-10-07 at 03:02, Russell Coker wrote:
> On Wed, 6 Oct 2004 20:49, petre rodan <kaiowas@gentoo.org> wrote:
> > this is a new diff with distro_gentoo ifdefs dropped.
> > also, logrotate is not part of the gentoo base-policy and it shouldn't be a
> > dependency for ntpd, so I'm also ifdef-ing that.
> 
> Having daemon binaries in /usr/bin instead of /usr/sbin is a bug.
> 
> ntpd and ntpdate can not be used by regular users, they can only be used by 
> the administrator.  Therefore any distribution that follows the LSB (or the 
> FHS which the LSB is based on) will put them in /usr/sbin.  Here is the 
> relevant section of the FHS:
> 
> 4.6 /usr/sbin : Non-essential standard system binaries
> 
> This directory contains any non-essential binaries used exclusively by the
> system administrator. System administration programs that are required for
> system repair, system recovery, mounting /usr, or other essential functions
> should be placed in /sbin instead.
> 
> 
> Those .fc entries for /usr/bin can go in under ifdef(`distro_gentoo' if Gentoo 
> does not follow the FHS.  Otherwise it's best to file a bug in the Gentoo bug 
> system requesting that the files be moved.
> 
> I've attached a patch which has the changes I think belong in the CVS at this 
> time.  Note that I changed the order of the capabilities so that they match 
> the order of capability.h .
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
