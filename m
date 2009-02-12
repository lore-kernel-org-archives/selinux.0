Subject: Re: cron sys_admin
From: Stephen Smalley <sds@tycho.nsa.gov>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200902122121.12451.russell@coker.com.au>
References: <200902122121.12451.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 12 Feb 2009 09:37:35 -0500
Message-Id: <1234449455.17114.5.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2009-02-12 at 21:21 +1100, Russell Coker wrote:
> I am seeing the cron daemon request capability sys_admin.  The below seems to 
> indicate that vfork() is the relevant operation (190 seems to be vfork 
> according to ia32entry.S).
> 
> So how does vfork() require sys_admin?
> 
> type=AVC msg=audit(1234433821.879:6677): avc:  denied  { sys_admin } for  
> pid=9598 comm="cron" capability=21 
> scontext=system_u:system_r:crond_t:s0-s0:c0.c1023 
> tcontext=system_u:system_r:crond_t:s0-s0:c0.c1023 tclass=capability
> type=SYSCALL msg=audit(1234433821.879:6677): arch=40000003 syscall=190 
> success=yes exit=9600 a0=0 a1=804ca00 a2=257e a3=0 items=0 ppid=3701 pid=9598 
> auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 
> tty=(none) ses=4294967295 comm="cron" exe="/usr/sbin/cron" 
> subj=system_u:system_r:crond_t:s0-s0:c0.c1023 key=(null)

Could be this test in kernel/fork.c:
        if (atomic_read(&p->real_cred->user->processes) >=
                        p->signal->rlim[RLIMIT_NPROC].rlim_cur) {
                if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_RESOURCE) &&
                    p->real_cred->user != INIT_USER)
                        goto bad_fork_free;
        }

Kernel version?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
