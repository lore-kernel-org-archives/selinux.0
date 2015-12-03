Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tB3Fox0V014865
 for <selinux@tycho.nsa.gov>; Thu, 3 Dec 2015 10:50:59 -0500
From: Paul Moore <pmoore@redhat.com>
To: Brian Foster <bfoster@redhat.com>
Cc: Niels de Vos <ndevos@redhat.com>, gluster-devel@gluster.org,
 Manikandan Selvaganesh <mselvaga@redhat.com>, selinux@tycho.nsa.gov
Subject: Re: Steps needed to support SElinux over FUSE mounts
Date: Thu, 03 Dec 2015 10:50:51 -0500
Message-ID: <2074080.yv27hRHClr@sifl>
In-Reply-To: <20151203153048.GA29002@bfoster.bfoster>
References: <20151202120200.GO19804@ndevos-x240.usersys.redhat.com>
 <20151203142627.GD7004@ndevos-x240.usersys.redhat.com>
 <20151203153048.GA29002@bfoster.bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, December 03, 2015 10:30:49 AM Brian Foster wrote:
> On Thu, Dec 03, 2015 at 03:26:27PM +0100, Niels de Vos wrote:
> > On Wed, Dec 02, 2015 at 08:26:45PM -0500, Paul Moore wrote:
> > > On Wednesday, December 02, 2015 01:02:00 PM Niels de Vos wrote:
> > > > Hi,
> > > > 
> > > > At the moment it is not possible to set an SElinux context over a FUSE
> > > > mount. This is because FUSE (in the kernel) does not support SElinux.
> > > > I'll try to explain what we need to accomplish to get this working.
> > > > 
> > > > 1. make it possible for SElinux to check sub-filesystems
> > > > 
> > > >    Currently SElinux only can check if a filesystem supports SElinux,
> > > >    based on the base filesystem. By default FUSE does not support
> > > >    SElinux, so it is not possible for sub-filesystems to support it
> > > >    either. When checking /proc/mounts a Gluster mount identifies
> > > >    itself
> > > >    with "fuse.glusterfs", which is <mainfs>.<subfs>.
> > > >    
> > > >    An experimental patch for the kernel has been attached to
> > > >    https://bugzilla.redhat.com/1272868
> > > 
> > > I'm not very knowledgeable about gluster so I don't have much
> > > constructive to say about any of the points below, and my comments in
> > > the BZ above are still valid.  I will say that I didn't have much luck
> > > getting a response from Eric, but I don't think that should stop
> > > anything at this point; if the gluster folks are okay with everything
> > > else, I have no problems with the proposed SELinux kernel bits (that
> > > weren't already mentioned in the BZ).
> > 
> > The approach looks good, but did not have any success with our testing
> > yet. The patch applied and running with the test-kernel does not make it
> > possible yet to change the SElinux context with "chcon". Even mounting
> > with the additional "seclabel" mount option does not help with that (but
> > it looks like a no-op in the kernel sources anyway).
> > 
> >   # chcon -t home_user_t /mnt/README
> >   chcon: failed to change context of ‘/mnt/README’ to
> >   ‘system_u:object_r:home_user_t:s0’: Operation not supported> 
> > Systemtap shows that the subtype is set correctly in the super_block at
> > the time selinux_sb_kern_mount() is called. I'm not sure what else is
> > needed to make this work. A suggestion what to check from a SElinux side
> > is welcome. The audit.log does not contain anything relevant at the time
> > of the mounting, maybe there is a way to enable more verbose logging of
> > some kind?
> 
> I believe fuse modifications are required to enable SELinux support via
> xattrs. I had posted some prototype patches a ways back:
> 
> http://sourceforge.net/p/fuse/mailman/fuse-devel/thread/1385389343-55663-1-g
> it-send-email-bfoster%40redhat.com/#msg31678712
> 
> These patches basically add the ability for the userspace fs to enable
> selinux in fuse, add the hooks for fuse to initialize security properly
> on new inodes (fairly boilerplate if you take a look at some other linux
> fs'), and add a notification mechanism to help userspace invalidate the
> security context on remote context changes.
> 
> IIRC, the latter is required since otherwise the security context is
> initialized on the in-memory inode once and never changed except via the
> explicit chcon (setxattr?) path. Therefore, client A doesn't have any
> clean way to notify the local kernel that the backend security context
> has changed via a chcon on client B.
> 
> I also think an selinux policy update that enables selinux via xattrs
> support for "fuse.glusterfs" filesystems is a requirement to actually
> test any of this stuff. My understanding is that the kernel subtype
> thing is a requirement to distinguish glusterfs from other types of fuse
> filesystems, but the actual policy enablement for such fuse.glusterfs
> fs' is part of the userspace selinux-policy package.
> 
> I have old, custom selinux-policy-3.12.1-95.fc21 rpm packages sitting
> around here that you're welcome to, but they might be too old at this
> point. I also might have prototype-level supporting code in glusterfs
> for some of this stuff (e.g., xattr name translation, remote context
> invalidation, etc.), but I'd have to dig around for that...
> 
> Brian

Brian is correct, some SELinux policy tweaks should be needed as well.  I'm 
going to be traveling in a few hours without reliable network/email so I'm 
CC'ing the SELinux list.

-- 
paul moore
security @ redhat
