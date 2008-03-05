Subject: Re: Unreserved portnumbers in corenetwork
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@a61.nl, selinux@tycho.nsa.gov
In-Reply-To: <1204730645.14217.39.camel@gorn>
References: <37866.80.95.164.250.1204712494.squirrel@www.a61.nl>
	 <1204730645.14217.39.camel@gorn>
Content-Type: text/plain
Date: Wed, 05 Mar 2008 10:51:54 -0500
Message-Id: <1204732314.1397.58.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-03-05 at 10:24 -0500, Christopher J. PeBenito wrote:
> On Wed, 2008-03-05 at 11:21 +0100, selinux@a61.nl wrote:
> > We're building a policy for JBoss. Jboss uses atleast port 8080 and 8083.
> > Besides this, the application we use on JBoss also opens port 8443 (https)
> > 
> > While building the jboss-module we ofcourse want to claim these ports and
> > patch corenetwork. However, this is where our problem arises; HTTP has
> > claimed some of the ports we need and http-cache has claimed 8080
> > allready.
> > 
> > But http and http-cache allow to open more ports (80, 443, 488, 8008,
> > 8009) than we really need. We think this is against the SElinux policy of
> > least privilege.
> > 
> > So how do we deal with these kinds of port conflicts? Maybe corenetwork
> > isn't the best place to define unreserved (> 1024) ports?
> 
> Unfortunately there are 3 forces at work.  The first is that for the
> most part, ports should always be labeled, because, for example, port 80
> is always going to be regarded as the http port.  The second is that
> thats not always the case for non well-defined ports (your situation).
> The third is that portcons (the port labeling statements) only work in
> the base module.  So, though we want to make a happy medium between the
> first two, we can't overcome the final one within the constraints of the
> current toolchain.

Perhaps all port context definitions should be moved to being handled
via semanage port?  Doesn't brickwall do something similar?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
