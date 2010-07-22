Date: Fri, 23 Jul 2010 09:21:26 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH -v3] SELinux: special dontaudit for access checks
In-Reply-To: <1273068506.15368.31.camel@localhost>
Message-ID: <alpine.LRH.2.00.1007230920310.11913@tundra.namei.org>
References: <20100503222931.9662.9780.stgit@paris.rdu.redhat.com>  <alpine.LRH.2.00.1005050849140.12883@tundra.namei.org> <1273068506.15368.31.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 5 May 2010, Eric Paris wrote:

> On Wed, 2010-05-05 at 08:50 +1000, James Morris wrote:
> > On Mon, 3 May 2010, Eric Paris wrote:
> > 
> > > Signed-off-by: Eric Paris <eparis@redhat.com>
> > > ---
> > 
> > This does not apply to my tree, please fix.
> 
> Patches sent should be applied in this order:
> 
> re-introduce MAY_ACCESS
> http://marc.info/?l=linux-fsdevel&m=127085147411199&w=2
> 
> LSM explicit masking
> http://marc.info/?l=linux-fsdevel&m=127085147211188&w=2
> 
> SELinux audit_access
> http://marc.info/?l=selinux&m=127292585028408&w=2
> 
> open in common perms
> http://marc.info/?l=selinux&m=127111467103490&w=2
> 
> execmod in common perms
> http://marc.info/?l=selinux&m=127111467103486&w=2
> 
> If you prefer I can send them all again as a series or as a single mbox.
> Or you can just apply them in the correct order....

I'm getting:

security/selinux/hooks.c: In function selinux_inode_permission:
security/selinux/hooks.c:2662: error: FILE__AUDIT_ACCESS undeclared (first 
use in this function)

Looks like av_permissions.h is not being built.   Can you resend all this 
as a patchset against my current tree ?



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
