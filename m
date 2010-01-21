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
Date: Thu, 21 Jan 2010 09:57:46 -0500
Message-Id: <1264085866.11002.81.camel@moss-pluto.epoch.ncsc.mil>
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

Since you mentioned that you had a selinux-sysvinit package (and hence
should have had a patched /sbin/init), I looked around and found:
http://aur.archlinux.org/packages/selinux-sysvinit/selinux-sysvinit/sysvinit-init.c.diff

Interestingly, this patch (which is not the same as the one used in the
past by Fedora and Debian) does not try to re-exec init, which is why it
isn't transitioning into its domain.

Further, this patch tries to load policy from /etc/policy.bin.  That's a
non-standard location, and won't work unless it happens to be a symlink
to the location used by libsemanage and libselinux
(/etc/selinux/$SELINUXTYPE/policy/policy.NN where SELINUXTYPE is defined
by /etc/selinux/config and NN is the policy format version number).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
