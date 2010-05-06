Subject: Re: [PATCH -v3] SELinux: special dontaudit for access checks
From: Eric Paris <eparis@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
In-Reply-To: <alpine.LRH.2.00.1005061000280.22641@tundra.namei.org>
References: <20100503222931.9662.9780.stgit@paris.rdu.redhat.com>
	 <alpine.LRH.2.00.1005050849140.12883@tundra.namei.org>
	 <1273068506.15368.31.camel@localhost>
	 <alpine.LRH.2.00.1005061000280.22641@tundra.namei.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 06 May 2010 17:23:50 -0400
Message-ID: <1273181030.15368.180.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-05-06 at 10:03 +1000, James Morris wrote:
> On Wed, 5 May 2010, Eric Paris wrote:
> 
> > On Wed, 2010-05-05 at 08:50 +1000, James Morris wrote:
> > > On Mon, 3 May 2010, Eric Paris wrote:
> > > 
> > > > Signed-off-by: Eric Paris <eparis@redhat.com>
> > > > ---
> > > 
> > > This does not apply to my tree, please fix.
> > 
> > Patches sent should be applied in this order:
> > 
> > re-introduce MAY_ACCESS
> > http://marc.info/?l=linux-fsdevel&m=127085147411199&w=2
> 
> This changes filesystem code (e.g. logic in NFS), but has no comments or 
> signoff from fs/vfs folk, as I indicated to you off-list.  Do you think 
> it's ok to go in anyway?

It changes NO logic, just breaks one flag into 2.  If it does change any
logic the patch is busted!  So yes I believe it is perfectly safe to go
in.  I, however, poked Al again (about the 3rd time) just in case he has
a better suggestion.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
