Date: Tue, 12 Jun 2007 10:44:12 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Russell Coker <russell@coker.com.au>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>
Subject: Re: [RFC][PATCH] selinux:  enable authoritative granting of capabilities
Message-ID: <20070612154412.GC14397@sergelap.austin.ibm.com>
References: <20070611204336.GA30846@sergelap.austin.ibm.com> <620792.60154.qm@web36608.mail.mud.yahoo.com> <20070611222402.GA21593@sergelap.austin.ibm.com> <200706121920.07268.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200706121920.07268.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Quoting Russell Coker (russell@coker.com.au):
> On Tuesday 12 June 2007 08:24, "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> > That changes how one uses these a bit, in an interesting way. ?Let's say
> > we want users running ping to get CAP_NET_RAW. ?If ping were then
> > exploited to exec something else, then with capabilities it would lose
> > CAP_NET_RAW. ?How should (or should?) that be emulated in selinux?
> 
> The solution to this example is to not allow ping to execute anything - it has 

Yes I picked the example hoping you'd recognize that not being allowed
to execute anything is not a satisfactory solution in the general case.

Let me try another example - namespace cloning requires CAP_SYS_ADMIN,
and generally is followed by an execve.  So if/when we provide a script
to start a vserver or checkpoint/restart job for ordinary users, we
would want it to run with CAP_SYS_ADMIN, then drop CAP_SYS_ADMIN on
execve.

> no need to do so anyway.  Also an attacker who exploited ping could probably 
> make it do whatever net-raw operations they desired without needing to 
> execute a different program.
> 
> For the general case of a privileged process executing another process you 
> want a domain_auto_trans.

Ok, those can be forced, so I can't override it as a user?

Let's say I execute /usr/bin/restart_job, which has CAP_SYS_ADMIN in
order to clone some namespaces and then executes my restart job.  I
started out as serge_u:serge_r:serge_t, and became
serge_u:serge_r:restartjob_t while running /usr/bin/restart_job.  Now
when my checkpointed job is exec'ed, I might want to run in my original
context.  Any sane way of doing that (and supporting it for various
users)?  Do I just have to provide a bunch of domain_auto_trans rules
to transition to a bunch of users, and let the selinux user field select
which user I actually get transitioned to?

BTW - if the short answer is "we want to provide the *ability* to do
capability overrides but stick to the TE transition model in doing so,
that's fair too.

thanks,
-serge

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
