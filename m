Subject: Re: justifying --context=CTX (-Z) for upstream coreutils, like
	mkdir
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Jim Meyering <jim@meyering.net>, selinux@tycho.nsa.gov,
        Russell Coker <russell@coker.com.au>
In-Reply-To: <1155308294.8018.59.camel@localhost.localdomain>
References: <87mzabgyrk.fsf@rho.meyering.net>
	 <1155308294.8018.59.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 11 Aug 2006 11:23:30 -0400
Message-Id: <1155309810.30078.81.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-08-11 at 10:58 -0400, Karl MacMillan wrote:
> On Fri, 2006-08-11 at 15:58 +0200, Jim Meyering wrote:
> > Hello again,
> > 
> > With clear agreement that neither cp nor mv needs the --context=CTX (-Z)
> > option, I am nearly convinced that the this option does not belong in any
> > other program in upstream coreutils.  [of course, I expect it to remain
> > in RHEL and probably in Fedora for some time]  Upstream coreutils will
> > display contexts (stat, ls, uname), and preserve them (cp, mv, install?),
> > and add chcon+runcon, but that's all.
> > 
> > For a little context on why, ...
> > I'm also considering the xattr patch that's been floating around for
> > years.  Currently it's part of SuSE's coreutils patch set.  It ensures
> > that mv and cp -p preserve any (selected) XATTR attributes.
> 
> Only selected attributes or you can optionally preserve only a subset?
> I.e., is the default to preserve all?
> 
> >   There is
> > no option to let install(1) apply XATTR attributes.
> 
> Is there a need for this? I have no idea.
> 
> >   Nor mkdir, mkfifo,
> > mknod.  Similarly for the ACL support that's widely available, there is
> > no option to let those programs apply a specified ACL.  Why should
> > SELinux security contexts be treated differently?
> 
> Acls are a discretionary mechanism and it is, therefore, appropriate for
> them to be applied by users after file creation.
> 
> SELinux is fundamentally different as a mandatory mechanism and a core
> property is that objects should be labeled correctly at creation time.
> 
> > 
> > I do understand the race condition argument, but any sysadmin who is
> > silly enough to create new files in such a way that those races matter,
> > deserves whatever s/he gets.
> 
> But what real options do they have? Forcing the app to install into a
> DESTDIR, labeling and copying? What about a developer trying to
> distribute a tarball with selinux support at install - what option would
> this leave them?
> 
> >   If a destination file really must be in a
> > vulnerable place, it's not so hard to create it first in a safe place,
> > apply any necessary context via chcon, and then `install' them via rename.
> > 
> 
> You are assuming a policy where relabeling is allowed fairly broadly -
> not all policies are written in this way. Heavily locked-down systems
> will want to prevent relabeling wherever possible and not providing
> tools to create files labeled correctly prevents this.
> 
> > Am I missing some justification for why e.g., mkdir should have the
> > option?  Yes, it does accept --mode=M (-m), but is that enough to
> > justify the SELinux---ACL/XATTR dichotomy?  Not to me.  But I'm
> > willing to be educated :)
> > 
> 
> Again, SELinux is fundamentally different from ACL/XATTRs.
> 
> > BTW, what makes install so special that it needs to call matchpathcon?
> > Can it accomplish the same goal via "chcon ...;
> > install --preserve-context ..."?
> > 
> 
> It allows install to correctly label for different policies, including
> policies distributed separately from the application. Otherwise the
> makefile must hardcode all possible labels in the chcon statements or
> provide a mechanism that is essentially matchpathcon.
> 
> This could be done with the separate matchpatcon utility though, so I
> wouldn't be against dropping this.

The only thing I would add here is that the install(1) change to use
matchpathcon(3) was to parallel the corresponding logic in rpm, so that
non-rpm packages (e.g. ordinary upstream tarballs that people build and
install via make install) would have their files labeled correctly at
install time too.  Otherwise, admins have to take extra steps to get
such files labeled correctly.  At installation time, you generally need
some external knowledge of the right security attributes for the file,
which is what matchpathcon is providing.  Whereas cp or mv can operate
based on the original security attributes of the file, plus the process'
attributes.
  
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
