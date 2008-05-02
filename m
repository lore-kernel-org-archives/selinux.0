Subject: Re: [RFC][PATCH v2] selinux:  support deferred mapping of contexts
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
        Eric Paris <eparis@parisplace.org>
In-Reply-To: <1209745373.25678.567.camel@moss-spartans.epoch.ncsc.mil>
References: <1209588984.25678.389.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.64.0805010853300.2731@us.intercode.com.au>
	 <1209639872.25678.409.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.64.0805012209480.24536@us.intercode.com.au>
	 <1209645099.25678.434.camel@moss-spartans.epoch.ncsc.mil>
	 <Xine.LNX.4.64.0805012318440.4703@us.intercode.com.au>
	 <1209649760.25678.455.camel@moss-spartans.epoch.ncsc.mil>
	 <481B37AF.4040806@redhat.com>
	 <1209744848.25678.562.camel@moss-spartans.epoch.ncsc.mil>
	 <1209745373.25678.567.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 02 May 2008 12:45:13 -0400
Message-Id: <1209746713.25678.582.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 2008-05-02 at 12:22 -0400, Stephen Smalley wrote:
> On Fri, 2008-05-02 at 12:14 -0400, Stephen Smalley wrote:
> > On Fri, 2008-05-02 at 11:47 -0400, Daniel J Walsh wrote:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > > 
> > > Stephen Smalley wrote:
> > > > On Thu, 2008-05-01 at 23:22 +1000, James Morris wrote:
> > > >> On Thu, 1 May 2008, Stephen Smalley wrote:
> > > >>
> > > >>> the build host with no way to define it).  Or a mechanism for a
> > > >>> hierarchy of policies (complex, and not clear how to handle objects as
> > > >>> they may be visible to processes operating under more than one policy,
> > > >>> e.g. both inside and outside of the chroot).
> > > >> Indeed, this might be helped by encoding DOIs into labels but would likely 
> > > >> add lots of complexity and performance overhead.  AFAICT, entities in 
> > > >> different policy namespaces would need to be totally separated (unless 
> > > >> purely hierarchical).
> > > > 
> > > > Pure isolation would be cleaner, but won't work in the buildsys example,
> > > > as there we have rpm (running outside the chroot) installing files into
> > > > the chroot tree and then launching scriptlets within the chroot, so we
> > > > have processes both outside and within the chroot acting on the files.
> > > > 
> > > > In any event, of the available alternatives, I think the
> > > > set-unknown-label option may be the only practical one. So if you have
> > > > any comments on the code in the patch or if you want it split into two
> > > > stages, let me know.  Otherwise, I'll re-spin it with Casey's suggested
> > > > change.
> > > > 
> > > This is half the solution.  Don't we need a new /selinux for inside the
> > > chroot, so that when selinux-policy rpm installs the policy, it lies and
> > > says the policy was loaded.  Then at the end of the install , restorecon
> > > is running on the entire image to make sure the labels match the
> > > file_context in the chroot.
> > 
> > I don't know offhand, but that is something the installer folks can do
> > on their own.  Just make a fake /selinux directory in the chroot with
> > "load" as a hard link to /dev/null?
> 
> Actually, why can't we just pretend selinux is disabled within the
> chroot (via a shared object that overrides is_selinux_enabled) to
> suppress attempts to reload policy into the kernel?  Everything else
> (installing the policy files, running semanage, etc) is supposed to work
> even on a selinux-disabled host.
> 
> As long as rpm itself knows that SELinux is enabled on the build host
> (which it should determine at startup before chroot'ing), I don't see
> the problem.

Or does that break scriptlet transitions?

If it is a problem, then in addition to faking the load node, I think we
need to fake the context node for context validation/canonicalization.
That one might be a little harder than just bind mounting /dev/null over
it, as userspace expects to read back the canonicalized context value
from it.  But I suppose we could just make it a regular file - then when
rpm writes the context value to it and then reads it back, it will get
the identity relationship we want.

So bind mount /dev/null on top of selinux/load and touch selinux/context
within the chroot and it should mostly just work (tm).

> 
> > I do expect we'll run into other issues, but we won't really know what
> > they all are until we try using this kernel patch first.  Can we get the
> > patch (w/ Casey's suggested change) put into a Fedora kernel for initial
> > testing before upstreaming?
> > 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
