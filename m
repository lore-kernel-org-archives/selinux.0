Subject: Re: [PATCH] selinux:  drop remapping of netlink classes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>, Paul Moore <paul.moore@hp.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        James Carter <jwcart2@epoch.ncsc.mil>
In-Reply-To: <1254423926.2952.8.camel@dhcp231-106.rdu.redhat.com>
References: <1254422903.30591.123.camel@moss-pluto.epoch.ncsc.mil>
	 <1254423926.2952.8.camel@dhcp231-106.rdu.redhat.com>
Content-Type: text/plain
Date: Fri, 02 Oct 2009 08:26:32 -0400
Message-Id: <1254486392.30591.285.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-10-01 at 15:05 -0400, Eric Paris wrote:
> On Thu, 2009-10-01 at 14:48 -0400, Stephen Smalley wrote:
> > Drop remapping of netlink classes and bypass of permission checking
> > based on netlink message type for policy version < 18.  This removes
> > compatibility code introduced when the original single netlink
> > security class used for all netlink sockets was split into
> > finer-grained netlink classes based on netlink protocol and when
> > permission checking was added based on netlink message type in Linux
> > 2.6.8.  The only known distribution that shipped with SELinux and
> > policy < 18 was Fedora Core 2, which was EOL'd on 2005-04-11.
> > 
> > Given that the remapping code was never updated to address the
> > addition of newer netlink classes, that the corresponding userland
> > support was dropped in 2005, and that the assumptions made by the
> > remapping code about the fixed ordering among netlink classes in the
> > policy may be violated in the future due to the dynamic class/perm
> > discovery support, we should drop this compatibility code now.
> 
> Shouldn't we reject the load of such a policy as well?  No reason to
> leave them with a false sense of working....

That seems worse - at that point we're explicitly dropping all
compatibility with policy < 18 and requiring the user to upgrade his
SELinux userspace and recompile his policy to a newer policy version if
he wants to use a newer kernel.

Contrast that with loading policies < 18, booting up at least minimally
(e.g. single-user boot should be fine), and only failing all netlink
socket operations.  The user could at that point add definitions and
allow rules for the fine-grained netlink classes to his existing policy
and recompile that policy with his existing checkpolicy, without needing
to update his userspace.

Either way I suppose we are technically in violation of the "new kernels
must not break existing userspace" rule, although the latter seems
slightly more compatible to me (no need to upgrade their checkpolicy,
just modify their policy sources and recompile it).

Alternatively, we could just leave the compat code as is (i.e. not apply
this patch).  It just seemed like an opportunity to remove some legacy
cruft from long ago.  The only situation where the compat code will in
fact cause us a problem is if we allow arbitrary ordering of classes in
the policy (moving class definitions into modules and not imposing any
fixed ordering); at that point we'd have to replace the netlink class
range comparisons with an explicit enumeration of the individual netlink
classes.  That won't be possible though until the dynamic class/perm
discovery support is mainlined and all userspace code that uses fixed
class and permission values is updated, which will take a while.  And
even then, we still need to be able to build policies that will work on
older kernels and userspace, so some way of imposing an ordering will be
required for a long time.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
