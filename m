Date: Sun, 23 Sep 2007 16:15:43 -0700 (PDT)
From: James Morris <jmorris@namei.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
cc: Eric Paris <eparis@redhat.com>, selinux@tycho.nsa.gov,
        ewalsh@tycho.nsa.gov, sgrubb@redhat.com
Subject: Re: [PATCH -v4] kernel: selinux: policy selectable handling of
 unknown classes and perms
In-Reply-To: <1190405732.17518.172.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.64.0709231615220.22240@us.intercode.com.au>
References: <1190399830.3451.145.camel@localhost.localdomain>
 <1190405732.17518.172.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 21 Sep 2007, Stephen Smalley wrote:

> On Fri, 2007-09-21 at 14:37 -0400, Eric Paris wrote:
> > Allow policy to select, in much the same way as it selects MLS support,
> > how the kernel should handle access decisions which contain either
> > unknown classes or unknown permissions in known classes.  The three
> > choices for the policy flags are
> > 
> > 0 - Deny unknown security access. (default)
> > 2 - reject loading policy if it does not contain all definitions
> > 4 - allow unknown security access
> > 
> > The policy's choice is exported through 2 booleans in
> > selinuxfs.  /selinux/deny_unknown and /selinux/reject_unknown. 
> > 
> > Signed-off-by: Eric Paris <eparis@redhat.com>
> 
> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
> 

Applied to
git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/selinux-2.6.git#for-akpm


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
