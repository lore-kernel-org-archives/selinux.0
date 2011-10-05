Subject: Re: I am trying an experiment of making allow_ptrace boolean
 actually do something useful.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>
In-Reply-To: <4E8C7DCA.3020003@redhat.com>
References: <4E8C7DCA.3020003@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 05 Oct 2011 13:23:14 -0400
Message-ID: <1317835394.1403.30.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-10-05 at 11:54 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> The idea is, if you turn this boolean off, no domains will be allowed
> to sys_ptrace or ptrace.
> 
> In doing this, I have noticed that the simplest ps -eZ command
> generates an access violation.
> 
> allow sysadm_t self:capability sys_ptrace;
> 
> 
> # ps
>   PID TTY          TIME CMD
>  2123 pts/1    00:00:00 sudo
>  2127 pts/1    00:00:05 sh
>  4095 pts/1    00:00:00 ps
> sh-4.2# aud
> 
> 
> #============= sysadm_t ==============
> allow sysadm_t self:capability sys_ptrace;
> 
> To me this looks like we are being too strict on the sys_ptrace
> cabability checking, which I believe is a bug in the kernel.
> 
> 
> If I go into /proc/PID directory of domain with a different UID, I get
> the following, permission denieds:
> 
> cat: auxv: Permission denied
> cat: cwd: Permission denied
> cat: environ: Permission denied
> cat: exe: Permission denied
> cat: io: Permission denied
> cat: maps: Permission denied
> cat: numa_maps: Permission denied
> cat: pagemap: Permission denied
> cat: root: Permission denied
> cat: smaps: Permission denied
> cat: cwd: Permission denied
> 
> Are all these really needed?  Is knowing a processes current working
> directory the same as executing
> 
> gdb -p PID
> 
> 
> ???

With modern kernels, SELinux makes a distinction in its permission
checks for ptrace vs /proc/pid but the DAC/capability checks do not.
For SELinux, we check :file read access for most /proc/pid files, and
only check :process ptrace on specific /proc/pid nodes (originally
only /proc/pid/mem, but I see that viro expanded it
to /proc/pid/{syscall, stack, personality} as well; not sure whether
that is justified or if it should just use PTRACE_MODE_READ there as
well).  So you'll see sys_ptrace capability denials but shouldn't
see :process ptrace denials from running ps these days.  Older kernels
would trigger :process ptrace denials from ps due to environ, but that
was switched over to PTRACE_MODE_READ and only triggers :file read now.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
