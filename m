Subject: Re: debugging confined domain with gdb
From: Eric Paris <eparis@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com, cpebenito@tresys.com
In-Reply-To: <1192044685.2687.88.camel@moss-spartans.epoch.ncsc.mil>
References: <1192044493.3202.37.camel@localhost.localdomain>
	 <1192044685.2687.88.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 10 Oct 2007 15:50:26 -0400
Message-Id: <1192045826.3202.40.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-10-10 at 15:31 -0400, Stephen Smalley wrote:
> On Wed, 2007-10-10 at 15:28 -0400, Eric Paris wrote:
> > So I've hit on this, and now I've run into 2 other people who had
> > problems using the targeted policy when they attempt to use gdb to trace
> > a running process in a confined domain.
> > 
> > The example today was:
> > gdb /sbin/audispd $(pidof audispd)
> > 
> > type=SYSCALL msg=audit(1192471243.328:5985): arch=c000003e syscall=61 success=no exit=-13 a0=4bf6 a1=7fff23dfb32c 
> > a2=ffffffff80000000 a3=0 items=0 ppid=11732 pid=11792 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 
> > fsgid=0 tty=pts0 comm="gdb" exe="/usr/bin/gdb" subj=root:system_r:unconfined_t:s0-s0:c0.c1023 key=(null)
> > 
> > type=AVC msg=audit(1192471243.328:5985): avc:  denied  { signal } for  pid=11792 comm="gdb" 
> > scontext=root:system_r:auditd_t:s0 tcontext=root:system_r:unconfined_t:s0-s0:c0.c1023 tclass=process
> > 
> > Basically audispd now needs to be able to signal back to the unconfined
> > gdb process.
> > 
> > So, policy gurus, I want gdb to work out of the box.  I also don't want
> > to generically give everything in the world signal to unconfined_t
> > permissions.  What options do I have in policy, run gdb in an unconfined
> > domain and give every single other domain signal permission to it?  Is
> > there an easy way to do that without thousands upon thousands of new
> > rules?
> > 
> > I probably can do something horrible in the kernel like if my signal is
> > denied then go back and check "if A can ptrace B then B can signal A"
> > but this probably wouldn't go over well in some environments *evil grin*
> > 
> > So how do I make gdb and friends work out of the box?  Developers having
> > to turn off selinux (ok, so i just load a policy module) to debug their
> > work just isn't working and more....
> 
> Is this related to bug 232371?

looks like it yes (adds self to that bz), but this is just me and 2
other people internally getting mad that stuff doesn't work   :)

-Eric



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
