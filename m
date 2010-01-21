Subject: Re: Policy is not managed or store cannot be accessed
From: Stephen Smalley <sds@tycho.nsa.gov>
To: AlannY <m@alanny.ru>
Cc: SELinux@tycho.nsa.gov
In-Reply-To: <20100121141716.GA7818@alanny-pc.lcl.starlink.ru>
References: <20100120202135.GA6124@alanny-pc.lcl.starlink.ru>
	 <1264020386.24133.182.camel@moss-pluto.epoch.ncsc.mil>
	 <20100121122816.GB13907@alanny-pc.lcl.starlink.ru>
	 <1264080547.11002.28.camel@moss-pluto.epoch.ncsc.mil>
	 <20100121141716.GA7818@alanny-pc.lcl.starlink.ru>
Content-Type: text/plain
Date: Thu, 21 Jan 2010 09:37:33 -0500
Message-Id: <1264084653.11002.68.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-01-21 at 17:17 +0300, AlannY wrote:
> On Thu, Jan 21, 2010 at 08:29:07AM -0500, Stephen Smalley wrote:
> > So /sbin/init never transitioned from kernel_t to init_t and thus none
> > of your processes are in the right security context.
> > 
> > In order for this to happen, one of two things is required:
> > 1) Your /sbin/init program needs the selinux patch to load policy and
> > then re-exec itself into the right security context, or
> > 2) Your initramfs init script needs to load policy (e.g. chroot
> > $NEWROOT /usr/sbin/load_policy -i) before running the real init program.
> > 
> > #1 was the original approach in Fedora; #2 is the current approach in
> > Fedora and Ubuntu.
> 
> Ok, I'll try to modify initramfs.
> 
> > > File contexts:
> > > Controlling term:               system_u:object_r:ramfs_t
> > 
> > This is interesting - why is your tty on a ramfs image?
> 
> I don't know ;-( It was by default. What can I do to change it?

What were you running sestatus from?  single-user mode?  Normal console
login at runlevel 3?  What does "tty" report as your tty device and what
does cat /proc/mounts show?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
