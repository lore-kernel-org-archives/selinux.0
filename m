Subject: RE: [PATCH 0/2] new and improved range_transition statements
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Valdis.Kletnieks@vt.edu, James Morris <jmorris@namei.org>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>,
        SELinux List <SELinux@tycho.nsa.gov>, Eric Paris <eparis@redhat.com>
In-Reply-To: <6FE441CD9F0C0C479F2D88F959B0158832ADD8@exchange.columbia.tresys.com>
References: 
	 <6FE441CD9F0C0C479F2D88F959B0158832ADD8@exchange.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 07 Aug 2006 10:57:51 -0400
Message-Id: <1154962671.26697.34.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-08-07 at 10:32 -0400, Joshua Brindle wrote:
> > From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> > Possibly we aren't communicating - the current userland (e.g. 
> > in FC5 and
> > later) already handles this situation correctly; libsemanage 
> > always generates the latest policy version supported by 
> > libsepol (unless overridden by semanage.conf), and libselinux 
> > loads the latest policy version supported by libsepol, or the 
> > closest one to it, downgrading on the fly if necessary via 
> > libsepol to the kernel's policyvers, and SysVinit uses the 
> > libselinux policy loader now.  The purpose of this kernel 
> > patch is to avoid breaking legacy userland (e.g. FC3, FC4) 
> > that predates all of this support (libsemanage altogether, 
> > the libsepol interfaces needed to make it work, the 
> > libselinux helper function to fully encapsulate the policy 
> > load, and the changes to SysVinit to use the libselinux 
> > helper function).
> > 
> 
> Ah, ok, fair enough. It seems strange that people are upgrading kernels
> in FC3, FC4 but not userland, just seems like a bad idea.

IIUC, that's standard practice in Fedora - userland freezes except for
bug fixes at release time, while kernels re-base to each new kernel.org
release during the life cycle of the distribution.  Not something I can
control...

More importantly, kernel developers and some users often build and test
new kernels on existing distros, and expect new kernels to always
provide backward compatibility for existing userland, even when that
existing userland is broken. 

> > BTW, one way to address Darrel's concern is to leave the 
> > default value unchanged (at 20) when we merge the range 
> > transition patch, so that the kernel package maintainer or 
> > user has to take positive action to force the kernel to 
> > support policy version 21.
> > 
> 
> That is reasonable for RH to do for its legacy systems but doing it in
> mainline seems silly, particularly since its going to mean very few
> people testing out the new code.

Mainline seems to take the opposite view, i.e. require people to take
positive action to do anything that will break their existing userland.
Compatibility given precedence over new features.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
