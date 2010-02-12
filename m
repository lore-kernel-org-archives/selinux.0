Subject: Re: Random fork showing up in policy.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4B740814.8080802@redhat.com>
References: <4B740814.8080802@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 12 Feb 2010 08:07:15 -0500
Message-ID: <1265980035.911.88.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-02-11 at 08:37 -0500, Daniel J Walsh wrote:
> There has got to be something I am doing wrong.  But on my blog someone asked about writing a program that does a fork and having SELinux block it.  
> 
> Where is the fork access coming from?

Are you sure its not this:

allow domain self:process { fork sigchld };

in domain.te?

> In the tmp dir I see this policy being compiled.
> 
> # grep process.*fork fork.tmp
> 	class process { fork transition sigchld sigkill sigstop signull signal ptrace getsched setsched getsession getpgid setpgid getcap setcap share getattr setexec setfscreate noatsecure siginh setrlimit rlimitinh dyntransition setcurrent execmem execstack execheap setkeycreate setsockcreate };
> 	type_transition initrc_t fork_exec_t:process fork_t;
> 	type_transition init_t fork_exec_t:process fork_t;
> 	type_transition unconfined_t fork_exec_t:process fork_t;
> neverallow fork_t self:process fork;
> 
> 
> But if I install.
> 
> # semodule -i fork.pp
> libsepol.check_assertion_helper: neverallow violated by allow fork_t fork_t:process { fork };
> libsemanage.semanage_expand_sandbox: Expand module failed
> semodule:  Failed!
> 
> If I remove the neverallow line.
> 
> # sesearch -A -s fork_t -p fork
> Found 1 semantic av rules:
>    allow fork_t fork_t : process { fork sigchld } ; 
> 
> Something strange is going on.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
