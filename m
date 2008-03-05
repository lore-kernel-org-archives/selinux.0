Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m25G871R023643
	for <selinux@tycho.nsa.gov>; Wed, 5 Mar 2008 11:08:07 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m25G87UA006903
	for <selinux@tycho.nsa.gov>; Wed, 5 Mar 2008 16:08:07 GMT
Subject: Re: Unreserved portnumbers in corenetwork
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: selinux@a61.nl
Cc: selinux@tycho.nsa.gov
In-Reply-To: <51324.80.95.164.250.1204732077.squirrel@www.a61.nl>
References: <37866.80.95.164.250.1204712494.squirrel@www.a61.nl>
	 <1204730645.14217.39.camel@gorn>
	 <51324.80.95.164.250.1204732077.squirrel@www.a61.nl>
Content-Type: text/plain
Date: Wed, 05 Mar 2008 11:05:23 -0500
Message-Id: <1204733123.14217.48.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-03-05 at 16:47 +0100, selinux@a61.nl wrote:
> > Unfortunately there are 3 forces at work.  The first is that for the
> > most part, ports should always be labeled, because, for example, port 80
> > is always going to be regarded as the http port.  The second is that
> > thats not always the case for non well-defined ports (your situation).
> > The third is that portcons (the port labeling statements) only work in
> > the base module.  So, though we want to make a happy medium between the
> > first two, we can't overcome the final one within the constraints of the
> > current toolchain.
> >
> 
> Agree with that. But wouldn't the situation be a little less complicated
> if you decide not to define any ports above 1024 in the reference policy?

That breaks people that just want to use reference policy.

> If you decide to do that, you could create a portcon that allows a single
> active module to claim a port above 1024 on a per module basis. A second
> module could claim another one, as long as it's not equal to the first
> (active) one.
> 
> In this way you create a generic handler for modules that need ports above
> 1024 and can create a reference policy with modules with the same ports.
> As long as they are not both active, you wouldn't have any problem.

If I understand what your suggesting, then I don't see how thats
implementable with the current toolchain.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
