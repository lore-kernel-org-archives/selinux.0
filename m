Subject: Re: [PATCH] Add functionality to upstart to load policy early in
 boot
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Manoj Srivastava <srivasta@golden-gryphon.com>
Cc: selinux@tycho.nsa.gov, Manoj Srivastava <srivasta@debian.org>
In-Reply-To: <1252430762.13634.439.camel@moss-pluto.epoch.ncsc.mil>
References: <1252332992-5271-1-git-send-email-srivasta@golden-gryphon.com>
	 <1252430762.13634.439.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 08 Sep 2009 13:33:57 -0400
Message-Id: <1252431237.13634.451.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2009-09-08 at 13:26 -0400, Stephen Smalley wrote:
> On Mon, 2009-09-07 at 09:16 -0500, Manoj Srivastava wrote:
> > From: Manoj Srivastava <srivasta@debian.org>
> > 
> > 
> >          As has been reported, Debian is planning on moving to upstart
> >  for the next release. Debian does not require a system to have an
> >  initramfs (custom kernels which do not need initramfs and/or modules
> >  are supported), so it is desirable to have /sbin/init load policy early
> >  in the boot process, and sysvinit has already been patched like this.
> >  I am sending this in for comment and review.
> > 
> > This patch is applied conditionally, and unless WITH_SELINUX is defined
> > when make is called (that is, at compile time), it does nothing. If
> > WITH_SELINUX is set to 'yes' at compile time, this patch, analogous to
> > that in sysvinit, checks early to see if SELinux is enabled on the
> > machine, and then tries to load policy, If loading policy fails,and if
> > SELinux is in enforcing mode, it prevents startup.
> > 
> > If the machine does not have selinux enabled at run time, nothing
> > happens.
> 
> Looks like you followed the sysvinit selinux patch except that you added
> a test of is_selinux_enabled() that ensures that upstart will not try to
> load policy a second time if it was already loaded (e.g. by the
> initramfs).  So it looks good to me.  Not sure about the best way to
> report errors from upstart - you might look to see if there is a better
> interface than just fprintf(stderr...) that would be suitable to ensure
> that the user actually sees that message.

Wondering whether you actually need the putenv() and getenv() calls -
that was the old way of ensuring that we didn't try to load policy twice
when we re-exec init.  But if we're now testing is_selinux_enabled() to
detect whether it was already loaded by initramfs, that may suffice (not
entirely sure - it depends on whether we have /proc mounted).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
