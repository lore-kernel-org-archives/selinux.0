Date: Fri, 31 Oct 2008 02:24:24 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] SELinux: check open perms in dentry_open not
 inode_permission
In-Reply-To: <1225377084.13709.9.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <alpine.LRH.1.10.0810310222410.8775@tundra.namei.org>
References: <20081029210646.14332.52199.stgit@paris.rdu.redhat.com> <1225377084.13709.9.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 30 Oct 2008, Stephen Smalley wrote:

> On Wed, 2008-10-29 at 17:06 -0400, Eric Paris wrote:
> > Some operations, like searching a directory path or connecting a unix domain
> > socket, make explicit calls into inode_permission.  Our choices are to
> > either try to come up with a signature for all of the explicit calls to
> > inode_permission and do not check open on those, or to move the open checks to
> > dentry_open where we know this is always an open operation.  This patch moves
> > the checks to dentry_open.
> > 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> 
> Thanks, mea culpa - the original RFC patch for open permission put it
> into dentry_open but I (wrongly) recommended taking it to
> inode_permission at the time.
> 
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

Applied to 
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/security-testing-2.6#next

If you want this in 2.6.28, it needs to qualify as a bugfix for an issue 
affecting real users.  Thoughts?


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
