Subject: Re: RBAC with SELinux MCS
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Shaz <shazalive@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <7b740b700906302215n2a6eb4f3y8e2e15419af33191@mail.gmail.com>
References: <7b740b700906302215n2a6eb4f3y8e2e15419af33191@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 01 Jul 2009 10:03:53 -0400
Message-Id: <1246457033.13464.158.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-07-01 at 11:15 +0600, Shaz wrote:
> Dear list,
> 
> I was studying some earlier work on RBAC and came across Kuhn98 [1],
> which says that RBAC can be implemented if some interface function is
> used to map privilege sets of RBAC with MCS. James Moris blog article
> on MCS [2] states that MCS is just dicretionary like DAC if
> hierarchies like of MLS levels are not used. It might be because of
> the implementation of current LSPP on Linux distros. So my question is
> that can RBAC be used with SELinux if the mapping function is
> provided?
> 
> Some further literature or existing work being pointed out will be
> appreciated.
> 
> Thank you.
> 
> [1]
> http://csrc.nist.gov/groups/SNS/rbac/documents/design_implementation/kuhn-98.pdf
> [2] http://james-morris.livejournal.com/5583.html

SELinux implements its own RBAC model, described here:
http://www.nsa.gov/research/_files/selinux/papers/policy2/x86.shtml

By coupling RBAC with TE (which is a mandatory scheme), we can directly
bind roles to processes and enforce RBAC restrictions at the operating
system level.  We also address some of the limitations of traditional
RBAC through TE.

RBAC and MCS don't have anything to do with each other.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
