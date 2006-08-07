MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 0/2] new and improved range_transition statements
Date: Mon, 7 Aug 2006 10:32:14 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158832ADD8@exchange.columbia.tresys.com>
In-Reply-To: <1154960391.26697.20.camel@moss-spartans.epoch.ncsc.mil>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <Valdis.Kletnieks@vt.edu>, "James Morris" <jmorris@namei.org>,
        "Karl MacMillan" <kmacmillan@mentalrootkit.com>,
        "Darrel Goeddel" <dgoeddel@TrustedCS.com>,
        "SELinux List" <SELinux@tycho.nsa.gov>,
        "Eric Paris" <eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> 
> On Mon, 2006-08-07 at 08:04 -0400, Joshua Brindle wrote:
> >  
<snip>
> > Hrm, I'd have really prefered this be handled in userspace, for 
> > example by having init query semanage to find out what 
> policy version 
> > to use (this not only affects loading old policies but also 
> > potentially stale ones which we have no protection against 
> right now)
> > 
> > If libsemanage wrote the latest policy name into the store 
> an semanage 
> > call could give it the info whether it was policy.n, policy.n-2 or 
> > policy.somethingentirelydifferent.One thing to think about 
> with this 
> > solution is how to handle multiple security servers though.
> > 
> > However, this seems fairly imperative and your proposed way of 
> > handling it is fast and simple so I guess it needs to go in 
> regardless.
> 
> Possibly we aren't communicating - the current userland (e.g. 
> in FC5 and
> later) already handles this situation correctly; libsemanage 
> always generates the latest policy version supported by 
> libsepol (unless overridden by semanage.conf), and libselinux 
> loads the latest policy version supported by libsepol, or the 
> closest one to it, downgrading on the fly if necessary via 
> libsepol to the kernel's policyvers, and SysVinit uses the 
> libselinux policy loader now.  The purpose of this kernel 
> patch is to avoid breaking legacy userland (e.g. FC3, FC4) 
> that predates all of this support (libsemanage altogether, 
> the libsepol interfaces needed to make it work, the 
> libselinux helper function to fully encapsulate the policy 
> load, and the changes to SysVinit to use the libselinux 
> helper function).
> 

Ah, ok, fair enough. It seems strange that people are upgrading kernels
in FC3, FC4 but not userland, just seems like a bad idea.

> BTW, one way to address Darrel's concern is to leave the 
> default value unchanged (at 20) when we merge the range 
> transition patch, so that the kernel package maintainer or 
> user has to take positive action to force the kernel to 
> support policy version 21.
> 

That is reasonable for RH to do for its legacy systems but doing it in
mainline seems silly, particularly since its going to mean very few
people testing out the new code.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
