From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: cron sys_admin
Date: Fri, 13 Feb 2009 09:18:04 +1100
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <200902122121.12451.russell@coker.com.au> <1234449455.17114.5.camel@localhost.localdomain>
In-Reply-To: <1234449455.17114.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200902130918.08611.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 13 Feb 2009, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Could be this test in kernel/fork.c:
>         if (atomic_read(&p->real_cred->user->processes) >=
>                         p->signal->rlim[RLIMIT_NPROC].rlim_cur) {
>                 if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_RESOURCE)
> && p->real_cred->user != INIT_USER)
>                         goto bad_fork_free;
>         }

>From a casual inspection of the code that seems to be a vfork() called as root 
before setgid() and setuid() are called.

> Kernel version?

The Debian packaged version of 2.6.26.

Below is the ulimit output.  I restarted cron and received the same message.  
I have less than 300 processes on the machine in question, nothing near 
12283.

# ulimit -a
core file size          (blocks, -c) 0
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 0
file size               (blocks, -f) unlimited
pending signals                 (-i) 12283
max locked memory       (kbytes, -l) 32
max memory size         (kbytes, -m) unlimited
open files                      (-n) 1024
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) unlimited
max user processes              (-u) 12283
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited
# /etc/init.d/cron restart
Restarting periodic command scheduler: crond.

Thanks for the pointer to the kernel code, but I'm still stuck trying to work 
out the real cause of this.

-- 
russell@coker.com.au
http://etbe.coker.com.au/          My Main Blog
http://doc.coker.com.au/           My Documents Blog


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
