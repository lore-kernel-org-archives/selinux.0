Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0CHegIi017302
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 12:40:43 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0CHejgF027179
	for <selinux@tycho.nsa.gov>; Wed, 12 Jan 2005 17:40:45 GMT
Subject: Re: kernel error
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1105548548.22495.131.camel@moss-spartans.epoch.ncsc.mil>
References: <200501102205.36386.russell@coker.com.au>
	 <1105548548.22495.131.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1105551280.22495.148.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 12 Jan 2005 12:34:40 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-01-12 at 11:49, Stephen Smalley wrote:
> On Mon, 2005-01-10 at 06:05, Russell Coker wrote:
> > I am getting the attached kernel error repeatedly when trying to install a new 
> > kernel package on a Debian 2.6.10 system (stock kernel.org kernel with no 
> > patches).  This error happens in enforcing mode but not in permissive mode.
> 
> Looks like it might be triggered by a revocation of the controlling
> tty.  If you do a make enableaudit load and then try it again, do you
> see any relevant audit messages for the controlling tty?

The patch that introduced this kernel error message can be found at
http://marc.theaimsgroup.com/?l=linux-kernel&m=109838483518162&w=2
You might want to follow up on lkml as well.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
