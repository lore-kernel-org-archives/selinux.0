Date: Wed, 29 Jun 2005 13:35:50 -0500
From: serue@us.ibm.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: linux-security-module@wirex.com, SELinux <selinux@tycho.nsa.gov>
Subject: Re: RFC: jail functionality
Message-ID: <20050629183550.GB19299@serge.austin.ibm.com>
References: <20050629161409.GB16233@serge.austin.ibm.com> <1120062900.3553.151.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1120062900.3553.151.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Stephen Smalley (sds@tycho.nsa.gov):
> On Wed, 2005-06-29 at 11:14 -0500, serue@us.ibm.com wrote:
> > Attached are the old task_lookup patch which was used by the bsdjail lsm,
> > a patch for selinux to utilize this hook, and a sample jail policy and
> > .fc, which presumably would eventually be changed to a jail_domain()
> > policy macro.  Does this seem at all useful by itself, or should this
> > wait until it were actually needed for a complete linux jails
> > implementation?
> 
> What's the real benefit of "hiding" tasks in this manner?

In terms of security, I'd say none, except perhaps a hard-to-exploit
covert channel.  IMO, it would only be for user convenience.

> SELinux can
> already prevent processes from accessing anything under /proc/pid for a
> process in another domain, and procps already conveniently omits entries
> for any such inaccessible /proc/pid directories, so the typical user
> experience is the same (i.e. users won't see processes that are
> inaccessible in ps output) and at most, only the pids are exposed
> in /proc.  

I didn't think procps did that.  In that case, I guess tasklookup can
be taken off the list of jail requisites.

> > Is there any interest in seeing the virtual network devices and
> > network namespaces pushed upstream?
> 
> Yes, although I can't say that I've looked at their approach.

Ok - so long as there is interest, I will try to take some time to
write a standalone patch for it.  Then hopefully if their approach
or my port of it is not acceptable, someone else will code up an
acceptable version :)

> > Read-only bind mounts?
> 
> Not sure what happened to earlier discussions and patches related to
> that issue on lkml.

Christoph Hellwig said he wants it, but wanted a different
implementation, but hasn't had a chance to write up his own.  The author
of the existing patches feels there's not enough support/interest and
too much opposition, so has not resubmitted (after I believe his 6th
version).

> > The attached task-lookup patches?
> 
> Not sure it provides much value.

Sounds good.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
