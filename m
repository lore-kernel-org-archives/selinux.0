Subject: Re: mkdir avc
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1158948389.7748.240.camel@moss-spartans.epoch.ncsc.mil>
References: <20060922175743.5272.qmail@web51510.mail.yahoo.com>
	 <1158948389.7748.240.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 14:15:39 -0400
Message-Id: <1158948939.7748.243.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-22 at 14:06 -0400, Stephen Smalley wrote:
> On Fri, 2006-09-22 at 10:57 -0700, Steve G wrote:
> > >I would have expected the syscall audit record to have captured the path, but am
> > >not seeing it now either (but do see it in older audit logs).  Regression in the
> > >audit code?
> > 
> > Could be...that's why I'm asking. I wanted to get confirmation that one or the
> > other should be there. When you audit the mkdir syscall, a path record is there.
> > But in the case of the avc, its not.
> 
> Related to the optimization for no audit filters (suppressing collection
> of path in that case)?

Ok, tried adding and removing a simple audit filter on execve (i.e.
anything but mkdir), and it changed the behavior.  With the filter, a
PATH record was generated; without it, it was not generated.  So as long
as you have some audit filter defined, you should get the PATH data for
the avc denial.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
