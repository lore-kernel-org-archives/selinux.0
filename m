Date: Sun, 9 Nov 2008 10:41:18 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] SELinux: Use unknown perm handling to handle unknown
 netlink msg types
In-Reply-To: <1226074293.16320.70.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <alpine.LRH.1.10.0811091040530.24870@tundra.namei.org>
References: <1225895682.3300.111.camel@localhost.localdomain> <1226074293.16320.70.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 7 Nov 2008, Stephen Smalley wrote:

> On Wed, 2008-11-05 at 09:34 -0500, Eric Paris wrote:
> > Currently when SELinux has not been updated to handle a netlink message
> > type the operation is denied with EINVAL.  This patch will leave the
> > audit/warning message so things get fixed but if policy chose to allow
> > unknowns this will allow the netlink operation.
> > 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> 
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
