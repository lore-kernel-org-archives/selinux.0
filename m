Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of
	capabilities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Russell Coker <russell@coker.com.au>,
        Casey Schaufler <casey@schaufler-ca.com>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
In-Reply-To: <20070612154412.GC14397@sergelap.austin.ibm.com>
References: <20070611204336.GA30846@sergelap.austin.ibm.com>
	 <620792.60154.qm@web36608.mail.mud.yahoo.com>
	 <20070611222402.GA21593@sergelap.austin.ibm.com>
	 <200706121920.07268.russell@coker.com.au>
	 <20070612154412.GC14397@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Tue, 12 Jun 2007 11:57:37 -0400
Message-Id: <1181663857.17547.227.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-06-12 at 10:44 -0500, Serge E. Hallyn wrote:
> Quoting Russell Coker (russell@coker.com.au):
> > On Tuesday 12 June 2007 08:24, "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> > > That changes how one uses these a bit, in an interesting way. ?Let's say
> > > we want users running ping to get CAP_NET_RAW. ?If ping were then
> > > exploited to exec something else, then with capabilities it would lose
> > > CAP_NET_RAW. ?How should (or should?) that be emulated in selinux?
> > 
> > The solution to this example is to not allow ping to execute anything - it has 
> 
> Yes I picked the example hoping you'd recognize that not being allowed
> to execute anything is not a satisfactory solution in the general case.
> 
> Let me try another example - namespace cloning requires CAP_SYS_ADMIN,
> and generally is followed by an execve.  So if/when we provide a script
> to start a vserver or checkpoint/restart job for ordinary users, we
> would want it to run with CAP_SYS_ADMIN, then drop CAP_SYS_ADMIN on
> execve.

Well, first, no script should be allowed a capability that is not given
to its caller directly ;)

But the general goal here seems easy to address through TE domain
transitions.

> > no need to do so anyway.  Also an attacker who exploited ping could probably 
> > make it do whatever net-raw operations they desired without needing to 
> > execute a different program.
> > 
> > For the general case of a privileged process executing another process you 
> > want a domain_auto_trans.
> 
> Ok, those can be forced, so I can't override it as a user?

A domain cannot execute code at all (via execve or mmap PROT_EXEC)
without file:execute permission to its type and a domain cannot execve a
program in its own domain (i.e. without performing a domain transition)
without file:execute_no_trans permission to its type.  Thus, one can
require a domain transition in order to execve a program, and then the
possible domain transitions are controlled in the usual way
(process:transition, file:entrypoint).

> Let's say I execute /usr/bin/restart_job, which has CAP_SYS_ADMIN in
> order to clone some namespaces and then executes my restart job.  I
> started out as serge_u:serge_r:serge_t, and became
> serge_u:serge_r:restartjob_t while running /usr/bin/restart_job.  Now
> when my checkpointed job is exec'ed, I might want to run in my original
> context.  Any sane way of doing that (and supporting it for various
> users)?  Do I just have to provide a bunch of domain_auto_trans rules
> to transition to a bunch of users, and let the selinux user field select
> which user I actually get transitioned to?

A common idiom in policy is a chain of domain derivations like:
	domain_auto_trans(user_t, su_exec_t, user_su_t)
	domain_auto_trans(user_su_t, shell_exec_t, user_t)

This takes you from the initial domain to the privileged domain and back
again.  Not sure that you need to do this with per-user types though.

> BTW - if the short answer is "we want to provide the *ability* to do
> capability overrides but stick to the TE transition model in doing so,
> that's fair too.
> 
> thanks,
> -serge
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
