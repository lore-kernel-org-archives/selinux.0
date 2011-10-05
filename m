MIME-Version: 1.0
In-Reply-To: <1317835394.1403.30.camel@moss-pluto>
References: <4E8C7DCA.3020003@redhat.com>
	<1317835394.1403.30.camel@moss-pluto>
Date: Wed, 5 Oct 2011 13:47:11 -0400
Message-ID: <CACLa4pucvDGoYe-RKcJTPiC1oj8-M_RvH9gt+Wz_YYsL-gqZ5g@mail.gmail.com>
Subject: Re: I am trying an experiment of making allow_ptrace boolean actually
 do something useful.
From: Eric Paris <eparis@parisplace.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Oct 5, 2011 at 1:23 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2011-10-05 at 11:54 -0400, Daniel J Walsh wrote:

> With modern kernels, SELinux makes a distinction in its permission
> checks for ptrace vs /proc/pid but the DAC/capability checks do not.
> For SELinux, we check :file read access for most /proc/pid files, and
> only check :process ptrace on specific /proc/pid nodes (originally
> only /proc/pid/mem, but I see that viro expanded it
> to /proc/pid/{syscall, stack, personality} as well; not sure whether
> that is justified or if it should just use PTRACE_MODE_READ there as
> well).  So you'll see sys_ptrace capability denials but shouldn't
> see :process ptrace denials from running ps these days.  Older kernels
> would trigger :process ptrace denials from ps due to environ, but that
> was switched over to PTRACE_MODE_READ and only triggers :file read now.

Everything you say is true.  But I'm having trouble deciding best way
to deal with the CAPABILITY__SYS_PTRACE denials that pop out of the
use of /proc/pid/stat when run by a process that has CAP_SYS_PTRACE.
/proc/pid/stat works just fine even if this permission is not granted,
but we get a denial.  We could dontaudit all of them.  Or maybe I
could look for some way to make the check in __ptrace_may_access use
the dontaudit version of the capability checks.  I'm leaning for that
way, but don't know....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
