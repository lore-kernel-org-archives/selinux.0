Subject: Re: I am trying an experiment of making allow_ptrace boolean
 actually do something useful.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <CACLa4pucvDGoYe-RKcJTPiC1oj8-M_RvH9gt+Wz_YYsL-gqZ5g@mail.gmail.com>
References: <4E8C7DCA.3020003@redhat.com>
	 <1317835394.1403.30.camel@moss-pluto>
	 <CACLa4pucvDGoYe-RKcJTPiC1oj8-M_RvH9gt+Wz_YYsL-gqZ5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 05 Oct 2011 13:59:48 -0400
Message-ID: <1317837588.1403.38.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-10-05 at 13:47 -0400, Eric Paris wrote:
> On Wed, Oct 5, 2011 at 1:23 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On Wed, 2011-10-05 at 11:54 -0400, Daniel J Walsh wrote:
> 
> > With modern kernels, SELinux makes a distinction in its permission
> > checks for ptrace vs /proc/pid but the DAC/capability checks do not.
> > For SELinux, we check :file read access for most /proc/pid files, and
> > only check :process ptrace on specific /proc/pid nodes (originally
> > only /proc/pid/mem, but I see that viro expanded it
> > to /proc/pid/{syscall, stack, personality} as well; not sure whether
> > that is justified or if it should just use PTRACE_MODE_READ there as
> > well).  So you'll see sys_ptrace capability denials but shouldn't
> > see :process ptrace denials from running ps these days.  Older kernels
> > would trigger :process ptrace denials from ps due to environ, but that
> > was switched over to PTRACE_MODE_READ and only triggers :file read now.
> 
> Everything you say is true.  But I'm having trouble deciding best way
> to deal with the CAPABILITY__SYS_PTRACE denials that pop out of the
> use of /proc/pid/stat when run by a process that has CAP_SYS_PTRACE.
> /proc/pid/stat works just fine even if this permission is not granted,
> but we get a denial.  We could dontaudit all of them.  Or maybe I
> could look for some way to make the check in __ptrace_may_access use
> the dontaudit version of the capability checks.  I'm leaning for that
> way, but don't know....

I assume you want to pass a flag from do_task_stat() to
ptrace_may_access() or introduce a ptrace_may_access_noaudit() interface
that it can use, so that you only turn off auditing in that particular
case?

I'm ok with that.  But if he wants to be able to remove dontaudit rules
for :process ptrace as well, then we need to make sure that we only
check it for actual ptrace(2) or equivalent (/proc/pid/mem falling into
the latter category).  So unless there is some particular
rationale, /proc/pid/{syscall, stack, personality} should likely be
using PTRACE_MODE_READ instead.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
