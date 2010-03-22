Subject: Re: capability:sysadmin and xend
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <201003211304.55200.russell@coker.com.au>
References: <201003211304.55200.russell@coker.com.au>
Content-Type: text/plain
Date: Mon, 22 Mar 2010 08:58:22 -0400
Message-Id: <1269262702.8986.1.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2010-03-21 at 13:04 +1100, Russell Coker wrote:
> Below is a sample of the audit.log from starting a Xen server running 
> Debian/Testing on i386.
> 
> >From linux/syscallent.h in the strace source it appears that syscall 3 is 
> sys_read.  What might xend be doing?
> 
> type=AVC msg=audit(1269119177.855:8): avc:  denied  { sys_admin } for  pid=985 
> comm="xend" capability=21  scontext=system_u:system_r:xend_t:s0 
> tcontext=system_u:system_r:xend_t:s0 tclass=capability
> type=SYSCALL msg=audit(1269119177.855:8): arch=40000003 syscall=3 success=yes 
> exit=2 a0=f a1=99714b4 a2=2 a3=2 items=0 ppid=984 pid=985 auid=4294967295 
> uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) 
> ses=4294967295 comm="xend" exe="/usr/bin/python2.5" 
> subj=system_u:system_r:xend_t:s0 key=(null)
> type=AVC msg=audit(1269119177.855:9): avc:  denied  { sys_admin } for  pid=985 
> comm="xend" capability=21  scontext=system_u:system_r:xend_t:s0 
> tcontext=system_u:system_r:xend_t:s0 tclass=capability
> type=SYSCALL msg=audit(1269119177.855:9): arch=40000003 syscall=3 success=yes 
> exit=2 a0=f a1=99714b4 a2=2 a3=2 items=0 ppid=984 pid=985 auid=4294967295 
> uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) 
> ses=4294967295 comm="xend" exe="/usr/bin/python2.5" 
> subj=system_u:system_r:xend_t:s0 key=(null)
> 
> 
> Xen works fine without enabling this access, so I'll probably put in a 
> dontaudit rule.

Enable syscall auditing to collect the pathname of the target object.
http://danwalsh.livejournal.com/34903.html

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
