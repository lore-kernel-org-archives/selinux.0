Subject: Re: type transitioning script race condition?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: russell@coker.com.au, Klaus Weidner <klaus@atsec.com>,
        selinux@tycho.nsa.gov, Stephan Mueller <smueller@atsec.com>
In-Reply-To: <1157035743.24429.105.camel@twoface.columbia.tresys.com>
References: <20060830223937.GB12307@w-m-p.com>
	 <200608310918.03263.russell@coker.com.au>  <44F6539E.7090800@gentoo.org>
	 <1157035423.15844.31.camel@moss-spartans.epoch.ncsc.mil>
	 <1157035743.24429.105.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 11:09:00 -0400
Message-Id: <1157036940.15844.38.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-08-31 at 10:49 -0400, Joshua Brindle wrote:
> On Thu, 2006-08-31 at 10:43 -0400, Stephen Smalley wrote:
> > On Wed, 2006-08-30 at 23:12 -0400, Joshua Brindle wrote:
> > > Russell Coker wrote:
> > > 
> > > >On Thursday 31 August 2006 08:39, Klaus Weidner <klaus@atsec.com> wrote:
> > > >  
> > > >
> > > >>This sounds as if it suffers from the well known race condition that
> > > >>makes setuid shell scripts a bad idea - is there any protection in place
> > > >>to prevent users from exploiting the race condition to run code of their
> > > >>own choice in the new domain?
> > > >>    
> > > >>
> > > >
> > > >Correct.  As long as the script is run in a domain that has less privileges 
> > > >than the calling code this isn't a problem.  If running a script causes a 
> > > >transition to a more privileged domain then that's a policy bug.
> > > >
> > > >  
> > > >
> > > this happens quite a bit, including our own selinux management script 
> > > semanage. In addition to the race condition (that is not fixable on 
> > > Linux AFAIK)
> > 
> > Solaris deals with the race by having the kernel set up the state of the
> > transformed process to include a descriptor to the script file and then
> > passing /dev/fd/<n> as the command line argument to the interpreter
> > rather than the original script pathname, IIRC.  There hasn't been much
> > receptiveness to doing something equivalent in Linux in the past on
> > lkml.
> > 
> 
> Right, I'd be curious to see how many scripts this breaks, plenty of
> applications (including scripts) look at argv[0] to see how they were
> invoked to decide how to behave.

Yes, Solaris only does the /dev/fd/n substitution if the script
execution involves a change in identity/privs, presumably to avoid
creating compatibility issues with unprivileged scripts.

> 
> Then again, if we really wanted this to eliminate the race we could
> always do it from the wrapper..
> 
> Maybe this would be a good thing to do for security critical apps (eg.,
> semanage) and not mess with everything else.
> 
> > >  there are other environmental contamination issues,
> > > 
> > > There are some plans to fix the environmental contamination issues using 
> > > a wrapper that cleanses the environment ala atsecure but the race is not 
> > > fixable as far as I know.
> > 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
