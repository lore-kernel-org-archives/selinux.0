Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l43Cgcsj018326
	for <selinux@tycho.nsa.gov>; Thu, 3 May 2007 08:42:38 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l43Cgbqf023932
	for <selinux@tycho.nsa.gov>; Thu, 3 May 2007 12:42:37 GMT
Subject: Re: Where to specific the handling of unknown kernel classes and
	perms
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Joshua Brindle <method@manicmethod.com>
Cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov
In-Reply-To: <463930F3.7020803@manicmethod.com>
References: <1178141128.3897.33.camel@dhcp59-235.rdu.redhat.com>
	 <463930F3.7020803@manicmethod.com>
Content-Type: text/plain
Date: Thu, 03 May 2007 08:42:34 -0400
Message-Id: <1178196154.3404.6.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-02 at 20:46 -0400, Joshua Brindle wrote:
> Eric Paris wrote:
> > I just sent out a kernel patch with the tristate flag to change kernel
> > handling of unknown classes and permissions.  The idea is that when the
> > policy is created someone can set the flag to any of the three options
> > (deny/reject/allow) and the kernel will act accordingly.  My problem is
> > I don't understand the userspace tools which create policy.  I patched
> > libsepol to support this new flag when it reads or writes a policydb,
> > which allows me to edit my policy.21 by hand in hex and then call
> > load_policy to test my kernel.  My problem now is that I don't know
> > where a user should be specifying how they want the flags to be set.  To
> > be perfectly honest after a bit of searching I'm not even sure where
> > policy.21 gets created when I build a policy.
> >
> >   
> It should be setable in semanage.conf or by checkpolicy if building a 
> monolithic policy.
> 

The other option, I guess, is to set the flag on the base module and
have that propagated to the kernel policy.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
