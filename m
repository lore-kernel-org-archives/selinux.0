Subject: Re: [PATCH] selinux:  drop remapping of netlink classes
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@namei.org>,
        Eric Paris <eparis@parisplace.org>, Paul Moore <paul.moore@hp.com>
In-Reply-To: <1254422903.30591.123.camel@moss-pluto.epoch.ncsc.mil>
References: <1254422903.30591.123.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 01 Oct 2009 15:05:26 -0400
Message-Id: <1254423926.2952.8.camel@dhcp231-106.rdu.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-10-01 at 14:48 -0400, Stephen Smalley wrote:
> Drop remapping of netlink classes and bypass of permission checking
> based on netlink message type for policy version < 18.  This removes
> compatibility code introduced when the original single netlink
> security class used for all netlink sockets was split into
> finer-grained netlink classes based on netlink protocol and when
> permission checking was added based on netlink message type in Linux
> 2.6.8.  The only known distribution that shipped with SELinux and
> policy < 18 was Fedora Core 2, which was EOL'd on 2005-04-11.
> 
> Given that the remapping code was never updated to address the
> addition of newer netlink classes, that the corresponding userland
> support was dropped in 2005, and that the assumptions made by the
> remapping code about the fixed ordering among netlink classes in the
> policy may be violated in the future due to the dynamic class/perm
> discovery support, we should drop this compatibility code now.

Shouldn't we reject the load of such a policy as well?  No reason to
leave them with a false sense of working....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
