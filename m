Subject: Re: [GIT] security / creds fixes
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>, James Morris <jmorris@namei.org>,
        selinux@tycho.nsa.gov
In-Reply-To: <1253122492.5213.137.camel@dhcp231-106.rdu.redhat.com>
References: <20090914162613.9016.79225.stgit@warthog.procyon.org.uk>
	 <alpine.LRH.2.00.0909151008440.11936@tundra.namei.org>
	 <20090916130224.GA27519@elte.hu>
	 <1253122492.5213.137.camel@dhcp231-106.rdu.redhat.com>
Content-Type: text/plain
Date: Wed, 16 Sep 2009 15:03:49 -0400
Message-Id: <1253127829.18198.123.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-09-16 at 13:34 -0400, Eric Paris wrote:
> On Wed, 2009-09-16 at 15:02 +0200, Ingo Molnar wrote:
> > i'm still getting crashes even with latest -git [0cb583f]:
> > 
> > 
> > EXT3-fs: mounted filesystem with ordered data mode.
> > VFS: Mounted root (ext3 filesystem) readonly on device 8:6.
> > async_waiting @ 1
> > async_continuing @ 1 after 0 usec
> > debug: unmapping init memory ffffffff81f1e000..ffffffff81fb1000
> > SELinux:  Disabled at runtime.
> > BUG: unable to handle kernel NULL pointer dereference at (null)
> > IP: [<ffffffff81122537>] kmem_cache_alloc+0x9a/0x185
> 
> sds, I'm not quite sure how to fix this, maybe you have some ideas?
> 
> One problem is that avc_disable() (which frees everything in the AVC and
> then kmem_cache_destroy() the avc_node_cachep) is done before we do the
> security_ops = secondary_ops call.  So other tasks could still call
> selinux_ functions after the avc_node_cachep is free.  Fixing that
> ordering would likely take care of most of the problems but it's not
> complete.  We have no idea if anything is already passed the
> security_ops->function() call and is just waiting to explode as soon as
> the avc_node_cachep is freed.  Any ideas how we can be sure that
> everything is out of selinux code so we can finish the free safely?

What if we call synchronize_rcu() before freeing it?

Was it really worth it to free the AVC upon runtime disable in the first
place?  If they were really worried about the memory, they can always
boot with selinux=0.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
