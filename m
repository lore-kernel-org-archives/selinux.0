Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0GIabRb011309
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2004 13:36:38 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0GIZRxr014408
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2004 18:35:27 GMT
Received: from mail.idtweb.com (mail.idtweb.com [63.140.241.100])
	by jazzswing.ncsc.mil  with ESMTP id i0GIZQYc014402
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2004 18:35:26 GMT
Subject: Re: specifying groups of types
From: Karl MacMillan <kmacmillan@tresys.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Dave Caplan <dac@tresys.com>, Chris PeBenito <pebenito@gentoo.org>,
   Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1074277054.24719.113.camel@moss-spartans.epoch.ncsc.mil>
References: <200310111435.46684.russell@coker.com.au>
	 <1066134168.5054.11.camel@moss-spartans.epoch.ncsc.mil>
	 <3F8C46E4.1030403@tresys.com>
	 <1074177115.17320.32.camel@moss-spartans.epoch.ncsc.mil>
	 <1074271807.23661.119.camel@colossus.columbia.tresys.com>
	 <1074277054.24719.113.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1074278194.23661.134.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Fri, 16 Jan 2004 13:36:35 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-01-16 at 13:17, Stephen Smalley wrote:
> On Fri, 2004-01-16 at 11:50, Karl MacMillan wrote:
> > I'm not certain that we want these to be order dependent. I can imagine
> > a policy writer doing
> > 
> > allow { attr_a -sysadm_t attr_b} . . . 
> > 
> > and being surprised that sysadm_t was allowed because it was in attr_b.
> 
> So, you want something like the attached (untested) patch?
> Still wouldn't prevent one allow rule from adding back a
> type excluded by another allow rule...

Exactly. I don't think that we want to prevent other rules from adding
back the type, just consider the list of types within a rule as a whole.
The patch looks correct to me at first glance, but I didn't test it
either. After testing, will this change go in? I'm working on supporting
this in our tools and need to know the final semantics.

Thanks,

Karl

-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com
(410) 290-1411 x134


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
