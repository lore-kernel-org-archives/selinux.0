From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Starting applications from initrc in a user's context?
Date: Thu, 13 Jan 2005 06:47:49 +1100
Cc: mike@theptrgroup.com, SElinux <SELinux@tycho.nsa.gov>
References: <41CAE132.3020504@theptrgroup.com> <200501042103.15885.russell@coker.com.au> <1105548854.22495.136.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1105548854.22495.136.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200501130647.49842.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday 13 January 2005 03:54, Stephen Smalley <sds@epoch.ncsc.mil> wrote:
> On Tue, 2005-01-04 at 05:03, Russell Coker wrote:
> > Allowing the role to be changed requires adding privrole to the
> > attributes of domain initrc_t.  In that case either the identity system_u
> > must be permitted to have the role user1_r or initrc_t also needs the
> > privuser attribute so it can launch a process with a different identity.
>
> Role changes also require a role allow rule, e.g.
> allow foo_r bar_r;

True, but that should already be allowed.  Init scripts run as 
system_u:system_r:initrc_t, and system_r is already allowed to change to 
every role.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
