Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0JFeUXf003671
	for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2006 10:40:30 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0JFeOh0024360
	for <selinux@tycho.nsa.gov>; Thu, 19 Jan 2006 15:40:27 GMT
Subject: Re: dropping pppd_script_exec_t
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: russell@coker.com.au
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <200601200039.38070.russell@coker.com.au>
References: <1137083967.29815.205.camel@sgc.columbia.tresys.com>
	 <200601200039.38070.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 10:41:53 -0500
Message-Id: <1137685313.29815.374.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-01-20 at 00:39 +1100, Russell Coker wrote:
> On Friday 13 January 2006 03:39, "Christopher J. PeBenito" 
> <cpebenito@tresys.com> wrote:
> > In the ppp module there is a type pppd_script_exec_t and its only used
> > in one rule:
> >
> > domain_auto_trans(pppd_t, pppd_script_exec_t, initrc_t)
> >
> > Looking at the actual scripts, they seem similar to regular init scripts
> > for configuring network devices.  Since the scripts transition to
> > initrc_t already, it seems like they should instead be labeled
> > initrc_exec_t and the regular interface call for transitioning to initrc
> > can be used.  Then pppd_script_exec_t would be dropped (made an alias of
> > initrc_exec_t for compatibility).  Is there any problem with doing this?
> 
> The only problem is that escape from the pppd_t domain is possible via any of 
> the initrc_exec_t scripts (of which there are many) instead of merely the 
> pppd_script_exec_t (of which there will be few if any).

Following this logic, it would be better to make a new domain that can
do only the few network configuration things that pppd scripts need to
do.  I think this is a better idea, then you can't "escape" to the
highly privileged initrc_t at all.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
