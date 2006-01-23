Subject: Re: [PATCH] libsemanage/semanage - permission check for semanage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, SELinux List <SELinux@tycho.nsa.gov>,
   selinuxdev <selinux-dev@tresys.com>
In-Reply-To: <43D1553B.3090701@tresys.com>
References: <1137707155.17672.2.camel@twoface.columbia.tresys.com>
	 <1137770413.3648.140.camel@moss-spartans.epoch.ncsc.mil>
	 <1137784500.31152.6.camel@twoface.columbia.tresys.com>
	 <1137790181.3648.250.camel@moss-spartans.epoch.ncsc.mil>
	 <43D1553B.3090701@tresys.com>
Content-Type: text/plain
Date: Mon, 23 Jan 2006 09:36:15 -0500
Message-Id: <1138026975.20815.62.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-01-20 at 16:25 -0500, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > Better, but a few lingering issues/questions:
> > 1) Running semanage as a non-root user with existing default modes on
> > the policy module tree yields "SELinux policy is not managed."
> > So we aren't quite providing the right information to the user yet.
> >
> if the user can't stat the module directory how do we know whether or 
> not it is a managed system?

Understood, but the message to the user needs to convey that fact, i.e.
instead of just saying "SELinux policy is not managed", we likely need
to say "SELinux policy is not managed or the module store is not
accessible to you."  

We also need to make sure that setsebool continues to do the right thing
here, as it uses semanage_is_managed() to decide whether it should a)
abort with an error (if < 0), b) fall back to the libselinux support for
setting booleans (== 0), or proceed to use the semanage functions for
setting booleans (> 0).  It looks like this patch is fine in that
respect since it doesn't change that interface; it should just silence
the warning we get from libsemanage in (b).  

Trying setsebool as a normal user I get "Could not change active
booleans:  Permission denied", which seems like a reasonable error
message for that case.  Only potential concern is that what is really
happening there is that setsebool is falling back to case (b) and trying
to directly manipulate booleans via libselinux, and it is only the lack
of permission to do so that prevents it from proceeding.  So if the
caller lacked permission to access the module store but had permission
to directly manipulate booleans (a pathological situation indeed), then
setsebool could do the wrong thing here.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
