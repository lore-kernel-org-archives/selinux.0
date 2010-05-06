Date: Thu, 6 May 2010 10:03:24 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [PATCH -v3] SELinux: special dontaudit for access checks
In-Reply-To: <1273068506.15368.31.camel@localhost>
Message-ID: <alpine.LRH.2.00.1005061000280.22641@tundra.namei.org>
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

This changes filesystem code (e.g. logic in NFS), but has no comments or 
signoff from fs/vfs folk, as I indicated to you off-list.  Do you think 
it's ok to go in anyway?


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
