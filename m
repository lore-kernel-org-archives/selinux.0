Subject: Re: [PATCH] SELinux: always check SIGCHLD in selinux_task_wait
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org, roland@redhat.com
In-Reply-To: <1193080781.24622.144.camel@moss-spartans.epoch.ncsc.mil>
References: <1193080073.2948.28.camel@localhost.localdomain>
	 <1193080781.24622.144.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 22 Oct 2007 15:31:05 -0400
Message-Id: <1193081465.2950.4.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-10-22 at 15:19 -0400, Stephen Smalley wrote:
> On Mon, 2007-10-22 at 15:07 -0400, Eric Paris wrote:
> > When checking if we can wait on a child we were looking at
> > p->exit_signal and trying to make the decision based on if the signal
> > would eventually be allowed.  One big flaw is that p->exit_signal is -1
> > for NPTL threads and so aignal_to_av was not actually checking SIGCHLD
> > which is what would have been sent.  Even is exit_signal was set to
> > something strange it wouldn't change the fact that the child was there
> > and needed to be waited on.  This patch just assumes wait is based on
> > SIGCHLD.  Specific permission checks are made when the child actually
> > attempts to send a signal.
> > 
> > This resolves the problem of things like using GDB on confined domains
> > such as in RH BZ 232371.  The confined domain did not have permission to
> > send a generic signal (exit_signal == -1) back to the unconfined GDB.
> > With this patch the GDB wait works and since the actual signal sent is
> > allowed everything functions as it should.
> > 
> > ---
> > 
> > Signed-off-by: Eric Paris <eparis@redhat.com> 
> > 
> > security/selinux/hooks.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 24e1b18..078fe82 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2979,7 +2979,7 @@ static int selinux_task_wait(struct task_struct *p)
> >  {
> >  	u32 perm;
> >  
> > -	perm = signal_to_av(p->exit_signal);
> > +	perm = signal_to_av(SIGCHLD);
> >  
> >  	return task_has_perm(p, current, perm);
> >  }
> 
> Just make it:
> 	return task_has_perm(p, current, PROCESS__SIGCHLD);
> 

ok, will resend as soon as it compiles and boots.  I was sticking with
it because we don't use PROCESS__SIG* anywhere outside of signal_to_av
and we use constant input to that function in
selinux_file_send_sigiotask (although for very different reasons).  Is
the compiler smart enough to compile out the inlined switch statement
when given a constant?  Doesn't matter, new patch coming.

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
