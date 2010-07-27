Subject: Re: [PATCH 2/2] selinux: implement mmap on /selinux/policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1280258664.2788.20.camel@dhcp231-200.rdu.redhat.com>
References: <20100726193407.19538.67667.stgit@paris.rdu.redhat.com>
	 <20100726193414.19538.64028.stgit@paris.rdu.redhat.com>
	 <1280255773.4789.83.camel@moss-pluto.epoch.ncsc.mil>
	 <1280256670.2788.14.camel@dhcp231-200.rdu.redhat.com>
	 <1280257773.4789.110.camel@moss-pluto.epoch.ncsc.mil>
	 <1280258214.2788.17.camel@dhcp231-200.rdu.redhat.com>
	 <1280258441.4789.113.camel@moss-pluto.epoch.ncsc.mil>
	 <1280258664.2788.20.camel@dhcp231-200.rdu.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 27 Jul 2010 15:28:12 -0400
Message-ID: <1280258892.4789.118.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-07-27 at 15:24 -0400, Eric Paris wrote:
> On Tue, 2010-07-27 at 15:20 -0400, Stephen Smalley wrote:
> > On Tue, 2010-07-27 at 15:16 -0400, Eric Paris wrote:
> > > On Tue, 2010-07-27 at 15:09 -0400, Stephen Smalley wrote:
> > > > On Tue, 2010-07-27 at 14:51 -0400, Eric Paris wrote:
> > > 
> > > > > My fear was:
> > > > > 
> > > > > Process A			Process B
> > > > > ------------------------	-------------------------
> > > > > open("/selinux/policy");
> > > > >   plm->data = p1
> > > > >   plm->len = l1
> > > > >   i_size = l1
> > > > > 				load_policy
> > > > > 				open("/selinux/policy");
> > > > > 				  plm->data = p2;
> > > > > 				  plm->len = l2;
> > > > > 				  i_size = l2;
> > > > > 				stat("/selinux/policy");
> > > > > 				  we get i_size=l2
> > > > > stat("/selinux/policy");
> > > > >   we get i_size=l2  WHOOPS.
> > > > 
> > > > How is that different from corresponding situation for a regular file?
> > > > Doesn't seem like the sort of thing the kernel should worry about.
> > > > I thought the check was to prevent arbitrary allocation of kernel memory
> > > > by spinning in a loop opening /selinux/policy forever.  But that doesn't
> > > > require worrying about the inode size changing.
> > > 
> > > This is actually more the problem with files in /proc.  The difference
> > > is that the plm->data and plm->len are still p1 and l1.  It's just
> > > stat() that is going to lie to you.  So you will either mmap to much or
> > > too little space and you have no idea how long the data you are going to
> > > be reading is...
> > > 
> > > read() works ok, because it is going to go till the EOF, but you have no
> > > idea where that is with mmap.....
> > 
> > I see.  It appears that setools and coreutils use read() rather than
> > mmap() since I could run seinfo, sediff, and cp on /selinux/policy, so
> > maybe nothing other than checkpolicy -b would even use the mmap support?
> > And that can be worked around by first copying to a regular file.
> > checkpolicy -b isn't exactly a typical user command; most people don't
> > even know it exists.
> 
> Another horrific option would be to create a new inode for each open()
> so your fd would always have your i_size info....

That would indeed be horrific ;)

> I'm going to finish my second mmap implementation attempt just to learn,
> but maybe we want to just throw it all away?  If so, thoughts on
> addressing the memory usage issue?

I don't care about userspace getting confused by an interleaving of
policy load and policy read - that is a userspace problem IMO.  So I
wouldn't be opposed to having the mmap handler upstreamed, although I
don't feel qualified to review the implementation - might want some
-fsdevel or -kernel eyes on it.

Limiting /selinux/policy to one user at a time might be reasonable as a
way of limiting memory consumption.  But you don't need the i_size hacks
as part of that.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
