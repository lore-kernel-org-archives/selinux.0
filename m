Subject: Re: textrel_shlib_t handling
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chris PeBenito <pebenito@gentoo.org>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1145726058.9106.70.camel@gorn.pebenito.net>
References: <1145726058.9106.70.camel@gorn.pebenito.net>
Content-Type: text/plain
Date: Wed, 26 Apr 2006 09:43:14 -0400
Message-Id: <1146058994.28745.122.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-04-22 at 13:14 -0400, Chris PeBenito wrote:
> I remember seeing some discussion about RPM being enhanced so that it
> detects libraries with text relocations, and labels them textrel_shlib_t
> when installing them onto the filesystem.  So I thought that it would be
> useful for Gentoo's Portage too.  The problem is that if a library isn't
> already textrel_shlib_t in the file contexts, a relabel will reset them
> back to shlib_t.  I came up with two possible solutions:
> 
> 1. the package manager adds file contexts using semanage fcontext, then
> the library will get the right label by default.  The problem with this
> is that this would need to be recorded somewhere (probably the package
> manager db) so the package manager removes this fcontext if the package
> is removed/upgraded.
> 
> 2. textrel_shlib_t is made a customizable type.  The problem is that the
> libs can still get set back to shlib_t if using -F on
> restorecon/setfiles.
> 
> While #1 is the best solution, it may require significant changes in the
> package manager, and may not be acceptable to the upstream because of
> that.  #2 is a simpler solution, but has the -F problem.  My feeling is
> that the -F problem is not a significant problem, so we should go with
> #2.  Thoughts?

I had suggested #2 previously, but someone (Dan?) noted that we then
have the problem that textrel_shlib_t will never get removed if the
library is later updated to a version that no longer requires text
relocations.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
